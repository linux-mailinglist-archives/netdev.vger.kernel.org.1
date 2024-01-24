Return-Path: <netdev+bounces-65657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C773383B44F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECABB1C244E0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760E135411;
	Wed, 24 Jan 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMCiQ/wd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A21353FE
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133321; cv=none; b=GdvIFztXrGwC5WQrjrTcH7TFT2SFULJPFHQ8YNJSqOBuO3CKjeCoxtkAQFWL6zz6TfjhFZgNFZ6OmXOKrj+XSuJ0DwE1NBDlcG3rt5R1to62i4Bng/KCyJTAUN+B/zW4MduxjizOViKkeCk217sf6a9cIhItzOZLMmX38c6jJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133321; c=relaxed/simple;
	bh=n3IPNbbVdKYaZpgAPJ5BWufRGEN+w7t+TDaWYJv2krA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ3U95jn5uz7JKnpxRU8NplrP5H/Z+DzfC1sw/aVPO5Gh7pAvZuNr/eiiilwGgcHxpzyvgXIvKHuUITAWDuuOSI5x+v85YFwEkvhW1mZaN9gVSE244K8rvfFTLwnO60kqUu8Qh5pg+zh/FFAgriCeKZylEb399emtuL1tsHxBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMCiQ/wd; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so3404239f.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 13:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706133319; x=1706738119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5kAKftFuR26zLdPSqWeCQwMFVTeeC/w9h4h4ULb/2E=;
        b=fMCiQ/wdcNs8p2JZ6apk5uNnZeUc5gY1cjzgAB0fMHgjkIti8Z+XZRpK4Fn2MzgYu5
         SfD1loiTy+WhUuMMnt4jSED+K8e6qewIX2iIhY7B3oIFOmPcOfkUmPyyjpBonl+plv/E
         uZ6npkCkypTAmfiLnGsuUB3tYuaZToZzr5GAR/brNY85mvY3Cs72+/QnA+9vyOMD3r00
         z/5mVLcZ5+23Jmx8bbr4yFccizl/cYpFH/6L7+u2HgLtjx4II0tEK6R5GewXaPJ0pmBx
         IwO15ryj28dCVRs6iy4K1cqh9mMemp4ACx/RVJ7zk3dxZGviUf+cPgRNgTyKX0xgxUHj
         o07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133319; x=1706738119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5kAKftFuR26zLdPSqWeCQwMFVTeeC/w9h4h4ULb/2E=;
        b=BjnaP2SYWaN5Zi3N8T8blR9imr4ACmL0eoRpptuKQzBwpWmExxr71OiLN3FyKHPfVg
         /aNbpjAklLZdQ5ACHVgsGnIAV42Ax5Tju8DwWuuJP/IGP0VAYnmfIOi/l0PE8/uHAo8O
         Kmg/tURPOkPYKD3a08RwlWdof2VWUq7L9gT9gxzU7Qbixn8bRJEWS1OcXL4SUbkukdIq
         kInTFPXzf2vvG6Q1XRroIAGxGnEt6VyOCxYa2ckDM+iO+NPsOtffuRj6XzQVG/d2mFOn
         7DoW74ZhFA9M1jhdOXQbTmKreTN5msXSs+npwK1oBTs8FF/iK8RVU7wj1Ybi7WKvaMR4
         Hbmw==
X-Gm-Message-State: AOJu0YwMtIdbfZMmac4U5s6e5nhTlJ37epBTSVSVXCAYgIXRPj6TARGX
	84t0+LGIZwfC633ZF6wzDdBY4qkrfOvd/KMetiOKHUUjEzyzJ5X75N8eUvis
X-Google-Smtp-Source: AGHT+IF5fvenDqwEHCLs7vxXOp+mW8H407CIyJLqns2q3dXJqGUBfQei/3fXVPbrfwSG1oI0WQdBig==
X-Received: by 2002:a05:6e02:1b08:b0:360:8cd6:5637 with SMTP id i8-20020a056e021b0800b003608cd65637mr164479ilv.23.1706133319347;
        Wed, 24 Jan 2024 13:55:19 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:3c2c:1afc:52ff:38e7? ([2601:282:1e82:2350:3c2c:1afc:52ff:38e7])
        by smtp.googlemail.com with ESMTPSA id j30-20020a02cb1e000000b0046f1c29757esm207867jap.15.2024.01.24.13.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 13:55:19 -0800 (PST)
Message-ID: <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
Date: Wed, 24 Jan 2024 14:55:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Heng Guo <heng.guo@windriver.com>
Cc: Vitezslav Samel <vitezslav@samel.cz>, netdev@vger.kernel.org
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240124123006.26bad16c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 1:30 PM, Jakub Kicinski wrote:
> Thanks for the analysis, Vitezslav!
> 
> Heng Guo, David, any thoughts on this? Revert?

