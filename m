Return-Path: <netdev+bounces-273543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MAkOfCYy2mYJQYAu9opvQ
	(envelope-from <netdev+bounces-273543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780F3675CB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C3430056CE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8023EDAD3;
	Tue, 31 Mar 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghXP4G0t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeXrsgPH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AC3EE1D1
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950524; cv=none; b=Y5QHx7ZSd0EC4JQXtkVw8JniX2h3esbURJOr0NTE2yH2alHJZa0t6CGtDgMrEK8dMFloZG9C6OJSuMRwtdZ9svNdWv5r9YKC4np8euUwBFalfSjA6v9SVJL2CjKqZSpfRyLW8We1eLdVqv9HQfSivZpNoKBMQ5YDGiJWqVpJYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950524; c=relaxed/simple;
	bh=OmkQL2rZPo+S3r7wx36gg8PGLqL+K5Qrozwe0KStT10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKu+CH6MTXB1SoivBmNbHrgWg2D3Phbtz/pVzcb+zLzoN+DY/7BK/P20/BGQZ3qUEPAby++NTPc2+5icReGScDpW6N38r5XwC477Kyr1gTcnE9cdqr6RRHuNm35ljU2CZh/deooy92yJh808yhtpKgO0V3sAb7uNXZMgyY8Wxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghXP4G0t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeXrsgPH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774950520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAWTeG+TgfKTJsRPkbNlI/x8xqrSYMpp7Kw/l/cmWps=;
	b=ghXP4G0tyHs9OlyPaxvcytGDOsRaf1Ejsai/ZylnXqCrhI46ZKDXpPgBP8lZJOyK0vPLh4
	o9k/8XZvI1KhvghvqxCa7NLCcKDcV3AFWDBwogkB6E+dPG++HsF8uO6IP+dsr2O/ihDuwP
	gMjQcgLqoFH8wKPJafITuLtM3F/yc78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-dDIbxdk-N6miyhLOaqkiZg-1; Tue, 31 Mar 2026 05:48:34 -0400
X-MC-Unique: dDIbxdk-N6miyhLOaqkiZg-1
X-Mimecast-MFC-AGG-ID: dDIbxdk-N6miyhLOaqkiZg_1774950513
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b8f9374dfso3960942f8f.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774950513; x=1775555313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAWTeG+TgfKTJsRPkbNlI/x8xqrSYMpp7Kw/l/cmWps=;
        b=UeXrsgPHuiN4fXBscym+goukdHPPb8sAxrAE6ZCXo5k0pX8xERuBfv3yEUOaL32GPf
         v8TtnMXVek/tHFP7klqR5XZgHSUxJxpPEgAhvbjuVllC3pUkEYGC171GZe6/UJf4m9E0
         mCPMO7JKjNQz7vnOi9N4EX2Lqwa98I1+GCm7WWOXZAPXcWup/h9kFlZ+6frvTXubLioR
         lHVI2WbQ3rQ6SHX3NwodjcmGD61EIVShNlE19+BW5BXW0l5yK9qYuY46bqlsPDJnQsWe
         rkKkoZh+b8uvmmXtVRnaiTqdIh/VGVZqfyCsO0M45T86eGkJU6nAtkTkdfpaZszzxSba
         1QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950513; x=1775555313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAWTeG+TgfKTJsRPkbNlI/x8xqrSYMpp7Kw/l/cmWps=;
        b=ZoH/vyIdN9TCwDWxd2Zkrt84Yw2hQGggvyUaq6Ffxr2xkR80kQxhTXsVh4E5gQa99W
         1OHgWoWYHAaSKiHH7eZKsoIxJgZXbF2fWpTVYT2E4PN5k4QFLYXpxRZ+ByZNS5leo18J
         VeFmGiMhf+Y5AsGqvEHnO6PIYLIfyD6OnmZD+5lm0sw0LHO8Sb3JF0Jf7kV3snoBPlsY
         yxCWDR/K/hWtR/iSxFvot5Qyp61pLCty52rq7x0049owF+dlD8kcyHDhigwqs0vJrfxW
         n313OGG1X5XigMRW3TUfy/p5jW5lIUI1DQwHSCr+xpE0xLLf6cjEie47FdfpbrlEXJgL
         Brtw==
X-Forwarded-Encrypted: i=1; AJvYcCXi7HJU5S9c7/T9cCkygEeA9j2s+OncEwgGpWNe76W8deY+TkEBIVekTrn03AXu5a1H2JaBGzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEAQyJe4t7rXLnXhaunw4ybVXN5VBLHA2yPj1vI3fTiNrvSWf
	BI4126krI8WH4IbrBXhGcJx11daEX0NTLVHFJfIO7rkU0HmR6crgByL5/3rT+Bdq7dVsrgl8K7D
	jqvnNvgjeeQDmhOrHKLdRdZfVBhiELe4okArqb/sy3Xt44Hy6oBrBWg0CZA==
X-Gm-Gg: ATEYQzwWt6H5Z7Pd1WSxFjxSG5421tnyi0gSH8JuTfrSwnvlzESwh0cwMOaw5BFkM2G
	Iagj5JTcgCskdlQvFukt0Z9yHZ18wxcHZok2b8T7q1ijNRxLkljSf3qDJCtdleX9kAc9ViyzSG+
	9lGiRT+jmYc5FZJchM/XMvzC2MIoS8GmnHrkb8Gsf/wLSSEwoxkNqmvcDj5NPeGRFaaaRbXO4fI
	zqk0jnUk36V8p79irAtoQAuGFALsiR++honrRHoQyoyfCBn1wUeW7odo3QR38+j57ZDY/sXP7dc
	U3bS3H93RRdIc+bhWaio5QUIcSaF3HQ3IXGAWGhapUhK84vKnsiXR1om10Vi97IzZ5Iwi4FX0fm
	hadxB9aAt/lHtbIL6D4LzUqcbZl3py6kCt/XpM5Ue1sCZ0f2aX//nbJEw
X-Received: by 2002:a05:600c:4ecc:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4887839a81dmr45299555e9.11.1774950513323;
        Tue, 31 Mar 2026 02:48:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4887839a81dmr45299015e9.11.1774950512742;
        Tue, 31 Mar 2026 02:48:32 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c536a7fsm25303355e9.1.2026.03.31.02.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:48:31 -0700 (PDT)
Message-ID: <3f30c7ba-8053-4443-9fb0-ba628657b385@redhat.com>
Date: Tue, 31 Mar 2026 11:48:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/4] net: dsa: mxl862xx: implement bridge
 offloading
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Yang <mmyangfl@gmail.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
 Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu
 <lxu@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1774572749.git.daniel@makrotopia.org>
 <201af75c81ca093c46ab5c28a9379eeb6e9fa432.1774572749.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <201af75c81ca093c46ab5c28a9379eeb6e9fa432.1774572749.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-273543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4780F3675CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 2:01 AM, Daniel Golle wrote:
