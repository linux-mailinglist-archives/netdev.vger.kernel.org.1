Return-Path: <netdev+bounces-81321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92188735A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26C1B216B1
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81B6F08C;
	Fri, 22 Mar 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHk2nzBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4D6E60D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133262; cv=none; b=VeKmgKp8QUug5tT0MFFjGNepan5+4GFG+Tj0GbVctZW7Y10lZMj2rqLbpMGiDN34uA16gfJkjz81QPvQscArqZIp0VLwBzPA0JFbhUHnLMA/QHBl4GefoNEDFO9D5hzw8AD/9c0cL1d/Lldf01qnL8jebQn1sSe5Tx0rCllDbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133262; c=relaxed/simple;
	bh=vSdQOe+HPCr37E6/s54vnEHlsLu6yCmxolGOCcW5u60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plnl+CeEOFbyEKTDdORV8Pd1hkfKDNfbK5+ubcoTsc8A2NbtiNue94ciEsIIySgEBfsYP4de9y7obQH9xpGXriczvI55KOUS/ma7GLqZLEXfqpGxUhUuYersAyYiCDcRcghG9Ea1BmCXU7DtgjmRrA0/Ru5PKiPN3hmfoDi9FGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHk2nzBT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513c8b72b24so2793676e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711133259; x=1711738059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wAdL9KBels27DMRkr0txQCwk0I3oRGyD9ctKZu+ON6k=;
        b=UHk2nzBT6BzsYtgv6H+FuCkfCjhpslf4D7QxiLEBGPa/KYA9JRq2MfBlE0KcNaliJX
         maVAcQnq7AhxNdQob+8auOdtvxsrmX7VF93nYz4HEX+xLEeYgYXGW5E86czCFQVmqplT
         q3Us7U6V0XfnjvKv4VonjspVIB5Prc+lzk5S9l67hK0+7UcZy6RrhIxmDkJ4CFthiSJN
         UMExVvpxkXGpVPSPQX7PmKDLaDaNeHc47lxZlBK3P58EV0e8NHsMzamdfbWa2cWtp4//
         8zmcCSjVfDZ83JbKxA9oU5iwj02eUaK/CI551juB1NvE06NRdu5lRVA6jAYdCJUKbSQF
         4a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133259; x=1711738059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAdL9KBels27DMRkr0txQCwk0I3oRGyD9ctKZu+ON6k=;
        b=SMOUA6w/zmIdCXhaCPK7jDoYTK4bYvcUcfFrFWLWwyKM4pz+dUpfn45WTMuYGQcfiX
         7nDjgbhptBTBLWt4JEmEVVrOLlMKEIaQVFlnYxDcmCVSEBZm6McBj8fcfQf1wEL9Drob
         MO0iMQxvR4T90nPqWxFzdBKTzW9TQK2tUB6OaEJVvYzWRDFR/uu9bUDKiy3Ilapy3YdS
         Yz1NCSDSMIX6E6/Hu6EiHaFySyJ/Gr6SmPYg2p5MuVN10xR8MdFpyCqEijuArNZn8ToC
         NBO6hHe7ohRFZZDNoz/zfP2Xj5Vbi+Uyge/q1z+Q/8/L3WHTMZbexuyRUKJFCQe/rc1g
         pEnw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3yMa/8xaHcS2FTV9d3wpgqPD94SyE3zmtPUbobgtuAhzP92u0TGrJOAqF0nsMaeK8z+QMcro9zTn3XauhwUVcpIioxj8
X-Gm-Message-State: AOJu0YzUuI6WJ9bRNb4ramxdeP9AcGDXSMiHpISTdBU4CHrhaiJ1nTwt
	HFd9Iv/WC+Huxl6w9K+pY6kTon6Qd2TWyo5iF+LODEwUmtv5tuHI
X-Google-Smtp-Source: AGHT+IG2ja+8kqMkbex+tOKq1t0XQ/2t2UmOqQ2iys9jwZ0OrRKBTKuNFk2AkjlTAU/9TRBJB0heGw==
X-Received: by 2002:a05:6512:92b:b0:512:ab58:3807 with SMTP id f11-20020a056512092b00b00512ab583807mr198556lft.9.1711133258661;
        Fri, 22 Mar 2024 11:47:38 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b00513b4e492c3sm12328lfn.21.2024.03.22.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:47:38 -0700 (PDT)
