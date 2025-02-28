Return-Path: <netdev+bounces-170833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C3A4A29E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966B27A5B54
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE81C3BEB;
	Fri, 28 Feb 2025 19:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F01AB52D;
	Fri, 28 Feb 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770599; cv=none; b=PWPjuC35O1bgJxjd3MRP+vblDwGdA9hrKAqi1MBnP3p/dV9ghBoawY0RHmiTQvullOFMnzOE5isOuFnikQb0C81OJ2uJmciXeHrRQXoUf4nwAz4cIrCSXLoLgSNhDQ8dt4WyfadXMt/sQhn3MZ2iU7JGROjqNrAB6TX+y88693I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770599; c=relaxed/simple;
	bh=0lwXzzKm7UaXqQuhWslVyCdy8IAqyxHiPV1fM2s//HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgaLGBWiPGifxMZVlWeG8T+JllUL2qxmasHmkpbQV3W8LzCgl/L6LTX1Ta2PCqhf1omOnfmQsAcpRV85HKMrpZ6UFGJwDysV6NXh8i4m6BAg/k1xjVAXWDWVBTUc66SqQjGg0AQ4kxc6Iuveg+WlIy+2Qa7v8A8vWyZMqfm3G3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1to5x0-0001Q7-81; Fri, 28 Feb 2025 19:23:10 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Lee Trager <lee@trager.us>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Su Hui <suhui@nfschina.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()
Date: Fri, 28 Feb 2025 11:15:27 -0800
Message-ID: <20250228191935.3953712-3-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228191935.3953712-1-lee@trager.us>
References: <20250228191935.3953712-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow fbnic_tlv_attr_get_string() to return an error code. In the event the
source mailbox attribute is missing return -EINVAL. Like nla_strscpy() return
-E2BIG when the source string is larger than the destination string. In this
case the amount of data copied is equal to dstsize.

Signed-off-by: Lee Trager <lee@trager.us>
---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 39 ++++++++++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  4 +--
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index 2a174ab062a3..400fb6c80053 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -233,19 +233,40 @@ s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr)
 /**
  * fbnic_tlv_attr_get_string - Retrieve string value from result
  * @attr: Attribute to retrieve data from
- * @str: Pointer to an allocated string to store the data
- * @max_size: The maximum size which can be in str
+ * @dst: Pointer to an allocated string to store the data
+ * @dstsize: The maximum size which can be in dst
  *
- * Return: the size of the string read from firmware
+ * Return: the size of the string read from firmware or negative error.
  **/
-size_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *str,
-				 size_t max_size)
+ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
+				  size_t dstsize)
 {
-	max_size = min_t(size_t, max_size,
-			 (le16_to_cpu(attr->hdr.len) * 4) - sizeof(*attr));
-	memcpy(str, &attr->value, max_size);
+	size_t srclen, len;
+	ssize_t ret;

-	return max_size;
+	if (!attr)
+		return -EINVAL;
+
+	if (dstsize == 0)
+		return -E2BIG;
+
+	srclen = le16_to_cpu(attr->hdr.len) - sizeof(*attr);
+	if (srclen > 0 && attr->value[srclen - 1] == '\0')
+		srclen--;
+
+	if (srclen >= dstsize) {
+		len = dstsize - 1;
+		ret = -E2BIG;
+	} else {
+		len = srclen;
+		ret = len;
+	}
+
+	memcpy(dst, &attr->value, len);
+	/* Zero pad end of dst. */
+	memset(dst + len, 0, dstsize - len);
+
+	return ret;
 }

 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
index 67300ab44353..b29ed2649585 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -116,8 +116,8 @@ static inline bool fbnic_tlv_attr_get_bool(struct fbnic_tlv_msg *attr)

 u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr);
 s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr);
-size_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *str,
-				 size_t max_size);
+ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
+				  size_t dstsize);

 #define get_unsigned_result(id, location) \
 do { \
--
2.43.5

