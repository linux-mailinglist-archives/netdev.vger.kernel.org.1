Return-Path: <netdev+bounces-34165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806677A26BD
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2611C2092B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75C18E0B;
	Fri, 15 Sep 2023 19:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7811726
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF916C4339A;
	Fri, 15 Sep 2023 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694804429;
	bh=MwYH2ME9s5GR5J22JIc9pHMsg8/BLoZqEWB3h/MNKug=;
	h=Date:From:To:Cc:Subject:From;
	b=dc8ehB5SmqvG+DNp8dNDSxMhG6TsX6M2Tx1knthy1ka7AXh1nnnTV+JKs/Ham9X1W
	 3md8hC7WO1cITCN5OrswcKVsh5Fy1W7DIf5Ax8oN5FfaBJ5yZWyR3k9tEURxkhX9ZF
	 qNGNd+NHhuu+6+i4FytLLtQYvu8N7xtCcLFQFfIWMbuR28NGsHHVMMqeU7Z5M+OjOw
	 7HgYmICKCdR35+1RWyxVxRCMOFdSPFz+StmTuRGIBMd2E0SKfLvdGwAL+AtAPECYAo
	 kTi27M/ImM9c0gDUg/Q8A+JdhRNsC1gbUNUaw0o3YyuJkPjVDCUotXiTehzBM32kWj
	 FeCGvVBwtoKhg==
Date: Fri, 15 Sep 2023 13:01:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <ZQSqA80YyLQsnd1L@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If, for any reason, the open-coded arithmetic causes a wraparound, the
protection that `struct_size()` adds against potential integer overflows
is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.

Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index e2aced7ab454..95f63fcf4ba1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -496,7 +496,7 @@ mlxsw_sp_acl_bf_init(struct mlxsw_sp *mlxsw_sp, unsigned int num_erp_banks)
 	 * is 2^ACL_MAX_BF_LOG
 	 */
 	bf_bank_size = 1 << MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_BF_LOG);
-	bf = kzalloc(struct_size(bf, refcnt, bf_bank_size * num_erp_banks),
+	bf = kzalloc(struct_size(bf, refcnt, size_mul(bf_bank_size, num_erp_banks)),
 		     GFP_KERNEL);
 	if (!bf)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1


