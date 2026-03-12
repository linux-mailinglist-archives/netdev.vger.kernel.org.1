Return-Path: <netdev+bounces-267066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDyuDxTCsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:39:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212E272BD1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E54305AC8A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF93822BB;
	Thu, 12 Mar 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkOjbUcC"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947D34251B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322761; cv=none; b=kwzpEDQky2znJMmXFQmM3iMfIhxZ0yvbC6eWmoPSvFt78nYhYdu17Vh2UEqwD6eJJvH58nWITXdaMOBGDWX67rTHGtu8kKSYKy4v9s8VglxmfBBIgli9gwuQcHRkwIeK2erj0EM7lNFa3r9L99ThCtYfOmwqVh4heTNDawYTTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322761; c=relaxed/simple;
	bh=uCgy/4a3O45IKbt53bkbdtju6nVoH67NjrRZwRGOQKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnlrLbFLifLU7durtep+NAzn3uy71L3aMbdUZ16McXZLJpFHrzIn/+EJZqovbBRQPc2mU1D3jy/FJGbEdwn/E/daHvg38Js9i7q7L1nLy3RQH6N3nefzM+8/iMfCIDrgWGA1xPJsOYyFsC95cCDy1JPdmaPeSkojf5xbOvHs93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkOjbUcC; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14e9e301-38da-4800-a1a6-9913c8d3cbf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773322757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMYxCY6UeSuDYqBhMw/GjMm6u1qYKBPdLAkA3zqj/aY=;
	b=IkOjbUcC2VEP4LSLMMoZOUZeVQuS5QXzTMHpO6lSR8shlxoVxt9sz6+li1zVGw22ifVZKG
	2hwPY0AvWefeYF1lFoDXA02IOu7sT2HB0bD8QruPmBC9AlSoGRUl9MZlc2+0TT5NNEAZwq
	rPxTrFnaNGpH51JUlmZIGsIc4se4H/o=
Date: Thu, 12 Mar 2026 21:39:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260303150639.85007-1-leon.hwang@linux.dev>
 <20260303150639.85007-4-leon.hwang@linux.dev> <abHwii5stH93Vz5E@krava>
 <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev> <abKZfhWs9Gojuvip@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abKZfhWs9Gojuvip@krava>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-267066-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 8212E272BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/3/12 18:46, Jiri Olsa wrote:
> On Thu, Mar 12, 2026 at 10:24:24AM +0800, Leon Hwang wrote:
>> On 12/3/26 06:45, Jiri Olsa wrote:
[...]
>>
>> Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
>> will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
>> instead of 0.
>>
>> bpf_prog_test_run_tracing()
>> |-->bpf_fentry_test1()
>>     |-->dummy_kprobe()
>>         |-->kprobe() /* via tail call */
>>             |-->regs->di = 0;
>>     return 1; /* instead of 2 */
>> return -EFAULT;
>>
>> Yep, the commit log is not clear to describe this abuse problem. Will
>> update it.
> 
> ah right :-\ ok, I think we need to do the suggested one way check and
> that should prevent kprobes having writeable ctx
> 

Yeah, will apply strict both-ways check. See
https://lore.kernel.org/bpf/8a3c7f14-b3d1-4208-acbd-76e5db6c5320@linux.dev/.

Thanks,
Leon


