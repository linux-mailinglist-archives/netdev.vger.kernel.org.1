Return-Path: <netdev+bounces-143197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26299C15CD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1290284B6D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97481D1E86;
	Fri,  8 Nov 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WQt70xNE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2D1D12E9;
	Fri,  8 Nov 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041872; cv=none; b=Q/EZwGTnJT2P7RDZ8W4bgNBAcLk0sGSFfKesMj+SXeHTA2/iJTCSfUZP2d1ZwTfyzG1ET/4HggLa6HSkIEWUN6GV19hgbfuOqGQPTvVP29d3aJzA2V8+YJ4WZ/5a2smHfupsWgnhKa9acujcoqVvdArlPeWeC6XMZsJgM5RzmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041872; c=relaxed/simple;
	bh=Dz5n86kURPP7OoYgGSRYHpzSnQC1jtFfeaDJMiUSy8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caJf0VsiML/bIg5TdmeYzDAXnJx9DP5PLlkAnWN5xSAXS9pc5v3b6UnT09sGevojAtWHVhJ/v0Ayr4Or/OskXR0Xz0v0JWOOJNU/AVowdbcCAw6TGuC9AWx982QA4XhX6qMOSUW2vL2Pktk5pDLZFIaQOoWqQ2G6JrPmZjs5/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WQt70xNE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbaKb022658;
	Thu, 7 Nov 2024 20:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	Kpn1407b+Tv9pGNNqEbYJD0oICigfIO++kEhxezVo8=; b=WQt70xNEJQckC0m5s
	ix5gJsrqovh0sq26hUmeP2cmMXOzT8USjG8mweNX9V9eg082WiC5oWaf7l3u4xQ/
	1NysTg/0l7+sUw5FWLIAtUN8uhJy+YEJxBAvFeujFjc7foj9IRy7/NE8FoB1GmYe
	MGkpeGzDVHkvowo2bB7lnBZTQN74/1D2WLbXGiE7uONwPzg4aKO+nXd1A96E9J+L
	+LBDbgzDQP8l3fP4VaGWFZd+gP0t55cwfFOVpPUG/kOWe6tNbCZxs48tuXOHeqzG
	EwiApqMcBSfYhaC3u1Nh/VYChpJmE1kGuHJacQBL1LhrhScPgEYFN1eds71P8AZ3
	dsqXw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu8pf1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:40 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:39 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 14F513F7044;
	Thu,  7 Nov 2024 20:57:34 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 5/8] cn10k-ipsec: Add SA add/del support for outb ipsec crypto offload
Date: Fri, 8 Nov 2024 10:27:05 +0530
Message-ID: <20241108045708.1205994-6-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108045708.1205994-1-bbhushan2@marvell.com>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: diIi-HtE6JvpwO99XlVUKME8vIYW9TRB
X-Proofpoint-GUID: diIi-HtE6JvpwO99XlVUKME8vIYW9TRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patch adds support to add and delete Security Association
(SA) xfrm ops. Hardware maintains SA context in memory allocated
by software. Each SA context is 128 byte aligned and size of
each context is multiple of 128-byte. Add support for transport
and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
128/192/256-bits with 32bit salt.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v8->v9:
 - Previous versions were supporting only 64 SAs and a bitmap was
   used for same. That limitation is removed from this version.
 - Replaced netdev_err with NL_SET_ERR_MSG_MOD in state add flow
   as per comment in previous version 
 - Changes related to mutex lock removal 

v5->v6:
 - In ethtool flow, so not cleanup cptlf if SA are installed and
   call netdev_update_features() when all SA's are un-installed.
 - Description and comment re-word to replace "inline ipsec"
   with "ipsec crypto offload"

v3->v4:
 - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
   Thanks "Leon Romanovsky" for pointing out

v2->v3:
 - Removed memset to zero wherever possible
  (comment from Kalesh Anakkur Purayil)
 - Corrected error handling when setting SA for inbound
   (comment from Kalesh Anakkur Purayil)
 - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
   This fix build error with W=1

 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 415 ++++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       | 113 +++++
 2 files changed, 528 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index e09ce42075c7..ccbcc5001431 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -375,6 +375,391 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
 	return ret;
 }
 
