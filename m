Return-Path: <netdev+bounces-210519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA23B13C8F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7773A350C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EF26CE21;
	Mon, 28 Jul 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJSwV6Bh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87F7261C;
	Mon, 28 Jul 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711006; cv=none; b=OvlxQAFTw+g4MJ8eE24cKPIOV/xldUtAu5ImoPShC4MwxTzxSt7/zpQR3Lo9PJHXKpoXf0Kfe88UIhvhbgBePU9AkAOLtbOMof6vNoYveijwUWCskSZr6SetimK1P7sh3mnSArZp+PWKa4dRm/C5hf7LcmM2MDb95jR0n2/n2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711006; c=relaxed/simple;
	bh=Yj+5izj8Mt9uJqcA+pwBtpmYYGEAxnFMMaHSgbYMwWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byMi+tQF5NAx1GukhFhg5hFiFxUVTqsWmGokkC7/IRIUsio5FJcndSKguNq2VWrlOJ1FUFIf/UoEzvyTdKSzBeC5Ui0gpbHQo2jH9jKOHV3TqPJ6UQkg1Jft7hH+qve1i2yE9mcUYqL2o67vnPjDf8Ic0YBH4Zst5mB2LbeRfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJSwV6Bh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-456065d60a8so3963915e9.3;
        Mon, 28 Jul 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753711002; x=1754315802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IG2cga25LP6ZPuVt0z2STMNNsIhvl1pufwSwAK8ecLo=;
        b=IJSwV6BhPprgFhrtwECYXgbHh84aFDZt5d4Bv5QCaJTPnvzjAARuIROHMF1YvZcZlL
         Rcwtpo7dZwVsvWDfoRfKqx6BLmvHHTLXZ5I882Rivi1Ht04x6+DlttC4fhkqQNXbR8Cw
         Lcle8CMJyIWQSy/CD1lLjUzbzmp3lq8wsjlG72Wf/W6IgH6R2IUBavdWqqgSbP8WBiWu
         NSHGrtvxqkMszW1kDPPZKsy5NC8wLHKSncE0Eg+1phY8X3DL2AXJIr21KaZBfMcJ4dzZ
         BbLnvn7eaX5Q+4VpcIZj177J4ff6E0esQ7rTnyRIyFzMQYmm19B8tlHW03A4gBfgHq1I
         uhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711002; x=1754315802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IG2cga25LP6ZPuVt0z2STMNNsIhvl1pufwSwAK8ecLo=;
        b=qIfCRTduM7JgNIlf+19Cz7HkKdwH0bau66sANfPZRHQWm11SCfwNkUxuZhQ55vQLi1
         dzpoAkQiVmP/y3Up2RU3Ld41ZnH/2x0piSPNPwSULiRS/6CleUK4aDBNpvJmoGf38yug
         APOanAnQnqvVPkLSqKukWSTX7kUhh2CBiHAD39B11NBNWtAF9O0IJiETItO0fCS4K2lt
         e9Q9VSGKJ1sS5co0dCaQJnIRfrWrnaKJXs7jJ59gAzHkHiSQatknDz+p5oLFd+jTluBy
         uBhjsiEfhlwRI0CCCv4lPVQcmmQH/Xx1Mpw5pW1T/PRz3g/b2aQiuQEZh2Jvc9xeScRu
         TWrw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/ozbPpCD59g7x2tIj/3OO0X3/pj1joFmxTtnKXpuuNE9n05evw66VdS3Ac9maX7jglFa4LRb@vger.kernel.org, AJvYcCXRv2tz18SSnpYrZertKme7MQD6doFvg29AfZwTy/E1aFDCuMNM25LV5DavCmaz70DA4QymLunJTimyrOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjbQj/w6wlD1U5ZP1bx5uXJYuacSLLhQ1asy4oPwASwj1HADj
	sYQPsvkpj9y0Q5CM2N6IIlHN+CwliUwkzKRArj5CfGdRfC/FsU2TS0g8
X-Gm-Gg: ASbGncsY6FVhAu9eApAw18H8IFg/t/cxIqXcA/8Xo5f7Rp1NVEZm3YecffMsETfAnEz
	QVjUnzLu5dzxSOw+lAurkGb5Yf/Yd9Xn61IwThZaUl8yRxYoWC9tQTPnkjLGGTQsMYWtMWFRyyW
	shS5+OXFMOAlxZN8KIHgEL7lOuzDg3/UFmDK+ZF5Ot/P/bd6plOwxQZD68kS8IyJTjF/1doazPn
	wRDrjUgOGkGu9T2zgHCfrMd0gJK7S4S15nJzpnL2Eb59VLgvbIMrom6Zgr8ubx+2RGjMIBHABz6
	Ogj5Ak7Yi88NvbWSRookGM/8d/rQCJcsK477Qk4aWQQWYxlSLEvQ0hOh2HLo9vYfka6/ANaQzbp
	Vy77CmxWqqr5Vo4/X53lOARDLey8lDHgK1S/WbI62llxLSU7NFZIYhfQmYKHl4+ELi2sW
