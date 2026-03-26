Return-Path: <netdev+bounces-272096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MRJEK5HxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 495513370A3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81BD1309BD47
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710A401A1A;
	Thu, 26 Mar 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC5TeLlm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B60401A2C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535403; cv=none; b=Z2Zw7mj1YKzP4Sx6UxSyuvaqmTpxxZsot1S548HxY6LwS6FaqboYRm5N3jj0Bs/GAE6XuofFMgUtPnoo7drapMjPA+HfSTj3X7KG3sz3vuATR1RCUZc+yQj5XLR/h9Jg/ccusHWTXek9/+LSg3loZmFmvgeHIf5Nomqh22ek/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535403; c=relaxed/simple;
	bh=VbuDMb+H+FjceHqWGQreAgIpUzCdyguZjD7Y9UveUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0/kZdke4N0li0lWw+KlshMNoGztwQTckDFiPWWSmX8psjepDbHHZ6UZccDENJULGs1OPEGfIdzGWcGmNYZ9V2ThGZ6OzOSXXKwVkM0lOZwVQsW7NVZZnQqEjuZGFW+ABwdFAN2qT5Stg3+gBraYDwcSaOhm4LIfcCqK+FxqufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC5TeLlm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774535398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0lPlN5i4axD7w00CmonF0qGRN2vy8UaEGXm/6LQ520=;
	b=DC5TeLlm9Aymc5OcdpLwTWoNABxy56kJT+lxfhjUDnvgj+9TufSd3c3NS7ddGuJwmEMJ8l
	z1wnaslCfpzs2s4zfsg8cwhaaowthaLN/VOeTAzFjvVFQwXdc85tdCPincM9g8RrDK232r
	6+3TRb9V1WdlDwX5N+SAgcnPE+gFJS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-sf8Dk5A-N9KmkfdW1xCRHA-1; Thu,
 26 Mar 2026 10:29:54 -0400
X-MC-Unique: sf8Dk5A-N9KmkfdW1xCRHA-1
X-Mimecast-MFC-AGG-ID: sf8Dk5A-N9KmkfdW1xCRHA_1774535393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1748A19560AF;
	Thu, 26 Mar 2026 14:29:53 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E043000223;
	Thu, 26 Mar 2026 14:29:50 +0000 (UTC)
Date: Thu, 26 Mar 2026 15:29:47 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/4] net: hsr: require valid EOT supervision
 TLV
Message-ID: <acVC20oV12VtIsrt@thinkpad>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
 <20260324143503.187642-4-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324143503.187642-4-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-272096-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 495513370A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:35:02PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
>
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> with a length of zero.
>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

> ---
>  net/hsr/hsr_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index aefc9b6936ba..d26c7d0e8109 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
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


