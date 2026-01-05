Return-Path: <netdev+bounces-247134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8E9CF4D66
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A53322196E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA041D8E10;
	Mon,  5 Jan 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpvcwbQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2430DEC1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631350; cv=none; b=rE2dxdVbvO/pCOVau6SGqKU0YmcOlXCTmM2nLqPeyCtBN8OOCqM9YUt26rWqvE6elnXSo2iujcl5q//5aE93KgmUl5iRcKbanhFCgW+Kc54R1cM3uGoCZcvVBEp1xQAZHB4Gc9ZJeFHeDXBfkJMsNsXbEr/NPdN9bI4eNqwFAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631350; c=relaxed/simple;
	bh=m1cWU1c28IHidxYRJfjMgPQezz6qGL1YM01BII9uEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+LJw+4joQnh96zfIrhFIGa/qSnC0Xy2MK10XQolq1WNoCn67WrCy0xm6YaXN29YCKNGDuwDAksd6Y/ALVm0RDhcL+4k3Qegtetbuhqt7pfvnOc9VyBaFcopraJUtJpNx6snI+Jqihvyap7tnAyiAS+OrrNRhZSf5/7mkUNRTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpvcwbQm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso732865e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767631345; x=1768236145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OyCREwze6wuRU2UsbFO8TEdIlanzdvvtH1ABUGO9pDk=;
        b=YpvcwbQm1Ws8kOnBUDebthH7pvpr+9K1tOO6q41ET3aQT3gSf0QPKEjIH7nFGXScZl
         nbvPh+zzM+mEpGmIJsqK85m7URuRjmo92MoOVdjG9YaDLr/LxU6NoIyG3FAp9hK4DI4d
         /sHcowifOP/wrfNVb+Wwhb4ZYIA37cIUtY0M2ojV1pMpyqCOpAAP7FggUhxLyFln4kg8
         fZPdcJFwhjLs/jQ0tcDd1Y8pKfm82Kmw3dDCyaax6DiTnR2FgJ8qB22eJyFqK2dpPm5w
         JJzC9Qn6D6R8PB3HEtVk+UeytTw8chSRaGZAfK7O796k+BgpbiDZbW7wPZdTpjDp5eOC
         EDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631345; x=1768236145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyCREwze6wuRU2UsbFO8TEdIlanzdvvtH1ABUGO9pDk=;
        b=Zm/7Q7Qj+9WPdXLfp9s3RZKaNzZ27Il+RHhZTl+GQedwbvcKQixtEL7x2Kf1z7gDhd
         z3K7Wy50bUm/EZRKRnJaaec62HKsqL3PtqqdV2cZRTdecQo0S/hJxUfi7EhipIoAFRw8
         bJA6aeY4yirIxYS6Q5BloW+LCyQs6ngDUlCN1xoRa4sy+Vdd/f2vxqFOe4QsAvQ0w7eW
         if/cnOfp5VUBrKuyATFDEbyThpdEM1W9JNGei2Rd8IHJ1FAh5qzTl3qoir+1tp6njFRk
         +9sXSpXubtxxnuTLraP8C9th4jUaWpH/Gg5izKNcX2rJutwzYvYuX1FZjWcCxNW3Cnv+
         QSng==
X-Forwarded-Encrypted: i=1; AJvYcCWxaQyxzQvGzyK2JEn8fL7fdtR5TxVJKCf1fg8IZS3aug6251tFVR/jkJvucZvzL4nbwsraKx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFYmtnU17/l9Iy4i9kNW/3Yfvh3MoA4gK+E8tuWVzosCCPwpo
	7YSaNafunDN/5ltks7Rgrgd3IM3yb2sHQw7EKiC2XwdJVwudQ17SY+cS
X-Gm-Gg: AY/fxX6qsn547PMllOPmT28QNFAoZd+AepZNK8BSQ1Hkueg6dBHkzWx0rpyhb5QokWU
	qDg2uAHAy53qlov+rvW1ylawfNu61sNpAwhvK2MLATMCwu7A5OdW+M/KqAiJLhxeLfZI8HPya2D
	oZZMK+j0UxlpGMeZmkNin6EtFcMgdMixPh/fmnfnLJIn4TPuO7kwG7SstfbNkjQxfyz51rCZJA0
	CKtfp4A89TzoQbGArnI/FKSrt7UmngLGIpyVER3ts77OG8zbsJX3p3rUqidNgLP5kMCv2MVKlgH
	QZXboY1t/J6o7CESeDPTTWHRIxAXyKHljxWe6ZQTfnt/jCAjImD+UWI0yBkj5s/TfCDPsW7BulG
	ma3tbn+9mY6VrZPw0G5pL3Bx8vtAFRyfCxHGLVm3nucXwv+3Mojn+6chuucBSil/RNJVgmwYOGg
	CuZS8JByJW0SM=
X-Google-Smtp-Source: AGHT+IE/JjorzXLwwkJgsbApvm+a3QMCRUUp3o9LGdUjHP2iI1zq9V8yb9BydDK6HAKwFcoQXH8UFg==
X-Received: by 2002:a05:600c:1c29:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-47d1959d4bamr704429525e9.34.1767631345377;
        Mon, 05 Jan 2026 08:42:25 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:20bb:19ed:fbb2:7e2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bca532c6sm442805f8f.27.2026.01.05.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:42:24 -0800 (PST)
Date: Mon, 5 Jan 2026 17:42:23 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <aVvp70S2Lr3o_jyB@eichest-laptop>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>

Hi Andrew,

On Mon, Jan 05, 2026 at 04:26:40PM +0100, Andrew Lunn wrote:
> > Unfortunately, I'm afraid of breaking something on the platforms
> > that are already working, as this is an Ethernet controller
> > issue. As I understand it, the PHY works according to the standard.
> 
> What is the exact wording of the standard? I'm assuming this is IEEE
> 802.3?  Please could you quote the relevant part.

Yes this is correct. ERR050694 from NXP states:
The IEEE 802.3 standard states that, in MII/GMII modes, the byte
preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
(0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
be no preceding preamble byte. The MAC receiver must successfully
receive a packet without any preamble(0x55) byte preceding the SFD,
SMD-S, or SMD-C byte.
However due to the defect, in configurations where frame preemption is
enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
byte, the received packet is discarded by the MAC receiver. This is
because, the start-of-packet detection logic of the MAC receiver
incorrectly checks for a preamble byte.

NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
they show two tables one where the preamble is preceding the SFD and one
where it is not. The text says:
The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
between transmission at the source GMII and reception at the destination
GMII. Table 35–3 depicts the case where no preamble bytes are conveyed
across the GMII. This case may not be possible with a specific PHY, but
illustrates the minimum preamble with which MAC shall be able to
operate. Table 35–4 depicts the case where the entire preamble is
conveyed across the GMII.

We would change the behavior from "no preamble is preceding SFD" to "the
enitre preamble is preceding SFD". Both are listed in the standard and
shall be supported by the MAC.

I hope this helps.

Regards,
Stefan

