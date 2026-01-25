Return-Path: <netdev+bounces-253208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJLuM/N+dmkcRQEAu9opvQ
	(envelope-from <netdev+bounces-253208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:37:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881382648
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0905E3003534
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED62F0C46;
	Sun, 25 Jan 2026 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qw1IPWmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B551CF7D5
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769373425; cv=none; b=F8+h2r75faBGKFEf30D7SruSBT+H1QvYsxuhRo4e3XV/JBjlbvVJ/3SUJurCqtsi3gXhAukTyBff+lBjrd3keFJvcW0XKGzRxGkGpMxbxCHSWz1b6Hp+Vt/s4JqeEM0Ct3FuxrxowWLOLr/AtjqFsvFmHqbY7M8MsB9bfPie8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769373425; c=relaxed/simple;
	bh=KaPXS/Z/c7D152Q/n61SaHtWw2eblop+3/kEWHmsHuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AN0cdCorgMyH4OVll4iaROFvMf2XBpjZ65AyKk+H6kJWRc8afhGN1qfvKx/ehJMkXe81jWpeagGXLCncxSl0A3fpGmmZLPs0/uS6c2FU7AgB9Qr1M0CbBs9B2oEuRHYtPBy25xXnXMJZP6L/Ep06zJsXJyfnlWVQ4BuWXqP2YxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qw1IPWmY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8849dc12f6so568178866b.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769373422; x=1769978222; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6PV7Aw1GuCHemjI6CRSwhEaXuqwDH59s8evm2BBYZE=;
        b=Qw1IPWmYFB0+6h6ZiIm1fa/iOlZvllRVg2MaAEL9LvX9K/MFR9g6U0XdPt+ryrh9bl
         lKztIaNpPX4LJ5oDo95onJVbHxbhvaD9uqJjwdE35dax7Ntlfo8OgeACgBEUI07EBUcu
         d3OzZzEX+mflDNDEBFdJmUZvemHRFn4STY36xFBwteF/8sQ8/AtKA2avzowRW+2NKCzs
         qpqjCpdmdGYKWNlEO0zhUrQRaIApPpKG6ZeA9ePa2CvkbYdFdL+UOOlDyWxE3uVIGqJW
         QQXEUS4vfO+OLX0e0VXuP45Je25lMkrcy5qZ6LBCCHTk/93h6/HImBfz35aXNw/qyORU
         OcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769373422; x=1769978222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6PV7Aw1GuCHemjI6CRSwhEaXuqwDH59s8evm2BBYZE=;
        b=MFw+DB4Pb7JtwSYWS1FnV+mU0fN8rkdUC8OmjfEds5Kt0k8eQv/wMg7vKysG6Szb5f
         zVoriOFfDHJQBQyvkzr/mszcwFQXoK718eMezW10+upkypzSe33GoYtGOm4HsCEYH4oi
         CrEqSBs9JHFPHNq/ko7uk0ZYegDjCVhiD8au8uLbp8q2KH7VtEg/SEwMcHdI5obdXTzR
         vNerTYeLZM5LBXY8HgIad0H7B3RypI+zGUgd1TTiMMlUbXOYZE1GbmhealEBEuSO3DD6
         HxgXS40Ycseh0Mg4nfn5gvwG/64f456jdlhG36iuURq6AJg3Ezlw97MkFT+BWstb7btQ
         /Hhg==
X-Forwarded-Encrypted: i=1; AJvYcCUMQPnk/kQsUIMhsnwZJJLARxPzm+QWowzyb+lEqxtJcav0QVFg0IlJXnTaW5nyw46sqvpitIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJo+crK8xLGkTvhVe9PcrAgAvxRxAlYRwrW2eef6h/pycH46N
	KuSdu8NqIy/q9pIrOHSOG2GKMeEPttYHD3eMOMgJhMKcIIZ5UBf0wk+WqLKEO1zhTiw=
X-Gm-Gg: AZuq6aLwPlDE9BT38lup/huNBXFRrW8nxO3IQrd9QqXN+cYqvIvR1+DMs+2V/Lc+Ox7
	qh+WTF5iDk1UvEZiEDynG6ldqGkkja4Aem74dvlrcs1jmzhxAGtANeOWbntmQhWTRxPTIsec5od
	vFwzVTYPY2felXjkmd1J0AB74+DKHzTeZbt2JsoK1KSlKq76v+ZNW82Ih1UoKZV/PJZMBGEk13U
	nOKnFOI7VsZ0U/XJ8yWihUKXWJ/tZ1novCNtfFSxe09o/vP9NHlznkW3zX1YCxMM9G7qN9KVI+I
	mN3tAFLNTT5z5Gt1I+GT6Id/Dbio3ySsoQk3snP0kfuYluQuJC+/WYQ0oHl5zD64MuP76+64udr
	guumORCZnpvmYgfS9VM53IKCdB1Clm2rBhOr5lnDp/E2hnHjC9WtQD0LAJzm8MSQA1hDk0gP0tk
	/5+zU=
X-Received: by 2002:a17:907:9710:b0:b87:206a:a241 with SMTP id a640c23a62f3a-b8cfedfc951mr173619466b.11.1769373421994;
        Sun, 25 Jan 2026 12:37:01 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4d7sm507309066b.45.2026.01.25.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:37:01 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,
  ihor.solodrai@linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper
 calls from prologue/epilogue
In-Reply-To: <bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev> (Martin KaFai
	Lau's message of "Fri, 23 Jan 2026 15:49:34 -0800")
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
	<20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
	<bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev>
Date: Sun, 25 Jan 2026 21:37:00 +0100
Message-ID: <874io9tonn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253208-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2881382648
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 03:49 PM -08, Martin KaFai Lau wrote:
> On 1/23/26 9:05 AM, Jakub Sitnicki wrote:
>> @@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			goto next_insn;
>>   		}
>>   patch_call_imm:
>> +		if (env->insn_aux_data[i + delta].finalized_call)
>> +			goto next_insn;
>> +
>>   		fn = env->ops->get_func_proto(insn->imm, env->prog);
>>   		/* all functions that have prototype and verifier allowed
>>   		 * programs to call them, must be real in-kernel functions
>> @@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			return -EFAULT;
>>   		}
>>   		insn->imm = fn->func - __bpf_call_base;
>> +		env->insn_aux_data[i + delta].finalized_call = true;
>>   next_insn:
>>   		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
>>   			subprogs[cur_subprog].stack_depth += stack_depth_extra;
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index d14401193b01..cb39388f69a9 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
>>   	/* ret = bpf_skb_pull_data(skb, 0); */
>>   	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>>   	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
>> -	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
>> -			       BPF_FUNC_skb_pull_data);
>> +	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
>
> Ihor reported that the test_map has started failing on arm64.
>
> https://github.com/kernel-patches/bpf/actions/runs/21298510237/job/61311053284
> https://github.com/kernel-patches/bpf/actions/runs/21298505282/job/61312363930
> https://github.com/kernel-patches/bpf/actions/runs/21301695907/job/61321375157
>
> For BPF_PROG_TYPE_SK_SKB, the BPF_FUNC_skb_pull_data has a different
> func_proto. It is sk_skb_pull_data instead of bpf_skb_pull_data.
> A different func needs to be emitted here based on prog type.
> Not sure why it only fails on arm64.
>
> The set has been reverted to get the CI going.
> Please address the issue, add a test for this case, and
> then respin. Thanks.

Sorry for this oversight.

I see now that sk_skb_pull_data doesn't bpf_compute_data_pointers which
writes over skb->cb. Perhaps that has something to do with the failure.

Will get this sorted.

Expect some delay. This is a pre-conferece week (FOSDEM).

