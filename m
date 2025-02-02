Return-Path: <netdev+bounces-161983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A386A24F0F
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DD23A2304
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4D1C5F37;
	Sun,  2 Feb 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2D55ZTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B62557C
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738515649; cv=none; b=beEtZOPojg02LaR3I78g3jio8tkt/cf7w0bUqFqkmZ/OFlcrAbWs7AMZgTZSESUAvffZa7q+15i8/sAYU5boPy3Hb6JsNJBM39wcACeZXCWZkeeGTxm/Tr9MOhwkQUD5s3hzpeP/HK3p2qrBFI9gCh17rqqmG74Xd1LqrZFt21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738515649; c=relaxed/simple;
	bh=8SCf22IMjz6HTq6q4WA3gCdMyh5qsfp0uRd+uI+J4yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfUok0+22fiavYoxQGh18A/7IXl+6XRqq3Z5GuhzouMODlUDwikDRYYs/0n+4puoa7d2JFV3gzqg0ZNQlDc778C4b8foN8rXfUKxbP0RKAN9XbnFW7MNDS7eD+HKAPfGZPo9Y4eudWjba0xE/VvXa3oHCiYTvaYmmPutqGS06RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2D55ZTe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d89a727a19so45610676d6.0
        for <netdev@vger.kernel.org>; Sun, 02 Feb 2025 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738515646; x=1739120446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8SCf22IMjz6HTq6q4WA3gCdMyh5qsfp0uRd+uI+J4yo=;
        b=Y2D55ZTe7cxNbG2V9tSSfz1nrnEOtN8BEv/gh+IZkzAhD4lBEsCpS1eprWtx+QweMN
         ZDS9gpcJEW4tv+62pH8Tvgg8rPyPb7YkzGmwEHqUozDICO8gS2SCDZ/tnGjEjyPnDQBc
         Z9GR+ZbTr2Ibwkf5bORznVn8A+QOX0dRx21+UeyZwa9h86TpszmPOYj6ETfVdSqIMxrs
         BieueGT6DyekEovKRmT514rdkXnFH7PuvGRFQ1Y/EQbQQ/8ehhZDKVw0rWpsAQuc+VZR
         tlibBootv/7SsYHsrd55YdmehlqW2A2DohJaI4jDrjeYimJJvfTEjamCk2NqLpkJ5n4w
         sOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738515646; x=1739120446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SCf22IMjz6HTq6q4WA3gCdMyh5qsfp0uRd+uI+J4yo=;
        b=ISNSi6OxoLh57rbOl+mPOtVRO7vHof63nrYM8+96MAQatq0eM/nZWszW0CXni28b+C
         HJ3CJBRYAwLcRkhrUAj3++K0+TZEiJCnjtE7qQmuEHc+yYDT/K2frEXnYGVBrSdRXbeB
         Y/DYo6e+9O0Dr4BvhsoATlUnKBuIszkANtBEym50c52MrrUas4GT8hqDXoIepA/WeDXn
         tk3lsfpTKBzW4s1JZKiLVDiqPidmpIdAm61diQmXa+LwdFaS3HyEt0/obdhxIMGskEUU
         Vi3IkKCyyD0+IzQjMCixBnJfrlfxINkn/CUWUcn2LRhIXipv9IITVbDV65oZRyTaynk7
         2krQ==
X-Forwarded-Encrypted: i=1; AJvYcCW50hjHAWKOUgppJY+VDfO/4lkqQgWjfu/RJBrn1hAApyNaOrfaDgppzlcJXZLqs6w0R2ImNKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HXY2/FOpT2LO0pbTk/HJeqwYRC+besnOdFVcxgr8DPP3rDFl
	CworgYobr7TsTaxdQTyRiHZlOuonoXcFvu9Q/CcvmC0+BBqiPUMjbV87W0ZpIdZi93E9sgRBpPu
	z2ZxfZJCRVwcVKyj6DeKwKRPsl1E=
