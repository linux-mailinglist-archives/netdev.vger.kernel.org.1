Return-Path: <netdev+bounces-140449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C259B6853
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B0DB218EE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF4213EEA;
	Wed, 30 Oct 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="j3DZGKV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB8213EDE
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303425; cv=none; b=Q3+O5SPngjqRQ56aZpVDoItzTyrWqQ6uk0MA23pyUpiV7hDA2QD2zeB8CmwsWfsGcAr1vyEvrQs7bDaeClrVYtWJXPavQ7pR1LTfsrmx7wNLnBQ4WJ5XTEjEqxVr5nObP1Md3cCqnyNJJvNpWPYvLH2jrYx+MsRCyUU4Cbyjekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303425; c=relaxed/simple;
	bh=jdc7WeuGxCiVpcsCtu8uscom4y5JgQN/uL/vJwzOwMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/obxtMHDAYnlcX8LCwpGFMKgr5WK95B7X0PYBebbVz/VBVKFOs5Xjbdfp/23IA0A2nhI/FRKqmmUKwt7w2+Sz+WGTRDyhHTv4Aa11LY8TQNdlL/FO6EnM/zk/LoH3AV2vP5N8y7dTH6HzFWQ4yOhl+UY+qolzmC/HiJuzO3sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=j3DZGKV4; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jdc7WeuGxCiVpcsCtu8uscom4y5JgQN/uL/vJwzOwMc=; t=1730303423; x=1731167423; 
	b=j3DZGKV4VN6tLl75CZqXSSEArYdnbM/lIFSZYXOv9jj71RTW5qjs+SpzO9HFSYASJ1TdhAkTx7s
	A4KEiREsXEuBpq37ctPMul3t+f+9JcB81utzMmOaFJYLdnuV91+H3FLDZrXNr0lRKFgaC2g2UW/BZ
	Jkpt0L1q2Rpu1nvBdmpycyOAdQhFbVnREqroGqBYe46DbwbV0fBV66t7S5jqdpbCD3Yff74n/NZdV
	53cOTSE5rb4q7pYkvbwGyxwE6PHUI4wea5ZlglmdLevCUSCke0Yl+sPTvfQzr+wPxrY1dwmJfY/Nc
	+Fv+piMwij1wFu1KbPet1zAd21vUfg1SxctA==;
Received: from mail-oo1-f51.google.com ([209.85.161.51]:52374)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6Axi-0006nM-Vp
	for netdev@vger.kernel.org; Wed, 30 Oct 2024 08:50:23 -0700
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ec6bdd9923so30530eaf.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:50:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrvzyYEvbfRZotkMbcYgLbNGOOgjZgH44L8r9UW91zRaOZPPCe
	1Co6JeFJsE9RVgwqZip+H7YzploP5AkaxRFALfg1LdMXnHhbmgz6+p/IK+8iLaeo4VH3bv21CaX
	a6Zer616uTT0c2YPygzJ8SbVpStE=
X-Google-Smtp-Source: AGHT+IExuLmc7U9uDrbdFaWTNo3I/K6alMVbEM83kNSRIKi8xV6HoEuoHtrOyTOfdom4QTUTxSFtopKajfK8NdWfxt8=
X-Received: by 2002:a05:6820:221d:b0:5eb:c6ba:7830 with SMTP id
 006d021491bc7-5ec2392647bmr11946004eaf.4.1730303422531; Wed, 30 Oct 2024
 08:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-9-ouster@cs.stanford.edu>
 <1ec74f2a-3a63-4093-bea8-64d3d196eac6@lunn.ch> <CAGXJAmwaqMs12YtHMZRN5bbqOor2gVe+cCo=JqduaoXsErCY=w@mail.gmail.com>
 <471a65c1-2ddd-4dc3-a241-fd5bdf28ce55@lunn.ch>
In-Reply-To: <471a65c1-2ddd-4dc3-a241-fd5bdf28ce55@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 30 Oct 2024 08:49:46 -0700
X-Gmail-Original-Message-ID: <CAGXJAmw0vu5dFa1YeRqGbed8gmyNtSSEQk_jZx3M4_q=_xHxkA@mail.gmail.com>
Message-ID: <CAGXJAmw0vu5dFa1YeRqGbed8gmyNtSSEQk_jZx3M4_q=_xHxkA@mail.gmail.com>
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: ff384b2b9a2989b26e23b1d864f6aba2

On Wed, Oct 30, 2024 at 6:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > BTW, I did some experiments with tracepoints to see if they could
> > replace timetraces. Unfortunately, the basic latency for a tracepoint
> > is about 100-200 ns, whereas for tt_record it's about 8-10 ns.
>
> This is good to know, and you will need it for justification if you
> decide to try to get tt_record merged.
>
> However, once you get homa merged, you will find it easier to reach
> out to the tracepoint Maintainers and talk about the issues you
> have. If working together you can make tracepoints a lot faster,
> everybody benefits.

Agreed.

-John-

