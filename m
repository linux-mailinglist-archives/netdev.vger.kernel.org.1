Return-Path: <netdev+bounces-140588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128969B7190
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFDD282754
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9E4C80;
	Thu, 31 Oct 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTqxHV5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0454A35
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337589; cv=none; b=Cqg4N5agwzLf/KZtolXBMgzi1F+YjhBPMIyvYgpF7nsBxnrI5Ie3fX19jE6zv66lheLKEakYm/2mwyrqYA/S9aZ0mUIv3KU13Z9IwRpM81o4Xf+dfGObQrUmGc2cxOLvyQfMJebZGHZ/mk9J8yv3o/kC0/PXZ7If4OABw0mUKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337589; c=relaxed/simple;
	bh=LJI6Z/Zr2MKK5f33NntjwWNdXfNGH31HxbT9rMagnJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1LjVIQg5zPl2Lz5eJhyV9UcC6CQsfUuGfCaY//VZLN2udNlpzfjjOZ0/8M8tvAdElvTDHrjxuI99DlOZuZYCCsdGAixMzaov/lpouX7waNdmVx00V9wrQPARv8V4CUbPKk9KZ8vez08nr1ShXLNrrdV1THihynGeFzSkxpaAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTqxHV5P; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so383588a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730337587; x=1730942387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHtAOHOoGLVP4Wjak+4McryRK5g8UXlop6EKa4aufMI=;
        b=UTqxHV5PVNAyiyGp2ftNKXbDYmZy0FMo7wvNZ9AdNvKCkX6d0p6ju0HkOLiHypGjlE
         2b7oOwhxr+7ZcoXI8sGlqMAry2UMzz0v1LtpWyojH5j51txCBq0CGlHdme2W7H0U15/1
         K8XdgzazlpzC+VQxx5s4L+h3Y+ilm0M4N4NRzEcnbfPLWOA4U0W/D0BMzUJlRl/NxnJW
         1UnPQNmy70Hsnve6znKXEDcfjDLVg/KcRkF8Rp81vxo0juMdJTHCfbzrkJbR2THBmBKw
         Y2ZWuT8mh5z198Tgna1jRtLEaQ1uUITQJNfexp3eCPzILCVjpJfCxIZvxMP6nQLHHMtM
         DvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730337587; x=1730942387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHtAOHOoGLVP4Wjak+4McryRK5g8UXlop6EKa4aufMI=;
        b=V0g2iaeP8LuJRAn5x6WoVJeKWahw99ib4FFwFZp6IOHTN+gq1AIoGY5a7J7lmI56n4
         KHw4xvnraayW6Q7m2+edVSupMKvtPd0N+weOv92CiOAVqGFH+V8nwLV+72+FMQzYrBoq
         vzY2+yInrGJpNqKqfOk+nvuHFhLBF7/8qvhNEsIr4lDLoTkdtwzk4KmG4MKBLCqvoD/f
         iIs27du3o1Y6Tf1VHmwAF0SydghJsK1QbQhYz1eycdhBjxwEV+HPZH5CEiO1Iq3PcIPv
         So2Dt3a9/A2XdP87ltXquq6kP5VWp340/I18TmAQ5qvWW1Aw/S1Ox8hiLkr6gKzuPpn9
         9zWQ==
X-Gm-Message-State: AOJu0YxGSTE5+LV7DjMzeBgBnhU/vjCu6FoyxKHqEA+Y7oNtz7KVfmvg
	m18Cyll2hZAqBh758+xlO22oT3z0Dy2wsm/NFpSvf3Sq1h6ez+VT
X-Google-Smtp-Source: AGHT+IHMPtNDtVpRcRZtMr9tzaiGmSEmM5MgHLKZaMNbK+myn4r51WltG4jIsQXJEy9DE5jUw/JmBQ==
X-Received: by 2002:a05:6a20:e605:b0:1d9:2994:ca2b with SMTP id adf61e73a8af0-1d9a83d627fmr23776747637.19.1730337587443;
        Wed, 30 Oct 2024 18:19:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:1c59:4088:26ff:3c78? ([2620:10d:c090:500::7:3f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b894csm282535b3a.40.2024.10.30.18.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 18:19:46 -0700 (PDT)
Message-ID: <5b6032d7-58f6-4e2d-98ec-68f7f55ae2c1@gmail.com>
Date: Wed, 30 Oct 2024 18:19:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
 sdf@fomichev.me, vadim.fedorenko@linux.dev, hmohsin@meta.com
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
 <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Basically, in addition to the RX TCAM (RPC) that you mentioned, we also 
have a TCAM on the TX path that enables traffic redirection for BMC. 
Unlike other NICs where BMC diversion is typically handled by firmware, 
FBNIC firmware does not touch anything host-related. In this patch, we 
are writing MACDA entries from the RPC (Rx Parser and Classifier) to the 
TX TCAM, allowing us to reroute any host traffic destined for BMC.

I will ensure that the commit message for the revised version clearly 
explains this.

On 10/30/24 11:34 AM, Andrew Lunn wrote:
> On Thu, Oct 24, 2024 at 03:31:35PM -0700, Mohsin Bashir wrote:
>> Add support for writing to the tce tcam to enable host to bmc traffic.
> 
> The commit message is not really helping me understand what is going
> on here. What entries are you adding to the TCAM? Normally a TCAM is
> used on ingress, but you are talking about host to BMC, which is
> egress?
> 
> 	Andrew


