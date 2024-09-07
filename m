Return-Path: <netdev+bounces-126252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73699703CD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C591C2129F
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7943AA8;
	Sat,  7 Sep 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Biah8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA6165EE6;
	Sat,  7 Sep 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725735831; cv=none; b=FjRPe8oUKCtitpQ9uBwjsCdMl99G2EGCwEmill3vyfK3zHv5UB+k/lAhv3TJUKEdjuGPm4mn2GxVsC+eXaW58ksmdDVb8zH00d2kvZq6Rq20Ttt/mWG65ctFEVK05wCfy36DI1mRTYeaOdAIFpJA9FpJOtiqr9emDiwwOBF3Q3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725735831; c=relaxed/simple;
	bh=dfph/+nheQwDiPwg/rtS9N3WHLIN0TbhfZndd6ZvTvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/KG79vP4LPhWAvjHS49IF95pmuEj9IO4LnYbxqj2aFBkXBDWG3iod5CtyCLVVusAmZ/AIdIJSxPoHWETWI2XlH9BMQA7athxCAAIRPhRslXFD9Ahoe8gOm0ANIYN+YdrKZLDyi3Fbgje/f3waBlDU9vWQNeb0tyanqPh2l/v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1Biah8X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d79fb6f7so1613975b3a.3;
        Sat, 07 Sep 2024 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725735829; x=1726340629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zx1VFN5ZHG/PELZ4zI7xuhOBSu9xApqGwfQ/VTlx3U=;
        b=P1Biah8XNGMx/KQetgtR3HSvwAdgk52PHYHiHyYMfS0Tl1K68r1vMR3rGfqMfwFdAy
         0B+bKBXOFbv5XdKCg4buzFharaVRX/zriZp5YgBpliASgSGT4v6/oCuCF2vVLnfOY2mw
         dXyp4QKknhYZubBANhn6oaAJ+pqlO36kt46oV+P5yhP9D5/1Up8Jb1zcywSoFm7ts3E2
         WjWKcD60OQg9B7WHDZec4Vrejng4zkbFfF00Um9gtrqxG0I+af5WHtYjto4XXd5yxTWm
         Jl7jnffqlc0DwerIjS6dWOfwa7IPPNc4UUikge1e+6IVHED3mHTRzvQ1/ld6cwQAFv8M
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725735829; x=1726340629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zx1VFN5ZHG/PELZ4zI7xuhOBSu9xApqGwfQ/VTlx3U=;
        b=uJHrzfO5bwYbTOi20roDlpWOOXF10y7NzN4jq8NaTpB7Y4TC8LIaJVxx2Uuk+jkclQ
         1ECKHaQoK/HkLnMol2RDR1LFCbMMPIYXFjfxE4nx9VdI6XmBCQvBR6EOE7hsX08Vjpkx
         ruUncB/pV9voVYJexnoNhji7RA7oOuSSO8i/F9I3rX5rBwv0enRye3kb7P5gNeyn92Kz
         Vf7E0b01PAoZjNJVHgiEYROL9MYCFS+j+VI1oWhFJqsSwCg3918KaA+JWr5WRf2YuOdv
         cro+rJ+CaByhGxgtx8EweDlT8DOJq0Sn9151/suoE2N3Nz/t2MZAx4IX5BkzN7qERih+
         xs0w==
X-Forwarded-Encrypted: i=1; AJvYcCUckzkouX6SuLzqy7o5qH10pBKnHxRMULYcvvKS2NBsZHom95y4k9tGfffqY8cGymIAMPlM06tc@vger.kernel.org, AJvYcCUoU4/HLTDPr5gycZgRerfArYXRih+NazmHh68bwE4v9YUgSFtynhGkSm1FERlanyYoQy70t0Q604tjoPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSMfAx89fSCxssYZ2eKGeRhUkwWh3plYT/2jQOJVcBfy/x5py
	hVyJyWsaT12IP6iWcUAkjYJEuH+pYk9C90h568lecuuK/e9aGfyS
X-Google-Smtp-Source: AGHT+IF2s6wWTR93OjwD/+aDtqpA+I1jBE57UiitafG1lKAb9FL9AHnURLl68bPKfCdojx/3px4j3g==
X-Received: by 2002:a05:6a00:a0e:b0:717:85a4:c7a1 with SMTP id d2e1a72fcca58-718d5f2fca0mr6558673b3a.27.1725735829117;
        Sat, 07 Sep 2024 12:03:49 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5896ba6sm1166097b3a.5.2024.09.07.12.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 12:03:48 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	lukma@denx.de,
	ricardo@marliere.net,
	m-karicheri2@ti.com,
	n.zhandarovich@fintech.ru,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()
Date: Sun,  8 Sep 2024 04:03:41 +0900
Message-Id: <20240907190341.162289-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function hsr_proxy_annouance() added in the previous commit 
5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network 
with ProxyNodeTable data"), the return value of the hsr_port_get_hsr() 
function is not checked to be a NULL pointer, which causes a NULL 
pointer dereference.

To solve this, we need to add code to check whether the return value 
of hsr_port_get_hsr() is NULL.

Reported-by: syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com
Fixes: 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/hsr/hsr_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc..b3191968e53a 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -427,6 +427,9 @@ static void hsr_proxy_announce(struct timer_list *t)
 	 * of SAN nodes stored in ProxyNodeTable.
 	 */
 	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (!interlink)
+		goto done;
+
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
 		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
 			continue;
@@ -441,6 +444,7 @@ static void hsr_proxy_announce(struct timer_list *t)
 		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
 	}
 
+done:
 	rcu_read_unlock();
 }
 
--

