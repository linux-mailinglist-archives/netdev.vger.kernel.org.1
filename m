Return-Path: <netdev+bounces-209829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5AB1108D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED033ACDEC
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AF62EBBB1;
	Thu, 24 Jul 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1HgVvJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A262192F4;
	Thu, 24 Jul 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379817; cv=none; b=LM74xQiuGYMPTcdZvQn2xOGswjnAgvGQvjHV0nC5egKxGl5sXoObY6MT+nKwueXaVCwy4G5BHyQTBE1yY/aGCLDjQzxRGUjMfhqxtdfKxeLI3KbUv4donTyVYTGR+9rhnaX1pPR5Q2pIR8Im00xRDt8Ek9hG3o+9svDUO2h8tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379817; c=relaxed/simple;
	bh=1mkblMfBIl1Lwwzh5TiSIwwcOL0XeaJ62oDOZdymnxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOPXhTuYv4hqnLCfEle+jZE5kUoxXvfIuzu4ZZla4tqOS0D58NFTK+X/eUlcuyhyLJLd93fXGYOvzEIlCwYMBHUw4Fmky2YhznmbO3HFTu8A1L2z2cpvjz0EqlRJp25rgkR0UpNVjCozaprZYZtbtevBM5Qr6VEad8IE8JNCG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1HgVvJL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso13778291fa.1;
        Thu, 24 Jul 2025 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753379814; x=1753984614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+Hc/EJTpAN/zUBy6dWU21PJ3WMLmwKCsM/9bWx/tE4=;
        b=G1HgVvJLJgtuU5lvy+qsI+C1J4AroPkn8QcqjCVbR7F6xGSt2M+0St1KN2CHi1TsBI
         Gzn9dKPSNShUcM/jOfLRsDZq6g+Xqux8Wq6fHeFUCuv6r2j5QzN/ebjGfnm7C3aLY+Cw
         WcuAUBRDDWebdCzQlTeIcoC/tbm9djtobOOaL02bg1vBhC5GlnPAG7YXzt3ECav2TlUu
         2kasUlEZHOLLIO/weWlVaqx0WvpDp2MDFmNskYUbygnkNpRRGq7BAIuw2ohcq1qkNVMG
         9opnW+r3fSETxjP5AKHUF/HA6EGYeUYZYq2GO3lm6tECg3uLsUCtAGnBaO/i0xzhVyb1
         dXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379814; x=1753984614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Hc/EJTpAN/zUBy6dWU21PJ3WMLmwKCsM/9bWx/tE4=;
        b=I21EVLlmWaXp09TOxDu8m287wOh17oXmiJroA0gp1Ucwm5NNYUam/t2kf4KEyQbK5f
         QZNPcM6fiaIsklOyQupCqQ++pb27lu5CfXxaChWtT/iMfYkyNvjCzyjVZkKnlAlbb+W0
         RDfrcmZTZ+/vkylzYoQ+htpj5ZegR2YNSK+4z1MfKOEMULWICghb56Kn/izNmLjoLQ5l
         n1fd4sXi8uq0KEPa3J4c2P6lCL/Iyp1/c+L23G35G29jl66JUgKgBt+T2Trwm3mSjOr0
         7QbRgMCuLE/HyJfuzCm5pNVFDI82B9NCxLcqzLKxC+FhGi8O20FclQqLymf2MpEN3O0r
         0tTw==
X-Forwarded-Encrypted: i=1; AJvYcCVQkD3IqRQCyyPakEemyRFpceDrvzDnAdH9zX83DSEEXUS7HTtEEb7T79fDm3zMgg/1VJHQwvro@vger.kernel.org, AJvYcCWqpbsG9sfV1Y1Kp6ijJtGzFJ5fwqKk9e01/EE9R0NX1l2HcUM7t/x8whBa2Sp5qcuFDhCSIO8sD+5Gpa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0XLmFywkBlzUV5rcbtOHLgp6SdHaTxygmvThboandYwkh1o0
	IuK7AHxdCYi9DeBiqklqGpz/dg5OIF5++wBsOzwirLUrEbcKVetXvEYn
