Return-Path: <netdev+bounces-234877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71854C287B2
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 21:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FB894E18AB
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976CB1F4176;
	Sat,  1 Nov 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L002O9pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0A1684B0
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028194; cv=none; b=Z95lCtzMjmo+1ryREWh4XN6S2DYrWe1kV6bYxFZ7em7JJ1b6bOH11dmCKG0LyCeiEUz//Ix3bTxQFvBcTtEuCTp47R2bPtQ2eMq8CrqxlR6wc6eUI9BZTukDRsQ5aLhkimAyGgIJIT3UctwlC97jeWwc8wOpI3DMcVuvbms9zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028194; c=relaxed/simple;
	bh=NgY32jHrmDxujixjfxxUJsAupyyE1/qxQpZzA9u0gaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cCp63A0RQWvHBvoXGo8ztqTunnZHlKZ340jqMolVav575NSROmHL398lCNvjdBgxt3kwNnySwOmIusVDUjvRZu74c2SelKg7IYCaSxPONPFOnUqJJdmiR0QWv3FVcYxB6V/fhochJl/1YWvED7eGUk01Z75wxEcxDEChRmTHYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L002O9pB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4f323cf89bso756328966b.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762028191; x=1762632991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UY8fhAykEF/ZiZ4HL8RaS16ulFJ7StXJeVUPVb78F9I=;
        b=L002O9pBj+XyhGSyRVcFULwaEZT/PqMn30D8t4pRGBlxGtQyS7MBvSXZEE5ShjSjPD
         Im1+WbB/j2aOeXueUXqdG/sp5kso2+05Ln0dVFj3d7QxYoYoNG5lqdEA9lD//wAgWLbo
         Y/11vTgeTBWyNhpDHNJj/hW1VTxD6GS47iA7l7hJIjpoUZJ35DgKf3q/YCkwzDZmKnqh
         Qb89Ds8I7nSGgwscMAtN6zmwOMPgvXy8KJWUn1Hxc1DkiCxVyOBa9q7sFBtWB9Lza734
         3gQ6vBua6Ch+aMuMjaafgv42nGYtx5UgCB0T82w4qzOwMpHw56txgsij8fRkQe0rYaVE
         0vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762028191; x=1762632991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UY8fhAykEF/ZiZ4HL8RaS16ulFJ7StXJeVUPVb78F9I=;
        b=SCJNAIEMIBUJ9Z+Rv60v6jaeo/dOPQBh+vCKJ/NPKutm1dD8Rxg56DJQKOfb/0LfZu
         HTD/Vg8Te9TKiSpJbnBw2lD+DZn72asOgBTBSzR8ZmidOLOH9YLMQmZjhBWg8cVaxOBL
         Eiwm0I0TcmrpAVpcLX6GKhKZGhCoOGL9viBrITlv9kqVzV0wBEMWowcdLATIPVNJq5UK
         sJwYk3V2FQZqVjxcGYivLBASebtxIZhJHx8VlZp6/4sG0van4DZu7zjOEXjVJ2FDwjBN
         yVlPZE4zzVvFexZIBNz1U34Jz9Wuc3weVkEFBqyuuNmk0LRtZAkciXdoTHDAOYsyS1HZ
         QSMw==
X-Gm-Message-State: AOJu0YzshXlBQ5s20PO0lh1JoL5irbz3SkDp6TNMHtmqYNMlaVI2mxzl
	D8W7drpjjyA1LnE2N46qc6CBHBxTd0AL9d2TQnEqBeisWI/X1xh2aWWkm0bxXppecRM=
X-Gm-Gg: ASbGncsUVgfpQsyjanGsEa0hieSEhMsRfOANkNSPEcdxeKMtprcumfXrnvFCKIRnETz
	Prtz7XESbEmO/gESGsOyG+8Le9fmU87c4KHo5knWMJoYdB+zERAvKJfgQD5CBsIBMp7Fp0yzEWs
	Ikg2kM/0JpvdAP9xeH7ll/fr4vNsfwv8nbMkgKurMPfqklDgOaCZ8VytmkmirHluTzW/M6f0roi
	qn27M9+X7DGxzuZ5wSxHGDYXm/kXCUaKKcrpX3ChGuxw2s5FOZtCM90XrSahoCRnmJliyy3Bt7i
	RlFD+SeQZdwBfaaiV0j0RkCHYITxgs/XwaplL34rWIDJGNVcCS0zVZLJLEn+y27nCh7/iBOV9eP
	W/2MvQlV3LFg0L5MmSb4V3Nzb5Z2q1+qsgbtrmyFFyLyqpTBuT/bzxhLzPdnRvAytCp9mzyeQIC
	TN2KS2d0+ZEHdThddA4v756l4T+L2T1YWgDQ==
X-Google-Smtp-Source: AGHT+IGB7pHaBILf2c3NpKvf8sojA4NRxzvgG1R2KvX/z/p98Y0bkh17Ok5v5PO2TCOEk6VdJjPVag==
X-Received: by 2002:a17:907:972a:b0:b41:2fd0:2dd4 with SMTP id a640c23a62f3a-b70708738f7mr755907566b.61.1762028190523;
        Sat, 01 Nov 2025 13:16:30 -0700 (PDT)
Received: from localhost ([2a02:810d:bb0b:f200:c13a:3288:7fab:6ade])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975cfesm539241466b.4.2025.11.01.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 13:16:30 -0700 (PDT)
From: rafiqul713 <rafiqul713@gmail.com>
To: netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	rafiqul713 <rafiqul713@gmail.com>
Subject: [PATCH] [PATCH] staging: rtl8723bs: use ether_addr_equal in rtw_ap.c
Date: Sat,  1 Nov 2025 21:16:23 +0100
Message-Id: <20251101201623.185575-1-rafiqul713@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace memcmp() with ether_addr_equal() for MAC address comparison.
This is the preferred and more readable method in network code.

Signed-off-by: rafiqul713 <rafiqul713@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 0908f2234f67..7cfd4088ce8e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -6,6 +6,7 @@
  ******************************************************************************/
 
 #include <drv_types.h>
+#include <linux/etherdevice.h>
 #include <linux/unaligned.h>
 
 void init_mlme_ap_info(struct adapter *padapter)
@@ -1185,7 +1186,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	list_for_each(plist, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
-		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
+		if (ether_addr_equal(paclnode->addr, addr)) {
 			if (paclnode->valid == true) {
 				added = true;
 				break;
@@ -1238,7 +1239,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (
-			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
+			ether_addr_equal(paclnode->addr, addr) ||
 			is_broadcast_ether_addr(addr)
 		) {
 			if (paclnode->valid) {
-- 
2.34.1


