Return-Path: <netdev+bounces-265330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDbGAJ3KrWnv7QEAu9opvQ
	(envelope-from <netdev+bounces-265330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:14:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87C231DAE
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 315FE30160E9
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81145395D87;
	Sun,  8 Mar 2026 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIAnezaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32926394499
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997272; cv=none; b=MTNx+UR6rvcid68XsDT7gbZ6C7PYWqIJ12RFt8sRIiYkeF4FkhWFMnxd7ID84XsfZV/lFOJ70Cp8MbwRex5Kp6bZAigpKvAh2H1ymlJ5d62wTE8BPqWKU3I2bk3O0wIlBAAP1a06o6bujMQjiYnbBMbRwQDOJzLvcjqXgMpiX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997272; c=relaxed/simple;
	bh=AzxKAZm/nl7pcn7SMGa+wkaWx2pzjLH+P7jHPWrIvAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lo2voS45aJxWLJiobFxa9jdIC/uMTqa9lgH+hyHhHkVe3oTH6msCCfzpmYcKiI2o4QqmnsAGE3g6YkthVFtyzp/sUOqUCsSNCw9KH4DBPWoKSGFnj64eZ6nWrqphhCC1tBHCWqxaLdBiMnU9Tb4s3YwI0u0WC27VDe84SFsrJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIAnezaD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d741f61ee5so627552a34.1
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772997270; x=1773602070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+q0dNvBbupC+6tyHU0OlnBS7KtJOe+yMxAJG2X59mY=;
        b=QIAnezaDpNaKZ7Vcfi8917jkkI9tFX7hIQ2raI7r/ErUmVkLhttIOd6TBhFtK6TBGE
         ah08o/b1bhuZplZJQfOhJkoV9q0TSOr0mPz4MNL2Pyfw21R8r85g0QDXa3td0mGgBZH7
         OWhg6q5A4/Zep9sD68cIIRGTDO89B0yAOeKA8q+UktrC92De7UjGjlGqTiJ9E4Ac8jhn
         d62DXmL9lxla2ILNvHkK1EdH20bAS/uC2cWmz0ChgQvMHcLiNyIU7shez4i5OVdQ02W8
         3UHwzh2bnDZ+5Q2k5f0swj0QD7mL2NiDzbbkp0llavQbOqM0woFIWI8WEgQ1yuc1LcOu
         igiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772997270; x=1773602070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+q0dNvBbupC+6tyHU0OlnBS7KtJOe+yMxAJG2X59mY=;
        b=ODVjC8OjE849uEmWL3aOcPKrlvpe7rSSPzOE9tu5DPhF4i+lJRnYXo67DNSgF7CSJI
         6nnYvbnohnvPB16rY5j3uvwqoFo28DotUyQpgqZI5UT3oueOxMV5QgNADCAKKe4cJ/1/
         qVm5/qwB8R87ZjaF8VPZFLNXlXiKsTsH3QpsO7f7/eDO32VfWQNGAn89sb7LA/btQOgI
         Ax8j3jR3UIWU99m68MSQPd6KsDhogqS3SSHaJM9ZgxTmDwi1G3X4ty1ICZelxHBmSu53
         6RZAu8iApbgguR9W+QwUg9Ly1SYwRgqyJbPDR0oFKtPbef3x6BzJtKaO2qaNbBfwtakk
         n20w==
X-Gm-Message-State: AOJu0YxYP3EZcjao29NbUgeZNzAb/45qSRUUQmQyLooSylJKMmRzdkOV
	j7vEI0Srfy6I0rZltyNYOcAOHobI4qSRP+6t7tmdt58RwuyAmG4V/HHp19NhFmCN
X-Gm-Gg: ATEYQzy/OoaZLkZzvO/l5v4ySuvPN7+cV4IO7o2DA7hg4NVpioD7AuhUz+/2kF5tRcg
	VSZVWVJbjfhhQ/Xa2FF0yCZrjg08kJi2xxAUm8jU9Cc65W+7J9Y6yHzuM/CWp9ixgiRFS2UaNll
	qxVFMAn/DNPzPSbNm9J4O5I3rbeqXigsToOCbjwTObEo/GDFUb9u4O3Pp7eWQjZl9G7jA1gwZhD
	5Hh+QQRM7hKuoupZi2+srahovbl6bXHTmLPma1pkQQxlBz4gHItdKHKbn0xSTkP3QRVN51ucbkf
	MLF6R8rYxk4XYe2E4ccRXiYRKWcbXwtorE4NojW4qQxE1n3agDFCzLctxGJR6vBKjDwPhO+Y0RM
	1+qYaCmVNn7m7zi3RJHV3Flnwr1882PCPCbCgBQvWRqAjdPPVjBGj0qiS0N/tNrEw/VuUH4TsNA
	Dy52HS2K085fbNISdW6D/vsul6NmxaDwOsGmleAtj2xlAYrncLGITcvLBxTk/mEerNErPsMK6Tn
	YzUC2CQ1VT0
X-Received: by 2002:a05:6820:2901:b0:66e:61cc:80e9 with SMTP id 006d021491bc7-67b9bd22714mr5309000eaf.47.1772997269962;
        Sun, 08 Mar 2026 12:14:29 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb230e0f1sm943936eaf.13.2026.03.08.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 12:14:29 -0700 (PDT)
From: ShravyaPanchagiri <shravy112@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ShravyaPanchagiri <shravy112@gmail.com>
Subject: [PATCH] docs:octeontx2: fix typo in documentation Fix spelling mistake "Crate" to "Create"
Date: Sun,  8 Mar 2026 14:11:42 -0500
Message-ID: <20260308191142.172363-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E87C231DAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-265330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shravy112@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
---
 .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index a52850602cd8..c31c6c197cdb 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -323,7 +323,7 @@ Setup HTB offload
 
         # ethtool -K <interface> hw-tc-offload on
 
-2. Crate htb root::
+2. Create htb root::
 
         # tc qdisc add dev <interface> clsact
         # tc qdisc replace dev <interface> root handle 1: htb offload
-- 
2.43.0