X-Gm-Gg: ASbGncvlg+zK4UEMDwzrgAFjHLwCEjqA376peILhrcMp4MeJPo0OlT+m9kH5j7fTIcV
	/rEAE3GFe/JzzZyOD9ZeDqSwH7wou/er6hFYbmGJJsIc7SrSOLElClVkwXgvgCjieBLNk3ykDqQ
	D0i0Fk02WjpncMGo0zF/VkD99Kmu49Ccl8QkECRSx6hTga3Q8KNVnBHyUBt0WMewF6THR6Hs0+x
	OFNPFcumTKevLNK9BAQaIkxTZjeYZw9I5KdE4Ukvn0C5wv+Q02jBs72b4NnuwkP/ignPVyJxPdw
	0iB4sc+ObgqYUvcf42MgTlAY3sKsHQIjIfXkn03AO4qakEFXlcw9Gs2vzMXVFWLHwF3ugbb80Pb
	hTWuv0n/jUXwHsPnLw6EG+MaVU7OAzFNhA57A8kw/
X-Google-Smtp-Source: AGHT+IFN4Xrrwc5r0VQkcaQC/psZUUhsAWA2bd+XSOCuqzO1usstf65IZl+/xhZAoKMELAzl9zDBaw==
X-Received: by 2002:a2e:9cc2:0:b0:32b:3104:f89c with SMTP id 38308e7fff4ca-330dfe3cf57mr22675651fa.29.1753379813377;
        Thu, 24 Jul 2025 10:56:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e08e98aesm4007631fa.54.2025.07.24.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:56:52 -0700 (PDT)
Date: Thu, 24 Jul 2025 20:56:06 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Message-ID: <tcebsuesjejtk3vmzx77yuo7zil2xciucnnrakubrslwvnndas@utvi4r7ob3xa>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
 <4df7133e-5dcd-4d3d-9a58-d09ad5fd7ec3@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df7133e-5dcd-4d3d-9a58-d09ad5fd7ec3@altera.com>

Hi Rohan

On Thu, Jul 24, 2025 at 09:48:29PM +0530, G Thomas, Rohan wrote:
> On 7/17/2025 5:17 PM, Serge Semin wrote:
> > DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
> > neither in the XGMII nor in the GMII interfaces. That's why I dropped
> > the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
> > only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
> > MAC_Tx_Configuration.SS register field). Although I should have
> > dropped the MAC_5000FD too since it has been supported since v3.0
> > IP-core version. My bad.(
> > 
> > Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
> > has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
> > (XGMII). Thus the more appropriate fix here should take into account
> > the IP-core version. Like this:
> > 	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
> > 		dma_cap->mbps_10_100 = 1;
> > 
> > Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
> > MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
> > would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
> > dwxgmac2_setup() method too for the v3.x IP-cores and newer.
> 
> Hi Serge,
> 
> From the databook, I noticed the condition:
> (DWCXG_XGMII_GMII == 1) && <DWC-XGMAC-V2_20 feature authorized>
> which seems to suggest that 10/100 Mbps support was introduced starting
> from version 2.20.
> 
> Am I interpreting this correctly, or is this feature only fully
> supported from v3.00 onwards.

Hm. Interesting discovery. I've got only DW XGMAC v1.20a, v2.11a,
v3.01a and v3.20a databooks at hands. So I can't prove for sure your
inference. But the DW XGMAC v3.01a doc indeed states that
DWCXG_FDUPLX_ONLY parameter is enabled if:
(DWCXG_XGMII_GMII == 1) && <DWC-XGMAC-V2_20 feature authorized>
which implies that the parameter was originally introduced in v2.20a
IP-core.

So to speak you might be right. Perhaps it will be more correct to set
dma_cap->mbps_10_100 for v2.20a (SNPSVER = 0x22) IP-cores too
especially seeing another parameter DWCXG_MII_SUPPORT depends on
SNPS_RSVDPARAM_16 which also depends on DWC-XGMAC-V2_20.

-Serge(y)

> 
> Best Regards,
> Rohan