Date: Fri, 22 Mar 2024 21:47:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
Message-ID: <tr65rdtph43gtccnwymjfkaoumzuwc574cbzxfh2q3ipoip2eo@rzzrwtbp5m6v>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
 <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
 <e57a6501-c9ae-4fed-8b8f-b05f0d50e118@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e57a6501-c9ae-4fed-8b8f-b05f0d50e118@loongson.cn>

On Fri, Mar 22, 2024 at 06:36:20PM +0800, Yanteng Si wrote:
> > > > > > +{
> > > > > > +	int i, ret, vecs;
> > > > > > +
> > > > > > +	vecs = roundup_pow_of_two(channel_num * 2 + 1);
> > > > > > +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> > > > > > +	if (ret < 0) {
> > > > > > +		dev_info(&pdev->dev,
> > > > > > +			 "MSI enable failed, Fallback to legacy interrupt\n");
> > > > > > +		return loongson_dwmac_config_legacy(pdev, plat, res, np);
> > > > > In what conditions is this possible? Will the
> > > > > loongson_dwmac_config_legacy() method work in that case? Did you test
> > > > > it out?
> I need to wait for special hardware and PMON for this.  Please give me some
> time.
> 
> > Then those platforms will _require_ to have the DT-node specified. This
> > will define the DT-bindings which I doubt you imply here. Am I wrong?
> > 
> > Once again have you tested the loongson_dwmac_config_legacy() method
> > working in the case of the pci_alloc_irq_vectors() failure?
> 
> Yes!  I have tested it, it works in single channel mode.
> 
> dmesg:
> 
> [    3.935203] mdio_bus stmmac-18:02: attached PHY driver [unbound]
> (mii_bus:phy_addr=stmmac-18:02, irq=POLL)
> [    3.945625] dwmac-loongson-pci 0000:00:03.1: MSI enable failed, Fallback to
> legacy interrupt
> [    3.954175] dwmac-loongson-pci 0000:00:03.1: User ID: 0xd1, Synopsys ID: 0x10
> [    3.973676] dwmac-loongson-pci 0000:00:03.1: DMA HW capability register supported
> [    3.981135] dwmac-loongson-pci 0000:00:03.1: RX Checksum Offload Engine supported
> 
> cat /proc/interrupt:
> 
> 43:          0          0   PCH PIC  16  ahci[0000:00:08.0]
>   44:          0          0   PCH PIC  12  enp0s3f0
>   45:          0          0   PCH PIC  14  enp0s3f1
>   46:      16233          0   PCH PIC  17  enp0s3f2
>   47:      12698          0   PCH PIC  48  xhci-hcd:usb1
> 
> 
> the irq number 46 is the falkback legacy irq.

Ok. Thanks. You can do that in a bit more clever manner. Like this:

+static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
+					   struct plat_stmmacenet_data *plat,
+					   struct stmmac_resources *res)
+{
+	int i, ret, vecs;
+
+	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
+	 * --------- ----- -------- --------  ...  -------- --------
+	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
+	 */
+	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
+	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
+		return ret;
+	} else if (ret >= vecs) {
+		for (i = 0; i < plat->rx_queues_to_use; i++) {
+			res->rx_irq[CHANNELS_NUM - 1 - i] =
+				pci_irq_vector(pdev, 1 + i * 2);
+		}
+		for (i = 0; i < plat->tx_queues_to_use; i++) {
+			res->tx_irq[CHANNELS_NUM - 1 - i] =
+				pci_irq_vector(pdev, 2 + i * 2);
+		}
+
+		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	}
+
+	res->irq = pci_irq_vector(pdev, 0);
+
+	return 0;
+}

Thus in case if for some reason you were able to allocate less MSI
IRQs than required you'll still be able to use them. The legacy IRQ
will be also available in case if MSI failed to be allocated.

-Serge(y)

> 
> > 	
> > 
> > > > > > +	}
> > > > > > +
> > > > > > +	plat->rx_queues_to_use = channel_num;
> > > > > > +	plat->tx_queues_to_use = channel_num;
> > > > > This is supposed to be initialized in the setup() methods. Please move
> > > > > it to the dedicated patch.
> > > > No, referring to my previous reply, only the 0x10 gnet device has 8 channels,
> > > > and the 0x37 device has a single channel.
> > Yes. You have a perfectly suitable method for it. It's
> > loongson_gnet_data(). Init the number of channels there based on the
> > value read from the GMAC_VERSION.SNPSVER field. Thus the
> > loongson_gnet_config_multi_msi() will get to be more coherent setting
> > up the MSI IRQs only.
> You are right!  it works well.
> 
> 
> Thanks,
> 
> Yanteng
> 
> 

