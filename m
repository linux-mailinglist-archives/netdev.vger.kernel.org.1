Return-Path: <netdev+bounces-284632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNcTNgSQ+mk4PwMAu9opvQ
	(envelope-from <netdev+bounces-284632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE564D5036
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE3D5303D359
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D242153D8;
	Wed,  6 May 2026 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYgb3l+Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885E19F40B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028545; cv=none; b=iVqH4wJD/GqEXvI/XvKfrDN3b8dL2E5ACyBd0ydPRcgcvpTDNM1vY4nDiE9pkJtoi+5qJHZvCblhZ2gtjT4qHWw/FbsdjVM0VSstnzt9ByXnn/gEVHjw99yOOTD4KdSe5KzclSg5OKrnjndVky3G/rRGOBgcsmeq/zzewa2MpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028545; c=relaxed/simple;
	bh=ca62F4uGkdzsX/Jw5lr5LSYquoMOT+qVDd37fpoT8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5StKvzKqTwEiwyXibeC483mUtyfwuebS+TX92f09zmJQMuT/1MIukrF2Caq8Al8QE7aT6B9jcySJjYCwWoyZgXki9mUegEpk4bLx1tcJlDHfFpwcgRAYdFTh2/IstIQ3l97YXuUWqygD1tWfVptqawKsSTl3fy9PK8TW8Lsnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYgb3l+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B56EC2BCB4;
	Wed,  6 May 2026 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778028545;
	bh=ca62F4uGkdzsX/Jw5lr5LSYquoMOT+qVDd37fpoT8q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYgb3l+YflHvn4hZqYa8w8hTS0dTMcOnqbMxe7S/EWLjDKakRONrLniqglC65cdV0
	 hKUKxPGYPcAjTtdXYMxLGzZiV96R1SzP7tdnRQrWadDCEBG2BxKQ+yxJ6IY147Bb7j
	 khf6qfVZZfQ1DN045FVjfCaMDaa73UgIZGTBuSFegndjqmVuRhV+AElkM4UM+51aAl
	 ARqKNZXd8wShhwhV852CcgvDK/zqNVrSNdl6QVc86+pacOChh2u1oQJsuRh9GHjMWr
	 +GjN3v5A2AeE2Dr41zqRtxUmgJMW0DJzQ3guF+ehTTmThhzhCqo14WRrbT5+FqF0KO
	 oZEWUF9aw0NCQ==
Date: Tue, 5 May 2026 17:49:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/15] udp_tunnel: Speed up UDP tunnel
 device destruction (Part I)
Message-ID: <20260505174904.52b20741@kernel.org>
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
References: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4EE564D5036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Sat,  2 May 2026 03:12:53 +0000 Kuniyuki Iwashima wrote:
> Kuniyuki Iwashima (15):
>   udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
>   udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
>   udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
>   udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
>   udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port().
>   vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
>   vxlan: Store struct sock in struct vxlan_sock.
>   vxlan: Free vxlan_sock with kfree_rcu().
>   geneve: Store struct sock in struct geneve_sock.
>   bareudp: Store struct sock in struct bareudp_dev.
>   fou: Store struct sock in struct fou.
>   amt: Store struct sock in struct amt_dev.
>   pfcp: Store struct sock in struct pfcp_dev.
>   tipc: Store struct sock in struct udp_bearer.
>   udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().

Excellent job splitting this into patches, pleasure to read!

