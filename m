Return-Path: <netdev+bounces-102875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A31905418
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646721C22CAE
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C017DE06;
	Wed, 12 Jun 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZFK5+nAI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190A17C7C1;
	Wed, 12 Jun 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200040; cv=none; b=PGjEu5f0Evpk4FPjhD1xUszc4AI7UWbu+G9apFx7l3M5XkG2Re6dda0Sm3jaQg9SA6LiMp3Z0dxQE9LvLQNDaoFT4zfDM5ngJOakJ64V74mEqBaAgmGvBa8l7bMOeMa4rNOkK83jSZavO2en3btlPBRiXKsAQ9H2FVE38Ur6lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200040; c=relaxed/simple;
	bh=hDjzquv4KwS7DeqalEjIJ2K5XtrRM0qbp2P6LHywquw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZvVPKs8SYuB2CBGmxSYnonxONa2nsKmbIonrn7yDTzcObXEsVB2xwZNL8pl0nEHg/vqfdkbh00D1Eo6ah16BaTlFHiES0DnOg6wO7tMF0VaTixLZvLXLmwM5Sl9G8Xe9V7m3zEk4EgrshpmRL7I472xuT7CPRC0m4VHV2b6y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZFK5+nAI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C953YM027260;
	Wed, 12 Jun 2024 06:47:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
	HwVyI5z/3/kzB75FVANDrjr/LQYBiIB4M7fZiTVsAs=; b=ZFK5+nAIen8lFBVla
	276FNtBYCCYb+DCGdSa7YPx4hnNCFnU0OfQQpoSqLAkHYaEz1juzoBzJo+pzZvl/
	f9CGkJCRciqLc2vISaT7OOPUlSI2b5NK3M3Y93S2geab5hRB9wIBaV0qzlhpI9+I
	FGa92jnKNnlxRVpPxS8DjzOg48HxFNFUXYNW5wi9QR4MUzoME+UCjZA6YPTKJWns
	LO69IpaaAHIJ7awhrioHrNPR+llHYTSaveinYVxmX8idWNSTWJ7icnNwp+d4ACir
	qAhGInFP+j405RENXKpi4vj1ZKtaXzybIyL+aERkL3mMhPiXL1YY8D6fby53f/40
	XZS5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0u4c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:47:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 06:46:57 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 12 Jun 2024 06:46:52 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v4 5/8] cn10k-ipsec: Add SA add/delete support for outb inline ipsec
Date: Wed, 12 Jun 2024 19:16:19 +0530
Message-ID: <20240612134622.2157086-6-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612134622.2157086-1-bbhushan2@marvell.com>
References: <20240612134622.2157086-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H0l2tER7mhZlaSlK-qSxodVz78OCN4QI
X-Proofpoint-ORIG-GUID: H0l2tER7mhZlaSlK-qSxodVz78OCN4QI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_07,2024-06-12_02,2024-05-17_01

This patch adds support to add and delete Security Association
(SA) xfrm ops. Hardware maintains SA context in memory allocated
by software. Each SA context is 128 byte aligned and size of
each context is multiple of 128-byte. Add support for transport
and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
128/192/256-bits with 32bit salt.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v3->v4:
 - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
   Thanks "Leon Romanovsky" for pointing out
 
v2->v3:
 - Removed memset to zero wherever possible
  (comment from Kalesh Anakkur Purayil)
 - Corrected error hanlding when setting SA for inbound
   (comment from Kalesh Anakkur Purayil)
 - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
   This fix build error with W=1

 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 456 ++++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
 2 files changed, 570 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index fc1029c17c00..892bdbde92ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -336,6 +336,12 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
 	/* Set inline ipsec disabled for this device */
 	pf->flags &= ~OTX2_FLAG_INLINE_IPSEC_ENABLED;
 
+	if (!bitmap_empty(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA)) {
+		netdev_err(pf->netdev, "SA installed on this device\n");
+		mutex_unlock(&pf->ipsec.lock);
+		return -EBUSY;
+	}
+
 	/* Disable CPTLF Instruction Queue (IQ) */
 	cn10k_outb_cptlf_iq_disable(pf);
 
@@ -356,6 +362,434 @@ static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
 	return ret;
 }
 
