Return-Path: <netdev+bounces-275509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qTWnKaYh02nAewcAu9opvQ
	(envelope-from <netdev+bounces-275509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1C3A1315
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A0D30057A2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D831C567;
	Mon,  6 Apr 2026 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPM1uad7"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7B311977
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444387; cv=none; b=JegWKqOFSjwV5t1SGwzL5BZcu2SPvtMggwZHNdcBn/X3BP99gqXBu1l7i3EhpBbn/SBRTfctg+rWFsnYSkFGJ752Mi+lKe9HmNqFvZcfllAsYnxC29YWlXor4bR1kjEPrzyIdMX2Mu8efaPa74lVUU35Qnx9jb4pfGnimi0GrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444387; c=relaxed/simple;
	bh=NEjNx16X3MvrbK8jLNLSnKWkbI4CxRfzz8rCKoiMhYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B96Rwfe/W/fI59Iig6753E0nrHKBR2UBYE5a2mgARB+9TIblFApZ68ltTmvfwsPXoHTjM41UaVYWIqT8VFW8713Ozo0cbhOS5j/hCVrYCypEdEG6e1Ehk8BbPazdv/0O3jaLLAuaqzA0yEN1tEDKPLns1n6fRGBdqkIsuX59vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPM1uad7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <346597fc-1703-45d7-bcef-55f5d4a7579c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775444373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67hA3OliRUcWeRg8i0BeGw487zxvix2e4GTW3l9b4HI=;
	b=rPM1uad708uPb3invdA5OX4dYmQkrrWyi7Hmf+JSTIzvhx/GBdbohacnaGfkfMOQ1QyxJN
	482g7pFD7xNrcdd6mJEZe4cjjbEic0nEmpIx6zLj29T+FHovMhlskf2mnOk6Q35/ET8fMG
	tI+ilWhhYrRVIZqyApyjsRwS02msv98=
Date: Mon, 6 Apr 2026 10:58:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
 <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
 <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-275509-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email]
X-Rspamd-Queue-Id: 2AD1C3A1315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/6/26 7:54 AM, Emil Tsalapatis wrote:
> On Sun Apr 5, 2026 at 7:49 PM EDT, Emil Tsalapatis wrote:
>> On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
>>> When a BPF sock_ops program reads ctx->sk with dst_reg == src_reg
>>> (e.g., r1 = *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
>>> fails to zero the destination register in the is_fullsock == 0 path.
>>>
>>> The macro saves/restores a temporary register and checks is_fullsock.
>>> When is_fullsock == 0 (e.g., TCP_NEW_SYN_RECV state with a request_sock),
>>> it should set dst_reg = 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NULL
>>> type is correct at runtime. Instead, dst_reg retains the original ctx
>>> pointer, which passes subsequent NULL checks and can be used as a bogus
>>> socket pointer, leading to stack-out-of-bounds access in helpers like
>>> bpf_skc_to_tcp6_sock().
>>>
>>> Fix by:
>>>   - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>>>     added instruction.
>>>   - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>>>     restore in the !fullsock path, placed after the restore because
>>>     dst_reg == src_reg means we need src_reg intact to read ctx->temp.
>>>
>>> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")
>>> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
>>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>>> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u
>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> This patch only seems to fix the problem when dst_reg == src_reg.
>> Why is this not an issue when is_fullsock == 0, but dst_reg != src_reg?
>> In that case the dst_reg is unmodified by the whole macro but is still
>> marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
>> a test case for is_fullsock == 0 but dst_reg != src_reg in patch 2?
> Sorry for the double post, but also check sashiko.dev:
> SOSK_OPTS_GET_FIELD seems to have the same issue as the
> SOCK_OPTS_GET_SK. Can you add the same fix to it?
>

Thanks for the review!

The AI reviewer's observation about SOCK_OPS_GET_FIELD() is correct —
it has the same bug when dst_reg == src_reg and is_locked_tcp_sock == 0.
I've folded that fix into patch 1 in v2.

Regarding dst_reg != src_reg: this case is actually safe. When
dst_reg != src_reg, fullsock_reg is dst_reg itself, and the generated
sequence is:

LDX_MEM   dst_reg = is_fullsock
JEQ       dst_reg == 0, +jmp
LDX_MEM   dst_reg = sk

The JEQ only branches when dst_reg == 0, so dst_reg is naturally
zeroed on that path — no extra MOV_IMM needed. The same-register bug
exists precisely because dst_reg == src_reg forces the macro to borrow
a temporary register for the is_fullsock check, leaving dst_reg (the
ctx pointer) untouched.

I will add a get_sk_diff_reg subtest in v2.

The other suggestions (moving the detailed comment to the BPF program
file, avoiding vague "the fix" wording) are good points — addressed
in v2 as well.


