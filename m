Return-Path: <netdev+bounces-262985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDwdHNA9pmkZNAAAu9opvQ
	(envelope-from <netdev+bounces-262985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:48:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D31E7D10
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4D03030EC5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F206364EA5;
	Tue,  3 Mar 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p9h32Ka7"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8932AADC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502477; cv=none; b=b4cWLuvQ9ckqRbJQUVoDNfGVjEktYE44YcgsBDIKwqvt68AEnsw/VU4sb1xmoDqPi0DlDTjQXQYjphGuLdRXf2G8MjRv6/hN0Syji4H6fhksPMkmhvu7cUVH4W9gdtg7qMaBW89jCCifcvUQWw8Yg3grCs8gMGN5dwnNzNlwjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502477; c=relaxed/simple;
	bh=aoMEVQ5LUbx119Jr5j4ceub8JG6Junu39T7U3pDYlsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUIL1lO8sCN6a/iT7KMvzkeWZ7UXQhaVh1Nf6z73hdeg0W6zeADWvGvZOjO/lsLKX/wsgfuLjFygnvbQHklaTQuKtFrjUeJcYlhpBr8uS06gdeTl0z+kQuT3CE2ofJhL0KvwMgjYpUZ/LA4AialelKjbQCWU8uIRaVfa9lFMmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p9h32Ka7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b6fd20c-83e5-4152-b28a-fed55c4e2d4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772502474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7CIzyP9wR0VJBHipYkJvXUaV4HJEK+fjwhplqHqBos=;
	b=p9h32Ka7qR+MFuTWRhB2htAsqJHjiblMVnZ8TfbDKKoWyTo7pXsUGxXJ2q5LKasQWwkgme
	ZYSIuz070uiSe6Ubj4fbVtVmehthHzFHQbeMWRRzC+A821z7Bg/4MGeWUbN68FWdNDJDEG
	Lgx8dPosVGRI+UNCapqO5NixVXA0/c0=
Date: Tue, 3 Mar 2026 09:47:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Disallow !call_get_func_ip progs
 tail-calling call_get_func_ip progs
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 yangfeng@kylinos.cn, menglong8.dong@gmail.com, puranjay@kernel.org,
 bjorn@kernel.org, pulehui@huawei.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260302150342.55709-5-leon.hwang@linux.dev>
 <abc5556bf4da9afc2d8100cd8937c41e9718f1a14b343d8a398499546157126c@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abc5556bf4da9afc2d8100cd8937c41e9718f1a14b343d8a398499546157126c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DD6D31E7D10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com,meta.com];
	TAGGED_FROM(0.00)[bounces-262985-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[27]
X-Rspamd-Action: no action



On 2/3/26 23:53, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> 
> [ ... ]
> 
>> @@ -2422,11 +2423,17 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
>>  	case BPF_MAP_OWNER_MATCH_FOR_INIT:
>>  		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
>>  			return false;
>> +		if (owner->call_get_func_ip != fp->call_get_func_ip)
>> +			return false;
>>  		break;
>>
>>  	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
>>  		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
>>  			return false;
>> +		if (bpf_prog_has_trampoline(fp)) {
>> +			if (!owner->call_get_func_ip && fp->call_get_func_ip)
>> +				return false;
>> +		}
>>  		break;
> 
> The FOR_UPDATE path correctly guards the call_get_func_ip check with
> bpf_prog_has_trampoline(fp), since only trampoline-based programs
> rely on the func IP stored on the trampoline stack. Kprobe programs
> get func_ip from kprobe_running()->addr via bpf_get_func_ip_kprobe(),
> which is independent of the trampoline.
> 
> Should the FOR_INIT path have the same bpf_prog_has_trampoline()
> guard? Without it, two kprobe programs that share a prog_array will
> be rejected if one calls bpf_get_func_ip() and the other does not,
> even though mixing is safe for kprobes.
> 
> bpf_check_tail_call() calls this with BPF_MAP_OWNER_MATCH_FOR_INIT:
> 
>     kprobe prog_a (call_get_func_ip=1) loads, references jmp_table
>       -> owner->call_get_func_ip = 1
>     kprobe prog_b (call_get_func_ip=0) loads, references same jmp_table
>       -> owner->call_get_func_ip != fp->call_get_func_ip
>       -> returns false, prog_b fails to load
> 
> Something like this would match the FOR_UPDATE scoping:
> 
>     case BPF_MAP_OWNER_MATCH_FOR_INIT:
>             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
>                     return false;
>             if (bpf_prog_has_trampoline(fp)) {
>                     if (owner->call_get_func_ip != fp->call_get_func_ip)
>                             return false;
>             }
>             break;
> 

Correct.

The FOR_INIT path should have the same bpf_prog_has_trampoline() guard.

I'll do it in the next revision.

Thanks,
Leon

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22582690876
> 
> AI-authorship-score: medium
> AI-authorship-explanation: The v1 selftests carried Assisted-by Codex tags, and the kernel code follows a mechanical copy-paste pattern across commits; the v2 selftests were rewritten but the overall series structure suggests AI-assisted development.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The FOR_INIT strict equality check on call_get_func_ip is missing a bpf_prog_has_trampoline() guard, causing unnecessary rejection of kprobe programs that share a prog_array with different call_get_func_ip values.


