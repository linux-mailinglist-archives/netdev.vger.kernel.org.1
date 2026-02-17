Return-Path: <netdev+bounces-259172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOtLNTn5lGktJgIAu9opvQ
	(envelope-from <netdev+bounces-259172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 00:26:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1A151EA4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A103042774
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91B313527;
	Tue, 17 Feb 2026 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvUgKJjp"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAD2F3C12
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370806; cv=none; b=PnC05F3whhi1U95xcMeNPSnTFahK5dbp0dZh37U7OQaJId4CKmZvNJ2RyHw5MkNyU9k8+R8BWCtpw4DObp3PzTp2FVODpjSxpTN3GtVgpIhv8CE/A4e3r/j1JsjWJxnlAsgINuTfCeWhRSJnXzbCgYk5cI9jlQYr35NVpzc82uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370806; c=relaxed/simple;
	bh=j/RworCfYk3woL5j7jSZnA+8/H6/CtqlnalefOGhQ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td9g4hT8Ij0y8WBqqF0d3zOPYR9AcKL3xk8+pHKugxfnAmyogjIN2oepKZdUbNE5gqkAjA3wtqH1Nf7vmrINdNc/naCthDxsv9PtzkG2Qp39J49uHL2EHwbBv5i9xU3ValnIpNBN965dcd/ANIYGRmD43ty/cqIlsN4RUSUnIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvUgKJjp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1bc24867-edde-408e-ac1b-2ca2a41622b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771370801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izRud62R72/Q2Ixi4S6gHYCThWIGKo49JaBchMF76Ec=;
	b=dvUgKJjppqqboXgBoZKaB4cz2Esw42wpPBtkPU6knhjUY3Ytr5JrgAkXRmkCmGDPJvglJb
	eqEu9t+/BQCH2FCdPQAPF4IqKb+K3biw+N26A4IzBVv4lh3FgpQiQ6teOYmTe7qVJ6gPXR
	tdFSB1BpLVg+pypxTGQYPEAJlLTq3WQ=
Date: Tue, 17 Feb 2026 15:26:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
To: Jakub Kicinski <kuba@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
 <20260211075240.70095-1-yangfeng59949@163.com>
 <6528c028-1224-4737-b902-e631641ddb37@linux.dev>
 <20260217140831.52fac4ca@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260217140831.52fac4ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 47C1A151EA4
X-Rspamd-Action: no action

On 2/17/26 2:08 PM, Jakub Kicinski wrote:
> On Tue, 17 Feb 2026 10:08:29 -0800 Martin KaFai Lau wrote:
>>> The reason for the CI test failure.
>>
>> Make sense, but the early point stays the same: the user-provided skb
>> can have unexpected data. Either an skb->protocol is not handled here,
>> or the earlier dst lookup has an error. I don't know what the current
>> active users left in lwt are. Unless there is an issue with missing
>> skb_dst() in other mainstream program types (e.g., tc), I would prefer
>> to add a check in bpf_lwt_push_ip_encap() instead of complicating
>> bpf_prog_test_run_skb() further.
> 
> Can bpf_prog_test_run_skb() simply not support LWT then?

It is a bold move. If we are open to this idea, we can consider to 
retire the lwt support completely instead of only retiring lwt in the 
test_run_skb alone. I think it will still take time to announce and 
deprecate it?

> Having fastpath checks for test harness really feels like duct tape

Adding route lookup on ip[v6]_hdr does not work well either and is a 
larger duct tape on the test_run_skb side.

An option is to always set skb to 'some' dst (loopback or 
ipv6.fib6_null_entry) on all is_lwt cases without doing the lookup. It 
is only to get it going. It is a duct tape also imo but maybe a middle 
ground.

