Return-Path: <netdev+bounces-273072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG6ZO30PymmX4wUAu9opvQ
	(envelope-from <netdev+bounces-273072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:51:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA775355BEF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 923C03005AD4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B337F8A3;
	Mon, 30 Mar 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CSFe3j4v"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E4285CB9
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849914; cv=none; b=BnVmVrumRImzhk9qfZGDlSKMs3gZTXGiWlcA2XgSA0IAv8i8bMnSIlQlnriP67EnB1TE+zvz6UHnQ2aYotB7WOHV+cSQMnEb5z2IhWSnf2W4+sSbsX4mP3PNmubNU5Ru/mRg9hp8U6TOr24q+uAEyL1uaCvwhj7ZvrGHQgTi6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849914; c=relaxed/simple;
	bh=h69unk6IdGQcnGcEAbMDZVMrP7GK6c3oW9vGjsESLkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVdY3IgDFrfPnQhj6nvOT0cupiOlZjUOXjFbQ2F+Y2fybov0ne04R+DllK9tNB4pQQR7TtsOrBtQvunaYd7TNGIT+LCDerAcTHdtZX70VCEW9om9LYkY2aOJgevxAzjYY75v3NPOyS6c2TwWDTuaeOcQmbb7lqQ4k4Hn8P8uDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CSFe3j4v; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <964c4090-d939-4d0b-a0fc-156feb3c0c68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774849901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCV2Xx45S8pCgxzDwB3s2LIMPJDnbsciGgZ7CqnTIaM=;
	b=CSFe3j4voYTNDqEEpPKqluWLTk+J3NFXow3aJ4jXqCVvqrmEFrJUTtTthn8f/AzprCXLQE
	5w+GuGAB5Hghm/8bzU4hyuNjMfvI7/YidsRiv7fn0wJVfQinwcGR4XC6eq0V3dN3VgYkJ7
	GD6VxxxfePe2LJZAIAw88ONWSGH1Z4A=
Date: Mon, 30 Mar 2026 13:51:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-3-leon.hwang@linux.dev> <acbrlN_n4Z684h9e@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <acbrlN_n4Z684h9e@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273072-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA775355BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/3/26 04:41, Jiri Olsa wrote:
> On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
[...]
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6404,6 +6404,14 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
>>  		/* remember the offset of last byte accessed in ctx */
>>  		if (env->prog->aux->max_ctx_offset < off + size)
>>  			env->prog->aux->max_ctx_offset = off + size;
>> +		if (env->prog->type == BPF_PROG_TYPE_EXT) {
>> +			struct bpf_prog *dst_prog = env->prog->aux->dst_prog;
>> +
>> +			if (env->prog->aux->kprobe_write_ctx != dst_prog->aux->kprobe_write_ctx) {
>> +				verbose(env, "Extension program cannot have different kprobe_write_ctx value with target prog\n");
>> +				return -EINVAL;
>> +			}
>> +		}
> 
> would it be more clear to check this in bpf_check_attach_target,
> instead of depending on actual write to context
> 

I've considered it.

But we can't, because bpf_check_attach_target is before check_ctx_access
at load time.

Besides, sashiko has pointed out that this check in check_ctx_access can
be bypassed when attaching to kprobe_write_ctx=false target [1].

So, I posted v2 to do the check in bpf_tracing_prog_attach at attach
time [2].

[1]
https://sashiko.dev/#/patchset/20260324150444.68166-1-leon.hwang%40linux.dev
[2] https://lore.kernel.org/bpf/20260326141718.17731-1-leon.hwang@linux.dev/

Thanks,
Leon


