Return-Path: <netdev+bounces-167079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEEA38B70
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723DC189059F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A41236428;
	Mon, 17 Feb 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECO4WBLV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864E236421;
	Mon, 17 Feb 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817863; cv=none; b=adu/kg/RJ188GkoN2vJ4jfSEwOIyTU5YI9MfUjZHmH2M7onklB4ml7KCs+vPCiaMKA+PB6Wc59sjfwpS/SiU914g8JifcCMenGe2C4mzsdHJ6DMR3+PyrOjtibEX3l2uk7Lizm/OGeL+A84SiTi43EMAMy7yQAQljACxL0+0Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817863; c=relaxed/simple;
	bh=hvJmtOA0hWqdrwewer4IWWSTXNheMWESg95g21xhQrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UytvLfS292qiDnLix1HchdeNr5JDzZx/P9mKQHtWN1V1OL3Qj29bAmSu0g0gAODuMcdZmhGRum/D2t2gtCw+AWCID9api3PyLM4Jb0X6Mf+8HaU5tqF89h+e96A1i9YvoCtBCmjsIepqqHd7eH9OJ6ZO6QCL4UTQBtvuIEz8RrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECO4WBLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF9C4CED1;
	Mon, 17 Feb 2025 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817863;
	bh=hvJmtOA0hWqdrwewer4IWWSTXNheMWESg95g21xhQrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECO4WBLVH6vcxQaP1em3PQFuRdPLwaJyGRECgte5JxlUQg1SE2w9c4ZETGj9bYn96
	 BTxsCXe7x/dvdDGteIZHJdpiOG7cqvSrAUvROo4x7h//C6W72zLNRrXmpAVGYJSQVd
	 NhuVpbUduXFTY1QwO8PYkH2qLBh+VysqtAdmV5zv09bXnmko1+2PNaJV07deqxLvV2
	 U6vV0ZMgVKT7Hb1K24nZixUabg0/URFZyN+GKFzuHCO7HGHcKYKQhutA6vhjjQzDXj
	 p13Lzp5sAPXkhyZhb5shtiSB5kfHYMB3f6nUIp4nwXYvajhQ4AWQ96vq7kM23OOofk
	 yNsY0nMF/bBSA==
Date: Mon, 17 Feb 2025 18:44:16 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v4 16/16] net: airoha: Introduce PPE debugfs
 support
Message-ID: <20250217184416.GQ1615191@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
 <20250213-airoha-en7581-flowtable-offload-v4-16-b69ca16d74db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-16-b69ca16d74db@kernel.org>

On Thu, Feb 13, 2025 at 04:34:35PM +0100, Lorenzo Bianconi wrote:
> Similar to PPE support for Mediatek devices, introduce PPE debugfs
> in order to dump binded and unbinded flows.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c

...

