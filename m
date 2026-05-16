Return-Path: <netdev+bounces-288533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DjoExLEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 529EB559AD6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0EFE30095DD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA329C35A;
	Sat, 16 May 2026 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2YWsmuJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819C29BDB1
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893816; cv=none; b=aGnb9vVyYOR2liwtRCAhnxT9kfVzkiZmJl9EMG3rNVN2YQmY6chE9gQczscntx2QnfEm0lXFcgIPQ2B8mQmuCX/9vuYLYj3TVlIkAMekFhVwEsnjn//oiZTDXontSUlk3FeVeC6qHDhWQqHx+umRlHyoEPn/V6aDKVuRx0PVMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893816; c=relaxed/simple;
	bh=q4humdzQhT75PJYD0sJWYpPcuGedUGovyqEbRbwM7SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma/T4wjxtnGiPuYKrCWMVRZC9iFknpl8Ej6aJha3Rhxo/DaYEdb+TAuHiI8Gx50mo5xjpKNAvAFTEGoMBClbDHrTScqE3pr+N1g5uM2Yf+L1f/TehDTMCQY/eYDg4l67yNtFC/GzeVeHgiCP1EnWEq82vg426ROa8WKOfaA5AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2YWsmuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E92C2BCB7;
	Sat, 16 May 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893816;
	bh=q4humdzQhT75PJYD0sJWYpPcuGedUGovyqEbRbwM7SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2YWsmuJqUVXmczbl8UkH80adREsXg02/T9YrXtd6LoyPQ3NaP03DpzmNQ1ANN5Ek
	 7Bbjs0HmySXQ7egAW8RzdxOcdSEP/1F+IwAOnO1yeCqOqwgTLG6M2mR55ttBBb1Rzh
	 CoRYnz4ytayTpIVOsMY3oAdfc13RSN06vaF5Eb6PYTzbXYWI4m0IWwJihKpPSNpt1n
	 aTMA9/9v9N5j+j/5fcPOAR/sc0Ooxn/Hnel4IolQXlg5iBFya0WAjqgzzi7JGdTyFb
	 QQRa+ViQ2HcKyKyQ8K9UL5ybbtfGqrFb+LZ8JNq6m4AQ8xfUIRb8KilSAxRR7Hq1Uo
	 ElU1Af+S+7stQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Fri, 15 May 2026 18:10:15 -0700
Message-ID: <20260516011015.1857549-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-9-michael.chan@broadcom.com>
References: <20260512212105.3488258-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 529EB559AD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288533-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt_en: Reserve crypto RX and TX key contexts on a PF

This patch teaches the bnxt_en PF reservation path to populate
num_ktls_tx_key_ctxs / num_ktls_rx_key_ctxs in the HWRM_FUNC_CFG request
and to record the reserved counts returned by HWRM_FUNC_QCFG, so kTLS
keys can later be allocated at run-time.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e2b5f81b36a6..926665c8bb79 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -7915,8 +7920,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
>  		}
>  		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
>  		req->num_vnics = cpu_to_le16(hwr->vnic);
> +		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
>  	}
> -	req->enables = cpu_to_le32(enables);
> +	req->enables |= cpu_to_le32(enables);
>  	return req;
>  }

[Medium]
After this change, every caller of __bnxt_hwrm_reserve_pf_rings() that
takes the BNXT_NEW_RM(bp) path picks up a kTLS key reservation.  One of
those callers is bnxt_hwrm_check_pf_rings(), which is the feasibility
check used by bnxt_check_rings() (ethtool -L, ethtool -G, channel
resize, etc.):

    static int bnxt_hwrm_check_pf_rings(struct bnxt *bp,
                                        struct bnxt_hw_rings *hwr)
    {
            struct hwrm_func_cfg_input *req;
            u32 flags;

            req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
            flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
            if (BNXT_NEW_RM(bp)) {
                    flags |= FUNC_CFG_REQ_FLAGS_RX_ASSETS_TEST |
                             FUNC_CFG_REQ_FLAGS_CMPL_ASSETS_TEST |
                             FUNC_CFG_REQ_FLAGS_STAT_CTX_ASSETS_TEST |
                             FUNC_CFG_REQ_FLAGS_VNIC_ASSETS_TEST;
                    ...
            }

            req->flags = cpu_to_le32(flags);
            return hwrm_req_send_silent(bp, req);
    }

This sets the *_ASSETS_TEST bits in req->flags, but it never sets
FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST in req->flags2 (a grep of
drivers/net/ethernet/broadcom/bnxt confirms that flag is not set
anywhere in the driver).

Does that mean firmware will treat the tx/rx/cmpl/stat/vnic resources as
test-only while still committing the kTLS key reservation as a side
effect of every bnxt_check_rings() call?

If so, would this also cause an ethtool ring/channel resize to be
rejected on a chip whose kTLS key pool is currently exhausted, even
though the user only intended to probe the ring resources?

Should bnxt_hwrm_check_pf_rings() either skip
bnxt_hwrm_reserve_pf_key_ctxs(), or set
FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST in req->flags2 so the kTLS
portion of the request is also evaluated as test-only?

[Low]
On a kTLS-capable PF (bp->crypto_info != NULL),
bnxt_hwrm_reserve_pf_key_ctxs() unconditionally sets
FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS in req->enables, and the change
from "=" to "|=" on the final assignment preserves them.

That makes the early-return short-circuit in bnxt_hwrm_reserve_pf_rings()
unreachable on such PFs:

    req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
    if (!req)
            return -ENOMEM;

    if (!req->enables) {
            hwrm_req_drop(bp, req);
            return 0;
    }

    rc = hwrm_req_send(bp, req);
    ...
    return bnxt_hwrm_get_rings(bp);

Is it intended that every previously-no-op call now performs an HWRM
round-trip plus a follow-up bnxt_hwrm_get_rings() on kTLS-capable PFs?

If not, would it be appropriate to also gate the kTLS enables/values on
whether any of the original "enables" bits were going to be set, so the
no-op path is preserved?

[ ... ]

