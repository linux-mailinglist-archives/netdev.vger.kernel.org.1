Return-Path: <netdev+bounces-286074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHZEL/iR/mnJswAAu9opvQ
	(envelope-from <netdev+bounces-286074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A054FD604
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7465C3024518
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1C281525;
	Sat,  9 May 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYWCwI+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3122F8E8D;
	Sat,  9 May 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291171; cv=none; b=oBpIjtQdhJ9noICaem9s2lKaZS2QUW9YC21VGzmhfqyWJNSaAHIgM2oJo9nlLJ2+LIsGxfGHcSIjo1ACutRVlpETsj+rpsH6zlHONM6gzAUxVfB2DIdqvbNtq7N4T9X5DJerUb7nhaiYyfZFv4nc5whFIpLMf0H0aBdEwtwkzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291171; c=relaxed/simple;
	bh=BdduitEx/Iq5i1rUs4QAgBh5C/BbY9EApB51NEx/vLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmMMQDQCOPQNoaoAEDZV436uOBwxA/RFCaj3M5OFkavNqjLZWY0C7T13NwJ9uwS/oNir+GY9yth3C3DLuV79ws+pSe/I57nnKqWv1YdFNGy6ZoFdBy1pMqmMFdkUQ1ha4UfhgZpk7b8SmQxL08hKXi3SH4BxSIbfUk8PdM2tgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYWCwI+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69CDC2BCB4;
	Sat,  9 May 2026 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291171;
	bh=BdduitEx/Iq5i1rUs4QAgBh5C/BbY9EApB51NEx/vLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYWCwI+94h+mct2TLbTJjnQFISjyiYFHyrKUtGozTDIzANAOJMaOtPVVkreUKD+K9
	 8WNvMkHjLFyzYUEOC+LVPB9t5tj4hFQKh62vtCnS2z1yiPppl1K/C0jSziA0TkepPx
	 lQgabOvDArnfoCig7Q1reL94Bh+L7djvwE43z6wULkjZr4UR7lF1n952ujk6sPA+Kv
	 VlGwGNnGj/isiYeMo8U/LFFDPgdou8TAMc5UDaGfnUcldMWe3PBPScuapPQAgbKOpw
	 MF1BFrrIZP0qfDeVmsNDUCoXEa+c8+uKJfc9V3OmSdE6LiC3CDu6MTl8otGFIsxEGf
	 xzlGLy1Uo0zTg==
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
	devicetree@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 05/10] net: airoha: Move qos_sq_bmap in airoha_qdma struct
Date: Fri,  8 May 2026 18:46:09 -0700
Message-ID: <20260509014609.3558041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-5-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47A054FD604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-286074-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net: airoha: Move qos_sq_bmap in airoha_qdma struct

The change moves the HTB-offload channel-allocation bitmap from the
per-netdev airoha_gdm_port to the per-QDMA airoha_qdma, so sibling
netdevs attached to different QDMA blocks no longer clobber each other's
bitmap.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 080705e2f58d..69a4c2e0d58b 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2600,7 +2600,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
>  	int err, num_tx_queues = netdev->real_num_tx_queues;
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> -	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_qdma *qdma = dev->qdma;
>  
>  	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
> @@ -2627,7 +2627,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
>  		return err;
>  	}
>  
> -	set_bit(channel, port->qos_sq_bmap);
> +	set_bit(channel, qdma->qos_sq_bmap);
>  	opt->qid = AIROHA_NUM_TX_RING + channel;
>  
>  	return 0;

[High]
Now that qos_sq_bmap is per-QDMA, can two sibling netdevs that share the
same QDMA block collide on allocation?  On EN7581, GDM2/GDM3/GDM4 all
select the same qdma pointer via:

    drivers/net/ethernet/airoha/airoha_eth.c:
        /* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
        dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];

and airoha_is_lan_gdm_dev() returns true only for port->id == 1, so
every non-LAN GDM netdev resolves to eth->qdma[1] and shares
qdma->qos_sq_bmap.

The allocation path does not test the bit before setting it:

    channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
    ...
    set_bit(channel, qdma->qos_sq_bmap);
    opt->qid = AIROHA_NUM_TX_RING + channel;

If two sibling netdevs on the same QDMA pick classids whose TC_H_MIN
maps to the same channel, both airoha_qdma_set_tx_rate_limit() calls
program the same HW TRTCM egress slot, the later caller silently
overwrites the earlier configuration, and both netdevs receive the same
opt->qid.  Should this path use test_and_set_bit() (or similar owner
tracking) to reject a channel already owned by a sibling netdev?

> @@ -2811,11 +2811,11 @@ static int airoha_dev_setup_tc_block(struct net_device *dev,
>  static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> -	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_qdma *qdma = dev->qdma;
>  
>  	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
>  	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
> -	clear_bit(queue, port->qos_sq_bmap);
> +	clear_bit(queue, qdma->qos_sq_bmap);
>  }

[High]
airoha_tc_remove_htb_queue() operates unconditionally on the caller's
netdev but clears a bit that may be owned by a sibling netdev on the
same QDMA.  The effects that follow look like cross-netdev interference:

  - netif_set_real_num_tx_queues(netdev, real_num_tx_queues - 1)
    decrements the caller's tx-queue count for a queue it never
    allocated, and its return value is discarded (eventually the txq<1
    EINVAL guard in netif_set_real_num_tx_queues() will trip silently).

  - airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0) zeros the
    egress TRTCM rate-limit registers for a channel that the sibling
    netdev still considers active.

  - clear_bit(queue, qdma->qos_sq_bmap) then hides the channel from the
    legitimate owner's later test_bit() checks.

> @@ -2838,10 +2838,10 @@ static int airoha_tc_htb_delete_leaf_queue(struct net_device *netdev,
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> -	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_qdma *qdma = dev->qdma;
>  	int q;
>  
> -	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
> +	for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
>  
>  	return 0;
>  }

[High]
Does airoha_tc_htb_destroy() now walk bits owned by sibling netdevs?
The iteration no longer filters by owning netdev:

    for_each_set_bit(q, qdma->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
        airoha_tc_remove_htb_queue(netdev, q);

Previously each netdev had a private bitmap, so destroy could only
touch its own channels.  After this change, tearing down HTB on one
GDM netdev appears to remove channels and clear rate-limit HW state
belonging to every sibling GDM netdev on the same QDMA.  A subsequent
tc-htb delete or get on the legitimate owner then hits:

    if (!test_bit(channel, qdma->qos_sq_bmap)) {
        NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
        return -EINVAL;
    }

Should the bitmap track the owning netdev alongside the bit (for
example a per-channel owner pointer, or a per-netdev sub-bitmap inside
airoha_qdma), so that destroy/delete can only touch channels owned by
the caller?

> @@ -2852,9 +2852,9 @@ static int airoha_tc_get_htb_get_leaf_queue(struct net_device *netdev,
>  {
>  	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> -	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_qdma *qdma = dev->qdma;
>  
> -	if (!test_bit(channel, port->qos_sq_bmap)) {
> +	if (!test_bit(channel, qdma->qos_sq_bmap)) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
>  		return -EINVAL;
>  	}

