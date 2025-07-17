Return-Path: <netdev+bounces-207981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F72B09317
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8058844D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE32F94AA;
	Thu, 17 Jul 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBhdOUAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82F2FD59D;
	Thu, 17 Jul 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772971; cv=none; b=TtteuzD634gbbBjGBdaYeZSQ14XO4kPTxQOtvaQOX5HykJITr94IM9b5olRaLvcMg5bfLUbSNIejvLK9uVVE+r7KmIKKUWXYltjfFN2qJVcFMgHl/IbU7OwRf//kVV4X/khpKBqs6LUpV9PIrg3k2AWfXquYrVqRZ63JNB/5CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772971; c=relaxed/simple;
	bh=+f5kVd1eY8Gf8a4Ce6BEYZF/IIYBtPaQe/FOEtaQqDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeJGs3E+UetIssV3gDChJcO82f/exiz30rvFwGuZqlR14Ihb1tv/v96aW8n9I4f5QATufN7xEzAdxEYWKgqZ/9aDN+iKYq/80dDpI/WkfdYL3PIykZW6ReSiXhl8ftAehvKmq3VID7HmTqLrg/BM1sQroj0OwAOvYuLaIYIca+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBhdOUAI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso13431431fa.0;
        Thu, 17 Jul 2025 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752772968; x=1753377768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1M9VBNshXRr/zeZayfHhf6pLw+VHfQ7XhNs8UL9FnqY=;
        b=jBhdOUAIM+159akvKE1D80KC6VT3E0D2iAIEQmmF4kWyk8kQe9eDAU+oD3tB/HwpSx
         XDlAwXD5Yi/CqmBeH7ciNZMshk6rlVOgOMJwxznc1ka9SEanbCRmXI3yaotWX167v9QU
         biLDiQOxKzLyHvoVdWAJc9FPCYijJzKem5CaZlG+ScCCov9sZtaK5KarID39BauifpAt
         ijY+R3UfczWPwAL/AAy9iEQxI//3o/zhrJ0s/HDcAeBRiIhSh6AMu2ocJVo5YIOM13eP
         dz6OWTdzVrHnkRp3zoxZq50Cc1xBOMQPgIfqf6dU+UgDjgZEleJXwnXDNUBPbsMZDtqk
         IrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772968; x=1753377768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M9VBNshXRr/zeZayfHhf6pLw+VHfQ7XhNs8UL9FnqY=;
        b=MSymMlciGn9nHKtgCLwX+GOrdq7Sfd8eR6dht2ny3REdj/6dEpCVfiGuEV3kl+TL3Y
         w53wKCGQIBJ/XPmxDz4A7SpDroruXBwZvtKPXBAVG2p2R+syu5+xNlrxlgOAM2IAflxT
         eVdO7MOifhfP3Dd+smAIrGcoS7kw3wQ3AWwGVeTJDAg5zPFKqnI0YhwV9J6wBF3F1mAa
         Wj1uladlCkHj7HuppLgCZdI7FbbwAyHo+HPny1A+n+/+LmmpddE20tRRTHzdbqTJtxqc
         PzDHg6KY/EtipRrVe1BP0PkhYVCIvSNat8YbI2PysIYRgZIPuomJjsNWBilPa1ACWF8Z
         RjKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSajEoGt5kqQ3UqRkFW9ph6i9qTb0L6EYrg8uBluhY+jPd+TDf14M6XcsqEvKx5hHs5lC2EMNR@vger.kernel.org, AJvYcCVtANut3WjzgkSo/35aQ98x2N9faEtfVIRqNLloWZMA0lKvTFaO35rmageEuiFNzlmOqYLmhOyxFmcPIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYON12A8DKIqpfiK/7ydgXZy4viE1W56bYEBNfVNVH+hzfMnf
	EkNihzCybe0q+/acguQt6u4jH/a5TmP0Tn8OiNAQYRI4fomBLZUmuYj+
X-Gm-Gg: ASbGnctKAmjy8Pwnw7qft/5ss8VOZvciZWvyfanJk1oVdBYbldpYNx/kMTK5OeuKtZA
	B5XJdmukSYMwDjuuZOh3m7MPxmLizznZrfflnUCufrrV5Pk/VjS7NabMUt719k++CmmnIahsoBg
	i6JJyxoAdoLyY6ORSLlhPnB3ZEPEK53xroieZIESf0y57ISlyAMZs05y5b/2lqIeyXbBSPT776W
	QnSNkmgl+qI+aqtYgmdXbJi0gY1tpKh1NK8P2ZrM3qHXVf8qfnLDiufqCAZubLL95ZkyippTdu8
	/yYvZmdfnRVbBcFpPrytPV8ADF+uRQYhL8y2hYL3pdDZtx+pTzPOYCJr0k/gMw9VtIm0kvlH5/u
	CeIyWs0NKRfFMy9LaEX2/qWLHsels/LCbmm/gNcAh
