Return-Path: <netdev+bounces-175600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341DA669D7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5967A104A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482D1991CF;
	Tue, 18 Mar 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bGWJTMML"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E391581EE;
	Tue, 18 Mar 2025 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277018; cv=none; b=DmdjFN12pe63YtY4Hu86rxQ+aiMn+/xyLBniXN9bA8uMxHzlg5NFdlz9AxvlBYYQpzR9b8DJCkgcwnbOrSrzuNqrMRUESnLn58ePZh1n2HRVAgLBmhGOTsTqQ5NoEA1fqhqQ3YzfP3xF3/aEEMxiug9XWX4k+GVDyONEnTP0Qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277018; c=relaxed/simple;
	bh=pvu8Dy/VXpfCbsU1wxKIDJov4xBbmkpNoQHZ+cN+CpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9EvBASdV2/vn5Nj9/IcqSkob1MUjbWD80dElLwxGDGWB78WPXAwJFW2HIu/sX0pfHv4Ub6feZtJA4aDxDjPyia6t+gdVC0p2GCqXAIe4bZh83Q3hMusllhFOngnaRHfAIMvL9dGaee4VUE7FEm5tKN0pps5ENHDO/x16DEQv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bGWJTMML; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742276905;
	bh=gnxCvj2Q4txIQOV5P4Py/Ax9TpGa8Qqrm59V7rorQes=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bGWJTMMLo1vPiblbg8wA/YzaBkh1qg/4v9XjtUjF8i2JbvM0xXwVB7GOZJE+ACXmu
	 mKKfTtq492sSMuWqdQ+KW7Mq0sXO91kXW/V4aQbK7wyvqMZ+WHtsMqZwvv+b1JScIv
	 y7KGeyCJc2me9ZFNT5p/5iJ5aFdQeBlXYo+qvyh8=
X-QQ-mid: bizesmtpip2t1742276892tccjh2r
X-QQ-Originating-IP: nU1X2tnth8q/r2x9zmTdbfutXO0tdYJJftZxAw3Ni3k=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 13:48:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4937968447994938010
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
Subject: [PATCH net v2] mlxsw: spectrum_acl_bloom_filter: Workaround for some LLVM versions
Date: Tue, 18 Mar 2025 13:48:03 +0800
Message-ID: <CBD5806B120ADEEE+20250318054803.462085-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MDqtQ4jGWXAGGkXhdGOheQd0DQb8GmA4pV+NZKf2C0W+B7whEvAuecxh
	Ubc5P5Uaiguc+F72RWQYas6HsJq+/7WZPGamkXvZpv8nWptiwBEz9VFWdPLgqfY32iwgVES
	GDahTSNRl7LryVYgTanaGdbbOcPtHQEt6Gr+2HHcLHG7+73fSxe7dP8aNIbsn7kVjdNr3S/
	gV7UvLuDyxzQUtnhypi1mjd1auJmRlIcKZBblwsDpxhkt9aDrDjIM1VzNj+elLIQ3ThLvLB
	22akizcolK0pM/0eY4+2Nh2v+hGV6ISffuojtjU/5UtpdHOb+byF9i68LNL4XOo3tNf5AF1
	9nzS/f/VqQ/Yff8ucL5iqZkkl8ABy2aCiYz6m0nIHhANDHvqQlRHLDXGVa+whATMTHPmh3L
	uVS/dZ3RH1UBbhwUg2X8c962/JUTJ3tb94O0TBYgIkWXK156LTU2ZFgJyGQlwc7Nznc7cPJ
	kKU/m4vYcz8nd9hIkdbtqLLBgtUCpN0JqtUk2kAB7VSrZ5Bsul9gBS9bne3DD0AVtKhxORu
	TztH7KtJ02zxCmqPG9UvF58lwpvgZIWQD1SqmE/Otu2aaJLf8U3HbcsUCMRGgb7g8eZNMPT
	A6JOV7veqywL3nqcJhWSYcW1EY1rv5KHNe7OWKly9QRDQvTRKbDGZgkqOJmKRbgmb0tUO++
	IAB7uo4McQCnYiCz9G1fXAe7ph45UcpjZSsQNPK5W5BL1m00VxEVSqpXUnhRNPXpVHO29ul
	dzZ24Kiej3RSf2NcGUpN95euDZrlXC5KzkvYcsHPZ/nuIGN9HjZbg2lTSs0oy6sNl9B6UjZ
	Wbns06zI1nWCV/hCqzqQuIPmgwjJHJG6mei05hxPxyNDo2oa/5HUfXd3darjyEnE8fQbI+O
	6POH7DqMT3p3DByKaVDhKRbpsqJVMKItrJ7erlJ3wdMQlwDASpWoGcBkudh+x2bP/zSI0OV
	z1Ajfqd5HpHiLO5MAjYDK345Vsp+0YzYF8EL/yqJ4hHIelK3hq/LdWbdfT0gjRYjgPA4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
---
 .../mlxsw/spectrum_acl_bloom_filter.c         | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..fc8a8cf64ec8 100644
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
+		switch (chunk_index) {
+		case 0:
+			return &aentry->ht_key.enc_key[2];
+		case 1:
+			return &aentry->ht_key.enc_key[20];
+		case 2:
+			return &aentry->ht_key.enc_key[38];
+		default:
+			WARN_ON_ONCE(1);
+			return &aentry->ht_key.enc_key[0];
+		}
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
@@ -245,12 +261,12 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 				   (aregion->region->id << 4));
 	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
 	     chunk_index++) {
+		char *enc_key;
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


