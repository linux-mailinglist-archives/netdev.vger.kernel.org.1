Return-Path: <netdev+bounces-71028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD568851B27
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FCB28BCE1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439E3D579;
	Mon, 12 Feb 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PF5f5+L7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E493D3A5
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758407; cv=none; b=WjiUBVcwj7b/zRyUzsFOUSuTMqo6VfhtqBARVR3nM8GUYQpnrJ+5ncn/6Flm+zOGPZNHXe4y78KJ9sPfy2BN6SEjS/d8nLtvPanY7R1Mf+WF8eQXb7YEjpWELzwS08ro7klARlQcf1eYKJTk7+VBLXk18EBLpOnLYBdGkqit/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758407; c=relaxed/simple;
	bh=YdFt098wQSPGsFJktXbjbFUsM0swVB6ZC6nPxBUXtQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osaRuawSYv5rPIZ9T2htb4MhaBVZGp5AxAstUwcq3nWbIrIxBiRA+/D382zEZu3BKvyVu00V00YevAMNu2qbxZiczsY6rVvNUwLkcngaPxxXfszeBvgiN0kjW1KXogUhj8JhGw5RRtBL+iMsRMqC4S4Ufj6fh7qO4I+kaLG0WdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PF5f5+L7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso1982374b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707758405; x=1708363205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLh4tao3b4DJbo6bEnHxRXsOhivCEXqCBRXWYjsWl0g=;
        b=PF5f5+L7ZKdzGB8LAkPk9guiDqUHS4mHcvLg3bqWDIC11o6d4csNRFez3uJQaEsf86
         Tn3cPz3NKCoFCPpm9HvnLUemIdUaxm4XLSsdbOQyt3dDVyOWQKu24VXN3vs4h7cFaD0T
         BaJLQV9vuuxgrmRlyBzicnlKw6j9t53gQZLhfUjoSrD9P8cymbmuOQtbN4TItb/HTKn/
         mR5kthT2gNYBtaJ82KFJtq7QGUSKy21Z96O9TXo9+Zcl0cM5SAeFLp3itS2j3e8zLZuS
         r2Ac7uGK62CzNGZq9a//qUC1utoGVd+OmLqK2iuAE1v4pgisD8paf5Y69M/qQjtzeQw5
         NMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758405; x=1708363205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLh4tao3b4DJbo6bEnHxRXsOhivCEXqCBRXWYjsWl0g=;
        b=bHvoSFXoAoWVmFXX6/LmaktlAsTKzKKhDoAHB3gfKtrZjdM12e5/yKOEG601V0rNBo
         axif0R3BVQtsrdX7Cbm9suGb75sVSKgRAId2o16VdNYqOHJwhHXnbYsXw77VllvRClfa
         LykJVKhIPBuPywVxE/gwDSqiimosQE7zIYlnrdNtlv+//PRsQvfDWAin+d4exmJPnDr3
         345it94kTGpVxYEnMPhbZr63JV8TYXzRPkNT7LnNDUy3Ofbz+MhPdp23ukEQnDRHM6By
         T499YLJGEVPGtqTRGmMvoedCjDPW/PMZ2e89cCWVr5oBQYE26rmpPhi2le6HoAoNHzlb
         ZqmA==
X-Gm-Message-State: AOJu0YzxBtou2XmFf/FJu7hgui1xg3oUyRar+RSa3eP8E5x18gkgu99F
	B9fgGlc1iWPoyhztJb514iTohy4Rge4khL29GQ7woUySs7tcZzf54aBuDiwcgzE=
X-Google-Smtp-Source: AGHT+IFopOOrVArfZbGSjD5LXE03huErax7BrFeC5z7KaSpE5DPu8ZS5vL5lnXX702s7kbMPze8hxQ==
X-Received: by 2002:a05:6a20:94c9:b0:19e:cbe9:63b with SMTP id ht9-20020a056a2094c900b0019ecbe9063bmr169116pzb.3.1707758405017;
        Mon, 12 Feb 2024 09:20:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLFnMYOG9PaTEfbCro0JWCt8gZpF1YVqj79lXPa3E59TDQY5n5WW/uvzpAbhvZuMLqYQH9KEcgaEDa/fwnvwbvQrrghDwEtiPtOmiHDAnpWW1ck347KioHpVtKf96r1LfO3ByADp1lc5B9mifWPsJpUcfcTlkJ7KnqaUNqvGQuHPUv6Ti7Iq8TyvzeYRgsAmEbeTUtzuST4dfce6Yxb8vGLgiVaFE=
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:ad38])
        by smtp.gmail.com with ESMTPSA id t16-20020a056a00139000b006e096708e96sm6008549pfg.97.2024.02.12.09.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:20:04 -0800 (PST)
Message-ID: <16d46687-999c-4e46-9a76-9895779018c6@davidwei.uk>
Date: Mon, 12 Feb 2024 09:20:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
Content-Language: en-GB
To: Maciek Machnikowski <maciek@machnikowski.net>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-4-dw@davidwei.uk>
 <01747e34-c655-4dbf-bda9-544f4e3f8ebd@machnikowski.net>
 <b3fc2f7f-4bd4-4b87-a55b-4dd7d6072ee9@machnikowski.net>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <b3fc2f7f-4bd4-4b87-a55b-4dd7d6072ee9@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-10 10:53, Maciek Machnikowski wrote:
> 
> 
> On 10/02/2024 09:48, Maciek Machnikowski wrote:
>>
>> On 10/02/2024 01:32, David Wei wrote:
>>> +###
>>> +### Code start
>>> +###
>>> +
>>> +modprobe netdevsim
>>> +
>>> +# linking
>>> +
>>> +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
>>> +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
>>> +
>>> +setup_ns
>>> +
>>> +NSIM_DEV_1_FD=$((RANDOM % 1024))
>>> +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
>>> +NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
>>> +
>>> +NSIM_DEV_2_FD=$((RANDOM % 1024))
>>> +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
>>> +NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
> Can we change these to:
> NSIM_DEV_1_FD=$((256+(RANDOM % 256)))
> NSIM_DEV_2_FD=$((512+(RANDOM % 256)))
> 
> to prevent a 1/1024 chance of drawing the same indexes?

Yes, that is a good idea, thank you.

> 
>>> +
>>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
>>> +if [ $? -eq 0 ]; then
>>> +	echo "linking with non-existent netdevsim should fail"
>>> +	exit 1
>>> +fi
>>> +
>>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
>>> +if [ $? -eq 0 ]; then
>>> +	echo "linking with non-existent netnsid should fail"
>>> +	exit 1
>>> +fi
>>> +
>>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
>>> +if [ $? -eq 0 ]; then
>>> +	echo "linking with self should fail"
>>> +	exit 1
>>> +fi
>>> +
>>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
>>> +if [ $? -ne 0 ]; then
>>> +	echo "linking netdevsim1 with netdevsim2 should succeed"
>>> +	exit 1
>>> +fi
>>> +
>>> +# argument error checking
>>> +
>>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
>>> +if [ $? -eq 0 ]; then
>>> +	echo "invalid arg should fail"
>>> +	exit 1
>>> +fi
>>> +
>>> +# send/recv packets
>>> +
>>> +socat_check || exit 4
>>
>> This check will cause the script to exit without cleaning up the devices
>> and namespaces. Move it to the top, or cleanup on error
>>
>> Thanks,
>> Maciek
>>

