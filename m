Return-Path: <netdev+bounces-130215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F99892F4
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 05:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39A11F2182B
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CD0249E5;
	Sun, 29 Sep 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ATK5Ec35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206EAD51
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727582290; cv=none; b=mrH5Fxdzl8NNn0hVC+5e/dzpUBB3wId9ZjidqxlsmtnzdaYgVcUvvhkdF+67mJC6Otta5ZhT7f1YXd3/Askv/ZojWG0MeUqSQ/akGs0llRxLIss7AA7DngHB+vfPuhlTBAiYpAOivwxppWya+1MS2uFE5NTbI/YGngufq88Lbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727582290; c=relaxed/simple;
	bh=aaVSKdkRgN4OaH6OgMY4XkDmYKUvaQpfJVKpqLC/iIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/Aau8C+V1BSWR3mA65seMdYceCKTS1ZKTt7aGCjOEE3HYbbFSDlGgkdF1IapuxlD+3JGsLjR9fGoTjaYm6UzbKFvhxWEhPplR/qywU0j2eXfwBpsYMXgMSVcAXTt2vuzZBbEww9KRPhg+TY0rq6xNWEbgrV2qXxr/FPdTqc76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ATK5Ec35; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-205722ba00cso30566925ad.0
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727582287; x=1728187087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YkWfPvtAH4vWwmKQhiADe/rYImGBQg3vsS8ImzGFis=;
        b=ATK5Ec35NTMqsRmoTJEMJnDZwRkG786hWBuzzYWq0ASYfbzSdHxX4j7S9S7Jdu+Olt
         IbbwpBHlQ5czooZr+XuoQIYjE/D9l99Dv2A6Tv/uJFv6wT4XSb5qS9OR/Y2ysN6Jg7Rt
         nU4ZGj30RHs9qqUY78bjB6BlC63Pm2fZGuXZFwjQe9RKPxdE15JwiU8tdItUtLo9Kfdz
         0pWfvMor4XlZGSjgCYcJp860OHnZTipVk94paAuZn0kroT30NJB/R9tNFiPR0JCYyS49
         yS3KtfvBFPWRS6QOIXRHY4xBMUuzzwFUMTH85RXkHYMCQm1srxRTlperJ7671ir7YRkJ
         6PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727582287; x=1728187087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YkWfPvtAH4vWwmKQhiADe/rYImGBQg3vsS8ImzGFis=;
        b=NMGKcTu4NEKC+3KHZ+sfN7cmTg8X10eF5WDdcEEp3TatYMjzDBRjcZpWcVH1d0dDjh
         gwqOmQsUDDWr+mfahlAZMIp+JH9axE4lUX9EVD3+ZPmRLqadmt1vsdZEj8X4GaZb7Zag
         8D8I+nR+YPilHmaHLnKNoFAfJZ1ydl9/xPNmcx9JSaYU3zL/X5qpo5CpoXkxh3Xw2e+2
         8jTwD/wFgeFOy3ibXQYKI/C4uDgqTRL65y1FyUbIUfoAiarjfCUO/sdzH8dB6RylgEtM
         pIG0k6aQ1Lf9Jd5kmuRpNxhy4ZX8y+5AeEge79FAdZkEWxRE4ZXEMWH/YsBMfLpmwtgW
         CrJg==
X-Forwarded-Encrypted: i=1; AJvYcCX0POcCYXR7bWAYCNm7cYlvgrDRaNbW99hls6KNqj0FYthQe/O27e3H5Eg4aOOY58IO5tsRVNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsAjPLmV6XKTy+BduhUJ+mlApmSun9oOURPGJ1ysvbo2wNHV9
	p02mr/Ul2oAx4VooeU9x5HsJw5gfQJk2PBEl18avOPWvv3WzJKMaB8iRLKhJ0DE=
X-Google-Smtp-Source: AGHT+IGV/f9jzts7RDAjmlHZvifv1MNEX/u7uVlkFGTpdrqBwMyA+z/HUMV+o4vjzAPi2t1Jy3PuxA==
X-Received: by 2002:a17:903:8cc:b0:20b:5b16:b16b with SMTP id d9443c01a7336-20b5b16b29dmr54329085ad.36.1727582286974;
        Sat, 28 Sep 2024 20:58:06 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e36fe7sm33519615ad.211.2024.09.28.20.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 20:58:06 -0700 (PDT)
