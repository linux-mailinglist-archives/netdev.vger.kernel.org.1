Return-Path: <netdev+bounces-270997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIZQKGpxwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:11:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0B307123
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A86C1303ECC4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCF3E5590;
	Tue, 24 Mar 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoV8UPkH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE3E866F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349750; cv=none; b=H+9F1if+JPX/zMJdr7hdlF6An06AYwEWEMfhLmoV2xIBVjet+vzitBRz9M2lK9JrFXG5bHm/p4RPwHda7B6OCEKdk43bLliYk1W0zrRvQ5GBfVUb8/872i8dnKWRgxG6/+9iusvGTXnRYhWSDaT0Uxu/UsORb0Xz10Cv+b4tkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349750; c=relaxed/simple;
	bh=9reHqaEQHSaEIcY5uVJvIuyJuAFcS8ySWsb25gbLv2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOHT29FmCmrMl5bJhuvwYVCXlwy1OT0JZA1T0iQ2H16ibaC1mF4beZxsgWqELAe76EeG2QbS8sNZs1y0E1ZJHOX32V5ltLFM2+AK8p5f/0UDoTYaUCxVXQwbEA5Z3fE7z7Vw2nMr4zeFWMslAxjiXNjEWCMnGqaER740kobon+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoV8UPkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774349747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ja7iUxjh4Mzh8SBaPIoROLhvcU3SlPPZC5KlAtOp/gw=;
	b=PoV8UPkH2pIILbBIz2sLVNHfAJ9f9fdTCKynqmUyCx/Z+XpnD+lKKsdJHwTA2hxGA0Co6y
	7QnH/QGWcE6fIIcan4xKmUoqVVTb/E68nsRV0LLP2GQXPxXJ+QhUjUVuaW1DNJxeJxt6ZC
	WKUuJY4BJOZaDcg7y+0kuNH0t42EAJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-cCmCq8FrPiSOclhRKjtYEw-1; Tue,
 24 Mar 2026 06:55:44 -0400
X-MC-Unique: cCmCq8FrPiSOclhRKjtYEw-1
X-Mimecast-MFC-AGG-ID: cCmCq8FrPiSOclhRKjtYEw_1774349743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EDB119560A6;
	Tue, 24 Mar 2026 10:55:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFB8C1800764;
	Tue, 24 Mar 2026 10:55:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mail@birger-koblitz.de
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org
Subject: Re: [net-next,v3,2/2] r8152: Add support for the RTL8157 hardware
Date: Tue, 24 Mar 2026 11:55:37 +0100
Message-ID: <20260324105537.385457-1-pabeni@redhat.com>
In-Reply-To: <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
References: <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-270997-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A5F0B307123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8152: Add support for the RTL8157 hardware

The RTL8157 uses a different packet descriptor format compared to the
previous generation of chips. Add support for this format by adding a
descriptor format structure into the r8152 structure and corresponding
desc_ops functions which abstract the vlan-tag, tx/rx len and
tx/rx checksum algorithms.

Also, add support for the SRAM access interface of the RTL8157 and
the ADV indirect access interface and PHY setup.

For initialization of the RTL8157, combine the existing RTL8156B and
RTL8156 init functions and add RTL8157-specific functinality in order
to improve code readability and maintainability.
r8156_init() is now called with RTL_VER_10 and RTL_VER_11 for the RTL8156,
with RTL_VER_12, RTL_VER_13 and RTL_VER_15 for the RTL8156B and with
RTL_VER_16 for the RTL8157 and checks the version for chip-specific code.
Also add USB power control functions for the RTL8157.

Add support for the USB device ID of Realtek RTL8157-based adapters. Detect
the RTL8157 as RTL_VER_16 and set it up.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index bab8e10e5f99..6cd3c321edb4 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -1617,6 +1734,122 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
>  	return ret;
>  }
>
> +static int wait_cmd_ready(struct r8152 *tp)
> +{
> +	u32 val;
> +
> +	return poll_timeout_us(ocp_read_dword(tp, MCU_TYPE_USB, USB_ADV_CMD, &val),
> +			       val, !(val & ADV_CMD_BUSY), 50, 1000000);
> +}
> +
> +static u32 ocp_adv_read(struct r8152 *tp, u16 cmd, u16 addr, u32 *data)
> +{
> +	int ret;
> +
> +	ret = wait_cmd_ready(tp);
> +	if (ret)
> +		return ret;
> +
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_ADDR, addr);
> +
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_CMD, cmd);
> +
> +	ret = wait_cmd_ready(tp);
> +	if (ret)
> +		return ret;
> +
> +	ret = ocp_read_dword(tp, MCU_TYPE_USB, USB_ADV_DATA, data);
> +
> +	return ret;
> +}

Should ocp_adv_read() return int instead of u32? The function returns
'int ret' which can be 0 or -ETIMEDOUT from wait_cmd_ready(), but the
function signature declares u32. The companion function ocp_adv_write()
and all callers (rtl_bmu_read, rtl_ip_read) correctly use 'int ret' and
check 'ret < 0' for errors.

