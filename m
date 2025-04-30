Return-Path: <netdev+bounces-186988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43D5AA463C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23FE3A419C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C42222D1;
	Wed, 30 Apr 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="fTI9dEH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F21C9E4
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003577; cv=none; b=KAy6oksEK8BjEhst8Zk3oMQqy4jznD94LelX1c/MQywMG/1ebFpkgzDr/2epdZaCsj6OXu9xgaBhWvHMWqepnLynTpffVlISxdy1uT5vwX8F7vF4SqjVRA3YWBpOQgcTb4UULj7yh9yu9qFdzvk2qNU3l2fbRtN3crr2BnRZuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003577; c=relaxed/simple;
	bh=RkzlwZCbhtMJnB2Spo4yp2KgCgohamPmC7E8jQ72shc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=gQgjdGVTn/GOsMGvo9eQPB7iVHO3DC7yuAJlT2lJCKVzcvlhWCpAhbzBiUw2Xa7CWr7OUSnRH2gEhPfW7Dz0aaxcqsQhAx2+YLKAC5j2ZzaGY6VlL2UERDppRUFC8QLcvg9GQJYkpXXFh4ZcHOKTR3u8tbnldknG77esQmqgYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=fTI9dEH8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54c090fc7adso7388234e87.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1746003573; x=1746608373; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIdiM8Sc9hWrOWFRgDx0BZ0w7RTy7ecbUhEaYcLLJ6Y=;
        b=fTI9dEH8TBPvtPDf0DxDVe03/LQISz+jfVIigxgdB+znCeP1VsjLkm3m6a0f+2TPtq
         /PMPKGgPspCz4JvlIpARUdwI5u2nTUnwy+3dUF319+AvYLGwC3YndhdhKZaVvlL07hSa
         0DY+zjua9FMMV6r+BhJBDybu0ktEUgPb25VkbXU7mnsle+E6OQkDbZrfalm1mDdarsIi
         yYaN/vPej8GHj+hNCD7D77oD0KHloRKXu6so8PqMePWiZM9LOr67rDFJcYDS0bRUw5cM
         dC2nWKUuvsDZXdA15oTldUcpDBCMYIICQdavk+bGnvPPKfAMKaxb5xPYWqgyKPHlRAlV
         IXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003573; x=1746608373;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YIdiM8Sc9hWrOWFRgDx0BZ0w7RTy7ecbUhEaYcLLJ6Y=;
        b=MOfpDdxBKwsvoxtKILg7onPRiQr1GgEOHyfd39Rq1FjaTBF7+XpzSBM5p01og3b2+k
         fW25jQhsG2wIkH6+LoI+pFo7OTEO0i2RctkO/TbUMS14C+Ijnt8lFJtZgRbvTLfUufvh
         /6POp4H7tgPDWwc2MdDRSk5q55UpZIOHxCG15S8HCP8Zx89CJdbqAxDWRhPhV8z69fdM
         4Ns1Enc1S9WpQ4raBST2tlYfqYyZbRaVAW4IcE8PcF/UcrGXqxdBfCiFnPOTxVOoQgVr
         CnBTppKc/4IjsDNDeum7low1nh10a+Vl+k6LoyVMYxApV3qSaS9N+1JvNN9JQcOLNxK7
         acog==
X-Gm-Message-State: AOJu0YxVlz0FNYq1FAUNW2NLgj0pnPBqJZuW1R6sojCvkpv4Ok6rfr8j
	1pK8VtTyRg9PEXsTzrU4DhZblHeIz+4EXChaYhmTWXpkP5+RhDswX94/SgbzZPAss2V2hzLug+Z
	N7Fw=
