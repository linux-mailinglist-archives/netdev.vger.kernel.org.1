Return-Path: <netdev+bounces-153110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99B9F6CCB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F5188B4A7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C41FA8F8;
	Wed, 18 Dec 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMvDCjea"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834951FA270
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544727; cv=none; b=A04XGPaXmOKqhb/ZYa1UZmueqLb/Qetei4bquYUMuUrNL4Q6Ch5d0jeq5tqp/3mkxIOQu0DiDnPO2uey1z2trpmfyXo0CjCXgvK9tsQDfEwwxklf0+EEt426yvqLQk2JSsXrMfdRJ9C1kQOGa+4gdwryvdz2ak931RjFaRmf/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544727; c=relaxed/simple;
	bh=0Dv23YWi/monGunIVsBFt2V4sdvkJaombJ+zODDYVFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr6hurqYddPkK3pzWxV92A09O7Awf+GQ++RN454IoUwXviVW4+yEcSQZApNEnaGHs8vE7s1nz+7HWXmYOcBSLRwIOASecESuPE7wBf9gZU5aLSXN+agvo82w6bYd3m/xZfSC7F4xRecGHkBV9Htz0LVS1qiWalVSoYYtBRfbIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMvDCjea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734544724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Dv23YWi/monGunIVsBFt2V4sdvkJaombJ+zODDYVFw=;
	b=BMvDCjeaFB2ufYUCUNOxkdbf/csbyN0qS1ALUuK0a0CeG0KPOn92zr0c3ADVVDtebG9vSb
	qjLY5CmF1mALTLjlOP2IPhq9nuOCuREpNIUwD80QnTnW3b867VIQYh/vnR2HcqUw0hMnYa
	q+ooDKg7bQ3hY+j1K4G2EHaip3yb374=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-HUkfyrNXNUGjyRk9HqjSEw-1; Wed, 18 Dec 2024 12:58:43 -0500
X-MC-Unique: HUkfyrNXNUGjyRk9HqjSEw-1
X-Mimecast-MFC-AGG-ID: HUkfyrNXNUGjyRk9HqjSEw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so30474685e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544721; x=1735149521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dv23YWi/monGunIVsBFt2V4sdvkJaombJ+zODDYVFw=;
        b=JJaLF07kwoiz9CImmPfP6w9bnT4H+WePCBSC9wuCHFDWBWh38ger4DA6Kw9qCejGTS
         u9rlgjWXxp+hW8qEmV3pm9BPZyapZqvC0ql6c0XO256etL6P/zNqKh8zZpL6MLmBZ93H
         5iYLV4Lv0yetAXYGT61/9KYnpveQMyzPYF6WxSytB+l4q+zlnwWQJg+lfDie6RRmNsPb
         gGo35hrdtwx/hfu225dx1vlfSX4H2lS61p6+72jmgo8sPNKVInIaro/Bjesk+15mlm0i
         mMgH6JPZ49hFDncjzg1kz1xQ94OkXysDFU9rWB5ojg+SB7j3Ob6Hwb8zDS25xaZAhO1g
         DVtA==
X-Gm-Message-State: AOJu0YxxoYs1yp74BiihuwNu1X1+vDPUyad1vGg/N9Kbj9af8L688FOD
	AgQ8lVabH07gPnDJ+DEPEb6PSgJT5LQl/PuvSmlWshZddonnImZidsVtNvGNHsVQj/yYFigw3Ps
	4VuHwCOvqlbTiJQI1j9y9NAe9gfEjotAl+vYY3OUdeAwGPILA8aGnS88fF+jRNeie
X-Gm-Gg: ASbGncuEkCGbBZTHetZ0tBsV2BNCoRV66lVr4RZPivV42HFFHHfxG4O/oLfdxtqYfEG
	8asSxHBnlSL+P4rtfVWL78EUZbACkFFKGrP2OM+bCRWXWa6Fyv0+tgSGzDGfKra2nyGP5uSjatT
	B1sxKERz3C4KoAbqEFR0ul6hBJ9u8qXR3bfglNecVlYQ4MVlv+fIynC3xOdHpuORWAtest0sNGK
	jq/UP3k1zXDpCaZuFffIERhpZ2YI2Icb3tit4SXILVsBhHL+TNqRBdA6lNzMbS6tsKnNSg7f8Yr
	32guebWCr60twaqMze5+aCenV8DxmbpY
X-Received: by 2002:a05:600c:1d0e:b0:434:f623:9fe3 with SMTP id 5b1f17b1804b1-43655376cf4mr37522245e9.16.1734544721676;
        Wed, 18 Dec 2024 09:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES/m4ms8Dsl4HpnDu1B2TdTM/g4zN1t13n/hgaMwRBi8t71hCJvIrDnwfy0AE7tK+rQ9mjZQ==
X-Received: by 2002:a05:600c:1d0e:b0:434:f623:9fe3 with SMTP id 5b1f17b1804b1-43655376cf4mr37521925e9.16.1734544721026;
        Wed, 18 Dec 2024 09:58:41 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b2afsm27744395e9.35.2024.12.18.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:58:40 -0800 (PST)
Date: Wed, 18 Dec 2024 18:58:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 0/7] vsock/test: Tests for memory leaks
Message-ID: <5cznhfgfnie3nves5bmxn2djchinlsp6jvdaxguhlbs7h5ndhe@vbhx5lvockmj>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <03ae1a3e-9dde-4cb0-b617-b03bcaadab64@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <03ae1a3e-9dde-4cb0-b617-b03bcaadab64@rbox.co>

On Wed, Dec 18, 2024 at 03:38:17PM +0100, Michal Luczaj wrote:
>On 12/18/24 15:32, Michal Luczaj wrote:
>> Series adds tests for recently fixed memory leaks[1]:
>>
>> commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
>> commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
>> commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")
>>
>> Patch 1/6 is a non-functional preparatory cleanup.
>> Patch 2/6 is a test suite extension for picking specific tests.
>> Patch 3/6 explains the need of kmemleak scans.
>> Patches 4-5-6 add the tests.
>>
>> NOTE: Test in patch 6/6 ("vsock/test: Add test for MSG_ZEROCOPY completion
>> memory leak") may stop working even before this series is merged. See
>> changes proposed in [2]. The failslab variant would be unaffected. [...]
>
>Bah, I've added one more patch: "vsock/test: Adapt send_byte()/recv_byte()
>to handle MSG_ZEROCOPY" and broke the numbering above, sorry.

Not a problem at all ;-)

Thanks for this series again, LGTM!
I reviewed all of the patches and tested them.

Stefano


