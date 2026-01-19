Return-Path: <netdev+bounces-250937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DBD39C07
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752123004195
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DAE1FF7C8;
	Mon, 19 Jan 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D60PcPFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4E1F4176
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787068; cv=none; b=rCQT2xvt1+bL93f9yJc8hfkUpIf+mc994Z7gdF2qq9/25mHWYI2nWnWpBHxfLAKogAprl4K2fqKsyarc37EKqilHKf9h2C/6ciIidouWmHhLlAsMtI/0QoOls2bhpyWltaTiVo+bLCYfCi4TaYNHCP1lImWDkUsafhnglh7uGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787068; c=relaxed/simple;
	bh=VkcDqkYVamWxgzFand4/i5j9JzckX2bMhZN6R9QpqmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOj9GQV+HDLGjc0gJ4pqV8HzVz43FNMmiCsrmpGgiLomLjjBT4zzHhNvj23C+DM68HlrTljiNB1sXlH4PNnTh+bF4Ea+Y9mlafvl2PFTGe9pLX72EFoCdmIixQK7r6bvwqxn9RBXmAQBHs3gCXpTgP6HJHIGCErlRWnNwCCdOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D60PcPFI; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f36012fb2so5320965c88.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787067; x=1769391867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SUu7mR9w9aTv1c8MTdqdl262I4zy7RQjj2g442SDFA=;
        b=D60PcPFI3LSSdx1wWoA5PSzcJV61ANr077L+TjTpRF5j4wYXLFkLGNcmFp8Jq8BSYk
         ulWJWcCmkc3e/B1lMo7SKn6psBXGM8NENyiQMx4XpAOiIKv/UQ4aHFFxao9Efk7fw46B
         0N4/zPkLvWiNizcc7t6EnXnQXSy0SYXFMRfFlF6Jf805Dc4b232f8KKyTx/g+q/9YNeZ
         nA2afjRe0c3TiNAgeMSv+G3VkQ5C35GANzoKTfig/BY1wP0cerqsDs0e3OYocDiRHr3G
         qPBiKuBx0mnqpkS1ljr2e97Qp+feORvnuezj7qQNeQBdYCXmF4BswWigkowMq3fiJ8jw
         u5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787067; x=1769391867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SUu7mR9w9aTv1c8MTdqdl262I4zy7RQjj2g442SDFA=;
        b=wh2OtLS6+TmugDt8JGGmdRb6XmddGekVp9/oQokyHURcuKBkGEBc6gunW+ddnMa4hX
         uXXbPCP6t3XvSXQlPX9UGft9BH/bg7XE3fC5tEUQRrmmS8FOQIlVmjNigv9QhX/Ru28N
         xWykDxBhBH2tgRnqNTHSggoEd8bdOZwty6T/gpZC/h9C6xi3DUTVR0sqLGGOJOvf3P1I
         Sl04lZrXdKLoyKTgrnTNGzP+Huosqg5LlBMblUvgnZuWp4+bG9LNQuDbIL8rugq0tlg0
         60mud3qHAhKi2L5+7rPg9bG8uVAd2q/gdYJhR9/4zGALMi4PFlJmPvu6b1Rt1fnycB0h
         vmGw==
X-Gm-Message-State: AOJu0YyfquW9uWPRAPif0DljAnYSy8y2pA/Ok23iQTV8NNMSPM+I0AiA
	pYnvrSpkedYXUVg9zseHEOJnMVINQlPcuqCI4rD8uBoejZOaLLVzJUKDR/li
X-Gm-Gg: AY/fxX6Riu7HQTdcLeQ7Z698TW80f61gvUD8/A9gEXgV8uWWm7ZbRcLMLmxRUwvygvb
	CWPE4YY5XkTn5W9ustPGsqfqJX5SjMXvydezZmSB0DIM5tzMeQEJxzeS+u5lS/e4BlMqncNjBG5
	MV103Q99lIUUwcpK2p6lr/Rp1XrP2fYa0IYggtRtTMUVldZ93KSNBe4URgwlNbgKqFeZswz9w5v
	tQyHioP8sOOTzj7tThYDV3FHMQ1/qYn3pKFPTxvScBD8rItiNHSE4txKwNlrIaZK/8KcLyoP8nQ
	RvBl7WHp3uMENiReTqzxlojFz9kL9s92urMqFAGGjvcCOhpofz9spyZ0C1QWpgrYKNWyODGMb//
	QoLntO8e8czqcTn7hLUPCRQys/bv/jC2s0SwxajOzYnsim5QfYIXMH/B3xGC2E7Zxpv2K6XpTIe
	/1gZvi+AjfPUCaNAUGMNmm/ZvLdT5AApOdHtVhNei8pKOCo6NufjIIo5W2+M3tTYu3jxIlv0f2k
	BbHxg==
X-Received: by 2002:a05:7022:e05:b0:123:330b:3a0 with SMTP id a92af1059eb24-1244b31fdb4mr6587417c88.14.1768787066785;
        Sun, 18 Jan 2026 17:44:26 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefac48sm11757747c88.11.2026.01.18.17.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:26 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:25 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 03/16] net: Add lease info to queue-get
 response
Message-ID: <aW2Mec4NWre1axmO@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-4-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Populate nested lease info to the queue-get response that returns the
> ifindex, queue id with type and optionally netns id if the device
> resides in a different netns.
> 
> Example with ynl client:
> 
>   # ip a
>   [...]
>   4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
>     link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.2/24 scope global enp10s0f0np0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
>   [...]
> 
>   # ethtool -i enp10s0f0np0
>   driver: mlx5_core
>   [...]
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 4, "id": 15, "type": "rx"}'
>   {'id': 15,
>    'ifindex': 4,
>    'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
>    'napi-id': 8227,
>    'type': 'rx',
>    'xsk': {}}
> 
>   # ip netns list
>   foo (id: 0)
> 
>   # ip netns exec foo ip a
>   [...]
>   8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>       link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>       inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
>          valid_lft forever preferred_lft forever
>   [...]
> 
>   # ip netns exec foo ethtool -i nk
>   driver: netkit
>   [...]
> 
>   # ip netns exec foo ls /sys/class/net/nk/queues/
>   rx-0  rx-1  tx-0
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 8, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 8, 'type': 'rx'}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}leased, both devices are locked, thus if __netif_get_rx_queue_peer()
> returns true, the peer pointer points to a valid device. The netns-id
> is fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