X-Google-Smtp-Source: AGHT+IEhgPNpF+RY7Hv5LcpAToSUDOepB85CikAQqsHl0t8s9Rr18M+5Pk7Yf+LwBrK6Q8QRUcK15A==
X-Received: by 2002:a05:6512:4017:b0:553:a64a:18b0 with SMTP id 2adb3069b0e04-55a2970ec7bmr1282403e87.42.1752772967348;
        Thu, 17 Jul 2025 10:22:47 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bcd48sm3119279e87.46.2025.07.17.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:22:46 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:22:44 +0300
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
Message-ID: <ae4b3iobvbdyyijkpqhh4xv32rnfql2nvzmlzvmfbluefecy7z@t5o42w4orpfi>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
 <74770df8-007a-45de-b77e-6aa491bbb2ae@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74770df8-007a-45de-b77e-6aa491bbb2ae@altera.com>

On Thu, Jul 17, 2025 at 06:29:33PM +0530, G Thomas, Rohan wrote:
> Hi Serge,
> 
> Thanks for the review comments and the detailed explanation.
> 
> On 7/17/2025 5:17 PM, Serge Semin wrote:
> > On Tue, Jul 15, 2025 at 07:03:58PM +0530, G Thomas, Rohan wrote:

...

> > > 
> > > > 
> > > > What does XGMAC_HWFEAT_GMIISEL mean? That a SERDES style interface is
> > > > not being used? Could that be why Serge removed these speeds? He was
> > > > looking at systems with a SERDES, and they don't support slower
> > > > speeds?
> > > > 
> > > > 	Andrew
> > > As per the XGMAC databook ver 3.10a, GMIISEL bit of MAC_HW_Feature_0
> > > register indicates whether the XGMAC IP on the SOC is synthesized with
> > > DWCXG_GMII_SUPPORT. Specifically, it states:
> > > "1000/100/10 Mbps Support. This bit is set to 1 when the GMII Interface
> > > option is selected."
> > > 
> > > So yes, it’s likely that Serge was working with a SERDES interface which
> > > doesn't support 10/100Mbps speeds. Do you think it would be appropriate
> > > to add a check for this bit before enabling 10/100Mbps speeds?
> > 
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
> >  > Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
> > MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
> > would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
> > dwxgmac2_setup() method too for the v3.x IP-cores and newer.
> > 
> 
> Agreed. Will do in the next version.
> 
> Will ensure that mbps_10_100 is set only if SNPSVER >= 0x30 and will
> also conditionally enable 2.5G/5G MAC capabilities for IP versions
> v3.00a and above.
> 
> In the stmmac_dvr_probe() the setup() callback is invoked before
> hw_cap_support is populated. Given that, do you think it is sufficient
> to add these checks into the dwxgmac2_update_caps() instead?

Arrgh, I was looking at my local repo with a refactored hwif initialization
procedure which, amongst other things, implies the HW-features detection
performed in the setup methods.(
So in case of the vanilla STMMAC driver AFAICS there are three options
here:

1. Repeat what I did in my local repo and move the HW-features
detection procedure (calling the *_get_hw_feature() functions) to the
*_setup() methods. After that change you can use the retrieved
dma_cap-data to init the MAC capabilities exactly in sync to the
detected HW-features. But that must be thoroughly thought through
since there are Sun8i and Loongson MACs which provide their own HWIF
setup() methods (by means of plat_stmmacenet_data::setup()). So the
respective *_get_hw_feature() functions might need to be called in
these methods too (at least in the Loongson MACs setup() method).

2. Define new dwxgmac3_setup() method and thus a new entry in
stmmac_hw[]. Then dwxgmac2_setup() could be left with only 1G, 2.5G
and 10G MAC-capabilities declared, meanwhile dwxgmac3_setup() would
add all the DW XGMAC v3.00a MAC-capabilities. In this case you'd need
the dwxgmac2_update_caps() method defined anyway in order to filter
out the MAC-capabilities based on the
dma_features::{mbps_1000,mbps_10_100,half_duplex} flags state.

3. As you suggest indeed declare all the possible DW XGMAC
MAC-capabilities in the dwxgmac2_setup() method and then filter them
out in dwxgmac2_update_caps() based on the
dma_features::{mbps_1000,mbps_10_100,half_duplex} flags state and
IP-core version.

The later option seems the least code-invasive but implements a more
complex logic with declaring all the possible MAC-capabilities and
then filtering them out. Option two still implies filtering the
MAC-capabilities out but only from those specific for the particular
IP-core version. Finally option one is more complex to implement
implying the HWIF procedure refactoring with higher risks to break
things, but after it's done the setup() methods will turn to a more
useful procedures which could be used not only for the more exact
MAC-capabilities initialization but also for other
data/fields/callbacks setting up.

It's up to you and the maintainers to decide which solution would be
more appropriate.

-Serge(y)

> 
> > -Serge(y)
> > 
> > > 
> > > Best Regards,
> > > Rohan
> > > 
> 
> Best Regards,
> Rohan
> 

