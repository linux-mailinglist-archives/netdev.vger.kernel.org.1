Return-Path: <netdev+bounces-256918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LMMFab/g2nYwgMAu9opvQ
	(envelope-from <netdev+bounces-256918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4646EDF47
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F4030055C5
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8D2BCF68;
	Thu,  5 Feb 2026 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPn5RuWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7C29B8EF;
	Thu,  5 Feb 2026 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258330; cv=none; b=ku6EaWm7/Uaa6XCjrWVO6/YeU0TpFrF6JSu1bWcKWDSywBY7/4QeiK+Hka0rHMxZcnf/zitN5qjVz2f+Xya6IsBvmjkxY0+B6e7TrRzghvexZQKlAGFRKZU/gFh/LXK2uBq6uxkcFkK/AhC+f7nq44lu1QRsFIZ/CmrIzXduKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258330; c=relaxed/simple;
	bh=S9IHfYvk4HbMCAhqeJLhPoSUHhMVZR+8G/5Qacx8TJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv3OAItB9CnXWAbUgJ32mYThqtjYxJU2ITO9Fh6FES6/LqaG2qHd3ga69NLkTBpO1UozDrhkPkFFjKwXKmOt1zg30kPlMpNYsKAOJvh0A5QuFuE7T/Zmos+QfD9ZBlgf2KVJnWTH4IO0GfzO2N1vbNRqT1wWWlKi4r3qPYZgCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPn5RuWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D836C4CEF7;
	Thu,  5 Feb 2026 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258329;
	bh=S9IHfYvk4HbMCAhqeJLhPoSUHhMVZR+8G/5Qacx8TJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPn5RuWG8LguHrM/v3C2q96RuJdWN4VkaNuIcRBp9vyb6vXaexBrGbLVvb1pgQ2D5
	 ItoTBTL/yBJt5hKS2cZZYpwTCYN01h1Fg2EmLsmVHxwuAz+DfLn3kYVUXWQA8NfHZq
	 KoM3F5WlxxN2HdmvS91jUFpzrdx+7cpHEVT2YqS2GMizL5sWwusOvn+NzI5TKIiQ0k
	 eZA3XpWpjIgYZuDfD9qrtGMGIEhIQ309TIHZV74FbCPO9R0kWALsYlNJUtDTht84X0
	 /66/U2yhgaziGejAAlNA68Ln7H1nDJvA0ivRB1qIK2g854EEWujKx9GquGoEGiHHft
	 dMhY4ljR6DNlw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumang@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net
Subject: Re: [net-next,v8,10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
Date: Wed,  4 Feb 2026 18:25:27 -0800
Message-ID: <20260205022527.2271205-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202074607.2535569-11-rkannoth@marvell.com>
References: <20260202074607.2535569-11-rkannoth@marvell.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256918-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4646EDF47
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation

In CN20K, the PF/VF driver is unaware of the NPC MCAM entry type (x2/x4)
required for a particular TC rule when the user installs rules through the
TC command. This forces the PF/VF driver to first query the AF driver for
the rule size, then allocate an entry, and finally install the flow. This
sequence requires three mailbox request/response exchanges from the PF. To
speed up the installation, the `install_flow` mailbox request message is
extended with additional fields that allow the AF driver to determine the
required NPC MCAM entry type, allocate the MCAM entry, and complete the
flow installation in a single step.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7306414d1cf2..237e6f606fc1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -1412,9 +1453,11 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
>  		mutex_unlock(&mcam->lock);
>  		goto out;
>  	}
> +
> +	rl_type = rvu_npc_get_base_steer_rule_type(rvu, pcifunc);
> +
>  	/* Read the default ucast entry if there is no pkt steering rule */
> -	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
> -					 NIXLF_UCAST_ENTRY);
> +	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf, rl_type);
>  read_entry:
>  	/* Read the mcam entry */
>  	npc_cn20k_read_mcam_entry(rvu, blkaddr, index,

The new function rvu_npc_get_base_steer_rule_type() returns
NIXLF_PROMISC_ENTRY for loopback VFs, but npc_get_nixlf_mcam_index() can
return negative error codes when it cannot find the requested entry.
Should there be an error check after calling npc_get_nixlf_mcam_index()
at line 1460?

When the promisc MCAM entry is not configured, npc_cn20k_dft_rules_idx_get()
returns -ESRCH, which causes npc_get_nixlf_mcam_index() to return -EFAULT.
Without an error check, this negative value gets cast to u16 when passed to
npc_cn20k_read_mcam_entry(), converting -14 to 65522 and potentially
causing an out-of-bounds hardware register read.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index bff190ba95e2..b9572de1d175 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1549,6 +1549,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	cn20k_wreq.intf = req->intf;
>  	cn20k_wreq.enable_entry = (u8)enable;
>  	cn20k_wreq.hw_prio = req->hw_prio;
> +	cn20k_wreq.req_kw_type = req->req_kw_type;
>
>  update_rule:

Looking at npc_install_flow(), req->req_kw_type is copied to
cn20k_wreq.req_kw_type, but is req->req_kw_type ever initialized with the
computed kw_type value?

In rvu_mbox_handler_npc_install_flow(), the function
rvu_npc_alloc_entry_for_flow_install() computes the correct kw_type based
on the flow requirements and stores it in the local variable 'kw_type' at
line 1746. However, this computed value is never assigned to
req->req_kw_type before calling npc_install_flow() at line 1887.

As a result, npc_install_flow() uses either a zero-initialized value or
whatever the PF driver sent, instead of the AF-computed value. This seems
inconsistent with the commit message stating "the AF driver determine the
required NPC MCAM entry type." The incorrect req_kw_type is then passed to
npc_cn20k_config_mcam_entry() which uses it for hardware configuration
mismatch handling in npc_cn20k_config_kw_x2() at lines 956-960.

> @@ -1642,6 +1643,79 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	return 0;
>  }
>
> +static int
> +rvu_npc_free_entry_for_flow_install(struct rvu *rvu, u16 pcifunc,
> +				    bool free_entry, int mcam_idx)
> +{
> +	struct npc_mcam_free_entry_req free_req;
> +	struct msg_rsp rsp;
> +	int rc;
> +
> +	if (!free_entry)
> +		return 0;
> +
> +	free_req.hdr.pcifunc = pcifunc;
> +	free_req.entry = mcam_idx;
> +	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
> +	return rc;
> +}

