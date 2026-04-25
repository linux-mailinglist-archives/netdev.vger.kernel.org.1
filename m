Return-Path: <netdev+bounces-281104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zZ3YMJd67GlaZAAAu9opvQ
	(envelope-from <netdev+bounces-281104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 10:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89AB46585B
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CFB300D318
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D12FFF8B;
	Sat, 25 Apr 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8aVFktR"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745D291864
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777105555; cv=none; b=YuDsoGSqaGOWhrZOS56Fawyam+hCqqHNBYLFueVnN2BhIhkRqesl6G+SLZgAtgNpY58/XPNNwcDi7WkQSxixXKyY5YAngutt1SYUe861yvOX+0MOMTqQADvMB9uBRgeMo4klhlx1MB33BoE5moamG2kTC6TqMt6wCN9Eg/pq9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777105555; c=relaxed/simple;
	bh=FtR0uH9a054NjeSooW+fqTU0hFY6g2vc3n2Cp1RuWWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idSElSuHNxgGF70G2mCfLsSDOV48IqzNGzB1ozylyN26ehfOCOT+87i2+bnHrwDNrHeGg4GSgnt+XrXU8TQm7p90yjWjxCvWBXiwfmNUnSxzw9QZBNWOuqRb0QmiVv8Dss1wa8H6IFkdjvsCLt2ByN1IVElA5ChJVcYZyi5Ylgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8aVFktR; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f2485da-257f-4654-a2cd-8108228ece46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777105550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOn9U/3e6dTU/MmjjYQsibDoy6oebfVPZ4u1C038vCI=;
	b=e8aVFktR7Kt9EA58N+Wck8UQEfRx12xzPuef+95KR4Cv/MUI7XGQR3reTsgmDl1KlOwHOC
	rOoWUjvfQzkh0jDUSYu5I7G/IBmmwxZMFb8xmjbz3V8+RW3+NIyr0GH2c6VBfOqjpwwh5B
	JO8NsxPr73451RMhBPQ5Uz/+zzd6FYo=
Date: Sat, 25 Apr 2026 16:25:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
To: Weiming Shi <bestswngs@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260423155807.1245644-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260423155807.1245644-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D89AB46585B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281104-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,asu.edu];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.364];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 4/23/26 11:58 PM, Weiming Shi wrote:
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by `start` (absolute message
> byte offset) instead of `start - offset` (byte position within the
> element). This makes rsge.offset overshoot by `offset` bytes, pointing
> to the wrong location within the page or beyond its boundary. Consumers
> of the corrupted entry either silently read wrong data or trigger an
> out-of-bounds access.
>
>   BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
>   Read of size 32752 at addr ffff8881042f0010 by task poc/130
>   Call Trace:
>    __asan_memcpy (mm/kasan/shadow.c:105)
>    bpf_msg_pull_data (net/core/filter.c:2728)
>    bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>    sk_psock_msg_verdict (net/core/skmsg.c:934)
>    tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>    sock_sendmsg_nosec (net/socket.c:727)
>
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Fix looks correct.
The bug only surfaces when the split branch is taken and start lands
inside a non-first SG element (offset > 0).

It took me 2 hours to reproduce it. Repos or self-tests are welcome next 
time you reported a bug...

> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e56b567bd18..f12fbc49bc03 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2865,7 +2865,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>
>   		psge->length = start - offset;
>   		rsge.length -= psge->length;
> -		rsge.offset += start;
> +		rsge.offset += start - offset;
>
>   		sk_msg_iter_var_next(i);
>   		sg_unmark_end(psge);
> --
> 2.43.0

