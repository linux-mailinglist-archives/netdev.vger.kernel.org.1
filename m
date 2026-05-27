Return-Path: <netdev+bounces-292360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAkANiUSF2pf3QcAu9opvQ
	(envelope-from <netdev+bounces-292360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D15E7269
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DD530DAFC4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE95426D18;
	Wed, 27 May 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4/H3fCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F189423152
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896383; cv=none; b=Nc6YKVTzKtGnf4n5u9ippl/xy8IvIfY/S6bfMaGYj6hEVV1Pu8+BXOmkDw/pmoRwgo7fa2JFF9n2j5NQxmI8jzMVDhmN8o4OOaw+APnpQsjJpkoWgvmPYxXiX6MdA2VHaBLyxDwJ0D1Mh3/kKZFwBNPF8tm2gdAvUj/ozERWg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896383; c=relaxed/simple;
	bh=onG1RawqFcI8NnhLU4G5xlXfAOmprRvmPVBmdp31/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4sos5l/g8q6fTMVSEHVaDEALKGjEjmirp0IRWOSIKfRcEyFH5VN0vSa5Fgj07c5anejswh+hGe1GuR7D3TC8RLhZkNBjBVAlT1Q/LZHlO/K1Q+du69KsKaJOKipckJvik2Co9mdGh2qqkomminDjgxn9IpjaIc5d32IRmdlj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4/H3fCt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-be4344dde59so109058266b.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896380; x=1780501180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0daKFRaEmuHFhe11WXYlg2kJgS3CypnETaj1XfTD4g=;
        b=A4/H3fCt5PNt3vNNcRnjd8AToa27YHRdnxJPuWORfzcvaq+W8ejpkaq+WzszdWKtDa
         h/breJbeyOpCEoGfW6bb0Fpf1A1E4hbzQLFzaqi9QMgcw+931MBTrQhh5r8qXTwLiIb8
         Va7i4ALvoE0BeUWE1E0s/Ip/x94p9cE45Q/VIynl79tXr1WIZ/nC0BNmMjOSJoh6yepT
         rmGYJ52wVLfmABWENjSGGNOSL4vVqGlXubN2lYd6SD0PLb8U3VxiHhsnESEGhCNNkali
         xlna+NtmRsPjqWYkb8P960u5ugpxlGGGXZQrpHxa6phOoNM23zW5do5j8aXnXDm5s+zM
         wBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896380; x=1780501180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0daKFRaEmuHFhe11WXYlg2kJgS3CypnETaj1XfTD4g=;
        b=VSHFHfCCK7A48R8fBTN4G9vM0UWHWvc4k7yVcj+R14zWsc6zglCmh2AuY7F4fJXpnn
         uJYKYRv1IIGZtInBe+zL/ogb7n4VlFEdi2MYQf/LkAb524jJjfpV8BNzghYJqHrc7eVR
         XhzLocpEDJUU02Ff+t1z9SjWYnaWmwsxu0Q4tag/7cg0F5DKYOYMwS4E5ig+/2lbF100
         34HitQdv5nuydanR9iIi+2Wl+Fld6vjuFwvTuGCy6ok09MOWzOasO92tgI2HsxD+gH5d
         Me+33nLgMSCAOaF7PmebP7CJVLu8XSwua+u205vxagq+wQXVSfUg1lMOnIXQoaGlV5Al
         gLSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qliyJ7QxuinZULKCb942D+JHCO5lMQYQpvgcq+l/eRPaIUwRhTjfSRGQogHV+pc8SgRoT78E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OhXXY2gCapGFRYjfTpD+cBxMtFHjunczwPmHI4qLp+vTa5Pe
	xlrrx8X6O4x46OHY5VqFBQ6M9g1rpo4nJb/qgX7GouUsVnVSzkcxlXzU
X-Gm-Gg: Acq92OGa6AV72/4tWOcVpY2BzwUa1sL+7nVYLH8jfQT5PU8INGkK9mmopiorZlZ+56M
	ZuOpPebkins3ge1IJ9l2RkWXB034lE9JDUeEtH9Pc/kqmh1An5dTexf00rg0Itb+Bb2jlWpbY1i
	p5kN9Kza569si9iRDu8B/wD/fix/Frqb4BjqUOgoyUEMj/zoOKtdztqA5PVhoLTM0JkXatmJYms
	tVVYHXzsy27hXBU6sDBq4dyDrroBiWDlI7e3TPxg10rBuWk3q986dbz7AKj7TV7Hq3oC1sC4qI9
	gDjSQ7BTywcYdhVc7MdJTzQYANz4YPA7knRcm9m7JOCx282Irq+NlLIdzpIuPNeLMDLo2uCbOTD
	nLk4ZefnayAle2Tpah2HwalcyzuRJtZKQ177mtTm9Z3S0TZGP8JGDSTDaWWFnFdn3b5xw0AMdE/
	lDqM6LJ5fRV1QLhsdmSVUaSNiZzQKsVd7DdvwxP2F9CxqGy5HJCK8GALyA3nv6Sj/IgPkRT36xf
	/PxgH73p7GezEKfIqjKJKaUWoRtesj0ESbFrLzZ3B5/GSjm6zW9uRMQmCqVl8poMAMDAbKx2a8A
	hT/eHr/h27xrORN2W7g=
X-Received: by 2002:a17:907:b5a3:b0:bce:4be4:cb9e with SMTP id a640c23a62f3a-bdd25ce0c02mr1052749566b.24.1779896379332;
        Wed, 27 May 2026 08:39:39 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-016-123.002.205.pools.vodafone-ip.de. [2.205.16.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc30528a7sm626790066b.21.2026.05.27.08.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 08:39:38 -0700 (PDT)
Message-ID: <2bcddaf2-e3b4-4f72-ae2d-1ac22c2e7553@gmail.com>
Date: Wed, 27 May 2026 17:39:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: add tag driver for LAN9645X
To: =?UTF-8?Q?Jens_Emil_Schulz_=C3=98stergaard?=
 <jensemil.schulzostergaard@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260527-dsa_lan9645x_switch_driver_base-v6-0-4d409ae64f3c@microchip.com>
 <20260527-dsa_lan9645x_switch_driver_base-v6-1-4d409ae64f3c@microchip.com>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20260527-dsa_lan9645x_switch_driver_base-v6-1-4d409ae64f3c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292360-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E1D15E7269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 27/05/2026 16:49, Jens Emil Schulz Ãstergaard wrote:
> Add tag driver for LAN9645x using a front port as CPU port. This mode
> is called an NPI port in the datasheet.
> Use long prefix on extraction (RX) and no prefix on injection (TX). A
> long prefix on extraction helps get through the conduit port on host
> side, since it will see a broadcast MAC.
> 
> The LAN9645x chip is in the same design architecture family as ocelot
> and lan966x. The tagging protocol has the same structure as these chips,
> but the particular fields are different or have different sizes.
> Therefore, this tag driver is similar to tag_ocelot.c, but the
> differences in fields makes it hard to reuse.
> 
> LAN9645x supports 3 different tag formats for extraction/injection of
> frames from a CPU port: long prefix, short prefix and no prefix.
> 
> The tag is prepended to the frame. The critical data for the chip is
> contained in an internal frame header (IFH) which is 28 bytes. The
> prefix formats look like this:
> 
> Long prefix (16 bytes) + IFH:
> - DMAC    = 0xffffffffffff on extraction.
> - SMAC    = 0xfeffffffffff on extraction.
> - ETYPE   = 0x8880
> - payload = 0x0011
> - IFH
> 
> Short prefix (4 bytes) + IFH:
> - 0x8880
> - 0x0011
> - IFH
> 
> No prefix:
> - IFH
> 
> The format can be configured asymmetrically on RX and TX.
> 
> The IFH get/set functions are declared as inline. All the field
> constants are compile-time known, so when these calls are inlined
> efficient code is generated with branches pruned and loops unrolled.
> During testing it was observed that without explicit inlining GCC would
> have trouble inlining the functions, which hurt performance.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 

(snip)

> +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> +				    struct net_device *ndev)
> +{
> +	u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
> +	struct dsa_port *dp;
> +	u32 ifh_gap_len = 0;
> +	u16 vlan_tpid;
> +	u8 *ifh;
> +
> +	/* DSA master already consumed DMAC,SMAC,ETYPE from long prefix. Go back
> +	 * to beginning of frame.
> +	 */
> +	skb_push(skb, ETH_HLEN);
> +
> +	if (unlikely(!pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN)))
> +		return NULL;
> +
> +	/* IFH starts after our long prefix */
> +	ifh = skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);
> +
> +	popcnt = lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
> +	etype_ofs = lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_SZ);
> +	src_port = lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
> +	tag_type = lan9645x_ifh_get(ifh, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
> +	vlan_tci = lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
> +	qos_class = lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
> +
> +	/* Set skb->data at start of real header
> +	 *
> +	 * Since REW_PORT_NO_REWRITE=0 is required on the NPI port, we need to
> +	 * account for any tags popped by the hardware, as that will leave a gap
> +	 * between the IFH and DMAC.
> +	 */
> +	if (popcnt == 0 && etype_ofs == 0)
> +		ifh_gap_len = 2 * VLAN_HLEN;
> +	else if (popcnt == 3)
> +		ifh_gap_len = VLAN_HLEN;
> +
> +	skb_pull(skb, LAN9645X_IFH_LEN);
> +
> +	if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN)))
> +		return NULL;
> +
> +	skb_pull(skb, ifh_gap_len);
> +	skb_reset_mac_header(skb);
> +	skb_set_network_header(skb, ETH_HLEN);
> +	skb_reset_mac_len(skb);
> +
> +	/* Reset skb->data past the actual ethernet header. */
> +	skb_pull(skb, ETH_HLEN);
> +
> +	/* We must deliver the skb so skb->csum only covers the data beyond the
> +	 * real ethernet header. The fake ethernet header in the prefix is
> +	 * not part of skb->csum already. We must subtract what remains of the
> +	 * prefix, the ifh and the gap.
> +	 */
> +	skb_postpull_rcsum(skb,
> +			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
> +			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
> +
> +	skb->dev = dsa_conduit_find_user(ndev, 0, src_port);
> +	if (WARN_ON_ONCE(!skb->dev)) {
> +		/* This should never happen since we have disabled reflection
> +		 * back to CPU_PORT.
> +		 */
> +		return NULL;
> +	}
> +
> +	dsa_default_offload_fwd_mark(skb);

Does the switch (by default) also flood link local traffic (e.g. STP, LACP,
etc)? If not, you should not mark these as fwd offloaded so that the kernel
knows that it needs to do that in software if requested.

Is there is a bit in the header that says whether a packet was flooded or
trapped to CPU that you can check?

Best regards,
Jonas

