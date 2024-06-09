Return-Path: <netdev+bounces-102077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0990158F
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44D71C20B60
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D752C181;
	Sun,  9 Jun 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="b4+hcGLx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4E1CD13
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929442; cv=none; b=ZG4/ISAL6jYUYxUomfvGe/oCWVAMEH/sGVLNfJcNJsadeBY4ZfkHCXfXyA/WAwNTrYOo16+sNe0xaseNBs580d69gmj2NspsbE6nnuJs0JaC14yoFdMVHT8a0DR9MipUjyq9RKbVSQVTRt8PZhgtRMz1hYsgRc0gMgbSmLPVaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929442; c=relaxed/simple;
	bh=fS0riV6tx+Ta15aGrODcXuGQx926c7E8BMpciH435MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLMxZuYiZQrHg1+wJbCViU5aEbnGzrVtCO3WNtfzJNOUW6BTDiWYvNqgAcD0O/vaAea/LumRciMKxqAainwdTO6EAiXscpNu3YFkzC6wEoqj7K5d7Y1YfkVd62DlsoCd8NHs3r0ek89hZ2NtfeaZsr8kz7VCUiGqAx4slRbvfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=b4+hcGLx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6efe62f583so107540466b.3
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929436; x=1718534236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBg6USOiUCl8/5mG5bszaFohunyM8rngAh7qlwT06Ac=;
        b=b4+hcGLx494kTQnLPXQitQkZhrLBwS8+qyE4yrSK5kETFgi2cR95PsaM6QcPddjbHd
         1i+0/cgkpUUvYGaMWobHk3OWQiUWUSewqp5FGHSo7UBcwEgwUNR0LVflV+Rlnz8ow9P2
         QoONax1vUs5kBuco4YRES9iUqEnw6I63HERQteBV3YUFJxTT4myViLDjI3Nc4Du8hvhG
         CD+ohQTvUlYOVwNh8Oi2t560Oa7gTz+2QL4KnocrsHn1gsZcMmyRqK29DYB7cs8lX9jI
         e6r53k9NmdUMA1Q4lvjvCnzxNQzSarR75UFynNam48otoEbHqai3ssqrwqDdkK7kX9tt
         RBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929436; x=1718534236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBg6USOiUCl8/5mG5bszaFohunyM8rngAh7qlwT06Ac=;
        b=m8SnLRM28bmTN2r2P7+s2HpKl7uEUZGr6PcQgSxLzE/IOcLv47BiTped2OexIcUqkc
         f5jxdAk2jTMleyryqKmsV4V69hCUxxVXv6bHYDkyevJ8IFYgGOvD5WJcce8J63qCSONY
         RM+BnoConLDzYRUfkUc8vgcx5FMOAqA2l5JHswcV3ONa4oORMmLsK/eeGlPjwFuW/sAS
         16/zhaQon26KEFjvhDHHllMTaPFcJ9q4MOuyzYIFC3sBg4tprRInEHBP1qt+RdIg8pYR
         Bdi843A3BROWTfp/yU6FmF5my+LXPKNuKIJIyn98qEYOWtV7/Zq8rhw5X+HPTxabS39c
         nH6A==
X-Gm-Message-State: AOJu0YwE3mDoO468M7ia4MFsve2VZyd/b+N3wt8POS/UlvKryfPKw2C2
	0sBc8GLU0G2NajsOyYF8uLsJVfMqbPIK4KpY8uEXddtQTrUTxf3yVh8u81T8jeVKyOV4iHUmOzM
	SpBV01Q==
X-Google-Smtp-Source: AGHT+IGhtjbH8tdBa6Z2trv53b7OLUu7IL/XfWQCQqByhcCcU0iomqhLDFqeo785srCXIa2ATLvf4Q==
X-Received: by 2002:a17:906:298c:b0:a6f:18e6:606e with SMTP id a640c23a62f3a-a6f18e662cemr63630466b.26.1717929435769;
        Sun, 09 Jun 2024 03:37:15 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:14 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] net: bridge: mst: fix suspicious rcu usage in br_mst_set_state
Date: Sun,  9 Jun 2024 13:36:54 +0300
Message-ID: <20240609103654.914987-3-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609103654.914987-1-razor@blackwall.org>
References: <20240609103654.914987-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I converted br_mst_set_state to RCU to avoid a vlan use-after-free
but forgot to change the vlan group dereference helper. Switch to vlan
group RCU deref helper to fix the suspicious rcu usage warning.

Fixes: 3a7c1661ae13 ("net: bridge: mst: fix vlan use-after-free")
Reported-by: syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1de72816b0fb..1820f09ff59c 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -102,7 +102,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	int err = 0;
 
 	rcu_read_lock();
-	vg = nbp_vlan_group(p);
+	vg = nbp_vlan_group_rcu(p);
 	if (!vg)
 		goto out;
 
-- 
2.45.1