Date: Sat, 28 Sep 2024 20:58:04 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
Message-ID: <ZvjQTD9jG12rX8Gx@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1>
 <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>
 <ZvYJfrPx75FA1IFC@x1>
 <5076789c-3a35-4349-9733-f5d47528c184@lunn.ch>
 <ZvhviRUb/CitmhgQ@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvhviRUb/CitmhgQ@x1>

On Sat, Sep 28, 2024 at 02:05:13PM -0700, Drew Fustini wrote:
> On Fri, Sep 27, 2024 at 01:58:40PM +0200, Andrew Lunn wrote:
> > > I tried to setup an nfs server with a rootfs on my local network. I can
> > > mount it okay from my laptop so I think it is working okay. However, it
> > > does not seem to work on the lpi4a [3]. It appears the rgmii-id
> > > validation fails and the dwmac driver can not open the phy:
> > > 
> > >  thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > >  thead-dwmac ffe7060000.ethernet eth0: validation of rgmii-id with support \
> > >              00,00000000,00000000,00006280 and advertisementa \
> > > 	     00,00000000,00000000,00006280 failed: -EINVAL
> > >  thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -22)
> > 
> > Given what Emil said, i would suggest flipping the MDIO busses
> > around. Put the PHYs on gmac1's MDIO bus, and set the pinmux so that
> > its MDIO bus controller is connected to the outside world. Then, when
> > gmac1 probes first, its MDIO bus will be probed at the same time, and
> > its PHY found.
> > 
> > 	Andrew
> 
> I'm trying to configure the pinmux to have gmac1 control the mdio bus
> but it seems I've not done so correctly. I changed pins "GMAC0_MDC" and
> "GMAC0_MDIO" to function "gmac1" (see the patch below).
> 
> I don't see any errors about the dwmac or phy in the boot log [1] but
> ultimately there is no carrier detected and the ethernet interface does
> not come up.
> 
> Section "3.3.4.103 G3_MUXCFG_007" in the TH1520 System User Manual shows
> that bits [19:16] control GMAC0_MDIO_MUX_CFG where value of 2 selects
> GMAC1_MDIO. Similarly, bits [15:12] control GMAC0_MDC_MUX_CFG where a
> value of 2 also selects GMAC1_MDC.
> 
> Emil - do you have any suggestion as to what I might be doing wrong with
> the pinmux?

I've been thinking about this and I don't think there is any problem on
the LPi4a. Both Ethernet jacks work when I have the mdio bus muxed for
gmac0 to control it. It seems to control both phy's okay.

Earlier, I tried to setup nfs root but it didn't work. I believe this is
just due to my ignorance of how to configure it correctly. I've instead
switched to just adding 'ip=dhcp' to the kernel command. This causes
stmmac_open() to happen shortly after the thead-dwmac is probed for both
gmac0 and gmac1. The phy is found for both and there are no errors.

Without 'ip=dhcp', stmmac_open() is not called until around 40 seconds
into boot when NetworkManager tries to open it. Everything works
correctly but the delay of over 30 seconds from thead-dwmac probe to
interface up looks odd in the logs, but I am pretty sure this is just
due the point in time at which NetworkManager decides to bring up
the network interfaces.

Booting with gmac0 connected to Ethernet cable:
https://gist.github.com/pdp7/e1a8e7666706c7d3c99b6b7a3b43f070

Booting with gmac1 connected to Ethernet cable:
https://gist.github.com/pdp7/8a9c2066a2c20377ec3b479213b9be4c

thead-dwmac probe for gmac happens around 6 seconds. stmmac_open()
occurs shortly after that. The interface is up by around 10 seconds
into boot. DHCP request works okay and the interface is up and working
once the shell is ready.

In short, I believe the dts configuration in patch 3/3 of this series
works okay for both Ethernet ports on the LPi4a.

Thanks,
Drew

