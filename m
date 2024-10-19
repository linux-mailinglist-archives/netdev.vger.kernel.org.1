Return-Path: <netdev+bounces-137221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35589A4E51
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B481C21289
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF3224DC;
	Sat, 19 Oct 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lum0RwEj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E72F3E;
	Sat, 19 Oct 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729345155; cv=none; b=IhakxKn0bWvNamk9yfTNZhkDW9wnB164M/UBfE6aw8XK79KJSeVd2PrvOnF7EJxvQusxz1/InONg4y3ztYwhTaXXIcJn4+llqarDpdSSoA1rLku4XEaYCDZuIXj/C9nqo2n6AbbqfjrGDKZGlxqWJoFqMJkNCPjGPITq41oFH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729345155; c=relaxed/simple;
	bh=/wpFDhd5ku8iGLMS+d1td4rDPsUqlNbpikfInoYFxOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx65amtQnW8PDpsEHAWlgB7W/NPBVP0+HHjGDgaM2sUFXFspvvCOmw3Eu7HbaTOr3nyNKLqbxAJI6Y779dervblJRmJYo/uAM/LRjegpO5nGgOAEHnr2qFOU9xc5iWAVJmZ9Ucfk0zVI3gvb5iCsBOGge1Ohtea+5tCMVFyYA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lum0RwEj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so3152925e9.2;
        Sat, 19 Oct 2024 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729345152; x=1729949952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwi9b8+vRyh6RJByQJbF1yVY0zVkfcgsQOyJwNPdlAg=;
        b=lum0RwEj7sSsTW1Ne7V+al9SjLkjupBmp0BZybrMCqCvTiwhZQ+A1130o6TtE2VSSk
         f36QVvM3SdRO3AJ9fOi1zsYpNgN3BLvtU0Lm/bxNYACGEcPg0svukPNC216lpxhwkmra
         254ybaE3mOV/p9+zzdwwiHDpd7Z9rgavX5bMJyXwqJ8Uz6XrvDftfmYT4B9oH2eD2w1O
         twsuV7rnap4ebwtOUfM1n0Kqs2ZgmbBNkyFQBWkdMK7qKw6KIUpCNPjoOW426GBZVhNC
         K/5SBtWiauKnC4gAicdlDizDamikW4NYfnl4t7FHVViNFBW41/0eXN/JYS/PmDIqcKy0
         8/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729345152; x=1729949952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwi9b8+vRyh6RJByQJbF1yVY0zVkfcgsQOyJwNPdlAg=;
        b=RSqo4yEC7Dx4fDX1YdGnBH38L9aIedFCm+DZ24xFszinvAgp9dXIxOZ4KepbLLdRXC
         8O1BJgBQhIhnrMk+Nu8PC0k4faZtM0JrzgmI3PwRjmfTnKlwt8VLKd5pjNH1DIbOKrSC
         BrsiEvRsR0XyF/4weT9+2GOpTWJE2PH3yBOTOPYPZ7IFFM7ST3fBoBdhXxbCFxLcICrX
         tPNqWFEYR1w0laIg9F+m7WBIP78Of8nMQz+bQOyfpgxqOHCU5NpZFjqh/H1bJuorF6PU
         bnZ/2H/cvrHueYyr8ipFGRpGnaH06BtnQKpncMQUGy3aSoMdmpq3K4zP42oyggExtsn9
         yS3A==
X-Forwarded-Encrypted: i=1; AJvYcCU2oevq5izRUqXXuaUd+OCkjmB/6Ts83AJPZMg8aN96bBhyBylRw5qN826s9vISDO5MsE3PbsQxFOfQeYI=@vger.kernel.org, AJvYcCUu8OKQ0WpmeLjvwGW4IDScLPnPWK7nvSLy+yPGOhUBcWSbITdvrTif8C3gbHswQfyFgl08DWAt@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuEtKQ4v0008risZiVdnz6trSJnoMspgy+xgk2azjj3h8pwLj
	HlZi08TRCdmj3Roz4zHZSKDzzMJvcJVlJD2PzMDNyLMsRaUyx3vg
