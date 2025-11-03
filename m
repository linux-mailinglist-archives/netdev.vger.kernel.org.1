Return-Path: <netdev+bounces-235286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF1EC2E75B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28074E5169
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09447301473;
	Mon,  3 Nov 2025 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY2CwaGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFE3002DD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213467; cv=none; b=l+vzJwrQQOgLEKkOdIkoH/PyRFJ6VKntrk9D+atpUyG+aDfLy2dLupdSu9YhEwiw8kuXPbn1sB0FfX3h7Gx5CD0cljZAri+dFbBLwDFyjSv5IVfFZpRLfJx22D7yb7enqDqZoV2D21egE6uahdYyom/sicE+u6SEIo4jEzdDF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213467; c=relaxed/simple;
	bh=Y6n9uQysouYMPCUaMOJBUSqSTFggZuvD2vskFKtZeJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey5t+/01rSdQ9MtSNuqjEi1Cnx3odJTskDHbXj+lE2G7cHPepvwEAWQCNyMaZtfrzyuzTxaqozbaVPbDfEoXN3sjwtJMCtsTrIQsIiADopqtRGnl0sC3tps8CYlU6THZDqIaTV7pCO/L4jmcJa0Bck4byXG0n7/ThgU5VFwIxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY2CwaGa; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4330e3080bfso16076005ab.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762213465; x=1762818265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6n9uQysouYMPCUaMOJBUSqSTFggZuvD2vskFKtZeJg=;
        b=JY2CwaGa142DhxgfBJXxiyYPof7YfVLRPcMhBRcU/HCt8X7lo+psiS8OsO1vLKmpCW
         tsdIo8vDmh0evudvdo5gpV/BC9kZdr72P+7jaFXvGO88KKV9nJUUmBBz2kluIsFskWR/
         Rxag83WRdozh1A0zZyu83hpJ/nWz5xXdP0iVnwJ8xOYgAJThxMweooIy9phPg40Yn5M2
         vBoXULyyngGWaN/PHVoKAvO7FhR/FckJy3upmaESCkwyBL7+fkzdR8NLFoSZ9Rj427Qi
         omhx6/fqG8JqJo8sb5zfm/gQbRkuz2+7rHmkxYC2NG5nwC0ljy44JDV8D/rsB+BE914S
         fNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762213465; x=1762818265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6n9uQysouYMPCUaMOJBUSqSTFggZuvD2vskFKtZeJg=;
        b=b+joB7TTyfJmL/2aWyynpX3s/aDD6zhliXcTMMy483e6UBsnVlxL0o5zG4D9JJOTxU
         04SjArQq2QO0HuzH1cD43qHcgsHu4Qoj6r3/jeyuFMZn2jGrikig1lNgCB3iNQg6OwRY
         TZK50a2ugSIRecLX2PnbOhbmFuhm4FKwMCYyze1U81lZD8Tnon2Lk6Bcz6TU0sCRy3hO
         kK7WxG8Tr7wDAEUYswTvJXcomlduxh6TQRUsuirlZe7pGpMu5+V4Mn+ov+QpB8mCuMBY
         UrAo9SrwuqGjLk4LC/W3AMUQ9RP91XeDXuS9KYu51IVDMJaogW1jmWyr5A+TVareWyXm
         6QlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFZeEqn2/mwKnCuxrELKYMRptup9yyzKvmD1NC8u6mQICoyGeeRWge0WFDMv+sFdYUQz56tJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUX09u8+d6wWu8tsrH2KGv/xFNec9/EEDErRNakS8ifEGtg4G
	qrVuotscGsoQYdRyKJS6+/N9Q4tUWM9I0uZRuIulDliK9HWhl/wocVWrg1skmLIxiWtKLc5jpO0
	eiOPIk+Jgffn5JmO61OLwhdref6sCVhY=
X-Gm-Gg: ASbGnct62PmwL28JbV61qM3++Eupe/vTI5lnALgcxDgz4QWLQo+7KC+dzXeqk8RC3+O
	+tbsdnU3Ld6jkGIKAAIO+n75sigfcokOhfvJYkgYGEnArY5acA50/gSVeYOSxhGht/BtNqYMgbe
	HgkvrvCHE1qNqtEVqfDUVs0Bl/Pgi/ETsYHlRPzikY8MnPeD/670Bx3ZWCNPAiFHcWKsUqLv9op
	w5x+MBi3YheJ9M/EtL18w+HdwEisPq9xBBWqXBQoq76ihu9XhZXOqi76tcff7S5n7IK6aSXqqs=
X-Google-Smtp-Source: AGHT+IFNhRs34JdCoFIUNGAK5kaza3jhQFgDrCvZKnXBXB1PKB6pOBzqwopRPsJ72AB1jyGZrF/UDMbdNLxVmWlkcM8=
X-Received: by 2002:a05:6e02:2302:b0:433:3583:d6e with SMTP id
 e9e14a558f8ab-43335830ef2mr34098115ab.27.1762213465483; Mon, 03 Nov 2025
 15:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103165256.1712169-1-edumazet@google.com>
In-Reply-To: <20251103165256.1712169-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Nov 2025 07:43:48 +0800
X-Gm-Features: AWmQ_blTiss_K2n9gVzeiaYHnCz30aRV59IJkT45Zl6cz_ly-uFCXiRmvHV9yIk
Message-ID: <CAL+tcoA0=DWr-eQbL39xwVjKb4ZiBtMXBFTB2QPVoDQAzy0AEQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mark deliver_skb() as unlikely and not inlined
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Nov 4, 2025 at 12:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> deliver_skb() should not be inlined as is it not called
> in the fast path.

IIUC, it can be the fast path only when an af_packet socket attached to
ptype_all is used because it controls the filters in the rx/tx
directions? It even could be much hotter than __dev_queue_xmit() when
multiple af_packet sockets are created?

Thanks,
Jason

