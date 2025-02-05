Return-Path: <netdev+bounces-162940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C6A288E8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B693AE9EA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC98151998;
	Wed,  5 Feb 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvO4xMe5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B0151996;
	Wed,  5 Feb 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753231; cv=none; b=QXvGnGfVfcn4memHEf/nG3Lao6xs8Spq3+6VuP+Z4tx+xgIlZBB4nIqwubQVoMcF58ZmlU4S08OAEeAb9rssJEvObv3kCb6IZO+eAGowpH3DiPfzr2fUBeVdguDyxzEF3svECeW1piJMjaQD/sskcpQyuBPjtyheRv6abAoENyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753231; c=relaxed/simple;
	bh=ggnuHh5JOOSCJ6LLQ0zuX0132brvaETBrjf3g3m+GmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKDHrXehcXo39VoTS/S4k14Yjr8QPXVHCIfk9xi7yvfwFoDCyP/SRpxitQCMndikzCzMQOxe0aMtzrYP+D5GsTW0sDUyqHYyHxPIca+21JKqwpKWMiQk78vX2dm0K/zcB0hmgeoVMMY8qrWbIaoJCaKf3ZYSqqY0izt9/yHpqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvO4xMe5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so132766766b.0;
        Wed, 05 Feb 2025 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738753228; x=1739358028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSjdJz/xDA8mb42ayTcwdNMNuepVYnt3TrZB/pvMUoI=;
        b=RvO4xMe5WjxZzGTC1pf1axeLdTV617XE8F087deLMx3HaHzChky7sh5Aye/StlXHUq
         M+im9pOYozpXRYV5saTxIFatoz9WY2tp7IZ+B1ktG1ybQ2XpTQzpEmv+5iQMgnGO3OB0
         VR8njr52sV6NgdIHCbeSaqA7inF7NJSTMryTzKnbZd4kTkrgccemGFinU25/WNP1bCGe
         GofHPm3jalZ4Wfllo6wDxs9GM08e4m3+Ns65G/yaQrMtqjxj478YFGGdrJpqwfTZLQWV
         74H9Di0DRhE2hKb6hmy3bKV/Th5f5ycoj61O3k69GxDkR3egZ2AdQvScaOY/iI/XNKLN
         n+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738753228; x=1739358028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSjdJz/xDA8mb42ayTcwdNMNuepVYnt3TrZB/pvMUoI=;
        b=OWE2Oqo/+rMmNclfbAmjQ6h3ZgjzJdMP8YS74mpyVKVUl6FDceF+W1Tz2RDcyRwsRz
         hOBpo4H/onhELdMzUKybbzOnGHM5i0PftkIUq2cJm5hkJZDxSrB4JJNk3izkbHJzEDCX
         Hi/YxBtxCa6CkQ8fgmYuu7a77Uk597IzdzQDsyVFAGRy9/F/bguCWxr/khGfutG+ufJX
         rnhHzb+uOSJMpeGGjDzIZKjZUF+RU2CEWwVHm4FPfg6eW+jXuvKPvMej8aV/umM4G+fQ
         pJpMZq7DPJgx3JGoS8W+dJavK9exth013FqKw9a0JL31OltLQH+BFJlq2Qr910SiieZ0
         jtSw==
X-Forwarded-Encrypted: i=1; AJvYcCW0GCUPbU6QJp2Qd2Ioz54NGw/DN2aWFxMMeMmRgW90PEcQ12BSGcc8vUf2nN4U0bNQ3m6Q2ITpPuUmdAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2Fc+1s+A0vkmuDAKiRa69gufbN5fMlnwnu2es8NjezBNfUkN
	MgrqYu6i9Rz7GxbljYGnjmehGN+kawJt/7M259MVndfR5k6LPk6KEt4pHq8oMpHvZ5yR
X-Gm-Gg: ASbGncsPcbydoXo+IEPw+5b2KSumnJeEnQkz+WEzEodv6TWTX84N/m+Hq+qRiLyeiAI
	f8k7GS1gOQKSW+e0hpea4LoMYhbdzd3peH27rKTeS7jYVCIVcRHEjgYpD5ufu4U1UkdBcGIl/o5
	T47L60z1NdznLVdN78RtIgF5LrS4WiVYJIv9IKnLxNIXHtH/+MRfq3bHdzm2O+SrKBy05Wh1dwU
	Q595wtfbw3RmzmMhZA30HutRo8zguW8RaTidNoDLLn1xsMffd7awt3wYKlGIXKE