X-Gm-Gg: ASbGncu+RCEdBb0U6vO5CTdRPyG9NkCaQO/3TlRWh/hA7pRHgi5iMH+RuLaYvnzCSff
	fuabw9Z1GciIkBclvVFZ2KCqZytuGoKHd/cI4Kz3OaPl7TXZbKsFdgTJNksFkyGx2BS+735Jw1z
	AV547DF6Bjfs7zwGaFrDwREhm8Zvn0e9SRo8XOBVDE48YcczcDtl+o+KTD4+pzLF6P0Reqa6k6L
	Qu/MkdJmNcVKywcVDaiVnBz8Q1vTsgHsYufUIwep7l9/ms4UVfwh+mnNeA2uMKEbZ93Kyguc2rq
	Wueh9AOnPgbw2dyfayIoSLZG3pvwtqy0CUrG/HsnsHDvEoWHYMFCKMTxYGxxtyl3AouMlz4ZvgF
	vfiA+lV6Ehm8MivILUIGzztm3K5sI3CDURel3W/p5
X-Google-Smtp-Source: AGHT+IG3iXBWYklb5olq3Bl09k5KuE60rSVsdTBnASacEjuureyHiufykWtV/54mU6g8/SWciMgQbA==
X-Received: by 2002:a05:6512:1597:b0:54e:85bc:d151 with SMTP id 2adb3069b0e04-54ea3397427mr579314e87.46.1746003573020;
        Wed, 30 Apr 2025 01:59:33 -0700 (PDT)
Received: from ?IPV6:2a00:6020:ad81:dc00:46ab:9962:9b00:76f8? ([2a00:6020:ad81:dc00:46ab:9962:9b00:76f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb408f5sm2141821e87.104.2025.04.30.01.59.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 01:59:32 -0700 (PDT)
Message-ID: <06415c07-5f29-4e1d-99c3-29e76cc2f1ae@deepl.com>
Date: Wed, 30 Apr 2025 10:59:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Christoph Petrausch <christoph.petrausch@deepl.com>
Subject: Possible Memory tracking bug with Intel ICE driver and jumbo frames
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

**

*Hello everyone,*

*

We have noticed that when a node is under memory pressure and receiving 
a lot of traffic, the PFMemallocDrop counter increases. This is to be 
expected as the kernel tries to protect important services with the 
pfmemalloc mechanism. However, once the memory pressure is gone and we 
have many gigabytes of free memory again, we still see the 
PFMemallocDrop counter increasing. We also see incoming jumbo frames 
from new TCP connections being dropped, existing TCP connections seem to 
be unaffected. Packets with a packet size below 1500 are received 
without any problems. If we reduce the interface's MTU to 1500 or below, 
we can't reproduce the problem. Also, if a node is in a broken state, 
setting the MTU to 1500 will fix the node. We can even increase the MTU 
back to 9086 and don't see any dropped packets. We have observed this 
behaviour with both the in kernel ICE driver and the third party Intel 
driver [1].


We can't reproduce the problem on kernel 5.15, but have seen it on 
v5.17,v5,18 and v6.1, v6.2, v6.6.85, v6.8 and 
v6.15-rc4-42-gb6ea1680d0ac. I'm in the process of git bisecting to find 
the commit that introduced this broken behaviour.

On kernel 5.15, jumbo frames are received normally after the memory 
pressure is gone.



To reproduce, we currently use 2 servers (server-rx, server-tx)with an 
Intel E810-XXV NIC. To generate network traffic, we run 2 iperf3 
processes with 100 threads each on the load generating server server-tx 
iperf3 -c server-rx -P 100 -t 3000 -p 5201iperf3 -c server-rx -P 100 -t 
3000 -p 5202On the receiving server server-rx, we setup two iperf3 
servers:iperf3 -s -p 5201iperf3 -s -p 5202

To generate memory pressure, we start stress-ng on the 
server-rx:stress-ng --vm 1000 --vm-bytes $(free -g -L | awk '{ print $8 
}')G --vm-keep --timeout 1200sThis consumes all the currently free 
memory. As soon as the PFMemallocDrop counter increases, we stop 
stress-ng. Now we see plenty of free memory again, but the counter is 
still increasing and we have seen problems with new TCP sessions, as 
soon as their packet size is above 1500 bytes.[1] 
https://github.com/intel/ethernet-linux-ice Best regards, Christoph 
Petrausch*


