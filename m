Return-Path: <netdev+bounces-290998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBnnDPoBEWq2gQYAu9opvQ
	(envelope-from <netdev+bounces-290998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2F5BC4E2
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 280F0301A423
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D082367B8;
	Sat, 23 May 2026 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE8XusBq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563441519B4;
	Sat, 23 May 2026 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499508; cv=none; b=hW5nHFQJ1IgVQwUfZt/nDbU4xF0HwVmZ4YDGmZwBn3o1jE/i8lzYHLHLrsk8a3LtfL6ETnl/Hkyt2N1u/ca6enOFMhNh8ObIMagHICZrrA3LFsRebueyPv6bR5T+q0AFafG7HwNj+LkzvfzHLW4+MP3QoVynxe/aA9ohNs3IGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499508; c=relaxed/simple;
	bh=B7IQLDbup+DStCtBuB7NuAYcjvgCDC5FeoogmhU8GIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol9GEcZwMmZ9x5YqQlJXpVMq9lEAuq1WcD83UShkb/5KuvJfd6Ak41GKX3bNdYAkIp5J5T/jpr95/T2YLwozsQJq4bx4GawsMQhED/I4l4WMrJLne8/FPNZ6cbp3KmKEvMxXDZtrmuQN44RMFUIOUgD6Cjwdy7gi1EfM7EfRNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE8XusBq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6091F000E9;
	Sat, 23 May 2026 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499507;
	bh=ad46GsGU0D8pwsNiSgcCsfOxeZc0ksjRFk5Ah2BqwC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SE8XusBqHhnO9fVz8W6Vk1i+R8XeaBK6FNhOnBEyb1O+/8Ts+dJIDzsNucg5GRYhW
	 gVLNCG3FJ+yePpOJJ2NnbGb1TlVo67SJtONdIZUkWd6+n0lk0G5YtBn4fO/ZNNB9SE
	 8kbx4s4l/MmRBcNU2RtzeDDp3YujYCv14AI1lBKE47eMSd3MZmcLVmcZ9nh735BRJU
	 k3x1vpIpH89i6ZJF5vVN22Ma2Bw5qTeuBHZ1UorJeChuF7v/zWcLM4aJd7mF6PCGEA
	 bXb9w3NcTiLNV5Fe+51sE+frLY9qTt2SGdjsqQbLnPu25V16bHd1GC64RoUkTRMHwj
	 JlAj3CglBA43A==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 10/12] net: atlantic: add AQC113 PTP hardware ops in hw_atl2
Date: Fri, 22 May 2026 18:25:02 -0700
Message-ID: <20260523012502.1823591-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520141046.2151-11-sukhdeeps@marvell.com>
References: <20260520141046.2151-11-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290998-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A2B2F5BC4E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 PTP hardware ops in hw_atl2

This commit adds the hardware-layer PTP implementation for AQC113 (Antigua).
It includes TSG clock programming, RX/TX timestamping mechanisms, and PPS
output generation via the TSG pulse generator.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 39d84576ca519..d6a97a1ec5c65 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
[ ... ]
> @@ -888,6 +924,151 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
[ ... ]
> +static u64 hw_atl2_hw_ring_tx_ptp_get_ts(struct aq_ring_s *ring)
> +{
> +	struct hw_atl2_txts_s *txts;
> +	u32 ctrl;
> +
> +	txts = (struct hw_atl2_txts_s *)&ring->dx_ring[ring->sw_head *
> +						HW_ATL2_TXD_SIZE];
> +	/* DD + TS_VALID */
> +	ctrl = READ_ONCE(txts->ctrl);
> +	if ((ctrl & HW_ATL2_TXTS_DD) && (ctrl & HW_ATL2_TXTS_TS_VALID)) {

[Severity: High]
Will this fail to recognize valid TX timestamps on big-endian architectures?

The struct hw_atl2_txts_s is a hardware DMA structure, and the ctrl field
is defined as a native u32. When reading it via READ_ONCE(txts->ctrl) on a
big-endian system, the little-endian word is loaded into the CPU register
natively without byte-swapping, so ctrl & HW_ATL2_TXTS_DD will test the
wrong bit.

Should this field be defined as __le32 and accessed with le32_to_cpu()
instead?

> +		dma_rmb();
> +		return le64_to_cpu(txts->ts);
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int hw_atl2_adj_sys_clock(struct aq_hw_s *self, s64 delta)
> +{
> +	s8 clk_sel = READ_ONCE(self->clk_select);
> +
> +	if (clk_sel < 0)
> +		return -ENODEV;
> +	if (delta >= 0)
> +		hw_atl2_tsg_clock_add(self, clk_sel, (u64)delta);
> +	else
> +		hw_atl2_tsg_clock_sub(self, clk_sel, (u64)(-delta));
> +
> +	return 0;
> +}
> +
> +static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb)
> +{
> +	u32 freq = AQ2_HW_PTP_COUNTER_HZ;
> +	u64 divisor = 0, base_ns;
> +	u32 nsi_frac = 0, nsi;
> +	u32 nsi_rem;
> +	s8 clk_sel;
> +
> +	base_ns = div_u64((u64)((s64)ppb + NSEC_PER_SEC) * NSEC_PER_SEC, freq);
> +	nsi = (u32)div_u64_rem(base_ns, NSEC_PER_SEC, &nsi_rem);
> +	if (nsi_rem != 0) {
> +		divisor = div_u64(mul_u32_u32(NSEC_PER_SEC, NSEC_PER_SEC),
> +				  nsi_rem);
> +		nsi_frac = (u32)div64_u64(AQ_FRAC_PER_NS * NSEC_PER_SEC,
> +					  divisor);
> +	}
> +
> +	clk_sel = READ_ONCE(self->clk_select);
> +	if (clk_sel < 0)
> +		return -ENODEV;
> +	hw_atl2_tsg_clock_increment_set(self, clk_sel, nsi, nsi_frac);

[Severity: High]
Could these two clock adjustment functions race when writing to the hardware
command registers?

The core PTP operations execute adjfine holding
mutex_lock(&aq_nic->fwreq_mutex) and execute adjtime holding
spin_lock_irqsave(&aq_ptp->ptp_lock). Since hw_atl2_adj_sys_clock()
and hw_atl2_adj_clock_freq() are protected by different locks, can
concurrent calls from userspace interleave writes to the same
CLOCK_MODIF_CTRL hardware register and corrupt the PTP hardware clock state?

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> index c84955bc14ae4..ee7f444f6d07d 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
> @@ -8,6 +8,16 @@
>  
>  #include "aq_hw.h"
>  
> +/* Hardware tx launch time descriptor */
> +struct hw_atl2_txts_s {
> +	__le64 ts;
> +	u32 ctrl;

[Severity: High]
Does this ctrl field need to be __le32? Since this is a hardware DMA
structure, declaring it as a native u32 causes endianness issues when read
on big-endian systems, as mentioned in the hw_atl2_hw_ring_tx_ptp_get_ts()
function above.

> +	u32 reserved;
> +};

