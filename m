Return-Path: <netdev+bounces-138140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557719AC215
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1623C284431
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226B157E82;
	Wed, 23 Oct 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBA6G3qd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B55156238
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673220; cv=none; b=YK6kCQvU+Dyevz+ORKBvuuC8lcIEncucdnYA6SbE5Win7HA1BtDNQWGmCO4/qrbMVny+PFsLfO7B47+4GU4Qzqk+OwrL0asveDbIXoQdN/p8RIrlpHS+ReZbcGAfbMdioAHB2Cuwg7eWw8as9n2jvZwhzreJEuH+Y/Czis+Qclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673220; c=relaxed/simple;
	bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EpHJlyR9CQrGesZv3f6uf1VDe0gU0rl2HjsRPubld5EoqvodTML+e+exnAdJgwt4h8QXY2IkeNrqgSAGjf/E96knOJZ84jBkIDVlSiXUjMgUFz/r/k+E5GwgSuTqXWhBqUY4d4NZoPFXNxlMFRCGbrpsITt3K/Eq0AbrtwSucV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBA6G3qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729673217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
	b=eBA6G3qdAOMzrlAS4OqX6g9ZIRXDo+EjM6n4Z1chAqK/dpvlOrhK0x4AEDdFUinBZNM1FG
	m3ldCA+jlaB3UrayepW5TWIkor2Tp7L2sE2UumkPMNhNe6YE8t2HIVGZEVKQ/HZ/LN/BKR
	1C8sNj7yvszLsIP1aWzZ7yj6Ei57298=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-CcDxVh45NoGpiASVJ02Zpw-1; Wed, 23 Oct 2024 04:46:56 -0400
X-MC-Unique: CcDxVh45NoGpiASVJ02Zpw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so3266241f8f.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 01:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673215; x=1730278015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
        b=W7IZgvi+ZZZRj8gLSVwbKfaqBMGt4m+89Yu54L+LrO8QM2xlgiolOM2AFM5K0kmGzB
         aDT/b8fPM2lklvFefQWA776L8jEZNcKwNnFcWGr/2r8kqaX3lPatL5QQO/62qvLclKYC
         wNiSqXj3B2BkmiXK7yU5SyGzlJfErBZ8y/L0mEelT3arKx6dbTrkJv73z5oTVoXHoeKB
         8SwTlzM1VrNMdAw71bNgh8WD6gVfE/aX54lzYSb+E4ZVxE5DkZeSj6G1m3x8q7vcxG09
         qM5gXr3Amqo4vzPeTTdryl5vY/eu2JGPE7kTf9hNeCWviiWGcMRpSp5k1SPYg+prSUkK
         hCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY4yjuzsBQa19j8gA6Q8mFqXLvqucoc9itqN3BVzDGmn07mwfCPLsmtk00bBJQmrfm+f+99O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7q2s72CVREocAYSHHpmdrweg6aGtR7HEI8GxG0KCwijagiNo
	UprXKlghwnvglPI7mQcfcHOYxqzveL7wNrkrtbdXhOVpIkiX6eb9DkHd8T6aGjJWHC+R+Ir0zHR
	yTh6nbboV6Ny9atzhceeU5C/sPOQkMVEg+swASOPggj9r3bnbyAN9RA==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr1135685f8f.25.1729673215093;
        Wed, 23 Oct 2024 01:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1SYY6CyLekUwxKlnFZKNXUKAAfEqXFWJcII0J+uNLboSCz2hbmrGghitkgxAUMr8DsnJ2jw==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr1135673f8f.25.1729673214688;
        Wed, 23 Oct 2024 01:46:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8455810f8f.73.2024.10.23.01.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:46:54 -0700 (PDT)
Message-ID: <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
Date: Wed, 23 Oct 2024 10:46:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/26] cxl: add Type2 device support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

10/17/24 18:51, alejandro.lucero-palau@amd.com wrote:
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.

I'm sorry for the late feedback, but which is the merge plan here?

The series spawns across 2 different subsystems and could cause conflicts.

Could the network device change be separated and send (to netdev) after
the clx ones land into Linus' tree?

Thanks,

Paolo


