Return-Path: <netdev+bounces-302882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBEsBHgfQ2o6RQoAu9opvQ
	(envelope-from <netdev+bounces-302882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6A6DFA1C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZosgIJpp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302882-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302882-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10244302D94C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF550369D43;
	Tue, 30 Jun 2026 01:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD8248F64
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:44:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783861; cv=none; b=AuMIffGKdKpycINkj6M+dodYQpO4rBuQHzS4dKfAtSgavoJ8Ga71ionNOj5qsNIHNf28J4geQcet9sNfgJZhI+ZGByL9i0Gf0+QhMGpuof6aJLXqiAx03saCmw4UFRGUQ5EtTLvM4jGvGvWMg50+5Xq4IjAcM1DQaI5lE1GJzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783861; c=relaxed/simple;
	bh=Vvt/56gy8G8/h1bEPGg954eTCgoQLln1hfdkZhLsSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhVmUsBhdLxkQZmro9R6juWMUKRdMsyNdMee+Mlt3tDVuNgn1PHsItWobu+IRpZzyupCdPmCINGvSoDevi7dSY3OkVG6n1anBeJ9vJYuMI/rkEbOPHfzQSGUcB3kI5WifbtYs41r5OxlG0gr1+GVQw0SpZuBmiEoUNPRz795/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZosgIJpp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E741F00A3A;
	Tue, 30 Jun 2026 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782783858;
	bh=oZjMZHJiDHz+w25IYGC9p7Z1RAZDQsxO1VxwuLW+Q/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZosgIJppFsBMcY3e+7NAQHjC+byOxDD3kbLJRZmLnPkm25SXNrQW8rtZG83Bcro3B
	 gDNJXe8FHUf0pW4nShsUD+kwiiDK7DyzOKSVJLIoXukHNI3F6sPXH6WB6J07mh8s7v
	 34lCaQH0H3YZ/G/Ds+R3rBotkLgdQbmOn6XEYkP6V5L6sNRINLGD1FdbbZwF0E6hR+
	 9aci6RZLjjHYIrQcCGo0SN7LfpPbdnFiymzOHhLb4RgqVpw9lFF1JSYwlF5R/j2Yvz
	 1j516NDX5enOEW4ZwZ/wmzVa5beP779Pk+jMe02KbRVMKm2aicFEVFoz3QHBmydUvz
	 oSp0icNVAFPcw==
Date: Mon, 29 Jun 2026 18:44:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harsha M <h.mahadeva@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: Re: [PATCH net v1] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Message-ID: <20260629184417.31b21223@kernel.org>
In-Reply-To: <20260626134848.91281-1-h.mahadeva@chelsio.com>
References: <20260626134848.91281-1-h.mahadeva@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:h.mahadeva@chelsio.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DC6A6DFA1C

On Fri, 26 Jun 2026 19:18:22 +0530 Harsha M wrote:
> +		if (be16_to_cpu(match.key->vlan_tpid) == ETH_P_8021AD) {

nit: put the byteswap on the constant to let the compiler do it a build
time

> +			struct adapter *adap = netdev2adap(dev);
> +			u32 ovlan_reg, ctl_reg, val, port_id;
> +
> +			if (!adap) {
> +				netdev_err(dev, "%s: adap not found\n", __func__);
> +				return;
> +			}
> +
> +			val = (be16_to_cpu(match.mask->vlan_tpid) << 16) |

Looks like this is changing a per-port register. Presumably the mask
must be the same for all filters. Why not enforce that mask is ~0 and
program a constant?

> +			      be16_to_cpu(match.key->vlan_tpid);

you compared tpid to ETH_P_8021AD above, why not use the constant?

> +			port_id = netdev2pinfo(dev)->port_id;
> +			fs->val.ovlan = vlan_tci;
> +			fs->mask.ovlan = vlan_tci_mask;
> +			fs->val.ovlan_vld = 1;
> +			fs->mask.ovlan_vld = 1;
> +			ovlan_reg = PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);
> +			ctl_reg = PORT_REG(port_id, MPS_PORT_RX_CTL_A);
> +			t4_write_reg(adap, ovlan_reg, val);
> +			val = t4_read_reg(adap, ctl_reg);
> +			t4_write_reg(adap, ctl_reg, val | 1);
> +			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);
-- 
pw-bot: cr