Revert is best; Heng Guo can revisit the math and try again.

The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
shown in proc but never bumped in the datapath.

> 
> On Sat, 20 Jan 2024 10:23:18 +0100 Vitezslav Samel wrote:
>> 	Hi!
>>
>> In short:
>>
>>   since commit e4da8c78973c ("net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated")
>> the "Ip6OutOctets" entry of /proc/net/dev_snmp6/<interface> isn't
>> incremented by packet size for outbound forwarded unicast IPv6 packets.
>>
>>
>> In more detail:
>>
>>   After move from kernel 6.1.y to 6.6.y I was surprised by very low IPv6 to
>> IPv4 outgoing traffic ratio counted from /proc/net/... counters on our linux
>> router. In this simple scenario:
>>
>> 	NET1  <-->  ROUTER  <-->  NET2
>>
>>   the entry Ip6OutOctets of ROUTER's /proc/net/dev_snmp6/<interface> was
>> surprisingly low although the IPv6 traffic between NET1 and NET2 is rather
>> huge comparing to IPv4 traffic. The bisection led me to commit e4da8c78973c.
>> After reverting it, the numbers went to expected values.
>>
>>   Numbers for local outbound IPv6 seems correct, as well as numbers for IPv4.
>>
>>   Since the commit patches both IPv4 and IPv6 reverting it doesn't seem like
>> the right thing to do. Can you, please, look at it and cook some fix?
>>
>> 	Thanks,
>>
>> 		Vita
>>
>> #### git bisect log
>>
>> git bisect start '--' 'include' 'net'
>> # status: waiting for both good and bad commits
>> # good: [fb2635ac69abac0060cc2be2873dc4f524f12e66] Linux 6.1.62
>> git bisect good fb2635ac69abac0060cc2be2873dc4f524f12e66
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [5e9df83a705290c4d974693097df1da9cbe25854] Linux 6.6.9
>> git bisect bad 5e9df83a705290c4d974693097df1da9cbe25854
>> # good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
>> git bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>> # good: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> git bisect good 6e98b09da931a00bf4e0477d0fa52748bf28fcce
>> # good: [9b39f758974ff8dfa721e68c6cecfd37e6ddb206] Merge tag 'nf-23-07-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
>> git bisect good 9b39f758974ff8dfa721e68c6cecfd37e6ddb206
>> # good: [38663034491d00652ac599fa48866bcf2ebd7bc1] Merge tag 'fsnotify_for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
>> git bisect good 38663034491d00652ac599fa48866bcf2ebd7bc1
>> # good: [7ba2090ca64ea1aa435744884124387db1fac70f] Merge tag 'ceph-for-6.6-rc1' of https://github.com/ceph/ceph-client
>> git bisect good 7ba2090ca64ea1aa435744884124387db1fac70f
>> # bad: [ea1cc20cd4ce55dd920a87a317c43da03ccea192] Merge tag 'v6.6-rc7.vfs.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
>> git bisect bad ea1cc20cd4ce55dd920a87a317c43da03ccea192
>> # bad: [b938790e70540bf4f2e653dcd74b232494d06c8f] Bluetooth: hci_codec: Fix leaking content of local_codecs
>> git bisect bad b938790e70540bf4f2e653dcd74b232494d06c8f
>> # bad: [6912e724832c47bb381eb1bd1e483ec8df0d0f0f] net/smc: bugfix for smcr v2 server connect success statistic
>> git bisect bad 6912e724832c47bb381eb1bd1e483ec8df0d0f0f
>> # bad: [c3b704d4a4a265660e665df51b129e8425216ed1] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
>> git bisect bad c3b704d4a4a265660e665df51b129e8425216ed1
>> # bad: [82ba0ff7bf0483d962e592017bef659ae022d754] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
>> git bisect bad 82ba0ff7bf0483d962e592017bef659ae022d754
>> # bad: [dc9511dd6f37fe803f6b15b61b030728d7057417] sctp: annotate data-races around sk->sk_wmem_queued
>> git bisect bad dc9511dd6f37fe803f6b15b61b030728d7057417
>> # good: [7e9be1124dbe7888907e82cab20164578e3f9ab7] netfilter: nf_tables: Audit log setelem reset
>> git bisect good 7e9be1124dbe7888907e82cab20164578e3f9ab7
>> # bad: [4e60de1e4769066aa9956c83545c8fa21847f326] Merge tag 'nf-23-08-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
>> git bisect bad 4e60de1e4769066aa9956c83545c8fa21847f326
>> # bad: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
>> git bisect bad e4da8c78973c1e307c0431e0b99a969ffb8aa3f1
>> # first bad commit: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
>>
>>
> 