+static void cn10k_cpt_inst_flush(struct otx2_nic *pf, struct cpt_inst_s *inst,
+				 u64 size)
+{
+	struct otx2_lmt_info *lmt_info;
+	u64 val = 0, tar_addr = 0;
+
+	lmt_info = per_cpu_ptr(pf->hw.lmt_info, smp_processor_id());
+	/* FIXME: val[0:10] LMT_ID.
+	 * [12:15] no of LMTST - 1 in the burst.
+	 * [19:63] data size of each LMTST in the burst except first.
+	 */
+	val = (lmt_info->lmt_id & 0x7FF);
+	/* Target address for LMTST flush tells HW how many 128bit
+	 * words are present.
+	 * tar_addr[6:4] size of first LMTST - 1 in units of 128b.
+	 */
+	tar_addr |= pf->ipsec.io_addr | (((size / 16) - 1) & 0x7) << 4;
+	dma_wmb();
+	memcpy((u64 *)lmt_info->lmt_addr, inst, size);
+	cn10k_lmt_flush(val, tar_addr);
+}
+
+static int cn10k_wait_for_cpt_respose(struct otx2_nic *pf,
+				      struct cpt_res_s *res)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10000);
+
+	do {
+		if (time_after(jiffies, timeout)) {
+			netdev_err(pf->netdev, "CPT response timeout\n");
+			return -EBUSY;
+		}
+	} while (res->compcode == CN10K_CPT_COMP_E_NOTDONE);
+
+	if (!(res->compcode == CN10K_CPT_COMP_E_GOOD ||
+	      res->compcode == CN10K_CPT_COMP_E_WARN) || res->uc_compcode) {
+		netdev_err(pf->netdev, "compcode=%x doneint=%x\n",
+			   res->compcode, res->doneint);
+		netdev_err(pf->netdev, "uc_compcode=%x uc_info=%llx esn=%llx\n",
+			   res->uc_compcode, (u64)res->uc_info, res->esn);
+	}
+	return 0;
+}
+
+static int cn10k_outb_write_sa(struct otx2_nic *pf, struct qmem *sa_info)
+{
+	dma_addr_t res_iova, dptr_iova, sa_iova;
+	struct cn10k_tx_sa_s *sa_dptr;
+	struct cpt_inst_s inst = {};
+	struct cpt_res_s *res;
+	u32 sa_size, off;
+	u64 *sptr, *dptr;
+	u64 reg_val;
+	int ret;
+
+	sa_iova = sa_info->iova;
+	if (!sa_iova)
+		return -EINVAL;
+
+	res = dma_alloc_coherent(pf->dev, sizeof(struct cpt_res_s),
+				 &res_iova, GFP_ATOMIC);
+	if (!res)
+		return -ENOMEM;
+
+	sa_size = sizeof(struct cn10k_tx_sa_s);
+	sa_dptr = dma_alloc_coherent(pf->dev, sa_size, &dptr_iova, GFP_ATOMIC);
+	if (!sa_dptr) {
+		dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res,
+				  res_iova);
+		return -ENOMEM;
+	}
+
+	sptr = (__force u64 *)sa_info->base;
+	dptr =  (__force u64 *)sa_dptr;
+	for (off = 0; off < (sa_size / 8); off++)
+		*(dptr + off) = (__force u64)cpu_to_be64(*(sptr + off));
+
+	res->compcode = CN10K_CPT_COMP_E_NOTDONE;
+	inst.res_addr = res_iova;
+	inst.dptr = (u64)dptr_iova;
+	inst.param2 = sa_size >> 3;
+	inst.dlen = sa_size;
+	inst.opcode_major = CN10K_IPSEC_MAJOR_OP_WRITE_SA;
+	inst.opcode_minor = CN10K_IPSEC_MINOR_OP_WRITE_SA;
+	inst.cptr = sa_iova;
+	inst.ctx_val = 1;
+	inst.egrp = CN10K_DEF_CPT_IPSEC_EGRP;
+
+	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
+	dma_wmb();
+	ret = cn10k_wait_for_cpt_respose(pf, res);
+	if (ret)
+		goto out;
+
+	/* Trigger CTX flush to write dirty data back to DRAM */
+	reg_val = FIELD_PREP(CPT_LF_CTX_FLUSH, sa_iova >> 7);
+	otx2_write64(pf, CN10K_CPT_LF_CTX_FLUSH, reg_val);
+
+out:
+	dma_free_coherent(pf->dev, sa_size, sa_dptr, dptr_iova);
+	dma_free_coherent(pf->dev, sizeof(struct cpt_res_s), res, res_iova);
+	return ret;
+}
+
+static int cn10k_ipsec_get_hw_ctx_offset(void)
+{
+	/* Offset on Hardware-context offset in word */
+	return (offsetof(struct cn10k_tx_sa_s, hw_ctx) / sizeof(u64)) & 0x7F;
+}
+
+static int cn10k_ipsec_get_ctx_push_size(void)
+{
+	/* Context push size is round up and in multiple of 8 Byte */
+	return (roundup(offsetof(struct cn10k_tx_sa_s, hw_ctx), 8) / 8) & 0x7F;
+}
+
+static int cn10k_ipsec_get_aes_key_len(int key_len)
+{
+	/* key_len is aes key length in bytes */
+	switch (key_len) {
+	case 16:
+		return CN10K_IPSEC_SA_AES_KEY_LEN_128;
+	case 24:
+		return CN10K_IPSEC_SA_AES_KEY_LEN_192;
+	default:
+		return CN10K_IPSEC_SA_AES_KEY_LEN_256;
+	}
+}
+
+static void cn10k_outb_prepare_sa(struct xfrm_state *x,
+				  struct cn10k_tx_sa_s *sa_entry)
+{
+	int key_len = (x->aead->alg_key_len + 7) / 8;
+	struct net_device *netdev = x->xso.dev;
+	u8 *key = x->aead->alg_key;
+	struct otx2_nic *pf;
+	u32 *tmp_salt;
+	u64 *tmp_key;
+	int idx;
+
+	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
+
+	/* context size, 128 Byte aligned up */
+	pf = netdev_priv(netdev);
+	sa_entry->ctx_size = (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
+	sa_entry->hw_ctx_off = cn10k_ipsec_get_hw_ctx_offset();
+	sa_entry->ctx_push_size = cn10k_ipsec_get_ctx_push_size();
+
+	/* Ucode to skip two words of CPT_CTX_HW_S */
+	sa_entry->ctx_hdr_size = 1;
+
+	/* Allow Atomic operation (AOP) */
+	sa_entry->aop_valid = 1;
+
+	/* Outbound, ESP TRANSPORT/TUNNEL Mode, AES-GCM with */
+	sa_entry->sa_dir = CN10K_IPSEC_SA_DIR_OUTB;
+	sa_entry->ipsec_protocol = CN10K_IPSEC_SA_IPSEC_PROTO_ESP;
+	sa_entry->enc_type = CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM;
+	sa_entry->iv_src = CN10K_IPSEC_SA_IV_SRC_PACKET;
+	if (x->props.mode == XFRM_MODE_TUNNEL)
+		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL;
+	else
+		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT;
+
+	/* Last 4 bytes are salt */
+	key_len -= 4;
+	sa_entry->aes_key_len = cn10k_ipsec_get_aes_key_len(key_len);
+	memcpy(sa_entry->cipher_key, key, key_len);
+	tmp_key = (u64 *)sa_entry->cipher_key;
+
+	for (idx = 0; idx < key_len / 8; idx++)
+		tmp_key[idx] = (__force u64)cpu_to_be64(tmp_key[idx]);
+
+	memcpy(&sa_entry->iv_gcm_salt, key + key_len, 4);
+	tmp_salt = (u32 *)&sa_entry->iv_gcm_salt;
+	*tmp_salt = (__force u32)cpu_to_be32(*tmp_salt);
+
+	/* Write SA context data to memory before enabling */
+	wmb();
+
+	/* Enable SA */
+	sa_entry->sa_valid = 1;
+}
+
+static int cn10k_ipsec_validate_state(struct xfrm_state *x,
+				      struct netlink_ext_ack *extack)
+{
+	if (x->props.aalgo != SADB_AALG_NONE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload authenticated xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.ealgo != SADB_X_EALG_AES_GCM_ICV16) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only AES-GCM-ICV16 xfrm state may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->props.calgo != SADB_X_CALG_NONE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload compressed xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.flags & XFRM_STATE_ESN) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot offload ESN xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.family != AF_INET && x->props.family != AF_INET6) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only IPv4/v6 xfrm states may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload other than crypto-mode\n");
+		return -EINVAL;
+	}
+	if (x->props.mode != XFRM_MODE_TRANSPORT &&
+	    x->props.mode != XFRM_MODE_TUNNEL) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only tunnel/transport xfrm states may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->id.proto != IPPROTO_ESP) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only ESP xfrm state may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->encap) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Encapsulated xfrm state may not be offloaded\n");
+		return -EINVAL;
+	}
+	if (!x->aead) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states without aead\n");
+		return -EINVAL;
+	}
+
+	if (x->aead->alg_icv_len != 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states with AEAD ICV length other than 128bit\n");
+		return -EINVAL;
+	}
+	if (x->aead->alg_key_len != 128 + 32 &&
+	    x->aead->alg_key_len != 192 + 32 &&
+	    x->aead->alg_key_len != 256 + 32) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states with AEAD key length other than 128/192/256bit\n");
+		return -EINVAL;
+	}
+	if (x->tfcpad) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states with tfc padding\n");
+		return -EINVAL;
+	}
+	if (!x->geniv) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states without geniv\n");
+		return -EINVAL;
+	}
+	if (strcmp(x->geniv, "seqiv")) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload xfrm states with geniv other than seqiv\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cn10k_ipsec_inb_add_state(struct xfrm_state *x,
+				     struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "xfrm inbound offload not supported\n");
+	return -EOPNOTSUPP;
+}
+
+static int cn10k_ipsec_outb_add_state(struct xfrm_state *x,
+				      struct netlink_ext_ack *extack)
+{
+	struct net_device *netdev = x->xso.dev;
+	struct cn10k_tx_sa_s *sa_entry;
+	struct qmem *sa_info;
+	struct otx2_nic *pf;
+	int err;
+
+	err = cn10k_ipsec_validate_state(x, extack);
+	if (err)
+		return err;
+
+	pf = netdev_priv(netdev);
+
+	err = qmem_alloc(pf->dev, &sa_info, pf->ipsec.sa_size, OTX2_ALIGN);
+	if (err)
+		return err;
+
+	sa_entry = (struct cn10k_tx_sa_s *)sa_info->base;
+	cn10k_outb_prepare_sa(x, sa_entry);
+
+	if (!cn10k_cpt_device_set_inuse(pf)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "CPT unavailable for IPsec offload\n");
+		err = -EOPNOTSUPP;
+		goto free_sa;
+	}
+
+	err = cn10k_outb_write_sa(pf, sa_info);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Error writing outbound SA\n");
+		goto cpt_state;
+	}
+
+	x->xso.offload_handle = (unsigned long)sa_info;
+	pf->ipsec.outb_sa_count++;
+
+cpt_state:
+	cn10k_cpt_device_set_available(pf);
+free_sa:
+	/* Free SA memory if error */
+	if (err)
+		qmem_free(pf->dev, sa_info);
+	return err;
+}
+
+static int cn10k_ipsec_add_state(struct xfrm_state *x,
+				 struct netlink_ext_ack *extack)
+{
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
+		return cn10k_ipsec_inb_add_state(x, extack);
+	else
+		return cn10k_ipsec_outb_add_state(x, extack);
+}
+
+static void cn10k_ipsec_del_state(struct xfrm_state *x)
+{
+	struct net_device *netdev = x->xso.dev;
+	struct cn10k_tx_sa_s *sa_entry;
+	struct qmem *sa_info;
+	struct otx2_nic *pf;
+	int err;
+
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
+		return;
+
+	pf = netdev_priv(netdev);
+
+	sa_info = (struct qmem *)x->xso.offload_handle;
+	sa_entry = (struct cn10k_tx_sa_s *)sa_info->base;
+	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
+	/* Disable SA in CPT h/w */
+	sa_entry->ctx_push_size = cn10k_ipsec_get_ctx_push_size();
+	sa_entry->ctx_size = (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
+	sa_entry->aop_valid = 1;
+
+	if (cn10k_cpt_device_set_inuse(pf)) {
+		err = cn10k_outb_write_sa(pf, sa_info);
+		if (err)
+			netdev_err(netdev, "Error (%d) deleting SA\n", err);
+		cn10k_cpt_device_set_available(pf);
+	}
+
+	x->xso.offload_handle = 0;
+	qmem_free(pf->dev, sa_info);
+
+	/* If no more SA's then update netdev feature for potential change
+	 * in NETIF_F_HW_ESP.
+	 */
+	if (!--pf->ipsec.outb_sa_count)
+		queue_work(pf->ipsec.sa_workq, &pf->ipsec.sa_work);
+}
+
+static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
+	.xdo_dev_state_add	= cn10k_ipsec_add_state,
+	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
+};
+
+static void cn10k_ipsec_sa_wq_handler(struct work_struct *work)
+{
+	struct cn10k_ipsec *ipsec = container_of(work, struct cn10k_ipsec,
+						 sa_work);
+	struct otx2_nic *pf = container_of(ipsec, struct otx2_nic, ipsec);
+
+	rtnl_lock();
+	netdev_update_features(pf->netdev);
+	rtnl_unlock();
+}
+
 int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
