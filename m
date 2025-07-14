Return-Path: <netdev+bounces-206791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1EDB045B7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C317B07A8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB752620D5;
	Mon, 14 Jul 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqnAw7ON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF95260588
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511345; cv=none; b=gQN3YR4vm3YU5xvzA12hhJ4xiKrXiFliSWBUNGsFJzinb9j0LH1Pi3vXxqsWc5ybOF2yjK84mNMI9cbNq6aSdHz5hIW2i/96dXx39CIzchV0OXkRzgmAm4fRGfI0PIvnkE933CSoJHm3/oZKCNJwb+73t0zMOyRKaEUIUUttCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511345; c=relaxed/simple;
	bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge81kIIq+IsfkuGrLMrX/BalwYu1gfKAoSJoNISJPaFftvMIo2lAvWGPKvs43qPh0fm9U6TpKWX4PUdNI7HYKA7L8V+fErPKtX87Ok2UNc7bPSoBx2DSMjv2MoU+2uyLTp9hAykS7pmbDTFC4YTylK3hzseEJHoDLL9RyssPMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqnAw7ON; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so3596600a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511343; x=1753116143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
        b=RqnAw7ON8BvQm9W4FOcyb2dvCXYsYTpGkdtsE9tcr+95kQtefvTCjuw7Z43mfmZDtU
         2xK98hj1Xtby1Y8FkR/8mPse/D5JTzYKxBb+/rA+ZPB1HAs4rJdyU30LrM3QwAM4oqWV
         x5GjLG2ZaiGk4eTiDpA6PbbOSfsdnN+RXgWD7jRiGATC5OjvOa/mYp9CPItQskh278cz
         OmVgaAuWEEHfcJ26Oun0fsZoSCUCE8YEnj6foj8E+U9VMaqZgAvu7B4p3C0Vv3D+WAZK
         QsK7USkPzba1cXzqB/yKzhOJrab6hSJzevpCOQmWGCwOgQmrwku8PBChH6rdTbXCAh+i
         vC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511343; x=1753116143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBiOWgTbH6mBxN5Ueovjxh8H9DeHQsuCNdyto7bQGqs=;
        b=Ya0BW0YdRaGWdZZo/GCEtSTo6cTvc5uS/zwa1UcSo6ZuFjhCL0G7zX9izdTmLmliDc
         1L/Y/oGwOrMcvPdiRS4aqt8FiSQB/3mYGmJKR5tIg7rv1HoW9O0gR5Z+KDmQ/twoEQ1i
         Zm8/aLX/6XMzFcJ7Oyt3eVZAj4iZRinxtqJbRGQHfrtcXVimxycSAL8vCay9uwqJEjVz
         l+JjswvqfT6P6kr5gevzKFtx8t+KjsCn2N2g7JZkW/blcV/1iLADOFQBsszdodMH0OpJ
         aggBi6m/VYSAS4kCNR6Oac0mq3RQHHqlXrFfha34GwjD9f4qFxL32CuCsnE+WHgYtoP/
         PaNA==
X-Forwarded-Encrypted: i=1; AJvYcCWcBXH82zW3lf3y656rnTQvwsmFVY6h1x0fDOrPpeF7kzbPxrO0Tu3ZXp89rEawjMy2cC228b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIuMEAc8jeK2su2B9KPlIk1wrRLkcsKwBIAr8E4BkE5GcNanZ
	1Gc+R4niSPtfAt/A1O2szje1TU1ljdOhN5OLPF7+WgL3ddb3xkLlqoka4yBoJovNPXVbNx7JU3B
	4pL5o4HuOUPPysexiSY33f/tTThHHfB8gXHCtZBNQ
X-Gm-Gg: ASbGncs62ZOwIu9nRi2p8cINx8nVi/G09UfFLh4lW/EedVCQ2mk5DcVxWgx6LvzTmdi
	xjHzElAK4oCsC4jVpgot9NMiIiy2VRytQjOIIB/YshP830fPcvsduPAUnYAKKwsyqkewhb/VltJ
	364Xg487z8ObE7ORAVx7TVNcvJu+YX8biBleMBPXr0jXmwNdss4PqfOoKwPQWT4nYSKb5qqxOmt
	DbHq+rRShe4VRb3CkqLN60rzsuxP85BxyR1iA==
X-Google-Smtp-Source: AGHT+IHetMliiiiDydhmaCxsBQrgccYD+etGrXdLocRuZAremfRO01jz/DZULhdQUdpZs9OByqjF6ydOGiy58cu/VYs=
X-Received: by 2002:a17:90b:3b90:b0:311:b0ec:1360 with SMTP id
 98e67ed59e1d1-31c4ccf4bc1mr19820630a91.29.1752511342873; Mon, 14 Jul 2025
 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714081949.3109947-1-yuehaibing@huawei.com>
In-Reply-To: <20250714081949.3109947-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:42:11 -0700
X-Gm-Features: Ac12FXy6QarP7_7bnDBMPeBZuzZfs7pD0MO4S9tO1DtMXZCd9Z_2kaicajsPMoc
Message-ID: <CAAVpQUAPbj6=HoGtpJhO4SEnzBXis38DWpFOtz55iHpuYV4Tgw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Avoid a duplicate pointer check
 in mld_del_delrec()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:00=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Avoid duplicate non-null pointer check for pmc in mld_del_delrec().
> No functional changes.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

