Return-Path: <netdev+bounces-173922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB90A5C3A3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC7A3A8CFB
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98289256C8C;
	Tue, 11 Mar 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GDziwUc2"
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C995258;
	Tue, 11 Mar 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702728; cv=none; b=nxKMh9CIEfTQ122kq/zRVsrvBcgKvhbsRtmdbeoD6SHExYaHZdRiOpKNVes6w718+5XHCa5iGS94Wuy8gdWrInOIr+LTLziUkjIzlnJYtFF6E/3NhER3ZSWwOD/m/IGrOtKbp/0ihHvZL6CK2DgpHY47389+eULbKcsbaoUw1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702728; c=relaxed/simple;
	bh=wOYjxEZ/0wmOjDYjIIZ/PDKOZ+0BzYlXCetbCEpPVO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFE6jBCmI1OXX3UAM4Okld4nNq7eGUaEChw0FTyJXrsT8I5BfCoP0Gw5YwzxBAfItIkFJ3DUxh6Mfx1xFBb5JY1PLAiJpmhmee+dRKP0ymyqk8Js4fNMXuVAqoeGAlcoVQecdg82OIcIJcxj8SXgF7qIFiBMW8IIfCA+wi60BGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GDziwUc2; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741702650;
	bh=NuLTb6/IZznVNvNlPQ92jV9NmTmPUh3Vr6zv3u8Mkrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GDziwUc2d/DoEdUwKYShyrmlPhPBxVsx5TmNHI95Wuay+XlsZa+A7lfegQAx+jG1u
	 Q9bxzQ3MzWBc6MbF7PLkE/dAE2CWWF+9SbOgr5csGj0H7f3jogjaIuohBEuuvlDIJL
	 jJXRIm6bKXr6AdXzTZEaajyuFQ/HY8lby0RG3ReE=
X-QQ-mid: bizesmtpip3t1741702635trwluo4
X-QQ-Originating-IP: uLe1LkVYOpronyFtP5Q40Qs/2Ik8VmNj44zUrSn5RoM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 22:17:11 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7136192104827494518
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
Subject: [PATCH net 2/2] mlxsw: spectrum_acl_bloom_filter: Type block_count to u32
Date: Tue, 11 Mar 2025 22:17:01 +0800
Message-ID: <994A4354E63E1310+20250311141701.1626533-2-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MUibas7vHviY2UFWBR+OTYPjBbPOSIvO6/gEpzQKCj4CxKffoK/c9tfK
	78tzcUQGl1fU38bxFrqeWfuMWQFLVFCKAZO11FjwdTeEkBthwxyTRxtJmurDIOXSZanbg+z
	dqqNxz+WCxpAdbQpjiQWngIk+htjsWUdwu37Kz80i1MCsWTuTF+/dYZTrdLt4hlUJZYbKLJ
	IbMQrfOh9EAN17oIGzSz4cxn3LzOh3VDs62fgWsDD7pzE9xbuyCsSvCF32sxeUOdlT42KJw
	su9W+72rKLso62XBHm+4b00kT0tDqCXxngqYV7q4oaYgZyhPJ2wcnrv1neHg+LB1SaZdQvL
	ivMCnZkooLeioLcONeQjwSl1VCm+T9fWF5lx4S5rJhFSCG++9m/YgbJhBfp/So9a7s0H001
	9A1uXG4cEbmeBfbJ6IHLlFlNs2Q62xMAyt64JdfzvgJV7j6KDHX4qR3TOCTHkoL31YDXJm/
	HchYNwRuVtnlZmcvEll/UVJIfVqKU6rXSUmGZGvWkSn4R41g3YHK5EqYWEUyM/NgdtnG6ni
	GeWcJ0QHIWO6i4ngbT6N++dwV5Hjs8v02AsOh+SCR1QZaZbXOwxaDrN1QQ/NmpdjhLuCkgM
	0fmYK+zDHPqk89a8k+3v8M4ZOA55ylweeum6iui6A86n2Gj9P0i8CbIP2Lot1TThFj4g0qj
	GnXJQFfu469Q4YcVsraFNTh2RRbqRt08SWQiMQT/T1uKoCZI+ejZKsiPnw3uJhZwU1uHPTL
	Q8ZJ2xQ7y2dhtDxLyZOz3Elqot5yZRFJO/Oyyq020qtTr31KQK30CHImUrMge99Ktrsg/cY
	ePx5GuozqEt3WRHIMAJwcl/7PF1f8KLrXTIcvMnzSvZHocccrnjyl2c/pVXQxyyia8dM6S6
	vb+GRHOuAnca8s5rwFOAGa8+o0IvokByy+fUopAwFveTISN/rsbSFkb7p331NZ9J6oUHie6
	3+aFOlbuVqdSWXhGHi0ILWPmM2/ipLBJP3E7SMUn4OMv3lOHxL+2KTthx/lZy8ugqym6wMP
	7jFdCxPLeymtUsVPuQuNhplcql65uk+NupGPLGej0gbvmJi2+l6EmQC1qX0jxUMv74qQp19
	QeBt7W4RYGml5kW++fwY69IPlkydkBlKw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In light of the fact that block_count is populated by
mlxsw_afk_key_info_blocks_count_get(key_info), whose type is unsigned
int and which returns the blocks_count member (also of type unsigned
int) from the mlxsw_afk_key_info struct, it is illogical to define
block_count as u8.

Co-developed-by: Zijian Chen <czj2441@163.com>
Signed-off-by: Zijian Chen <czj2441@163.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index 96105bab680b..174bfda53985 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -224,7 +224,8 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
-	u8 chunk_index, chunk_count, block_count;
+	u8 chunk_index, chunk_count;
+	u32 block_count;
 	char *chunk = output;
 	char *enc_key_src_ptr;
 	__be16 erp_region_id;
-- 
2.47.2


