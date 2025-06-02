Return-Path: <netdev+bounces-194609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E494ACB016
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F5A7A21EC
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD851E1A3F;
	Mon,  2 Jun 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0DNiWPn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80001C5D72;
	Mon,  2 Jun 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872789; cv=none; b=kFIEhZlPqkNGgyPcADuay7mZB4ZUNQxBHJQgvuoZ5Ny135gaFZPkNRLOiEX/za+izeAyaUF22QCU3OREck4wBt9XZQpsupMKhCOW5b3i+XHsmDyW2cPTo4AMHdTrNic3GQ1aXdfK6CAikbShXyQGipd4SIa4zBgLj5QyF8SpQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872789; c=relaxed/simple;
	bh=510jMgMuVJgLONrJpYnhvGvMBIc9L3Cdb3rc79Pyu2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYHmbd/4lxPHjWLqYZuAow7FQiSVcDNmAsyywok4hzzLIzt1Kn0IHjNFZaWhtJEQNY9G2m8dxONsWgtKQdAxCe/swbLGYj4dGPe9UjhJ12WEyz/TlUzSUqINnN6K2q6UTtajUFa7qoSjaJptSLODqqcnVTdcodVGTRalyQtB83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0DNiWPn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b9dfb842so40044595ad.1;
        Mon, 02 Jun 2025 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748872787; x=1749477587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2I9kHfTkQCdW1yuTkU7IIRkkfGeUty8kEfkKZcVJwRY=;
        b=L0DNiWPnUolLMLTzty3nYrM9mJvowEsDoo/TAKcXCFRuLe+ch6fphTAECb1CnS+dnu
         J2O/NIJcXiTLx1079YwrvisIc7/v/4697zG5DW8B9P2ByL+zskSpLqucHcCQnjkceaMv
         XuLa3g/atp/KTZa0+/yyAp4/nfK6OglyZQbyLBYvLCbtPrbCTE+frm6E8IWDhqbqtiOa
         WxR5aQVSD2+SKniioh8eel2Fs/GbsYtz1Q4GP0hMTYUd24Fi0ubi8yeSS9eCmzFbk909
         PX8V8bhvWT3yvX4J43rBJ7HX0ZY2/bTI2Aomg5aU3sSbDOWFUef7aUEgx3cLfcYaeZBm
         TZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872787; x=1749477587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I9kHfTkQCdW1yuTkU7IIRkkfGeUty8kEfkKZcVJwRY=;
        b=tLZZefWuGulqVC98iE/n57P6aXVWmidKndV8PFCBfcLyW3OoeQT6FUAVCZSfznpA0o
         XHKc2KBCA+duNbx4P0XOprd6TB2CQ7TlwPz78FuBidVoePMfJ4XW93/mXboYZHgRAxVz
         USUWn6tTQrG9XJRFSueD+DxR/5AQ2psfmCnk0odV9bgrvDHDmacUNdgdmoRggu87+CU3
         5Hy0mNrSFQ+joodiNsbH4/TSOWJ+aP+gBPVelXhMJXMAC+kVZzrGxyL9ellC5Nt9N8jT
         iN+5MQHZjFn3hzQLleeNtzIB7OfNFiSkQ+GNLWosyJ4aQxix5Ti8QCeBi1EWVH4M5BIH
         dlXA==
X-Forwarded-Encrypted: i=1; AJvYcCWm4a4CC/k+4LDy58XSS9sCBzldL+6ptZdORKwSYgHNYHmUeXvAukwWJYMW2+ftJVecpzKtgOZ12E1mo7U=@vger.kernel.org, AJvYcCX0H/iYuOmC6jxQJbzxe/ZrhTZgoJC387wtYI/l4sd1uROZWT0Xldv+Pt/WegWCeaNQraHwBrFU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqvn7OI2BD6D72Hhr0kohcVxKd7LTKU7Lsfm0qDBwFl9EEBnRd
	IDTrEKg10cPaTmJnYpHmGwRbLdl/uDwjfH6l1/q7oIsOCLLSSOxPcAJM
X-Gm-Gg: ASbGncvi38wPSjwa2GDMTPnUXr72J9/UNA/i+st69f2h2NgO/u+iJ7E1kyPZdBk9Rih
	xYSePx3/jtUVD5Zd7/Faqpq0ZTAHMEjdd621F+zxO/i35ouzX2ELaWJE2JzJ+f62X8DTR9nOZck
	jrEYT3da6xxuV1WrKIZhY5gpIybogYaI+tFgUZmkZMZSVg+NCymTPQvo6eJjt1ua0Hi76tEXiKE
	1LASORXkhT2Fz4j++/2Heib+5FqRKAZRFbQt0/lHjejmOCPJ1M3ECXteuLKGEHW8vMddivO/sIl
	7Opl8a3+Eh71hTAS+6N6T2u0qBrOb1CKROHokdZADSp3RyfSpgvZXLuAdgvcuxym8wv7T8w=
X-Google-Smtp-Source: AGHT+IFY51lSdo7zfzC13+wWkvAWgQEqDkxEkSXJntWB0/HrzcJFz1Qu6WVZNLxHhgpfVvxEFhR9/w==
X-Received: by 2002:a17:903:1c6:b0:234:ba37:879e with SMTP id d9443c01a7336-2355f781dadmr132895055ad.38.1748872786765;
        Mon, 02 Jun 2025 06:59:46 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:a430:9007:9516:3e06:bd5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14ddasm70988915ad.251.2025.06.02.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:59:46 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keescook@chromium.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] net: randomize layout of struct net_device
Date: Mon,  2 Jun 2025 19:29:32 +0530
Message-ID: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __randomize_layout to struct net_device to support structure layout
randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
do nothing. This enhances kernel protection by making it harder to
predict the memory layout of this structure.

Link: https://github.com/KSPP/linux/issues/188
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ea022750e4e..0caff664ef3a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2077,7 +2077,11 @@ enum netdev_reg_state {
  *	moves out.
  */
 
+#ifdef CONFIG_RANDSTRUCT
+struct __randomize_layout net_device {
+#else
 struct net_device {
+#endif
 	/* Cacheline organization can be found documented in
 	 * Documentation/networking/net_cachelines/net_device.rst.
 	 * Please update the document when adding new fields.
-- 
2.49.0