In rvu_npc_free_entry_for_flow_install(), the free_req structure is
declared on the stack without initialization. Only the hdr.pcifunc and
entry fields are explicitly set, leaving the 'all' field uninitialized.

When rvu_mbox_handler_npc_mcam_free_entry() is called, it checks
'if (req->all)' to decide whether to free a single entry or all entries
for the PF/VF. If the uninitialized 'all' field contains non-zero stack
garbage, could this cause the function to incorrectly call
npc_mcam_free_all_entries(), freeing ALL MCAM entries instead of just the
intended single entry?

In the same source file, the function rvu_npc_alloc_entry_for_flow_install()
correctly zero-initializes entry_req and entry_rsp structures using memset.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 052d989f2d9a..23372f30dcc2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

[ ... ]

> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
> +				  u16 *x4_slots)
> +{
> +	struct npc_get_pfl_info_rsp *rsp;
> +	struct msg_req *req;
> +	static struct {
> +		bool is_set;
> +		bool is_x2;
> +		u16 x4_slots;
> +	} pfl_info;
> +
> +	/* Avoid sending mboxes for constant information
> +	 * like x4_slots
> +	 */
> +	if (pfl_info.is_set) {
> +		*is_x2 = pfl_info.is_x2;
> +		*x4_slots = pfl_info.x4_slots;
> +		return 0;
> +	}
> +
> +	mutex_lock(&pfvf->mbox.lock);

In otx2_mcam_pfl_info_get(), the static pfl_info structure is used as a
cache to avoid repeated mailbox queries. However, the cache check at line
54 reads pfl_info.is_set without holding the mutex, while lines 88-90
write to the same static variables with the mutex held.

Could this create a race condition between concurrent threads? For example:

Thread A: Reads pfl_info.is_set (false) at line 54
Thread B: Reads pfl_info.is_set (false) at line 54
Thread A: Acquires mutex, queries AF, writes pfl_info at lines 88-90
Thread B: Acquires mutex, queries AF again (redundant operation)

Or in a scenario with partial reads:

Thread A: Reads pfl_info.is_set (false)
Thread B: Reads pfl_info.is_set (false), starts to read the cache
Thread A: Sets pfl_info.is_set = true at line 90
Thread B: Re-reads and sees is_set==true, reads is_x2 and x4_slots
         (but Thread A may not have finished writing these values)

Would it be safer to perform the cache check inside the mutex?

[ ... ]

> @@ -86,6 +181,22 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>  		return -ENOMEM;
>  	}
>
> +	if (is_cn20k(pfvf->pdev)) {
> +		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
> +		if (rc) {
> +			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
> +			return rc;
> +		}
> +
> +		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
> +		if (rc) {
> +			netdev_err(pfvf->netdev,
> +				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
> +				   pfvf->pcifunc);
> +			return -EFAULT;
> +		}
> +	}

