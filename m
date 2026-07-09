Return-Path: <netdev+bounces-306145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x8C3B1VxT2pEgwIAu9opvQ
	(envelope-from <netdev+bounces-306145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817A72F408
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="CL/BbG1L";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306145-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306145-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D4C30B9D0C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C182404BCF;
	Thu,  9 Jul 2026 09:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEF405860
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:56:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590989; cv=none; b=IqRMg2BDADEzgRbnXm6u//S+TDKFxPe57mmuQvexD5K6qNFaA3nzpHdCkFEVEI7aQ5NgbHuxKxh6JOKODfDxaDrCmS/pkVpZIBYXGAbYGf5Vhl+4iPOOB9fUz0gApvjK6JOxy2etYFNcN/H+jHrws/oqVGEIrUJxVXu9jFHdMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590989; c=relaxed/simple;
	bh=0lLiOHvM+1jzSNmZF138AXkDxXWVgZsnRJ7laTDWbb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoFhl2bUbMdmzv0io8jJ6Men93zvOzStQNwovFIfONo/7k8Ymfkqz5/B8vbmIzVOmqN3dMA8gaD8JrN/YgDD27bCutv9Ngja5rM4dnIrAp8GqBiLHZjCorZ0xsZI0oRuhpZ51i5bZkk8Hms4r6wgsPhskATj+QSpQydqY7R+cEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL/BbG1L; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783590985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjnFHOpb2bksdqrCcbPAslEOpXP4Sq2lWwqlw5oI6O0=;
	b=CL/BbG1L3fcrE3oT8helgvtRxHgnrO8c4hWaZd6qxBTUV3D6gp+DBSD16yOKtWTTrGCqI2
	M41NJ+c2R2SYlUJzg9XU1RQipGHO3d/1Adz1zn/QQ665LHZNo4oh54m6d3EgtGj104GQpG
	F+Y6Sjgf/pHLiDaUpU9ljXkq7I/Ti6A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-qrCuYYsZPI2IPuHwU8Iybg-1; Thu,
 09 Jul 2026 05:56:21 -0400
X-MC-Unique: qrCuYYsZPI2IPuHwU8Iybg-1
X-Mimecast-MFC-AGG-ID: qrCuYYsZPI2IPuHwU8Iybg_1783590980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0214318052DB;
	Thu,  9 Jul 2026 09:56:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7AD718004D4;
	Thu,  9 Jul 2026 09:56:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v2 net-next 2/9] octeontx2-af: switch: Add switch dev to AF mboxes
Date: Thu,  9 Jul 2026 11:56:12 +0200
Message-ID: <20260709095612.117341-1-pabeni@redhat.com>
In-Reply-To: <20260702045026.2914748-3-rkannoth@marvell.com>
References: <20260702045026.2914748-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-306145-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8817A72F408

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Subject: octeontx2-af: switch: Add switch dev to AF mboxes

This patch introduces a set of new AF mailbox messages so that a
separate Marvell switch device (running its own Linux) can query
interface topology, mcam features, mcam multi-entry stats, and
multi-entry flow delete/free from the AF driver, and adds a stub
swdev2af_notify handler plus two up-direction message definitions.

A few questions on the diff below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 821895a7014e..43ff97441273 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -172,6 +172,10 @@ M(FL_NOTIFY,		0x012,  fl_notify,				\
>  				fl_notify_req, msg_rsp)		\
>  M(FL_GET_STATS,		0x013,  fl_get_stats,				\
>  				fl_get_stats_req, fl_get_stats_rsp)	\
> +M(GET_IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
> +				iface_get_info_rsp)			\

[Low]
The generated enum symbol for this entry becomes
MBOX_MSG_GET_IFACE_GET_INFO, which has a duplicated GET_ prefix and
does not match the handler/struct naming (iface_get_info,
iface_get_info_rsp). Was IFACE_GET_INFO intended here? This enum name
becomes part of the mbox ID namespace once released.

> +M(SWDEV2AF_NOTIFY,	0x015,  swdev2af_notify,		\
> +				swdev2af_notify_req, msg_rsp)		\
>  /* CGX mbox IDs (range 0x200 - 0x3FF) */				\