@@ -387,16 +772,41 @@ int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
 	if (enable)
 		return cn10k_outb_cpt_init(netdev);
 
+	/* Don't do CPT cleanup if SA installed */
+	if (pf->ipsec.outb_sa_count) {
+		netdev_err(pf->netdev, "SA installed on this device\n");
+		return -EBUSY;
+	}
+
 	return cn10k_outb_cpt_clean(pf);
 }
 
 int cn10k_ipsec_init(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	u32 sa_size;
 
 	if (!is_dev_support_ipsec_offload(pf->pdev))
 		return 0;
 
+	/* Each SA entry size is 128 Byte round up in size */
+	sa_size = sizeof(struct cn10k_tx_sa_s) % OTX2_ALIGN ?
+			 (sizeof(struct cn10k_tx_sa_s) / OTX2_ALIGN + 1) *
+			 OTX2_ALIGN : sizeof(struct cn10k_tx_sa_s);
+	pf->ipsec.sa_size = sa_size;
+
+	INIT_WORK(&pf->ipsec.sa_work, cn10k_ipsec_sa_wq_handler);
+	pf->ipsec.sa_workq = alloc_workqueue("cn10k_ipsec_sa_workq", 0, 0);
+	if (!pf->ipsec.sa_workq) {
+		netdev_err(pf->netdev, "SA alloc workqueue failed\n");
+		return -ENOMEM;
+	}
+
+	/* Set xfrm device ops
+	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
+	 */
+	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+
 	cn10k_cpt_device_set_unavailable(pf);
 	return 0;
 }
