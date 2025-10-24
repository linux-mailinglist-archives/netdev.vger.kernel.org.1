Return-Path: <netdev+bounces-232380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 473AEC04F8C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E126950129E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FB2FF168;
	Fri, 24 Oct 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghsdQXOr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA692FD7D9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293252; cv=none; b=G2eSSDzSksfdVb4XjLWNAAUPl7+4s6isdszd4fPsRWJLNRR2Ozi+hO40HndadICYuzfJoTc/EBli3wLz1R78k9EDIPzT5vg8pvfYIRlJuNwQV3qO6vLMAZo26E341w9WuErWW0gIQZ0KX3B2AnAaanU4oQSJHt73cK2iaeLlCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293252; c=relaxed/simple;
	bh=v6Uu9OfpU3miqfYHQVDWdTDLr/YQ0zcUPbLXEWhEqOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvoJhJSNhvJxrUgZ6ZsJO08kBqe2HSbtWWWSMV9ebLs/KznkNo7YCE9v91zWFGgmpWydjRD6mtmkXFyfZrlTiL6l2j/YUZuUeVzhueIijcmnD+6y+5bjTfQuwq1uFzgj1nuRPyW1x53XE3ftd7yqAOeOCBF/nNWf2nPYCn6bx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghsdQXOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761293249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRmVGBR3L7ECLXJInz7h60bnXxh8bIDyGiHP96dEYqU=;
	b=ghsdQXOr8xxlMQ1O0nmaQ+mvFhzEpaMcqJufrbDlSCN+6yp1R0UtTf68XVPf32U8/KIaQF
	wFRm01Y66SXNH5ck5ZAIWiaYw5siMqYtVC3Z7i1eiC+puTWAp38c+S9U+tZ/sHxtRS6laQ
	qnBMK2eVJJEpizwvmRFGYydAuzF+N/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-IxR4pFjIPW-VTMVKpsMpsQ-1; Fri, 24 Oct 2025 04:07:28 -0400
X-MC-Unique: IxR4pFjIPW-VTMVKpsMpsQ-1
X-Mimecast-MFC-AGG-ID: IxR4pFjIPW-VTMVKpsMpsQ_1761293247
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47107fcb257so11552625e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293247; x=1761898047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRmVGBR3L7ECLXJInz7h60bnXxh8bIDyGiHP96dEYqU=;
        b=qDJESaDKpQQ0txelRo5o8Xa1ZHYy83atkEpeWlne2Sn5mYZkAslRIFk8u08yFnHNui
         dxGpGL6a2tUCD6NieCXl6lQ5Ew9I8Z5fKkJghXIgOyaIS2eWMuiRJrYtN5BzccHAYyaI
         aq574r1wUsWUi6HRB6FV9LHsvwb+8pDbELf2DXQcLcXXhp7888/jCWRlOTz7CLL69zj0
         FWsqcWdtt5g67qjCE2A54L7ttlE9uTm+dc93HfDrjkNpqeNi05TWapn0CDwEMqbauOhr
         aC34pwU5VEavtbn+o7tExibO1vAOIxPofiLdYfpzcU5xTc0nVpJ5S5qWVcD1B1ZyoEbY
         4w6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/hSq7FxXdi+UH7VFWkKJLLKtahUiIBTbmbDW21mZsoJSnxe6h8oeqpa95rU2nEVbr71Dd+hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtHLcI3NiYphqnA+i33stPemAvKcvkXA+r59X4uV3DUwZBQ7S
	mASgkJy3vRanJDgdJAur2K7BXphztC3/NN9FEAcSju5m7ArqJw+KaQa1j0G7v7SLlA7ADXgLDEf
	SnzS2SY2LLcNtBDCvntbfS7BOf6F5zTKKoA6V3w+MTF0m51rSd8OS7ZfGpw==
