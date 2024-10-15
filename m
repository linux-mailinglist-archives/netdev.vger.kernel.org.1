Return-Path: <netdev+bounces-135451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324299DF89
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8644D1C215A5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8561AF4EE;
	Tue, 15 Oct 2024 07:45:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9D1A76D0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978345; cv=none; b=D1k10TspnU7am/iqlfcnLJfdgbcz25CxP8ZEdKnymJnabCsVZ2tw91PiE+yu0fjyWi9ufOgyrD4kr4nQFuSwjOsc32NBMAOvHSQXD/XPUTxprOlqMotTM44wwmqbosxSBhepiUeGq4MTssXFFq+xdIq4b2EFyKACQ5KdMNsSKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978345; c=relaxed/simple;
	bh=1zD9/mHh18lXT+7ttuw1aMX0tptGIaFbMtNjg4M89uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQTZQpO6GMhEVMQIPnkRc+MSrS1xLj/SXqzXuO+mEEoSdkVvy6H6UrIhb+cVIIA585qYgDQ2vrMQu+hH3aAbXv6fvPKEAAPXdIiWoV5nqA1k8NE134Hjv8xjKzrYo+Ow9Ii8bLu+hNQ8oRC/r7Tyy0wUL6SOObeXSfAQzo+kR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2DFFEFAA30;
	Tue, 15 Oct 2024 09:39:49 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Erick Archer <erick.archer@outlook.com>,
	Kees Cook <keescook@chromium.org>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Tue, 15 Oct 2024 09:39:44 +0200
Message-Id: <20241015073946.46613-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073946.46613-1-sw@simonwunderlich.de>
References: <20241015073946.46613-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erick Archer <erick.archer@outlook.com>

The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
trailing elements. Specifically, it uses an array of structures of type
"batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is specifically __counted_by_be since variable
"num_vlan" is of type __be16.

The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:

-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);

+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);

is intended to prevent the compiler from generating an "out-of-bounds"
notification due to the __counted_by attribute. The compiler can do a
pointer calculation using the vlan_data flexible array memory, or in
other words, this may be calculated as an array offset, since it is the
same as:

        &tt_data->vlan_data[num_vlan]

Therefore, we go past the end of the array. In other "multiple trailing
flexible array" situations, this has been solved by addressing from the
base pointer, since the compiler either knows the full allocation size
or it knows nothing about it (this case, since it came from a "void *"
function argument).

The order in which the structure batadv_tvlv_tt_data and the structure
batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
type error.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro and use the "flex_array_size" helper to
clarify some calculations, when possible.

Moreover, the new structure member also allow us to avoid the open-coded
arithmetic on pointers in some situations. Take advantage of this.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h | 29 ++++++++++--------
 net/batman-adv/translation-table.c | 49 ++++++++++++------------------
 2 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..439132a819ea 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -9,6 +9,7 @@
 
 #include <asm/byteorder.h>
 #include <linux/if_ether.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 /**
@@ -592,19 +593,6 @@ struct batadv_tvlv_gateway_data {
 	__be32 bandwidth_up;
 };
 
-/**
- * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
- * @flags: translation table flags (see batadv_tt_data_flags)
- * @ttvn: translation table version number
- * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
- *  one batadv_tvlv_tt_vlan_data object per announced vlan
- */
-struct batadv_tvlv_tt_data {
-	__u8   flags;
-	__u8   ttvn;
-	__be16 num_vlan;
-};
-
 /**
  * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
  *  the tt tvlv container
@@ -618,6 +606,21 @@ struct batadv_tvlv_tt_vlan_data {
 	__u16  reserved;
 };
 
+/**
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
+ * @flags: translation table flags (see batadv_tt_data_flags)
+ * @ttvn: translation table version number
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
+ * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
+ */
+struct batadv_tvlv_tt_data {
+	__u8   flags;
+	__u8   ttvn;
+	__be16 num_vlan;
+	struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
+};
+
 /**
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2243cec18ecc..6815d1262feb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -28,6 +28,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -856,8 +857,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -876,7 +876,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
@@ -936,8 +936,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		total_entries += vlan_entries;
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -956,7 +955,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -2916,7 +2915,6 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 	int i, size;
@@ -2932,7 +2930,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	size = struct_size(tvlv_tt_data, vlan_data, num_vlan);
 	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
@@ -2944,12 +2942,10 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* send all the CRCs within the request. This is needed by intermediate
 	 * nodes to ensure they have the correct table before replying
 	 */
-	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-		tt_vlan_req->vid = tt_vlan->vid;
-		tt_vlan_req->crc = tt_vlan->crc;
+		tvlv_tt_data->vlan_data[i].vid = tt_vlan->vid;
+		tvlv_tt_data->vlan_data[i].crc = tt_vlan->crc;
 
-		tt_vlan_req++;
 		tt_vlan++;
 	}
 
@@ -3001,7 +2997,6 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool ret = false, full_table;
 	u8 orig_ttvn, req_ttvn;
 	u16 tvlv_len;
@@ -3024,10 +3019,9 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_data->vlan_data,
 					ntohs(tt_data->num_vlan)))
 		goto out;
 
@@ -3370,7 +3364,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
-	u16 change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3383,10 +3376,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&orig_node->tt_lock);
 
-	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
-	change_offset *= ntohs(tt_data->num_vlan);
-	change_offset += sizeof(*tt_data);
-	tvlv_ptr += change_offset;
+	tvlv_ptr += struct_size(tt_data, vlan_data, ntohs(tt_data->num_vlan));
 
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
@@ -3985,10 +3975,10 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags, void *tvlv_value,
 					  u16 tvlv_value_len)
 {
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
+	size_t flex_size;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -3998,17 +3988,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < flex_size)
 		return;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);
+	tvlv_value_len -= flex_size;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+	batadv_tt_update_orig(bat_priv, orig, tt_data->vlan_data, num_vlan,
+			      tt_change, num_entries, tt_data->ttvn);
 }
 
 /**
@@ -4039,8 +4030,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
-	tt_vlan_len *= ntohs(tt_data->num_vlan);
+	tt_vlan_len = flex_array_size(tt_data, vlan_data,
+				      ntohs(tt_data->num_vlan));
 
 	if (tvlv_value_len < tt_vlan_len)
 		return NET_RX_SUCCESS;
-- 
2.39.5


