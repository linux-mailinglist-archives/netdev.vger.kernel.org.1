Return-Path: <netdev+bounces-200297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D20AE4738
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93B2173BDF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CF262D27;
	Mon, 23 Jun 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhgLHdkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519E262FC1
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689453; cv=none; b=aLrH/f8zAGqmDohEkKrCUtMfyEGTfbSO+Whp1xriJFlTF3KfnQQkvV3cCiEPSD6SGD2RoJ6tYDZ2Zd4l8yCF7UfM8wjbms9uleeb4NAYwAgo6sN1BBGzDviMZnR8AjVsDyeJmYT1bMhkBBxrANDBrqa0CQY6MuZD8kPEtCckvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689453; c=relaxed/simple;
	bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dosaO7fNdZ8qcvfzTrg9T4GSo/XbjQrwc9zGoO6DaZTSkcRWirmcvj61fA1eHUfUF/k48tVUlPemjdP7Ue6nUHIw9uqbd8UzNWBT5cbfraiQZpxxdQ7J/lOL7eZLY2sdf7tS1bH0A0pIdwE8IlwRIIUJQqzpG3ITX0GFbYC2QTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhgLHdkQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58c2430edso46610031cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750689451; x=1751294251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=KhgLHdkQ12YOMk5t2QbBYMUrg0K8zvWpoctNAs5thUVaGg8pgsUnupoAxL57PWeZaT
         NIcfduZWRLblmprO9Nx4w3no1Ug/2VnYioNDXc97wTVOG1CqBV8nXNmGwLTPne9+10wE
         O5KhsWouiPnGSPnruJrMXdxTFK2Wkcm8+p2BkQ8jUm5BjRQRtEGpdBdH4mkgHSTd4Ras
         iNvf0g5or7/ti8FPmLz66FNgZEK1JChMBq65IX9YI5N44D80iIp02gpnztPz5FbhUIHQ
         6G13JCgSK85umLnNnfAJul/FZvByGMT/jsAHB/QwSajXZSQb43hYPLPa3gBtm8SSypoi
         Lgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689451; x=1751294251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=ju6Alxg0cYjvnBsdqS6QfUS6T2sEcVPxEVtq1OoBEiVv/ZtdJ1kiQvB+tdoyWBNaAl
         QElxYA4LauKBqEJSmxmC6yGsPGDMDBEHPacKgVAesSZyTMDAomiJqYDSAQSGFLWQqJuP
         STNDz7FWk7zATUOTqYQ3PHzqdUvejHt9DwOG7vb9l/JkOK7KWoVJSdZ3YbdYwjk/3JhU
         BEuwj3OsU8mP8yCx0KXHWCrCcDi7SIXsp+V5sN7oYWqQgqBtj/+AXWr/T9sTieRi8+qy
         vjgZMvDd9FguGpyo4VaeIeufPrwBZJRtGWFcbEh8p+9bEKnoi7XfRWUXtRYYPHuckK3z
         Qfuw==
X-Forwarded-Encrypted: i=1; AJvYcCXt6RSIqmMNI8xk7cQVqohsCRHYJISgqEgMGFxrOiYepcxatA4VLJl8mr0KJnMNb5niaFsQZ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWb7s5DDVJEjnK7OsmjEkREC3zKBofe9yTxr8diL4nNjoqYtRy
	YAOgdwcIiTb+it5ZOADaLs8QV+aHzPv6eyAWbaHBlYKt7lWE/xWtfPDA0YA730r3iF4lIHGuBjq
	tWQx9X3fv9qQJO2kFnhet6jVQX7/eMFytE4+LJwqH
X-Gm-Gg: ASbGncuCK5zAVY5u+wuxw6zB8YYxtlnvRv+iX22F3cnQDLXBAOdRQQU32kqkOcjuJoU
	Di9HpkgZiwcfNW6VfFc4sdfDj6X/0XNevEqkULKTCY/pLK5cDEGG0JDL3Crey3W7hZPiJtDFOIZ
	Lw4G/u3pRRpp1QRRcFf3fnFWc0z36Da9OQQpKALDRCMKE=
X-Google-Smtp-Source: AGHT+IErEx0kDAOqp1ojFcDM9yYCZh+mVleoBFl1AEdwsO+17A/oIA84nB9tL4FUjJhJfRwxa3+3/8JyJJH7G1AK0u0=
X-Received: by 2002:a05:622a:750a:b0:4a7:7c8e:1d5 with SMTP id
 d75a77b69052e-4a77c8e083amr154660831cf.17.1750689450031; Mon, 23 Jun 2025
 07:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:37:19 -0700
X-Gm-Features: AX0GCFuRrhX0LBiCnxAPHQ5MTAVLkaa48kUt8r7GSQvKFHWuAgGT6_YRkQKc9Ek
Message-ID: <CANn89iKXWH8VLY5W+iM4d7MGYL2dMRep2xG-AGGV7BcbJyMY4g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] tcp: reorganize tcp_sock_write_txrx
 group for variables later
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
> group for 'noneagle'/'rate_app_limited' to fill in the existing hole
> in later patches. Therefore, the group size of tcp_sock_write_txrx is
> reduced from 92 + 4 to 91 + 4. In addition, the group size of
> tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
> Below are the trimmed pahole outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>