[ ... ]

> @@ -1587,6 +1607,30 @@ struct npc_mcam_alloc_entry_rsp {
>  	u16 entry_list[NPC_MAX_NONCONTIG_ENTRIES];
>  };
>  
> +struct npc_flow_del_n_free_req {
> +	struct mbox_msghdr hdr;
> +	u16 cnt;
> +	u16 entry[256]; /* Entry index to be freed */
> +};
> +
> +struct npc_mcam_get_features_rsp {
> +	struct mbox_msghdr hdr;
> +	u64 rx_features;
> +	u64 tx_features;
> +};
> +
> +struct npc_mcam_get_mul_stats_req {
> +	struct mbox_msghdr hdr;
> +	int cnt;
> +	u16 entry[256]; /* mcam entry */
> +};
> +
> +struct npc_mcam_get_mul_stats_rsp {
> +	struct mbox_msghdr hdr;
> +	int cnt;
> +	u64 stat[256];  /* counter stats */
> +};

[Low]
Is there a reason cnt is a signed int in both the request and the
response here, when npc_flow_del_n_free_req above uses u16 cnt?

The handler validates via:

    if (!req->cnt || req->cnt > 256) {

which is a signed compare, so a negative req->cnt passes and rsp->cnt
is then assigned from req->cnt.

Any caller (current or future) that treats rsp->cnt as an unsigned
length before iterating rsp->stat[] would go out of bounds. Would a
u16 for both cnt fields be safer?

> +
>  struct npc_mcam_free_entry_req {
>  	struct mbox_msghdr hdr;
>  	u16 entry; /* Entry index to be freed */

[ ... ]

> @@ -1909,6 +1953,83 @@ struct fl_get_stats_rsp {
>  	u64 pkts_diff;
>  };
>  
> +struct af2swdev_notify_req {
> +	struct mbox_msghdr hdr;
> +	u64 flags;
> +	u32 port_id;
> +	u32 switch_id;
> +	union {
> +		struct {
> +			u8 mac[6];
> +		};
> +		struct {
> +			u8 cnt;
> +			struct fib_entry entry[16];
> +		};
> +
> +		struct {
> +			unsigned long cookie;
> +			u64 features;
> +			struct fl_tuple tuple;
> +		};
> +	};
> +};

[Low]
Is unsigned long intentional in a mailbox payload? All other structs
in mbox.h use fixed-width types (u8/u16/u32/u64/__be16). The commit
message notes the switch runs on a separate Linux OS, so if the two
endpoints ever differ in bitness the on-wire size of cookie changes
silently. Same question applies to struct fl_info below. Would u64
be more appropriate?

> +
> +struct af2pf_fdb_refresh_req {
> +	struct mbox_msghdr hdr;
> +	u16 pcifunc;
> +	u8 mac[6];
> +};
> +
> +struct iface_info {
> +	u64 is_vf :1;
> +	u64 is_sdp :1;
> +	u16 pcifunc;
> +	u16 rx_chan_base;
> +	u16 tx_chan_base;
> +	u16 sq_cnt;
> +	u16 cq_cnt;
> +	u16 rq_cnt;
> +	u8 rx_chan_cnt;
> +	u8 tx_chan_cnt;
> +	u8 tx_link;
> +	u8 nix;
> +};

[Low]
Was it intended to place is_vf and is_sdp as bitfields inside a u64
storage unit? That reserves 8 bytes per entry for two bits, and this
struct is embedded IFACE_MAX times in iface_get_info_rsp. Would
u8 is_vf:1; u8 is_sdp:1; work here?

> +
> +#define IFACE_MAX (256 + 32) /* 32 PFs + 256 Vs */
> +
> +struct iface_get_info_rsp {
> +	struct  mbox_msghdr hdr;
> +	int cnt;
> +	struct iface_info info[IFACE_MAX];
> +};

[Medium]
Is IFACE_MAX = 288 sufficient? rvu_hwinfo.total_vfs is a u16 populated
from a 12-bit HW register field, so total VFs can exceed 288 on some
SoCs. The handler silently truncates (goto done) and sets rsp->cnt to
the truncated count with no overflow indication, so the caller cannot
distinguish "all interfaces" from "truncated". This fixed cap also
becomes part of the effective wire layout once released.

> +
> +struct fl_info {
> +	unsigned long cookie;
> +	u16 mcam_idx[2];
> +	u8 dis : 1;
> +	u8 uni_di : 1;
> +};
> +
> +struct swdev2af_notify_req {
> +	struct  mbox_msghdr hdr;
> +	u64 msg_type;
> +#define SWDEV2AF_MSG_TYPE_FW_STATUS BIT_ULL(0)
> +#define	SWDEV2AF_MSG_TYPE_REFRESH_FDB BIT_ULL(1)
> +#define	SWDEV2AF_MSG_TYPE_REFRESH_FL BIT_ULL(2)
> +	u16 pcifunc;
> +	union {
> +		bool fw_up;		// FW_STATUS message
> +
> +		u8 mac[ETH_ALEN];	// fdb refresh message
> +
> +		struct {		// fl refresh message
> +			int cnt;
> +			struct fl_info fl[64];
> +		};
> +	};
> +};

[Low]
Is msg_type meant to be a bitmask or a selector? It is declared u64
with BIT_ULL(0..2) flags, which suggests multiple bits may be set
simultaneously, but the payload is an anonymous union whose members
are mutually exclusive. Would an enum-style tag value (0/1/2) match
the actual semantics better than BIT_ULL()? The choice is baked into
the mailbox ABI once merged.

> +
>  struct flow_msg {
>  	unsigned char dmac[6];
>  	unsigned char smac[6];
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index ffba56ee8a60..6e10a58a0421 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -1990,6 +1990,122 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
>  	return 0;
>  }
>  
> +int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
> +				    struct iface_get_info_rsp *rsp)
> +{
> +	struct iface_info *info;
> +	struct rvu_pfvf *pfvf;
> +	int pf, vf, numvfs;
> +	u16 pcifunc;
> +	int tot = 0;
> +	u64 cfg;
> +
> +	info = rsp->info;
> +	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {

[Medium]
Should this handler filter what it returns based on req->hdr.pcifunc?
As written, it walks every PF and every VF and returns pcifunc,
rx/tx channel base+count, SQ/CQ/RQ counts, tx_link, NIX block and
SDP flag for all of them, with no is_pffunc_af() gate and no
ownership/privilege check.

In multi-tenant SR-IOV where distinct PFs belong to distinct tenants,
a non-privileged PF sending mbox 0x014 would receive the full
resource layout of neighbouring PFs and VFs.

Was this intended to be an AF-only or privileged-caller-only message?

> +		if (tot >= IFACE_MAX)
> +			goto done;
> +

[ ... ]

> +done:
> +	rsp->cnt = tot;
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c7bc0b3a29b9..d797cd05776e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -3544,6 +3544,45 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
>  	return rc;
>  }
>  
> +int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
> +					 struct npc_flow_del_n_free_req *mreq,
> +					 struct msg_rsp *rsp)
> +{
> +	struct npc_mcam_free_entry_req sreq = { 0 };
> +	struct npc_delete_flow_req dreq = { 0 };
> +	struct npc_delete_flow_rsp drsp = { 0 };
> +	bool err = false;
> +	int ret = 0, i;
> +
> +	sreq.hdr.pcifunc = mreq->hdr.pcifunc;
> +	dreq.hdr.pcifunc = mreq->hdr.pcifunc;
> +
> +	if (!mreq->cnt || mreq->cnt > 256) {
> +		dev_err(rvu->dev, "Invalid cnt=%d\n", mreq->cnt);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < mreq->cnt; i++) {
> +		dreq.entry = mreq->entry[i];
> +		ret = rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
> +		if (ret) {
> +			dev_err(rvu->dev, "delete flow error for i=%d entry=%d\n",
> +				i, mreq->entry[i]);
> +			err = true;
> +		}

[Low]
Can this branch ever fire? Looking at rvu_mbox_handler_npc_delete_flow()
in rvu_npc_fs.c, it unconditionally ends with return 0 and logs
per-rule failures via dev_err inside its own loop, so ret here should
always be 0. Is the delete-flow error handling reachable, or is this
dead code that hides failures?

> +
> +		sreq.entry = mreq->entry[i];
> +		ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
> +		if (ret) {
> +			dev_err(rvu->dev, "free entry error for i=%d entry=%d\n",
> +				i, mreq->entry[i]);
> +			err = true;
> +		}
> +	}
> +
> +	return err ? -EINVAL : 0;
> +}
> +

[ ... ]

> @@ -4361,6 +4400,55 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
>  	return 0;
>  }
>  
> +int rvu_mbox_handler_npc_mcam_mul_stats(struct rvu *rvu,
> +					struct npc_mcam_get_mul_stats_req *req,
> +					struct npc_mcam_get_mul_stats_rsp *rsp)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	u16 index, cntr, entry;
> +	int blkaddr;
> +	u64 regval;
> +	u32 bank;
> +
> +	if (!req->cnt || req->cnt > 256) {
> +		dev_err(rvu->dev, "%s invalid request cnt=%d\n",
> +			__func__, req->cnt);
> +		return -EINVAL;
> +	}
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return NPC_MCAM_INVALID_REQ;
> +
> +	mutex_lock(&mcam->lock);
> +
> +	for (int i = 0; i < req->cnt; i++) {
> +		entry = npc_cn20k_vidx2idx(req->entry[i]);
> +
> +		if (npc_mcam_verify_entry(mcam, pcifunc, entry)) {
> +			dev_err(rvu->dev, "%s invalid mcam index=%d\n",
> +				__func__, req->entry[i]);
> +			return -EINVAL;
> +		}

[High]
Does this early return leak mcam->lock? mutex_lock(&mcam->lock) was
taken just above the loop, and this path returns -EINVAL without
calling mutex_unlock().

Since req->entry[i] and req->hdr.pcifunc come from the mailbox, any
PF/VF can send a request containing an entry it does not own or one
that is out of range and permanently wedge mcam->lock. That mutex
serializes all NPC MCAM operations AF-wide, so once leaked, subsequent
allocate/free/read/enable/disable/stats operations from any PF or VF
would block forever.

Neighbouring handlers in this file (npc_mcam_entry_stats,
npc_mcam_free_entry, npc_mcam_read_entry, npc_mcam_dis_entry) unlock
before returning; would a "goto exit" style unlock path work here as
well?

[High]
Should this handler branch on is_cn20k(rvu->pdev) the way
rvu_mbox_handler_npc_mcam_entry_stats() does?

The single-entry stats handler has:

    if (is_cn20k(rvu->pdev)) {
        regval = rvu_read64(rvu, blkaddr,
                            NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index,
                                                               bank));
        rsp->stat_ena = 1;
        rsp->stat = regval;
        ...
        return 0;
    }

