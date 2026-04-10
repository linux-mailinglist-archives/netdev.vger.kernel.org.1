Return-Path: <netdev+bounces-277214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjRGBln2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68D3D19B9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 172DC301093E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9614302165;
	Fri, 10 Apr 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unC8irle"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F820B22;
	Fri, 10 Apr 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789842; cv=none; b=ScdDEMufcj+nSD/tYVJRjpZMJnCZz2UEa3RHwb2YlUM179RAOz++FKSZd+CDbNMFqZEevBifn1uAaXf5ajTFgkQ3zv0xOVxDqZecybFUzba7Q8yGhQvS6E73zdpnwUFs2cSE7iI6sOVYxebeJb5+Qt9vuoG2RjnAXUpPwdYT62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789842; c=relaxed/simple;
	bh=L6wszwS8qFkzeqIRGzk3Bj9pcAOHKFzChEeUvPEdrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnwPpP25wzHN4bKH+n0f+/1QbfTxT71mMlkXHNetlV5sz9gBdlooOYo3YG9cVfIVx95ODtt4YxrH/cR0jTQFG7mj6L0a0cVFb2p/6tj6yRDnUVzxwIH9q0/gLj3tHyPubPk+Fm+S2hTrTwLqX65GGeNfutQJKyf68dmPQQ13td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unC8irle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D1C4CEF7;
	Fri, 10 Apr 2026 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789842;
	bh=L6wszwS8qFkzeqIRGzk3Bj9pcAOHKFzChEeUvPEdrVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unC8irle7Z3WU/wQW+tQG3kvvhONwihsBJSpZ61ZtOgJMg9y5hpsgn9k+vJYEcT+c
	 HYnfv4g5AcYBdjEkZdN/iLtFLVzOfn3zTaOYEjxRj1RKujkw18nUmpDqnYRS+C4msc
	 cuh9JKjZta34u229RaBwakIw166xI1ktxuAkvyLaSNYGIfYh9yFd4oe5pKhUm5eyqI
	 Byl9p1++5upj/hfB36VMkud/RZJ0jr9TG70WXdJi6q9pIyE/4v0SKCnmWr8e08WRjv
	 LWTkLaANz/OuTlTanVHD2TpMaUj3nL5RqWBeGHwF4cv6faXsaVtlN155Li1VR129D2
	 2CbU6tOPE5cuA==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] net: airoha: Set PPE cpu port for GDM2 if loopback is enabled
Date: Thu,  9 Apr 2026 19:57:20 -0700
Message-ID: <20260410025720.1809934-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-277214-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E68D3D19B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct

This commit moves the airoha_qdma pointer from the airoha_gdm_port struct
to the airoha_gdm_dev struct. This ensures the QDMA block used depends on
the specific net_device WAN/LAN configuration.

[ ... ]

> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -1497,9 +1498,10 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
>  	}
>  }
>  
> -static void airoha_update_hw_stats(struct airoha_gdm_port *port)
> +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
>  {
> -	struct airoha_eth *eth = port->qdma->eth;
> +	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_eth *eth = dev->eth;
>  	u32 val, i = 0;
>  
>  	spin_lock(&port->stats.lock);

This isn't a bug introduced by this patch, but does this spin_lock()
carry a deadlock risk?

Because ndo_get_stats64() can be called from atomic context (e.g., from a
softirq), if a process context caller holds port->stats.lock and is
interrupted by a softirq on the same CPU that also triggers dev_get_stats(),
the softirq could spin forever waiting for the lock.

Should this be upgraded to spin_lock_bh() to ensure local softirqs are
disabled during the critical section?

[ ... ]

> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -534,12 +534,12 @@ struct airoha_qdma {
>  
>  struct airoha_gdm_dev {
>  	struct airoha_gdm_port *port;
> +	struct airoha_qdma *qdma;
>  	struct net_device *dev;
>  	struct airoha_eth *eth;
>  };
>  
>  struct airoha_gdm_port {
> -	struct airoha_qdma *qdma;
>  	struct airoha_gdm_dev *dev;
>  	int id;

This isn't a bug introduced by this patch, but since the qdma pointer
is being moved to better align with the hardware structure, should 
qos_sq_bmap, cpu_tx_packets, and fwd_tx_packets be moved to 
struct airoha_qdma as well?

Because QDMA1 is shared by all WAN ports (GDM 2, 3, 4) and qos_sq_bmap
is currently tracked per-port instead of per-QDMA, each WAN port 
independently allocates QDMA1 channels starting from index 0. Does this 
cause different ports to overwrite each other's hardware QoS configurations 
in the shared QDMA1 block?

Furthermore, cpu_tx_packets and fwd_tx_packets cache per-channel ETS
hardware counters but are single u64 scalar variables in the port structure.
When querying stats for multiple channels, do these scalar caches get
overwritten with values from completely different channels, resulting in
incorrect delta calculations?

