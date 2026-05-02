Return-Path: <netdev+bounces-283455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OW6NX019mk5TAIAu9opvQ
	(envelope-from <netdev+bounces-283455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60814B3149
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDBF23008448
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26F3876DF;
	Sat,  2 May 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLC6/y9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27464383C64;
	Sat,  2 May 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743196; cv=none; b=qx8xiQwVHaJyOyLX3MWsw8sVNnN1aGh5Dip+ztrsAk9YwsN4Rx3FuNE1320IdfZyTDbs71pia3dR03NJ9b3imnm8D/yzBf2k6Fc2UOdbyYIpnyrv1R/m2iatTQJslY45CgALH8TEgdqXLmvmACkhq3cSOLQ//Bx1BOOMy9Hs86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743196; c=relaxed/simple;
	bh=S5qoTZogq1Cn7svB3A0PhTr6V/f5lwXN2HU0h7HAeUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT/oPxSooofaHrImEV+XU0kuN6MHgt4XZIVhN9ZzxVOz2NhVx2Y61TtGZ4Gbdoo1A0LARza9pSXLDYMfNU/lGEHJGpfaNlRYExID0CUykX9yncLGr/DHQAMCzTsG5ezVuaFTEY250BwuYtmyxJsg47lH2Q/6PRY3J7IuEdz0ICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLC6/y9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C961C2BCC4;
	Sat,  2 May 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777743196;
	bh=S5qoTZogq1Cn7svB3A0PhTr6V/f5lwXN2HU0h7HAeUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLC6/y9TtOrNYzHMV1KgTbziuDPQ9nO8kWopW/5vnCHlyoPKOuQVgBGhXtpbEN4Z0
	 vDAvG9jePuGE/xViDxRZggJEsUXnZAeba55YgG3g8lVVBUIUTkOKm9N8mGeamLtbpd
	 PFKBp4TEUdO0YDwFi5wooTXh7EbZXr1BrLvOFXwSEBo97Gu2d5g+PHdwpWxbP2dUgf
	 +5u1EWuzugfvOMX8Pu4J2s11eoywOun+Mil4H5irWAb5IWdTHDxdWuGvpvnoOVHFLb
	 UJd/M3hWziYZMch+ZSL2RzevPatDQgmHcgOlDY2Du+Q75DgTL68AwnpEYrPSd3LKZf
	 qLnocQ8vtEJJw==
From: Jakub Kicinski <kuba@kernel.org>
To: grzegorz.nitka@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ivecera@redhat.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	edumazet@google.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	donald.hunter@gmail.com,
	linux-kernel@vger.kernel.org,
	arkadiusz.kubalewski@intel.com,
	andrew+netdev@lunn.ch,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	Prathosh.Satish@microchip.com,
	anthony.l.nguyen@intel.com,
	pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH v7 net-next 6/8] ice: implement CPI support for E825C
Date: Sat,  2 May 2026 10:33:14 -0700
Message-ID: <20260502173314.3849725-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430094238.987976-7-grzegorz.nitka@intel.com>
References: <20260430094238.987976-7-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D60814B3149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,linux.dev,resnulli.us,google.com,intel.com,gmail.com,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283455-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: implement CPI support for E825C

