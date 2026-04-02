Return-Path: <netdev+bounces-274443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF65Glo0zmk8mAYAu9opvQ
	(envelope-from <netdev+bounces-274443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60E386B6A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5697305BFD3
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201762C11EF;
	Thu,  2 Apr 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB88frpH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CARUPya/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355723A9AD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121326; cv=none; b=ZzFW6hGkYzF5scAOhoC83SYE6zGMhMN/+iyexJZ9ObENyqBGcPAaP/9KdytmkkN0hb8vRVvfCs/4hBuCfVgKYc1IbBgup669h4M7u/l4zKGoOPnQgWtEV6dD53+uk9K23xv2sIU7wgB1aWJm3yMuEASJhiZGxwXzrkceQb1rgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121326; c=relaxed/simple;
	bh=jAZxqtMpHzi7Mhaugkk6uTTYMLEDQ9pF1F+mOLCkCXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EElcyNPKJMiuVj8eVALIS0WbSd85j3+5vLz/fTBIjhpz9w0JZ8o+dT36A0H5g3074dP9ykJsIBsYWPlvFOTcUSwvnXcOysANMhPhoOUEpMqBslUbQOX1mfS/k3vV+XZ6B7SlMLh6zo/iEeub/VoAxh00HfTogw5+3VQ5uhqR31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZB88frpH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CARUPya/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775121323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
	b=ZB88frpHkCyGTDR1WRP/8jBOeu3GcG4m9hQ5sNgAqbnZW5S6VWl2VLR/vIlgZdEUyLhVQM
	imEVZLWTMOsy3sbHWKf9xvuE4/Q4SkeqCM7nvsxgpMWRO0zk6Po6g7k9+iTMjo6pxgLLEG
	3pH3o096UvdclFP6KLz74fiVfFf7oEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-WD365-pwNYaee6OIP_6UKA-1; Thu, 02 Apr 2026 05:15:22 -0400
X-MC-Unique: WD365-pwNYaee6OIP_6UKA-1
X-Mimecast-MFC-AGG-ID: WD365-pwNYaee6OIP_6UKA_1775121321
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so409937f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775121321; x=1775726121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
        b=CARUPya/P7aHJTrYH44uVwsE7fsNFLZtzTnxPr0NvOM9akTk0o17oJNKSDLmKn/orB
         3t9h+RdRjbBuevc+Jm6NxjsZ4cCCh4FYIquHPvRtnq3ybZD2M66Jefg2REdPrzg8/+R1
         4eBsTp3+uZiAD5Fh2lMRf0JeudFxbWGwKCOdMdj2+HHGVBgc8NwyRTGGDjuyH6Rzi4fJ
         E2US44wUAWwFktpdCtwj7VJsxp6FMvosM40R36eqQ/ENGspsDvSsu5KOyrzCoZvByu3z
         nAyF8qWh2nNYoV7UPKrk/XXbRM4QAa27comjkXOwF8g3ZcapUAxCsdpdKTDt+75bZmmh
         5iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121321; x=1775726121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SskMdLMgYIwJQCazZ/kSkMNagGT4jeVKuLr6cdsSiX8=;
        b=Fo8dbioQhAk1rtlZfNZnrvXGwTlc/7hNPI6GUY7+uMR6dpH46nxI7/2YD8KnGxd6NY
         O7C4OTTUgtPxSXgtKO5TJ5iJzVEKoog4Tf6aCk/b+iY8APzn0rrewKI+7XVNfiOtHZCF
         F7G0Pjb7wRrxGH81yd7SLjVn96SHQ6qn0yvdk7tVgfQi/TIfFDJI/umahC21SxsFKwLh
         kaKb2R4MBuB61S3Pzit3S8vi5ySYzXsQtLNQRqA8lr9P+zr5I95KHjBFzyLZLxj96Ye8
         ew9aPKrvuEOsqr4AjT57dmkUFuSkQcdot3JH/L2H4DliR2ErC5izyhUClW2I1ojtajpl
         UfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3F03LCgX5TE8NgbGN2GPapbocS7JncRnyDFRD9e2rsgz+r+MI7Hi5Sv4xMEl8AIVA0DVathQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJp7mkJC8sA8xMFpMaLXnX9dOyA+Dj7xu5ePo+2FlhdqY28xL
	Y0MJ5E363ZQbYJzNW+/xCWspju+f/D4GeHgDr71w5TLu7iip5TPNbo4MG54Dqv+kRkBGTs5XhDh
	wIQsMNP/KEAqY37QbVAtYYCmtpjYFx1zbsFFlWCWXx6+erB7KA6v+xAY0MQ==
X-Gm-Gg: AeBDievq1/vczi6LO/M1ed+hciC+wd/HBwAQLhcTqC0vs3YLGgVqNVctikvSZM/QkJe
	Q7Dg5rhUk7SJDs6UHTqNYw41IpXb5+FiVTqP2gubmJ5K09N6CEPhmQwd94H6xbm6xE+EtsWlLJO
	v9qZ/gjbfZky6QZi675s9aP1hGT2m0fTG4qVj855cZdD9F8kHaAZqsx904Jf06q2SqGDgqI7qne
	BPGEB3Yne05cTh6g5y/WSfoasx+jsKZlKElOgoKFB2/X4ed2dTbTp5lk0PEDP+C8rtconlItH/i
	x5rgd9ayKcbgZiGJcHmHTN4uzgIXN7KeagScdamW62u79bdIbGNyCJE/qAt7KyhIi3qGGXn5ed9
	uXfmJ2EC8NQrAoF3KEQb0WlrBdJjQy9CS2ItxAMGFMKv9o43yzvLp3GMw+w==
X-Received: by 2002:a05:6000:40d9:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d150b770dmr12948344f8f.29.1775121321102;
        Thu, 02 Apr 2026 02:15:21 -0700 (PDT)
X-Received: by 2002:a05:6000:40d9:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d150b770dmr12948278f8f.29.1775121320596;
        Thu, 02 Apr 2026 02:15:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a7223sm5966184f8f.5.2026.04.02.02.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:15:20 -0700 (PDT)
Message-ID: <624d0f8d-9a6b-4dd7-b9b0-950f2aacd251@redhat.com>
Date: Thu, 2 Apr 2026 11:15:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: taprio: fix NULL pointer dereference in
 class dump
To: Weiming Shi <bestswngs@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20260330102904.2677818-5-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330102904.2677818-5-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-274443-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BC60E386B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 12:29 PM, Weiming Shi wrote:
> When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
> Subsequent RTM_GETTCLASS dump operations walk all classes via
> taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> returning the NULL pointer, then dereferences it to read child->handle,
> causing a kernel NULL pointer dereference.
> 
> The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> namespaces enabled, an unprivileged local user can trigger a kernel
> panic by creating a taprio qdisc inside a new network namespace,
> grafting an explicit child qdisc, deleting it, and requesting a class
> dump. The RTM_GETTCLASS dump itself requires no capability.
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
>  Call Trace:
>   <TASK>
>   tc_fill_tclass (net/sched/sch_api.c:1966)
>   qdisc_class_dump (net/sched/sch_api.c:2329)
>   taprio_walk (net/sched/sch_taprio.c:2510)
>   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
>   tc_dump_tclass_root (net/sched/sch_api.c:2370)
>   tc_dump_tclass (net/sched/sch_api.c:2431)
>   rtnl_dumpit (net/core/rtnetlink.c:6827)
>   netlink_dump (net/netlink/af_netlink.c:2325)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
> 
> Fix this by substituting &noop_qdisc when new is NULL in
> taprio_graft(), following the same pattern used by multiq_graft() and
> prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> all consumer paths (dump, enqueue, dequeue) safe. The noop_qdisc is a
> kernel-global builtin qdisc that drops all packets, which is
> functionally equivalent to a NULL child for data path purposes. The
> refcount increment and flag modification are guarded with
> != &noop_qdisc to avoid modifying the global singleton.
> 
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sched/sch_taprio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..cecaef16c0dd1 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
>  	if (!dev_queue)
>  		return -EINVAL;
>  
> +	if (!new)
> +		new = &noop_qdisc;

Sashiko says:

---
Does replacing a deleted child with &noop_qdisc instead of NULL leak the
qlen and backlog counters of the root taprio qdisc?
Before this change, taprio_enqueue() checked for a NULL child and dropped
the packet safely without incrementing the root qdisc's stats. With the
child now set to &noop_qdisc, the check passes and execution proceeds to
taprio_enqueue_one().
Inside taprio_enqueue_one(), the root qdisc's qlen and backlog are
incremented before calling the child's enqueue function:
taprio_enqueue_one() {
    ...
    sch->q.qlen++;
    sch->qstats.backlog += qdisc_pkt_len(skb);
    ...
    qdisc_enqueue(skb, child, to_free);
}
When the child is noop_qdisc, its enqueue callback drops the packet and
returns a drop status. However, taprio_enqueue_one() does not appear to
roll back the incremented qlen and backlog counters to account for the
drop.
Can this permanently inflate the root qdisc's queue length and backlog,
breaking statistics and disabling transmission fast-path bypasses?
---

It looks like you additionally need to replace NULL checks for
q->qdiscs[] with check vs '&noop_qdisc' in many places.

/P


