Return-Path: <netdev+bounces-125652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9396E175
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5F1F24483
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285CF14EC71;
	Thu,  5 Sep 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeXyQoU9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06B7464
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559368; cv=none; b=GblD0c1Hc5C9rVboQe7BqN27UDX840HBJWK8maBL+e8ViaitWl8CjSB0JrqgWyozVGcM2cr9QTkFdZwcC78jtZGYeaen/p2X4a3WWbYa9rWCX37tRiNMTy3mEopCDCbxtqGpE+jKPKOZDOXhnUmbFrR9XtigY293xMfXG7Riy2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559368; c=relaxed/simple;
	bh=MYjqPyEWSIxKowUVyW5gBooisxjj82jZbxgXRIpxqOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1i0GHq3DMkWkV3oFUgTM38oVG2Z3+BzZx3hNt+qINjCDta2r8Frwq7bEcFOhwsAujwgX35y49PoC3dm5m5Q8+E+tx1BYnp3H3MhzPZSbUJNuEiFMgMAbuRqAwC2TV0zQC+j5VyT8D5cZZD9+J6rHZkwox3wAUG44UEBf/Ms8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeXyQoU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725559365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roHMeVfpM72nhdopD5nInjvN5CDvhNQCgAGjHCepxw0=;
	b=VeXyQoU9SkOPB6VGEiiBjBpzhu6oONV2rGvYd9YRv/a7KlBUhD/vFWKVOoKHHft+/Bw0Rd
	x3JCQcbP0h3Zz37GGkY8quD/QJ6uvmTRA3SjsIAsrDZfd/JlUzAgjUt5V/dxnIzsSUgJ1G
	mbxpWTIkmw04ZwXbk+DNxfos99e7T7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-OM2WSNtEPaeLa5uXC05sUg-1; Thu, 05 Sep 2024 14:02:43 -0400
X-MC-Unique: OM2WSNtEPaeLa5uXC05sUg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c78767b90so9562035e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 11:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559362; x=1726164162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roHMeVfpM72nhdopD5nInjvN5CDvhNQCgAGjHCepxw0=;
        b=HCdKsi+EoHseHeaYKPNWDPMrhIeIe5d/axe+bzg4YGCp/sD5ZPKl0TUAJTJxfxHZx3
         CFaM+tJeztex/s5m3wtwBlvWg25kDwXHolvkl8y2pYnLyeHVT2NdPPaVAI+MWk5cu/7i
         8dqtOAQW3xtpDh7CLxHjviwlZr60VoNYo+LXyt4qEp0AzWp45lGmItHXuf5Jnnq+QYlM
         pys9tdIY/GwBmWqVFTYK9i7XhHMbapJ7r9oNfWRgn/VQhuNR3DIVBDxqrswNGoE92Ta4
         zag4H7sVdnqt6QQwcEYbxvp4oRtKqcL8m1w4ALu+k1mU1NyCMQJI7VHSdcAuSKbu/KsC
         Xaaw==
X-Gm-Message-State: AOJu0YyrJu36H8yAjhGpOk3qdDQrt5X5MyvgI+/rTYj0o2+68rBRl2i5
	8mm0Q2t8l/2ogtKaoLfFkLYPW0EldpcLYJIv7NQQkF0NJdpmPFLBmAXYbH2Cqn6b92gQkQUd0B4
	vk2O+NUAZyaC+p/yAca9JFvbLgkIQumP2WgSJYDtWBTCM1C6JLHallQ==
X-Received: by 2002:a05:600c:3ba6:b0:428:e09d:3c with SMTP id 5b1f17b1804b1-42c9f9e19demr55565e9.33.1725559362042;
        Thu, 05 Sep 2024 11:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM7dtnarUxGlrKVgRtwKFRRAKunwM7qUZpmhPs8q0DiH25QRQFO41dHQpmteCZ2uYmeo0sQA==
X-Received: by 2002:a05:600c:3ba6:b0:428:e09d:3c with SMTP id 5b1f17b1804b1-42c9f9e19demr55335e9.33.1725559361488;
        Thu, 05 Sep 2024 11:02:41 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a0asm240201845e9.13.2024.09.05.11.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 11:02:40 -0700 (PDT)
Message-ID: <8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
Date: Thu, 5 Sep 2024 20:02:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1725457317.git.pabeni@redhat.com>
 <160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
 <20240904183329.5c186909@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240904183329.5c186909@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/24 03:33, Jakub Kicinski wrote:
> On Wed,  4 Sep 2024 15:53:39 +0200 Paolo Abeni wrote:
>> +		net_shaper_set_real_num_tx_queues(dev, txq);
>> +
>>   		dev_qdisc_change_real_num_tx(dev, txq);
>>   
>>   		dev->real_num_tx_queues = txq;
> 
> The dev->lock has to be taken here, around those three lines,
> and then set / group must check QUEUE ids against
> dev->real_num_tx_queues, no? Otherwise the work
> net_shaper_set_real_num_tx_queues() does is prone to races?

Yes, I think such race exists, but I'm unsure that tacking the lock 
around the above code will be enough.

i.e. if the relevant devices has 16 channel queues the set() races with 
a channel reconf on different CPUs:

CPU 1						CPU 2

set_channels(8)

driver_set_channel()
// actually change the number of queues to
// 8, dev->real_num_tx_queues is still 16
// dev->lock is not held yet because the
// driver still has to call
// netif_set_real_num_tx_queues()
						set(QUEUE_15,...)
						// will pass validation
						// but queue 15 does not
						// exist anymore

Acquiring dev->lock around set_channel() will not be enough: some driver 
change the channels number i.e. when enabling XDP.

I think/fear we need to replace the dev->lock with the rtnl lock to 
solve the race for good.

/P




