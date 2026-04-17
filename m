Return-Path: <netdev+bounces-279297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ3ZNWkP4mkg1AAAu9opvQ
	(envelope-from <netdev+bounces-279297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7641A5C9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09677300A309
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59203BA220;
	Fri, 17 Apr 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/DWVYQV"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414643B6354
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422755; cv=none; b=U0hcjsOtnWAslP4ySy3poTfSdje2Mi4IhN8PvPIQ1faQmP5S/U6iG9e6bGG8xbD5eYeItCsNJY58s/mBmFD7pPBHX5Z7x9uR/pAUwplMT5JwpyOe0xpQOv2u067RU2BBh5cDlQZLWRr8qiunJGZcFmfkee7DeTL8MMDAIUVM5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422755; c=relaxed/simple;
	bh=0VRL0cpLJ+qES0oZbNjlAL/FiePH+bQn1HvWNYQ7Fz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jN6fYiuwreeapzE9qF7n7Kzse6WSkx82KMp6Q7iVshvOp37gi0KnEgYoxn1iU6SR+HnIkjOzsQ+cnC9KlknNt+/NkXOdfwzlD9U+eKYFYICrEEP1GuOLWYq1Y/SmBHaw/fc1Svrj1Nf7nSDYjBNHgjMeHafNcdDTa77CtusL+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/DWVYQV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d8f345e-e3aa-428d-8484-8127387bb4a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776422741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TX419zoOiGLPA/HkUNw0XGLgQfe+SD1cqA8DukbVfYA=;
	b=l/DWVYQV/EMiKjrRUIH1rDNxFlRC62ccAcD9M3jpilGTVBLiGKOkFHMGahAuxby3XNgdwh
	fmf8HkF9S5ONFOjHvmqq2c3OEa33cnmZ1D4SIQeUvv/19zfqN/RftnlUZ1cX/Ygakeo6c8
	NlbPQI/G+Lm1OJE124oh4JAqX+5DPsA=
Date: Fri, 17 Apr 2026 18:45:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr opt
 callbacks
To: KaFai Wan <kafai.wan@linux.dev>, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
 <20260417092035.2299913-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260417092035.2299913-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279297-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: A9C7641A5C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/17/26 5:20 PM, KaFai Wan wrote:
> Add a sockops selftest for the TCP_NODELAY restriction in
> BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> With BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG enabled,
> bpf_setsockopt(TCP_NODELAY) returns -EOPNOTSUPP from
> BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB, avoiding
> unbounded recursion and kernel stack overflow.
>
> Other cases continue to work as before, including
> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB and user space
> setsockopt(TCP_NODELAY).
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


A little nit below, no need to resend.

> ---
>   .../selftests/bpf/prog_tests/tcp_hdr_options.c    | 12 +++++++++++-
>   .../bpf/progs/test_misc_tcp_hdr_options.c         | 15 ++++++++++++++-
>   2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> index 56685fc03c7e..7b9dbbb84316 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> @@ -461,7 +461,7 @@ static void misc(void)
>   	const unsigned int nr_data = 2;
>   	struct bpf_link *link;
>   	struct sk_fds sk_fds;
> -	int i, ret;
> +	int i, ret, true_val = 1;
>   

NIT: please follow the reverse xmas tree variable ordering


>   	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
>   
> @@ -477,6 +477,10 @@ static void misc(void)
>   		return;
>   	}
>   
> +	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
> +	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY)"))
> +		goto check_linum;
> +
>   	for (i = 0; i < nr_data; i++) {
>   		/* MSG_EOR to ensure skb will not be combined */
>   		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg),
> @@ -507,6 +511,12 @@ static void misc(void)
>   
>   	ASSERT_EQ(misc_skel->bss->nr_hwtstamp, 0, "nr_hwtstamp");
>   
> +	ASSERT_TRUE(misc_skel->data->nodelay_est_ok, "unexpected nodelay_est_ok");
> +
> +	ASSERT_TRUE(misc_skel->data->nodelay_hdr_len_err, "unexpected nodelay_hdr_len_err");
> +
> +	ASSERT_TRUE(misc_skel->data->nodelay_write_hdr_err, "unexpected nodelay_write_hdr_err");
> +

NIT: It's would be misleading if you run ./test_progs with "-v"
misc:PASS:unexpected nodelay_est_ok 0 nsec

"PASS:unexpected" ?

>   check_linum:
>   	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
>   	sk_fds_close(&sk_fds);
> diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> index d487153a839d..a02e28d9db2e 100644
> --- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> @@ -29,6 +29,10 @@ unsigned int nr_syn = 0;
>   unsigned int nr_fin = 0;
>   unsigned int nr_hwtstamp = 0;
>   
> +bool nodelay_est_ok = true;
> +bool nodelay_hdr_len_err = true;
> +bool nodelay_write_hdr_err = true;

I prefer "nodelay_hdr_len_reject"



