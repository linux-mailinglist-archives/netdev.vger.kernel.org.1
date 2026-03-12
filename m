Return-Path: <netdev+bounces-266851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eONnI/EjsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:24:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D426C2F5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C7803019448
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CDA35DA61;
	Thu, 12 Mar 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuIml8+b"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741C33D507
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282285; cv=none; b=Ok2bzUIJ1PeysEPgAfKeE4HGFPLz6MBz8mG+i2FviW+SFx2fM5dJSYx6fhVEloS7vDG2wUj7I7Onp3/mWMXYryK9tNBdgcEX9bcpPI0xRWouvTCwmQc8WYtJziGzNpAsfsSa5w9pdZcM1QEaDLpYcIvvJkeXRmUV+ITPtOYpS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282285; c=relaxed/simple;
	bh=t/o8JZUco4a+9p05JAFPQThPlGv3WyinrLjprD+EYkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bebBfeiZ46Gt5aCsPKZGzHF7piXn+8kdGKgZpDPnsERgEYlp0Y7xzXfzB0N82shHgBxRylGRCqbxgUcRHP+14c/zc6rjI0jL5hua5gTHYFbQBTb8SSJX+VuB5+MzoSx2NaSJrdYnuc2rGBouZ0YV5Mx6/aH6PzoBd++9jmARwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuIml8+b; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <931b490b-ab29-44fc-b888-8ac1ee8d8ccc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773282281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+NS9REi3OjQ/Mu3hl26dakXZd5lzaswGeV0mI0VxH4=;
	b=WuIml8+bFNWIai4pwtX4tSQzikrGoTasWPFRug7mytOWFiHVJNt6mTJkktE1FTWXVKRaLT
	g1ZTGbjjaTi+mrujNQC9o7G5g6Q2iRFeWZg+YXNo/pvsk4EKezOY3WBmG3CzbloTpKjOfJ
	6jEHTin93tow6aBkkOPbIY/3bFRGEoI=
Date: Thu, 12 Mar 2026 10:24:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
Content-Language: en-US
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abHwii5stH93Vz5E@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266851-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 251D426C2F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/3/26 06:45, Jiri Olsa wrote:
> On Tue, Mar 03, 2026 at 11:06:36PM +0800, Leon Hwang wrote:
>> Uprobe programs that modify regs require different runtime assumptions
>> than those that do not. Mixing !kprobe_write_ctx progs with
>> kprobe_write_ctx progs via tail calls could break these assumptions.
>>
>> To address this, reject the combination of !kprobe_write_ctx progs with
>> kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
>> tail callee from modifying regs unexpectedly.
> 
> hi,
> could you please give some example where this is actual problem?
> I'd expect it's up to user (whoever installs the tailcall map) to
> avoid such situations.
> 
The self test in patch #6 can verify the problem, that
kprobe_write_ctx=true progs can be abused to modify struct pt_regs via
tail calls when tracing kernel functions using kprobe_write_ctx=false prog.

Explain the problem by reusing the test code:

int dummy_run;
u64 data;

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} prog_array_dummy SEC(".maps");

SEC("?kprobe")
int dummy_kprobe(void *ctx)
{
	dummy_run++;
	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
	return 0;
}

SEC("?kprobe")
int kprobe(struct pt_regs *regs)
{
	data = regs->di = 0;
	return 0;
}

The "kprobe" prog will be added to "prog_array_dummy" map.

In user space, the "dummy_kprobe" prog will attach to kernel function
"bpf_entry_test1".

Actually, without this patch, when "bpf_fentry_test1" runs, the arg "a"
will be updated as 0. Thus, bpf_prog_test_run_tracing() returns -EFAULT
instead of 0.

bpf_prog_test_run_tracing()
|-->bpf_fentry_test1()
    |-->dummy_kprobe()
        |-->kprobe() /* via tail call */
            |-->regs->di = 0;
    return 1; /* instead of 2 */
return -EFAULT;

Yep, the commit log is not clear to describe this abuse problem. Will
update it.

Thanks,
Leon


