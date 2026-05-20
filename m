Return-Path: <netdev+bounces-289986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIsPNLzYDWqj4AUAu9opvQ
	(envelope-from <netdev+bounces-289986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:52:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7459142A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23FF3215CF5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC863F1AB9;
	Wed, 20 May 2026 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oSaiv1bt"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2853E1D07;
	Wed, 20 May 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289967; cv=none; b=H3MA0kgIssfHTMyg9VmoHmppTi5kxqhApVNJ9KI/YU58u12cBywqaC1xefMlJ1+tgUQX63Qtmu+Lema9Z5qAekGXRMgiemywisO3XRJFzrN9sW6Y5vyuD+vcBCFNegyHhBkvxRBSb2N0Mzp64BIfNTod5PcJMGsEg/U9lT1vcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289967; c=relaxed/simple;
	bh=tGtQjeU/68YJYtAlar9WmNrQ1Kf8bmpfGl/v/jPKSmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY1ahtA+FmTmEezUPrHPyQjeQC7pv5HKvMMFklkPwhds+XqyPfd0L3PVtCpJnDNVZlQ5LNgjf8KCYSUvecebla4s/iSPX00MJfRinjNWdQCtLga8cQhntPaD+BqtYiViKPbW0QjSGD5ZxMcBijZI6i4yZlhht2AnXcpGn6L9kEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oSaiv1bt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QPXvLIkN6psp73tzXjNMpifHWdCYlylmGbN06uhNR4w=; b=oSaiv1bt5JDDUSxvfqdZmH78t4
	o0cgYrVZa0la0sN6fvzkcjHAJf9ghPmVzKLi1WN7k5/+JCt+5ORp/LtE5F4xF1rOPO6zpAVTww/xM
	VZqomeLDAytz/VYXwFwM/Z4rLKbrMeXQIC9gRY8B6qCaVA8EMVVE5nvofiaFUHHp4bAKugg+PtB6t
	6SPP3q+dx3JniitJ4MZo6WB2FsSDj1GBN3YultHQS5gL6ljyNZ1RR3cc+X/jYQsJVvD7neXpp8oyr
	YgVAVWnWgfOCLZAbH/C+jjJwRlTZ+AA12LDf3vRY4ArbeK+iK7nSBbMz9uDgFtE9+/3eH6j7fodbr
	JlTGlk1w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wPiag-000GHz-3C;
	Wed, 20 May 2026 17:12:11 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wPiaf-000HqV-2I;
	Wed, 20 May 2026 17:12:10 +0200
Message-ID: <f6595728-06f2-4cdf-a515-f31fcec13c86@iogearbox.net>
Date: Wed, 20 May 2026 17:12:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 13/14] netkit: Add xsk support for af_xdp
 applications
To: Zhu Yanjun <yanjun.zhu@linux.dev>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
 <20260402231031.447597-14-daniel@iogearbox.net>
 <ea99efb4-6ac0-4b29-8b38-e9865b46526c@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <ea99efb4-6ac0-4b29-8b38-e9865b46526c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28006/Wed May 20 08:25:19 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iogearbox.net:mid,iogearbox.net:dkim]
X-Rspamd-Queue-Id: 55C7459142A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 5:10 AM, Zhu Yanjun wrote:
> 在 2026/4/2 16:10, Daniel Borkmann 写道:
>> Enable support for AF_XDP applications to operate on a netkit device.
>> The goal is that AF_XDP applications can natively consume AF_XDP
>> from network namespaces. The use-case from Cilium side is to support
>> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
>> virtual machine management add-on for Kubernetes which aims to provide
>> a common ground for virtualization. KubeVirt spawns the VMs inside
>> Kubernetes Pods which reside in their own network namespace just like
>> regular Pods.
>>
>> Raw QEMU AF_XDP backend example with eth0 being a physical device with
>> 16 queues where netkit is bound to the last queue (for multi-queue RSS
>> context can be used if supported by the driver):
>>
>>    # ethtool -X eth0 start 0 equal 15
>>    # ethtool -X eth0 start 15 equal 1 context new
>>    # ethtool --config-ntuple eth0 flow-type ether \
>>              src 00:00:00:00:00:00 \
>>              src-mask ff:ff:ff:ff:ff:ff \
>>              dst $mac dst-mask 00:00:00:00:00:00 \
>>              proto 0 proto-mask 0xffff action 15
>>    [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
>>    # ip netns add foo
>>    # ip link add numrxqueues 2 nk type netkit single
>>    # ynl --family netdev --output-json --do queue-create \
>>          --json "{"ifindex": $(ifindex nk), "type": "rx", \
>>                   "lease": { "ifindex": $(ifindex eth0), \
>>                              "queue": { "type": "rx", "id": 15 } } }"
>>    {'id': 1}
>>    # ip link set nk netns foo
>>    # ip netns exec foo ip link set lo up
>>    # ip netns exec foo ip link set nk up
>>    # ip netns exec foo qemu-system-x86_64 \
>>            -kernel $kernel \
>>            -drive file=${image_name},index=0,media=disk,format=raw \
>>            -append "root=/dev/sda rw console=ttyS0" \
>>            -cpu host \
>>            -m $memory \
>>            -enable-kvm \
>>            -device virtio-net-pci,netdev=net0,mac=$mac \
>>            -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>>            -nographic
>>
>> We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
>> 100G NIC with successful network connectivity out of QEMU. An earlier
>> iteration of this work was presented at LSF/MM/BPF [0] and more
>> recently at LPC [1].
>>
>> For getting to a first starting point to connect all things with
>> KubeVirt, bind mounting the xsk map from Cilium into the VM launcher
>> Pod which acts as a regular Kubernetes Pod while not perfect, is not
>> a big problem given its out of reach from the application sitting
>> inside the VM (and some of the control plane aspects are baked in
>> the launcher Pod already), so the isolation barrier is still the VM.
>> Eventually the goal is to have a XDP/XSK redirect extension where
>> there is no need to have the xsk map, and the BPF program can just
>> derive the target xsk through the queue where traffic was received
>> on.
> 
> Sorry, this may be a bit late regarding this commit.
> 
> If I remember correctly, eBPF is already supported in netkit. Since eBPF can cover everything XDP does, I’m wondering what the motivation was for adding explicit XDP support to the netkit driver.
Pls see the commit message which explains the details; tl;dr the need
was to support zero-copy af_xdp based application in containers to bind
against netkit, so that we can have native speed there. (see qemu example
which uses af_xdp backend)

