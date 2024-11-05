Return-Path: <netdev+bounces-141768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB019BC320
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E86282C27
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AB3FB1B;
	Tue,  5 Nov 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJSLGpbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BB364D6
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773239; cv=none; b=b+sWOR4lglqRHFnAwRny8FTb7YVe0+6YuRcyTuaC2cSE12X7gHAatE08GY5L0jeEl8uhQ42ln3Nn4ftUjfMwUREYC+8QWrlBmHvohQVpFPg7BWJ+lJU20tbcNDt7WlxKUDoRznzMmyYlT2+w73bYz7ngkwcNgbPGpVTUxYB8HZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773239; c=relaxed/simple;
	bh=3scN1yfHs9mQ9BxlaOMQDYfsT/Xlx8DHcOI1gJ90IK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jtESyEiRqcZTlfiPHwUDMDR2ZZZm+acBRQ7l7PobDkgCgXyRiOW8MEyA6u4Z0xEG4YJZ+3rwJ3Z/3q/+euk8fZTUvJRkZgzV1aZVWQIS5RIOa1VK8AxF+LxDTU7b6QHMxZT+xTACjO5wdvI5vh85MiW+KKk6NIpnBlUYl3DM7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJSLGpbQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3334739a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 18:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730773237; x=1731378037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu2sO02rILbi6RYbzKuYuNQiSGhqW8jNif/o6etQ7Qc=;
        b=AJSLGpbQFglZLmqmGKKByqKlslqVvp3V/4Mg/SJcFrJjuCGVYMrWp/bZYg1pi3imJ7
         FFOUYNwWIYR/PpoWl05A+l6/3QrjhekY/86UYvQm0FhAL+KGrOFlv7hfXfuLW69ygcR4
         gnY7HG+YH3DdRFSoYclZkql53aZy1s/Lq6QYC8itlaZQTa/J4kGQTKqt5PDeJrjb0Jhy
         sh6PzomGGKgMz8f0TmadNfAi21mdAGCQt2z93MZwIQZZnZm13ML87Jv0tFU+PGJFGNMU
         nlRtFbBHlAI72z4CcpyeaQFAIxIBDxTFtUCnqnzREr6x0QA8mklkKf5WiOmbUB6sARaJ
         crIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773237; x=1731378037;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu2sO02rILbi6RYbzKuYuNQiSGhqW8jNif/o6etQ7Qc=;
        b=hrWPNQFUOSWLuk8C55s9TVLhVvUIOfO9d7SuuI1pj+1iyS6OLw6UzqUw3ODrjDLyIc
         7eRUQBm7m0elPVF6ijkpL6JWk0gk36F/5Y9lXIYXJNd9ZWjv9+051snX1YVzkVyFYNcR
         dNnkPF50oSsZuPKOmVIdcDeT87r5gbeRAb/Z/pVvdqXiOogdaypMuIjAJIavrFhaSEoa
         ZnGHCMdM2XCY/UKoCVvRbkuEJYam0vORrHMxgxU7xfRL0If7599ThYGku8v5t+0ibON1
         NE+hYVUilWTpCtqkH6DyQuiS7/baZkiI/VF2a5ORr83B6LmED5JPw2QqyGcg4pcsHX5Q
         Us+Q==
X-Gm-Message-State: AOJu0YxF2DLaHeqn8xkPVa4ynekRYhGonf30KmAX+g22ivSiPJOn1qxi
	7g8eWnpK4ld9nrbAtuTSjnNK0MMGRDFXPTomIZRMj27Ii6H4K/RA
X-Google-Smtp-Source: AGHT+IHdQUCVsQeTfZmlqZd+CfslsS1BnKc1JzLu2wTD71Jc8vtW2WJDTwrMmuIn/sqX72LDPuhUlw==
X-Received: by 2002:a17:902:ecc4:b0:20c:b606:d014 with SMTP id d9443c01a7336-210f76d6604mr301239985ad.44.1730773237529;
        Mon, 04 Nov 2024 18:20:37 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:1c59:4088:26ff:3c78? ([2620:10d:c090:500::6:9ebc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eee7bsm68228065ad.61.2024.11.04.18.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 18:20:37 -0800 (PST)
Message-ID: <638b1c74-3718-441c-bfee-7d00af833e36@gmail.com>
Date: Mon, 4 Nov 2024 18:20:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] eth: fbnic: Add support to write TCE TCAM
 entries
To: Joe Damato <jdamato@fastly.com>
References: <20241104031300.1330657-1-mohsin.bashr@gmail.com>
 <ZykNzvV3d5SXe7Yn@LQ3V64L9R2>
Content-Language: en-US
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
 sanmanpradhan@meta.com, sdf@fomichev.me, vadim.fedorenko@linux.dev,
 horms@kernel.org
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <ZykNzvV3d5SXe7Yn@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joe,


> Does the macro need to be on its own line? Maybe it does due to line
> length, not sure.
> 
Yes, this is because of the line length.


>> +		if (!tcam_idx) {
>> +			dev_err(fbd->dev, "TCE TCAM overflow\n");
> 
> In the error case does fbd->tce_tcam_last need to be set ?
> 
>> +			return;
>> +		}
>> +

Basically, we have 4 unicast and 1 multicast/broadcast entry for BMC 
(see fbnic_bmc_rpc_init() in fbnic_rpc.c for reference), making overflow 
really unlikely. If an overflow does occur, we currently report it for 
debugging purposes. A more comprehensive solution to handle when it does 
occur, will be added later.

>> +	while (tcam_idx)
>> +		fbnic_clear_tce_tcam_entry(fbd, --tcam_idx);
>> +
>> +	fbd->tce_tcam_last = tcam_idx;
> 
> Wouldn't this end up setting tce_tcam_last to zero every time or am
> I missing something?
> 
>> +}

Yes, that is true. The role of tce_tcam_last is to track the direction 
of the next pass. Since FBNIC_TCE_TCAM_NUM_ENTRIES is 8, while the BMC 
entries are less than 8, we clear the remaining entries (which would 
have already been written by this point). At this point, the value of 
tcam_idx should be 0, guiding the direction of next pass to be in 
forward direction.


>> +		if (tcam_idx == FBNIC_TCE_TCAM_NUM_ENTRIES) {
>> +			dev_err(fbd->dev, "TCE TCAM overflow\n");
> 
> As above, in the error case does fbd->tce_tcam_last need to be set ?
> 
>> +			return;
>> +		}
As discussed above.


>> +	while (tcam_idx < FBNIC_TCE_TCAM_NUM_ENTRIES)
>> +		fbnic_clear_tce_tcam_entry(fbd, tcam_idx++);
>> +
>> +	fbd->tce_tcam_last = tcam_idx;
> 
> As above, wouldn't this always set tce_tcam_last to
> FBNIC_TCE_TCAM_NUM_ENTRIES every time?

Yes, similar to above, this will ensure next pass to be in reverse 
direction.

Hope this clarifies things.