[ ... ]

> @@ -2252,8 +2507,17 @@ static inline void rtl_tx_vlan_tag(struct tx_desc *desc,
>  	}
>  }
>
> +static void r8152_tx_vlan_tag(void *d, struct sk_buff *skb)
> +{
> +	struct tx_desc *desc = d;
> +
> +	rtl_tx_vlan_tag(desc, skb);
> +}
> +
>  static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
> -			 struct sk_buff *skb, u32 len)
> +			 struct sk_buff *skb, u32 len);
> +
> +static int r8152_tx_csum(void *d, struct sk_buff *skb, u32 len)
>  {
>  	u32 mss = skb_shinfo(skb)->gso_size;
> +	struct rx_desc *desc = d;

Is this the correct descriptor type? r8152_tx_csum() casts the void *d
parameter to 'struct rx_desc *desc' but this function handles TX
descriptors. The sibling TX functions (r8152_tx_vlan_tag, r8152_tx_len)
use 'struct tx_desc *'. The bug is latent because both struct tx_desc
and struct rx_desc have opts1 and opts2 at identical offsets.

>  	u32 opts1, opts2 = 0;
>  	int ret = TX_CSUM_SUCCESS;
>
> @@ -2359,6 +2626,74 @@ static inline void rtl_rx_vlan_tag(struct rx_desc *desc,
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2));
>  }
>
> +static void r8152_rx_vlan_tag(void *d, struct sk_buff *skb)
> +{
> +	struct rx_desc *desc = d;
> +
> +	rtl_rx_vlan_tag(desc, skb);
> +}
> +
> +static u32 r8152_tx_len(void *d)
> +{
> +	struct tx_desc *desc = d;
> +
> +	return le32_to_cpu(desc->opts1) & TX_LEN_MASK;
> +}

[ ... ]

> @@ -2923,13 +3283,14 @@ static netdev_features_t rtl8152_features_check(struct sk_buff *skb,
>  						 netdev_features_t features)
>  {
>  	u32 mss = skb_shinfo(skb)->gso_size;
>  	int max_offset = mss ? GTTCPHO_MAX : TCPHO_MAX;
>
>  	if ((mss || skb->ip_summed == CHECKSUM_PARTIAL) &&
>  	    skb_transport_offset(skb) > max_offset)
>  		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>  	else if ((skb->len + sizeof(struct tx_desc)) > agg_buf_sz)
>  		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>
>  	return features;
>  }

Does this match the RTL8157 limits? rtl8152_features_check() uses
TCPHO_MAX (0x7ff = 2047) for non-GSO checksummed packets on all chip
versions, but the new RTL8157 (RTL_VER_16) hardware has a smaller limit
TCPHO_MAX_2 (0x3ff = 1023) as checked in r8157_tx_csum(). For RTL8157,
packets with transport offsets between 1024 and 2047 will pass
features_check, but r8157_tx_csum will reject them and fall back to
r8152_csum_workaround, producing netif_warn messages.

[ ... ]

> @@ -8252,25 +8711,27 @@ static void r8156b_init(struct r8152 *tp)
>  	u16 data;
>  	u8 speed;
>
> +	tp->coalesce = 15000;	/* 15 us */
> +	data = r8153_phy_status(tp, 0);
> +
>  	if (test_bit(RTL8152_UNPLUG, &tp->flags))
>  		return;
>
> -	tp->coalesce = 15000;	/* 15 us */
>  	r8153b_u1u2en(tp, false);
>
>  	r8156_fc_parameter(tp);
> -	rtl_tally_reset(tp);
>
> +	if (tp->version < RTL_VER_13)
> +		r8156_mdio_force_mode(tp);

[ ... ]

> +	if (tp->version >= RTL_VER_13 && tp->version <= RTL_VER_15)
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);

Are the version guards correct for RTL8156B? When merging r8156b_init into
r8156_init, the condition 'tp->version >= RTL_VER_13 && tp->version <=
RTL_VER_15' excludes RTL_VER_12. Before this patch, RTL_VER_12 was handled
by r8156b_init which executed these code paths unconditionally. The commit
message states VER_12 is RTL8156B hardware.

Three specific behavioral changes for RTL_VER_12: (1) RX_DETECT8 is no
longer set on USB_U2P3_CTRL (shown above), (2) the flow control
initialization block (SLOT_EN clear, FLOW_CTRL_EN set, FC_TIMER, FW_CTRL,
FW_TASK) is skipped later, and (3) the PHY_STAT_EXT_INIT path
ocp_reg_clr_bits(tp, 0xa466, BIT(0)) is skipped because 'tp->version >=
RTL_VER_13' excludes VER_12.

Should these be 'tp->version >= RTL_VER_12' instead to preserve the old
r8156b_init behavior for RTL_VER_12 hardware?

[ ... ]


