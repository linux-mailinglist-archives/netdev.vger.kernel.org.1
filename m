Return-Path: <netdev+bounces-278335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOm5CjD53WlTlwkAu9opvQ
	(envelope-from <netdev+bounces-278335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3123F7217
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2078030B1C2B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A2394785;
	Tue, 14 Apr 2026 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSBbH9t1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU232IvO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBE392C28
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154574; cv=none; b=PGqYifBhhsext56W4JPxin0yYAHCE7tbPCxNZ1msZg5VGgWfnurbvAaJqwDaa91M4mxKWXn/tm8ATyEn1EZQCo9hmdtuV32XKlG4W8OO8lza7glVfxliuXvq1yt0Kr7ojnUF3lXGjArLtZg96/E0k2r1ujr+exDuI4wFDwz6yxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154574; c=relaxed/simple;
	bh=i1OOL69PWoIgXgONVQTjhPA97zSUzbZCd21cHXhl9P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGyiU5iuZurDLOeoigkCF8GidkQFhwLVUWau0dQI87ciiZJ/k6YV0qBLIN18dFgV31XOkWrsxL05bZ1l3GIJZmup8BdlJF4OkcFifiN2hCACuHJJU5KKzMk9KkQMtCTQSncUEWtQjXqfZp8lzyU/BAJOFPxUy9dtD45mMwmReOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSBbH9t1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU232IvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776154572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im3PpL69b2f4ofhj1wnRMCa8c1QM7cUPPbp8HBVBvcQ=;
	b=iSBbH9t1lUQeEUQLYM+Apgi3FaeOYdvg/p9rJXsQx5JScNdab9ygnq7SPfJdKCZrkEcKt+
	wZtctDMkfLh6hctESicI5U0xkRh6+4s5BzWEbuMhQrQ3CnHIyvQLuzPOiMNVmHhi4YYt/4
	NozwJKkqnd6iPjpBUClLhLFXEDOEBTg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-99fRUTt2MBWm1fPw-rfkVA-1; Tue, 14 Apr 2026 04:16:09 -0400
X-MC-Unique: 99fRUTt2MBWm1fPw-rfkVA-1
X-Mimecast-MFC-AGG-ID: 99fRUTt2MBWm1fPw-rfkVA_1776154568
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488dcff87b7so16324585e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776154568; x=1776759368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im3PpL69b2f4ofhj1wnRMCa8c1QM7cUPPbp8HBVBvcQ=;
        b=YU232IvOawWb0Agv/mZt3JbL+7HfpnMOPfnqyS/6Vj45JJvWdksV0d5vFmiLc/Jeyt
         wGyCsDDeJ5emfQtVNDgl9XumOkt+GCM3BjdPNqf6WySfpKjc7k2kEd75EqoCYNn+LedV
         IIlE9afB05MkLLLzVRWgc0jLClNlBBqGHA3wrSScEQSXJ6WFMMcrcmv5fqOVMm8hXerW
         ME11prtygkKvQ3e1os/LwJkCwwOcytqISN0eg20mFZQDZUDtbBvZkZIQP19fuvVjZu5v
         ywv0Sgh79Ngbl+iK3bMcqcZeANRjZ20GH2oR/FfspOgf8stM7AAvS7CTo9Ski2iaGsWw
         F+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154568; x=1776759368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im3PpL69b2f4ofhj1wnRMCa8c1QM7cUPPbp8HBVBvcQ=;
        b=q/gWhTDe4zACSqfLG0OwhMbuwUx7sECY9tLgRofJS6PZsPAaE9BUc3mQ9Vi0mU9fVW
         M9Lr3livz1xH7yMadTwCGO81a/SjA2yefgI4fhAsKVrttY8xmZhPVylHTY/mi4Vwszqm
         0SGl9dqPt/5QjkcLdpJJBGaUNH1FY32aDQcW9WRlcTKzrnmrGRO+eONxN7x4pbpqva/H
         6hHJc4sh302CaJuyCyZGBZv4h7BwnA5jFYo3ng3B3dEaLQjHI/FFpxevahwgkqSCgdZs
         h5XIYiH1XeCtqa6eMOfj+CkVSOHMQajdGIj7KTvC7I4tWVtbvWd/1PfArHJRIXuc/T77
         YwFg==
X-Forwarded-Encrypted: i=1; AFNElJ/4DQemScWhhGBExTcMGZ7hyVL2+78f9lGDcumczvlNk53k6ZDzMJ0e+E7y0BgmShHIg0nxYyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRnLdHP01Mk2XIkeO92QR7IfMTWkbGaALspOUQQf8kpNwKZFK
	HePxrKmw2yIP5zRuwEB/VWOgnqZWeBGXZLEoI2vWOled2wMme6tTKjA6DbowMOBFD5WGA2fxj4b
	hsjxPiB/FzLeTdItP4oiB86CTjNqD5/7IGSaNjgY7mZPNWypUxTJ2mS2+0Q==
X-Gm-Gg: AeBDieu3FzJXD2/S/snWkaAA+APFgoEUEIi3E0AV5r0ssgHCYqRoeMUQTbjAORPovld
	8ykAO/hCsK6NuOR4FW+pwDJhLLA2eNG58a95nad2uSCAeGxSqhL3ik647SjkpxmmmsPv6BdRSfl
	mn3TE+0FO09M3sWOdzuaFjTWgZwza4BeeKwDUVodj5OJIUD+YOn3HaUUao7jbnr58hzz6wUV654
	VDH3AGHyE/65nWYLvNk5GunfFSD2vlDBqTac2TpNvw404sDPIfpfaLKJigkrqV8AiSpkCWxWw1E
	54qipSFXQQlSGkdr+JJsbGkCjbbLL+uAirFxMCS1vJXNbZFL4AcqiPx0zwBNajlk76F8feYMfpG
	0tDFmlbE6NK/5eeLP3uxHnRzqIsNggMBP8zvvKtBGsPtUrh5lyw9418Td
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488d68431ebmr163924935e9.14.1776154567780;
        Tue, 14 Apr 2026 01:16:07 -0700 (PDT)
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488d68431ebmr163924345e9.14.1776154567196;
        Tue, 14 Apr 2026 01:16:07 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042e47sm30932275e9.13.2026.04.14.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:16:06 -0700 (PDT)
Message-ID: <6f4ebd09-9fa9-4b6e-97b5-a6b1fcec8774@redhat.com>
Date: Tue, 14 Apr 2026 10:16:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/sched: taprio: fix NULL pointer dereference in
 class dump
To: Weiming Shi <bestswngs@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260410153902.955227-2-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260410153902.955227-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 7F3123F7217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 5:39 PM, Weiming Shi wrote:
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
> control-plane dump paths safe without requiring individual NULL checks.
> 
> Also update the data-plane NULL guards in taprio_enqueue() and
> taprio_dequeue_from_txq() to check for &noop_qdisc, so that packets
> are still dropped cleanly without inflating qlen/backlog counters.
> 
> Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
>   - Update NULL checks in taprio_enqueue() and taprio_dequeue_from_txq()
>     to test for &noop_qdisc instead of NULL, preventing qlen/backlog
>     counter inflation when noop_qdisc drops packets (Sashiko)
> ---
>  net/sched/sch_taprio.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..XXXXXXXXX 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> 
>  	child = q->qdiscs[queue];
> -	if (unlikely(!child))
> +	if (unlikely(child == &noop_qdisc))
>  		return qdisc_drop(skb, sch, to_free);
> 
>  	if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
> @@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
>  	int prio;
>  	int len;
>  	u8 tc;
> 
> -	if (unlikely(!child))
> +	if (unlikely(child == &noop_qdisc))
>  		return NULL;
> 
>  	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
> @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
>  	if (!dev_queue)
>  		return -EINVAL;
> 
> +	if (!new)
> +		new = &noop_qdisc;
> +
>  	if (dev->flags & IFF_UP)
>  		dev_deactivate(dev);
> 
> @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
>  	*old = q->qdiscs[cl - 1];
>  	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
>  		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
> -		if (new)
> +		if (new != &noop_qdisc)
>  			qdisc_refcount_inc(new);
>  		if (*old)
>  			qdisc_put(*old);
>  	}
> 
>  	q->qdiscs[cl - 1] = new;
> -	if (new)
> +	if (new != &noop_qdisc)
>  		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> 
>  	if (dev->flags & IFF_UP)
> --
> 2.43.0

Does not apply cleanly to net and looks seriously mangled. I suspect the
above chunks should be part of the actual patch ?!?

Please, whatever tool you are using to help crafting the patch, double
check the result manually before the actual submission.

/P


