Return-Path: <netdev+bounces-207872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E5B08DEC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B276218876C6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184282E0908;
	Thu, 17 Jul 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OiiXHJLB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2C2BE059
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758074; cv=none; b=nEt1LHLbOA7TyQZvR0nqPe7ig7crlrCnzxZv6GBRX4RfzZwR/47Xpif4wYTHD+XE5MBuYQVYvC4nzp2FD63X4wGWApVUn0EHkq/HT4Kl5j1mBgNsQIDdZePdROP/4zBH/TdFVBPo9Lk26US6hZaHT8BfPBcTWkazyq57G0MlJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758074; c=relaxed/simple;
	bh=noMqCXITYyf2FejAm0EKe9cVIK4aYS0QWeRxoaDXEq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5W2is3RM7RFzaQanVd8C9I+a/8Zy5djyNp6v0pDjwKNcADihgC2R7DZDaxe9pIa5NN4vq7FbjHbdVjaqXpjxmWsbVXwl7toscwplR3g0KUcpRqEucQ5Y25aL3CWnZwA5qVO4WpzPQcvKgr/lsexpPs/DiL52aXdEAefCJ1TO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=OiiXHJLB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so1450944a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752758070; x=1753362870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0WfmMy3iigRI0GYiSm9ZQNFXSYzMwic5UBPun5KAcs=;
        b=OiiXHJLBTlLOpVQ2T4Lg76Ssym1R9yMAeOi9qiw2yb4yWzAZqPikGnl9Y1V7X0XM11
         FlLjLeQxIZwAxcgJQ+X1AmgLw8xTldTQ1DJxOUaPcyKrjKbPYXU6bF9BiXjB0SSMQYjI
         LXwmw/rvSX3nCgIBxfWE0/C9pT5G0PwQJOHiCb1efdzjtu7j9dQh77HI8PZgd2RU55HE
         1j47kdtr+LLMSZlJsJarfC0vfnbTZ7wqMSdG5BiWXMdRsZ7UOoLlUg8Au6btldt650Qo
         PKSD4NbF525Nz/kvqc0QxQ1q90f0WA0vsyXsoCDJEOpnXHS8TGqcOPkkNiAwsRqooGcf
         XnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758070; x=1753362870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0WfmMy3iigRI0GYiSm9ZQNFXSYzMwic5UBPun5KAcs=;
        b=W9tV3ehHmoumb8avtS3cxosTLWZYfFpBMHbauRXDcmuQYBO9Ef9PmiRYB0Hjin/NoN
         g47SE3kZel2VESrbIfH9XC2/HYboOtIBVl4EXswMqj4MiBq/Aj3AI+nTrpiHbMt3R0oa
         CinbEs/e2bCLANh9nDn+kBEt4LNiRDOq4LmZLcHgilCIAtnlxsBHHxCVDYVqpU5mLrA4
         cG6EKxdeuJY0AJW8mRTl78nnb14au2sxeKyRW567jPe4gfF0D3TD9ZL01N/Rtjik6+Ff
         CNv3vfQzVgcbjacWN1FhA8XBPugs/PR5edht+NWVl8V9bsr3TxtB/gdnMyUYTcGdpRVz
         4QmA==
X-Forwarded-Encrypted: i=1; AJvYcCVo6Fbt0LKtvxvdZDbdXlplXoNLpg7hvw0U+/MqEOowbMzYwzk3rP4w53ro2SghwYBNOsZTLqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQI7N7oMj4AdvXVnkjBiZXWjpeIKScveSOIt1pDUZ9MT5geJhM
	IGpWpQzuoiJeddXyTtpZ8bamNDaTvzg7A/cMMjdapo9RdOK6TLWio4tFu3P5Nax7+oc=
X-Gm-Gg: ASbGncv2nO9CqE0BIPqROihUR5UAr/JA4ZwceabpU5pAjVjkOppTFUgUEPWc20bTvQO
	a3OE7Ce8bzZF1hmLwbHsgWFwq9L/tW3QjwbQHeRgze5KH+sSr62f45JFfsaf7+W3S3leWf5JFbp
	A4jZsHH9pi4XIO5z+bDD9wSypWWJ73N8X9M8xGse7SW8gDrwDcG8OpLk744v/mNL53VBLgDNzMr
	V8d/NIB03EbZGt69A1Fp5APGGjHJVGOZzBfpc/chereBkGQThQSPpQipTdcRtw/7H8aWtP8zc/o
	3Y8IxC0LwQ+MaUhgHaor2jzaotUPTPwrVw4UuhRfN3D6X2IteVlKnCKN3ym5N0reBCgIF/Y+108
	ocnfnpz82Pxs+b9nZm41FCoaUgPAUdP4FeMQcW1iZjMaSWtpICZEmng==