@@ -410,6 +820,11 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
 	if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
 		return;
 
+	if (pf->ipsec.sa_workq) {
+		destroy_workqueue(pf->ipsec.sa_workq);
+		pf->ipsec.sa_workq = NULL;
+	}
+
 	cn10k_outb_cpt_clean(pf);
 }
 EXPORT_SYMBOL(cn10k_ipsec_clean);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index f3eb5aee4b9d..490b75b81234 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -50,6 +50,19 @@
 #define CN10K_CPT_LF_NQX(a)		(CPT_LFBASE | 0x400 | (a) << 3)
 #define CN10K_CPT_LF_CTX_FLUSH		(CPT_LFBASE | 0x510)
 
+/* IPSEC Instruction opcodes */
+#define CN10K_IPSEC_MAJOR_OP_WRITE_SA 0x01UL
+#define CN10K_IPSEC_MINOR_OP_WRITE_SA 0x09UL
+
+enum cn10k_cpt_comp_e {
+	CN10K_CPT_COMP_E_NOTDONE = 0x00,
+	CN10K_CPT_COMP_E_GOOD = 0x01,
+	CN10K_CPT_COMP_E_FAULT = 0x02,
+	CN10K_CPT_COMP_E_HWERR = 0x04,
+	CN10K_CPT_COMP_E_INSTERR = 0x05,
+	CN10K_CPT_COMP_E_WARN = 0x06
+};
+
 struct cn10k_cpt_inst_queue {
 	u8 *vaddr;
 	u8 *real_vaddr;
@@ -69,6 +82,103 @@ struct cn10k_ipsec {
 	u64 io_addr;
 	atomic_t cpt_state;
 	struct cn10k_cpt_inst_queue iq;
+
+	/* SA info */
+	u32 sa_size;
+	u32 outb_sa_count;
+	struct work_struct sa_work;
+	struct workqueue_struct *sa_workq;
+};
+
+/* CN10K IPSEC Security Association (SA) */
+/* SA direction */
+#define CN10K_IPSEC_SA_DIR_INB			0
+#define CN10K_IPSEC_SA_DIR_OUTB			1
+/* SA protocol */
+#define CN10K_IPSEC_SA_IPSEC_PROTO_AH		0
+#define CN10K_IPSEC_SA_IPSEC_PROTO_ESP		1
+/* SA Encryption Type */
+#define CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM	5
+/* SA IPSEC mode Transport/Tunnel */
+#define CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT	0
+#define CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL	1
+/* SA AES Key Length */
+#define CN10K_IPSEC_SA_AES_KEY_LEN_128		1
+#define CN10K_IPSEC_SA_AES_KEY_LEN_192		2
+#define CN10K_IPSEC_SA_AES_KEY_LEN_256		3
+/* IV Source */
+#define CN10K_IPSEC_SA_IV_SRC_COUNTER		0
+#define CN10K_IPSEC_SA_IV_SRC_PACKET		3
+
+struct cn10k_tx_sa_s {
+	u64 esn_en		: 1; /* W0 */
+	u64 rsvd_w0_1_8		: 8;
+	u64 hw_ctx_off		: 7;
+	u64 ctx_id		: 16;
+	u64 rsvd_w0_32_47	: 16;
+	u64 ctx_push_size	: 7;
+	u64 rsvd_w0_55		: 1;
+	u64 ctx_hdr_size	: 2;
+	u64 aop_valid		: 1;
+	u64 rsvd_w0_59		: 1;
+	u64 ctx_size		: 4;
+	u64 w1;			/* W1 */
+	u64 sa_valid		: 1; /* W2 */
+	u64 sa_dir		: 1;
+	u64 rsvd_w2_2_3		: 2;
+	u64 ipsec_mode		: 1;
+	u64 ipsec_protocol	: 1;
+	u64 aes_key_len		: 2;
+	u64 enc_type		: 3;
+	u64 rsvd_w2_11_19	: 9;
+	u64 iv_src		: 2;
+	u64 rsvd_w2_22_31	: 10;
+	u64 rsvd_w2_32_63	: 32;
+	u64 w3;			/* W3 */
+	u8 cipher_key[32];	/* W4 - W7 */
+	u32 rsvd_w8_0_31;	/* W8 : IV */
+	u32 iv_gcm_salt;
+	u64 rsvd_w9_w30[22];	/* W9 - W30 */
+	u64 hw_ctx[6];		/* W31 - W36 */
+};
+
+/* CPT Instruction Structure */
+struct cpt_inst_s {
+	u64 nixtxl		: 3; /* W0 */
+	u64 doneint		: 1;
+	u64 rsvd_w0_4_15	: 12;
+	u64 dat_offset		: 8;
+	u64 ext_param1		: 8;
+	u64 nixtx_offset	: 20;
+	u64 rsvd_w0_52_63	: 12;
+	u64 res_addr;		/* W1 */
+	u64 tag			: 32; /* W2 */
+	u64 tt			: 2;
+	u64 grp			: 10;
+	u64 rsvd_w2_44_47	: 4;
+	u64 rvu_pf_func		: 16;
+	u64 qord		: 1; /* W3 */
+	u64 rsvd_w3_1_2		: 2;
+	u64 wqe_ptr		: 61;
+	u64 dlen		: 16; /* W4 */
+	u64 param2		: 16;
+	u64 param1		: 16;
+	u64 opcode_major	: 8;
+	u64 opcode_minor	: 8;
+	u64 dptr;		/* W5 */
+	u64 rptr;		/* W6 */
+	u64 cptr		: 60; /* W7 */
+	u64 ctx_val		: 1;
+	u64 egrp		: 3;
+};
+
+/* CPT Instruction Result Structure */
+struct cpt_res_s {
+	u64 compcode		: 7; /* W0 */
+	u64 doneint		: 1;
+	u64 uc_compcode		: 8;
+	u64 uc_info		: 48;
+	u64 esn;		/* W1 */
 };
 
 /* CPT LF_INPROG Register */
@@ -86,6 +196,9 @@ struct cn10k_ipsec {
 /* CPT LF_Q_SIZE Register */
 #define CPT_LF_Q_SIZE_DIV40 GENMASK_ULL(14, 0)
 
+/* CPT LF CTX Flush Register */
+#define CPT_LF_CTX_FLUSH GENMASK_ULL(45, 0)
+
 #ifdef CONFIG_XFRM_OFFLOAD
 int cn10k_ipsec_init(struct net_device *netdev);
 void cn10k_ipsec_clean(struct otx2_nic *pf);
-- 
2.34.1


