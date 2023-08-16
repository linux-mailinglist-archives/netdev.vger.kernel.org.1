Return-Path: <netdev+bounces-28244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E0377EB7E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100EC281C70
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618D1AA64;
	Wed, 16 Aug 2023 21:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDA1AA61
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:14:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495BEE4F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692220441; x=1723756441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gplscp/XZkhuKoy/2Rvmy5zxnyy+eYc3CmlmBUferVA=;
  b=e5Yc3gQZrOOHAs3iVBDDKPFD3QkCeKE1fkARanLRrbuazo+Q/+rdvYGn
   DtSffoNrDzHXudtf2ZuHELLAuAEVHCF4jnx4AVbx3v24gOqg8zr1Azppg
   J2wLTnCaUiTYQEhzRO4ABKUL9YQXQLAThRjNNZVGZz7kYZiL2nqdVStVq
   GVA9I45dKBpkFn3YgVUUfAfXKk0c8Qbfu6TrU+vrK4t1LAK8R1Rsj6GEb
   yUE9I35GVwemzWqB2eR92Ur6WQVZvdLoSME15WMLcL5f5xb5dTjk+dtH7
   +ATGEmBqzFWWCnr6p+1mBFGwBPHiPhGgfdAWDa+YasRsz1BYdPXDmXkT7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352223490"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="352223490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763765534"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="763765534"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 14:13:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	andriy.shevchenko@linux.intel.com,
	larysa.zaremba@intel.com,
	keescook@chromium.org,
	gustavoars@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` - 1
Date: Wed, 16 Aug 2023 14:06:55 -0700
Message-Id: <20230816210657.1326772-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
References: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Lobakin <aleksander.lobakin@intel.com>

The two most problematic virtchnl structures are virtchnl_rss_key and
virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
allocating / checking, the actual size is calculated as `sizeof +
nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
of such structure with proper flex array, it's two bytes larger due to
the padding. That said, their size is always 1 byte larger unless
there are no tail elements -- then it's +2 bytes.
Add virtchnl_struct_size() macro which will handle this case (and later
other cases as well). Make its calling conv the same as we call
struct_size() to allow it to be drop-in, even though it's unlikely to
become possible to switch to generic API. The macro will calculate a
proper size of a structure with a flex array at the end, so that it
becomes transparent for the compilers, but add the difference from the
old values, so that the real size of sorta-ABI-messages doesn't change.
Use it on the allocation side in IAVF and the receiving side (defined
as static inline in virtchnl.h) for the mentioned two structures.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  6 ++--
 include/linux/avf/virtchnl.h                  | 31 ++++++++++++++-----
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index be3c007ce90a..10f03054a603 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1085,8 +1085,7 @@ void iavf_set_rss_key(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	len = sizeof(struct virtchnl_rss_key) +
-	      (adapter->rss_key_size * sizeof(u8)) - 1;
+	len = virtchnl_struct_size(vrk, key, adapter->rss_key_size);
 	vrk = kzalloc(len, GFP_KERNEL);
 	if (!vrk)
 		return;
@@ -1117,8 +1116,7 @@ void iavf_set_rss_lut(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	len = sizeof(struct virtchnl_rss_lut) +
-	      (adapter->rss_lut_size * sizeof(u8)) - 1;
+	len = virtchnl_struct_size(vrl, lut, adapter->rss_lut_size);
 	vrl = kzalloc(len, GFP_KERNEL);
 	if (!vrl)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index c15221dcb75e..3ab207c14809 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -866,18 +866,20 @@ VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_promisc_info);
 struct virtchnl_rss_key {
 	u16 vsi_id;
 	u16 key_len;
-	u8 key[1];         /* RSS hash key, packed bytes */
+	u8 key[];          /* RSS hash key, packed bytes */
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_key);
+#define virtchnl_rss_key_LEGACY_SIZEOF	6
 
 struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
-	u8 lut[1];        /* RSS lookup table */
+	u8 lut[];         /* RSS lookup table */
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_lut);
+#define virtchnl_rss_lut_LEGACY_SIZEOF	6
 
 /* VIRTCHNL_OP_GET_RSS_HENA_CAPS
  * VIRTCHNL_OP_SET_RSS_HENA
@@ -1367,6 +1369,17 @@ struct virtchnl_fdir_del {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 
+#define __vss_byone(p, member, count, old)				      \
+	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
+
+#define __vss(type, func, p, member, count)		\
+	struct type: func(p, member, count, type##_LEGACY_SIZEOF)
+
+#define virtchnl_struct_size(p, m, c)					      \
+	_Generic(*p,							      \
+		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
+		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
+
 /**
  * virtchnl_vc_validate_vf_msg
  * @ver: Virtchnl version info
@@ -1479,19 +1492,21 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_KEY:
-		valid_len = sizeof(struct virtchnl_rss_key);
+		valid_len = virtchnl_rss_key_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_key *vrk =
 				(struct virtchnl_rss_key *)msg;
-			valid_len += vrk->key_len - 1;
+			valid_len = virtchnl_struct_size(vrk, key,
+							 vrk->key_len);
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_LUT:
-		valid_len = sizeof(struct virtchnl_rss_lut);
+		valid_len = virtchnl_rss_lut_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_lut *vrl =
 				(struct virtchnl_rss_lut *)msg;
-			valid_len += vrl->lut_entries - 1;
+			valid_len = virtchnl_struct_size(vrl, lut,
+							 vrl->lut_entries);
 		}
 		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-- 
2.38.1


