Return-Path: <netdev+bounces-117302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FE94D823
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D221F21C42
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E615FCEB;
	Fri,  9 Aug 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzJBBR0a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA434225D6
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236073; cv=none; b=TQZPQDq2UWxALq5PQUaDGnsahpVoxZapKYO6Dh4U0D4AWU4bWtOzp8UD7R9BmVmMv8mvKSlBH7wRS1oscvflmFbAPOmz5jr+YGh9DxaX0zfbzHclDWN1FdLgdh20O+lU7Y2tXQA8m3j9PLpOJ2EhWFAkuNnr/x9KhMCAAWGEIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236073; c=relaxed/simple;
	bh=KIEE9ddkqI5f2L7JTcgq3V0MrI0MyZ1KSMoEuAfnvVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgghvBdloPKe+Tlyj77WUorSebpVdNnxkajdRL8vtoFp6x9SroVsDQrypSHQsrXKjM3Y1p1QgRFVbV3IgCTbcWinx2GdLWxDzlKQm9OI73PHbI2oipKHqK/GKnjBYNfmQesD+sCmjGRbls5nfLzymldXWPkJj+AnrG+dVjyS+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzJBBR0a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723236070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNEXIEJzPBMlsAjpwHn7jEhkWltbTdI4oT0K7wYk6s4=;
	b=gzJBBR0aXdssxPlutpr8zx0l+xRC7q7C/VfwCQOwRQ3kwOwYasAaAZSgjY2eCupXeqLsnn
	C1b0fP40cnIqQ2VTViB+96CGDYQiWdm2FWpOfy/W7DSGIHvWrYYN1XOwhkQ390SiGebmqe
	FlV62KUyb9HPztecHhU2x1ATtz2Oh5k=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-xlLV8DYROLGXG1Dz6MUdpw-1; Fri, 09 Aug 2024 16:41:09 -0400
X-MC-Unique: xlLV8DYROLGXG1Dz6MUdpw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-492901b9bedso1299979137.1
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 13:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723236068; x=1723840868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNEXIEJzPBMlsAjpwHn7jEhkWltbTdI4oT0K7wYk6s4=;
        b=UkQdsR09VkQHF2YUVt9wmA9OvXPgi9yilQgtLAaTlAlV3CYNE6rPH2v8JDA8nFnzqp
         9YrfdFd/V5FkgIDx4FobGqW6TNdHtj8jA/mNma+1ce9sbA8pvQ43zDZJcjKZS/zXCxUv
         XNrk2LDMP3oWDOUGSA0Ih5anmwL3Q+IcAn8g5nq0YqkpFwc7Q8DdR7IXuAI0Ld7iblaE
         X4P9KaADuzrHf+KtbWXndN0qYZhYqyTaNchjgcsaaZzeinBf22n8NG1+JpW0AEDoo9kz
         DnMJNB1neln5q1xs1DPc3SnPxB0n3j1LJHkshFnJTyeutLDPieJi9GouDfD68ap/+jbS
         uUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUajeyidEyxii6mS4f/w+LJsy8DPeH8LRLAmFaYuVcIvLNitM0WImY//+bPMz0xVB0duuvuCrwrqZQv1qpR48pE50n+4oS
X-Gm-Message-State: AOJu0Yyz9rD9CXWbdMOsqN7kkCnz7iAzdfhFbDVBlwhCmATIJDnhOcCV
	geOp06LSzVOQILPxXtH6Ldfec/AAerAn2+wwXp0Uxf+MX0/2oqTfMaoLULgAmL2OPx7FgbvKCb0
	qrbOrTyLb9dfcmP8gTnIzuEc/c5AEyJHpPwBfXPDYkiTbtH7vi/j97Q==
X-Received: by 2002:a05:6102:3a06:b0:48f:eb5f:84d8 with SMTP id ada2fe7eead31-495d85e952emr3059689137.27.1723236068638;
        Fri, 09 Aug 2024 13:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhReBDQpsSa/QW032kDulYMN60Yhxqd+Hhm6w1zY++jeYljBNaq2SJ1k5pPC7La1xrvy/g7w==
X-Received: by 2002:a05:6102:3a06:b0:48f:eb5f:84d8 with SMTP id ada2fe7eead31-495d85e952emr3059671137.27.1723236068218;
        Fri, 09 Aug 2024 13:41:08 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1c322csm1137141cf.26.2024.08.09.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:41:07 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:41:04 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Fix false "invalid port speed" warning
Message-ID: <32bevr5jxmmm3ynnj3idpk3wdyaddoynyb7hv5tro3n7tsswwd@bbly52u3mzmn>
References: <20240809192150.32756-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809192150.32756-1-fancer.lancer@gmail.com>

On Fri, Aug 09, 2024 at 10:21:39PM GMT, Serge Semin wrote:
> If the internal SGMII/TBI/RTBI PCS is available in a DW GMAC or DW QoS Eth
> instance and there is no "snps,ps-speed" property specified (or the
> plat_stmmacenet_data::mac_port_sel_speed field is left zero), then the
> next warning will be printed to the system log:
> 
> > [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> 
> By the original intention the "snps,ps-speed" property was supposed to be
> utilized on the platforms with the MAC2MAC link setup to fix the link
> speed with the specified value. But since it's possible to have a device
> with the DW *MAC with the SGMII/TBI/RTBI interface attached to a PHY, then
> the property is actually optional (which is also confirmed by the DW MAC
> DT-bindings). Thus it's absolutely normal to have the
> plat_stmmacenet_data::mac_port_sel_speed field zero initialized indicating
> that there is no need in the MAC-speed fixing and the denoted warning is
> false.

Can you help me understand what snps,ps-speed actually does? Its turned
into a bool and pushed down into srgmi_ral right now:

	/**
	 * dwmac_ctrl_ane - To program the AN Control Register.
	 * @ioaddr: IO registers pointer
	 * @reg: Base address of the AN Control Register.
	 * @ane: to enable the auto-negotiation
	 * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
	 * @loopback: to cause the PHY to loopback tx data into rx path.
	 * Description: this is the main function to configure the AN control register
	 * and init the ANE, select loopback (usually for debugging purpose) and
	 * configure SGMII RAL.
	 */
	static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
					  bool srgmi_ral, bool loopback)
	{
		u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));

		/* Enable and restart the Auto-Negotiation */
		if (ane)
			value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
		else
			value &= ~GMAC_AN_CTRL_ANE;

		/* In case of MAC-2-MAC connection, block is configured to operate
		 * according to MAC conf register.
		 */
		if (srgmi_ral)
			value |= GMAC_AN_CTRL_SGMRAL;

		if (loopback)
			value |= GMAC_AN_CTRL_ELE;

		writel(value, ioaddr + GMAC_AN_CTRL(reg));
	}

What is that bit doing exactly? The only user upstream I see is
sa8775p-ride variants, but they're all using a phy right now (not
fixed-link aka MAC2MAC iiuc)... so I should probably remove it from
there too.

I feel like that property really (if I'm following right) should be just
taken from a proper fixed-link devicetree description? i.e. we already
specify a speed in that case. Maybe this predates that (or reinvents it)
and should be marked as deprecated in the dt-bindings.

But I'm struggling to understand what the bit is really doing based
on the original commit that added it, so I don't know if my logic is
solid. i.e., what's different in the phy case vs mac2mac with this
particular bit?

Thanks for your never ending patience about my questions wrt the
hardware and this driver.

- Andrew


