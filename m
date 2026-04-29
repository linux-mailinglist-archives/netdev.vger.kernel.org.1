Return-Path: <netdev+bounces-282153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OZiTA1JP8WmGfwEAu9opvQ
	(envelope-from <netdev+bounces-282153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934248DBBD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83B4C3007B88
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6E175A81;
	Wed, 29 Apr 2026 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7ivJSpa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D09443
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422158; cv=none; b=h4VW2rUj+CONd+7Nl0H4Pk5W8mwYUrFpc51oUCUhmLFxEHWqgODrtTWCBvJY4NSrssB9QB3wskJ9lLCWIJatgiGvRlHSSIHpt7B4mA0/W19+02QIAPF8hfeyX6RYLateCKrngYUFrRiAvbbqZSgSAaDBbbYb7PiprPPYCasP/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422158; c=relaxed/simple;
	bh=xEGh2fjdBYOT/+eYnYy09+VNafwCeHVdF9I208pZw4w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mhAfZsd2OzP1sKVSnihZAYf1YuE3/ywaMFflVEJpYWJ/lN1hfFijaztgslcAAaIv/GWGJH+kNt/nYFYxhVvqq7xQKXYdARL/Zx9+2VfuewDffgka80TPp7dbbGB6WEwAkkfnYtFNXwoMVEYLdSw1UihLQIUOckuX5udAXKUvi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7ivJSpa; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501547d7edso11373991d50.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777422156; x=1778026956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etfc/G/iwnspVWx/C0PU9T6hM3zZHBOrealtj7HVn+0=;
        b=s7ivJSpa0MX+FYg+62BFO+s4BXzPzbH0q0ntKhGIR2epbrJslFT791g1+0u3DJQWgg
         txGNCTkVCbOuwf0Jk48k/gP31cEb5ortQxkLS5f/1VNombJ7ZPbuXK6NaQLkARSZkjA7
         i3gAigBl8xMnRo/AGuF+iBdm229901q9vG3van0QcKy4PTlwONhuBc8WQ2FaxcLggTZ4
         55/0hh5D0hONAI5v3vCbuLyzLrDhBzlfh64Z0vxwugY9RV2sFo8Va+Q1PpJ+Av7SV8LO
         pfh+mDb2i40ak4w2ktMpuwi1jPGQ4WWzuMnXZWr6Qn+hXHXcU2zY6NYc8IDQKc5fHije
         FpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777422156; x=1778026956;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etfc/G/iwnspVWx/C0PU9T6hM3zZHBOrealtj7HVn+0=;
        b=Zn01HaSHZ0UXvWtCNRqKWiN2bn3ts25WXYblFya8vWSpiKFPiwmleB39zcdNRDR7Nz
         R8+VVFQBYvhcLaPhATrdEFgd5tm2wk12uCNR/4erPLqXLxCqlfjGkNFrI5TR5Aizp9Bw
         f4yYzcYds+1lCTfzkfUr97yq/4iOnDzSz1sFn/zTlvgkhFMJLfw8haPUMiFGbtZVvN3Y
         YnLJHSqT53Y8NPqd4CxNDZFHDerCZ4uCkNnXI0N9h6bMv+bxqAm05gI7wlDg8DSN30QR
         IvZ6sNgX/jNvYrjGKFpr/aI0b3hXSZ9nNq8XpZyHDkQUHi42X1b9TTFXxq3K9wOrcgn9
         pUUQ==
X-Gm-Message-State: AOJu0YyS6haTjFmFV140YNKFbTuSigw9A4265c9Bfg6vwsmtoEigSLSY
	yZ+ma2/y/nzDSRSmZ+konYdZMVlFkrId/s/GB2OkP1twTWgi977weaO5
X-Gm-Gg: AeBDievtdrPNOy46KhZT9kMU+/di/6XV1Wjl3mh0TIm9usbDWOO0hNowzsADRuVHp6b
	LAYD38uydEGf7NAZbQBbKmghqFULnGtoxLGrAYuG9fhoxgw8bHkdH7D/ZrW0BXmIiEp2pQia165
	CwCKeRaA+8hYVCZB5wWE1w4cnmUL2z+kDcLoTxYKzI08R6F8675wcA/6zVPCzgMmb56+EMqvX26
	GHg0AfnTVLEltfDBFOrea4k/0EEtdSArnX5TaDV9ByQAxi7xKkDz9hl2T5LyerIhbCUWSNG6Nl1
	9/xzSi7qgRyvzJ3URzRAl9zwrW9CSZDn5NAhpEjEiCPE1YwfyFSpjcxG4JVlnEva/98TXU37FNH
	HTAX7bPK1w+bhp/HH+zhqbkNvE4lQhVLhFVJT+HH18BS2Li6XXZObTUZnxA9l0PWijWJx7iHuw8
	0PbN9KIm4skt6Yu40hyImGj/nN+Ak4jg1sekLpq39RQbSG8ORzkbl8nj9MQlzBLNHwcYMf5tFAK
	AboHU2gY0TRnK0=
X-Received: by 2002:a05:690c:a8f:b0:7b3:f33:35ab with SMTP id 00721157ae682-7bcf4fc0816mr58262727b3.1.1777422155728;
        Tue, 28 Apr 2026 17:22:35 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd252a3b35sm6738787b3.11.2026.04.28.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:22:34 -0700 (PDT)
Date: Tue, 28 Apr 2026 20:22:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.223eebd28b57a@gmail.com>
In-Reply-To: <20260428205352.1247325-4-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
 <20260428205352.1247325-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] psp: validate IPv4 header fields in
 psp_dev_rcv()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7934248DBBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282153-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]

Jakub Kicinski wrote:
> psp_dev_rcv() is called from the NIC driver's RX completion path
> before the frame reaches ip_rcv_core(), so the IP header has not
> been validated in SW, yet. We expect that the device has done
> all this validation, but let's also add the SW checks, to avoid
> surprises.

If devices are expected to have verified this, should these be more
noisy checks, similar to netdev_rx_csum_fault?

 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/psp/psp_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index f069117c867a..524978dfb8fd 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -300,6 +300,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>  	if (proto == htons(ETH_P_IP)) {
>  		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
>  
> +		if (unlikely(iph->ihl < 5))
> +			return -EINVAL;
> +
>  		is_udp = iph->protocol == IPPROTO_UDP;
>  		l3_hlen = iph->ihl * 4;
>  		if (l3_hlen != sizeof(struct iphdr) &&
> @@ -335,6 +338,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>  	if (proto == htons(ETH_P_IP)) {
>  		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
>  
> +		if (unlikely(ntohs(iph->tot_len) < l3_hlen + encap))
> +			return -EINVAL;
> +
>  		iph->protocol = psph->nexthdr;
>  		iph->tot_len = htons(ntohs(iph->tot_len) - encap);
>  		iph->check = 0;
> @@ -342,6 +348,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>  	} else {
>  		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
>  
> +		if (unlikely(ntohs(ipv6h->payload_len) < encap))
> +			return -EINVAL;
> +
>  		ipv6h->nexthdr = psph->nexthdr;
>  		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
>  	}
> -- 
> 2.54.0
> 