X-Google-Smtp-Source: AGHT+IFS8ktNIvXJv6u6+eUrJkPG7Sbb+KXh4VriiAoLNDeOM8PDZfK0V3Vv1recWjSQqGMt8bObcw==
X-Received: by 2002:a05:600c:3b1e:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-4316168f6dfmr19200265e9.6.1729345151451;
        Sat, 19 Oct 2024 06:39:11 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606c68fbsm55014485e9.30.2024.10.19.06.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:39:10 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:39:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Message-ID: <20241019133908.fy46uasva3tdwtmk@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-5-d9b1f7500740@intel.com>

On Fri, Oct 11, 2024 at 11:48:33AM -0700, Jacob Keller wrote:
> +/**
> + * __ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
> + * @ctx: the Rx queue context to pack
> + * @buf: the HW buffer to pack into
> + * @len: size of the HW buffer
> + *
> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
> + * bit-packed HW layout.
> + */
> +void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
> +{
> +	CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
> +	WARN_ON_ONCE(len < ICE_RXQ_CTX_SZ);

Why not warn on the != condition? The buffer shouldn't be larger, either.

> +
> +	pack_fields(buf, len, ctx, ice_rlan_ctx_fields,
> +		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
> +}
> +/**
> + * __ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
> + * @ctx: the Tx queue context to pack
> + * @buf: the HW buffer to pack into
> + * @len: size of the HW buffer
> + *
> + * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
> + * bit-packed HW layout.
> + */
> +void __ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, void *buf, size_t len)
> +{
> +	CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
> +	WARN_ON_ONCE(len < ICE_TXQ_CTX_SZ);

Same question here.

> +
> +	pack_fields(buf, len, ctx, ice_tlan_ctx_fields,
> +		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
> +}

In fact, I don't know why you don't write the code in a way in which the
_compiler_ will error out if you mess up something in the way that the
arguments are passed, rather than introduce code that warns at runtime?

Something like this:

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1f01f3501d6b..a0ec9c97c2d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -12,6 +12,13 @@
 #define ICE_AQC_TOPO_MAX_LEVEL_NUM	0x9
 #define ICE_AQ_SET_MAC_FRAME_SIZE_MAX	9728
 
+#define ICE_RXQ_CTX_SIZE_DWORDS		8
+#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
+#define ICE_TXQ_CTX_SZ			22
+
+typedef struct __packed { u8 buf[ICE_RXQ_CTX_SZ]; } ice_rxq_ctx_buf_t;
+typedef struct __packed { u8 buf[ICE_TXQ_CTX_SZ]; } ice_txq_ctx_buf_t;
+
 struct ice_aqc_generic {
 	__le32 param0;
 	__le32 param1;
@@ -2067,10 +2074,10 @@ struct ice_aqc_add_txqs_perq {
 	__le16 txq_id;
 	u8 rsvd[2];
 	__le32 q_teid;
-	u8 txq_ctx[22];
+	ice_txq_ctx_buf_t txq_ctx;
 	u8 rsvd2[2];
 	struct ice_aqc_txsched_elem info;
-};
+} __packed;
 
 /* The format of the command buffer for Add Tx LAN Queues (0x0C30)
  * is an array of the following structs. Please note that the length of
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c9b2170a3f5c..f1fbba19e4e4 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -912,7 +912,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
 	/* copy context contents into the qg_buf */
 	qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
-	ice_pack_txq_ctx(&tlan_ctx, qg_buf->txqs[0].txq_ctx);
+	ice_pack_txq_ctx(&tlan_ctx, &qg_buf->txqs[0].txq_ctx);
 
 	/* init queue specific tail reg. It is referred as
 	 * transmit comm scheduler queue doorbell.
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e974290f1801..57a4142a9396 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1363,12 +1363,13 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
  * @rxq_ctx: pointer to the packed Rx queue context
  * @rxq_index: the index of the Rx queue
  */
-static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw, u8 *rxq_ctx,
+static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
+				   const ice_rxq_ctx_buf_t *rxq_ctx,
 				   u32 rxq_index)
 {
 	/* Copy each dword separately to HW */
 	for (int i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
-		u32 ctx = ((u32 *)rxq_ctx)[i];
+		u32 ctx = ((const u32 *)rxq_ctx)[i];
 
 		wr32(hw, QRX_CONTEXT(i, rxq_index), ctx);
 
@@ -1405,20 +1406,20 @@ static const struct packed_field_s ice_rlan_ctx_fields[] = {
 };
 
 /**
- * __ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
+ * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
  * @ctx: the Rx queue context to pack
  * @buf: the HW buffer to pack into
- * @len: size of the HW buffer
  *
  * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
  * bit-packed HW layout.
  */
-void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
+static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
+			     ice_rxq_ctx_buf_t *buf)
 {
 	CHECK_PACKED_FIELDS_20(ice_rlan_ctx_fields, ICE_RXQ_CTX_SZ);
-	WARN_ON_ONCE(len < ICE_RXQ_CTX_SZ);
+	BUILD_BUG_ON(sizeof(*buf) != ICE_RXQ_CTX_SZ);
 
-	pack_fields(buf, len, ctx, ice_rlan_ctx_fields,
+	pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
 		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
 }
 
@@ -1436,14 +1437,13 @@ void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
 {
-	u8 ctx_buf[ICE_RXQ_CTX_SZ] = {};
+	ice_rxq_ctx_buf_t buf = {};
 
 	if (rxq_index > QRX_CTRL_MAX_INDEX)
 		return -EINVAL;
 
-	ice_pack_rxq_ctx(rlan_ctx, ctx_buf);
-
-	ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
+	ice_pack_rxq_ctx(rlan_ctx, &buf);
+	ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
 
 	return 0;
 }
@@ -1481,20 +1481,19 @@ static const struct packed_field_s ice_tlan_ctx_fields[] = {
 };
 
 /**
- * __ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
+ * ice_pack_txq_ctx - Pack Tx queue context into a HW buffer
  * @ctx: the Tx queue context to pack
  * @buf: the HW buffer to pack into
- * @len: size of the HW buffer
  *
  * Pack the Tx queue context from the CPU-friendly unpacked buffer into its
  * bit-packed HW layout.
  */
-void __ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, void *buf, size_t len)
+void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf)
 {
 	CHECK_PACKED_FIELDS_27(ice_tlan_ctx_fields, ICE_TXQ_CTX_SZ);
-	WARN_ON_ONCE(len < ICE_TXQ_CTX_SZ);
+	BUILD_BUG_ON(sizeof(*buf) != ICE_TXQ_CTX_SZ);
 
-	pack_fields(buf, len, ctx, ice_tlan_ctx_fields,
+	pack_fields(buf, sizeof(*buf), ctx, ice_tlan_ctx_fields,
 		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 88d1cebcb3dc..a68bea3934e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -93,14 +93,7 @@ bool ice_check_sq_alive(struct ice_hw *hw, struct ice_ctl_q_info *cq);
 int ice_aq_q_shutdown(struct ice_hw *hw, bool unloading);
 void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode);
 
-void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len);
-void __ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, void *buf, size_t len);
-
-#define ice_pack_rxq_ctx(rlan_ctx, buf) \
-	__ice_pack_rxq_ctx((rlan_ctx), (buf), sizeof(buf))
-
-#define ice_pack_txq_ctx(tlan_ctx, buf) \
-	__ice_pack_txq_ctx((tlan_ctx), (buf), sizeof(buf))
+void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
 
 extern struct mutex ice_global_cfg_lock_sw;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 618cc39bd397..1479b45738af 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -371,8 +371,6 @@ enum ice_rx_flex_desc_status_error_1_bits {
 	ICE_RX_FLEX_DESC_STATUS1_LAST /* this entry must be last!!! */
 };
 
-#define ICE_RXQ_CTX_SIZE_DWORDS		8
-#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
 #define ICE_TX_CMPLTNQ_CTX_SIZE_DWORDS	22
 #define ICE_TX_DRBELL_Q_CTX_SIZE_DWORDS	5
 #define GLTCLAN_CQ_CNTX(i, CQ)		(GLTCLAN_CQ_CNTX0(CQ) + ((i) * 0x0800))
@@ -531,8 +529,6 @@ enum ice_tx_ctx_desc_eipt_offload {
 #define ICE_LAN_TXQ_MAX_QGRPS	127
 #define ICE_LAN_TXQ_MAX_QDIS	1023
 
-#define ICE_TXQ_CTX_SZ		22
-
 /* Tx queue context data */
 struct ice_tlan_ctx {
 #define ICE_TLAN_CTX_BASE_S	7
-- 
2.43.0


