Return-Path: <netdev+bounces-208526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF9B0BFBF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3729E189DA15
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CE221DA8;
	Mon, 21 Jul 2025 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UE5QvYW2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5721B19D
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089312; cv=none; b=LBOCM89ialgM01mc0S0dxg7R4kAZJ+rKSBPifq9UxYe6XfUSf2kxAREWPqcf4phViitk367mEpm0g+85rATL/B9ad+n0T9WpQIx0mT1wiq0pwFIFCrcbFYKiWKEIOVoJHDJTMzUsv3eVA7zPvlfHpdwigXqnrOtuqRh66G6ytF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089312; c=relaxed/simple;
	bh=IppsuYmCl8RRKioYYb2jY+xXysF/TwAiC8Aaglai5yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDkLOL232v5zKFL4kbN5O9HEnYdUaQFPjFBEE3xIvdXzQNmyE8YBBqS0pk6GhhDeaEjxIqkdZD7jGn+J40ucKnRKERguDfTZ/luv6k831lksWXmB2Lh4WeYeiBGQ0Fya5R5NRbJUIw6NY8UodCqxeciWi5bo2JrhKwmnHluPNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UE5QvYW2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a52874d593so3126038f8f.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753089308; x=1753694108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5ygTDgXdW6Dq4gPwmqNEck7jj/kFNK70RN6J6x/seo=;
        b=UE5QvYW2ePMvmv0uQ56ybLbm46ClmQS3gyLT/wXrC9qsRXVOVmZFEvQvwnbbMiRvSH
         J1/DJDObav9e0ezsZY0Vs/UQWdFpGNCDtl/tnJntX8i9tfU6mtyEgZQYItWjw30SfFgN
         KhXNAa96AKq3vmMlljt+bsd9j4ixAfdS+u5Z+JAyI7REA04qyB/oEobC/PbfB3o09uqX
         T5X+2Trd0qAH8+xsiUo0DUhCG8pqNLw7WTiqCKIznHj6QbQITrPxCXdDx+98Hg+PaQ2/
         TH4yLTJVsu8Lq3ZBQXJljI3HaDp+4uDMsrHUlNgMKt1mN7+K3D+/iud9q8RiFhJ8eYXy
         TTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753089308; x=1753694108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5ygTDgXdW6Dq4gPwmqNEck7jj/kFNK70RN6J6x/seo=;
        b=Hn8+AgW1RavcY3QYnVSKZBGJvNVO11xF5oA9HCTfOAURpG8Mhn7aedW+ngPTQzz4yC
         xCILJlVc5szP4vQ6VLzseJfQLYbZQQr3eCRmOt53Uvn9iItZxEljXSyhd/VP6DZ4Q6Aw
         JWhM12vdNQ6xSbP8j1hShhW2ijNs9M4aELObYl9hw3FDuHuSK/j7sKs216A3FR9lzYS4
         8ayPc9BsK2kkAzzLzNfrrI6JCUNnpbnKBzn3VteHreBky8TXunnpjhPhB5mg6YOe0+vK
         Xga1T68pT5n94UFJK3tt02x0tWRlXFSx5Rgxv3kbRvC3fR1iDrh5EnZM+WKKxdLzHnP4
         jtKg==
X-Gm-Message-State: AOJu0YyCEkRPuq0HKwG/NoFEzy0iHPcC5fqGyYidJ60aSikE8jqPUbDz
	ASC1FKsu3f2YaEsLLVJ8EHyIh9SR/21FGMjZAnhFJSUCpJFjMwyNsrGHlfvIgdGQZwvrOqCzb8I
	HIC+6
X-Gm-Gg: ASbGncu2Iu4pWWOyL6U2i11Lu56qeKc4Tu2SXrs7NnbQrD2DHsWstsmM4zV6DlTWkvU
	WPrLEbaRB3FY4UxLGvZR1mTPT4Vxwp5ccC/AVP19vEojf9u7OOh0VO1BiFfX8G8H3XJXXZOQBNV
	ZOsdE0yQwl3jWVIBgcccd4h9G9cTmVWsxRglV3prlDkUpyGwPtctkhdkaUx/UIC5UleZFIPPjMF
	qz/xcmA7iGxIl8NUMfXc5oNIzpJ+F7Ob37EuVzm+lOvd2UuhxtFSHg0x1voHH9NaUAGV+K7FfNA
	/hcvPXieOImqpbIVUyydV1NW6JyDZOZA5SJEnFr62YzqvvEm/JT+KY82DG66LJ2MMVjBSUrrmMV
	sxqxzw8iV2jPEJrYjommuanQA
X-Google-Smtp-Source: AGHT+IFyHtdt5YQqISwCrrU+0gAQvNd5S8dUh32cO4aT1RLN+oYMwR8P6c88IikfltcdlnNKexZETA==
X-Received: by 2002:a05:6000:2308:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3b60e51d196mr14159075f8f.45.1753089308092;
        Mon, 21 Jul 2025 02:15:08 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48cb9sm9933364f8f.45.2025.07.21.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 02:15:07 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:15:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next] netdevsim: add couple of fw_update_flash_*
 debugfs knobs
Message-ID: <qtxhmyqmxkwurk62akezcovqt6ybzhk4o3tdmp43fwlbjhnttc@itfqp6muiaxh>
References: <20250719131315.353975-1-jiri@resnulli.us>
 <20250720141502.GV2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720141502.GV2459@horms.kernel.org>

Sun, Jul 20, 2025 at 04:15:02PM +0200, horms@kernel.org wrote:
>On Sat, Jul 19, 2025 at 03:13:15PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Netdevsim emulates firmware update and it takes 5 seconds to complete.
>> For some usecases, this is too long and unnecessary. Allow user to
>> configure the time by exposing debugfs knobs to set flash size, chunk
>> size and chunk time.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>...
>
>> @@ -1035,20 +1040,20 @@ static int nsim_dev_flash_update(struct devlink *devlink,
>>  						   params->component, 0, 0);
>>  	}
>>  
>> -	for (i = 0; i < NSIM_DEV_FLASH_SIZE / NSIM_DEV_FLASH_CHUNK_SIZE; i++) {
>> +	for (i = 0; i < flash_size / flash_chunk_size; i++) {
>>  		if (nsim_dev->fw_update_status)
>>  			devlink_flash_update_status_notify(devlink, "Flashing",
>>  							   params->component,
>> -							   i * NSIM_DEV_FLASH_CHUNK_SIZE,
>> -							   NSIM_DEV_FLASH_SIZE);
>> -		msleep(NSIM_DEV_FLASH_CHUNK_TIME_MS);
>> +							   i * flash_chunk_size,
>> +							   flash_size);
>> +		msleep(flash_chunk_time_ms);
>>  	}
>
>Hi Jiri,
>
>This loop seems to assume that flash_size is an integer number multiple
>of flash_chunk_size. But with this change that may not be the case,
>leading to less than flash_size bytes being written.
>
>Perhaps the code should to guard against that, or handle it somehow.

Okay, will sanitize that here. Thanks!


>
>>  
>>  	if (nsim_dev->fw_update_status) {
>>  		devlink_flash_update_status_notify(devlink, "Flashing",
>>  						   params->component,
>> -						   NSIM_DEV_FLASH_SIZE,
>> -						   NSIM_DEV_FLASH_SIZE);
>> +						   flash_size,
>> +						   flash_size);
>>  		devlink_flash_update_timeout_notify(devlink, "Flash select",
>>  						    params->component, 81);
>>  		devlink_flash_update_status_notify(devlink, "Flashing done",
>
>...

