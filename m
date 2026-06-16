Return-Path: <netdev+bounces-299853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fQuuJNdQMWpIggUAu9opvQ
	(envelope-from <netdev+bounces-299853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:34:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79768FF6B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mYrtHlTR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299853-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299853-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247883017C95
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376E30C16B;
	Tue, 16 Jun 2026 13:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA630595B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:33:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616835; cv=none; b=VANX/5I5aNLdlRWyZ7J28UuLidL20WXfncRbRG1XETKprYNDhHSnxRTGL2BCsQ+j3x+zLQ5b7hrCwVHj+T41Znwf8yaXcT5BG+nxo9XeUJkU0cjopHdHYa/Bq6UQMxlhZ+mo6Z2K69XkUv5eM/UYk20LvVzqqcpOL1ZhzeZVdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616835; c=relaxed/simple;
	bh=Sj4HWP9QisEzm9JzhjUCOB4XKgrZNOLEhL7geAA/29c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPtm8Uci1ymZz8fHBiRoYJDcwML/fzM8HdzkLWrxBAcMZFQW6qphaPZtmWBTty3+N+ES/HZ6S+Ji+0O/W/OkNdwlOfkMEAYLExWG4FbjPWzTFZVrfPHL+ROx//IU+9JQ/ieIj/T7nXyuGsibuyZDYKtnaoTuXXkK6xwegyWtPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYrtHlTR; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-461a5a39da1so452967f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616833; x=1782221633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvYxCng4UXLcQ/XoznoR8Er/jzsFv5UY/bjt0wk6M20=;
        b=mYrtHlTRdxgA3QyRxqM98M3oCUow0xVbxWsJIoBCSQB5kHzUCYSvhTWJ5vFzmEdvih
         tXJzr/GCI+jNAMdr8g9ipvNeUMn57kf4iKxAPO7yXDKMCdinPWG7PDPGmdMKmRLP6DHF
         60khKnZY3ImNbn+QlfBD/s3IHOTA0gWX0P7qmmgICE/fhtsg2PYR8g92tKpdUtJMQuKt
         M2P8bWOOQ6Q5POIH8JB70Tipi7QXKTTQzTnCag53sXEq/mJa01dH4AjESnuPkdlPEhf9
         JMybhn1k2kqUbjsHf5ZAJxop9Nwl02qvn9qa0uftl/MkUq0hqMVhMZ783kmzvT9yQ6DI
         1mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616833; x=1782221633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvYxCng4UXLcQ/XoznoR8Er/jzsFv5UY/bjt0wk6M20=;
        b=rx5l5QXoRQl+X8Mf0AqBZhgdh33q5ZmpklBNYjNjR1Djg/A0aXJsrojkXV6+Ftw/rm
         mL4kPtKffBxcrc/nc4hP4TcxHscazXPJJVrS4+I4YvaF5BDRIzbkctgH0T+NyJWLACWS
         CSuNh6+keVKWp0nMZfZAW+zhkPbDvpjgYWYzMsFkWT/41/2hGu09uFQcl/ckgQcbw5U3
         WeU2ZoAiAlz57dQA5+caxOJr8wpANeaTK4i2XC+CxyYP9KZzY4YRSmnaBlkjLpBMa5yE
         IA1l8jLBfUFXBfmei8eWal9d9do8Ej/h349c6+G+wpOuS/gumoexiZEM0kFqWKfSqzzA
         eB9w==
X-Forwarded-Encrypted: i=1; AFNElJ+sS14rPRtznOvHHztuc3zTQglfohB9+01qGiynxA7WhgCdDPPfJjEx5I6VH5CF6p2VEb8BDAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRa7EfaTUz+xPBmlgcGRJk7lzWsnZxXU+Jmp/sxt9Bbn1oDJkc
	gW0YoSAaASicmU8krZNsc1DQV1vOAmtlmTWK4xu+dzOYSWu2vg6ZxRW2
X-Gm-Gg: Acq92OFl/5SHAlVR0X86IniFRbq6OtONd9c+KZWUkMgkS6Cq6taQdJ8FL5vCZa5ppJn
	/SzP9t3BjOn0+w/sO6W35yTZx+OQNTUctpCNnmb9X5Umk6wg84zmJwKETc+XpQ9o0PLumkokhRy
	QNurd5g/oMJDlFdyhS0aYm3bASKu8eSSLoQjFWMVvoQcy/T+Ba+h0vBqrdMQm5rHGFixngpQ7aO
	PELVr88ohV4s6HNvv8WJeyBxs2xRYyw9xet6XUG7CKyAtfJL58JKJbjzNvkozBi05AZIlGqhwxP
	AUwsuTpseyy6nnSGHGSdz7RoDRKl8k+F88nGfgTWnsks7w8qq9pW99YZLITCRWt3642rtmcFV1h
	AjE6A0ktu9eDGSC8oQlJjzLnZCy8Mz6lSD/vX/7vfZiDzVs4/O6PPb6LVR1Wk3I1tDDofWX+Ira
	6DErhNFz2hTFWVlfJxf4Dr7nsZLvW9C91Idh80LzbQomJl8FEf34ig5nqxMH9wXO4TuSXCw2B69
	pMmyuJlHuyeyBlN5rktRqV+URCAoobLyp2PZQsnn/ngmcY+oLNtRl2CggRXJ2XW9UVCwju1ZeIM
	1V1L6zpXUNZJn/JQQ3JEOoTupMH4+xot5P1fvBKEoZw=
X-Received: by 2002:a05:6000:986:b0:44b:7ec9:2d76 with SMTP id ffacd0b85a97d-4619f383d22mr7296064f8f.7.1781616832689;
        Tue, 16 Jun 2026 06:33:52 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm20656081f8f.23.2026.06.16.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:33:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:33:49 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run
 output
Message-ID: <ajFQvedGURQuKqbX@mail.gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616093103.471444-2-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C79768FF6B

On Tue, Jun 16, 2026 at 05:31:02PM +0800, Sun Jian wrote:
> For non-linear test_run output, bpf_test_finish() derives the linear
> data copy length from copy_size - frag_size. This only matches the
> linear data length when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.
> 
> Compute the linear data length from the packet layout instead, and clamp
> the linear copy length to copy_size. This preserves the expected
> partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
> in data_out, and report the full packet length through data_size_out.
> 
> Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..976e8fa31bc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
>  	}
>  
>  	if (data_out) {
> -		int len = sinfo ? copy_size - frag_size : copy_size;
> -
> -		if (len < 0) {
> -			err = -ENOSPC;
> -			goto out;
> -		}
> +		u32 head_len = size - frag_size;
> +		u32 len = min(copy_size, head_len);
>  
>  		if (copy_to_user(data_out, data, len))
>  			goto out;
>  
>  		if (sinfo) {
> -			int i, offset = len;
> +			u32 offset = len;
>  			u32 data_len;
> +			int i;

That doesn't look needed.

>  
>  			for (i = 0; i < sinfo->nr_frags; i++) {
>  				skb_frag_t *frag = &sinfo->frags[i];
> -- 
> 2.43.0
> 

