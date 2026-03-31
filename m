Return-Path: <netdev+bounces-273406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L7GM3cWy2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74333362AE1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8DD304742B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FD27A904;
	Tue, 31 Mar 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnB/PLAU"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C32741B6;
	Tue, 31 Mar 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917006; cv=none; b=IjdNOH9Y6qBrWK5cLNt4atorhGzsbfWFWdrQkf7SsCo+Un0LGlVv2gkRFvVufuBuTjNY2gdl9D5DWkUTZKCuX/L1QDKNxEH5r+0dQwzL47q5B2yXZBOODIHbI4mfXqX271TfcKcSmfJ+1IVFun8DngTV4UnKqnusa8GGXSXD9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917006; c=relaxed/simple;
	bh=IGExde06qVF10qxh8DiBZsjvIIDhZt/JqkJu5UjWtog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHRkzDRGcrKWAtLzCaBIOL+rtzZoeDEMfrdIPE1OrfOnZy2s0fwi9fyeOYqZ3SiGVj7ek3sCmZ9BXPEmPgOyBMkIGJ4R2PlEYYDFvhDwBLGsWJCr93fURuMLP1is3ZFENpN4qgaT4I15gNsQMCXMQLVuzuPLbRn2/QbEAjIalzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnB/PLAU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ab2a379-8166-43b9-a26f-324295069dec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774916993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqJ2TyHriLW4kqacC8FHtakgb5SkSoHTUa2vGoSe/j4=;
	b=fnB/PLAUWrS9UFBAIcuImH+89EZq2XkoWDaAwIjI6UYb9wXmigPL12gIrBkckCZaMPDahJ
	oIjoyKrsyzp5Zxn/zB1PzbIzzrxXfsc7SgEy9G2RssEqTSmlwf3RQG82YmbGSdxBA/tfJ8
	CekDTExNfnThhOBjugFPi9rAjjZK8cc=
Date: Mon, 30 Mar 2026 17:29:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test that dst is cleared
 on same-protocol encap
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260329180428.2657785-1-kuba@kernel.org>
 <20260329180428.2657785-2-kuba@kernel.org>
 <3532664e-1f62-412c-9819-b048f62da010@iogearbox.net>
 <20260330162908.7413feb1@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260330162908.7413feb1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,iogearbox.net:email]
X-Rspamd-Queue-Id: 74333362AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 4:29 PM, Jakub Kicinski wrote:
> On Mon, 30 Mar 2026 10:03:46 +0200 Daniel Borkmann wrote:
>> On 3/29/26 8:04 PM, Jakub Kicinski wrote:
>>> Verify that bpf_skb_adjust_room() clears the routing dst even when
>>> the encap L3 protocol matches the original packet (e.g. IPIP).
>>> The dst selected for the inner packet is not valid for the
>>> encapsulated result; a stale dst could lead to misrouting.
>>>
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>
>> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
>>
>> For new tests we should ideally only be using tcx links and not the old
>> qdisc approach unless there is specifc reason to. Any objections if I
>> fold this in while applying?
> 
> Sorry for a late reply, of course don't mind, thanks for handling it!

I have folded Daniel's changes to the selftest. Applied. Thanks.

