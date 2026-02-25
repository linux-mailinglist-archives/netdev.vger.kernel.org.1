Return-Path: <netdev+bounces-261013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJMSGuATn2nhYwQAu9opvQ
	(envelope-from <netdev+bounces-261013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1F199874
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 663543079AAF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E96280CFC;
	Wed, 25 Feb 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtFB3V3h"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AA27280F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032579; cv=none; b=E7sDDSBaBMi0TZEJBjMhdCLP4fAg1wGVeLNB6EeonZllPtQscfgqYBoBlTNVimGbM6fKjAdoMK/+iofe+WpfpnGSjzGxshCnNIrwdc7MU+rlgw2rPSddX+aOxgQkvr6IccUBHaagHU22NTcrgflP2FB3PZM3GUPc7YF530ewa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032579; c=relaxed/simple;
	bh=2v4+h7fONrljMow2c+RVTQnuVYSvEGGP7MQ7qIyqGpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIeMvKa11KBJhiczeB2cxvjdRjx/6f8OiG43HG5M/X+2WGmW7kTDa7+DUhl3R2eeQqs/Qrpc9Tkm4lsoAxC5MpWeqjsZCnVPc/P5bakGcCsqkHJQLcGc7bwNy8dCNLF24D4H80nPvlfxrH77g6LZU+Ao573w8QurwrQbtK+tSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtFB3V3h; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0383ff36-df20-4376-9374-99ff32a527f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772032575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ht1IsfkuNiCWNDQxQQ9oeNsmgvwISL3gSGHhQ9b5ks=;
	b=wtFB3V3hJzoIj/6NCuu3CNIh/Ni0VeK128IyhG0t+3YpgSOC3/IIplpDBSjrRLxQ6uFU0E
	OOT9IHx1+YFteW01mvPoNroI5jrz/FoIOqnIUUeLVf1zFZQyfPr/axPf9h3HUj1g1i7JCN
	dmNqcRNbf5fp3U4Vq8kXZ1O+wL5qpXg=
Date: Wed, 25 Feb 2026 23:15:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Feng Yang <yangfeng@kylinos.cn>, Menglong Dong <menglong8.dong@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
References: <20260224154024.12504-1-leon.hwang@linux.dev>
 <20260224154024.12504-3-leon.hwang@linux.dev>
 <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261013-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: E5F1F199874
X-Rspamd-Action: no action



On 2026/2/25 00:57, Alexei Starovoitov wrote:
> On Tue, Feb 24, 2026 at 7:41 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> uprobe programs that can modify pt_regs require different runtime
>> assumptions than pt_regs-read-only uprobe programs. Mixing both in
>> one prog_array can make owner expectations diverge from callee behavior.
>>
>> Reject the combination of !kprobe_write_ctx progs with kprobe_write_ctx
>> progs in __bpf_prog_map_compatible() to address the issue.
>>
>> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h | 7 ++++---
>>  kernel/bpf/core.c   | 3 +++
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index b78b53198a2e..2a2f6448a5fb 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -285,9 +285,10 @@ struct bpf_list_node_kern {
>>   */
>>  struct bpf_map_owner {
>>         enum bpf_prog_type type;
>> -       bool jited;
>> -       bool xdp_has_frags;
>> -       bool sleepable;
>> +       u32 jited:1,
>> +           xdp_has_frags:1,
>> +           sleepable:1,
>> +           kprobe_write_ctx:1;
> 
> Don't you see how much churn you're adding this way?
> Every patch has to touch two lines instead of one.
> Use
> u32 jited:1;
> u32 xdp_has_frags:1;
> 

Ack.

> also the bot is correct on patch 2 and 3.

Agreed.

Here's a concrete example that breaks the constraint:

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?kprobe")
int prog_a(struct pt_regs *regs)
{
	regs->ax = 0;
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

SEC("?kprobe")
int prog_b(struct pt_regs *regs)
{
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

The constraint can be broken by:

* Load prog_a first.
  At this point, owner->kprobe_write_ctx=true.
* Load prog_b next.
  At this point, prog_b passes the prog map compatibility validation.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, the regs will be updated via prog_a.

> Don't be fancy. Require strict conformance both ways in *all* patches.
> 

It was to avoid awkward UX.

For example, the tail call from prog_a (kprobe_write_ctx=true) to prog_b
(kprobe_write_ctx=false) should be allowed. If prog_b is required to be
kprobe_write_ctx=true, prog_b will break user's expectation that prog_b
should not always update ctx.

The same awkward UX applies to call_get_func_ip, call_session_cookie,
and call_session_is_return.

I'll find a way to avoid such awkward UX by keeping the one-directional
validation, and to avoid the aforementioned constraint-broken issue at
the same time.

> And your codex selftests are garbage. I don't have other words
> to describe it. They are not testing the actual bug that
> your patches are fixing. Think of what you're doing.
> Asking LLM to write a test for your other patch is not what you
> should be asking it to do. The selftest should be such that
> it proves the unsafety/crash before the fix.
> 

OK. I'll reimplement the selftests by myself in the next revision.

Thanks,
Leon