X-Gm-Gg: ASbGncsCsp83hNcAhvWgY6fdROMnyOdeLk34ZID3oq9Kd435OpR+f31bmcFWqy0iSoX
	u0QnKShS85vpMicSYNb6QwqVD0sq8BwLkO6OGf1wwTPhbyXgcQTQQX4pSscCO6m66mk06K9Q=
X-Google-Smtp-Source: AGHT+IH+xuF+ZaA0tG1AttiwMr+ExCanBY7m7lm9L+metf0DIS2rVt5+9gfK9CNDEaElLiI7CfsGc6ICuaCjAaMWdeo=
X-Received: by 2002:a05:6214:19c4:b0:6e2:49eb:fb7 with SMTP id
 6a1803df08f44-6e25b036318mr130195346d6.3.1738515646435; Sun, 02 Feb 2025
 09:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z54XRR9DE7MIc0Sk@lore-desk> <20250201155009.GA211663@kernel.org>
 <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com> <634c90a1-e671-42ae-9751-fee3a599af20@lunn.ch>
In-Reply-To: <634c90a1-e671-42ae-9751-fee3a599af20@lunn.ch>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Sun, 2 Feb 2025 18:00:34 +0100
X-Gm-Features: AWEUYZlvrUQ2Nm244hTy7bRxl50tQYNgolIkA71p9l2A4I4zpm7CGGn3qrSN4sk
Message-ID: <CA+_ehUyzgAb9n+gWhoWYPLkuQD3tvro0Zkj0VvvQ3D+7-MciDA@mail.gmail.com>
Subject: Re: Move airoha in a dedicated folder
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, sean.wang@mediatek.com, 
	upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

Il giorno dom 2 feb 2025 alle ore 17:49 Andrew Lunn <andrew@lunn.ch> ha scritto:
>
> > Hi,
> > may I push for a dedicated Airoha directory? (/net/ethernet/airoha ?)
> >
> > With new SoC it seems Airoha is progressively detaching from Mediatek.
>
> The vendor name is actually not very relevant. Linux has a much longer
> life than most vendors. Assets get bought and sold, but they keep the
> same name in Linux simply to make Maintenance simpler. FEC has not
> been part of Freescale for a long time. Microsemi and micrel are part
> of microchip, but we still call them microsemi and micrel, because who
> knows, microchip might soon be eaten by somebody bigger, or broken up?
>

Yep, with detaching I mean more with the fact that it seems they are
stopping reusing Mediatek as a base for new HW.
Aka code sharing and registers are getting very different or no
similarities at all.

> > Putting stuff in ethernet/mediatek/airoha would imply starting to
> > use format like #include "../stuff.h" and maybe we would start to
> > import stuff from mediatek that should not be used by airoha.
>
> obj-$(CONFIG_NET_AIROHA) += airoha_eth.o
>
> #include <linux/etherdevice.h>
> #include <linux/iopoll.h>
> #include <linux/kernel.h>
> #include <linux/netdevice.h>
> #include <linux/of.h>
> #include <linux/of_net.h>
> #include <linux/platform_device.h>
> #include <linux/reset.h>
> #include <linux/tcp.h>
> #include <linux/u64_stats_sync.h>
> #include <net/dsa.h>
> #include <net/page_pool/helpers.h>
> #include <net/pkt_cls.h>
> #include <uapi/linux/ppp_defs.h>
>
> I don't see anything being shared. Maybe that is just because those
> features are not implemented yet? But if there is sharing, we do want
> code to be shared, rather than copy/paste bugs and code between
> drivers.

Yes this is really to understand how to move for the next drivers submission.
It's mainly about PPE and firmware loading. Airoha_eth got quite big already
and the code got split in multiple drivers. Also the header is planned to
be split in a dedicated airoha_regs header.

>
> Maybe drivers/net/ethernet/wangxun is a good model to follow, although
> i might put the headers in include/linux/net/mediatek rather than do
> relative #includes.
>

I personally prefer include/linux than relative includes, so if everyone is
ok with that I would choose that path.

Again this is really to better organize and understand how to move
with the new code. Thanks for the suggestions as always.

