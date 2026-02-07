Return-Path: <netdev+bounces-257694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBCwLBCjhmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBB104A36
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A003C3082659
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D6331A6F;
	Sat,  7 Feb 2026 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCz6CKCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E93314DF;
	Sat,  7 Feb 2026 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431097; cv=none; b=cUDtSWH3z0r8GWeJn9ZJ/L9pcXUfCTUK5g2GLxSpdPgzAFkgxB9FzVBaMCDSbK0RQG9q5m+QsHQzNDu4W/O9Kz/IFO/rtNXgmYJepDRCGe9bWVVGSM59htvNHjcfevvKMpna2M83yAGS+CVAqon3SsrawcM+N9acUAvUo4BtG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431097; c=relaxed/simple;
	bh=gR3zIaXjR3aBLX0hhwuBF993RceLsaFGYPgieGadOnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv0qcJPhSz5b8jFxepxT3BPxfoVjJBudiwUHHKpOJ7151zBXIvoSR08GlF8/8m1+Kif7nSs/t9Fqz8rJ+oHmeu3ZpOaOsWjDtr1JGVu1NGzFG7T3QCC1qv/s3Y3EJosXQGM/fg/fu1mR32XOAtq8wxa3U0IvpNaFizT6YKRDZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCz6CKCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641A0C16AAE;
	Sat,  7 Feb 2026 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431097;
	bh=gR3zIaXjR3aBLX0hhwuBF993RceLsaFGYPgieGadOnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCz6CKCUs4I4lyd7SrtegpAd3v+72fclOBxiqCEZgaj9bKrw5USPNcsKHnwDmvrYU
	 C5J0RILuHM7BTtDFFZAjVOap21qU0sSs2ETbh+1dJVn9FsqjvPonuM7busEkGhvlKv
	 plaX4AasPgUCoGS23ddJp9h2ZstxKpQQ0Deo00r0KxJDYmGJH48+iG4KGxj+3hFzZf
	 xRdcwacYo/pMD2uCgDY3FXrzk2oKkWANcRZjOzmL9V+jsrGDcZyZVleh21ygxC1P1S
	 ki5Y9zk0ZiETpXviiQXaK1q7ju2YuHe/UKlFxNkX0m66C0hipJnRb8Ou3SDbsS7q99
	 oWs+SsmivLXAA==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,06/11] net/nebula-matrix: add common resource implementation
Date: Fri,  6 Feb 2026 18:24:55 -0800
Message-ID: <20260207022455.4017894-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-7-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-7-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257694-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13CBB104A36
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add common resource implementation

This patch adds the common resource layer for the nebula-matrix network
driver, implementing conversion relationships among vsi_id, func_id,
eth_id, and pf_id.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> +static void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
> +			       u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
> +{
> +	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
> +	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
> +
> +	*eth_mode = eth_info->eth_num;
> +	if (pf_id < eth_info->eth_num) {
> +		*eth_id = eth_info->eth_id[pf_id];
> +		*logic_eth_id = pf_id;
> +		/* if pf_id > eth_num, use eth_id 0 */
> +	} else {

This isn't a bug, but the comment appears to be misplaced. It describes
what happens in the else branch but is located inside the if branch. Should
it be moved above the else?

[ ... ]

> +static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
> +{

[ ... ]

> +	for (i = 0; i < NBL_RES_MGT_TO_PF_NUM(res_mgt); i++) {
> +		/* if pf_id <= eth_num, the pf relate corresponding eth_id*/
> +		if (i < eth_num) {

This isn't a bug, but the comment says "pf_id <= eth_num" while the code
checks "i < eth_num". Should the comment say "<" instead of "<="?

> +			eth_id = eth_info->eth_id[i];
> +			eth_info->pf_bitmap[eth_id] |= BIT(i);
> +		}
> +		/* if pf_id > eth_num, the pf relate eth 0*/
> +		else

Similarly, the comment says "pf_id > eth_num" but the else handles the case
where "i >= eth_num". Should the comment say ">=" instead of ">"?

> +			eth_info->pf_bitmap[0] |= BIT(i);
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c

[ ... ]

> +static int vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
> +{
> +	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
> +	struct nbl_common_info *common = res_mgt->common;
> +	bool vsi_find = false;
> +	u32 pf_id = U32_MAX;
> +	int i, j;
> +
> +	for (i = 0; i < vsi_info->num; i++) {
> +		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++)
> +			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
> +			    (vsi_id < vsi_info->serv_info[i][j].base_id +
> +					      vsi_info->serv_info[i][j].num)) {
> +				vsi_find = true;
> +				break;
> +			}
> +
> +		if (vsi_find)
> +			break;
> +	}
> +
> +	if (vsi_find) {
> +		/* if pf_id < eth_num */
> +		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
> +		    j <= NBL_VSI_SERV_PF_DATA_TYPE)

This isn't a bug, but the comment says "if pf_id < eth_num" while the code
checks if j equals NBL_VSI_SERV_PF_DATA_TYPE (which is 0). The comment does
not seem to describe the actual condition being tested. Could it be updated
to reflect what the code is checking?

> +			pf_id = i + common->mgt_pf;
> +	}
> +
> +	return pf_id;
> +}