> +static int mxl862xx_set_bridge_port(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_port *p = &priv->ports[port];
> +	u16 bridge_id = dp->bridge ?
> +		priv->bridges[dp->bridge->num] : p->fid;
> +	bool enable;
> +	int i, idx;
> +
> +	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> +	br_port_cfg.bridge_id = cpu_to_le16(bridge_id);
> +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_EGRESS_SUB_METER);

AI reviews say:

Does this silently switch the hardware from Independent VLAN Learning
(IVL) to Shared VLAN Learning (SVL)? The mask no longer includes
MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING, and the
vlan_src_mac_vid_enable and vlan_dst_mac_vid_enable fields are not set.
For a VLAN-aware bridge, this appears to break VLAN isolation
boundaries, as a MAC address learned on one VLAN could affect forwarding
decisions on other VLANs.

[ ... ]
> +static int mxl862xx_add_single_port_bridge(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret;
> +
> +	ret = mxl862xx_allocate_bridge(priv, &priv->ports[port].fid);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> +		return ret;
> +	}
> +
> +	priv->ports[port].learning = false;
> +	bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> +	__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> +
> +	ret = mxl862xx_set_bridge_port(ds, port);
> +	if (ret)
> +		return ret;

AI review says:

If mxl862xx_set_bridge_port() fails, does this leak the newly allocated
hardware bridge? It looks like there is no call to mxl862xx_free_bridge()
on this error path.

