Return-Path: <netdev+bounces-258999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL6sBUJGlGmcBwIAu9opvQ
	(envelope-from <netdev+bounces-258999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:43:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C514AF7B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65388301544A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1733326959;
	Tue, 17 Feb 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmiDRWs6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRrMuO6P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AD326957
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324960; cv=none; b=M819ZNK9WSGtOBOzimlenhfmHU28MtzNCKjQtrQwhJ/kTBRaWiiY6AQzt/uwLeXJ9RmwgxgfJ85da/sSCz4LIvYomnKkE6qTXYn/Y4L/WQCB4j7JylZHiiCXwZLsQZdW9tWSzRzH/kIPfwX99C2//L9WJ81eIryV99ykp28sAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324960; c=relaxed/simple;
	bh=SlTp166RmeJkp/BxCQudQ8IYkPHQvbVqB8W5n9aMXo0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jkOOtwS3BdJ3OVDm58VY+pEmOemE3MTwk1S0knMDEmPI+2JkgVit+RU5Xxhnfc5VjSvLxqy9ZPSYnYlm7mFILjdCEnKllQ7xpNzJicHxmLoWml/v88+KoGqIHn2hBXldVYX/AZQzZPSW05lAzj6K82PhRR93S8xJSLNkLU72PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmiDRWs6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRrMuO6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771324958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsWdoN4R0FkWbCdWIJbr3dQGH4SJsrOAXlnJvK4TYag=;
	b=XmiDRWs6WUtFvdo9iRqY8SXaIJ1vDnEcg6SSgeie+st1FcED/Kr/W3zacMKzH2hfbMicp2
	ccSijTnkJOm/ER24SUtQvg2sFJ8O4gTsuyJdLMDceJJif0VWSBIUnQkierepYCZDzz66do
	WwvjyB3vc8KXRBKa55gCEL+w2lG3/R8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-5qpzN0B4O8KjCU_5eGILzA-1; Tue, 17 Feb 2026 05:42:36 -0500
X-MC-Unique: 5qpzN0B4O8KjCU_5eGILzA-1
X-Mimecast-MFC-AGG-ID: 5qpzN0B4O8KjCU_5eGILzA_1771324955
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836c819456so45240805e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771324955; x=1771929755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xsWdoN4R0FkWbCdWIJbr3dQGH4SJsrOAXlnJvK4TYag=;
        b=gRrMuO6Ph/485jH22AtfzQKuWQNXgEPNbQc7gEO8O2Kb1z2j2ljN9O5/t/p78flfOU
         rhF3XRb+rxQ9/1oy3cB9LriAsauTcoGPbETJqV4AJO148aSyy2SPr11gtOjWq6hrvJQO
         +byBijwfPmWTEeYW0alwaoYM9+l3kNCZ8HhV+SNyzGbHmeZpAOU+enVaMLksIcW6KX/i
         bT225b0aLoTPfAi24Pa0/tlcUupLmEYA1iIPhXlGRAN4KVUMOCadHK77U1U8qMvJTgZc
         7kWFBi2u1TSzfYSYlkgZcvbxsFCCV31Pp8Tf25eMyhCkX/MF6VOqrjNm+W1Sg38SJ/ng
         /FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324955; x=1771929755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsWdoN4R0FkWbCdWIJbr3dQGH4SJsrOAXlnJvK4TYag=;
        b=RVB88Wt2oQ3RFvOi7cSkma6tdrq1Hy1kM15LC9rWGy8ik49B1bOSjC7iwRCFsmlegU
         08I0nkEZf87zMPPc8uDI7Vduag9oNLT161BWNO51roTN/+yEGQMmdXNXb71gTRRezzmy
         uJ5DiY1J3z4ZKOI2uxskjIZqvYTZlSnrXk+XOTGZ8HtpA3/6CiWfvGqEkXXcJA1T/7Ef
         8I4H0D3K5T4dBhLeLCxLhEOEOr79rPEJ+ECYK78ifzxIP26EAlzumK8agWXzVTfSsctB
         ZQx/vXueTL1O8VOLlc2UjK6JODdAFKbl3tp9GUEK2OOTWzfLGXt+fm2sNxGT++6WyiWH
         bDUg==
X-Gm-Message-State: AOJu0YyHldjjWErONoiOe9CPV51y7RsgP/hdr/vNFVlSRipZ9zVLMNR7
	1YU7oK82TPtJBNfkxrGyxkKmzdypAK49QFCb4U/3MhZ8r9D0HnNIVPUKnyKjFePM2wE3IEURIHQ
	Rlx0fmzI+Q39ennoj7mALM/NZHpHgxXMHWW/AyA0NBF6KXUC+m8NXfZI20Ss1IX/iTawsV27gQ4
	Xle09VlIT/DhTZ059d9WNshuhmoxTCX1E/F+Xtb4k=
X-Gm-Gg: AZuq6aJoQB3HYrb8SK5kdAZQww5E2+qaiaNz1W2FMnGPB0bpF705ht+Y8rPGTCtXn2r
	e4efXNDeqxuwGuu9ZOtdPBYqHO3lA2miBvat35DYDvrqlzeBOz8sE0d7F6YkZMr+4HXn2qJ4cGq
	ICOiNDFFjzSmlAGSakhFos8oL2Ri5n78zCGzkF6vhXoLXp+U87d2gY0fi16kGzX5vBdpZ4BEQRr
	BGHjQaeoOMQLRDCFRDjQQ8lmOt8QvE5JAyKUc3Ki2+0PoTtl24YWgeQB7G6PHZscAYCpcqD7cEm
	fonN+cyjvZpgqh5iAnIM1E5iQunmZGqoTgz2L1ObBF6Zo5zEfUyUeopnTIa7EiQSLWuL9/7I4Lx
	e9p2r+WB26FyNad02BTq8WnMBfQ==
X-Received: by 2002:a05:600c:3b10:b0:480:4b59:9327 with SMTP id 5b1f17b1804b1-4838c063f8emr61509205e9.1.1771324955121;
        Tue, 17 Feb 2026 02:42:35 -0800 (PST)
X-Received: by 2002:a05:600c:3b10:b0:480:4b59:9327 with SMTP id 5b1f17b1804b1-4838c063f8emr61508635e9.1.1771324954510;
        Tue, 17 Feb 2026 02:42:34 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm763364495e9.0.2026.02.17.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 02:42:34 -0800 (PST)
Message-ID: <614836d3-c3e3-4f33-8bc8-de00a424cf18@redhat.com>
Date: Tue, 17 Feb 2026 11:42:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-258999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C8C514AF7B
X-Rspamd-Action: no action

On 2/17/26 10:38 AM, Paolo Abeni wrote:
> Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet.
> 
> act_ct was never meant to be used outside of the ingress path. Making
> defrag really works for act_ct outside such constraints range from very
> difficult to completely impossible.
> 
> Address the issue making act_ct drop any packet when not attached to the
> ingress path and additionally emit a warning about the bad
> configuration.
> 
> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")

Whoops, no idea how that wrong tag landed there

> CC: stable@vger.kernel.org
> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442afa7.1770394932.git.pabeni@redhat.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Catching the bad configuration at runtime instead of init time to reduce
> complexity
> ---
>  net/sched/act_ct.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 81d488655793..e8eb0d195f4a 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  	tcf_lastuse_update(&c->tcf_tm);
>  	tcf_action_update_bstats(&c->common, skb);
>  
> +	if (!skb_at_tc_ingress(skb)) {
> +		pr_warn_once("act_CT should be attached at ingress!\n");
> +		goto drop;
> +	}
> +
>  	if (clear) {
>  		qdisc_skb_cb(skb)->post_ct = false;
>  		ct = nf_ct_get(skb, &ctinfo);
> @@ -1109,6 +1114,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  out_frag:
>  	if (err != -EINPROGRESS)
>  		tcf_action_inc_drop_qstats(&c->common);
> +

This also must be dropped.

I'll send a v2 at due time.

/P


