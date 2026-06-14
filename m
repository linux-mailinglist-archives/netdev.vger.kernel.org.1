Return-Path: <netdev+bounces-299279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l2tQL3gnL2pc8QQAu9opvQ
	(envelope-from <netdev+bounces-299279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C75682636
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:13:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fr.zoreil.com header.s=v20220413 header.b=h7ZmX83M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299279-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zoreil.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3DDF30011AD
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F62192F9;
	Sun, 14 Jun 2026 22:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90C1EDA0F
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 22:13:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475186; cv=none; b=hMrTFongYabFs1q+dmKeQQtLx7czsEc8gta4Aoj0Yp1OYyW/3ooda/9L5/r9XPAEHPTmnvdxFzQWE5kEO+plwT3Oy7bysLs14WQMtlPWZzXVhI29NiLtx9ZqQjs0IbILu/WWWtYaKbbwmpGwNEQ4o1wduNWy6i4u56TTNFa53B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475186; c=relaxed/simple;
	bh=8FzDVrF4L/YSvNrxznjyJfZUiK58WCC6s70qhXPh0fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdC/uFGyBwZ3px9Ybl6qAlpyd4ZCasq21Gt/tmkh3kBeC9dEMUtzPFM9rxqhuRw3OL3jmYDyxQXbJJDbAWrvzm/kn/k28/ttKJVhPi2TOEDtxptq+fRaT+62M/Kix+/xEHeAQ549zOdBUourwboak2tJTViXykPIqS2mbWVK09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=h7ZmX83M; arc=none smtp.client-ip=92.243.8.30
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 65EM9ZeL3575649;
	Mon, 15 Jun 2026 00:09:35 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 65EM9ZeL3575649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1781474975;
	bh=WMF7Cj2b0Fu2KoPx50WdIel+R6rCbZ7IfudTvzE8Zgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7ZmX83MJfKEm7+q1jcmqpZJ6VYwTsbKd/VwoDHZX0Kxa39aZxCXtfKI5qNj/ivp1
	 jrWjX//1xoTiVqUK5QRigvxENoeCT4nmggTqooDvSJR+BbfCrSZ2Y5he+pekKg/ssn
	 RmozM64PWZ5LkQ3yqOk4H6Pp+1YAK0qdlSoyO26I=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 65EM9YTX3575648;
	Mon, 15 Jun 2026 00:09:34 +0200
Date: Mon, 15 Jun 2026 00:09:34 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: atharva-potdar <atharvapotdar07@gmail.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
Message-ID: <20260614220934.GA3575431@electric-eye.fr.zoreil.com>
References: <20260614054137.32181-1-atharvapotdar07@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614054137.32181-1-atharvapotdar07@gmail.com>
X-Organisation: Land of Sunshine Inc.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zoreil.com,reject];
	R_DKIM_ALLOW(-0.20)[fr.zoreil.com:s=v20220413];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[romieu@fr.zoreil.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fr.zoreil.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romieu@fr.zoreil.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97C75682636

atharva-potdar <atharvapotdar07@gmail.com> :
> Replace the driver-managed skb+copy Rx model with page_pool
> zero-copy in preparation for XDP support.
> 
> Key changes:
> - Allocate order-0 pages via page_pool instead of alloc_pages + dma_map
> - Build skbs directly from pages with napi_build_skb (zero-copy)
> - Add rtl8169_rx_refill() to replenish descriptors after processing
> - Track dirty_rx boundary for efficient refill scheduling
> - Cap max_mtu to R8169_RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN
>   (order-0 pages can't support arbitrary jumbo frames)
> 
> Tested on RTL8168h with iperf3 (~470 Mbps, 0 retransmits) and
> 1000 pings (0 drops).

You may consider fdd7b4c3302c93f6833e338903ea77245eb510b4 and some related
changes around that time.

-- 
Ueimor

