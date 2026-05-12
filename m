Return-Path: <netdev+bounces-287029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPuVO2TzAmo9zAEAu9opvQ
	(envelope-from <netdev+bounces-287029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:31:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407A51DC27
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DC1D300B590
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D839E6FD;
	Tue, 12 May 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0C1PluA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDC355F35
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578263; cv=none; b=EaHKGIPm6YDCycZYVfRhNhbBGwjS8y2xa8PBlOCcXNe3HmISiIlV7dKvAo2GcYWEEs9oESwDf4eLBZZZn4lOXyNDGfBNjJIsoVH9Gcdonj/VbutbFWOVzx1LG96Kh5ZPTC25Tidtt9pyqwRwSIDTM/rPz4EhS3aLNOtE7dyIKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578263; c=relaxed/simple;
	bh=/Lkf0xtjR8+DcAGM3D4n7rN02RixsrTSOnsw4O3WC10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyh/KOb7I0lR14TS87wzZfioNr/Tq4ZuHgffuNLiEslZgPDQpFJxPV0nZTZKUVGcbgVyAq31b6PQFwgZSAl2HlNk7mENzdqDzJ7Pexn3SJvR/aNpwVM4CBDXiZL9z98gJsq2U72MyMIlCNghygMvFrXnSOoBdWNo0cJdUPrvx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0C1PluA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECCEC2BCF6;
	Tue, 12 May 2026 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778578263;
	bh=/Lkf0xtjR8+DcAGM3D4n7rN02RixsrTSOnsw4O3WC10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0C1PluAnOEvd3FHFCLKsCriNp2pN7jslbKG13ypogFIFfLacjv/lI4SOjIFHfj0E
	 mFuA5EJAHtbq5Rif4W09Kz0ses2CrvoIlfeJg7v9Oo6DYxbYqzwiB3EW5U69tkUXZ0
	 aqnsVZuRFJf0HJXP0w6qTTAOdUiU14KDWtv3321u0vncE9pgm7OPYwb/2b5DChRBFP
	 WI4t0ecWLeswRdw6eOhsXS/ou2rVdD8nK4mDAnEH1tbWeuEmk4QAePwYnND3ica2l2
	 j6rUJh1KAr0Rzlh6TDKHt+7bKeVlq7qgCr/RbNBMXsVfV/HGApk72sEtZQ+z18qaqV
	 TAUOKSn01e3uQ==
From: Simon Horman <horms@kernel.org>
To: przemyslaw.korba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net v2] ice: support SBQ posted writes with non-posted support for CGU
Date: Tue, 12 May 2026 10:27:41 +0100
Message-ID: <20260512092740.290008-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508102247.826375-1-przemyslaw.korba@intel.com>
References: <20260508102247.826375-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9407A51DC27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287029-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: support SBQ posted writes with non-posted support for CGU

This commit introduces non-posted SBQ writes while allowing posted writes
to skip completion waits. It also adds an SBQ flush by reading address 0
from PHY 0 before issuing a SYNC command to ensure writes are completed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 24fb7a3e14d63..ec4c85ad12e4d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -352,6 +352,17 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
>  {
>  	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
> +	struct ice_sbq_msg_input msg = {
> +		.dest_dev = ice_sbq_dev_phy_0,
> +		.opcode = ice_sbq_msg_rd,
> +	};
> +	int err;
> +
> +	if (hw->mac_type != ICE_MAC_E810) {
> +		err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
> +		if (err)
> +			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
> +	}

[ ... ]

> @@ -4469,15 +4482,15 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
>   */
>  static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
>  {
> -	struct ice_sbq_msg_input msg = {0};
> +	struct ice_sbq_msg_input msg = {
> +		.dest_dev = ice_sbq_dev_phy_0,
> +		.opcode = ice_sbq_msg_wr_p,
> +		.msg_addr_low = lower_16_bits(addr),
> +		.msg_addr_high = upper_16_bits(addr),
> +		.data = val
> +	};

Since ice_write_phy_reg_e810() is updated to use the posted write opcode
(ice_sbq_msg_wr_p), it will skip the completion wait and return immediately.

If the SBQ flush in ice_ptp_exec_tmr_cmd() explicitly skips E810 devices
via the check for hw->mac_type != ICE_MAC_E810, does this leave E810 PHY
writes entirely asynchronous and unguarded?

Could this lead to a race condition where the writes have not actually
completed before the SYNC_EXEC_CMD is executed?

