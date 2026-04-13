Return-Path: <netdev+bounces-278043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JZ2ISnN3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:02:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F33EB088
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34803302BF74
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145D3BED57;
	Mon, 13 Apr 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJch27px"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37943BE640
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077862; cv=none; b=VUYl6polBywvedJ8MFr8bkZDZehcSGnGQwR0mmnuQPH2n4D3G9ZcNACP6fjmugPvZSm76dSSNEFM8rQvXAHGuK95frjlNxGVD5sVqczN5ErcVlbeaHrLjn0ISc2iXC3bfh0frsc9UKs1Fj3ZK3TDCUxR21+95BTRgRszSJIvS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077862; c=relaxed/simple;
	bh=9h8L9X1quD4VQ1UU57X66zsByMeBGf58uq+qu+vLtqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7WO7SBRm2F3h4EklEGGG9N/goOlE/ULxV+afZYthfWkcDN5ONzfsVFXUMbvG5ytp1SCic4GKPVBHVAIDYKCUbzrzT2+8hDNdozVYeRAo7OwX+GIkSS8U+hduRMK3MGgjwcvjlonSy7I7UeU/3F9AJySC1LY4bFTCU4t/bBnlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJch27px; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3nEKPhqrBpSq06pH2ECOhPuLmQNF80viXQygSB2+44=;
	b=HJch27pxSuAH/+AA6A1+RdzMSYqjNnTraAAAA+HQyQtd8q16i9i/eHq7xBR2pp82FO70K2
	4Fcj8ya5T+7+V9NWvUY+IZ0475M/NjLieGF8UM+K6fmpvksRjmQjPqT12L+9ZRvot9ZxH3
	WB/WpyHirPt6CTqXKiQDsFql6dVSb8g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-Xg-Wws2BPUuZreFzhQTO-g-1; Mon,
 13 Apr 2026 06:57:36 -0400
X-MC-Unique: Xg-Wws2BPUuZreFzhQTO-g-1
X-Mimecast-MFC-AGG-ID: Xg-Wws2BPUuZreFzhQTO-g_1776077855
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9269B1956048;
	Mon, 13 Apr 2026 10:57:35 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84CAA19560AB;
	Mon, 13 Apr 2026 10:57:33 +0000 (UTC)
Date: Mon, 13 Apr 2026 12:57:30 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v6 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <adzMGvi7oMMY7L1Y@thinkpad>
References: <20260413103449.169913-1-luka.gejak@linux.dev>
 <20260413103449.169913-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413103449.169913-2-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-278043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 904F33EB088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 12:34:48PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
>
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero, and properly linearizing the TLV header before
> access.
>
> Assisted-by: Gemini:Gemini-3.1-flash
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Please respect the netdev development process [1], net-next is currently
closed. I'll leave it to the maintainers if a resubmission is required.

Other than that:
Reviewed-by: Felix Maurer <fmaurer@redhat.com>

Thanks,
   Felix


[1]: https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

> ---
>  net/hsr/hsr_forward.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cb..0774981a65c1 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -84,7 +84,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>
>  	/* Get next tlv */
>  	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> -	if (!pskb_may_pull(skb, total_length))
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  		return false;
>  	skb_pull(skb, total_length);
>  	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
> @@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>
>  		/* make sure another tlv follows */
>  		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  			return false;
>
>  		/* get next tlv */
> @@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	}
>
>  	/* end of tlvs must follow at the end */
> -	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
>  	    hsr_sup_tlv->HSR_TLV_length != 0)
>  		return false;
>
> --
> 2.53.0
>


