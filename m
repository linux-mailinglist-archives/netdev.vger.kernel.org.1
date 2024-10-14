Return-Path: <netdev+bounces-135139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E999C704
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD52853C0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06D158548;
	Mon, 14 Oct 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brgpE/s6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C7146A79
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901194; cv=none; b=MStiZbXDIarAPhs76HfKZb11LOlMq4dOvpyqXsD0xsKTL1cILpEEXpDna859YZ15foEVc7WAFlSskjPkmHIMa+FC1a2ahH2z+MTlwEE4nEk4dtjHGPJM7pOpf4poGtGnj+Zml58H+vazuRPJjQyIi7HA8TEJraANoxQtyyAryAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901194; c=relaxed/simple;
	bh=B1eKaysnr/CwGZ//oHQpcL4jtQLUGrwYz+Hf9mgFVhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVayzVjOWqSHu7YIe+dGy6wfIXvKxsiqkMJL1fRDs3AnqqkxBNmbV3LIGwoIzMccud/B4CrnZ/1t2yCtDMOdbBSAfsE+FnMXKs1z/MY3Js9ESmXecVDKUmvjBTdMhTP1uaWzBkoeY1Mlwm8gFf65Go442q+GHa/1Udz5SSUqvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brgpE/s6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728901192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTHUqzvtiZs0La6Sa9CMCWUG64x+7/nx78p4X7/24lM=;
	b=brgpE/s6fGBtaBIElQj4sKkt5sFtVta16r14Tb33kbR98d8i4M2ckqap8f+wOGaiQV3Y9x
	gsdckPOVegZBX2jIHY7bTFHVEB7YtG9ddb9jWVY6YC7cyk8+Was7a+/INlFTQZNijf+DjM
	5+ioO0o+U1V7RKkr6/Qs4EW5OXwuXqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-r8hHxR_BMYaL3lpipdx3ew-1; Mon, 14 Oct 2024 06:19:50 -0400
X-MC-Unique: r8hHxR_BMYaL3lpipdx3ew-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d60f3e458so1127277f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901189; x=1729505989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTHUqzvtiZs0La6Sa9CMCWUG64x+7/nx78p4X7/24lM=;
        b=vxIaMgD7kJ+nM8jXt4KP/OT3QrIj+LF9XDEor1GLAd7Oc9uEx6GfV+aWFCNYyUOU5s
         ywIJrZ8p7/KCb9BcrWo2oCBXGJ4sZqVd7r+fWrP4ysbK3IofpewvF1Nbb/gnKJYLFcrT
         m+WeDT3afxqQrmuue4B9ZRLFzFmHfnEtzgkUVdT4i6fITmKuRZ8xFEexp6ESax+phFnt
         C+9vuLTAHi128dG7kFoW7P5XBOn70aI0u6Llxs5lNI6yFT2gtbW/VjCtMdVbIW/GK52G
         o37dGvGcqHv38oPLhDSfOjL5GjRMt9m2NckpCHY3jHNvDJjzkdaL1MBrbR6mMRWBMzJL
         O7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU+6cIwdvY/KM4jiDQu2M7SSlFuNysd0AI4uut6GNP9coPsIuY6W5tfzPWHLV6JmwyJ+SKOW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQBqnsMEHJ5OZL42T6hjDLyINkkmzYvIskc2O4CIZUDDVqJxY
	USAPfmESDGJzlegC7WyOHOfsvwCUMF4yHfe+DEAmSGrzcw1/mjZ++m2P0v9IVTJ2g3H71WXVWLU
	Noq5ErZNvGPjQP+cdZbp+aAfbv1mLJss61d/kJE/SH4Rj84K19WKPQQ==
X-Received: by 2002:adf:fe08:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d5ff59707mr6636084f8f.16.1728901189445;
        Mon, 14 Oct 2024 03:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHi9job+XsmNFpeabtOZPzGOYwfWd8AfURhtNkFtVblKgF7EyFl56Q7Tf5TlUEMuoxeKrkuQ==
X-Received: by 2002:adf:fe08:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d5ff59707mr6636059f8f.16.1728901189000;
        Mon, 14 Oct 2024 03:19:49 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f873sm10998742f8f.75.2024.10.14.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:19:48 -0700 (PDT)
Message-ID: <9c636d54-4276-4e28-abd3-0860bc738640@redhat.com>
Date: Mon, 14 Oct 2024 12:19:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-4-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012012918.70888-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 03:29, Philo Lu wrote:
> Currently, the udp_table has two hash table, the port hash and portaddr
> hash. Usually for UDP servers, all sockets have the same local port and
> addr, so they are all on the same hash slot within a reuseport group.
> 
> In some applications, UDP servers use connect() to manage clients. In
> particular, when firstly receiving from an unseen 4 tuple, a new socket
> is created and connect()ed to the remote addr:port, and then the fd is
> used exclusively by the client.

How do you handle the following somewhat racing scenario? a 2nd packet 
beloning to the same 4-tulpe lands into the unconnected socket receive 
queue just after the 1st one, before the connected socket is created. 
The server process such packet after the connected socket creation.

How many connected sockets is your system serving concurrently? Possibly 
it would make sense to allocate a larger hash table for the connected 
UDP sockets, using separate/different min/max/scale values WRT to the 
unconnected tables.

Cheers,

Paolo