X-Google-Smtp-Source: AGHT+IGkZJ0Ic6sg2dJlYiQQQzQ55W+RUIUNJxxRy+p/h7Xai0zbiSZgULA8th8fzmAbAnq2ongyMw==
X-Received: by 2002:a05:600c:4fcc:b0:453:9b3:5b70 with SMTP id 5b1f17b1804b1-4587665e19dmr37574035e9.8.1753711002143;
        Mon, 28 Jul 2025 06:56:42 -0700 (PDT)
Received: from ?IPV6:2001:660:5301:24:fe77:9d9a:a12:ac83? ([2001:660:5301:24:fe77:9d9a:a12:ac83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377e5sm157800215e9.7.2025.07.28.06.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:56:41 -0700 (PDT)
Message-ID: <ab715726-77e2-4af7-bc1d-98a92a653617@gmail.com>
Date: Mon, 28 Jul 2025 15:56:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: nixge: Add missing check after DMA map
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baptiste Lepers <baptiste.lepers@gmail.com>
References: <20250725133311.143814-2-fourier.thomas@gmail.com>
 <CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com>
 <20250725081045.34ac4130@kernel.org>
Content-Language: en-US, fr
From: Thomas Fourier <fourier.thomas@gmail.com>
In-Reply-To: <20250725081045.34ac4130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/07/2025 17:10, Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 06:53:16 -0700 Eric Dumazet wrote:
>> Not sure if this driver is actively used...
> Like most of the drivers that are missing dma_mappnig_error() :(
>
> Thomas, would it be possible for you to sort the drivers you have
> reports for in the reverse chronological order (when they were added
> or last time they had significant work done on them)? Start from
> the most recent ones?

This is already one of the most recent drivers with missing 
dma_mapping_error(),

I have patched the missing dma_mapping_error from 2017 onward that I 
could find.

Here are the drivers that are missing a dma_ampping_error() that I could 
find sorted by

the last date in their copyright notice:

2017 drivers/net/ethernet/ni/nixge.c
2017 drivers/scsi/aacraid/commctrl.c
2013 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
2012 drivers/net/ethernet/rdc/r6040.c
2011 drivers/scsi/isci/request.c
2010 drivers/tty/serial/amba-pl011.c
2010 drivers/net/ethernet/neterion/s2io.c
2010 drivers/net/ethernet/micrel/ksz884x.c
2010 drivers/net/ethernet/marvell/pxa168_eth.c
2009 crypto/async_tx/async_pq.c
2008 drivers/message/fusion/mptlan.c
2008 drivers/message/fusion/mptctl.c
2008 drivers/atm/solos-pci.c
2007 sound/pci/sis7019.c
2007 drivers/scsi/initio.c
2007 drivers/scsi/esp_scsi.c
2007 drivers/net/ethernet/tehuti/tehuti.c
2007 drivers/media/pci/ivtv/ivtv-udma.c
2007 drivers/crypto/hifn_795x.c
2006 crypto/async_tx/async_xor.c
2006 crypto/async_tx/async_memcpy.c
2005 drivers/scsi/megaraid.c
2005 drivers/net/ethernet/chelsio/cxgb/sge.c
2005 drivers/net/ethernet/dec/tulip/uli526x.c
2004 drivers/net/ethernet/via/via-velocity.c
2004 drivers/net/ethernet/sun/sungem.c
2004 drivers/net/ethernet/marvell/mv643xx_eth.c
2003 drivers/tty/serial/atmel_serial.c
2003 drivers/scsi/ips.c
2003 drivers/scsi/dc395x.c
2003 drivers/net/wan/wanxl.c
2003 drivers/net/ethernet/sun/cassini.c
2002 drivers/net/hippi/rrunner.c
2002 drivers/net/ethernet/ti/tlan.c
2002 drivers/net/ethernet/alteon/acenic.c
2002 crypto/async_tx/async_raid6_recov.c
2001 drivers/scsi/53c700.c
2001 drivers/parport/parport_pc.c
2001 drivers/net/ethernet/smsc/epic100.c
2001 drivers/net/ethernet/packetengines/yellowfin.c
2001 drivers/net/ethernet/natsemi/ns83820.c
2001 drivers/net/ethernet/dlink/dl2k.c
2001 drivers/net/ethernet/dec/tulip/winbond-840.c
2001 drivers/net/ethernet/dec/tulip/tulip_core.c
2001 drivers/net/ethernet/dec/tulip/de2104x.c
2001 drivers/atm/he.c
2000 drivers/net/ethernet/toshiba/tc35815.c
2000 drivers/net/ethernet/packetengines/hamachi.c
2000 drivers/net/ethernet/fealnx.c
2000 drivers/net/ethernet/amd/amd8111e.c
2000 drivers/net/ethernet/3com/typhoon.c
1999 drivers/net/fddi/skfp/skfddi.c
1999 drivers/net/ethernet/3com/3c59x.c
1999 drivers/atm/nicstar.c
1998 drivers/net/wireless/intel/ipw2x00/ipw2200.c
1998 drivers/net/ethernet/dec/tulip/dmfe.c
1997 drivers/scsi/aha1740.c


