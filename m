Return-Path: <netdev+bounces-263006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H70CABPpmlCNwAAu9opvQ
	(envelope-from <netdev+bounces-263006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:01:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438B1E8486
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 471EC3019E28
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1137CD3E;
	Tue,  3 Mar 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anrf9pou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140237CD3A;
	Tue,  3 Mar 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506839; cv=none; b=cBcTVFLZwYUz6NEh8Kp8FeIDeOTHgRxU77sdAC4ngcT5ppwC+3MtK3h5U5YV8p1BEMu4mfV4wAAfY75iAhqgIXPb5vU8D0A6bPtTmR0Ea+V7qJ+132Hdcs/5ZcdLslibbuOlU02ym8GwevP3UBB92M796o+p+SxLucc8ztQs3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506839; c=relaxed/simple;
	bh=KtwscISRwX3TlOXBXsLd9wej2wApWInTjxxy2nB7cb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjLZWtjBrZcNGiH69MuB5pgojCKdEfmRYdc4vfxJ8duCbJRzbVmcrxiR0evInr5dt9xociq0lOfo9OwVFxMj2RbUwit3y/TcOyzD5dDl9jPZITA5EXYcjnyU8e61Cg6dAMGNPvLCrummKapdJrTBARJRaZwluMldY4sB6ekvr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anrf9pou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4088DC2BCAF;
	Tue,  3 Mar 2026 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772506838;
	bh=KtwscISRwX3TlOXBXsLd9wej2wApWInTjxxy2nB7cb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Anrf9pouYXwbdsYpHMMdAyZaMsAH4JY/Gi5DvmkXko4k7ywu9J5//xUwCvp+xU4js
	 TAdMtAtm4gylRukw05cUPpNbZ9g+HApxhQRrosm4GXiLCh3MMOPSklxSp1YZarLBjo
	 NZuIUGxtGMjsJuCywBD5qzuNCvOBqr9oK1KPXnBLjPORqBmPrv+cJq9wxFSZSpRFIp
	 QpvxbJKsq/0gHM0gJA931uRMrHNyR/Jkwxk0nmI+aezbqLeF52440Lyyws6yffVMbL
	 HN1axW8x1deAmh37wmtwW2hamGBVHlYmW5Rd2hQNxFI3GhRWSzMGXuo39IJvKPApb2
	 ed/1iVHvl5oqQ==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	rajashekar.hudumula@broadcom.com,
	vikas.gupta@broadcom.com,
	pavan.chebbi@broadcom.com,
	rahul-rg.gupta@broadcom.com
Subject: Re: [net-next,v3,6/8] bng_en: add initial support for ethtool stats display
Date: Mon,  2 Mar 2026 19:00:36 -0800
Message-ID: <20260303030036.1885679-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228072715.1632280-7-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-7-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3438B1E8486
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-263006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: add initial support for ethtool stats display

This commit implements ethtool -S callbacks for per-ring RX/TX, TPA,
and port-level MAC/extended statistics, including string names, counts,
and DMA-backed memory allocation for port stats via HWRM wrappers.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> @@ -31,6 +31,331 @@ static int bnge_nway_reset(struct net_device *dev)
>  	return rc;
>  }
>
> +static const char * const bnge_ring_rx_stats_str[] = {
> +	"rx_ucast_packets",
> +	"rx_mcast_packets",
> +	"rx_bcast_packets",
> +	"rx_discards",
> +	"rx_errors",
> +	"rx_ucast_bytes",
> +	"rx_mcast_bytes",
> +	"rx_bcast_bytes",
> +};
> +
> +static const char * const bnge_ring_tx_stats_str[] = {
> +	"tx_ucast_packets",
> +	"tx_mcast_packets",
> +	"tx_bcast_packets",
> +	"tx_errors",
> +	"tx_discards",

Jakub Kicinski raised this concern during v3 review: standard stats like
rx_errors and tx_errors should not be duplicated in ethtool -S output.
While this patch adds structured callbacks (.get_eth_mac_stats,
.get_rmon_stats, etc.) for standard stats, rx_errors and tx_errors still
appear in the bnge_ring_rx_stats_str[] and bnge_ring_tx_stats_str[]
arrays above.

These arrays are used by bnge_get_strings() which feeds ethtool -S,
meaning the standard stats will still appear in ethtool -S output.

Should rx_errors and tx_errors be removed from these arrays to comply
with the kernel policy against duplicating standard stats?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c

[ ... ]

> +int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags)
> +{
> +	struct hwrm_queue_pri2cos_qcfg_output *resp_qc;
> +	struct bnge_net *bn = netdev_priv(bd->netdev);
> +	struct hwrm_queue_pri2cos_qcfg_input *req_qc;
> +	struct hwrm_port_qstats_ext_output *resp_qs;
> +	struct hwrm_port_qstats_ext_input *req_qs;
> +	struct bnge_pf_info *pf = &bd->pf;
> +	u32 tx_stat_size;
> +	int rc;
> +
> +	if (!(bn->flags & BNGE_FLAG_PORT_STATS_EXT))
> +		return 0;
> +
> +	if (flags && !(bd->fw_cap & BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED))
> +		return -EOPNOTSUPP;
> +
> +	rc = bnge_hwrm_req_init(bd, req_qs, HWRM_PORT_QSTATS_EXT);
> +	if (rc)
> +		return rc;
> +
> +	req_qs->flags = flags;
> +	req_qs->port_id = cpu_to_le16(pf->port_id);
> +	req_qs->rx_stat_size = cpu_to_le16(sizeof(struct rx_port_stats_ext));
> +	req_qs->rx_stat_host_addr =
> +		cpu_to_le64(bn->rx_port_stats_ext.hw_stats_map);
> +	tx_stat_size = bn->tx_port_stats_ext.hw_stats ?
> +		       sizeof(struct tx_port_stats_ext) : 0;
> +	req_qs->tx_stat_size = cpu_to_le16(tx_stat_size);
> +	req_qs->tx_stat_host_addr =
> +		cpu_to_le64(bn->tx_port_stats_ext.hw_stats_map);
> +	resp_qs = bnge_hwrm_req_hold(bd, req_qs);
> +	rc = bnge_hwrm_req_send(bd, req_qs);
> +	if (!rc) {
> +		bn->fw_rx_stats_ext_size =
> +			le16_to_cpu(resp_qs->rx_stat_size) / 8;
> +		bn->fw_tx_stats_ext_size = tx_stat_size ?
> +			le16_to_cpu(resp_qs->tx_stat_size) / 8 : 0;
> +	} else {
> +		bn->fw_rx_stats_ext_size = 0;
> +		bn->fw_tx_stats_ext_size = 0;
> +	}
> +	bnge_hwrm_req_drop(bd, req_qs);
> +
> +	if (flags)
> +		return rc;
> +
> +	if (bn->fw_tx_stats_ext_size <=
> +	    offsetof(struct tx_port_stats_ext, pfc_pri0_tx_duration_us) / 8) {
> +		bn->pri2cos_valid = false;
> +		return rc;
> +	}
> +
> +	rc = bnge_hwrm_req_init(bd, req_qc, HWRM_QUEUE_PRI2COS_QCFG);
> +	if (rc)
> +		return rc;
> +
> +	req_qc->flags = cpu_to_le32(QUEUE_PRI2COS_QCFG_REQ_FLAGS_IVLAN);
> +
> +	resp_qc = bnge_hwrm_req_hold(bd, req_qc);
> +	rc = bnge_hwrm_req_send(bd, req_qc);
> +	if (!rc) {
> +		u8 *pri2cos;
> +		int i, j;
> +
> +		pri2cos = &resp_qc->pri0_cos_queue_id;
> +		for (i = 0; i < 8; i++) {
> +			u8 queue_id = pri2cos[i];
> +			u8 queue_idx;
> +
> +			/* Per port queue IDs start from 0, 10, 20, etc */
> +			queue_idx = queue_id % 10;
> +			if (queue_idx > BNGE_MAX_QUEUE) {
> +				bn->pri2cos_valid = false;
> +				bnge_hwrm_req_drop(bd, req_qc);
> +				return rc;
> +			}
>                         ^^^^

Is this bounds check off by one? BNGE_MAX_QUEUE is 8, so queue_idx of
exactly 8 passes this check and gets stored in bn->pri2cos_idx[i].

Looking at the usage in bnge_get_ethtool_stats()
(bnge_ethtool.c:482-504), the code computes base_off + bn->pri2cos_idx[i]
to index into the CoS stat arrays:

	for (i = 0; i < 8; i++, j++) {
		long n = bnge_rx_bytes_pri_arr[i].base_off +
			 bn->pri2cos_idx[i];
		buf[j] = *(rx_port_stats_ext + n);
	}

The CoS arrays in rx_port_stats_ext and tx_port_stats_ext have entries
cos0 through cos7, which are 8 entries total with valid indices 0-7.
When pri2cos_idx[i] equals 8, the computed offset reads one entry past
cos7, returning data from the wrong stats counter.

This can happen when firmware reports a queue_id whose modulo 10 equals 8
(e.g., queue_id 8, 18, 28, etc.).

Should the check be queue_idx >= BNGE_MAX_QUEUE instead?

[ ... ]

