Return-Path: <netdev+bounces-279368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKEuM4Zg4mnI5QAAu9opvQ
	(envelope-from <netdev+bounces-279368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347641D253
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EE0930B905C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10052350D74;
	Fri, 17 Apr 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJoxFBpH"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D0302140
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443146; cv=none; b=e6XAxqTj4HUBxzrZtY/3LzaW4t9XGGXwhWV0p3AtOHsahkh7Y262GixPZB7T9FfNqKZom8JN2n/1p5dxoN71+mMahgQ4zW+4Pd0lvG62TUStnUTCHGI32xSzbNk6+w+dasQM6KiJ2JOwHJid1xb/2adKAC7PQCGXSMgo/TQ8B6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443146; c=relaxed/simple;
	bh=94BI5TrieslVOrJhUQ5ubUHE2QyaLFDLVCjOfZ4bfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAOfWM1iIyusjaigdHKFWZyiLZInKr/BjI/O9SiKxB76WbDO6E+lifFYZEoS4nQJsZHpXYBWrmQ7BI+9bbQ7wS6l6RqaVzM9lOfaE2fQ8PwzF2r6fB0vWiJEhC3uiorhBP2BleuJdeWVhNneZBTnwQ8TPLBjvTFVRwmou7mDUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJoxFBpH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Apr 2026 09:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776443131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ta1OKOTzp2fmeWL9SMKYpLf/VmLUkvE6ptMi0yslJGA=;
	b=FJoxFBpHTnbZ/jhmHKqENyZa6zw03gTPCjNI4e+Rljbm6UZ0V0WcbJzWcGncFD+L6ALbLV
	8nX5koaFkHCXNKpvSsmQ+C2zD5M3LbsJZPe1iEDYdUoXVIph+0qtiW8TdIlEbci7I+jVwa
	L0+jnn+4w+7ft7HmwLNsXA8VV+7/ddA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
Message-ID: <2026417162132.9MRI.martin.lau@linux.dev>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
 <20260417092035.2299913-3-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417092035.2299913-3-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4347641D253
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 05:20:35PM +0800, KaFai Wan wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> index 56685fc03c7e..7b9dbbb84316 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> @@ -461,7 +461,7 @@ static void misc(void)
>  	const unsigned int nr_data = 2;
>  	struct bpf_link *link;
>  	struct sk_fds sk_fds;
> -	int i, ret;
> +	int i, ret, true_val = 1;
>  
>  	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
>  
> @@ -477,6 +477,10 @@ static void misc(void)
>  		return;
>  	}
>  
> +	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));

Same comment as in v2. Why this setsockopt is needed?
The setsockopt in userspace is unnecessary. In the future,
we may need to understand why it is needed here in the first place.

