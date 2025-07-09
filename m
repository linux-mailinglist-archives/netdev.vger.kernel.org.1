Return-Path: <netdev+bounces-205327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCFAFE361
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA24E8144
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B568281525;
	Wed,  9 Jul 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aShfP3nD"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9D28137E
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051525; cv=none; b=ae0x7PKDCIb4VFFFC5bk0PWY10KTHRs6wpldJ0wcyDbL2ahN67hzDXgsAE1jC5JENbxpAW9vK0Ych9+wMRgHyVGSeMCXIWlAgkgkHojkUF+4bTEX1aIzDAIQeKPcWBj2SCpk71xA5LI2hDsew/rgtwcBiSjHQiliUR8m47Dl3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051525; c=relaxed/simple;
	bh=U9/cmNWHSKmPc3QSgv92YKAiDqZjIrfs5dRo8/xJljo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yb+2NwPr8dvx6JgpJtB9J8/NvInVZRL+8ijvbQS8Tp+1spmLmqCNrETnJ6R6W3rg9u/y3qKEAdo3GlY2yoVrKLE+ssdBf7aFOlCiiCIBw/3huUlNuOzhFjJfANpeB4MPgdPk2vWoogT5yTZOX6Tr9SY26PFiJsI0S2RL3leGqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aShfP3nD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <540c2855-da19-4562-ac17-d85225886732@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752051519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dux8HAaVmUxWXS8Gbs3Xy9RMiPdruTHWLLZ5gnv1ECE=;
	b=aShfP3nDbvgVx7l9jECP1YajsjEoxOUiiJ23tNZpdsd+c9JhApnCCwa3QZ9JNHJwkOXtmk
	2QcboS3rjOC3HGbRPfyj7Ryuh1WzCmiv6wMPpk6Le07Omn/ZlsUNNqhVpXWbhultsRcLgf
	r19FWoNPQ4qS9KeptPURc9+hHrUrf5Y=
Date: Wed, 9 Jul 2025 16:58:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/7] bpf: Remove attach_type in bpf_netns_link
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 horms@kernel.org, willemb@google.com, pablo@netfilter.org,
 kadlec@netfilter.org, hawk@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
References: <20250709030802.850175-1-chen.dylane@linux.dev>
 <20250709030802.850175-6-chen.dylane@linux.dev>
 <874ivlg4fq.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <874ivlg4fq.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/9 16:21, Jakub Sitnicki 写道:
> On Wed, Jul 09, 2025 at 11:08 AM +08, Tao Chen wrote:
>> Use attach_type in bpf_link, and remove it in bpf_netns_link.
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/net_namespace.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
>> index 63702c86275..6d27bd97c95 100644
>> --- a/kernel/bpf/net_namespace.c
>> +++ b/kernel/bpf/net_namespace.c
>> @@ -11,7 +11,6 @@
>>   
>>   struct bpf_netns_link {
>>   	struct bpf_link	link;
>> -	enum bpf_attach_type type;
>>   	enum netns_bpf_attach_type netns_type;
>>   
>>   	/* We don't hold a ref to net in order to auto-detach the link
> 
> Nit: Doesn't that create a hole? Maybe move netns_type to the end.
> 

Hi Jakub,
You are right, i will change it in v4, thanks.

pahole -C bpf_netns_link vmlinux
struct bpf_netns_link {
	struct bpf_link            link __attribute__((__aligned__(8))); /* 
0    80 */

	/* XXX last struct has 7 bytes of padding */

	/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
	enum netns_bpf_attach_type netns_type;           /*    80     4 */

	/* XXX 4 bytes hole, try to pack */

	struct net *               net;                  /*    88     8 */
	struct list_head           node;                 /*    96    16 */

	/* size: 112, cachelines: 2, members: 4 */
	/* sum members: 108, holes: 1, sum holes: 4 */
	/* paddings: 1, sum paddings: 7 */
	/* forced alignments: 1 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

> [...]


-- 
Best Regards
Tao Chen

