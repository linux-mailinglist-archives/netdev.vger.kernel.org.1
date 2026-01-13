Return-Path: <netdev+bounces-249370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C2D17605
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC33030057DA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2E30F7F2;
	Tue, 13 Jan 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wgy3+WMb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901331AAA2
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294092; cv=none; b=TO5pl5GcE7OVO3DMX+/1tTvMSCtFhPUvKRH5I/ZSbisDLXhv2W8f+191UD8+I2SDvVZJedg1iuIAEYlDC6odq6/cvGRZD5NFT23kZ8JEvvOzovqvr1URFQD53qSkmRvsl8SQEQvoVvAeRzhWc+AerXIg1qrqR2fS60wuk217jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294092; c=relaxed/simple;
	bh=xWTcOvUelEh2wlIx8ZWkSVkfKJ811YZn2XrcMxVzqTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0l1A6P0IjUGrQ3Qe7B/lLvM42VWt820Wrc/wo1dJu/Lx4GyhRMiL3Sx5xBa6x5N6eZvR+HY2CB+mw3kngAsaLArY4EI+FsxmeOAVdRbP/+qqResIqBE4ayVnMm+b8d5DgP1D1zuJNRB+KAytBmORLwootE+t2sXwRY4XnzuelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wgy3+WMb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f4cd02f915so54156581cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 00:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768294090; x=1768898890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWTcOvUelEh2wlIx8ZWkSVkfKJ811YZn2XrcMxVzqTM=;
        b=Wgy3+WMbgBIOUslbscAXfV8Az3DSsmhiYZ1OXF4VxsJLgxF7Xa6TCeXkC8/Cwu/eTA
         sBTDJnXBuoP1hDFi8ubyI83HU8Ljqnmk3mqh+/0f+cYYaDaI3HVTPivt8Gkkn2y3dYN0
         NHdu0NU/9FUtn/t56sfVKSCTL5sy3FkBvExkCYery4NWMy0R7sB991912G0EUdtHqtrQ
         XjdExYInEnt4+VyfvrPcbmyQI145T9VOFM7cO8LKmEQjstGR6GVDWH/VQ07xZIa1YQR7
         V5HpG3IYJVthEvAlaJpPLeh1J36VB25Ny5HVpu3QxaoCwxnS8hYA4MQRVT4xwatjxDDs
         3Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294090; x=1768898890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWTcOvUelEh2wlIx8ZWkSVkfKJ811YZn2XrcMxVzqTM=;
        b=Z2aUZIe1nrPGEogesbA5Zx6LP4pQGBTmcp1syYW4QiQbFzi5P53dex2Ed8K6PPZCID
         dJQbi8ZQklYGDfVg9NOTFXj4hbB52WKsx4Mdn50YFCnt6HwB7uOpPWtxXs0PG+YYI6YW
         OevVyhG+aSh5OZROumRCJOAGF7mEr3QMdDci9kFEDWiP/mmkMZg0CG2ntO5AsKIDoC+d
         563dLVHLKoVipftF9ZikcfTunewlUZFTfiicm5Nb15v6AcdT1zvXYkacRvl3nhjU7CGJ
         XF9zB+sZ8DqLBLZsfMKkpnJM2pbsrNAICjnbUYpiXHiDwu2XD2JzLo/YBmOZsrCJkat+
         609g==
X-Forwarded-Encrypted: i=1; AJvYcCXUYNuNTp2Bk5+nhO9aFOfqEDT2TztW2iVUg7IkPA7GI8vmITpj1XH0mdoT8qUZ5T902qsvoKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7iRN1UA1QZiU5Yc14cHz+/JDPHeuRrYxclrIn8c9bpWVZ0vn
	glEIOAaoVGG68CQK5uLtXVoP8folVkyAI8nDX67PwCGanOY6hqne9c8PZP6kdZpiTx/S9UrEkjZ
	BBtUMO05hMdVNg5CiwHKKUiJpV7lNZsfV6lVqeOFU
X-Gm-Gg: AY/fxX7sQaC+bYyNTlCZJQux30DtlNWP3x1obP4a5jwgOwxNmuVpHyw7V42cLXkpXCB
	IxcxLDolzcNsUI1wEr1NTJQJv9g94vX0pMO8LvCaNoyCQtlea47MgnD/vQ/oLPwxru+zP8LEWeh
	ww2/pAMQMXibOwTu+x/Cq215Tmbw9I1EKFom9Y//iRnNybf+4emueOTIIDb2XP0NsNYZAGXbZDX
	dpdkWkGt/qWWETdnux782o8xCQ+LNas5DGSH25nVSHEyKX7HWD6ZDR+o1sqidPAWapM9Q==
X-Google-Smtp-Source: AGHT+IHBodmwyOFJurQ+j86jkZWF22e+f2Ai5mnijzTMsW3bOwQs1AkFCDX6tugUSnrzGTTtmz+7TDBQ6mU6EsXWLCA=
X-Received: by 2002:a05:622a:4d4a:b0:501:1466:8419 with SMTP id
 d75a77b69052e-50114668b8bmr167085251cf.29.1768294089448; Tue, 13 Jan 2026
 00:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113010538.2019411-1-kuniyu@google.com>
In-Reply-To: <20260113010538.2019411-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Jan 2026 09:47:58 +0100
X-Gm-Features: AZwV_Qh0aRTx8atoL3Kjk1QVPCZHcQQAehrMlSFyDcJgAL1qYXnllqVjo5qBqyM
Message-ID: <CANn89iKb1gasQifwoiebUOWgEL-dY=_iHR-EMprmpw5E5NJ=zg@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipv6: Fix use-after-free in inet6_addr_del().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported use-after-free of inet6_ifaddr in
> inet6_addr_del(). [0]
>
> The cited commit accidentally moved ipv6_del_addr() for
> mngtmpaddr before reading its ifp->flags for temporary
> addresses in inet6_addr_del().
>
> Let's move ipv6_del_addr() down to fix the UAF.
>

> Fixes: 00b5b7aab9e42 ("net/ipv6: delete temporary address if mngtmpaddr i=
s removed or unmanaged")
> Reported-by: syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/696598e9.050a0220.3be5c5.0009.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

