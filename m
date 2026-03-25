Return-Path: <netdev+bounces-271574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFPJAPXsw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:11:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F4326816
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC46330BFCFE
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBC3BD24A;
	Wed, 25 Mar 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0Hgn8yd"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEE18C933
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446880; cv=none; b=kfKvrm+hWB9EX0bNtWHWFzapATiqBQNGjt48hYyR+oqPYCAifFDEQzN4yIo1mjzu6xVQE6OAwY1FmpbBiVUaDyuAz5Qj8CTSaavJjtYGWbjG0MHnmE+82dfBo31H6IJjJ//2zzqd6daLDpfzOyshTE2GrpYvOyJtNXUacI6RlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446880; c=relaxed/simple;
	bh=q+pMp5JVqAvlUlZ++vIPWfFNi3wud0iVLrZfD7M2nR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wpr7GwKy4Cwlbs1Wz1D95zTVd/zIpZu6tqcvCDwryz6ltVPHPWFiAG2+E20eglznUJS/TSILqHMTv/PDEpYNrP7Uxy2Kr9qLWq1QlvUxe/0cLwCqGS3Z3CDi8YUuIaFdRbA7ysybWCKqwV2Sszbq/0YYLR1Z/9ZUL0Zo0NxH1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0Hgn8yd; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e960b3f-bc29-4d92-8af0-ec207e3946f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774446875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxQsf2q1ci5YPhXSa4LVGW35p81aNPC6dkLRQOM/qOs=;
	b=m0Hgn8yd2lA+M1l0fBoYvP9D17kDemrGYGXcJYrOFSRmYnjvWysNwrt1vpwkRn0Rg+K9as
	SzLq4wyTslbyXJ2rssrnv2NtZfsfjF0fH6yZqy5kY/Orv8GtIK42qRtJoKCv75rpBT1j04
	4KLOYm5gie+PIWtLQYp8sSuoupKQaYI=
Date: Wed, 25 Mar 2026 21:54:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with
 mismatched kprobe_write_ctx values
To: Jiri Olsa <olsajiri@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
 <20260324150444.68166-3-leon.hwang@linux.dev> <acPaTdLd70YI_uNW@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <acPaTdLd70YI_uNW@krava>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 9B7F4326816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/3/25 20:51, Jiri Olsa wrote:
> On Tue, Mar 24, 2026 at 11:04:43PM +0800, Leon Hwang wrote:
>> uprobe programs are allowed to modify struct pt_regs.
>>
>> Since the actual program type of uprobe is KPROBE, it can be abused to
>> modify struct pt_regs via kprobe+freplace when the kprobe attaches to
>> kernel functions.
>>
>> For example,
>>
>> SEC("?kprobe")
>> int kprobe(struct pt_regs *regs)
>> {
>> 	return 0;
>> }
>>
>> SEC("?freplace")
>> int freplace_kprobe(struct pt_regs *regs)
>> {
>> 	regs->di = 0;
>> 	return 0;
>> }
>>
>> freplace_kprobe prog will attach to kprobe prog.
>> kprobe prog will attach to a kernel function.
>>
>> Without this patch, when the kernel function runs, its first arg will
>> always be set as 0 via the freplace_kprobe prog.
>>
>> To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
>> freplace on kprobe programs with mismatched kprobe_write_ctx values.
>>
>> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> hi,
> so it's another issue in addition to that on with tail-calls [1]
> do you plan to resend this fix as well?
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20260303150639.85007-4-leon.hwang@linux.dev/
> 
Kumar will re-post it soon.

Thanks,
Leon


