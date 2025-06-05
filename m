Return-Path: <netdev+bounces-195251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D796ACF0EF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6DC3A24F4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C725C813;
	Thu,  5 Jun 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="DttgFVns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0402494F8
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130839; cv=none; b=leEsfNatN4fJpl41JbR6JOJSia24C8YWZ4XkKiNXd9wKygNSdSoY0QPnk+2NYD4qAIR4L9nGlE+CiRhvr8bU+byok6RvWSuJ2X2cBCZy1pC8CTl2uIiZVhwH+QzKajPf19abmh6SIST3IbuKVtkY9k/V2OUHmLuZZWV6Fu8r/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130839; c=relaxed/simple;
	bh=iHIzoVdsgUinoZ8BmsUrRbKp3He5F7VRvpO1K9lEvKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uiFxbiRV+4vA77C0fuYJXccL1bBqSLhcHDHkoCAJ7RUt8F5dpMHGhZABNrYUoJVVqTJJxdHcfqRziDsbKoRWcV8dbwA+Iq4Xzer9gMluU3uLLt+TkQey7/bL6YdyYglXY9TF0WYcjDyJNupvxsI0Wbzn64X/HrzoD/Csz3I9pzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=DttgFVns; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so160573566b.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1749130836; x=1749735636; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dquXSD3f+mF944uxid9rtpogR5b2YO3NRGhOoE+P3gs=;
        b=DttgFVnsp+vpbC7D9o1vmmyOIJjriQGT8XL4KFj7OKjhV6RplonnJk3mfPbUBAU3wJ
         Qv/tLc4VXSBuBNT2tmVsFZmPwHM7RKHjJWWhJ2M4DvCLhHb/SIutok7NGWBIYMFh3N/6
         S68+JyP2eyvkteUMSsyWCnSbM9xx7T4+b3Ssc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130836; x=1749735636;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dquXSD3f+mF944uxid9rtpogR5b2YO3NRGhOoE+P3gs=;
        b=JTkLOZHJF4wXcT/XxJY9JbMH4HMaKBuev0c03WX5Iq07BasuR41TtQygcTydRFzWKi
         P098Siolt7rekvb3a9wlsWOk+VZViwP8Rs41888W5kkg1jWs5PXM3YqvNaK7lVIBur08
         iEqbcgbbTbP2n11IKTtKd0HWuVZV9GS3p/3f/sDLZSGczgiMQ221oduKspT/pyygM/rw
         Us/fPDx3YxWoxIuiYAFPZ13jOCl0dq6fg+vN8lsfqdVjwMC84oZmkUBl2pSdqJm4SCfc
         yJcRucMMzvKIOP9/iPLra4+CgvV5B4ruECv+DM/eyp4FkWn7Kjt6eAYXMJnDxlCVY09+
         8bMw==
X-Gm-Message-State: AOJu0Yx8e8OdMwU1ljsiBjpLOt6VKgcgoEHYRaIg06JW1MI2lqstTMei
	KJ/FVvnRxePisCRK3U0RF44g/zxj1NYfkukGgztnr7FHI6h/4tSCwj4SXa64ZlSDBbNRA47Z296
	OoosaSHI=
X-Gm-Gg: ASbGncuCEnhhtmhNp0f47tmU3QQwBZ3HomNEU+QH7nakjFkOfADIV9Oj/3KJJdwZqA7
	T9hMCzY2P07K0bccAwl8scW6BsG8hZiOdQvzLuuYVM8W9WvyH42WP0TIm26X8DaDuy6ITmX6psx
	/KxYBzmLClH9qMd9r/U2ZNVGnye0UBi/LcGqr62gKwJiUNCVb5Xs28Jcn7SMoGKK1VoSSTTurGS
	Nv6Aj6XG4tfdQP8/G2GMeJOozUOcgpLrS+BkBQ5t7b+Qel+K8ySOdggzouofOULF3VeLcuU/ECC
	OV1MVS3DcLB+lirLCN4iM5vxH1pVPbePPb6zVkqXQ2NacFg5aPM2xOTafhrLQNHtuNEERcqo
X-Google-Smtp-Source: AGHT+IEREIje3v2Hq1PcwMkHBac9ZyQHKMo+XtGQ+4HAwjNL/dcCiapUwoLffvMHf6Mabx1QiIU6VQ==
X-Received: by 2002:a17:906:dc8d:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-addf8caa363mr658709066b.5.1749130835587;
        Thu, 05 Jun 2025 06:40:35 -0700 (PDT)
Received: from bender.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39420sm1265773266b.136.2025.06.05.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:40:35 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:40:34 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: netdev@vger.kernel.org
Cc: Jerome.Pouiller@silabs.com, David.Legoff@silabs.com
Subject: wfx200 weird out-of-range power supply issue
Message-ID: <20250605134034.GD1779@bender.k.g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hey guys,

Apologies if this has been asked before, but i've searched and didn't find
anything related to this problem.  So here it goes: i'm upgrading the kernel of
a custom stm32mp15 board (from v5.4 to v6.6) and i've stumbled upon this when
wfx driver module get loaded:

wfx-spi spi0.0: sending configuration file wfx/wf200.pds      
wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -20
... a bunch of "hif: 00000000: bc 04 e4 15 04 00 00 00 ec 00 74 76 f7 b7 cd 09" like messages ...
wfx-spi spi0.0: time out while polling control register       
wfx-spi spi0.0: chip is abnormally long to answer                                                       
wfx-spi spi0.0: chip did not answer                                                                     
wfx-spi spi0.0: hardware request CONFIGURATION (0x09) on vif 2 returned error -110                      
wfx-spi spi0.0: PDS:4: chip didn't reply (corrupted file?)                                              
wfx-spi: probe of spi0.0 failed with error -110       

Needless to say that v5.4 kernel setup works fine.  The only difference with
v6.6 is the wfx driver and kernel's DTB.  Now, i've verified that wf200 is
powered with 3.3V, in both cases, so that's not it.  I've also lowered the SPI
clock from 40000000 to 20000000 but it didn't make a difference.

By looking at the driver i'm fairly certain the above error is actually coming
from the wf200 firmware and the driver is just printing an error message so i
don't see reasonable ways of debugging this thing.  In short, any suggestion
would be greatly appreciated.


thanks guys,
Petko

