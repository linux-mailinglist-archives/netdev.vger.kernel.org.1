Return-Path: <netdev+bounces-272736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ2rL/l4x2n2XwUAu9opvQ
	(envelope-from <netdev+bounces-272736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B234D888
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54DB1304B36E
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0AF33F5A8;
	Sat, 28 Mar 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ye+aru+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF733F369
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680266; cv=none; b=fpjfgCJZOHSs1XcsHmEu/zWIhQudZJNW6gfmv8Rn96Yjfe+pi/bfdYeijdahSlh6wRcvFyuegc9dyxJHwodPVkIlwcsR8TJVoHL9v+s9D60zMtDAQ77+C99YWwjSBJyAc4byTvYw/opIhNNLUqEv2jBqBDnhPUpGpRjjnyWSbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680266; c=relaxed/simple;
	bh=xU8llrJ8E/MPvLKzAix5sB2ylAwFcQsWJxamnGRvgmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1IINo1WEKRY4l87KhQSHrqoD5Od+kcm4t6abVy7XbT74xhG7kat8AZfvHce7c7YamjYEmnGYq4lw6PYs4VgGY0ZtMjiY3ZHUhpz0XnkfKxYnlDbp2A/5OSH+H5JlnVMX1BQny35DY58Lv9+ygfYEb2kqDfRFq22lrlraiSX1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ye+aru+9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b611274bso1488921f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680262; x=1775285062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zb9btrbms911nU8pycyHqMf15VHIDrQVqlKU3C8/x1c=;
        b=Ye+aru+9ztHiPJpVvbgdvNeBr42ckGjT6nQh6HYmXuigJ8Rsb7uqyRg/Avm+wnKnI2
         9yACR8iZWh7slpLjp/nYq4XueX1RlksiyWuIpwJF2tWPq95YVPWgjvT8QiYqSgEikGU3
         fYUfGJtLTzCgTR4XNRkrxJV6snPjE1oQ+F9m/Ly/6+Wy4eo4kn2ULXbMgXScd0ZyucSe
         fHrOksMI4XnBmlMR4YEvRDdtO722VS0op3xX5/stx0AiE3LT3C1dEN7ul08OX43+4i98
         XFlSFrA08xvhuTucfp8+FKHzZKzuw20Dn0TM5+qF7tRKPmXcBSHwjK8tEmz9/sX/g1DM
         moqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680262; x=1775285062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb9btrbms911nU8pycyHqMf15VHIDrQVqlKU3C8/x1c=;
        b=oRUQdPegV1/55BDXsa+SMu1fj6vz7uG+TY4+mVXhnVUBe9n2J2up21A3GmnBHtY3oW
         Sath6eHYmUttBPbIzOeAbeu2ckbmW4I4vjfq/xM9cVXHID+8VP5nXUlPnHujeLrfkElz
         sN99EyY0NgmOHwXUaEIqRSDAWcBZN92FbdL7BFdP75pSqipIAxqfOlvFn713NR2sHYZP
         DnBprQPnMd/wZrUOp7Pv9Hguz5pYlxRlNQFQj6Bq1AADriMs3IgHXRwOh7e7aa8+B/w+
         rYWy6dt9ymsm3dA/OKvqneGwJsvxtN3PxzT3Mu3IhMEBA+mUxloVm6ymV1Cm6fFi7tCx
         fbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQC4vYblww515FpmUjSxOBcsa3hwSzkCYQQeHRYWQjdwxYMTVRh+zYL46M3apBi80WNwAoOKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfV1VhOAojiIJcgCRpqRplfCTEgRw4/h/K+32NyQ2mxQ4bmxu0
	GmiY5JDlgV9KctlVPykPb8PGFsLBL0cjd+DwKFBL2kK/Uofp179i5koO1cBEKPx77V8=
X-Gm-Gg: ATEYQzyCxEeoibB0JrXk594f5XHlXNv+tP7QwycOpDH4jNFOuzhXmwNx1JQ75LkimDr
	sOHk+3GLkkY9+JyU6cNE81KEqtsceARl46bD1Q5wfQRwipEinqE9u5sqtlHseyF0qfBO+t17or2
	lXThx1RUkNesCK+14Vg4Hts2wZ7V8hWeaGBqgGG/pjFYeTJFj4lKjLxcLf94/KQythF+5ESGp3l
	zIPJcmC33Nh/DbV1cxE0YMGT77iTS4ywsJELz8rLmfznD2liKndf3wsLf/BOHJ4UOGGCzpL/yqv
	pDnzJP2xEd58bBQVvvBKMx/mAzY0fZ8yGs83/CgMuodx8C+4457j5PShmgIl1wOnCarLPRs0kZU
	AtjQgLfcAROMM87OA9GJZEkIVTffTF5VMNDlAKujXNswUpgOgwQeY3jA4ICSLNOsT01mTCMuCnP
	PeVDKF55fC6g5CXpPUU3klk27Br4qlwMWNM5quKQQvMjDjas7MLb+fUA==
X-Received: by 2002:a05:600c:19d2:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-48727d594bemr85729705e9.5.1774680261792;
        Fri, 27 Mar 2026 23:44:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270af027sm48648925e9.3.2026.03.27.23.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:44:21 -0700 (PDT)
Message-ID: <388be65e-4f80-45c7-b1c2-d3684cd1c256@blackwall.org>
Date: Sat, 28 Mar 2026 08:44:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 03/14] net: Add lease info to queue-get
 response
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,iogearbox.net:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,none:email]
X-Rspamd-Queue-Id: 271B234D888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Populate nested lease info to the queue-get response that returns the
> ifindex, queue id with type and optionally netns id if the device
> resides in a different netns.
> 
> Example with ynl client when using AF_XDP via queue leasing:
> 
>    # ip a
>    [...]
>    4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
>      link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
>      inet 10.0.0.2/24 scope global enp10s0f0np0
>         valid_lft forever preferred_lft forever
>      inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>    [...]
> 
>    # ethtool -i enp10s0f0np0
>    driver: mlx5_core
>    [...]
> 
>    # ynl --family netdev --output-json --do queue-get \
>          --json '{"ifindex": 4, "id": 15, "type": "rx"}'
>    {'id': 15,
>     'ifindex': 4,
>     'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
>     'napi-id': 8227,
>     'type': 'rx',
>     'xsk': {}}
> 
>    # ip netns list
>    foo (id: 0)
> 
>    # ip netns exec foo ip a
>    [...]
>    8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>        link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>        inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
>           valid_lft forever preferred_lft forever
>    [...]
> 
>    # ip netns exec foo ethtool -i nk
>    driver: netkit
>    [...]
> 
>    # ip netns exec foo ls /sys/class/net/nk/queues/
>    rx-0  rx-1  tx-0
> 
>    # ip netns exec foo ynl --family netdev --output-json --do queue-get \
>          --json '{"ifindex": 8, "id": 1, "type": "rx"}'
>    {"id": 1, "type": "rx", "ifindex": 8, "xsk": {}}
> 
> Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
> lock. For the queue-get we do not lock both devices. When queues get
> {un,}leased, both devices are locked, thus if __netif_get_rx_queue_lease()
> returns a lease pointer, it points to a valid device. The netns-id is
> fetched via peernet2id_alloc() similarly as done in OVS.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/netdev_rx_queue.h | 14 ++++++++
>   net/core/netdev-genl.c        | 66 ++++++++++++++++++++++++++++++++---
>   net/core/netdev_rx_queue.c    | 54 ++++++++++++++++++++++++++++
>   3 files changed, 130 insertions(+), 4 deletions(-)
> 


Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


