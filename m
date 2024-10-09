Return-Path: <netdev+bounces-133580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9C9965AA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A740281E49
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8918A6CD;
	Wed,  9 Oct 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amvQUf2b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752D487AE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466826; cv=none; b=Tdvc6mgjEQ/xU7nxh8x1h510Y8y2Ib3exbNDZ93ohjLuYhcRNGPzB8l2PUr8md5bDwbX+/sdqjYvtPFYUwTDAh7yfCv2RUAR/d1gZ7ukGvC0nKn0vPXQSKf3DXcpQeCzGylekePtr4ZkO7debj4IXbMbNpeGpXLZxe1Os6kqGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466826; c=relaxed/simple;
	bh=Zy4CcVrcNUHs7N7hZzh7ip+FcbJ5330PVdTK3C9ztc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KUlODVTqiRUdEoY1SP04ms0DpFpClfxDY7475dIaAM6pLJSSWC+1my48DcCsOcRC/Ch11h2XxXjAtYuhlslCtoyX8TCAOqyMrV6JIUnJ6R8x6ZspziVtqn1+veyXXM7YfDK9MH2RhDmRLLWMQpZpj4WvjuZHNaxwEyMB5bKGhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amvQUf2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D1C4CEC5;
	Wed,  9 Oct 2024 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728466825;
	bh=Zy4CcVrcNUHs7N7hZzh7ip+FcbJ5330PVdTK3C9ztc8=;
	h=From:Date:Subject:To:Cc:From;
	b=amvQUf2bGQobyvjeEoQo10NbuPzFT/Mkrbehkcs2Ddj0aN75mmK3lTeUPwWcheItX
	 zfLuf5/aE7DsKkRuxCOa65FxvNnB3V3AXAuEqzP6g+WglMohh6uKqP1EWAnK4X7E4R
	 qhORW7Z5CCxRtyGibs/HsXK6iT047yCGnCv1yj5DM3Z2CHjpZGRc+Vhxk+8v2iGc6V
	 dPgp+v/lGWhCO/xIQahjuoKFINHVqu3AkV1PW+T9VcHdZ+l+KCNsdwTVTSkv2eQDzF
	 IQwUnKF9cdVeNYPWABoMQVAH5edxSa8vGAv9cqgzln0dkLntNw7foAm8QBG31PrQuu
	 Wkqis/9iX8H1A==
From: Simon Horman <horms@kernel.org>
Date: Wed, 09 Oct 2024 10:40:10 +0100
Subject: [PATCH net-next] tg3: Address byte-order miss-matches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-tg3-sparse-v1-1-6af38a7bf4ff@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHlPBmcC/x3MQQqAIBBA0avErBvQTMiuEi0kJ5uNhSMRSHdPW
 r7F/xWEMpPA3FXIdLPwmRp038F2+BQJOTTDoIZRK+WwRINy+SyEzgSjrN8mqy204Mq08/PPFkh
 UMNFTYH3fDxrPH41mAAAA
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Michael Chan <mchan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Address byte-order miss-matches flagged by Sparse.

In tg3_load_firmware_cpu() and tg3_get_device_address()
this is done using appropriate types to store big endian values.

In the cases of tg3_test_nvram(), where buf is an array which
contains values of several different types, cast to __le32
before converting values to host byte order.

Reported by Sparse as:
.../tg3.c:3745:34: warning: cast to restricted __be32
.../tg3.c:13096:21: warning: cast to restricted __le32
.../tg3.c:13096:21: warning: cast from restricted __be32
.../tg3.c:13101:21: warning: cast to restricted __le32
.../tg3.c:13101:21: warning: cast from restricted __be32
.../tg3.c:17070:63: warning: incorrect type in argument 3 (different base types)
.../tg3.c:17070:63:    expected restricted __be32 [usertype] *val
.../tg3.c:17070:63:    got unsigned int *
dr.../tg3.c:17071:63: warning: incorrect type in argument 3 (different base types)
.../tg3.c:17071:63:    expected restricted __be32 [usertype] *val
.../tg3.c:17071:63:    got unsigned int *

Also, address white-space issues on lines modified for the above.
And, for consistency, lines adjacent to them.

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..5d468385feb0 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -3737,7 +3737,7 @@ static int tg3_load_firmware_cpu(struct tg3 *tp, u32 cpu_base,
 	}
 
 	do {
-		u32 *fw_data = (u32 *)(fw_hdr + 1);
+		__be32 *fw_data = (__be32 *)(fw_hdr + 1);
 		for (i = 0; i < tg3_fw_data_len(tp, fw_hdr); i++)
 			write_op(tp, cpu_scratch_base +
 				     (be32_to_cpu(fw_hdr->base_addr) & 0xffff) +
@@ -13093,12 +13093,16 @@ static int tg3_test_nvram(struct tg3 *tp)
 
 	/* Bootstrap checksum at offset 0x10 */
 	csum = calc_crc((unsigned char *) buf, 0x10);
-	if (csum != le32_to_cpu(buf[0x10/4]))
+
+	/* The type of buf is __be32 *, but this value is __le32 */
+	if (csum != le32_to_cpu((__force __le32)buf[0x10 / 4]))
 		goto out;
 
 	/* Manufacturing block starts at offset 0x74, checksum at 0xfc */
-	csum = calc_crc((unsigned char *) &buf[0x74/4], 0x88);
-	if (csum != le32_to_cpu(buf[0xfc/4]))
+	csum = calc_crc((unsigned char *)&buf[0x74 / 4], 0x88);
+
+	/* The type of buf is __be32 *, but this value is __le32 */
+	if (csum != le32_to_cpu((__force __le32)buf[0xfc / 4]))
 		goto out;
 
 	kfree(buf);
@@ -17065,12 +17069,14 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 		addr_ok = is_valid_ether_addr(addr);
 	}
 	if (!addr_ok) {
+		__be32 be_hi, be_lo;
+
 		/* Next, try NVRAM. */
 		if (!tg3_flag(tp, NO_NVRAM) &&
-		    !tg3_nvram_read_be32(tp, mac_offset + 0, &hi) &&
-		    !tg3_nvram_read_be32(tp, mac_offset + 4, &lo)) {
-			memcpy(&addr[0], ((char *)&hi) + 2, 2);
-			memcpy(&addr[2], (char *)&lo, sizeof(lo));
+		    !tg3_nvram_read_be32(tp, mac_offset + 0, &be_hi) &&
+		    !tg3_nvram_read_be32(tp, mac_offset + 4, &be_lo)) {
+			memcpy(&addr[0], ((char *)&be_hi) + 2, 2);
+			memcpy(&addr[2], (char *)&be_lo, sizeof(be_lo));
 		}
 		/* Finally just fetch it out of the MAC control regs. */
 		else {


