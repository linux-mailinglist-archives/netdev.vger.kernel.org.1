Return-Path: <netdev+bounces-239535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76614C6980A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CBD53495ED
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F32580EE;
	Tue, 18 Nov 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm6ph70A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9E257AEC
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470695; cv=none; b=ARwqysrYMlUtX/cBGSgYnDXk8Gcb2hIJAi13jIyDQUUwgenJ1j+PaiiSVhFkHYYUtAbXi17k2rsCn7qOt4uE6PIu2WEGhXdOUCFc7ic4Mk6xI1BbLFdByVBEj4wGuMAnADPt4gzSn87HZkwicr/mH9CLmMoV9H7HwR+n43MsAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470695; c=relaxed/simple;
	bh=WSYY1GCy65Dn9yCQkFLxBnLEHOuwaMSGnWKnMHR8fD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0pyRYuj+EcqIrtv4xSne4nQHwGDPfsCgPV2DOTEg1o/F807nxIyGRl1tCfQRRvUq5HC6XG2S1LmhezTdUDmkRlTiAcjlu2s6/zj4hwryOLAQ3Z+0hYdW9lHxsKYJBeHs4mk5tUXhyaz7I4qBpL0kjHt6Oa5H8z9dERZsaB6AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm6ph70A; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-641e4744e59so4155136d50.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763470692; x=1764075492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSYY1GCy65Dn9yCQkFLxBnLEHOuwaMSGnWKnMHR8fD8=;
        b=lm6ph70APVTlPzk6Ia0wqBjN1FNHr1HKL7Ug5iTmzl5UobRTQTVNCjivaNIz+0OarZ
         CUTFJoHLXy32dkL3XSh0Q+sNJajcT0wN7M0BaI4f58uGW/DGuMZgZ0QenfwkbzTQCaFk
         eFmKiOSEPlBmGUMt0TLYCBt0yv7Psl1Xh82hU0y/YQRUNaKNxUG0erlkISNNmNNISusW
         uxl/2ZOzrIfgtK+xBfH0T4hUY+g+e8u9j/HORdDRdzO4jjgXHPn+uvkkE7iwmO7Rrn/m
         vYE2FyCIEmR8m8yJ48bX/hQHQJFTw+D/IJYg5ta2tY0YJVUnfjMTK/zW3xKfsZ/XRhgy
         7PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470692; x=1764075492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSYY1GCy65Dn9yCQkFLxBnLEHOuwaMSGnWKnMHR8fD8=;
        b=gM7W9oqndy5xnQw+qo/sifpuI5jqd71fJmP6dzamXPerdRlogrif5YOHP7iP+Le0SQ
         T8Bcj0FLnG8M6a3xgWNtXuqHwrE5CRWAtAGaEinBuZJNbOJr5ZAAC5NDQOZUIbMl6b5g
         MS08ZOFhMoBdlfsyQ0ZD0BF/LP8sG5PjbuXMG1hrx4cVMsTs2VWO2wWf9CnR90scP59k
         vIYYMQDZZHZ9V8WZ66mOO4WVSa4T0QoW4Mkm33bflfyv9WtyEzeqXk0nB+bR9qkp83kC
         UpiuK7bsHYoFo07yVjNKgvCuBXCB3aSSbCCfE30rVZbAxK3yyr+MEngH9b2LPi+lZyfr
         GhFw==
X-Gm-Message-State: AOJu0YywioTfU+qLfPQTQJlllBv7mSyKhj2BRmHcIwSeGxN4ELMsmDBp
	AdCiOBa9/40fu4psMoSQVnFg27ShXmC+HEhNfSQRg7h5lztKgU09NUN4yKT/v+IzVZ0VSi7P6bk
	uzU4UqFZmDm3Loj4R9+aggHAzskJCp7M=
X-Gm-Gg: ASbGnctjENV9Ega8SXwcK2eVwYQBLcqoPnUE0sWOwfAMKezYvqGIzoziqsTz27H/Cwn
	R7//TgkI48/vEdH62gM6QocEdEaQ/gC9PhbxZLnOPxMMr2YyFosx8GTsmS4LgzQ00QRTEuWGgnG
	anYRgcpFMNofjr2LIE9jPW5XgOpHetzTpTL3/iVl7EJKafrJA0pm9uan69ULbIjBzsde0hW9FTV
	c7PrnFy0elg8X+dUxANLoLVAS/8RAPeMU5XT4D7NfydMrluBybCHBvhahwSFpPWrRbIV7reelVI
	0x+GbZ4=
X-Google-Smtp-Source: AGHT+IH/bZDBsrXsXAUAApwF6gssHfnH7eugf+ppBCQvvbWbg+nM//chdWve7ti2vCZ7FoMXtZajUu4P37i484lEKww=
X-Received: by 2002:a53:d057:0:10b0:63e:2d17:6a67 with SMTP id
 956f58d0204a3-641e75bbe5cmr12100922d50.28.1763470692533; Tue, 18 Nov 2025
 04:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADEc0q5uRhf164cur2SL3YG+fqzbiderZrSqnH2nY0CkhGHKTw@mail.gmail.com>
 <20251117164201.4eab5834@kernel.org>
In-Reply-To: <20251117164201.4eab5834@kernel.org>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Tue, 18 Nov 2025 20:57:59 +0800
X-Gm-Features: AWmQ_blepoLafxReiBIAa1hzJwPYnKoCLHh1NmMbo8JO-oq4DtUKvsAdjp4y_iQ
Message-ID: <CADEc0q6iLdpwYsyGAwH4qzST8G7asjdqgR6+ymXMy1k0wRwhNQ@mail.gmail.com>
Subject: Re: [PATCH] net: atlantic: fix fragment overflow handling in RX path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have used git send-email to send my code.

As for the patch --The aquantia/atlantic driver supports a maximum of
AQ_CFG_SKB_FRAGS_MAX (32U) fragments, while the kernel limits the
maximum number of fragments to MAX_SKB_FRAGS (17).

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=BA=8C 08:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 17 Nov 2025 19:38:54 +0800 Jiefeng wrote:
> > From f78a25e62b4a0155beee0449536ba419feeddb75 Mon Sep 17 00:00:00 2001
> > From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
> > Date: Mon, 17 Nov 2025 16:17:37 +0800
> > Subject: [PATCH] net: atlantic: fix fragment overflow handling in RX pa=
th
> >
> > The atlantic driver can receive packets with more than MAX_SKB_FRAGS (1=
7)
> > fragments when handling large multi-descriptor packets. This causes an
> > out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic=
.
> >
> > The issue occurs because the driver doesn't check the total number of
> > fragments before calling skb_add_rx_frag(). When a packet requires more
> > than MAX_SKB_FRAGS fragments, the fragment index exceeds the array boun=
ds.
> >
> > Add a check in __aq_ring_rx_clean() to ensure the total number of fragm=
ents
> > (including the initial header fragment and subsequent descriptor fragme=
nts)
> > does not exceed MAX_SKB_FRAGS. If it does, drop the packet gracefully
> > and increment the error counter.
>
> This submissions is not formatted correctly. Use git or b4 to send your
> code. Please also make sure you read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> As for the patch -- what's the frag size the driver uses? If it's
> larger than max_mtu / 16 the overflow is impossible.

