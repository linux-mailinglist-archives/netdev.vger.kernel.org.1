Return-Path: <netdev+bounces-269326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIy0KFafu2nplwIAu9opvQ
	(envelope-from <netdev+bounces-269326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:01:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B82C708D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BF24301869F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A23815D1;
	Thu, 19 Mar 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jPXlbjNs"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBA26A1A7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903693; cv=none; b=kjf224SlJUNu6UH/jcV3pgvQC+ueePw32Yn2BP//d9Wl4bSUXDwAVCcOO4lZyAho4XfeJlSwwvy9VK6wwvHn2VeaddtD7oHRsh8CFzXKiCYRH4Z9hazyVFlxM80Hv8hLK4T0kVlC1Eh+joMCwS+qOyoH2uB7BMjk7k6WSyE3gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903693; c=relaxed/simple;
	bh=UHCZu0hr1nMZo/bzZnMM4KOj/DYRmk7BHgpaFY+E2Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRgcn+/d3MXWFonseCvxY59XJbL8lCdjGs1DOhPczToGEp9HnjIqLUvtzJzSLbTzaoDGJVq1VV5Cwzkc1Zb3dZLPV4E7qkn99wCm5L1YEpukl/AmafMVPk+QXG8eA1gNKSsoFvxupiYgQDdAMJzCNx33dyhGfYgURcVwCaeRxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jPXlbjNs; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UHCZu0hr1nMZo/bzZnMM4KOj/DYRmk7BHgpaFY+E2Fk=;
	b=jPXlbjNs1abA7oQBJbyiMPOI3CL9sV1ATrPuCmhl9y+bqDrk78tOMquulmkzkt
	zV83cQOpwysCQFcfhVcnkRYop2Zwc8XCnOjs8KqF8YBIeJvu6fQuxXqAFBkx0mBu
	qp8Fw8dNuzKZ4AsWEjvvMq07JSwJsjDWhSpGqjK1rcR/Y=
Received: from [10.54.24.32] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnbKgdn7tpU2mXAA--.8182S2;
	Thu, 19 Mar 2026 15:00:46 +0800 (CST)
Message-ID: <7186df9b-9085-4a8a-8e75-4cddbe8f4c0e@163.com>
Date: Thu, 19 Mar 2026 15:00:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: use RCU-safe iteration in dev_map_redirect_multi()
 SKB path
To: David Carlier <devnexen@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260318162420.7684-1-devnexen@gmail.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260318162420.7684-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBnbKgdn7tpU2mXAA--.8182S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1DAryfXFy8uFyDWF1xZrb_yoWkKwb_W3
	Wvva1kZw43Kw1fC3WIkr4fCry3Jr48Cr9FgryxtF15Grn5Jw1vqF4DZr43u343W3y8Ar98
	G3ZIqanFq34xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU148B5UUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC7B4432m7nx59VAAA3v
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269326-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 685B82C708D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/19/26 12:24 AM, David Carlier wrote:
> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
> hlist_for_each_entry_safe() to iterate hash buckets, but this function
> runs under RCU protection (called from xdp_do_generic_redirect_map()
> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
> dev_map_hash_delete_elem) modify the list using RCU primitives
> (hlist_add_head_rcu, hlist_del_rcu).
>
> hlist_for_each_entry_safe() performs plain pointer dereferences without
> rcu_dereference(), missing the acquire barrier needed to pair with
> writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
> POWER), a reader can observe a partially-constructed node. It also
> defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
> detection.
>
> Replace with hlist_for_each_entry_rcu(), matching the XDP-frame path
> (dev_map_enqueue_multi) which already uses the correct macro for the
> same hash iteration.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Signed-off-by: David Carlier <devnexen@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


