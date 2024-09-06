Return-Path: <netdev+bounces-125983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA0C96F767
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED71B2611F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795371D3185;
	Fri,  6 Sep 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qyo6N5j9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930701D27B3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634180; cv=none; b=iESZniU8z8hIQWGZva1ZvKEozbx9c68UVxT7A7AFvb3jD8y7IDy4BgtsrANKwS3AWw3DxZ6yIbzCXQy3ASiOVt9fQ9PD1tqtrogBSLIxD6nSLZqXbn4EVJ7Pw3rEOQyxGRPaOPF4yC+KBeuIysgnzf39IIwvgraQ5K8I81apsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634180; c=relaxed/simple;
	bh=404WaK1LwOFCyinjlDe9HA0QhRST1HfdikWcMgbfG6Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JIPZhXJI+uURhdtLkuAvvDoBXMIONYv7VOu8G0Nj0XdoP1//RtR8IrtpBMKVpu+KqWLZQRqoR5K3J7njooA1QKmnrY8CG9u8l5AtUuifjDubcyDPmz1leMTWGnhLNqXTTXqPm57kmUdJc3vm1wBEemXrJseXxIXMuuWG2DayAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qyo6N5j9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725634177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcOjLLAUe40dmYXU1IuXAgjJNanI+NlxPP0WO3jSjmM=;
	b=Qyo6N5j90rlHbplMl4arTyH8HRsgCI2E1+k9tek6wDQtB2pCkBtI0ZWkENGsEGVdiCrVCP
	QL4P/m12GAGlaRWskfF4ZjPC1wWHJpoZ/zhDRWNyQcKXzZW121MDnTkHJP1/IBTq1LiRhv
	lwl1U3bEOdmPzI2lK7Q1py5bIcM+oGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-iP2tVD6jMMCt8IKapar4XQ-1; Fri, 06 Sep 2024 10:49:36 -0400
X-MC-Unique: iP2tVD6jMMCt8IKapar4XQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso15802205e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634175; x=1726238975;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcOjLLAUe40dmYXU1IuXAgjJNanI+NlxPP0WO3jSjmM=;
        b=V6jdr84IeJluZFzZPf6AQAI0xIuaZAmd6EgB7/BQAgZVL/jD5YKkEh9A9xGkElpmV5
         1uy4NrHgTzFNLW9l2Ich2hTgVheHdc8CQw+WSFUEl2Hr/bMwKunBageGWoH84Tvfndm8
         7VzW4yw3MEDL8SB+SlcimPObeCzDZiEMeIYbhUsG2fwf6R4OqyZ1op48CIs1N0Z02ppM
         b8Ay57bI6qrnYHPvY2RNh+h1lVNv4wrtOL9kMc8MYtyF+Cw0XaBQQq6TQvUys6V/MvS3
         iJw0qWwBBTVPG9hj2WV6dOC3Bx6ACsPGqaSwS9cwiKM3/2od7y3DGZaDwr7lKgrUtD35
         rvmw==
X-Gm-Message-State: AOJu0YwAshZTu3FhSC01q2Mc3Q1oJHzhzld5/3gXE2ZC7gzz9l1UzyOX
	Qt6kGkdRfgodS3FZiPmsEZtVdhtDxBiY5jrz0uKKGQAwjXp84AkV/HPZlhAGbCtex3OwxcJZE9a
	2T4y18C/U9WcPdzMtLtjy7h8AMzu6RLxUAvekSvPnr58PyMZzcLDd9A==
X-Received: by 2002:a05:600c:1c1b:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42bb01b4c35mr202140985e9.13.1725634175040;
        Fri, 06 Sep 2024 07:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH30rc1LnqRX1nDyjfK8MIZ3Y446lySjIxQolVtQW38LDKp/NAHPM/yeDTBxJie3QD7ySGPzQ==
X-Received: by 2002:a05:600c:1c1b:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42bb01b4c35mr202140735e9.13.1725634174598;
        Fri, 06 Sep 2024 07:49:34 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d8a40sm23323535e9.37.2024.09.06.07.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:49:34 -0700 (PDT)
Message-ID: <896b88ce-f86c-4f00-8404-cedc6a202729@redhat.com>
Date: Fri, 6 Sep 2024 16:49:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
From: Paolo Abeni <pabeni@redhat.com>
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
 <8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
Content-Language: en-US
In-Reply-To: <8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 20:02, Paolo Abeni wrote:
> On 9/5/24 03:33, Jakub Kicinski wrote:
>> On Wed,  4 Sep 2024 15:53:39 +0200 Paolo Abeni wrote:
>>> +		net_shaper_set_real_num_tx_queues(dev, txq);
>>> +
>>>    		dev_qdisc_change_real_num_tx(dev, txq);
>>>    
>>>    		dev->real_num_tx_queues = txq;
>>
>> The dev->lock has to be taken here, around those three lines,
>> and then set / group must check QUEUE ids against
>> dev->real_num_tx_queues, no? Otherwise the work
>> net_shaper_set_real_num_tx_queues() does is prone to races?
> 
> Yes, I think such race exists, but I'm unsure that tacking the lock
> around the above code will be enough.
> 
> i.e. if the relevant devices has 16 channel queues the set() races with
> a channel reconf on different CPUs:
> 
> CPU 1						CPU 2
> 
> set_channels(8)
> 
> driver_set_channel()
> // actually change the number of queues to
> // 8, dev->real_num_tx_queues is still 16
> // dev->lock is not held yet because the
> // driver still has to call
> // netif_set_real_num_tx_queues()
> 						set(QUEUE_15,...)
> 						// will pass validation
> 						// but queue 15 does not
> 						// exist anymore
> 
> Acquiring dev->lock around set_channel() will not be enough: some driver
> change the channels number i.e. when enabling XDP.
> 
> I think/fear we need to replace the dev->lock with the rtnl lock to
> solve the race for good.

I forgot to mention there is another, easier, alternative: keep the max 
queue id check in the drivers. The driver will have to acquire and held 
in the shaper callbacks the relevant driver-specific lock - 'crit_lock', 
in the iavf case.

Would you be ok with such 2nd option?

Side note: I think the iavf should have to acquire such lock in the 
callbacks no matter what or access/write to the rings info could be racy.

Thanks,

Paolo


