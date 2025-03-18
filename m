Return-Path: <netdev+bounces-175680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABCFA6717D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A299816E054
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666520764C;
	Tue, 18 Mar 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JXo/tZ2a"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20520767B;
	Tue, 18 Mar 2025 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294301; cv=none; b=nB01u+FtMWgWuBJX6FjE+MqGfD4JobcGIn7XZypqcIkuwV4k3Zfm54Imd5RZdmd/M/VSXXCkdByM8nDG/eFMnnUTCJx6/b0qDuZpkwfljZDNjoB5u5uLWQJTdJxmBtYFUJ4V0OpDkmBo5B9bpi5DlZil8TlDjpqtLe6uDqUm/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294301; c=relaxed/simple;
	bh=dWbnvc0H2PWgT6BFD4hK6o3vX/FGROxqJ5QE2fJRf5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccTy29HIUyV7vfcb3sJrTQkkt3GlfKZ+SynfULCLLdQXayeeJMsDC3T0aobz2NyWrRWXT+hBBnEo3DRJVeFnVWQG5StftQ5Kjt6/5ELYWdzaZoJrNvICbeKlW7XCDDP+mhrRH2Rq1MGYYQhXkCXkNT/nEfPHyxAQy7mCNK3C1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JXo/tZ2a; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742294231;
	bh=DXtvf89quNkllBQCcEVDfXSJ4OHfdlN6xu4S0VsBfvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JXo/tZ2az8LE2/NxIsEzgursFMeBEMxzvOQhxYcJKd0siK/gP8X+z3BqxbnoLZtC8
	 a85eAWXJvPa8Jgn0TKDkIkNAsPA8DiXRi57f0IB9QAGWgYWnhJ3A77LTAUfcIeKIe0
	 EiMriVV/pOHX8d6JuQ+blbyIPDV8nDOlvRf4L7Fs=
X-QQ-mid: bizesmtpip2t1742294221tlze8rf
X-QQ-Originating-IP: iB28bNylOBZpWv5JwSEOdDAs5v5oC97lziDKPQVhJLY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 18:36:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5576351486655069133
From: WangYuli <wangyuli@uniontech.com>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	czj2441@163.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH net v3] mlxsw: spectrum_acl_bloom_filter: Workaround for some LLVM versions
Date: Tue, 18 Mar 2025 18:36:54 +0800
Message-ID: <A1858F1D36E653E0+20250318103654.708077-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NXksGzpU7HLR84teKH5ZYaf8Sbh1jBomOiQpjjKwDLim0xIkGzKxLxjg
	EoWHLu+R4ia9cH7pBC4Rpmi/4FRn1lrQHa2MOgUzBFYXMiUiRV6D/csoa/ch1lWHoyEMNWK
	dIaBgi+KZj5rx8fQS73xerEBdnWcpxccwtXJyOoXcM3T03c1xQO8Y6vx79YqWm4DOvwz6Cg
	Sjtu0kTDaRO8IooX/56F6sIaXF2yQQXQgyPikKRwVQaXXt/JYInI3R5Iqx8ukGJFGvBds3J
	GhD02VkkUlOvekm48LQEEofWnyZgTuIQqa9AcX1AxtLw/C0P4V6Dm383pZlUa99wl4NNouh
	TPzpjtLM41NV8udtXva9vDuMz2kF/kNTQG0LeHwVevQapULaAKUx9VJjs1eFn11cvjT4WQP
	fKi9JBbSL3GOUIJEDbyBc8RPxiVjjPs2mAN7eGK1eqlj4TKLjAr/jLRWgl8/3CU2n+nl4Ed
	jotKGLKWL3Wq7o94FPPgDpPt++c22M0B77BSFFbMB1y/9oH29GOViqWbr+OAe7+1NKlc6Ur
	s6c9x4zwcqqyZ/Vc4vcopGzghCWPxde6ZwSvGc5owkZyGWDkxnL954TOrua+q2uOS6OEuXw
	9iWWWC6jOhoXTgsg4jcLyojagLPyG12shR9o7hnZDa4K98RgkAmJQtvXxeW5JR5oYdM7OXJ
	lgGazHjCTI0NnB2AFOn2KV4fNvcJIzwhIoE2YoqIs3fV2vIMQpJXqwRTUokr0wJhSPSZfEO
	sD/L1nyjS6v5Tyd+K6jeAbikmPsYt743x361PO3mgmR5TeFhTSOdXMJur1Rdr8BSGsK1aeN
	Bq6wqSMFOMgMosWUIdAA/GM5Ljez7QHrEKJuFp2coR8MjeYku0S4s5kSIBRJAGDuBugM974
	AaZubY8FSaThbzagU2FB5ACvnXmScI7aJY6eF8jMqT4yxMOnOTWobxHxGIy0vjo8PS4AP83
	VWGcZo09qzio9pPZp3mA1mko3aUw8e8nCv5KQluTX0XZDnLItHPhe9Zx8JvFCOm/utggCyH
	ZlnCZv/P7LlKCEateuvgy7Ue32pNU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