The new multi-entry handler skips this and always issues the legacy
STAT_ACT + MATCH_STATX sequence, which does not apply on CN20K
silicon. Would that produce garbage (or unmapped-address) reads on
CN20K?

> +
> +		index = entry & (mcam->banksize - 1);
> +		bank = npc_get_bank(mcam, entry);
> +
> +		/* read MCAM entry STAT_ACT register */
> +		regval = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank));
> +		cntr = regval & 0x1FF;
> +
> +		rsp->stat[i] = rvu_read64(rvu, blkaddr, NPC_AF_MATCH_STATX(cntr));
> +		rsp->stat[i] &= BIT_ULL(48) - 1;

[Medium]
Should this loop also check rvu->hw->npc_stat_ena before deriving cntr
from STAT_ACT[8:0]?

The single-entry handler does:

    if (!(regval & rvu->hw->npc_stat_ena)) {
        rsp->stat_ena = 0;
        mutex_unlock(&mcam->lock);
        return 0;
    }

For entries whose statistics counter is not enabled (a legal state),
this new code will take whatever the low 9 bits happen to be as a
counter index and return MATCH_STATX(random_index) to the caller as
that entry's stat value. Would checking npc_stat_ena per entry be
appropriate here too?

> +	}
> +
> +	rsp->cnt = req->cnt;
> +
> +	mutex_unlock(&mcam->lock);
> +	return 0;
> +}
> +
-- 
This is an AI-generated review.