X-Google-Smtp-Source: AGHT+IEVVg0kE39/wjtj8sTo6fT9WkDtB7UWVHKKZ58CONt1w8Vq3ELLHVci1DsLegASlf42WxQH4w==
X-Received: by 2002:a17:907:d90:b0:ab2:f255:59f5 with SMTP id a640c23a62f3a-ab75d2a9fe2mr249002866b.16.1738753227771;
        Wed, 05 Feb 2025 03:00:27 -0800 (PST)
Received: from m4.lan ([2a0b:f4c2:3::65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a818csm1077061666b.6.2025.02.05.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 03:00:27 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1tfd8q-0000bq-17;
	Wed, 05 Feb 2025 12:00:24 +0100
Date: Wed, 5 Feb 2025 12:00:24 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Jason Montleon <jason@montleon.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
	"si.yanteng@linux.dev" <si.yanteng@linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [REGRESSION,6.14.0-rc1]: rk_gmac-dwmac: no ethernet device shows
 up (NanoPi M4)
Message-ID: <Z6NEyCRHTVfnM1vf@localhost>
References: <Z6CfoZtq7CBgc393@localhost>
 <INKEBRCGF47MsjO5WHpLcf1OTcQHw2KG6_Ez-K9QiTwAnb4MRVErnxoUT1euX_o9oRrxUILDRDvlOZ7ezguCU4maUyvkk-UqU52l6xLsF8U=@montleon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <INKEBRCGF47MsjO5WHpLcf1OTcQHw2KG6_Ez-K9QiTwAnb4MRVErnxoUT1euX_o9oRrxUILDRDvlOZ7ezguCU4maUyvkk-UqU52l6xLsF8U=@montleon.com>

On Wed, Feb 05, 2025 at 04:19:58AM +0000, Jason Montleon wrote:
> On Monday, February 3rd, 2025 at 5:51 AM, Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > Hi,
> >
> > This morning I tried 6.14.0-rc1 on my NanoPi M4, the ethernet does not
> > show up.
> 
> I am experiencing similar behavior on the Lichee Pi 4A with thead-dwmac. It works fine on 6.12.12 and 6.13.1, but with 6.14-rc1 I don't see these last several lines of output as in your case. I did also see the same new error:
> +stmmaceth ffe7070000.ethernet: Can't specify Rx FIFO size
> 
> It looks like this message was introduced in the following commit and if I build with it reverted my ethernet interfaces work again.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/stmicro?h=v6.14-rc1&id=8865d22656b442b8d0fb019e6acb2292b99a9c3c

Confirmed, reverting it resurrects the ethernet also for me.

Thanks!
dom

> 
> Thanks,
> Jason
> 
> > This is the diff of the output of `dmesg | grep rk_gmac-dwmac` on 6.13.0
> > and 6.14.0-rc1:
> >
> > --- m4.ok.log 2025-02-03 11:37:03.991757775 +0100
> > +++ m4.nok.log 2025-02-03 11:37:17.249455484 +0100
> > @@ -15,4 +15,13 @@
> > rk_gmac-dwmac fe300000.ethernet: COE Type 2
> > rk_gmac-dwmac fe300000.ethernet: TX Checksum insertion supported
> > rk_gmac-dwmac fe300000.ethernet: Wake-Up On Lan supported
> > -rk_gmac-dwmac fe300000.ethernet: Normal descriptors
> > -rk_gmac-dwmac fe300000.ethernet: Ring mode enabled
> > -rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via HW Watchdog Timer
> > -rk_gmac-dwmac fe300000.ethernet end0: renamed from eth0
> > -rk_gmac-dwmac fe300000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > -rk_gmac-dwmac fe300000.ethernet end0: PHY [stmmac-0:01] driver [Generic PHY] (irq=POLL)
> > -rk_gmac-dwmac fe300000.ethernet end0: No Safety Features support found
> > -rk_gmac-dwmac fe300000.ethernet end0: PTP not supported by HW
> > -rk_gmac-dwmac fe300000.ethernet end0: configuring for phy/rgmii link mode
> > -rk_gmac-dwmac fe300000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx
> > +rk_gmac-dwmac fe300000.ethernet: Can't specify Rx FIFO size
> >
> > The configration was updated with `make olddefconfig`, as usual. I
> > could not find any new option that I might need to enable, if that is
> > what went wrong.

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

