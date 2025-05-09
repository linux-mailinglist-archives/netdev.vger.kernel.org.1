Return-Path: <netdev+bounces-189177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D7AB0FC6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5351C2436C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75F28E61B;
	Fri,  9 May 2025 10:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056622B8C6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784890; cv=none; b=Ufe+uKxzrWT5irdmgeE0ieEg19emZQO26ktN5aCp2DcQO1c3FPz7SHQ8ddcepbZn53CAFkEaLmOg2/jeUkL05bmPGT2rOOC1IWADYWd5v8TexKrJHxkI9cuQW+glnUb6nRdS7T40LW0YyZ3h1PZob0WiFUJX5L7NRGxBX00/mcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784890; c=relaxed/simple;
	bh=6CDUTg6Pn2eVTDd/M+2WlQEfD2TqTE+PO8NyJeMFOwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrBq4hPlWjzpBQy6pilErpmcP6aGUvnvZoT0zW+1IzTsVQgBO+phdSc7z+QcvqEi0ozuPjNCTvQMY2qvB0RvgT3hQaG8hRlNpZ+GMg70hqMtsAL34J7YNh0qlSoNWoyeedCxKliLRQLk6bST2jcdMz2JOPlvD4Ebjs7NDJpnwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1746784824tbf673ff5
X-QQ-Originating-IP: lqlGyLiuJjWofnarR4fWc324xGegJFNXgp1R4PsQnAs=
Received: from w-MS-7E16.trustnetic.com ( [122.233.173.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 18:00:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14409653432730430189
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 1/2] net: txgbe: Fix to calculate EEPROM checksum for AML devices
Date: Fri,  9 May 2025 18:00:02 +0800
Message-ID: <AB6DC619636B23FE+20250509100003.22361-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509100003.22361-1-jiawenwu@trustnetic.com>
References: <20250509100003.22361-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0mS+7D7RQfj9Ots3VTYJUXP4LGrfHmQx82LyAYGFa4dLz8ggy1NBdZu
	Xj88eusVySpNWFz/bKoQrEEB2cvtHiqRDLKcCpYllHxhva+wcd0WMYEeM2P8vpSQ2mor8fF
	lL7sXpoydYnQMmnGMr2viTdzVC6vrPuTW9Y9XZOqU2er+ll4eEIdqEoY3aXqbzJEN5gsZ1b
	LyfmeeC9PW24/2XWywGTCl6AnM7tSxCSOO/15tLl8XQEYJbho2UbWYiAitOK0gnfE4so0eJ
	841VN0ThpGPHrD9C1TPoKbtYYlSPw9nSjV4ddQo4ppk8Ww3oUbxv+Q/LSCbcp7LDwgAz0dq
	h2Ju7N5LS5VyDpc6tXv0PwzvYiigoO7/H9FzNHBeo5z0LJ74n7oht0xjA195j1Op7rC2xdX
	AncpvqUuNxdMTpJeQxYVvts2ifxXYjqsRkwiZersrEdfFvzVKgXMGqvY5ylFr2881ZnVfn3
	4jAV7xZQSyJDLPdA23UgcWEuITVVV5St8Bc8RVM1SZr7h4DHT7l+azyOhWVE3JVhEByY7SF
	jcFOAmB64Yqe4DalpJYQX1L7mdKhbZHX7WNfVU0TdSFxqnLdXscK0WSjZerMPp5cOEX6UWU
	1/qCVh1YR5KqjTvToxYE0uzWxtLEPvJX0oat3L9gkFJNJVnElm2fcdIC6gZdrdVZDVUTYKT
	gr7oKykIkrkRfGxCzmC7orOwZ8/K/TvxsVzoXw7hgtvE/QY/3xGH7m8ZCjLTt4h0HBvUUPS
	AV43abOUooYi4FKnNwxeGrqi4kosjhXI9vTolvl+L9cGuLihEWLNYGqRoNmcdSPfc1ybOVH
	r6/eZaWb6R9pgXikUK+cGYBK4KbSdfTO05SzLmiI3iH+qqIIdW/w574d6G2cjTNmABf7Vo5
	FM02sufLhOXCm0Oe1gRASJo+ImpHJu7gtpNwkF9F1caIJnRf7rQybOwv3spyW1ikNwOBHfH
	B7vvBuBDhyEYUKDQgkG9VYnQpTemvbGvZXA7qqGuS38tHcGbGufnvaaovb938iLW0zot3P6
	5LK/I25SvhqkBnqKDc
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

In the new firmware version, the shadow ram reserves some space to store
I2C information, so the checksum calculation needs to skip this section.
Otherwise, the driver will fail to probe because the invalid EEPROM
checksum.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c   | 8 +++++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 4b9921b7bb11..a054b259d435 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -99,9 +99,15 @@ static int txgbe_calc_eeprom_checksum(struct wx *wx, u16 *checksum)
 	}
 	local_buffer = eeprom_ptrs;
 
-	for (i = 0; i < TXGBE_EEPROM_LAST_WORD; i++)
+	for (i = 0; i < TXGBE_EEPROM_LAST_WORD; i++) {
+		if (wx->mac.type == wx_mac_aml) {
+			if (i >= TXGBE_EEPROM_I2C_SRART_PTR &&
+			    i < TXGBE_EEPROM_I2C_END_PTR)
+				local_buffer[i] = 0xffff;
+		}
 		if (i != wx->eeprom.sw_region_offset + TXGBE_EEPROM_CHECKSUM)
 			*checksum += local_buffer[i];
+	}
 
 	kvfree(eeprom_ptrs);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index cb553318641d..261a83308568 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -163,6 +163,8 @@
 #define TXGBE_EEPROM_VERSION_L                  0x1D
 #define TXGBE_EEPROM_VERSION_H                  0x1E
 #define TXGBE_ISCSI_BOOT_CONFIG                 0x07
+#define TXGBE_EEPROM_I2C_SRART_PTR              0x580
+#define TXGBE_EEPROM_I2C_END_PTR                0x800
 
 #define TXGBE_MAX_MSIX_VECTORS          64
 #define TXGBE_MAX_FDIR_INDICES          63
-- 
2.48.1


