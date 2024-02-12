Return-Path: <netdev+bounces-71027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B28851B26
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBBB23C79
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733623D576;
	Mon, 12 Feb 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="W0Fzmsml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D63EA6C
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758376; cv=none; b=RRQvpd6f8aYaUgHVVZeYoDf5EIuy8VFzhrcr3btBw0a6ibhO/LuUAPHi8FTShWv/A7CURZltiwAZOiSCtSvoc2CgUmn93sQro/x9slhIRIu6Zgxli/mkaeAkI4ea20ioOsUuHGIDo9pt2/qfR0aZjVSFxQs4viSKbTXKZQ4UZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758376; c=relaxed/simple;
	bh=az0yenF+D8g2pMu1VWg9wwzrWV5jCsR8QCRVpZsP4Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alXm1GkVeMOsVr/BPAwHUmUD1ZE8NEk+n+DsNyw2CCNhvv/8LUlhBFcKk0ll9MqStK3veHI76C7Yho3VrfK3HpVbqx0jtermLtTs6aq1oqUDST9r06c7Dhf907yyzQS+j54sVciRO24a6lh8LeP6g5oKBkRw56n64mFFp26wdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=W0Fzmsml; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dc4a487b1eso2497320a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707758374; x=1708363174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThJeiFegZ+yokN8cDlyMzgKlcvh1RtQP2uJuKGX34So=;
        b=W0FzmsmltsaUlUVrCrMgY1pgzJj7mrMntqp8i5O42eZHDF0Fl6MxGDxYPSGy8yYaYL
         Dzo4Nd8ePCs+HLGJBz5YT2RZAtNo+k8zRe7MF5oQDCWXPeHf7rrsVRa5VGbbSMs4usRh
         AOvXSOpucPZh6KjD5k+1HyI050Bt8t7o4iiqvj5Rocakm7mDQzB+ZE/h+LuybNz0fA4V
         chd1EvHQMl4G7AdrK+vkTiR2N8oVFKWhtjjNxHJ4uhxoCKQnbhAPNCTS2U5dl21lpdMS
         utdbw1g8ANlOBaZC/7CoD5tVxT+AzClNyrpjwU3wIOjN4gLxN8xlRITsNKWejhX3wo+j
         F6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758374; x=1708363174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThJeiFegZ+yokN8cDlyMzgKlcvh1RtQP2uJuKGX34So=;
        b=RELoVYO+ze1v41hHKyx3xBcC9eBf5FWetCcfOqp1O/vagoHjmzVQQ95xMXFjmiUaNw
         8RZ0QO5lLdKRHSKer69RRhjgQqUuVzbiv9nfJ+JnSLZenycu6zKRspfkcBJQYPTTKUA4
         Ebav3U7+K7CMFlkiJbG+LG/kjugI2gWPlba70LOaTDFUtoJ8hATvXhXxL+k30hf1RdGo
         0PmBnoBhV/kIknItLxZM+0tqWOlW05pCPpXypbWy1VIRmRTo63afQhMHCrGGIjqSTeEn
         hx3Zp3JythugaUgZUn3RidZP/FCTt1mMyvbjSwS9bhau7tDkN0wGwnyghg/WmV1LwlFv
         TdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUO4DkL8SUpbSCM4Jx7vgWEPpgA10Ck5Fuhn4T4e6ddrTBHiUhyI+fXWH3K8AtUjk0/aTHNGzNyqTww44oi/s0emg0lQxV
X-Gm-Message-State: AOJu0YzB9n068Hr+fu6Oc8s3mE0tE5AYebZyJRgppT4cKHWqkHJuH4Q1
	kGgrPg+ycC3q6JNJcdMdRfqyZdm4jamzKR43bHYGkSTvEflQ/V0k4lMxmbnvdtgAOnFAKtoJ/0+
	j
X-Google-Smtp-Source: AGHT+IGtzf/2WdJfgKKEzRjWhymxenr2a5APEcD39sDdt47NRisdb4zd/25gJyzJwGmK22duih9B3g==
X-Received: by 2002:a05:6a21:3115:b0:19c:a16d:ca79 with SMTP id yz21-20020a056a21311500b0019ca16dca79mr11343926pzb.15.1707758374237;
        Mon, 12 Feb 2024 09:19:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWj/qAr3kKkx5410s9WfMNCjO1CIMKKGEnjoN20fgDG2gqd/vW8YiQEDArS6+UoOMajis5lSazJp1R1RISTLFnqv4LX1AJwma6N2c3D1MzzIcUoiD15fC7sSDGlA6ffNKMyzk7/8bhhLm2ubgycr9pP/4/95qoN1YPkQqusNgXjRw3TsjrBFJZvBNrm07VlG788uOfCODuH
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:ad38])
        by smtp.gmail.com with ESMTPSA id t16-20020a056a00139000b006e096708e96sm6008549pfg.97.2024.02.12.09.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:19:33 -0800 (PST)
Message-ID: <ba4bf0dd-46f5-4b80-9040-3319b01c04b7@davidwei.uk>
Date: Mon, 12 Feb 2024 09:19:32 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/3] netdevsim: link and forward skbs between
 ports
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240209223017.5a03acaf@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240209223017.5a03acaf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-09 22:30, Jakub Kicinski wrote:
> On Fri,  9 Feb 2024 16:32:37 -0800 David Wei wrote:
>> This patchset adds the ability to link two netdevsim ports together and
>> forward skbs between them, similar to veth. The goal is to use netdevsim
>> for testing features e.g. zero copy Rx using io_uring.
>>
>> This feature was tested locally on QEMU, and a selftest is included.
> 
> Sadly we appear to be heading towards double-digit version numbers :)
> 
> https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/458900/14-peer-sh/stdout

:laughingcry:

