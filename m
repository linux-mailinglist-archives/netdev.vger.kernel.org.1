Return-Path: <netdev+bounces-294081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFNGE0KTHmqdlAkAu9opvQ
	(envelope-from <netdev+bounces-294081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7662A7A7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E26309C548
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56F3BE15F;
	Tue,  2 Jun 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PG9Ka901";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8qasZcV"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FB38887B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388273; cv=none; b=S7i2hRPeUfYqK9YUaZg7RDlCwpE0O+aO4wvM+6NMwsm8W1+oU9yVyM9iSlv6Dej17+TZLaePsjQ+UeOgenbugpSVpcRgLEidZQm4TCzIrM5Z/Z/LWY0Vlgocs3R84D72PlMrQpWawkzsRNY4L1dRPbD44osu2ukwuMLaVGdIdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388273; c=relaxed/simple;
	bh=7pVChPqDHXVqAPAnrlPKVmRgEs201+okE1NCvU9okKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl9KZP3SwJcR3O/2Y2GAfRjtqkpypzPFhlGxIYMXaM2Y0o61s0Zu4RC5Wn7Akz/LXtcc46Fg7khepT9IJyRrshSMYcIgfp2pIg2S9Cc94OshGyIoQ22dSM4WVG4Vd11kmrikZzfiaonmK8JypXeaiIjFJkz4lu01FFBfJ8fRDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PG9Ka901; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8qasZcV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25BC27A0015;
	Tue,  2 Jun 2026 04:17:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780388266; x=
	1780474666; bh=z58S7sTglbowuVwhGQ9uhTys6RnntOs5CEPvlIpADGo=; b=P
	G9Ka901FFfqs4pRzre8bZQlLkNPYRKwY38lSJmtyinnKsrn3TEfQlfw5mvz+yIwh
	6pLYp4do7eXrjhrALSf+FLEcIFR2mbed7i9Gt0FiQ2B3Q2+1wUfc/uOSJC8rvtbL
	JkS46ejGvd0RImlFOFIJvdc7R12cSYV5fbvFGhhaxBDksAdb/HQs9sj3CMETUPym
	Guy0C2pmpkUGoGeoIj+Y4oWs0oAOpNDoKaMnlsNvCCtUK6RGjR9uPLgJEpbhzO3b
	4Au19PeLNKnYGAiDdWCMdhl7CxdxA2NcJOH72SLf1+0snPSEpUD0TfxAnIU8D6l/
	idvt3+u5qz5i+UL5ZiEGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780388266; x=1780474666; bh=z58S7sTglbowuVwhGQ9uhTys6RnntOs5CEP
	vlIpADGo=; b=I8qasZcVy0cExtw94LbL5ffmm+/wOmudTJdWnM3LhCtqLITOZiW
	enoAiA3ruFCen8HQNNMQ/KVy7xAV+u14F93HDO4CmgG1cs/xLurKJhyMMUjBMDgG
	r1LrMC6ztS4IxRLqY1TnSyBrnh/1W3Txjw0znkiKIPSnRN78NISfc069j+CuZ/zv
	oKj1GVgljn45GrLRXHFSLFtqLqoF0oQaOk85+lwivLpuGxikjzm0pqk7D8gaEJ+G
	tvdovHehidEwr3TLY63vTMesHAMXy+zKee0Jl0t+nPbfgAm6X7fH3wqW2mOvpoC8
	RnItpo2cKR1l1NCGhsZipSFpGdWXlEmQ5pg==
X-ME-Sender: <xms:qpEeapT-beDxo-42Cx1mQE2gsEr0Q30354nAvACL8vIQtVZ1MOejFw>
    <xme:qpEeappDK4WLAaLi6SjTRx4lQ7pYFXaCT9AHqDSbuU6M_ARvHicfeL8x3NVZGKmg3
    VQiB9rk0XlKm3s2plmkqiQGNyminfPIidvbFOlzCmo0ZxyaP2EXdSU>
X-ME-Received: <xmr:qpEeanK3MhOsQAo6gIeZvMtq7zcQnMHqIpAR-ov1la8KisUroq0-pjVOb6pugyySlDcukr9hD2amILRgd9QdgdY>
X-ME-Proxy-Cause: dmFkZTGbw2yjVLcliRVGpFaNLrcv2v5R8eTcxoEmW4D7MW4OaNtZ3pCfCubKuUka6TYIGA
    0TQvc9yBP/rE0QqZ6hYXbcPq4njJutcIo2/rPuq53LHgBc7DmjQpyPNEsAXsMevd4DBUIT
    cX+EBsOxHyjly7zNxfsMbU3M7CGmCHpN1F1Q892LW9+KM4o+yS0s3z2fixZBN1FFF7qm/i
    ZcVJgh7LN+vr8zQf+gpXDAI4CLU3kMzMwnhR9wyM5A9vOYAVdjtpxC/1tekMj3GZc+GKHy
    Fb/I6HTKXQKkB5GkMC5Qde44k70KO0tXmp77Y29/Ee4ZNKuZYVAszA5vEBPESfc9zxmSJL
    7oAxExXrLw7ttnkizteUHprynO/nZCF69DoNKge1UhNB3OTGOKt71J5X4G+7SdorhZrB4O
    gxjtrdfNeyjUNJiKoMxExkKn5wXSMtWI1m8kwsZrcTG0eJraEkzbJNptdO9y9/b6Dl0fnR
    meK+op13M9wx0IoWfs6oBtYvLLGop08Hk2Ro912ckX9ysAPytkWZHjfjiGUxmZMzQA2PFr
    /eCdR8tdzeIcbXg2fnD58Pp5qfb63aurxikrzaw1a4zfBt4aRFdAkcTCAD62hQU23pzdCT
    WOq9Ft423xTopc+BEW6+nu6CAi4HCz38KuoI+/IG8zHCIpZVsC2ZUPHXaNxw
X-ME-Proxy: <xmx:qpEeasqxITx8LKUKhBly-_x8R4W3k3lmVKU79SERMJ9ocUrFy26XTg>
    <xmx:qpEeavzrYSeR2-lE7Wa0tGGAgAnxEwHafrBlUHUoD9rLQgd2DPduDA>
    <xmx:qpEeagM8AtcrYCUGtzYIELlLV_lU-QQIctunlapd1BGK6wspVOH-HA>
    <xmx:qpEeak6H29ArleXEZwP7L1LK1ZdLWPbJq0WpfDSNSZt5nyLOjyyxlg>
    <xmx:qpEeapBdGQOyBMZA-2zBv2YeKxHUGEqhJL3BS_PCsJUnNkBIOPg3611Z>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 04:17:45 -0400 (EDT)
Date: Tue, 2 Jun 2026 10:17:43 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net v3] xfrm: propagate -EINPROGRESS from
 validate_xmit_xfrm()
Message-ID: <ah6Rp00oKj6SVI_H@krikkit>
References: <20260601155822.20954-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601155822.20954-1-petr.wozniak@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294081-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4B7662A7A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-06-01, 17:58:22 +0200, Petr Wozniak wrote:
> Changes in v2:
>  - Only reset rc to NET_XMIT_SUCCESS when PTR_ERR(skb) == -EINPROGRESS,
>    not for any IS_ERR() result (Sabrina Dubroca)
>  - Add comment explaining why rc is reset and the async delivery path
>  - Fix validate_xmit_skb_list(): track stolen skbs and return
>    ERR_PTR(-EINPROGRESS) when all skbs in the list were stolen by
>    async crypto, not NULL (Sabrina Dubroca)

I'm confused by this changelog. Was the "bool stolen" stuff in
validate_xmit_skb_list added to address my comment on v1 about the
skb_list_walk_safe() loop?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0c6c270d9..b77364f83 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4078,6 +4078,7 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
>  {
>  	struct sk_buff *next, *head = NULL, *tail;
> +	bool stolen = false;
> 
>  	for (; skb != NULL; skb = next) {
>  		next = skb->next;
> @@ -4087,8 +4088,11 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
>  		skb->prev = skb;
>  
>  		skb = validate_xmit_skb(skb, dev, again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb)) {
> +			if (IS_ERR(skb) && PTR_ERR(skb) == -EINPROGRESS)
> +				stolen = true;
>  			continue;
> +		}
>  
>  		if (!head)
>  			head = skb;
> @@ -4099,6 +4103,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
>  		 */
>  		tail = skb->prev;
>  	}
> +	if (!head && stolen)
> +		return ERR_PTR(-EINPROGRESS);

If you're keeping this code, sch_direct_xmit also needs to be updated
to handle ERR_PTR, not just __dev_direct_xmit.

(considering that sch_direct_xmit doesn't care, and I don't think
__dev_direct_xmit callers can reach the -EINPROGRESS path of
validate_xmit_xfrm, I'd skip all this "bool stolen" logic)

>  	return head;
>  }
>  EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
> @@ -4858,8 +4864,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  			goto recursion_alert;
>  
>  		skb = validate_xmit_skb(skb, dev, &again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb)) {
> +			/* -EINPROGRESS: packet stolen by async xfrm crypto,
> +			 * delivered via xfrm_dev_resume(). */

FWIW, I don't think this comment is that beneficial. A comment above
validate_xmit_skb describing the possible returns (NULL = dropped,
EINPROGRESS = stolen) would make sense, but something here and very
specific to xfrm (there may never be other sources of EINPROGRESS for
this codepath, but refering to implementation details of xfrm in the
core feels wrong).

-- 
Sabrina