X-Gm-Gg: ASbGnctnCMvZcNal/jkOARyShZSbc2t2fnT7YTGU3JrfKjwEOpMXzOWh7imkhHyObP/
	osqLvZEXo6pzg44LbuqZbVBj7TF+OHG4HM+7iqMvJ0JOJFY9smGwLKsAVb7V5Swl9hdAFsO5Bwx
	ZVa5MqaXVcO+ATZGVnBco6v4jAhIPe1sL0o9ZqKjs+60j+sQqrJt1VnRnLhCd93vU25Stm8jdPc
	sfe49fDB1iC2EECHi7s1eGK6ALH02EfEzmaXqpkxl/64mLzuQalSvrTzSG0UIVJ60ErJEJkcI4R
	rqe0CMSTEzFSm2ExTgVuykieIinRfpxwKmGnLipbay6b/LyaCDkHecNAaGBIPj3ngmUmDi85CY3
	t+fMZROfPnnVY4k37zSkkXP/M8e3DVorOGYH4
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr198072975e9.41.1761293246653;
        Fri, 24 Oct 2025 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6r1TGgJ/wvxED8Gb1vHbNBF65U7KF83b48rl7o39gZzsWhbiRmyUjExyLr9qynJjlSEUsgQ==
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr198072685e9.41.1761293246204;
        Fri, 24 Oct 2025 01:07:26 -0700 (PDT)
Received: from [192.168.68.125] (bzq-79-177-149-47.red.bezeqint.net. [79.177.149.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf15498sm91555855e9.12.2025.10.24.01.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:07:25 -0700 (PDT)
Message-ID: <fd9bfe41-bff8-472a-a50b-e2089f3c6351@redhat.com>
Date: Fri, 24 Oct 2025 11:07:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
 <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
 <20251021160745.7ff31970@kernel.org>
 <9604cc84-4268-4964-a4d9-2d37ea095138@intel.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <9604cc84-4268-4964-a4d9-2d37ea095138@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Thanks Jakub and Jacob for the feedback.

On 10/23/25 1:11 AM, Jacob Keller wrote:
> 
> 
> On 10/21/2025 4:07 PM, Jakub Kicinski wrote:
>> On Tue, 21 Oct 2025 13:39:27 -0700 Jacob Keller wrote:
>>> On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
>>>> On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote:
>>>>> - The configured value is a theoretical maximum. Hardware limits may
>>>>>    still prevent additional MAC addresses from being added, even if the
>>>>>    parameter allows it.
>>>>
>>>> Is "administrative policy" better than "theoretical max" ?
>>>
>>> That could be a bit more accurate.
>>>
>>>> Also -- should we be scanning the existing state to check if some VM
>>>> hasn't violated the new setting and error or at least return a extack
>>>> to the user to warn that the policy is not currently adhered to?
>>>
>>> My understanding here is that this enforces the VF to never go *above*
>>> this value, but its possible some other hardware restriction (i.e. out
>>> of filters) could prevent a VF from adding more filters even if the
>>> value is set higher.
>>>
>>> Basically, this sets the maximum allowed number of filters, but doesn't
>>> guarantee that many filters are actually available, at least on X710
>>> where filters are a shared resource and we do not have a good mechanism
>>> to coordinate across PFs to confirm how many have been made available or
>>> reserved already. (Until firmware rejects adding a filter because
>>> resources are capped)
>>>
>>> Thus, I don't think we need to scan to check anything here. VFs should
>>> be unable to exceed this limit, and thats checked on filter add.
>>
>> Sorry, just to be clear -- this comment is independent on the comment
>> about "policy" vs "theoretical".
>>
>> What if:
>>   - max is set to 4
>>   - VF 1 adds 4 filters
>>   - (some time later) user asks to decrease max to 2
>>
>> The devlink param is CMODE_RUNTIME so I'm assuming it can be tweaked
>> at any point in time.
>>
>> We probably don't want to prevent lowering the max as admin has no way
>> to flush the filters. Either we don't let the knob be turned when SRIOV
>> is enabled or we should warn if some VF has more filters than the new
>> max?
> 
> Ah, yes that makes sense to me. I think the best approach is just return
> -EBUSY if there are active VFs. We could implement warning logic
> instead, but I think most of the time the administrator should be
> expected to configure this once during setup (i.e. a boot up script or
> something), and not during runtime.

To make sure I understood correctly before sending the next version:
  - I need to update the parameter documentation to describe it as an 
   administrative policy limit instead of a “theoretical maximum.

  - I need to modify the set callback to return -EBUSY if VFs are 
already allocated, so the parameter can only be changed before enabling 
SR-IOV.

  - I need to mention this behavior explicitly in the i40e devlink 
parameter description.

Also, just to confirm — should I resend the updated patch directly to 
the upstream netdev mailing list, or should it go through the IWL list 
first?

Thanks,


