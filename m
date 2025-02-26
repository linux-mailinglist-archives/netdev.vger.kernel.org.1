Return-Path: <netdev+bounces-169821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34000A45CF4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE823A5E17
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F62214222;
	Wed, 26 Feb 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qywDHKvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10846426
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569050; cv=none; b=kJdZD1v/QnumNM6PlCXRcp+ggzd8FLzDrzMZatreICufB0ELQ0/xyAJr9ol9jTEt69AWSx3Dv9LwrIayJIyHWTkQQfmph+7P2ZFKC9fYk/0Rt2f8Ya6xn/Croo70q76Nx+YpoB/J7cdBsltAndUyVQs7NjRRoCC+HkD8c9UByWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569050; c=relaxed/simple;
	bh=lASttuAEgLFZW2YusxKEwpKzO4jj4Pmy5vSln2d2l3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFJO52RWnP6qc7FEJUh+VmsHKqzWZBI3lPw8J9D7sqpjXglDj27HHddxC8xmkiHc2TnRb9jwF88QYIwqsqmOEEQgWjD16DTfd2Nw7Q0Nyn+Zoa7zQGm5/mTk9KHqdrvrPvXYn7yvvgWnBfM4Kjr1kN2hK0nRI6e+/ksCr761wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qywDHKvW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a36eecb9dso69491411fa.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740569047; x=1741173847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lASttuAEgLFZW2YusxKEwpKzO4jj4Pmy5vSln2d2l3Q=;
        b=qywDHKvWLJxaBEdlD6YuDQlY8UnBQvZjfgt69D/C6q2VN+9nS7vORqydN9vrgCLeJV
         Udq7V84BN56J8NFAX7TYaV5edtYiVK5qmkj0MtpYx+IUPqgbmkb+HLM2ECJHPnoiVPQZ
         HECadkwHJWdg/2AJaPSwxtH8Nn/qmt/QUoh9cIXb/KNHj0RORLe5IeEBYCLnxHBJWnyl
         AxGOuVDyz+lLsWTdwwMWhfNw1/NsdCDmcQbVaxle6Ot/EEpYOX8nRSE+xcmjGNP9Qw6j
         SFx10nBMHnQTtwV0uEKHsmTNFUTY33wHWECioRp4u6ysMp/WSbHr2A+HklOMSZ6Nwie2
         w2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569047; x=1741173847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lASttuAEgLFZW2YusxKEwpKzO4jj4Pmy5vSln2d2l3Q=;
        b=t9+HfLDCzWaKpgcUFKI8O4GVMMbnzOO2y2vuuz885PDpyv7BapJEQS8EtuiGdAzZoe
         d5SOS90VhZh4PEBj3Kws/IdLwBCuYtnMDyqQhQFa25mL7Mjr23gi7uQN/imDF5i2hdhp
         hrP0hFaUVeDAAumwa3B4tmGEehyRp/Myx6UxDQ1rFDNTW2yKRzYiasWeYygXrsEnmrsd
         ryzzyikq1PCP/hc7BYYa5n01wWQ6qOu5rinOMNFzlPmyDknx/Ac9NYSX6CghhoBjPBvd
         W5lG9hs3CYajL9GLkzaw7q3pPMtFONY7P2dZCDSUfQjdGzifLE8m8GFMJtruCETjeteY
         9ICw==
X-Forwarded-Encrypted: i=1; AJvYcCV3lNLFvuApgTqR/llx0QkKHTRxqmB8oe31YOCFLc9VNof4NPFwxcFNDEXeUsdUE1b1PhITyzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjv6NRbtl/7vCVmJCjBoy91fQ9fd0xfjW/WfQPH+C9b21mxfmO
	bW6OLkf/IHtiF72Ql5h/qd4izmQum7xbCw12vCFA04frBo2GdyZWlOwTs8nAKbp5zWlzU13nu4u
	LWXRIB5W8PrRzPk5XwYitySHHxhTzCP04Bi5SJUOuTCF3R7wKxZ1hY+0=
X-Gm-Gg: ASbGncuhREHDABhLlvzDPnjyTeFC/PCLr6Sga9iHua6yFdSvIJtMk1IK70HwzDici+9
	87Ass+DjU87CqUgTB3uKrM2HRImCnN31se+xFbjiMksL/lLbs9HE0VxEwRJ/zvg+4He0VV8yVxB
	Pm/bLGkGE=
X-Google-Smtp-Source: AGHT+IFTKVhRSUodhWdYn6Lz+OLJTryNTQf9Xe+MKAyhGrjFrqVgD74ezr+4y5RFfnMOBOEDVsiGwwtPXmCM4wrHtSM=
X-Received: by 2002:a05:6402:234f:b0:5e0:9390:f0dd with SMTP id
 4fb4d7f45d1cf-5e0b722e566mr21921409a12.22.1740569035603; Wed, 26 Feb 2025
 03:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-10-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:23:44 +0100
X-Gm-Features: AQ5f1Jq8ZIYsMRK3LZUldEB6laKtqyNlzPf0SrqJJJ27frJxHBNJDmk7OyVGpsg
Message-ID: <CANn89iKgmKFs9D32bH4jhrgUu1oDMTyz8gKXcJd-a=fpB_rhHA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/12] ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ip_fib_net_exit() requires RTNL and is called from fib_net_init()
> and fib_net_exit_batch().
>
> Let's hold rtnl_net_lock() before ip_fib_net_exit().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