This patch adds CPI (Converged PHY Interface) command handling for E825C
devices, introducing a new ice_cpi.c/ice_cpi.h subsystem that implements
the REQ/ACK handshake and a helper to enable or disable Tx reference
clocks. It also adds per-PHY mutexes on the adapter and a non-posted
write opcode (wr_np) to SBQ.

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index e95266c7f20b..fa238a6a0e1a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -31,6 +34,8 @@ struct ice_port_list {
>   * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
>   *                        register of the PTP clock.
>   * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
> + * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
> + *               Index 0 = PHY0, index 1 = PHY1. Only used on E825C.
>   * @ctrl_pf: Control PF of the adapter
>   * @ports: Ports list
>   * @index: 64-bit index cached for collision detection on 32bit systems

The kernel-doc says cpi_phy_lock is "Only used on E825C", but in
ice_adapter_new() and ice_adapter_free() the mutexes are unconditionally
initialized and destroyed for every adapter:

  for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
          mutex_init(&adapter->cpi_phy_lock[i]);

Would it be better to either relax the comment or gate the
init/destroy on an E825C device check so that the behavior matches the
documentation?

> diff --git a/drivers/net/ethernet/intel/ice/ice_cpi.c b/drivers/net/ethernet/intel/ice/ice_cpi.c
> new file mode 100644
> index 000000000000..d5be36c60697
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_cpi.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2026 Intel Corporation */

The sibling ice_cpi.h added in the same commit uses
"SPDX-License-Identifier: GPL-2.0-only" and "Copyright (C) 2018-2025".
Should the two newly added files use the same SPDX form (GPL-2.0 is the
deprecated alias of GPL-2.0-only) and the same copyright end year?

[ ... ]

> +/**
> + * ice_cpi_wait_req0_ack0 - waits for CPI interface to be available
> + * @hw: pointer to the HW struct
> + * @phy: phy index of port the CPI action is taken on
> + *
> + * This function checks if CPI interface is ready to use by CPI client.
> + * It's done by assuring LM.CMD.REQ and PHY.CMD.ACK bit in CPI
> + * interface registers to be 0.
> + *
> + * Return: 0 on success, negative on error
> + */
> +static int ice_cpi_wait_req0_ack0(struct ice_hw *hw, int phy)
> +{
> +	u32 phy_val;
> +	u32 lm_val;
> +
> +	for (int i = 0; i < CPI_RETRIES_COUNT; i++) {
> +		int err;
> +
> +		/* check if another CPI Client is also accessing CPI */
> +		err = ice_cpi_read_phy(hw, phy, CPI0_LM1_CMD_DATA, &lm_val);
> +		if (err)
> +			return err;
> +		if (FIELD_GET(CPI_LM_CMD_REQ_M, lm_val))
> +			return -EBUSY;

The function is shaped as a retry loop and the kernel-doc says it
"waits for CPI interface to be available", but when LM.REQ is observed
set it returns -EBUSY on the first iteration with no retry.

Only the ACK-deasserted check actually benefits from the loop and the
msleep(CPI_RETRIES_CADENCE_MS) cadence.

If another CPI client transiently holds REQ, should this path also be
retried (up to CPI_RETRIES_COUNT times) rather than failing
immediately?

[ ... ]

> +/**
> + * ice_cpi_exec - executes CPI command
> + * @hw: pointer to the HW struct
> + * @phy: phy index of port the CPI action is taken on
> + * @cmd: pointer to the command struct to execute
> + * @resp: pointer to user allocated CPI response struct
> + *
> + * This function executes CPI request with respect to CPI handshake
> + * mechanism.
> + *
> + * Return: 0 on success, otherwise negative on error
> + */
> +int ice_cpi_exec(struct ice_hw *hw, u8 phy,
> +		 const struct ice_cpi_cmd *cmd,
> +		 struct ice_cpi_resp *resp)
> +{
[ ... ]
> +	/* 1. Try to acquire the bus, PHY ACK should be low before we begin */
> +	err = ice_cpi_wait_req0_ack0(hw, phy);
> +	if (err)
> +		goto cpi_exec_exit;
> +
> +	/* 2. We start the CPI request */
> +	err = ice_cpi_exec_cmd(hw, phy, lm_cmd);
> +	if (err)
> +		goto cpi_exec_exit;

Can this leave LM.REQ stuck asserted on the hardware?

ice_cpi_exec_cmd() writes lm_cmd with CPI_LM_CMD_REQ_M set. If
ice_sbq_rw_reg() returns an error after the hardware has already latched
the LM.REQ=1 write (for example an admin-queue completion timeout after
the write was dispatched), control jumps to cpi_exec_exit and skips the
REQ deassert at cpi_deassert (steps 4 and 5).

Every subsequent ice_cpi_exec() on that PHY would then fail immediately
in ice_cpi_wait_req0_ack0() with -EBUSY, because that helper returns
-EBUSY on the first read that observes LM.REQ==1 and does not retry.

The step-3 error path already falls through to cpi_deassert; should the
step-2 error path do the same so REQ is always cleared? Deasserting REQ
when it was never latched is harmless.

> +
> +	/*
> +	 * 3. Wait for CPI confirmation, PHY ACK should be asserted and opcode
> +	 *    echoed in the response
> +	 */
> +	err = ice_cpi_wait_ack1(hw, phy, &phy_cmd);
> +	if (err)
> +		goto cpi_deassert;
> +
> +	if (FIELD_GET(CPI_PHY_CMD_ACK_M, phy_cmd) &&
> +	    FIELD_GET(CPI_LM_CMD_OPCODE_M, lm_cmd) !=
> +	    FIELD_GET(CPI_PHY_CMD_OPCODE_M, phy_cmd)) {
> +		err = -EFAULT;
> +		goto cpi_deassert;
> +	}

Is the FIELD_GET(CPI_PHY_CMD_ACK_M, phy_cmd) conjunct here ever false?

ice_cpi_wait_ack1() only returns 0 with asserted=true when
CPI_PHY_CMD_ACK_M is set in the value it stored into phy_cmd:

  if (asserted && FIELD_GET(CPI_PHY_CMD_ACK_M, phy_val)) {
          if (data)
                  *data = phy_val;
          return 0;
  }

So the ACK sub-expression is always true on this path, and reading the
code suggests a NACK/ACK=0 case is handled here that isn't. Would it be
clearer to drop the redundant check?

[ ... ]

> +/**
> + * ice_cpi_set_cmd - execute CPI SET command
> + * @hw: pointer to the HW struct
> + * @opcode: CPI command opcode
> + * @phy: phy index CPI command is applied for
> + * @port_lane: ephy index CPI command is applied for
> + * @data: CPI opcode context specific data
> + *
> + * Return: 0 on success.
> + */
> +static int ice_cpi_set_cmd(struct ice_hw *hw, u16 opcode, u8 phy, u8 port_lane,
> +			   u16 data)
[ ... ]
> +/**
> + * ice_cpi_ena_dis_clk_ref - enables/disables Tx reference clock on port
> + * @hw: pointer to the HW struct
> + * @phy: phy index of port for which Tx reference clock is enabled/disabled
> + * @clk: Tx reference clock to enable or disable
> + * @enable: bool value to enable or disable Tx reference clock
> + *
> + * This function executes CPI request to enable or disable specific
> + * Tx reference clock on given PHY.
> + *
> + * Return: 0 on success.
> + */
> +int ice_cpi_ena_dis_clk_ref(struct ice_hw *hw, u8 phy,
> +			    enum ice_e825c_ref_clk clk, bool enable)

The kernel-doc here and on ice_cpi_set_cmd() says "Return: 0 on
success." but both functions forward any negative errno produced by
ice_cpi_exec() (such as -EINVAL, -EBUSY, -EFAULT, or -ETIMEDOUT).
Should the Return: documentation also cover the error path?

> diff --git a/drivers/net/ethernet/intel/ice/ice_cpi.h b/drivers/net/ethernet/intel/ice/ice_cpi.h
> new file mode 100644
> index 000000000000..932fe0c0824a
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_cpi.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2018-2025 Intel Corporation */
> +
> +#ifndef _ICE_CPI_H_
> +#define _ICE_CPI_H_
[ ... ]
> +/* CPI LM CMD DATA register (CPI0_LM1_CMD_DATA) */
> +#define CPI_LM_CMD_DATA_M	GENMASK(15, 0)
> +#define CPI_LM_CMD_OPCODE_M	GENMASK(23, 16)
> +#define CPI_LM_CMD_PORTLANE_M	GENMASK(26, 24)
> +#define CPI_LM_CMD_RSVD_M	GENMASK(28, 27)
> +#define CPI_LM_CMD_GET_SET_M	BIT(29)
> +#define CPI_LM_CMD_RESET_M	BIT(30)
> +#define CPI_LM_CMD_REQ_M        BIT(31)
> +
> +#define CPI_OPCODE_PHY_CLK			0xF1
> +#define CPI_OPCODE_PHY_CLK_PHY_SEL_M		GENMASK(9, 6)
> +#define CPI_OPCODE_PHY_CLK_REF_CTRL_M		GENMASK(5, 4)
> +#define CPI_OPCODE_PHY_CLK_PORT_SEL		0
> +#define CPI_OPCODE_PHY_CLK_DISABLE		1
> +#define CPI_OPCODE_PHY_CLK_ENABLE		2
> +#define CPI_OPCODE_PHY_CLK_REF_SEL_M		GENMASK(3, 0)
> +
> +#define CPI_OPCODE_PHY_PCS_RESET		0xF0
> +#define CPI_OPCODE_PHY_PCS_ONPI_RESET_VAL	0x3F
> +
> +#define CPI_LM_CMD_REQ		1
> +#define CPI_LM_CMD_SET		1

A few of these macros appear unused anywhere in this patch and through
the end of the series: CPI_LM_CMD_RESET_M, CPI_OPCODE_PHY_CLK_PORT_SEL,
CPI_OPCODE_PHY_PCS_RESET, CPI_OPCODE_PHY_PCS_ONPI_RESET_VAL, and
CPI_LM_CMD_SET. CPI_LM_CMD_SET (value 1) looks like it was intended to
be passed to FIELD_PREP(CPI_LM_CMD_GET_SET_M, ...), but ice_cpi_exec()
uses the bool cmd->set directly and leaves the named constant dead.

Would it make sense to drop the unused defines, or wire them in if
they're intended for a follow-up?

Also, the commit message mentions "enabling/disabling/selection of PHY
reference clock" and CPI_OPCODE_PHY_CLK_PORT_SEL is defined for the
selection variant, but no API in this patch uses it;
ice_cpi_ena_dis_clk_ref() only issues ENABLE or DISABLE. Should the
commit message be trimmed to match what the patch actually delivers?

> +
> +struct ice_cpi_cmd {
> +	u8 port;
> +	u8 opcode;
> +	u16 data;
> +	bool set;
> +};
> +
> +struct ice_cpi_resp {
> +	u8 port;
> +	u8 opcode;
> +	u16 data;
> +};
> +
> +int ice_cpi_exec(struct ice_hw *hw, u8 phy,
> +		 const struct ice_cpi_cmd *cmd,
> +		 struct ice_cpi_resp *resp);
> +int ice_cpi_ena_dis_clk_ref(struct ice_hw *hw, u8 port,
> +			    enum ice_e825c_ref_clk clk, bool enable);
> +#endif /* _ICE_CPI_H_ */

Is ice_cpi.h intended to be self-contained?

The header declares ice_cpi_ena_dis_clk_ref() with an
enum ice_e825c_ref_clk parameter and uses struct ice_hw * in both
prototypes, but it does not include ice_ptp_hw.h (which defines
enum ice_e825c_ref_clk) and does not pull in anything that forward-
declares struct ice_hw. ice_cpi.c compiles because it includes
ice_type.h, ice_common.h and ice_ptp_hw.h before ice_cpi.h.

Since C does not allow a portable forward declaration of an enum type,
would a future consumer that includes ice_cpi.h without first including
ice_ptp_hw.h fail to compile? Should the header include what it needs?

