Return-Path: <netdev+bounces-18576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F1757C80
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FED1C20CF8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB57D2F0;
	Tue, 18 Jul 2023 12:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4593D513
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D366C433CA;
	Tue, 18 Jul 2023 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685191;
	bh=ODoi2e+vcqIb799pflsdMhm1nGdkubtWgbUegajrVfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDalzP/YaXdnw/eO5FhMttHT+uo4cUQ0HEfzV/eVDhjrh2vL2AqqxXcAqh13yqJn4
	 AVbM5TSLu3q0pr2cIE2wClirkeGHzrnHwdeCo5pdmULzTvNEpku6b70jtE1ArlykWc
	 iaLRyhhRjQiHzGqDFnFYCpXBS8sZnvAGylTxo/SCUEVIt3zDITwUPYFYeNX441iuA5
	 UPvKWFmqWGmWjFjxj3GAvUxK0AMTKP3bw+ZiMK2blBchprVp/PM9vi8CkYksqH9lwv
	 0KW/Y7eXnjmHRBPOokrRrf/vKW7znD2how5Rm7j4/YU0ipme/NjIaZ8mn9lIi/NwrT
	 dtMt3ZU+yjBpQ==
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
Subject: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to compression routines
Date: Tue, 18 Jul 2023 14:58:31 +0200
Message-Id: <20230718125847.3869700-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=ardb@kernel.org; h=from:subject; bh=ODoi2e+vcqIb799pflsdMhm1nGdkubtWgbUegajrVfU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT9FzF2aeyo1FL46LhUf9emTqUM1q5dWwJ2Dzr1cTG sRaswQ7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETqRRgZriduT8+o3D0pY5fL upjHTB/UclQ3ycjOPOLy0+e+sqX/b4Z/Wgf3MzUs1I/L09XztZ/lvWNdMcPstI16pS5bDvIdeTO NGwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Currently, the ubifs code allocates a worst case buffer size to
recompress a data node, but does not pass the size of that buffer to the
compression code. This means that the compression code will never use
the additional space, and might fail spuriously due to lack of space.

So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
buffer. Doing so is guaranteed not to overflow, given that the preceding
kmalloc_array() call would have failed otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/ubifs/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index dc52ac0f4a345f30..4e5961878f336033 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 	if (!buf)
 		return -ENOMEM;
 
+	out_len *= WORST_COMPR_FACTOR;
+
 	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
 	data_size = dn_size - UBIFS_DATA_NODE_SZ;
 	compr_type = le16_to_cpu(dn->compr_type);
-- 
2.39.2


