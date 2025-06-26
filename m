Return-Path: <netdev+bounces-201662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA45AEA43A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E22562987
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC342EB5CC;
	Thu, 26 Jun 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzQmK/lM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571302ECEA6
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958012; cv=none; b=W6cGj2MzOjI05kqlCWAtoBYXh2mC8S+4qfTMr1RxmnXr89Dk9sFYDxsMJiWO4un8SbBoRE8ZRAXj5ztZrLdvbHNKnTi/SzMkGiVGC2Nhg+tAk0beNXilrqMSkvdN0DfachCvyDf4YLDcdZ392UWHTEVdMRpWVZcn7xS5GxQxmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958012; c=relaxed/simple;
	bh=ZNHXEtJ0/7Wjin9NyDfJ2mvMBuoYNYE0UAKv1ZoFR3Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bb4mphdleyMNyZQ0202aUqiJPGobYx4B2nlBVQewG4n7BdyqMlUT3/NTKkBCCWrLOi2TDlXw2deOu1fDJWm1WNvJMHyvZuoLPA5KEvZGP80JuqdntIaIbeP6WgRGI2P7ltzmD7m20no7Ohgwhn1DvtFwvQDQU3l4NNfAE/hly7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzQmK/lM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e447507a0so10620467b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750958010; x=1751562810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC1Yv3NMZawoQIRSNUMgquzlpouMmlSswPoNSjHM88Y=;
        b=DzQmK/lMAhDvC4W2rGzuusdJN+B7HIIWae7XUGyUTR8dLgWl2OauDja+Ta8R6JJfVr
         6mujL5b/7fRqkOrXSRQSDr2eqrBvPjdNniSn4f9X2ss+QM21b3fcpLhHzIyrFsR/uC3n
         sb1wRVyeHRfkAVwMV+kmZnsCZeqGVmGYEA37K7tdCPyw1QM9TMy1f/7lAZk0INh9HtBR
         qvlM6QJD8JZ2Q4tN3AzqSSKFU9cGiT5HpdJtac5IJcQlo57fyJRe83ggod/5Wk04Sp0x
         2V7yBDcV+CMtWwY4Q8dLsuFn3GcrIrYdNGsjbEVhKRwklbbe8JbaIrcUQ+BAqzlJNWeI
         vCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958010; x=1751562810;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UC1Yv3NMZawoQIRSNUMgquzlpouMmlSswPoNSjHM88Y=;
        b=E51Xqhi5HqzXDo9Z/S/RBoER6QEXZMNx3OeYt0wN65ocmqAj/WLxuKE/71KuQk+bb+
         tH0JpbvaIkxMHR4KKaAoBQtvu3G0IogSgZt2OuME3l/0cLUAaiZpfNBOQOh9GOfqiLW/
         heQK1pLPvuv3I4pTM7DfRzsW3wn9rtAJROpjoFtZWN+JhGmBD8+Ns98FDIm5bi0TKvYD
         eWEEssyu57DdQex9H2E2b0HecScUvXkq11WrtCjpf1rmpf0JdC9L+L4ZUQ9cwNHdino6
         cwSmjk3koAQA4ExSbBFLC70h23TtH6ATkEnauDezdlz0sEA9pSsUExvtuhk2LM43oeU2
         DhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLEiL2dBWrMeta5KQSyUazy/XvBTfmUUzn5IV6ng8Bem3gFndDjLGBZVStagFJyGnB6YrJpw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36xja3bvLEF/tKDLjV+eZyp12mwCsE7Qeu5NDjxR7mGT1ba6E
	y28vtIn8fNJXQakB/UJXQOHIY9cpnq0riHPJs9a3sMluWUlI2NtSjrBTCzVkNw==
X-Gm-Gg: ASbGncueVMWQzaxb43p+CfYi93mgKcdoNEIBAgmvHG6s17WxQEyJVnYzijZmbALKDbJ
	UM1NfPQR94V21k/0gnAmrErbehF7l1LVfMis3JGSQOK8cm91/EoYvzDKP0mUmmdzwd2+ckl5k1o
	Iw3dq9QqdUdMQlAMkH2BCygyiqueZApbPEk6WkS5Nvio21hIOc/TLqXktQ2wecaJ/cmJAvXoQSU
	DJdx4GlTWVn8QcmEP0W9FAA1mXmmjQVI4nGEOJOv9OIXfzvBwbrhWR7Au9eMabDrmamc0h5rVvp
	1DmC9i8/3ps5nRSUAWrEKkgRVkCM1Url142FLxcDFTaqcE7thk0/dvymEPbHWsI3MqL/au+/Bqz
	O7kXa4HHFFm6+ueVwJSwO/Y494QZ4MA1L2CsMgBhMszMUohLaXoxa
X-Google-Smtp-Source: AGHT+IHRnSHTPadMkbjvZ6K8Vh9M17Ey2NRrlcN9dlyveHWO80nxCRw1EZeLYc2pWl9ePHD/T7N89Q==
X-Received: by 2002:a05:690c:3583:b0:70c:d256:e7fc with SMTP id 00721157ae682-71406dd1946mr114554837b3.21.1750958010146;
        Thu, 26 Jun 2025 10:13:30 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c040acsm713267b3.38.2025.06.26.10.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:13:29 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:13:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <685d7fb87e1e6_2e676c29436@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250623150814.3149231-3-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
 <20250623150814.3149231-3-sdf@fomichev.me>
Subject: Re: [PATCH net-next 2/8] net:
 s/dev_get_port_parent_id/netif_get_port_parent_id/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> Maintain netif vs dev semantics.

This is quite terse, when landing on this patch with a git blame.

Can you repeat the helpful intro from the cover letter, or point to or
quote the relevant paragraph in netdevices.rst?
 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

