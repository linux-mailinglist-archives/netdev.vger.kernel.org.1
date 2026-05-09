Return-Path: <netdev+bounces-286189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJnZMEA+/2lU3wAAu9opvQ
	(envelope-from <netdev+bounces-286189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 16:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D64FFF58
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDDD300C59D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D322541C;
	Sat,  9 May 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWXwN5RZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61437175A69
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335293; cv=none; b=I1r6bfrC/wk8sfdwMeBrxfWKDZ7OgTR50xvBuKv58mqZ0gf7ivOU8GmT+xaUO4CxYPKtkTlyYTEl8mdcSwpuzAGWVQrYINIYmKMQ88eXuHk9IiassrPic4cge0RlOJrhSjTke28rEkXSy1s3n5sjegOK8XiuK3KEHVgvrzDiRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335293; c=relaxed/simple;
	bh=ryVl5ZiJIV0a0q8v731KaLXpfxXsEZzmZsEUMVQfhP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmM25Plmzq7HzhmDGH20mZ/9Bc8+xsHflx6LJhrSPnEwbL9ybKFPWxzZGYDtSpH1AF7ybQcQspW2D1fOgbxMocfrIJi6Xv+6G/JnVM65tOlSikQwE2CzrqCXBhlPHNIZI0ixAS7iWQRs0k8Rup5PIW1pp0cln4XAb21hYUOwK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWXwN5RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70708C2BCB2;
	Sat,  9 May 2026 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778335293;
	bh=ryVl5ZiJIV0a0q8v731KaLXpfxXsEZzmZsEUMVQfhP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWXwN5RZYsj/8sp8lAmN3dBOMt3XgnHNfiTkNoCr03dfToBvANj+QA7HXyuSFth9l
	 PagkQmsnEMotkvInZPp6W/I2Y4PysE4Q/n3LQGVZ/kk6RxmFsHYRrmgVZXOizN15J2
	 MEihOhKFQlb7x8j+tqR8vho63NBC26dsxFxjk7xEyCKUZFfvi9zu8fxM5e0nzix7EB
	 BbvVZikJn+XkZQ5Dre+K/v/yZyYayDvl4rAOiKPBDjD7+8C26s/YgAtiTkHyBzCMUP
	 IoCmXAv86eMandbCXlYqaHLHaT6CFDbQPHLM4i0rvb81G7yLPvsOgjztTP88axs6Y5
	 0DKfJW+qnNABg==
From: Simon Horman <horms@kernel.org>
To: steffen.klassert@secunet.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	sd@queasysnail.net,
	tobias@strongswan.org,
	herbert@gondor.apana.org.au,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v2] esp: Consolidate esp4 and esp6
Date: Sat,  9 May 2026 15:00:21 +0100
Message-ID: <20260509140020.1312473-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <afr4ipktV91sA8WU@secunet.com>
References: <afr4ipktV91sA8WU@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 188D64FFF58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286189-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
esp: Consolidate esp4 and esp6

This commit merges the common code from esp4.c and esp6.c into xfrm_esp.c to
reduce duplication. It adapts the input and output encapsulation paths to
use indirect function calls.

> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 9f75313734f8c..9d6e030510860 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
[ ... ]
> +static int esp6_input_encap(struct sk_buff *skb, struct xfrm_state *x)
> +{
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +	int offset = skb_network_offset(skb) + sizeof(*ip6h);
> +	struct xfrm_encap_tmpl *encap = x->encap;
> +	int hdr_len = skb_network_header_len(skb);
> +	u8 nexthdr = ip6h->nexthdr;
> +	__be16 frag_off, source;
> +	struct udphdr *uh;
> +	struct tcphdr *th;
> +	int ret;
>  
> +	ret = ipv6_skip_exthdr(skb, offset, &nexthdr, &frag_off);
> +	if (ret == -1)
> +		return ret;
>  
> +	ret += hdr_len;
>  
> +	uh = (void *)(skb->data + ret);
> +	th = (void *)(skb->data + ret);

If hdr_len is added to ret before computing the uh and th pointers, does this
cause the pointers to overshoot the transport header by hdr_len bytes?

If uh->source reads from inside the decrypted ESP payload instead of the actual
UDP header, it seems this would almost always mismatch encap->encap_sport.
Could this lead to the kernel unconditionally calling km_new_mapping() on
every received packet, breaking IPv6 NAT-T?

> diff --git a/net/xfrm/xfrm_esp.c b/net/xfrm/xfrm_esp.c
> new file mode 100644
> index 0000000000000..4f75e1ace3bbc
> --- /dev/null
> +++ b/net/xfrm/xfrm_esp.c
[ ... ]
> +#ifdef CONFIG_INET_ESPINTCP
> +static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
> +{
[ ... ]
> +#else
> +static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	WARN_ON(1);
> +	return -EOPNOTSUPP;
> +}
> +#endif
[ ... ]
> +#ifdef CONFIG_INET_ESPINTCP
> +static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
> +					       struct sk_buff *skb,
> +					       struct esp_info *esp)
[ ... ]
> +#else
> +static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
> +					       struct sk_buff *skb,
> +					       struct esp_info *esp)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +#endif

Since the TCP encapsulation methods are guarded exclusively by
CONFIG_INET_ESPINTCP, does this break IPv6 ESP-in-TCP if
CONFIG_INET6_ESPINTCP is enabled but the IPv4 equivalent is disabled?

If CONFIG_INET_ESPINTCP is not enabled, these functions fall back to returning
-EOPNOTSUPP. Should these preprocessor guards check for both
CONFIG_INET_ESPINTCP and CONFIG_INET6_ESPINTCP?

