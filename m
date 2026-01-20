Return-Path: <netdev+bounces-251661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DwQKbIWcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:58:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C604E381
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBE01B410BA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CCF3D648A;
	Tue, 20 Jan 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOiXflXT"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AE3ACA7B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952666; cv=none; b=jwnJrntxN0HQW+sK5QYSDt/4pajRMCxnslnzoDndN2r/jdbSuf2cXIHZeMqfOgczLWyDihtE7ywTIAXRptPYKPyC6G9UNWMjr+QfOfAkuzS/VYTTfj5Q0qJGmGshrW3IOczXY++fSw/aeaj4Nt/WkIsTp+iNMsu9UQuEKgnzmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952666; c=relaxed/simple;
	bh=9me34u4oy/zI6wHNONKKIlR5rlAKTeUeC7SYhIdygYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfbhUzBSNrq9mlv2rLP8XRqSfpNKXC/35jBqlRXsUwSiljWqlvlri+AjonR+iJ5Zw8QDJA/cEZlVIAG1GJcjQQH4D6iK13EHHv3PMtkYDzRXFd4HiieYimlrGSz44Xu7lPJejaE+SHKA5U7/NfP3UPwn+/PE95iDJ7J3Xp4jEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOiXflXT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ea85474-d3ce-42c3-8360-1a53eb456879@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768952662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGA5b+grVZQoCK86vVDs2zAsKuW4vEnEne22G7ph12k=;
	b=AOiXflXTbsQOYq3ho0mJCb7oHPfkAW5HuuGcO6gEUAVdCamKYibEXW0oaSaE1seFkTsFdQ
	OqvoFt52HJ24mnBu06P7QCu249FNZTOOQGtW4Y6mII9N7Xb3hCyrJ7EqdL0PVOITVOkOol
	K8MKYtDSyPzwMso2C8mF+2leVw3OMj4=
Date: Tue, 20 Jan 2026 15:44:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, bpf@vger.kernel.org
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-1-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251661-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 26C604E381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
> Prepare to remove support for calling kfuncs from prologue & epilogue.
> 
> Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls already
> contain helper offset relative to __bpf_call_base and must bypass the
> verifier's patch_call_imm fixup, which expects BPF helper IDs rather than a
> pre-resolved offsets.
> 
> Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
> with resolved offsets so the verifier can skip patch_call_imm fixup for
> these calls.
> 
> Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x to
> prevent an ABI mismatch between BPF and C on 32-bit architectures.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


