Return-Path: <netdev+bounces-276122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FtDI5hB1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C923B2798
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A54723002B65
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284939FCD6;
	Tue,  7 Apr 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKbP/pSO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3433ADA7
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583634; cv=none; b=bVBeY6PnomOZHpupcFZx70efwgwq0nuQUoy86azSs5xZN8A9tg4cjACqGDazObr5FqRAMvCZcnpJybIIkuct0VV8wF3H5g4dy6ZbSrJnVLUWFtIclHQHSncO8XZNSMvmMbt9Urtpc6y4/9erQw7omXe1xKz72KGkBAI5i+MqK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583634; c=relaxed/simple;
	bh=cyjBtDuDQLBZlVjel4akmjDkRi6JcktZrCSiwVTimzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2oy/dGYPDyvyDQxwkj3IP4VUcMxPhvGtY1tver896sSwkDWCTaMVkGQinIEgGEKudj061nk81kMA018w2XmuP7CKwLwsoriTuoQIbx6MNFDjApoI5iA2jMQz7Z+dYrgRKRrbjRiJXE8K35P2x9OUL35691P+6bqI/Euu24ujOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKbP/pSO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775583630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jLM74fdFCIjcyM12S68S+CEQkWvsOQLC+ByQPvi9yoE=;
	b=CKbP/pSOdLfiRQb07o5X6qWCfPzd70gWJPXPyhVhWLS1WJjCEhubSGwpsGtMeWFaG9ZLW1
	90gso1TdyEYnC9+CUNWhVx398uKnFurRqW/2DEpGpXQWt/rquCY2HKjPec86+einHSyZaQ
	UWj1luI8ztDtf3p39P4hZe0YeSPlUA0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-qZsgApkWMFOcSc3_TLOWlw-1; Tue,
 07 Apr 2026 13:40:27 -0400
X-MC-Unique: qZsgApkWMFOcSc3_TLOWlw-1
X-Mimecast-MFC-AGG-ID: qZsgApkWMFOcSc3_TLOWlw_1775583625
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608951956068;
	Tue,  7 Apr 2026 17:40:25 +0000 (UTC)
Received: from thinkpad (unknown [10.44.50.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F23A1955D84;
	Tue,  7 Apr 2026 17:40:22 +0000 (UTC)
Date: Tue, 7 Apr 2026 19:40:19 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <adVBg8WUa9icLfXK@thinkpad>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401092324.52266-2-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-276122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 90C923B2798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 11:23:22AM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
>
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero.
>
> Reviewed-by: Felix Maurer <fmaurer@redhat.com>

As Fernando already pointed out: I did not review this.

> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cb..17b705235c4a 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
>  		return false;
>
> -	/* Get next tlv */
> +	/* Advance past the first TLV payload to reach next TLV header */
>  	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> -	if (!pskb_may_pull(skb, total_length))
> +	/* Linearize next TLV header before access */
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  		return false;
>  	skb_pull(skb, total_length);
>  	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>  	skb_push(skb, total_length);
>
> -	/* if this is a redbox supervision frame we need to verify
> -	 * that more data is available
> +	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
> +	 * extension TLVs to maintain forward compatibility.
>  	 */
> -	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> -		/* tlv length must be a length of a mac address */
> -		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
> -			return false;
> +	for (;;) {
> +		if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +		    hsr_sup_tlv->HSR_TLV_length == 0)
> +			return true;
>
> -		/* make sure another tlv follows */
> -		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		/* Validate known TLV types */
> +		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> +			if (hsr_sup_tlv->HSR_TLV_length !=
> +			    sizeof(struct hsr_sup_payload))
> +				return false;
> +		}
> +
> +		/* Advance past current TLV: header + payload */
> +		total_length += sizeof(struct hsr_sup_tlv) +
> +				hsr_sup_tlv->HSR_TLV_length;
> +		/* Linearize next TLV header before access */
> +		if (!pskb_may_pull(skb,
> +				   total_length + sizeof(struct hsr_sup_tlv)))
>  			return false;
>
> -		/* get next tlv */
>  		skb_pull(skb, total_length);
>  		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
>  		skb_push(skb, total_length);
>  	}

As the commit message doesn't match the patch, I can only guess why this
loop is there: I assume this is because Jakub pointed you [1] to the AI
review of the patchset [2], explicitly stating that he didn't further
investigate it. The AI review touches two points, 1) a missing
pskb_may_pull() check, and 2) handling of unknown extension TLVs.

As discussed in the other email, I don't think we should do 2) here at
all. The frame format is fully specified and versioned, frames that
don't follow this are invalid.

Point 1) is actually a valid point, but the rambling of the AI why this
previously worked is wrong (it was a bug already previously). Please add
the pskb_may_pull() check in the next version.

Thanks,
   Felix


[1]: https://lore.kernel.org/netdev/20260331193758.5dd027f6@kernel.org/
[2]: https://sashiko.dev/#/patchset/20260329112313.17164-2-luka.gejak@linux.dev