+static int cn10k_outb_get_sa_index(struct otx2_nic *pf,
+				   struct cn10k_tx_sa_s *sa_entry)
+{
+	u32 sa_size = pf->ipsec.sa_size;
+	int sa_index;
+
+	if (!sa_entry || ((void *)sa_entry < pf->ipsec.outb_sa->base))
+		return -EINVAL;
+
+	sa_index = ((void *)sa_entry - pf->ipsec.outb_sa->base) / sa_size;
+	if (sa_index >= CN10K_IPSEC_OUTB_MAX_SA)
+		return -EINVAL;
+
+	return sa_index;
+}
+
+static dma_addr_t cn10k_outb_get_sa_iova(struct otx2_nic *pf,
+					 struct cn10k_tx_sa_s *sa_entry)
+{
+	int sa_index = cn10k_outb_get_sa_index(pf, sa_entry);
+
+	if (sa_index < 0)
+		return 0;
+	return pf->ipsec.outb_sa->iova + sa_index * pf->ipsec.sa_size;
+}
+
+static struct cn10k_tx_sa_s *cn10k_outb_alloc_sa(struct otx2_nic *pf)
+{
+	u32 sa_size = pf->ipsec.sa_size;
+	struct cn10k_tx_sa_s *sa_entry;
+	u32 sa_index;
+
+	sa_index = find_first_zero_bit(pf->ipsec.sa_bitmap,
+				       CN10K_IPSEC_OUTB_MAX_SA);
+	if (sa_index == CN10K_IPSEC_OUTB_MAX_SA)
+		return NULL;
+
+	set_bit(sa_index, pf->ipsec.sa_bitmap);
+
+	sa_entry = pf->ipsec.outb_sa->base + sa_index * sa_size;
+	return sa_entry;
+}
+
+static void cn10k_outb_free_sa(struct otx2_nic *pf,
+			       struct cn10k_tx_sa_s *sa_entry)
+{
+	int sa_index = cn10k_outb_get_sa_index(pf, sa_entry);
+
+	if (sa_index < 0)
+		return;
+	clear_bit(sa_index, pf->ipsec.sa_bitmap);
+}
+
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
+static int cn10k_outb_write_sa(struct otx2_nic *pf,
+			       struct cn10k_tx_sa_s *sa_cptr)
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
+	sa_iova = cn10k_outb_get_sa_iova(pf, sa_cptr);
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
+	sptr = (__force u64 *)sa_cptr;
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
+	/* Outbound, ESP TRANSPORT/TUNNEL Mode, AES-GCM with AES key length
+	 * 128bit.
+	 */
+	sa_entry->sa_dir = CN10K_IPSEC_SA_DIR_OUTB;
+	sa_entry->ipsec_protocol = CN10K_IPSEC_SA_IPSEC_PROTO_ESP;
+	sa_entry->enc_type = CN10K_IPSEC_SA_ENCAP_TYPE_AES_GCM;
+	if (x->props.mode == XFRM_MODE_TUNNEL)
+		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TUNNEL;
+	else
+		sa_entry->ipsec_mode = CN10K_IPSEC_SA_IPSEC_MODE_TRANSPORT;
+
+	sa_entry->spi = (__force u32)cpu_to_be32((__force u32)x->id.spi);
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
+static int cn10k_ipsec_validate_state(struct xfrm_state *x)
+{
+	struct net_device *netdev = x->xso.dev;
+
+	if (x->props.aalgo != SADB_AALG_NONE) {
+		netdev_err(netdev, "Cannot offload authenticated xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.ealgo != SADB_X_EALG_AES_GCM_ICV16) {
+		netdev_err(netdev, "Only AES-GCM-ICV16 xfrm state may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->props.calgo != SADB_X_CALG_NONE) {
+		netdev_err(netdev, "Cannot offload compressed xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.flags & XFRM_STATE_ESN) {
+		netdev_err(netdev, "Cannot offload ESN xfrm states\n");
+		return -EINVAL;
+	}
+	if (x->props.family != AF_INET && x->props.family != AF_INET6) {
+		netdev_err(netdev, "Only IPv4/v6 xfrm states may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
+		netdev_err(netdev, "Cannot offload other than crypto-mode\n");
+		return -EINVAL;
+	}
+	if (x->props.mode != XFRM_MODE_TRANSPORT &&
+	    x->props.mode != XFRM_MODE_TUNNEL) {
+		dev_info(&netdev->dev, "Only tunnel/transport xfrm states may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->id.proto != IPPROTO_ESP) {
+		netdev_err(netdev, "Only ESP xfrm state may be offloaded\n");
+		return -EINVAL;
+	}
+	if (x->encap) {
+		netdev_err(netdev, "Encapsulated xfrm state may not be offloaded\n");
+		return -EINVAL;
+	}
+	if (!x->aead) {
+		netdev_err(netdev, "Cannot offload xfrm states without aead\n");
+		return -EINVAL;
+	}
+
+	if (x->aead->alg_icv_len != 128) {
+		netdev_err(netdev, "Cannot offload xfrm states with AEAD ICV length other than 128bit\n");
+		return -EINVAL;
+	}
+	if (x->aead->alg_key_len != 128 + 32 &&
+	    x->aead->alg_key_len != 192 + 32 &&
+	    x->aead->alg_key_len != 256 + 32) {
+		netdev_err(netdev, "Cannot offload xfrm states with AEAD key length other than 128/192/256bit\n");
+		return -EINVAL;
+	}
+	if (x->tfcpad) {
+		netdev_err(netdev, "Cannot offload xfrm states with tfc padding\n");
+		return -EINVAL;
+	}
+	if (!x->geniv) {
+		netdev_err(netdev, "Cannot offload xfrm states without geniv\n");
+		return -EINVAL;
+	}
+	if (strcmp(x->geniv, "seqiv")) {
+		netdev_err(netdev, "Cannot offload xfrm states with geniv other than seqiv\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cn10k_ipsec_inb_add_state(struct xfrm_state *x)
+{
+	struct net_device *netdev = x->xso.dev;
+
+	netdev_err(netdev, "xfrm inbound offload not supported\n");
+	return -EOPNOTSUPP;
+}
+
+static int cn10k_ipsec_outb_add_state(struct xfrm_state *x)
+{
+	struct net_device *netdev = x->xso.dev;
+	struct cn10k_tx_sa_s *sa_entry;
+	struct cpt_ctx_info_s *sa_info;
+	struct otx2_nic *pf;
+	int err;
+
+	err = cn10k_ipsec_validate_state(x);
+	if (err)
+		return err;
+
+	pf = netdev_priv(netdev);
+	if (!mutex_trylock(&pf->ipsec.lock)) {
+		netdev_err(netdev, "IPSEC device is busy\n");
+		return -EBUSY;
+	}
+
+	if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
+		netdev_err(netdev, "IPSEC not enabled/supported on device\n");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	sa_entry = cn10k_outb_alloc_sa(pf);
+	if (!sa_entry) {
+		netdev_err(netdev, "SA maximum limit %x reached\n",
+			   CN10K_IPSEC_OUTB_MAX_SA);
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	cn10k_outb_prepare_sa(x, sa_entry);
+
+	err = cn10k_outb_write_sa(pf, sa_entry);
+	if (err) {
+		netdev_err(netdev, "Error writing outbound SA\n");
+		cn10k_outb_free_sa(pf, sa_entry);
+		goto unlock;
+	}
+
+	sa_info = kmalloc(sizeof(*sa_info), GFP_KERNEL);
+	sa_info->sa_entry = sa_entry;
+	sa_info->sa_iova = cn10k_outb_get_sa_iova(pf, sa_entry);
+	x->xso.offload_handle = (unsigned long)sa_info;
+
+unlock:
+	mutex_unlock(&pf->ipsec.lock);
+	return err;
+}
+
+static int cn10k_ipsec_add_state(struct xfrm_state *x,
+				 struct netlink_ext_ack *extack)
+{
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
+		return cn10k_ipsec_inb_add_state(x);
+	else
+		return cn10k_ipsec_outb_add_state(x);
+}
+
+static void cn10k_ipsec_del_state(struct xfrm_state *x)
+{
+	struct net_device *netdev = x->xso.dev;
+	struct cn10k_tx_sa_s *sa_entry;
+	struct cpt_ctx_info_s *sa_info;
+	struct otx2_nic *pf;
+	int sa_index;
+
+	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
+		return;
+
+	pf = netdev_priv(netdev);
+	if (!mutex_trylock(&pf->ipsec.lock)) {
+		netdev_err(netdev, "IPSEC device is busy\n");
+		return;
+	}
+
+	sa_info = (struct cpt_ctx_info_s *)x->xso.offload_handle;
+	sa_entry = sa_info->sa_entry;
+	sa_index = cn10k_outb_get_sa_index(pf, sa_entry);
+	if (sa_index < 0 || !test_bit(sa_index, pf->ipsec.sa_bitmap)) {
+		netdev_err(netdev, "Invalid SA (sa-index %d)\n", sa_index);
+		goto unlock;
+	}
+
+	memset(sa_entry, 0, sizeof(struct cn10k_tx_sa_s));
+
+	/* Disable SA in CPT h/w */
+	sa_entry->ctx_push_size = cn10k_ipsec_get_ctx_push_size();
+	sa_entry->ctx_size = (pf->ipsec.sa_size / OTX2_ALIGN)  & 0xF;
+	sa_entry->aop_valid = 1;
+
+	if (cn10k_outb_write_sa(pf, sa_entry)) {
+		netdev_err(netdev, "Failed to delete sa index %d\n", sa_index);
+		goto unlock;
+	}
+	x->xso.offload_handle = 0;
+	clear_bit(sa_index, pf->ipsec.sa_bitmap);
+	kfree(sa_info);
+unlock:
+	mutex_unlock(&pf->ipsec.lock);
+}
+
+static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
+	.xdo_dev_state_add	= cn10k_ipsec_add_state,
+	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
+};
+
 int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
@@ -374,10 +808,30 @@ int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
 int cn10k_ipsec_init(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	u32 sa_size;
+	int err;
 
 	if (!is_dev_support_inline_ipsec(pf->pdev))
 		return 0;
 
+	/* Each SA entry size is 128 Byte round up in size */
+	sa_size = sizeof(struct cn10k_tx_sa_s) % OTX2_ALIGN ?
+			 (sizeof(struct cn10k_tx_sa_s) / OTX2_ALIGN + 1) *
+			 OTX2_ALIGN : sizeof(struct cn10k_tx_sa_s);
+	err = qmem_alloc(pf->dev, &pf->ipsec.outb_sa, CN10K_IPSEC_OUTB_MAX_SA,
+			 sa_size);
+	if (err)
+		return err;
+
+	pf->ipsec.sa_size = sa_size;
+	memset(pf->ipsec.outb_sa->base, 0, sa_size * CN10K_IPSEC_OUTB_MAX_SA);
+	bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
+
+	/* Set xfrm device ops
+	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
+	 */
+	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+
 	mutex_init(&pf->ipsec.lock);
 	return 0;
 }
@@ -388,6 +842,8 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
 	if (!is_dev_support_inline_ipsec(pf->pdev))
 		return;
 
+	bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
+	qmem_free(pf->dev, pf->ipsec.outb_sa);
 	cn10k_outb_cpt_clean(pf);
 }
 EXPORT_SYMBOL(cn10k_ipsec_clean);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index b322e19d5e23..fbfb6da8dd99 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -50,6 +50,22 @@
 #define CN10K_CPT_LF_NQX(a)		(CPT_LFBASE | 0x400 | (a) << 3)
 #define CN10K_CPT_LF_CTX_FLUSH		(CPT_LFBASE | 0x510)
 
+/* Outbound SA */
+#define CN10K_IPSEC_OUTB_MAX_SA 64
+
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
@@ -64,6 +80,101 @@ struct cn10k_ipsec {
 	/* Lock to protect SA management */
 	struct mutex lock;
 	struct cn10k_cpt_inst_queue iq;
+	/* SA info */
+	struct qmem *outb_sa;
+	u32 sa_size;
+	DECLARE_BITMAP(sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
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
+#define CN10K_IPSEC_SA_AES_KEY_LEN_128 1
+#define CN10K_IPSEC_SA_AES_KEY_LEN_192 2
+#define CN10K_IPSEC_SA_AES_KEY_LEN_256 3
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
+	u64 rsvd_w2_11_31	: 21;
+	u64 spi			: 32;
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
+};
+
+struct cpt_ctx_info_s {
+	struct cn10k_tx_sa_s *sa_entry;
+	dma_addr_t sa_iova;
 };
 
 /* CPT LF_INPROG Register */
@@ -81,6 +192,9 @@ struct cn10k_ipsec {
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


