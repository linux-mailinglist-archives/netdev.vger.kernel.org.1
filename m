Return-Path: <netdev+bounces-258638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIosDvtLj2nnPgEAu9opvQ
	(envelope-from <netdev+bounces-258638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:06:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2885137D0E
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B65433041153
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EE35FF43;
	Fri, 13 Feb 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHqcLS8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA32D780E
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998773; cv=none; b=ZkqSCr/kE95mPh/uJ8NPP+XuApNrwsRnQbpsESk5/BRm59AG3utK3gqyB5+yxFr4S5WkEpnrfy5jmhGX/A1qn5gWJvs9nHCMXAd7JokNaLW7/2KbLxJXNSFIm2h7/qx8r3Z0DCFqPxIg58Er2Y/X0puG1OG821G5djbmY+13NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998773; c=relaxed/simple;
	bh=nQZ77PqctDTcYDinAbWjENAqR0oQhnhj2uSc/QPB/FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtyCVBh2T6mfx8Jz9eGnWevyoGc160DeI6Fadt8uu4gv8UIcBCJar8s+ni0v/6qt4s1elFsHegXKDaH4zM/3QlvpgkWeqs87HqZNrMrt70LA6sdZPJlLF+jxDYi/ZsV1KdXXCU+6KBDHZzg9Twcmt58KlqblFBWv30QPFGELgVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHqcLS8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C10C116C6;
	Fri, 13 Feb 2026 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998772;
	bh=nQZ77PqctDTcYDinAbWjENAqR0oQhnhj2uSc/QPB/FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHqcLS8VUGrLPput0dKUotJs4S3e7OYkbAbIHCQIbdfzw4biZ7/2OFE34qoy29w1y
	 jYDVezYR+0D3Iu4pQ0Dx7jvwJucjrSfcCQZVWL+ZQKCmtUzM+s1SLaopGsjQ40accN
	 pb9ZMzk8OfhnOxPBQob4C6A6Adv50q3260+mA1NE75T/kPPr83UpHyqyRSgzx4r4xD
	 mt80Yd8dXw359ERf3PowTvyDOp2elu1uKjwFf61gDKiE73s2RpEgzlCRcPqQpn+SF/
	 8wD3MB0MeOrS7MzMhmtwuyqY4E+uuIYzfwp4FrzFexhYSEktZ9/fkLd3eaaQA6zOJL
	 L7kFGlPnyG+YQ==
From: Simon Horman <horms@kernel.org>
To: michael.chan@broadcom.com
Cc: Simon Horman <horms@kernel.org>,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	andrew.gospodarek@broadcom.com,
	andrew+netdev@lunn.ch,
	kicinski@meta.com,
	netdev@vger.kernel.org,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net
Subject: Re: [net,v3,3/4] bnxt_en: Fix deleting of Ntuple filters
Date: Fri, 13 Feb 2026 16:06:04 +0000
Message-ID: <20260213160604.2515258-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213074503.2302046-4-michael.chan@broadcom.com>
References: <20260213074503.2302046-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258638-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2885137D0E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bnxt_en: Fix deleting of Ntuple filters

This commit fixes an issue where ntuple filters deleted when the
interface is down would cause FW errors. It saves a vnic pointer in the
filter's base structure to check if the VNIC is already freed.

Fixes: 8336a974f37d ("bnxt_en: Save user configured filters in a lookup list")

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8fc15a8353fc..1f05ecf367fe 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -6240,6 +6244,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
>  	int rc;
>
>  	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
> +	if (fltr->base.vnic->fw_vnic_id == INVALID_HW_RING_ID)
> +		return 0;
> +

Does this code dereference fltr->base.vnic without checking if it's NULL?

For ntuple drop filters created with ring_cookie == RX_CLS_FLOW_DISC, the
code sets the BNXT_ACT_DROP flag. Looking at bnxt_hwrm_cfa_ntuple_filter_alloc:

int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
                                      struct bnxt_ntuple_filter *fltr)
{
	...
	if (fltr->base.flags & BNXT_ACT_DROP) {
		req->flags =
			cpu_to_le32(CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DROP);
	} else if (bp->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2) {
		bnxt_cfg_rfs_ring_tbl_idx(bp, req, fltr);
	} else {
		vnic = &bp->vnic_info[fltr->base.rxq + 1];
		fltr->base.vnic = vnic;
		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
	}

The BNXT_ACT_DROP case sets the drop flag but doesn't initialize
fltr->base.vnic. When that filter is later freed, this code dereferences
the NULL vnic pointer.

[ ... ]

> @@ -6339,6 +6348,7 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
>  		bnxt_cfg_rfs_ring_tbl_idx(bp, req, fltr);
>  	} else {
>  		vnic = &bp->vnic_info[fltr->base.rxq + 1];
> +		fltr->base.vnic = vnic;
>  		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
>  	}

Looking at the if-else structure here:

	if (fltr->base.flags & BNXT_ACT_DROP) {
		req->flags =
			cpu_to_le32(CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DROP);
	} else if (bp->fw_cap & BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2) {
		bnxt_cfg_rfs_ring_tbl_idx(bp, req, fltr);
	} else {
		vnic = &bp->vnic_info[fltr->base.rxq + 1];
		fltr->base.vnic = vnic;
		req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
	}

Should the BNXT_ACT_DROP case also set fltr->base.vnic?

Drop filters don't have a destination vnic, so the code doesn't set one.
But the free path in bnxt_hwrm_cfa_ntuple_filter_free now dereferences
fltr->base.vnic without a NULL check, which would crash when freeing drop
filters.

Either the drop case should explicitly set fltr->base.vnic = NULL and the
free path should check for NULL, or drop filters should be assigned a dummy
vnic. Currently the code leaves vnic uninitialized and then dereferences it.

[ ... ]

