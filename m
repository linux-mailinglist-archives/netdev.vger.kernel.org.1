Return-Path: <netdev+bounces-208907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2EAB0D892
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23321166B68
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239862E264C;
	Tue, 22 Jul 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMnw82v+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4A22D785;
	Tue, 22 Jul 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185191; cv=none; b=ReUrT2tCpMsvt0sN17H6kEuwdp8328Xb7I6DjAsjlmhkEmFNRhZJ9+qqnA98vQSqsRaeoK+FoMFS+QnO3A1+DVdOeQS/vmIaqtCnfNDDHQTaQJb2Lqg4W551YcinwLLubs4HC3mZlwVev4ROAHYNHmoB6a9YwSdv8lztvvuexHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185191; c=relaxed/simple;
	bh=loqztyaiUITTlGaYUo7RdoMuPE8I9gB9XD4AoEiAqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgcigzOSdyIpaRCRBCS/42dU6i+9UIw8xQS41trBxMCSaynIyvJHMLjbkV/OyX5GqHw5+Sj8Gvo+4BsCb647cT0kg2LOd0/c0loPvHU/f4tGOw6ZXcMcmAqF1MMBh0yUS3QS4EunT/z4LlEr6mQa/p31QHsVkREHlvOPdtGSmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMnw82v+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so59079405e9.1;
        Tue, 22 Jul 2025 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185188; x=1753789988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkp/rv74miGjepFs+AgLfe7Nd1NYRVijo7ZDQwRdmcc=;
        b=iMnw82v+4Kbs0B7Aim59ca0GykKY0fthuoPxPMoM9NMJ9rft3/SOwUzA8VR5bmca6w
         aV+UQ3O/SycTqIgwjjygPn1jPYh/S2140eGrmuiHebk5EjlGxf6QUSXgiB8YvNt7IuT4
         eGCwbypNYJWIa2mkDSy4nBE8ILYDS4NDTysLgSHAXjfwub7j4S/qsv0X01PaGQglkXLT
         2Zri6ID8vDRoxngNT9gvR785EyC9yCFkKCt6XKCf0bRLUTEYnc2LBl5W4ptbknQkF5Md
         1f3b5jW0MxWgUE+ozch7TN30InEKv25O53CsDJRGewDByufJEgMRkwmCYJDzKaWbC1zy
         16lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185188; x=1753789988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkp/rv74miGjepFs+AgLfe7Nd1NYRVijo7ZDQwRdmcc=;
        b=DaejTcfIqjDkbTaqyjKLsa1IToEmtK6fk6cmay5J3iYtJ9HgbbmiXkLLJeveBsl+3+
         CIJIYOeUE8Pn6QyQXAfxdvg6XthC0YRRG9PZPAUzjSXgXJ347wgO6qyqbOI8mCL5vx35
         173bD6Pym1dq3FZBN56f+siHE66T4CFEM5JMIyglaUc+pBRWo2JjR4XKARUz9fwV7wuY
         GkstnZynpvBkZiVuS76eW8WJjnJna6hUmKyoDCx7njfGAJAK5JscZOJLuOB1tt19LGt2
         cEvZ6LUc3xHQ9C5Bvgb4pdOyH7wTC/NUMGQM0JCrakIOuSypaa2PTf3LAHP+c0PPMSzB
         fRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6bzhp15oYYbZmwcvidp7eaN/PDhEC387H14VYBMc8X5i1b5fVoHxj80XjcgmO/T4MLbGNaY4o@vger.kernel.org, AJvYcCVcr5iG+Pt+Ms9FnViO+Tte0px+IQJu3M2HYlHR3aGI7KNqn1ynsFI/iUTsmnmwGam2nm3ydu56QxHr1po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAEBFF714dfIUBGeRTZKce5y6kH3qnyQvkCyjdKd6V6S/tsnU
	FtFLu2eYXlwISGqLQp9y3MY+1AO7dY5H3dPwNKf4XKG0Jpal22kIQ+LA
X-Gm-Gg: ASbGnctR3lliEk8PpG9XLMj6EetYOrSEs91bE80VXWnURkkMwZEg+ywxhe0w23t5/xF
	HyZj39S+IaIAAhlSlq3b8SjCP6t1qyikt6ef24EfSun8EoMANw6O2OC9riJgQtmhr/kUBw+pvDT
	tJ5yxAkFNIxjbFGX5AF8tOFrCPC7ItOsopi9F1JWAR8gIp+wru4zT+ZJaYkcOzIsZ3BTWQc8Amr
	5F5e9SCag8goEvfnpQV8NuZ/JJkI/pdkgBJc1ULsfhrVUTTYcPlPDHVJ1gHfTYCXcCpEZebY1iR
	fSiB4wEwndcyraR+Mz/OAjHs6k67BXakCLWc0G4l/TgdSZp+h/Eqtm9DjJcYInfIrvWVLrShFVc
	H7dMGV1dJqs33skXpCv94rMqXUg1JSoJ91gmLx06or5V5tA==
X-Google-Smtp-Source: AGHT+IGCf91BAOWUwlwAPbJxz/0CA+eqb9blpY9HNaDeUUuvBuznH5spHuwtcT2o8JH6NfXKK0Pfmg==
X-Received: by 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr186920655e9.7.1753185187369;
        Tue, 22 Jul 2025 04:53:07 -0700 (PDT)
Received: from Reodus.localdomain ([192.15.193.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e88474fsm192631615e9.22.2025.07.22.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:53:06 -0700 (PDT)
From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Subject: [PATCH] i40e: replace snprintf() with scnprintf()
Date: Tue, 22 Jul 2025 15:20:17 +0330
Message-ID: <20250722115017.206969-1-a.jahangirzad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In i40e_dbg_command_read(), a 256-byte buffer is allocated and filled
using snprintf(), then copied to userspace via copy_to_user().

The issue is that snprintf() returns the number of characters that
*Would* have been written, not the number that actually fit in the buffer.
If the combined length of the netdev name and i40e_dbg_command_buf is
long (e.g. 288 + 3 bytes), snprintf() still returns 291 - even though only
256 bytes were written.

This value is passed to copy_to_user(), which may read past the end of
the buffer and leak kernel memory to userspace.

Replacing snprintf() with scnprintf() fixes this. It returns the actual
number of bytes written, ensuring we only copy valid data.

Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6cd9da662ae1..19a78052800f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -70,7 +70,7 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 		return -ENOSPC;
 
 	main_vsi = i40e_pf_get_main_vsi(pf);
-	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
+	len = scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
 		       i40e_dbg_command_buf);
 
 	bytes_not_copied = copy_to_user(buffer, buf, len);
-- 
2.43.0