In otx2_alloc_mcam_entries(), when otx2_get_dft_rl_idx() fails, the
function returns -EFAULT. However, otx2_get_dft_rl_idx() can return
-ENOMEM (from otx2_mbox_alloc_msg_npc_get_dft_rl_idxs failure), -EINVAL
(from otx2_sync_mbox_msg failure), or -EFAULT (from IS_ERR(rsp) check).
Should the function return rc instead of hardcoding -EFAULT to preserve
the actual error code?

This is inconsistent with line 188 which correctly returns rc for a
similar error from otx2_mcam_pfl_info_get().

[ ... ]

> @@ -163,8 +287,24 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>  	struct npc_get_field_status_rsp *frsp;
>  	struct npc_mcam_alloc_entry_req *req;
>  	struct npc_mcam_alloc_entry_rsp *rsp;
> -	int vf_vlan_max_flows;
> -	int ent, count;
> +	int vf_vlan_max_flows, count;
> +	int rc, ref, prio, ent;
> +	u16 dft_idx;
> +
> +	ref = 0;
> +	prio = 0;
> +	if (is_cn20k(pfvf->pdev)) {
> +		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
> +		if (rc) {
> +			netdev_err(pfvf->netdev,
> +				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
> +				   pfvf->pcifunc);
> +			return -EFAULT;
> +		}
> +
> +		ref = dft_idx;
> +		prio = NPC_MCAM_HIGHER_PRIO;
> +	}

Same issue in otx2_mcam_entry_init() at line 302. When
otx2_get_dft_rl_idx() fails, the function returns -EFAULT, losing the
actual error code. Should this return rc instead?

[ ... ]

> @@ -973,12 +1168,41 @@ static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
>
>  static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
>  {
> +	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
> +	struct npc_install_flow_req *req, treq = { 0 };
>  	u64 ring_cookie = flow->flow_spec.ring_cookie;
>  #ifdef CONFIG_DCB
>  	int vlan_prio, qidx, pfc_rule = 0;
>  #endif
> -	struct npc_install_flow_req *req;
> -	int err, vf = 0;
> +	int err, vf = 0, off, sz;
> +	bool modify = false;
> +	u8 kw_type = 0;
> +	u8 *src, *dst;
> +	u16 x4_slots;
> +	bool is_x2;
> +
> +	if (is_cn20k(pfvf->pdev)) {
> +		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
> +		if (err) {
> +			netdev_err(pfvf->netdev,
> +				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
> +				   pfvf->pcifunc);
> +			return -EFAULT;
> +		}

This isn't a bug, but the error message at lines 1187-1189 says "Error to
retrieve ucast mcam idx" but the failing function is
otx2_mcam_pfl_info_get(), which retrieves profile information (is_x2 and
x4_slots), not the unicast MCAM index. The unicast MCAM index is retrieved
by otx2_get_dft_rl_idx(). Would it be clearer to say "Error to retrieve
profile info" instead?

[ ... ]

> +static int otx2_get_kw_type(struct otx2_nic *pfvf,
> +			    struct npc_install_flow_req *fl_req,
> +			    u8 *kw_type)
> +{
> +	struct npc_get_num_kws_req *req;
> +	struct npc_get_num_kws_rsp *rsp;
> +	u8 *src, *dst;
> +	int off, err;
> +	int kw_bits;
> +
> +	off = offsetof(struct npc_install_flow_req, packet);
> +
> +	mutex_lock(&pfvf->mbox.lock);
> +
> +	req = otx2_mbox_alloc_msg_npc_get_num_kws(&pfvf->mbox);
> +	if (!req) {
> +		mutex_unlock(&pfvf->mbox.lock);
> +		return -EINVAL;
> +	}

This isn't a bug, but when otx2_mbox_alloc_msg_npc_get_num_kws() fails at
line 1120, the function returns -EINVAL. Memory allocation failures
typically return -ENOMEM per kernel convention. For consistency with line
177 in otx2_alloc_mcam_entries() which returns -ENOMEM for
devm_kmalloc_array failure, should this return -ENOMEM instead of -EINVAL?

