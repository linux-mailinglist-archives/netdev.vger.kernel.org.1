Return-Path: <netdev+bounces-231854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38817BFDFF3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A22B74F0204
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B934EEE8;
	Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDCs3Pgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4432B9AD
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160639; cv=none; b=E96vPgLIeW0wM6fiRMN3xgh0pXvf/Xtmnv+kKxShELEYXkZDPDNikxMX6N/tOBtLiSeamHZBrw66ORiY5iX80ucZVXyV3aDF55o6bEzcBJizEFHtxtXCA7xyDKXwdqcqNfxfWe/Ser+KDLPk727Dr5nYthxEqCisLKKEOuKD9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160639; c=relaxed/simple;
	bh=6K0RhjTR32YOwx2oyDrA+kFpfkXCuWHQftsSI6h8mNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrL49wXpFzrKj7VHk/im+qtOuxpKmO3olG0FwAXZRPfIHwdPvTL2KLEtrnacxOOb23kb1mVfqdS6a6eGj8Ev4thJflmixLHx+EJXdeFF7DDSMnywqq5Te8Gm+VGMZ55dY6DJeHBfnpwpkLC18a2PWmAJ7BuxkKZjNXjOOuzo810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDCs3Pgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D4FC4CEFD
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160639;
	bh=6K0RhjTR32YOwx2oyDrA+kFpfkXCuWHQftsSI6h8mNM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vDCs3PgjteNQrQ5tQtMSipdlYJ0vyFKpezrgQh8UofSzJn/HlCCU8p7CWGrDSWmh1
	 6C1iEsqIwQfKom/0xRLiMJCDbjiAG7Lyv8FoQ2vTShEaMk6VFxdTzkK6A51y5wRGLc
	 M5ZMLeWdiAsVuqL4Ul6DxQCDB3aEczQvIXD609hCRAfKn/UCOyIO3w58lzoYxq+htw
	 ofdpMdHRs1d06yTkXuHhIHRtrNYp/2SXwy1IpbzB3I5m31FEqrAP/138rnIXDEdsuy
	 vcSNMQFbrTAeZm4a0Qfowy+dmQSPpKqK2dAkZD4VdmHXiwtduam6ZhKRHB9aDROXQ9
	 qVI+tV3O/0YPA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 06/15] net/rds: new extension header: rdma bytes
Date: Wed, 22 Oct 2025 12:17:06 -0700
Message-ID: <20251022191715.157755-7-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Introduce a new extension header type RDSV3_EXTHDR_RDMA_BYTES for
an RDMA initiator to exchange rdma byte counts to its target.
Currently, RDMA operations cannot precisely account how many bytes a
peer just transferred via RDMA, which limits per-connection statistics
and future policy (e.g., monitoring or rate/cgroup accounting of RDMA
traffic).

In this patch we expand rds_message_add_extension to accept multiple
extensions, and add new flag to RDS header: RDS_FLAG_EXTHDR_EXTENSION,
along with a new extension to RDS header: rds_ext_header_rdma_bytes.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Guangyu Sun <guangyu.sun@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/ib_send.c | 19 +++++++++++++-
 net/rds/message.c | 65 +++++++++++++++++++++++++++++++++++++----------
 net/rds/rds.h     | 24 +++++++++++++----
 net/rds/send.c    |  6 ++---
 4 files changed, 91 insertions(+), 23 deletions(-)

diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index e35bbb6ffb68..3c13cd1d96e2 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -578,10 +578,27 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
 		 * used by the peer to release use-once RDMA MRs. */
 		if (rm->rdma.op_active) {
 			struct rds_ext_header_rdma ext_hdr;
+			struct rds_ext_header_rdma_bytes rdma_bytes_ext_hdr;
 
 			ext_hdr.h_rdma_rkey = cpu_to_be32(rm->rdma.op_rkey);
 			rds_message_add_extension(&rm->m_inc.i_hdr,
-					RDS_EXTHDR_RDMA, &ext_hdr, sizeof(ext_hdr));
+						  RDS_EXTHDR_RDMA, &ext_hdr);
+
+			/* prepare the rdma bytes ext header */
+			rdma_bytes_ext_hdr.h_rflags = rm->rdma.op_write ?
+				RDS_FLAG_RDMA_WR_BYTES : RDS_FLAG_RDMA_RD_BYTES;
+			rdma_bytes_ext_hdr.h_rdma_bytes =
+				cpu_to_be32(rm->rdma.op_bytes);
+
+			if (rds_message_add_extension(&rm->m_inc.i_hdr,
+						      RDS_EXTHDR_RDMA_BYTES,
+						      &rdma_bytes_ext_hdr)) {
+				/* rdma bytes ext header was added succesfully,
+				 * notify the remote side via flag in header
+				 */
+				rm->m_inc.i_hdr.h_flags |=
+					RDS_FLAG_EXTHDR_EXTENSION;
+			}
 		}
 		if (rm->m_rdma_cookie) {
 			rds_message_add_rdma_dest_extension(&rm->m_inc.i_hdr,
diff --git a/net/rds/message.c b/net/rds/message.c
index 199a899a43e9..591a27c9c62f 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -44,6 +44,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_VERSION]	= sizeof(struct rds_ext_header_version),
 [RDS_EXTHDR_RDMA]	= sizeof(struct rds_ext_header_rdma),
 [RDS_EXTHDR_RDMA_DEST]	= sizeof(struct rds_ext_header_rdma_dest),
+[RDS_EXTHDR_RDMA_BYTES] = sizeof(struct rds_ext_header_rdma_bytes),
 [RDS_EXTHDR_NPATHS]	= sizeof(__be16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(__be32),
 };
@@ -191,31 +192,69 @@ void rds_message_populate_header(struct rds_header *hdr, __be16 sport,
 	hdr->h_sport = sport;
 	hdr->h_dport = dport;
 	hdr->h_sequence = cpu_to_be64(seq);
-	hdr->h_exthdr[0] = RDS_EXTHDR_NONE;
+	/* see rds_find_next_ext_space for reason why we memset the
+	 * ext header
+	 */
+	memset(hdr->h_exthdr, RDS_EXTHDR_NONE, RDS_HEADER_EXT_SPACE);
 }
 EXPORT_SYMBOL_GPL(rds_message_populate_header);
 
-int rds_message_add_extension(struct rds_header *hdr, unsigned int type,
-			      const void *data, unsigned int len)
+/*
+ * Find the next place we can add an RDS header extension with
+ * specific length. Extension headers are pushed one after the
+ * other. In the following, the number after the colon is the number
+ * of bytes:
+ *
+ * [ type1:1 dta1:len1 [ type2:1 dta2:len2 ] ... ] RDS_EXTHDR_NONE
+ *
+ * If the extension headers fill the complete extension header space
+ * (16 bytes), the trailing RDS_EXTHDR_NONE is omitted.
+ */
+static int rds_find_next_ext_space(struct rds_header *hdr, unsigned int len,
+				   u8 **ext_start)
 {
-	unsigned int ext_len = sizeof(u8) + len;
-	unsigned char *dst;
+	unsigned int ext_len;
+	unsigned int type;
+	int ind = 0;
+
+	while ((ind + 1 + len) <= RDS_HEADER_EXT_SPACE) {
+		if (hdr->h_exthdr[ind] == RDS_EXTHDR_NONE) {
+			*ext_start = hdr->h_exthdr + ind;
+			return 0;
+		}
 
-	/* For now, refuse to add more than one extension header */
-	if (hdr->h_exthdr[0] != RDS_EXTHDR_NONE)
-		return 0;
+		type = hdr->h_exthdr[ind];
+
+		ext_len = (type < __RDS_EXTHDR_MAX) ? rds_exthdr_size[type] : 0;
+		WARN_ONCE(!ext_len, "Unknown ext hdr type %d\n", type);
+		if (!ext_len)
+			return -EINVAL;
+
+		/* ind points to a valid ext hdr with known length */
+		ind += 1 + ext_len;
+	}
+
+	/* no room for extension */
+	return -ENOSPC;
+}
+
+/* The ext hdr space is prefilled with zero from the kzalloc() */
+int rds_message_add_extension(struct rds_header *hdr,
+			      unsigned int type, const void *data)
+{
+	unsigned char *dst;
+	unsigned int len;
 
-	if (type >= __RDS_EXTHDR_MAX || len != rds_exthdr_size[type])
+	len = (type < __RDS_EXTHDR_MAX) ? rds_exthdr_size[type] : 0;
+	if (!len)
 		return 0;
 
-	if (ext_len >= RDS_HEADER_EXT_SPACE)
+	if (rds_find_next_ext_space(hdr, len, &dst))
 		return 0;
-	dst = hdr->h_exthdr;
 
 	*dst++ = type;
 	memcpy(dst, data, len);
 
-	dst[len] = RDS_EXTHDR_NONE;
 	return 1;
 }
 EXPORT_SYMBOL_GPL(rds_message_add_extension);
@@ -272,7 +311,7 @@ int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 o
 
 	ext_hdr.h_rdma_rkey = cpu_to_be32(r_key);
 	ext_hdr.h_rdma_offset = cpu_to_be32(offset);
-	return rds_message_add_extension(hdr, RDS_EXTHDR_RDMA_DEST, &ext_hdr, sizeof(ext_hdr));
+	return rds_message_add_extension(hdr, RDS_EXTHDR_RDMA_DEST, &ext_hdr);
 }
 EXPORT_SYMBOL_GPL(rds_message_add_rdma_dest_extension);
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 0c3597ca3f48..569a72c2a2a5 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -184,10 +184,11 @@ void rds_conn_net_set(struct rds_connection *conn, struct net *net)
 	write_pnet(&conn->c_net, net);
 }
 