This is a workaround to mitigate a compiler anomaly.

During LLVM toolchain compilation of this driver on s390x architecture, an
unreasonable __write_overflow_field warning occurs.

Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
possibilities, the compile warning is suppressed.

Fix follow error with clang-19 when -Werror:
  In file included from drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c:5:
  In file included from ./include/linux/gfp.h:7:
  In file included from ./include/linux/mmzone.h:8:
  In file included from ./include/linux/spinlock.h:63:
  In file included from ./include/linux/lockdep.h:14:
  In file included from ./include/linux/smp.h:13:
  In file included from ./include/linux/cpumask.h:12:
  In file included from ./include/linux/bitmap.h:13:
  In file included from ./include/linux/string.h:392:
  ./include/linux/fortify-string.h:571:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
    571 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  1 error generated.

According to the testing, we can be fairly certain that this is a clang
compiler bug, impacting only clang-19 and below. Clang versions 20 and
21 do not exhibit this behavior.

Link: https://lore.kernel.org/all/484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com/
Fixes: 7585cacdb978 ("mlxsw: spectrum_acl: Add Bloom filter handling")
Co-developed-by: Zijian Chen <czj2441@163.com>
Signed-off-by: Zijian Chen <czj2441@163.com>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2:
    1. Combine patch #1 and #2 from v1.
    2. Take the more simplified change by Ido Schimmel.
    3. Append more Co-developed-by, Signed-off-by, Tested-by,
Suggested-by and Fixes tags.
    4. Retain reverse Christmas tree order for variables.
  v2->v3:
    1. Fix formatting errors.
---
 .../mlxsw/spectrum_acl_bloom_filter.c         | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..067f0055a55a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -212,7 +212,22 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
  * This array defines key offsets for easy access when copying key blocks from
  * entry key to Bloom filter chunk.
  */
-static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
+static char *
+mlxsw_sp_acl_bf_enc_key_get(struct mlxsw_sp_acl_atcam_entry *aentry,
+			    u8 chunk_index)
+{
+	switch (chunk_index) {
+	case 0:
+		return &aentry->ht_key.enc_key[2];
+	case 1:
+		return &aentry->ht_key.enc_key[20];
+	case 2:
+		return &aentry->ht_key.enc_key[38];
+	default:
+		WARN_ON_ONCE(1);
+		return &aentry->ht_key.enc_key[0];
+	}
+}
 
 static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
 {
@@ -235,9 +250,10 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
-	u8 chunk_index, chunk_count, block_count;
+	u8 chunk_index, chunk_count;
 	char *chunk = output;
 	__be16 erp_region_id;
+	u32 block_count;
 
 	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
 	chunk_count = 1 + ((block_count - 1) >> 2);
@@ -245,12 +261,13 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 				   (aregion->region->id << 4));
 	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
 	     chunk_index++) {
+		char *enc_key;
+
 		memset(chunk, 0, pad_bytes);
 		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
-		memcpy(chunk + key_offset,
-		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
-		       chunk_key_len);
+		enc_key = mlxsw_sp_acl_bf_enc_key_get(aentry, chunk_index);
+		memcpy(chunk + key_offset, enc_key, chunk_key_len);
 		chunk += chunk_len;
 	}
 	*len = chunk_count * chunk_len;
-- 
2.49.0


