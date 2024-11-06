Return-Path: <netdev+bounces-142192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192849BDB78
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB14B22AA3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F618B470;
	Wed,  6 Nov 2024 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cm7EV7wI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CB6BFCA;
	Wed,  6 Nov 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858025; cv=none; b=ka+UafPUqbc9ry/ncZ8zT1LFzZyXDdSnsTK2EtU5W8AfvTsMytAwdOhX8J5LdkljOahotkypgO4lFLFf9hGk/LovN82AL5lzGQis3senGrY+H7YHI9+o1LTVUnvoH5If32fzYF7S9+ngHFkMBGPS1aojX2wb7YOMKMGUDpzcCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858025; c=relaxed/simple;
	bh=68+zslkMKSA5nGn3lh0DlfksOz2L6lczC3Bk6w4itAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TK3xqZ0tEbTeqdzY7N7vfdhjUoHFNyHnim2l33fqymbitF3063D7G/34gMHYIWn5SSupAf/j/2P+L/hf7eM4td1YC6Gw/VjuR/gjUaiZibR/SI1G9ucYC8PE6jy/d0/QNwFhjqc/gJOzEA8xoZaYPSr0ceLyzpE7yD7kh0TaXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cm7EV7wI; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730858018; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=FVLThfaNjw2O2/L4P/vGneDLVGUi31T7fGTxCNOyGkY=;
	b=Cm7EV7wIG/mQnov3YGooQDNgnQByq5zZa2ryJDu0AAjxFHxNDlzey6LgzA0N1CNnfWv70m/gVb8q1IA1NM8T/n4RixzwRx52iDonWh0yf3Jyy3cO276DqwmU4JK3SUrXI3rBRguoLB4W6jOJ3LEpz2+WDwhCy43ExE33tAHbrZk=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIoL2WC_1730858016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 09:53:37 +0800
Message-ID: <72b93894-2728-48df-83b3-3b4773e7aae1@linux.alibaba.com>
Date: Wed, 6 Nov 2024 09:53:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected
 socket
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 horms@kernel.org, antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241105121225.12513-1-lulie@linux.alibaba.com>
 <20241105121225.12513-5-lulie@linux.alibaba.com>
In-Reply-To: <20241105121225.12513-5-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for missed EXPORT_SYMBOL()s that break ipv6.ko building. Will add 
for the shared functions including udp_ehashfn(), udp_lib_hash4(), and 
udp4_hash4().

-- 
Philo


