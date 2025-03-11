Return-Path: <netdev+bounces-173921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13FA5C3A1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24EF16C291
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFA1C5D61;
	Tue, 11 Mar 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Zbut6KV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E65258;
	Tue, 11 Mar 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702709; cv=none; b=TGVufuNOtxLh7UggNzT59tZIl2redCLG8oJDwASMB3PE8dpkprlfbeJPdld6enaeckt0tyset/SplctR2lQf1MOHzy4D3cvZrzRe/LxHrAPC7VvWrX7eXvDONX6+FSOM7Iz/Vd1Hi9S5s0tTnBZ8eLC1X4MrJRIiNkjKv0A2J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702709; c=relaxed/simple;
	bh=sq1bzv7wPMKFZV9txTevSdGdaM1ayfGv5n8e3oxFAMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+BI8nTVe9gADD/JkyP7Tlo7IQYtMf72/1l92ic6+4c3OsZdSOXh0Qsj2t8UUxI2SwNxl0w1g3yKQ+dxBKhHuC2tvscIa7CDhHOttuyZXL1+qSUSobuQ2A7PDQBhmrRUj6Hua0Mm4RdYltwnGjvsr0ARaHbTzVJjTGL9ZwsO4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Zbut6KV9; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741702643;
	bh=RVYNAhuMeknyi72a5SIFCHR/+FWG+XwIYawU2rgg6Qg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Zbut6KV9tkNncU0/II87cbel9+bARKtWC387gC+P923mTqUHG2EJnGL++sAwmVLJg
	 ZKZ8AxF/aXaDoLWrpdRGx9qV5LYNGuYGiqXT4i3ydbffkMkr5dT1iSf85wRWDuoW6p
	 xu4G6qaaKrygzDSM3SbFkbGwlwKIfa7Xqd5LPJ90=
X-QQ-mid: bizesmtpip3t1741702628typoi2l
X-QQ-Originating-IP: jOgGdtEt8JdK4n+h4lZGMYtkrIpM8o0HEbG+Ct52zcw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 22:17:06 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5424768636451710206
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: andrew+netdev@lunn.ch,
	chenlinxuan@uniontech.com,
	czj2441@163.com,
	davem@davemloft.net,
	edumazet@google.com,
	guanwentao@uniontech.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	niecheng1@uniontech.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	zhanjun@uniontech.com
Subject: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand chunk_key_offsets[chunk_index]
Date: Tue, 11 Mar 2025 22:17:00 +0800
Message-ID: <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OGZxhFXqN7PJ/F3hupnujxi4HZ5kkAX2m7GIaCt0HUvRbvtcuQPisXCW
	cJJnopEoS878cKF5d0G74KKnt+UOsWuLujZrNvn9KtcTJIlNYSn7lsg8oeAKSLPelrZbvyF
	jhPiCADz4l3IJVLL+6k8ChdyWW8mRn0e67TjRy2qw8HJudWldiTbUxLtQ1+QiOXBFiXqXaj
	lKqLMuABlEnCSbeumDYsrj+UqDTy/WXAUhXFD4xZQe19cAqOqhnFAHOnqPIIeINbcjZEzob
	fDgMza89yVBm7VGitXiRGxcPQ3cn4k6461tJ4n4CLKAVo91hAVj0X4RqM3q67vOJdZtKoN6
	xKVyNZ0c47Ab6YUQrrlOyx/SEI8hAMB1/VYK27apE4PWrnmmsKTPj5zA16cY5Bsii/F7gtF
	zqkMmftkGqk0UAtAFsfd3J6+sApZ5+ZXrab0dm8Cad8/mKZTgfENAo9RvenWWr3DwQ4HkOY
	kQ9Gb8Xs711AYPmDwgNcZzOX0Tv96eNQdQOEhb0SU9In/UoFgaqir9huF/fOUVWg6oWAL+X
	DbGABervaMAJZlamBNvBSFO+WvpYj+4zpSfxGW5OMfHYmV5rI/lWchi7kPrIki1wlB25Pz4
	JO3lAp/2BoijUPNuINN35b1r3bh0hYTkqZ7kU4H/S0N0i7YTAc2lAJUmn/3mIeWwqqsLYJ/
	Y/NFVY1RcOKoNAZ8uqiN/U8b5ARJDKjqKvEciR2paFa+iAQnMC3YyVS++8HCt1fRcrdJzQp
	ML3Ax6C82usy5+2K6DVioshDUVvBDX/NwSXl46qS+UWb692SXElrTWtVJ7qPNy8V3ytAHPC
	kGv6/5DWlKcALeVBa3XYCqW33gEaaAaeUrpHybIm4GqOJJjjD6ZgJNo+EKv3u+tLuQYmGk4
	260wGVnCaVHpZitsoXT12RWRCW9x1st5Ee0mcCBz+1wYMrbC0MV/Gojsvz2Zolg11cZH8e/
	hDo21RFL2N2Dn0ox+gVuFxwfR9mcOlXJis6z7NTdRB3O9OelGtupHiSkKeypTXSxp/6pyvp
	jQ2Q8d+oIJgU33+LZ9st93jsgiKKofw8RhlOIXs3uNZH4nA5JOI0k94S2HjowlbGX4gVWGO
	Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Co-developed-by: Zijian Chen <czj2441@163.com>
