Return-Path: <netdev+bounces-267236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E1NMkZXs2kRVQAAu9opvQ
	(envelope-from <netdev+bounces-267236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3749927B7FB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEAB7310A3A9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F0721770B;
	Fri, 13 Mar 2026 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aFhZAJDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699220C490
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360917; cv=none; b=XMik3/9RKibpAMRoFx3hy8Uj1okmCza6/LgdOgoxSkUw7fYiHleN79Evz2Z0/JQ/4LiZDJbbEznHEXpmYKcvXaNYLz4ldo0HXT3UnerTbetUP7z6ECOjZ09j34KdRqUpb7h+hMayM6C/4jaFmDSMXt5sc7SD9Xj9Gr9tiuC20vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360917; c=relaxed/simple;
	bh=Y9lEMiOJWuVnBliGg+6TyD1WzpSYX0eYA4l5wRczvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9IXP72c3EKNni5PKl4YT8HiIqH/prEu45FSeUET+NKzm4yf8Y96Tb4lMJuPOC6jTJe3TQwoFXs6HXfurFPvxGO5V2qdG6YhtmYOBh00MSRD0BMUbzG7dJvAZFKuaHuTVa01Gci5TphrPpC4EEAGcYOPlhsm5MbAuMWYtKsQce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aFhZAJDJ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35a1c6081a5so388718a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360915; x=1773965715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PW/s/EPybKw60UvYTN1AXRWTwN8tPerIA0uLhA0dEA4=;
        b=o4xLWpxLXSCcdqGzIt3tqab0UWyd3LfuNY+1LzP7U+0LF1ni+heKB8opEZDiH1jfRc
         knfSxsK6cZ16ltfrNvItghtpKkl84NkuEMyOIKV8bGKksERKcOuodRAE4j7nuUxI0T+C
         NS+HHtQkE6a1M56PnYI8CbLk488LL5vfe5o2y0+l46OE8Ot5RxrBgQ4EC301v45VIALL
         bk4qd8fgGqZs2coyMW0IFSoVZyLqCdB40zRl2+nTAznve2TMC/PQO8dp5I2VeMuWYhoL
         XmQqeaJRWUTnB11fXEIceV/L24Ao3idlM0ulX+x9PkSvnPqDvcroNZg446c9FnZuNvqf
         x3sg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpEJRJ2IyHWfanQlzv2ZRw+hRYckqbw4IfMBo3PueDu9HdCcdsfTy7ZdpMqbqoc8YLIFB2ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrloikqCQP2DdRD9RaenI02LSu2TTl+A7ShwYfEixdhAkxOuz
	0SLLWLeeTx09wTVcUxPrWYSEzSn7+Fq41OH/An7Cup3npYqa2TUQgDnejJVRHlnCTXQ/AEtk+BP
	3FXH2kzcoBgoWfuR0ZNGKPBq4zXNDRo+7g+krZdwWUaGVTW4oCLoAvlQko5zdiaq0I6EcgEZAlX
	RcXAunAuWTDhed6l9s0322JlmG+fLEvhxV+21yDyNXCgESpaEOLBfiqb6dfv5JwcwDtIRySP4co
	J7ZzHALqAdaQ21j+w==
X-Gm-Gg: ATEYQzwiLQNPV+cxg4SGXDI8RJILmfQWkH5fK5HiXIQosVrV7H3wA6BxbqxR+RvPyJ3
	Hh8dqwohqhPH5AOu1xPOkEX7Ly1gdqxkfkS9c1LiwNE8hfJWcSGHjC4Ay6J21+7XJ58/Zp/ZEBt
	F5kw9Ql//+7vGrBiXLUoXlmGjAurDzNqQpc8AV5Qpq7M7Som3t1oR0Vj6WyTrXjL5O5uZRp7SEx
	WI8Kh2WFytN2BH6vpdwJt58h3U/LqT6DqlwE70D/IYTnp8nhjAWK9MXkmD2LoBEk5vpQSAFi4oQ
	ka+FkoW2hdJJ8xjJm5890MWgM08IUFAgI/lLsnyNXE36GGOz6sKAfcioAFcKvSnSvN0gcb1gPbA
	/ZWhLQIRBeFgSCdnWfPqcMmmAX0c0qMgWijdUr5LgJc/3rDE0i1VvVcZEn//DENzgPSAJOM1OO2
	s03X4ZvTcHy6QDiGFnKc5ZSNhTmsrHU24PH3fJGHJAFT9n3al0EnQBBdIcjC5aVrg=
X-Received: by 2002:a17:90b:4a05:b0:359:f575:cc0f with SMTP id 98e67ed59e1d1-35a119ce127mr4402674a91.6.1773360914603;
        Thu, 12 Mar 2026 17:15:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35a030203fasm673769a91.6.2026.03.12.17.15.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:15:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a564fc62cso143204726d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360913; x=1773965713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW/s/EPybKw60UvYTN1AXRWTwN8tPerIA0uLhA0dEA4=;
        b=aFhZAJDJza96stT69Y9cprTQtXaDh6ns1b/Fmoza45VGJo378ebpa1M4KWpFZlGEBK
         sdwMkPvmzSeKFbX08U8HIsTPHRYlQjLsZNUw17Lg8BhIzKyvE9l9e+LQ6spei9XFgHAd
         y8SUxox2bbNvqbdnenzqKdW0UtWRdgsBeciaQ=
X-Forwarded-Encrypted: i=1; AJvYcCUK+jGLF6LV1f5ijPCWtXMjgvIDP3KF/g5uU4+VcKK7wIO3hdNRkovB+DT41GPCM5viZvEqu58=@vger.kernel.org
X-Received: by 2002:a05:6214:212d:b0:894:5d38:2e38 with SMTP id 6a1803df08f44-89a72a7948fmr80987256d6.18.1773360913224;
        Thu, 12 Mar 2026 17:15:13 -0700 (PDT)
X-Received: by 2002:a05:6214:212d:b0:894:5d38:2e38 with SMTP id 6a1803df08f44-89a72a7948fmr80986446d6.18.1773360912715;
        Thu, 12 Mar 2026 17:15:12 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfc409sm44610356d6.35.2026.03.12.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:15:12 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:15:09 -0400
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <abNXDVPK42wLUPYv@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-3-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267236-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,dama.to,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,dama.to:email,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.gospodarek@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3749927B7FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 05:00:17PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ab73aad40593..c06033cf9f82 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15906,6 +15906,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
>  	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
>  };
>  
> +static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
> +	.xmo_rx_hash		= bnxt_xdp_rx_hash,
> +};
> +
>  static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
>  				    struct netdev_queue_stats_rx *stats)
>  {
> @@ -16790,6 +16794,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto init_err_free;
>  
>  	dev->netdev_ops = &bnxt_netdev_ops;
> +	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
>  	dev->stat_ops = &bnxt_stat_ops;
>  	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>  	dev->ethtool_ops = &bnxt_ethtool_ops;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 90fa3e93c8d6..34bb98709f2b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -232,6 +232,7 @@ struct rx_cmp {
>  	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_ICMP			 (7 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
>  	#define RX_CMP_LEN					(0xffff << 16)
> @@ -311,6 +312,7 @@ struct rx_cmp_ext {
>  	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
>  	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
>  	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
> +	#define RX_CMP_FLAGS2_IP_TYPE				(0x1 << 8)
>  	__le32 rx_cmp_meta_data;
>  	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
>  	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..1f920464b426 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>  				  xdp_buff_get_skb_flags(xdp));
>  	return skb;
>  }
> +
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct bnxt_xdp_buff *xdp = (void *)ctx;
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	enum xdp_rss_hash_type hash_type = 0;
> +	u32 itypes;
> +
> +	if (!rxcmp || !RX_CMP_HASH_VALID(rxcmp))
> +		return -ENODATA;
> +
> +	*hash = le32_to_cpu(rxcmp->rx_cmp_rss_hash);
> +
> +	if (!rxcmp1) {
> +		*rss_type = XDP_RSS_TYPE_L2;
> +		return 0;
> +	}
> +
> +	if (xdp->cmp_type == CMP_TYPE_RX_L2_CMP) {
> +		itypes = RX_CMP_ITYPES(rxcmp);
> +		if (rxcmp1->rx_cmp_flags2 &
> +		    cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE)) {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		} else {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +		}
> +
> +		switch (itypes) {
> +		case RX_CMP_FLAGS_ITYPE_TCP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_TCP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_UDP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_UDP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_ICMP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_ICMP;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	*rss_type = hash_type;
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index 8c66698bde11..fb4f9143929f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -41,4 +41,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
>  struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
>  				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
>  				   struct xdp_buff *xdp);
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type);
> +
>  #endif