> +static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
> +				       bool bind)
> +{
> +	static const char *const ppe_type_str[] = {
> +		[PPE_PKT_TYPE_IPV4_HNAPT] = "IPv4 5T",
> +		[PPE_PKT_TYPE_IPV4_ROUTE] = "IPv4 3T",
> +		[PPE_PKT_TYPE_BRIDGE] = "L2B",
> +		[PPE_PKT_TYPE_IPV4_DSLITE] = "DS-LITE",
> +		[PPE_PKT_TYPE_IPV6_ROUTE_3T] = "IPv6 3T",
> +		[PPE_PKT_TYPE_IPV6_ROUTE_5T] = "IPv6 5T",
> +		[PPE_PKT_TYPE_IPV6_6RD] = "6RD",
> +	};
> +	static const char *const ppe_state_str[] = {
> +		[AIROHA_FOE_STATE_INVALID] = "INV",
> +		[AIROHA_FOE_STATE_UNBIND] = "UNB",
> +		[AIROHA_FOE_STATE_BIND] = "BND",
> +		[AIROHA_FOE_STATE_FIN] = "FIN",
> +	};
> +	struct airoha_ppe *ppe = m->private;
> +	int i;
> +
> +	for (i = 0; i < PPE_NUM_ENTRIES; i++) {
> +		const char *state_str, *type_str = "UNKNOWN";
> +		u16 *src_port = NULL, *dest_port = NULL;
> +		struct airoha_foe_mac_info_common *l2;
> +		unsigned char h_source[ETH_ALEN] = {};
> +		unsigned char h_dest[ETH_ALEN];
> +		struct airoha_foe_entry *hwe;
> +		u32 type, state, ib2, data;
> +		void *src_addr, *dest_addr;
> +		bool ipv6 = false;
> +
> +		hwe = airoha_ppe_foe_get_entry(ppe, i);
> +		if (!hwe)
> +			continue;
> +
> +		state = FIELD_GET(AIROHA_FOE_IB1_STATE, hwe->ib1);
> +		if (!state)
> +			continue;
> +
> +		if (bind && state != AIROHA_FOE_STATE_BIND)
> +			continue;
> +
> +		state_str = ppe_state_str[state % ARRAY_SIZE(ppe_state_str)];
> +		type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, hwe->ib1);
> +		if (type < ARRAY_SIZE(ppe_type_str) && ppe_type_str[type])
> +			type_str = ppe_type_str[type];
> +
> +		seq_printf(m, "%05x %s %7s", i, state_str, type_str);
> +
> +		switch (type) {
> +		case PPE_PKT_TYPE_IPV4_HNAPT:
> +		case PPE_PKT_TYPE_IPV4_DSLITE:
> +			src_port = &hwe->ipv4.orig_tuple.src_port;
> +			dest_port = &hwe->ipv4.orig_tuple.dest_port;
> +			fallthrough;
> +		case PPE_PKT_TYPE_IPV4_ROUTE:
> +			src_addr = &hwe->ipv4.orig_tuple.src_ip;
> +			dest_addr = &hwe->ipv4.orig_tuple.dest_ip;
> +			break;
> +		case PPE_PKT_TYPE_IPV6_ROUTE_5T:
> +			src_port = &hwe->ipv6.src_port;
> +			dest_port = &hwe->ipv6.dest_port;
> +			fallthrough;
> +		case PPE_PKT_TYPE_IPV6_ROUTE_3T:
> +		case PPE_PKT_TYPE_IPV6_6RD:
> +			src_addr = &hwe->ipv6.src_ip;
> +			dest_addr = &hwe->ipv6.dest_ip;
> +			ipv6 = true;
> +			break;
> +		}

Hi Lorenzo,

Perhaps it can't happen, but if type is not one of the cases handled
by the switch statement above then src_addr and dest_addr will
be used while uninitialised by the call to airoha_debugfs_ppe_print_tuple()
below.

Flagged by Smatch.

> +
> +		seq_puts(m, " orig=");
> +		airoha_debugfs_ppe_print_tuple(m, src_addr, dest_addr,
> +					       src_port, dest_port, ipv6);
> +
> +		switch (type) {
> +		case PPE_PKT_TYPE_IPV4_HNAPT:
> +		case PPE_PKT_TYPE_IPV4_DSLITE:
> +			src_port = &hwe->ipv4.new_tuple.src_port;
> +			dest_port = &hwe->ipv4.new_tuple.dest_port;
> +			fallthrough;
> +		case PPE_PKT_TYPE_IPV4_ROUTE:
> +			src_addr = &hwe->ipv4.new_tuple.src_ip;
> +			dest_addr = &hwe->ipv4.new_tuple.dest_ip;
> +			seq_puts(m, " new=");
> +			airoha_debugfs_ppe_print_tuple(m, src_addr, dest_addr,
> +						       src_port, dest_port,
> +						       ipv6);
> +			break;
> +		}
> +
> +		if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
> +			data = hwe->ipv6.data;
> +			ib2 = hwe->ipv6.ib2;
> +			l2 = &hwe->ipv6.l2;
> +		} else {
> +			data = hwe->ipv4.data;
> +			ib2 = hwe->ipv4.ib2;
> +			l2 = &hwe->ipv4.l2.common;
> +			*((__be16 *)&h_source[4]) =
> +				cpu_to_be16(hwe->ipv4.l2.src_mac_lo);
> +		}
> +
> +		*((__be32 *)h_dest) = cpu_to_be32(l2->dest_mac_hi);
> +		*((__be16 *)&h_dest[4]) = cpu_to_be16(l2->dest_mac_lo);
> +		*((__be32 *)h_source) = cpu_to_be32(l2->src_mac_hi);
> +
> +		seq_printf(m, " eth=%pM->%pM etype=%04x data=%08x"
> +			      " vlan=%d,%d ib1=%08x ib2=%08x\n",
> +			   h_source, h_dest, l2->etype, data,
> +			   l2->vlan1, l2->vlan2, hwe->ib1, ib2);
> +	}
> +
> +	return 0;
> +}

...