Signed-off-by: Zijian Chen <czj2441@163.com>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../mlxsw/spectrum_acl_bloom_filter.c         | 39 ++++++++++++-------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..96105bab680b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -203,17 +203,6 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
 0x2f, 0x02, 0x18, 0x35, 0x2c, 0x01, 0x1b, 0x36,
 };
 
-/* Each chunk contains 4 key blocks. Chunk 2 uses key blocks 11-8,
- * and we need to populate it with 4 key blocks copied from the entry encoded
- * key. The original keys layout is same for Spectrum-{2,3,4}.
- * Since the encoded key contains a 2 bytes padding, key block 11 starts at
- * offset 2. block 7 that is used in chunk 1 starts at offset 20 as 4 key blocks
- * take 18 bytes. See 'MLXSW_SP2_AFK_BLOCK_LAYOUT' for more details.
- * This array defines key offsets for easy access when copying key blocks from
- * entry key to Bloom filter chunk.
- */
-static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
-
 static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
 {
 	return (crc << 8) ^ mlxsw_sp2_acl_bf_crc16_tab[(crc >> 8) ^ c];
@@ -237,6 +226,7 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
 	u8 chunk_index, chunk_count, block_count;
 	char *chunk = output;
+	char *enc_key_src_ptr;
 	__be16 erp_region_id;
 
 	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
@@ -248,9 +238,30 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 		memset(chunk, 0, pad_bytes);
 		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
-		memcpy(chunk + key_offset,
-		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
-		       chunk_key_len);
+/* Each chunk contains 4 key blocks. Chunk 2 uses key blocks 11-8,
+ * and we need to populate it with 4 key blocks copied from the entry encoded
+ * key. The original keys layout is same for Spectrum-{2,3,4}.
+ * Since the encoded key contains a 2 bytes padding, key block 11 starts at
+ * offset 2. block 7 that is used in chunk 1 starts at offset 20 as 4 key blocks
+ * take 18 bytes. See 'MLXSW_SP2_AFK_BLOCK_LAYOUT' for more details.
+ * This array defines key offsets for easy access when copying key blocks from
+ * entry key to Bloom filter chunk.
+ *
+ * Define the acceptable values for chunk_index to prevent LLVM from failing
+ * compilation in certain circumstances.
+ */
+		switch (chunk_index) {
+		case 0:
+			enc_key_src_ptr = &aentry->ht_key.enc_key[2];
+			break;
+		case 1:
+			enc_key_src_ptr = &aentry->ht_key.enc_key[20];
+			break;
+		case 2:
+			enc_key_src_ptr = &aentry->ht_key.enc_key[38];
+			break;
+		}
+		memcpy(chunk + key_offset, enc_key_src_ptr, chunk_key_len);
 		chunk += chunk_len;
 	}
 	*len = chunk_count * chunk_len;
-- 
2.47.2


