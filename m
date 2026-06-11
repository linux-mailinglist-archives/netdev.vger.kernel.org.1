Return-Path: <netdev+bounces-297947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KFQhIRpOKmrlmgMAu9opvQ
	(envelope-from <netdev+bounces-297947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0AA66ED60
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:56:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="FJ0b9/Rs";
	dkim=pass header.d=redhat.com header.s=google header.b="TH/8dh9T";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297947-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297947-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91508301A28A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F469344DA8;
	Thu, 11 Jun 2026 05:56:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31292305E28
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:56:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157397; cv=none; b=qE+ACbkdCgnpATRsMkTbnuc2O2M0OwS1GECuyntc054MwvVIAuTA7XT1dDBJXP/23lxkxqdk3GGIa9Tnu6Ulkol4hHaQEemulm27bEfVQUoPaP4WVsA4RIWyZGhhzJ9ggORgMGnUI0BjLLVatJqJpPrLcLmAbkaF/PWGaN/u9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157397; c=relaxed/simple;
	bh=8RgB4L/mtyXUigOfElNRhYNFAjXq4m+NZ5s58y2e468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8mA2EKPirPOp+2jXL3lMXK3UY011Se2WRaShNJsbOvVPkhISGuTUSZvPoVo5cjoRQtG+dzAkSHY2+wxTUC+wseeWmzQru/U+JVe+R0fsxV2gy5BN58a9954lbnG7ZqhV7qC43T5IiJ0/w89Gckyk9723U3ClYCulFUOttMPK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJ0b9/Rs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TH/8dh9T; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781157393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NVtvAee8olyH9I5i9y9HtNMlvI+nO9nnsWLj7hlmuk=;
	b=FJ0b9/Rsm6IZ54JvweCSjDeZuESR0up/Z9WsQqqeRFBBwgPtRvYI2Bpol4RBKrhEcgkpuG
	m8AHqHwLbY6FTOitrcPO3ChlCN+4jWmIntVqXKeaMABheWWTiDqDJO0rQLEg/iAPXH3pH6
	IH7eFvBcspsWl29j9nXdjN9hl9/Tzg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3Y55nBq8MkWBg9-tPCbIEg-1; Thu, 11 Jun 2026 01:56:32 -0400
X-MC-Unique: 3Y55nBq8MkWBg9-tPCbIEg-1
X-Mimecast-MFC-AGG-ID: 3Y55nBq8MkWBg9-tPCbIEg_1781157391
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso4455667f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781157391; x=1781762191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NVtvAee8olyH9I5i9y9HtNMlvI+nO9nnsWLj7hlmuk=;
        b=TH/8dh9TC2JoXleK+EI8iv4YMFyhBrHbjMRXgfUJCJpEwFQSvtCAj8xc6GkYHCBOdH
         mizdIZXHX2Y5wKoZUzIVmxfNKTk5qJ3sXksPfPMfGrvEu2w7JEnmVz5fAPgr9NgG7lW6
         Mendqi7THUuayUfGhgzXFmGOnrFCN2FmmZpvKfAjKI8AOngJYQ8lBTvQ302rITejFOdx
         rbLFHIxkechN1M96mXtbLwqfxANj0vQnDhtGI4Ew+A2cyzLMqp9rAlJ2VArzlytE3i0A
         RnZSQLQSIilwLZCXVy6ADCNKla3LM096K0KLJgeiFQcubroXShk9aqTFc2t07tqvUR+f
         TWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781157391; x=1781762191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NVtvAee8olyH9I5i9y9HtNMlvI+nO9nnsWLj7hlmuk=;
        b=Qs3f0i+TumQYqiNJaeeVyk3uS1Raqi5zIm46GV4jCAYDzcmpdiItlx5A/FfgBfCDM/
         JHbnCmzX0X4DtkZNrF+yNFJV7u4NRUCyVlesSaixf20gUlzQL+44AzDNf5RO1a3HiSog
         gyM2Y0lfs50EmG99kvF5ypd9rpW5r+CLiCaN0EHi8EyPu1ZUs0oigwEs0fphglWG8bOh
         eQSuNOq5ACZ0bSLwOnkYuy9RXRBrplffdJq1AJSAMHHbFXnVOVClMkbLyOX1yoN8Dkia
         pPk+JfHHr34dMTdJh1nnnRgjBb+CmfjUibn+7mfGPt9ivooUJ2cd2VIosbYJYyr2/lTH
         vWmA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ddh2mLAs6kJ2U5gNpnwI2qipcRcpWy2Lh+kTEBe+X1LdY+MI1av9AaxyegmVFSwKWEYwnNt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWX8cERc+eSSl9HMaJmO64a+eDdV9nCHedgcGZP2ZhNA18Js5
	V53ChO6XN5zRckvglleI/k81H+qIxJlC92tjvzHbODBm/7VX8U54bAbpGb5kTr6AujHKHiSYWQv
	EM7JZ2SvtamKRu85/qLPvRdaB7p8iRUZhdgRoEfmoEtB1fEVr+Ejs4VWLYA==
X-Gm-Gg: Acq92OG+PUMJRos1saVOELWyfTvcq0vGDFhKHMLF8hESOfz9C+To7ikWLwXojJHyoIf
	pAjq6P/uxYPJxq84JF5rjSfH7/rfDlYdG/h6xGmEYJTtzjRYCa04Um5Dyc771wjLLYXg8Wfgi6v
	SSJ8JAijyyJN1QIBaF7tpGLmL1f9RUWp1UXImXJcZ0+sIUpB9VtkkYabKU3gB219RBooI/Nv6hR
	/hXuukH1ng0N/k7YaxZv+WgeAjYJT1eGlN4ST/sITkZE9mfFzl428c6eHJ0vt1Gx+bkV6PCzOuv
	Ei4+i02AuZz5xEF++Y1Gfq6fgYnoforPs4kPt+1ImYjQaQdiKLLk+XP972Lkt7NzMyDJCNUJQ0o
	u1ySs+tE4CVJaE2UEWfDzAhvcZC5FpdXwrCgnnrRdSm76uf9QQ3rRQQ==
X-Received: by 2002:a05:6000:490c:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-46067593598mr1505315f8f.17.1781157390704;
        Wed, 10 Jun 2026 22:56:30 -0700 (PDT)
X-Received: by 2002:a05:6000:490c:b0:45e:f52b:f4b7 with SMTP id ffacd0b85a97d-46067593598mr1505285f8f.17.1781157390190;
        Wed, 10 Jun 2026 22:56:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm85429628f8f.24.2026.06.10.22.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 22:56:29 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
Message-ID: <20260611014519-mutt-send-email-mst@kernel.org>
References: <20260611024616.1408317-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611024616.1408317-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297947-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA0AA66ED60

On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> 
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks for the patch! Something small to improve:

> ---
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> 
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;

Assignment can happen here?

>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;

Took me a while to figure out what is going on, but I finally
understand:


Reducing
(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE 

(what we allocated)

by sizeof(struct padded_vnet_hdr) - vi->hdr_len


right?

So clearer as:


	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
	sizeof(struct padded_vnet_hdr) + vi->hdr_len;




> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  
> -- 
> 2.43.0


