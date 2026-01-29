Return-Path: <netdev+bounces-254571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IrJH/jsemnC/wEAu9opvQ
	(envelope-from <netdev+bounces-254571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B1ABE0C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84EC43059806
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398702DC76E;
	Thu, 29 Jan 2026 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si3mX+vj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7C25332E;
	Thu, 29 Jan 2026 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663593; cv=none; b=g7Xr3WJ0O1Gv0HRR+07zVQLApAls3mmzWTZDcK4b5j06EQT9yxByUWQePmznujeLqXEdq1heanpJJsnW2sbe0Cp3yPqe4zvdikzI4sEz1KSS9DC9WaIQZIjT/wJEw7TVfujNdp59RpPWaIq8Xt0/NLnLHyE+QROCbk5BM8uClqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663593; c=relaxed/simple;
	bh=G+NlfwUBgakE9GFP/kt8+9HheUg6TSAq9NXWmYcqrgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT5eQ56L/XAKzWDkPC+KIcKFmgydBFAPdSz8zVVfXh55hjrc/Upeyf4oYIUIRuP4Xbl1iSACBrJJRzFjb2t7KuRcZ6+VNpJHbk2kfcgNRL4SS1a5Zwrxbr2vxc8YaAXA0JDcQEdvcrm6WIY2qEiBaH19qUL8tYDyh7H+/etiNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si3mX+vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863BAC19422;
	Thu, 29 Jan 2026 05:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663591;
	bh=G+NlfwUBgakE9GFP/kt8+9HheUg6TSAq9NXWmYcqrgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Si3mX+vj5CP4XiImhIkxeCZnhWwRKwpRUEoz41moMa+ceKJBYizqniST2jrD0LNDB
	 Pe8ifcRzXeKbg2Wy02OKYGkUn1P01KCmDBRXeyVAyA3hOs94vBc8Y+C1qZAd8uEmyh
	 ATnD3tOXgZNEDydXYhI/bApnuwdK2deaThrcQ1MlGmJVKNBvklOLqzNuI7hFUl0i4G
	 KeCb1PkSWmsphFYvL5ns1B+UvOtxAeNKEUY+g2uwECntQa25i4K7q8/QSZAM+lXzpH
	 NnzkA1oDJuhdqSZdzfTWWYvq617iE8IVI6GvJiOv5+NJDslf1cFDcyPXdvHLf3A4H8
	 Tfg19S9tkz5tA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sumang@marvell.com,
	linux-kernel@vger.kernel.org,
	sbhatta@marvell.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	sgoutham@marvell.com
Subject: Re: [net-next,v6,10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
Date: Wed, 28 Jan 2026 21:13:09 -0800
Message-ID: <20260129051309.376665-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-11-rkannoth@marvell.com>
References: <20260128071235.3577206-11-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254571-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D69B1ABE0C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation

This patch extends the install_flow mailbox request message with
additional fields that allow the AF driver to determine the required
NPC MCAM entry type, allocate the entry, and install the flow in a
single step for CN20K.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 82afb4993346..7a48ba1db5e9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1642,6 +1643,75 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	return 0;
>  }
>
> +static int
> +rvu_npc_free_entry_for_flow_install(struct rvu *rvu, u16 pcifunc,
> +				    bool free_entry, int mcam_idx)
> +{

[ ... ]

> +static int
> +rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
> +				     struct npc_install_flow_req *fl_req,
> +				     u16 *mcam_idx, u8 *kw_type,
> +				     bool *allocated)
> +{

[ ... ]

> +	if (!is_cn20k(rvu->pdev))
> +		return 0;
> +
> +	if (!fl_req->alloc_entry)
> +		return 0;

[ ... ]

>  int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  				      struct npc_install_flow_req *req,
>  				      struct npc_install_flow_rsp *rsp)
>  {

[ ... ]

> +	bool allocated = false;
>  	bool enable = true;
> +	u8 kw_type;
>  	u16 target;

[ ... ]

> +	err = rvu_npc_alloc_entry_for_flow_install(rvu, req, &req->entry,
> +						   &kw_type, &allocated);
> +	if (err) {
> +		dev_err(rvu->dev,
> +			"%s: Error to alloc mcam entry for pcifunc=%#x\n",
> +			__func__, req->hdr.pcifunc);
> +		return err;
> +	}

[ ... ]

>  	mutex_lock(&rswitch->switch_lock);
>  	err = npc_install_flow(rvu, blkaddr, target, nixlf, pfvf,
>  			       req, rsp, enable, pf_set_vfs_mac);
> +	if (err)
> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
> +
> +	rsp->kw_type = kw_type;
> +	rsp->entry = req->entry;
            ^^^^^^^^

Is kw_type initialized in all paths here?

When rvu_npc_alloc_entry_for_flow_install() returns early because either
is_cn20k() is false or alloc_entry is not set, kw_type is never written.
The function returns 0 without setting *kw_type, leaving the local variable
uninitialized.

The uninitialized stack value then gets copied to rsp->kw_type.

Should this be initialized to 0 at declaration?

>  	mutex_unlock(&rswitch->switch_lock);
>
>  	return err;
>  }

