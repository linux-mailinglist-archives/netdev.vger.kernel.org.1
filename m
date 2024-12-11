Return-Path: <netdev+bounces-151097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D19ECD76
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD91636DA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49C22ACCA;
	Wed, 11 Dec 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXghnRdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076023FD00;
	Wed, 11 Dec 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924557; cv=none; b=nB3wL2ARv71GAsM8y6QZVxNOYOZxFQcGa2gVEFhsMoFL41EDOcO53LezpbrMJkZgHn0U/vAqwQmYPF6uuYXAtQicEnarICi8Gxy9flmoxvRb9I4NnT+KGq3NCTYMAwBcL1NrvzyUtROcTI1725hLS7AFi0C6Pbu06A/yz72m7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924557; c=relaxed/simple;
	bh=//aM2lAG9xBSYdK0Zd1rktWcH+zQpqdgJLKcA6MaQgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPfASEJFRYRy8a64EgICkHeHiMF/ZpqatsmIN3LXnTQV+NNMuKHT4xiVMgwbVzlzvn1Xm1drsKsa91eNJ3hAkGqP9BBC/TSobmug1HTnJ45SVd80P4MefYPIvmUHXfB5q6C41iwS7N66KN4dfMe6j50RzndT4fuQgSHa7ljDKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXghnRdb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3863494591bso2110889f8f.1;
        Wed, 11 Dec 2024 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733924554; x=1734529354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Jj+YhZdReS15WwCWMzdZsF/agoNR+Ju4FNBhDdYtY=;
        b=YXghnRdbmbCjkwBjPkVdBJ6v1yB0tEhAon1dDUfhw7+Ef5cn16yj6luL6s3O+WHBT6
         GAYqwFtHzUxPRMeSm3IK/JcyKzrn1Cy0T/TZsiNz6izs62AyzObcJEewGmGh+g5xuccw
         6jrdjBihWRCTV+ZDinRIRJpqvFx9IgC0tpOyN6+Rxpf64+0YWXab9SG5/9Gvi6ZMF9NK
         w4sgeCWZYzwUvTAFAhUlzU4KXhRg4Ps/CIL36i59wGTNC4/DLTS232n1PerJ6P1Vtb49
         TxkMttYbNuWbaF7NnVDBYnehcGILniIG0XSRv6x6mzabo9qbGzmd6cog27ItavIBs0+Z
         +PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924554; x=1734529354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+Jj+YhZdReS15WwCWMzdZsF/agoNR+Ju4FNBhDdYtY=;
        b=jF/PT4rc7aicgjY4noUh6w5qFJTeEkiI2eLQw7U5kf0tDgfPZhwS2ht8VhcfbCKKRE
         NwxAQRrF8dajv2fLOLNA4OYRL/UOv5W4IiSqHRkEGGIvcVGm6MqjjchVVWy+QwH4CPF0
         WL1v25kahH6N/vyXBOcvP23A4Zz7KZw+YAMJjt87TfQyuEMWri+eUcj7OFTE47R3UYmL
         IWXvhXdcVn/6ZuaQDdzBA1guR+pjdek2/66GO2Naqc+bASIOdF00cYzwVepXvmvMmlxY
         zuJeltoYcJOvqHw4tsMgNwegnW2HBOn5QC+4u8Q+pH2LmDF9a0bEoTiZTLlQUlkuZKbX
         N74w==
X-Forwarded-Encrypted: i=1; AJvYcCUfmJccrw7w6hqpGa87I0tW1De9x5fBKZP/AHZtRM7URQWcxqfc6wMRpTwE+EOqZ9Vdw7vrwSLFvonBBkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHnPQor7GkT08fq0RE2kzKlo0lgADu9onZhLB5LeiE5nJLAdq
	7eGH53HB0Kb2YWjWRXvvWx1mfNHJ0XR/wO55FDz/5m/+qc3FPSe5
X-Gm-Gg: ASbGncu3egMLBc4QnifdrXEMyTPgIwMqbGD6JKHT80evZbaEz0pWO8x57Nv+yvbIVUr
	t6cHQXXaDS+9+gshtPwhb+zgGqfc2eFZmqtrUeDQ7AHzGVyFCzWjz8TNNv2COURYKyKWLYdC4yx
	E2AqGkvsfUZI8qMZQDLqIV+CBHxLvi5Ny5IP/biZsxEHOQKMjCy35oZYNyZ0o+2twwuInglACNX
	KCraUpu+JJtWIfhi5DuY91Cd2cdZGuV9tA9G74e2F4xvVB0GhlIXM67BDw6lw5x
X-Google-Smtp-Source: AGHT+IG+2YYZETv1errh5l2XpjzbOI5e6j5nECnS+lXKoM4bG3C6YBGKE9JMjwpLNUmwg1jMjpVtyw==
X-Received: by 2002:a05:6000:2ae:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-3864ce495c9mr2975553f8f.10.1733924553898;
        Wed, 11 Dec 2024 05:42:33 -0800 (PST)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:3efb:ead2:f2a7:dd86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514e6asm1326818f8f.79.2024.12.11.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:42:33 -0800 (PST)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH] qed: fix uninit pointer read in qed_mcp_nvm_info_populate()
Date: Wed, 11 Dec 2024 14:40:42 +0100
Message-ID: <20241211134041.65860-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
If qed_mcp_bist_nvm_get_num_images() returns -EOPNOTSUPP, this leads to
jump to label out with nvm_info.image_att being uninit while assigning it
to p_hwfn->nvm_info.image_att.
Add check on rc against -EOPNOTSUPP to avoid such uninit pointer read.

Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
Note:
- Fixes: tag should be "7a0ea70da56e net/qed: allow old cards not supporting "num_images" to work" ?
  
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index b45efc272fdb..127943b39f61 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3387,7 +3387,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
 	}
 out:
 	/* Update hwfn's nvm_info */
-	if (nvm_info.num_images) {
+	if (nvm_info.num_images && rc != -EOPNOTSUPP) {
 		p_hwfn->nvm_info.num_images = nvm_info.num_images;
 		kfree(p_hwfn->nvm_info.image_att);
 		p_hwfn->nvm_info.image_att = nvm_info.image_att;
-- 
2.43.0