-#define RDS_FLAG_CONG_BITMAP	0x01
-#define RDS_FLAG_ACK_REQUIRED	0x02
-#define RDS_FLAG_RETRANSMITTED	0x04
-#define RDS_MAX_ADV_CREDIT	255
+#define RDS_FLAG_CONG_BITMAP		0x01
+#define RDS_FLAG_ACK_REQUIRED		0x02
+#define RDS_FLAG_RETRANSMITTED		0x04
+#define RDS_FLAG_EXTHDR_EXTENSION	0x20
+#define RDS_MAX_ADV_CREDIT		255
 
 /* RDS_FLAG_PROBE_PORT is the reserved sport used for sending a ping
  * probe to exchange control information before establishing a connection.
@@ -259,6 +260,19 @@ struct rds_ext_header_rdma_dest {
 	__be32			h_rdma_offset;
 };
 
+/*
+ * This extension header tells the peer about delivered RDMA byte count.
+ */
+#define RDS_EXTHDR_RDMA_BYTES	4
+
+struct rds_ext_header_rdma_bytes {
+	__be32		h_rdma_bytes;	/* byte count */
+	u8		h_rflags;	/* direction of RDMA, write or read */
+};
+
+#define RDS_FLAG_RDMA_WR_BYTES	0x01
+#define RDS_FLAG_RDMA_RD_BYTES	0x02
+
 /* Extension header announcing number of paths.
  * Implicit length = 2 bytes.
  */
@@ -871,7 +885,7 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 void rds_message_populate_header(struct rds_header *hdr, __be16 sport,
 				 __be16 dport, u64 seq);
 int rds_message_add_extension(struct rds_header *hdr,
-			      unsigned int type, const void *data, unsigned int len);
+			      unsigned int type, const void *data);
 int rds_message_next_extension(struct rds_header *hdr,
 			       unsigned int *pos, void *buf, unsigned int *buflen);
 int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 offset);
diff --git a/net/rds/send.c b/net/rds/send.c
index 0ff100dcc7f5..f73facfbe5b0 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1458,12 +1458,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 		__be32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
-					  RDS_EXTHDR_NPATHS, &npaths,
-					  sizeof(npaths));
+					  RDS_EXTHDR_NPATHS, &npaths);
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_GEN_NUM,
-					  &my_gen_num,
-					  sizeof(u32));
+					  &my_gen_num);
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
-- 
2.43.0


