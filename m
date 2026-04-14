Return-Path: <netdev+bounces-278445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJPXJWA63mkxpgkAu9opvQ
	(envelope-from <netdev+bounces-278445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:00:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4EC3FA3EC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A6003021E6A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15453E6389;
	Tue, 14 Apr 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNRVvOgn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9743E5591
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171534; cv=none; b=f4PkOA4YNkQu0a9IqU2f5F1qxf2vA1p5zH2VgNAr8gaYoNndzrEF+zn4pWaLZ6dCF7NLG/Gt3V69g+jL8upubFBkqTkfkOyMEc1tIFvQx/hwS2+WlUolPd9ygnCleP4uHQM1GusQ+4e7Pc4Se51Y+3LCmstJyBceeUOccqDpp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171534; c=relaxed/simple;
	bh=8j7SG+h6op+SNbXj618VmTyqqQnfVPQ/1mylqAjMiS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDVMBVaI24C/k//Rx6UfSbZB58/DpeXfY/kf1qQq6Ew9Hrm9zYpPPR6iU/Z8RBMfhi9Qd+svUvtDUTnbD9Ba+vVpd0hhczqcT94WH3xxyVQnIGsW6VFigLR6O+LUsuB6hcWte5vqBq6t4GpqzTWa+FASJEJ6PD+GR/KaOqvcibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNRVvOgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B74BC19425;
	Tue, 14 Apr 2026 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776171534;
	bh=8j7SG+h6op+SNbXj618VmTyqqQnfVPQ/1mylqAjMiS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNRVvOgnmKjyX+zoMNeZ4X94fopZ1JEzh0RVOONchgWVUmnDthLOr+Ns3z9AD1Y76
	 X+k6nm1JU29g4bPfle4V/9nvhaWwuSiXPd46jIIoivUI4S5yXNx8Nr/a5v2tHxVHe7
	 XfAaOHAmHSOd65ZcIOKh8m9OV19da7uEvcRoLH1PvCP2lgzgB+MwPGnzOdJ7iglM3o
	 tjT6TZuMojmH5sW4VnJLo+Lc+Xb9VOaN6V8HF2VUMujpEoNJcBJewHHtdIrCbwpCcT
	 4X+WThGHXOdvbl8MRCGtk68ucZJsmREpgCYN/AnuYMI3AOsiFl17EK05aGdaGtqp2M
	 xR1+/2WE+59CQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 1/8] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Date: Tue, 14 Apr 2026 13:58:37 +0100
Message-ID: <20260414125837.755493-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408131216.2662245-2-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278445-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: EF4EC3FA3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation

The patch lowers IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 to prevent
descriptor ring starvation under sustained full-line-rate bulk RX traffic.
It states that this provides enough headroom to drain the ring before it wraps.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 59a1cee40b436..eedee3b2e72c8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -475,7 +475,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
>  
>  #define IXGBE_ITR_ADAPTIVE_MIN_INC	2
>  #define IXGBE_ITR_ADAPTIVE_MIN_USECS	10
> -#define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
> +#define IXGBE_ITR_ADAPTIVE_MAX_USECS	84

Will the hardware still be configured with a 126 us delay during bulk traffic?

Looking at ixgbe_update_itr(), when traffic is categorized as bulk
(packets >= 256), itr is initialized to IXGBE_ITR_ADAPTIVE_BULK (0).
For a 10Gbps link, avg_wire_size plateaus at 32256:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_update_itr() {
    ...
	} else {
		/* plateau at a limit of 8K ints/sec */
		avg_wire_size = 32256;
	}
    ...
}

The itr is then calculated and updated directly:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_update_itr() {
    ...
	switch (q_vector->adapter->link_speed) {
	case IXGBE_LINK_SPEED_10GB_FULL:
	case IXGBE_LINK_SPEED_100_FULL:
	default:
		itr += DIV_ROUND_UP(avg_wire_size,
				    IXGBE_ITR_ADAPTIVE_MIN_INC * 256) *
		       IXGBE_ITR_ADAPTIVE_MIN_INC;
		break;
    ...
}

With IXGBE_ITR_ADAPTIVE_MIN_INC being 2, the calculation is
DIV_ROUND_UP(32256, 512) * 2, which equals exactly 126.

There is no clamping against IXGBE_ITR_ADAPTIVE_MAX_USECS applied after this
bulk calculation, so ring_container->itr becomes 126.

Later, in ixgbe_set_itr(), the final ITR is determined by taking the minimum
between the rx and tx values:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_set_itr() {
    ...
	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
    ...
}

If the TX ring is idle or operating in latency mode, it will have the
IXGBE_ITR_ADAPTIVE_LATENCY flag (0x80) set.  Even though its base value is
clamped to 84, the latency flag makes it numerically 212.

Does this mean min(126, 212) will return the RX bulk value of 126, leaving
the interrupt delay at 126 us and descriptor ring starvation unresolved?

>  #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
>  #define IXGBE_ITR_ADAPTIVE_BULK		0x00

