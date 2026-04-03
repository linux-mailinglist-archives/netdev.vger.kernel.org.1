Return-Path: <netdev+bounces-275233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kx/lGRg20GlZ4wYAu9opvQ
	(envelope-from <netdev+bounces-275233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8248398906
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40229301184C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133EF2F6910;
	Fri,  3 Apr 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTJv2a//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E92D3ED1
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253013; cv=none; b=W62cp86mjs37PyPERrIuRDhJH3fKp9GOlOt6/ry9PUv3D+ctT4cJNHtkJXR/rZJaM1/5hQchsymAv+yt8xUCsn64M/yIfjtQvW+3G4+R2VKgfQw+TzmeYc0Ura+roIh0rKuEbxD0Ss87EsozGPyEV8EkTGJ/plLhlullRpsEZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253013; c=relaxed/simple;
	bh=Zkb8BAM9EJJVD7jpMzXADHmaaO/bpLCU6y+vWNwWOYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWsR5Tv7eT5hd8P7bQ51e2k3cusw4ZN8FLApWcSKlJVRUmJUluS7rsWOqotgouGXoWmE2BKEbNVDW7O58ZJscrUH87+Ht7s2KXpJ8gqy3go3rwouy5MF671lsrEl3Y0lC+pnkQUYugkq5HBr69BD+Zq/mfPR6lw3AHM9SK0mA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTJv2a//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C076AC4CEF7;
	Fri,  3 Apr 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253012;
	bh=Zkb8BAM9EJJVD7jpMzXADHmaaO/bpLCU6y+vWNwWOYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTJv2a//7RTD3wyWXJdb87NsPq6q1SMHDsBzK2PcKsJOEj2PVf9HNE3xmS/WCEQJN
	 d4uSEX+EG2l2McmPVmf1O5ICTENF7i7R3sxGs4Fy1EtDXRL++tFwnMpMalAH26m26Q
	 myJ0WuB1Vo7MhD2GS4wrpI42uNVI6dMMJpO+TYWfoqg5Sw+hb05nGJOHQuwe0pZ3gW
	 GEYeJFMtHdBUAHHMt7le7UrQJdIgoeEvIf9DlOqQD5CA8vqfsBHWMgeWFN2XrVoh68
	 TkcjlewaZ7hcYxXDem5R5HG3r1OtOzjNOVqN3qvf5L48VGrguilIlQLRrtp4YWIHFL
	 W7cgWjsYBz1vQ==
Date: Fri, 3 Apr 2026 14:50:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 yimingqian591@gmail.com, justin.iurman@gmail.com
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in
 __ioam6_fill_trace_data()
Message-ID: <20260403145010.4b4e5865@kernel.org>
In-Reply-To: <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
References: <20260402101732.1188059-1-edumazet@google.com>
	<20260403214418.2233266-2-kuba@kernel.org>
	<CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8248398906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026 14:47:32 -0700 Eric Dumazet wrote:
> > If the ingress device has more RX queues than the egress device (dev) has
> > TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
> >
> > Since skb_get_tx_queue() does not clamp the index, will it return an
> > out-of-bounds pointer into the egress device's dev->_tx array, causing
> > dereferencing queue->qdisc to read invalid memory?  
> 
> This seems a different bug ?
> 
> I mean, do we need to fix all bug in a single patch ?

no no, sorry, i'm just sending this out for Justin or you as a separate
thing.

