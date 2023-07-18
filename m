Return-Path: <netdev+bounces-18577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEF757C84
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A7628123D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902CD529;
	Tue, 18 Jul 2023 12:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3ABD513
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0484EC433C7;
	Tue, 18 Jul 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685196;
	bh=GKaoOTrRRgm3th2yeQunqYwl7QvKD9b4yz/UgiWU3NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5dvqAwNacmP9ofhTkW3T21chYyCqFIyw+EZKp42wVyn1aBnT5CMtykmkhXPBNAq/
	 dGkTWQjllhBsahtnxuWrT87+tMg5Aj23IVinvMXW8KOejUf8GgnDVVVmMVKVvh2QtE
	 R0+XyqV+Xe9Ab43eG/9cXVw4nBOiwYdiyBav7XTJ2PoskZrgMQQ8fTOZMOsQtUA1NO
	 yIPJjP9XtCxFVuinva0jPVu4cDhNmqsnTt8xiABPoaB0ZVmS+o/RqHoyAe5Fplb5Us
	 e4ZptUjNImOL1KKyHCWo/EJNvdPApIHEdnjfzLoE3LCknGqVwsN0292H46WRVCLqVX
	 ANtj4BazzH8OQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Haren Myneni <haren@us.ibm.com>,
	Nick Terrell <terrelln@fb.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Richard Weinberger <richard@nod.at>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	qat-linux@intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 06/21] ubifs: Avoid allocating buffer space unnecessarily
Date: Tue, 18 Jul 2023 14:58:32 +0200
Message-Id: <20230718125847.3869700-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=ardb@kernel.org; h=from:subject; bh=GKaoOTrRRgm3th2yeQunqYwl7QvKD9b4yz/UgiWU3NQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbTwlX6/4+66t8K795H8qq3nyxPGW6+prOkJjeOC3pB VKTDl7pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMJ38fIcIktU2XVksXxPvnz 7ZMjji6vymHbt3vhb8tlaW3L36gWdjAy/KlaojvPzyKk+4acZfHypV+1GfmK5ggkHxKI0X7uaXa XGwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The recompression scratch buffer is only used when the data node is
compressed, and there is no need to allocate it otherwise. So move the
allocation into the branch of the if() that actually makes use of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/ubifs/journal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4e5961878f336033..5ce618f82aed201b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1485,16 +1485,9 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 			      unsigned int block, struct ubifs_data_node *dn,
 			      int *new_len, int dn_size)
 {
-	void *buf;
+	void *buf = NULL;
 	int err, dlen, compr_type, out_len, data_size;
 
-	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
-	if (!buf)
-		return -ENOMEM;
-
-	out_len *= WORST_COMPR_FACTOR;
-
 	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
 	data_size = dn_size - UBIFS_DATA_NODE_SZ;
 	compr_type = le16_to_cpu(dn->compr_type);
@@ -1508,6 +1501,13 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 	if (compr_type == UBIFS_COMPR_NONE) {
 		out_len = *new_len;
 	} else {
+		out_len = le32_to_cpu(dn->size);
+		buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+		if (!buf)
+			return -ENOMEM;
+
+		out_len *= WORST_COMPR_FACTOR;
+
 		err = ubifs_decompress(c, &dn->data, dlen, buf, &out_len, compr_type);
 		if (err)
 			goto out;
-- 
2.39.2


