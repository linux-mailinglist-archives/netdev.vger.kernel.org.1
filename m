Return-Path: <netdev+bounces-286187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KRjO0k9/2kn3wAAu9opvQ
	(envelope-from <netdev+bounces-286187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:57:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D34FFF0B
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E17530013A7
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A62527AC31;
	Sat,  9 May 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/JYVpmU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBD1A2392
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335043; cv=none; b=n31mR8wYxtR2kpA0YWRtBt3tctON4HrysJBNTCJ2kri67C9SjqxoF0XMI6neo9jTkY71X9DsYZ583XPfYZ0SF1xseWvXuXAQvAHnblk5NtJ2Tjv38iBxcjmxh6ASz77KSC4HvUE8H5bXI9p4lqLbhRoa3b8/uD7ma1ajSAeLMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335043; c=relaxed/simple;
	bh=cxc9n++18QJ7wy+EjcfEz49X2FxVZv+VqE1pXVjdRto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLldtB0eRuiI1Mdg0rtJMNXFDfjRzvoV3fBP2nKm4Hr7BgPe/bLDxuk+CrllRmsJxMTe0xj4RgaoDNBKLrGFgA4VqtPkNp8emm4o5kGN4B6vSyL2MxMCvS6QCpCvScUyWQlJScGSttolkkx7YvsM8e7Uva/rj7TDZcw+LdrTa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/JYVpmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6F9C2BCB2;
	Sat,  9 May 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778335042;
	bh=cxc9n++18QJ7wy+EjcfEz49X2FxVZv+VqE1pXVjdRto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/JYVpmUebedpNFZZSiSdJNKwe5V5jwZThqfh+fXVTR/C0XVNWmk7C1arDlw17pPk
	 bVv+drG7uoVXrtavnw6sSCCcpI5LpRgHkVdRwbqhUW16mfCjW/d/9cytkWBKILLylE
	 cXXwGB92KkJYHfc15eE8PbUB0bl154ls+XPW33xJAmmETW6dQ5JiH0e2K5IMFKNmM+
	 09t1uSRsVrnlR3DMdOLjyJYGVYwhsrhISoZRoh7Otwmu9bBeSAGwgf1grXbRlNs+ah
	 RhhoyMirX4QhggYtDcXChnBnc8b6E5IDgGvrUjy0Ur7666oTSxPr4AwDlJITdc0H18
	 GfWeQlvvtApOg==
From: Simon Horman <horms@kernel.org>
To: steffen.klassert@secunet.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	sd@queasysnail.net,
	tobias@strongswan.org,
	herbert@gondor.apana.org.au,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v2] esp: Consolidate esp4 and esp6
Date: Sat,  9 May 2026 14:56:40 +0100
Message-ID: <20260509135639.1309815-2-horms@kernel.org>
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
X-Rspamd-Queue-Id: F27D34FFF0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286187-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,secunet.com:email]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Now I have enough to produce the report.

commit 64848fd4fb36bc803f3ebb41951e5c02a19f0280
Author: Steffen Klassert <steffen.klassert@secunet.com>

esp: Consolidate esp4 and esp6

This patch merges common code of esp4.c and esp6.c into a new
xfrm_esp.c. ESP output/input, AEAD setup and the TCP/UDP encapsulation
helpers are shared between IPv4 and IPv6, with three family-specific
hooks (input_encap, find_tcp_sk, output_encap_csum) added to struct
xfrm_type.

> diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
> index 22895521a57d..b1c38d7d286e 100644
> --- a/net/ipv6/esp6_offload.c
> +++ b/net/ipv6/esp6_offload.c
> @@ -290,14 +290,18 @@ static int esp6_input_tail(struct xfrm_state *x, struct sk_buff *skb)
>  {
>  	struct crypto_aead *aead = x->data;
>  	struct xfrm_offload *xo = xfrm_offload(skb);
> +	int hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead);
>  
> -	if (!pskb_may_pull(skb, sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead)))
> +	if (!pskb_may_pull(skb, hlen))
>  		return -EINVAL;
>  
>  	if (!(xo->flags & CRYPTO_DONE))
>  		skb->ip_summed = CHECKSUM_NONE;
> +	else
> +		skb_postpull_rcsum(skb, skb_network_header(skb),
> +				   skb_network_header_len(skb));
>  
> -	return esp6_input_done2(skb, 0);
> +	return esp_input_done2(skb, 0);
>  }

Has the non-offload IPv6 ESP input path lost its skb_postpull_rcsum()
for the IPv6 header?

Before this patch, esp6_input_done2() did:

    skb_postpull_rcsum(skb, skb_network_header(skb),
                       skb_network_header_len(skb));
    skb_pull_rcsum(skb, hlen);

and that call was introduced by commit a9b28c2bf05d ("esp6: Fix RX
checksum after header pull") to compensate for ip6_input_finish()
stripping the IPv6 header without adjusting skb->csum, fixing
"hw csum failure" warnings on devices delivering CHECKSUM_COMPLETE.

The new esp_input_done2() in net/xfrm/xfrm_esp.c only does:

    hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead);
    skb_pull_rcsum(skb, hlen);