[...]
> +static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
> +				     const struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
>  {
> -	struct mxl862xx_bridge_port_config br_port_cfg = {};
> -	struct dsa_port *dp = dsa_to_port(ds, port);
> -	struct mxl862xx_bridge_alloc br_alloc = {};
> +	struct mxl862xx_priv *priv = ds->priv;
> +	u16 fw_id;
>  	int ret;
>  
> -	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
> -	if (ret) {
> -		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> -		return ret;
> +	if (!priv->bridges[bridge.num]) {
> +		ret = mxl862xx_allocate_bridge(priv, &fw_id);
> +		if (ret)
> +			return ret;
> +
> +		priv->bridges[bridge.num] = fw_id;
> +
> +		/* Free bridge here on error, DSA rollback won't. */
> +		ret = mxl862xx_sync_bridge_members(ds, &bridge);
> +		if (ret) {
> +			mxl862xx_free_bridge(ds, &bridge);
> +			return ret;

AI review says:

If mxl862xx_sync_bridge_members() encounters an error partway through
updating the ports in its loop, are the already-updated ports left pointing
to a bridge ID that is then freed here?
It seems the software portmaps and hardware states of the preceding ports
are not rolled back, which might leave them corrupted and permanently
referencing a freed bridge.



> +		}
> +
> +		return 0;
>  	}
>  
> -	br_port_cfg.bridge_id = br_alloc.bridge_id;
> -	br_port_cfg.bridge_port_id = cpu_to_le16(port);
> -	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> -				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> -				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> -				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> -	br_port_cfg.src_mac_learning_disable = true;
> -	br_port_cfg.vlan_src_mac_vid_enable = false;
> -	br_port_cfg.vlan_dst_mac_vid_enable = false;
> -	/* As this function is only called for user ports it is safe to rely on
> -	 * cpu_dp being valid
> -	 */
> -	br_port_cfg.bridge_port_map[0] = cpu_to_le16(BIT(dp->cpu_dp->index));
> +	return mxl862xx_sync_bridge_members(ds, &bridge);
> +}
> +
> +static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
> +				       const struct dsa_bridge bridge)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_port *p = &priv->ports[port];
> +	int err;
> +
> +	err = mxl862xx_sync_bridge_members(ds, &bridge);
> +	if (err)
> +		dev_err(ds->dev,
> +			"failed to sync bridge members after port %d left: %pe\n",
> +			port, ERR_PTR(err));

AI review says:

Is the leaving port still present in dp->bridge when this function is
called?
The DSA core typically clears dp->bridge after the leave callback returns.
If so, mxl862xx_sync_bridge_members() would still iterate over the
leaving port and incorrectly add it to the hardware portmaps of all
remaining bridge members.

>  
> -	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> +	/* Revert leaving port, omitted by the sync above, to its
> +	 * single-port bridge
> +	 */
> +	bitmap_zero(p->portmap, MXL862XX_MAX_BRIDGE_PORTS);
> +	__set_bit(dp->cpu_dp->index, p->portmap);
> +	p->flood_block = 0;
> +	err = mxl862xx_set_bridge_port(ds, port);

AI review says:

Could there be two issues during this revert?
First, if dp->bridge is still set as noted above, mxl862xx_set_bridge_port()
will evaluate dp->bridge to true and use the shared bridge's hardware FID
instead of the port's standalone FID, keeping the port assigned to the
shared bridge.
Second, if learning was enabled while the port was in the bridge,
p->learning
remains true here. Should p->learning be set to false when the port reverts
to a standalone port to prevent inappropriate MAC learning?