X-Google-Smtp-Source: AGHT+IHEcZ9Lq7/cb1V2ZM6+RGYlF7mnokl2vHK9h25NbdWoz7myvROouYDFEg1aULxIUK8HMk7w7Q==
X-Received: by 2002:a17:906:6a25:b0:ae6:b006:1be with SMTP id a640c23a62f3a-ae9cdda3d41mr674539366b.5.1752758069723;
        Thu, 17 Jul 2025 06:14:29 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fd2sm1369890066b.108.2025.07.17.06.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:14:29 -0700 (PDT)
Message-ID: <451c6ad5-6577-4acc-ba5a-de5c4a85b88e@blackwall.org>
Date: Thu, 17 Jul 2025 16:14:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] bridge: fdb: Add support for FDB activity
 notification control
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, petrm@nvidia.com
References: <20250717130509.470850-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250717130509.470850-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 16:05, Ido Schimmel wrote:
> Add support for FDB activity notification control [1].
> 
> Users can use this to enable activity notifications on a new FDB entry
> that was learned on an ES (Ethernet Segment) peer and mark it as locally
> inactive:
> 
>  # bridge fdb add 00:11:22:33:44:55 dev bond1 master static activity_notify inactive
>  $ bridge -d fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
>  $ bridge -d -j -p fdb get 00:11:22:33:44:55 br br1
>  [ {
>          "mac": "00:11:22:33:44:55",
>          "ifname": "bond1",
>          "activity_notify": true,
>          "inactive": true,
>          "flags": [ ],
>          "master": "br1",
>          "state": "static"
>      } ]
> 
> User space will receive a notification when the entry becomes active and
> the control plane will be able to mark the entry as locally active.
> 
> It is also possible to enable activity notifications on an existing
> dynamic entry:
> 
>  $ bridge -d -s -j -p fdb get 00:aa:bb:cc:dd:ee br br1
>  [ {
>          "mac": "00:aa:bb:cc:dd:ee",
>          "ifname": "bond1",
>          "used": 8,
>          "updated": 8,
>          "flags": [ ],
>          "master": "br1",
>          "state": ""
>      } ]
>  # bridge fdb replace 00:aa:bb:cc:dd:ee dev bond1 master static activity_notify norefresh
>  $ bridge -d -s -j -p fdb get 00:aa:bb:cc:dd:ee br br1
>  [ {
>          "mac": "00:aa:bb:cc:dd:ee",
>          "ifname": "bond1",
>          "activity_notify": true,
>          "used": 3,
>          "updated": 23,
>          "flags": [ ],
>          "master": "br1",
>          "state": "static"
>      } ]
> 
> The "norefresh" keyword is used to avoid resetting the entry's last
> active time (i.e., "updated" time).
> 
> User space will receive a notification when the entry becomes inactive
> and the control plane will be able to mark the entry as locally
> inactive. Note that the entry was converted from a dynamic entry to a
> static entry to prevent the kernel from automatically deleting it upon
> inactivity.
> 
> An existing inactive entry can only be marked as active by the kernel or
> by disabling and enabling activity notifications:
> 
>  $ bridge -d fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
>  # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static activity_notify
>  $ bridge -d fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev bond1 activity_notify inactive master br1 static
>  # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static
>  # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static activity_notify
>  $ bridge -d fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev bond1 activity_notify master br1 static
> 
> Marking an entry as inactive while activity notifications are disabled
> does not make sense and will be rejected by the kernel:
> 
>  # bridge fdb replace 00:11:22:33:44:55 dev bond1 master static inactive
>  RTNETLINK answers: Invalid argument
> 
> [1] https://lore.kernel.org/netdev/20200623204718.1057508-1-nikolay@cumulusnetworks.com/
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> I have a kernel selftest for this functionality. I will post it after
> this patch is accepted.
> ---
>  bridge/fdb.c      | 69 ++++++++++++++++++++++++++++++++++++++++++++---
>  man/man8/bridge.8 | 22 ++++++++++++++-
>  2 files changed, 87 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