and the postpull is reinstated only in esp6_input_tail() under the
"xo->flags & CRYPTO_DONE" branch. Non-offload software-decrypt IPv6
ESP RX therefore no longer compensates skb->csum for the outer IPv6
header bytes. Is this an intentional change, and if so what replaces
the fix from a9b28c2bf05d?

The commit message says "Move the skb_postpull_rcsum() call to the
offloading codepath, it is needed only there", which seems to
contradict the stated reason for a9b28c2bf05d. Is there a later commit
or code change that makes it unnecessary in the non-offload path?

> diff --git a/net/xfrm/xfrm_esp.c b/net/xfrm/xfrm_esp.c
> new file mode 100644
> index 000000000000..4f75e1ace3bb
> --- /dev/null
> +++ b/net/xfrm/xfrm_esp.c

[ ... ]

> +#ifdef CONFIG_INET_ESPINTCP
> +static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	struct sock *sk;
> +	int err;
> +
> +	rcu_read_lock();
> +
> +	sk = x->type->find_tcp_sk(x);
[ ... ]
> +static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	int err;
> +
> +	local_bh_disable();
> +	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb);
> +	local_bh_enable();
[ ... ]
> +}
> +#else
> +static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	WARN_ON(1);
> +	return -EOPNOTSUPP;
> +}
> +#endif

Is CONFIG_INET_ESPINTCP the right guard for this shared file?

This new xfrm_esp.c is compiled for both IPv4 and IPv6 ESP, but the
TCP-encap helpers are wrapped with #ifdef CONFIG_INET_ESPINTCP, which
is the IPv4-only Kconfig symbol. The IPv6 counterpart is
CONFIG_INET6_ESPINTCP, and both symbols "select XFRM_ESPINTCP" as the
common hidden symbol (see net/xfrm/Kconfig and net/xfrm/Makefile,
which uses obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o).

For a kernel configured with CONFIG_INET_ESPINTCP=n and
CONFIG_INET6_ESPINTCP=y, the full esp_output_tcp_encap() /
esp_output_tail_tcp() are not compiled in, so the stub returning
-EOPNOTSUPP with WARN_ON(1) is selected, and any IPv6 ESP-in-TCP
output call ending up in esp_output_head() -> esp_output_encap() ->
esp_output_tcp_encap() will fail. The same #ifdef also appears further
down around esp_output_tcp_encap().

Should these two blocks be guarded by CONFIG_XFRM_ESPINTCP instead?

> +static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
> +					       int encap_type,
> +					       struct esp_info *esp,
> +					       __be16 sport,
> +					       __be16 dport)
> +{
> +	struct udphdr *uh;
> +	unsigned int len;
> +	struct xfrm_offload *xo = xfrm_offload(skb);
> +
> +	len = skb->len + esp->tailen - skb_transport_offset(skb);
> +
> +	uh = (struct udphdr *)esp->esph;
> +	uh->source = sport;
> +	uh->dest = dport;
> +	uh->len = htons(len);
> +	uh->check = 0;

Can this silently truncate uh->len?

The old esp6_output_udp_encap() explicitly rejected len > U16_MAX with
-EMSGSIZE before writing htons(len) into the 16-bit UDP length field,
and the old IPv4 esp_output_udp_encap() rejected len + sizeof(iphdr)
> IP_MAX_MTU. Both bounds are gone from this consolidated helper.

The commit message says:

    "Remove the IP_MAX_MTU check from UDP/TCP encap.
     The IPv4/IPv6 local_out function will do that ceck later."

local_out checks the outer IP packet length, not the UDP 16-bit length
field. In the software-fallback branch of esp6_xmit() (the !hw_offload
path calling esp_output_head()), skb->len of a GSO skb can exceed
65535 pre-segmentation, so the htons() can truncate uh->len without
any earlier check rejecting the packet.

Should the >U16_MAX check be retained in esp_output_udp_encap(), at
least for IPv6?

> +#ifdef CONFIG_INET_ESPINTCP
> +static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
> +					       struct sk_buff *skb,
> +					       struct esp_info *esp)
> +{
> +	__be16 *lenp = (void *)esp->esph;
> +	struct ip_esp_hdr *esph;
> +	unsigned int len;
> +	struct sock *sk;
> +
> +	len = skb->len + esp->tailen - skb_transport_offset(skb);
> +
> +	rcu_read_lock();
> +	sk = x->type->find_tcp_sk(x);
> +	rcu_read_unlock();
> +
> +	if (IS_ERR(sk))
> +		return ERR_CAST(sk);
> +
> +	sock_put(sk);
> +
> +	*lenp = htons(len);

Can *lenp be truncated here?

The previous IPv4 and IPv6 versions both had "if (len > IP_MAX_MTU)
return ERR_PTR(-EMSGSIZE)" before writing the 2-byte espintcp length
prefix. espintcp frames ride over TCP and are not bounded by any IP
MTU that local_out will later enforce on the outer header, so the
local_out justification in the commit message does not seem to cover
this case. Should the len > 65535 check be preserved here?

