Return-Path: <netdev+bounces-118252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08195111B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F29A1F222B7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746091FA3;
	Wed, 14 Aug 2024 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHzGkOcd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737E4A01
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596184; cv=none; b=LcbkEMIVRM87uPuH6pl2sqtTA0KV05MBdyzW/cPcGoKCj1w0vSuEVKYMAi1nnugTVhPObfr4SCyA6XAVo8wYczKM4fTeE7PsA3LtkYa0rQYL79IPltimD0gIlh//es9PdhClchq58kofPjVpmxH2oObnByNrouHZFRI/zTNk+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596184; c=relaxed/simple;
	bh=zdtQWhP/q44ASsgIwXBKQbesMKZflcf6Gaq4cnOTTtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH7mIrp0fCTM/Fu+sKqx+lz5t3X0VOA5nRNNsS/Lsv6QIQNIBBvlNvUsiZdeYtocYiwDoc5fCcQ88Uz9ACXbAiSiZm/VLkWpifHP/6yHy9lKBRA25B9lmVP3VOsnCZPjlNGCKB34woxl7FDhcZikWbLrpFaaDJJMe0hdKA6uNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHzGkOcd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723596181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neqRTcEj9/zj+36l4CNYLscl48VCNlUw8+/D/Uqo/H8=;
	b=AHzGkOcdrQ4nG3qutlTlS9BMTCAf3AMfRxinOsR2qXXDC22aJskS35ymDPhhdXaZhhzMX+
	yT1ZN7CHtpCKMw2V/YyLZ01BYwuJ6jU4kbXcD3/l2bIUFBvEFJQyT66CsKtbbNzQQ3Wde7
	FSGrophYI+0hMML6NyQMqv1cl4lu4QA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-tiIdDxU9OcqApLfZYN24Bw-1; Tue, 13 Aug 2024 20:43:00 -0400
X-MC-Unique: tiIdDxU9OcqApLfZYN24Bw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5d5c7700d4eso6248572eaf.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 17:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596179; x=1724200979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neqRTcEj9/zj+36l4CNYLscl48VCNlUw8+/D/Uqo/H8=;
        b=IAkMOT1Qq0TRuj1gqkN36q7bzT38IrbvJbaNf8ptB4I51NB4A2x1GcGZzyIhZh14FN
         Mt5vb9A3C2IjqMYQ5BN0vGHXL9HvNDrW3xtPMGW/zmout4MPvtgG5b9tyTGGQMdjA6rv
         Zo4Y1sYE6l3XaGezLynLLSyS2411qfMP06ugN9Q5ILnOVdSmU8tdHEZmnjrTN66dxsv8
         dxbBWk9M32LrcSFNExHYQuyLVsThFyCJq2Tv2p2bLJpTTphqHb1SrZliLv6llgk/c6jp
         WA6ykk9JsuA4bV7QypGGUrD9NtQw5ebWj9hUGOCHUagyffhsk/+sXKxcYUI9QiqFPnCk
         J+9w==
X-Forwarded-Encrypted: i=1; AJvYcCX6iKnZQ4Pg6DWHeJ+Cdoo5iX5sr6+1S0SwqcAwycB7qaOPzQkiDGmY2syIV+QXM744XI/9bdfcJdG1Y8KxOw75D91viPRT
X-Gm-Message-State: AOJu0Yzkl8yftoTQrf8b7fJIxdQWLpZqRjJNKQhiXMytOM6ZV1CzFedG
	qhiPY4resWBcRHgys2YQutisbc7hleDv+jqHeAAb3PVQ8/lagjFJD6UnJXy0prQ96tnpTcm7ByV
	iOx8u1ayl85YSyyTXSWu/CY+CBWaM62mycg1fW5rnS4GmgPR8QPXIjg==
X-Received: by 2002:a05:6358:5709:b0:1aa:bde7:5725 with SMTP id e5c5f4694b2df-1b1aad56c0amr166435355d.28.1723596179306;
        Tue, 13 Aug 2024 17:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTcmIh03e3B7xSn2L7DkI7RRKwpSIiec73Jgf5I9h/tC3e+8R44UqAGwk+9QzPwWzu5FYJxQ==
X-Received: by 2002:a05:6358:5709:b0:1aa:bde7:5725 with SMTP id e5c5f4694b2df-1b1aad56c0amr166433455d.28.1723596179007;
        Tue, 13 Aug 2024 17:42:59 -0700 (PDT)
Received: from x1gen2nano ([184.81.59.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7ded208sm383575085a.89.2024.08.13.17.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:42:57 -0700 (PDT)
Date: Tue, 13 Aug 2024 19:42:55 -0500
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
Message-ID: <lq326y6bjavnvrn4nre2kwetwnu2oiv7rrjbb7iol44xckgu5w@gjaedc7arxxb>
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
> 
> Fix the warning by permitting the plat_stmmacenet_data::mac_port_sel_speed
> field to have the zero value in case if the internal PCS is available.
> 
> Fixes: 02e57b9d7c8c ("drivers: net: stmmac: add port selection programming")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


