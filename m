Return-Path: <netdev+bounces-250829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC553D3945A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22BBD302281E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E432ABD1;
	Sun, 18 Jan 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpbP/0VU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55F32AAD6
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734038; cv=none; b=WJ0nsU2r5+q3IlqBANr55CKUa8afOSO3co0TIOZXRrHJ68q+yhHNzPh4hOqO3InrWU664vCxSjIn9cBSJHCRCDhLHPKZWseO1U8GZ2JuaOJyzNHeocbbn3bDN/lxZTszQRFhoLyG35rp7cts9u0YfROQQOdx71DSEE/FgFl+oEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734038; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1xGsvznrlVi++eri7qEn64TVOrsKnRFRPc6cQot9BkYJ6SPPSsDbrVXiz98+YEE4Hwsc4XlAXLts6FHKbf6v+OFBEFaUaHCLewnLUI/41mDSKQrtIEWYto+Ux+hyICGpRLIwg2bEwiYgrBPzh4rdaHxbUdXTXzK2GTTZp2PgWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpbP/0VU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so3057814f8f.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 03:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734031; x=1769338831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=gpbP/0VUM7wN14tUSOCRuaNj7g8IhqrWgy1uMClUU6YkG4NEaitoH3D4DyU/Wmgxuc
         X7ZSKLRX3OvJ7rHjfYhP3vRUSJb9BhDm7SruURfY+wUt2UMFtPFDbDYkJtZWjVGPXjxG
         JnJXrjGWMm+SaHN7rIgGIbCGDvV+b80VtxnqwpFP3qL9J69WwIGrkh1wJRwrIrpRQJAJ
         zBSmXlkfqG63iuiz4auzsKAWCYi+pjyL54HEwaJC1nFnuM6HERnRVBQ17/jC3EL4lCH+
         FVNXWMy7bifrWlg6btew66qssPs8KmUelJRVg8rXgzdHKawaEZ5bJJEjoVJKpGQJkVYf
         urRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734031; x=1769338831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=jRfR4B31f7PuKassqZmcg2wYz1TdTJhbc7iSal2EW9pUg3g5/3nzezln+bkLH4aiQV
         6cajcFD1VglHzti/cgfHgOIfTz8dnJMLE7sHs+SWTMfKQsMMsQBk1Yg8fIIDHG9/EhAa
         nQyVHYKqrZleg4Hqidow5YJPtpNqbJdTswkaB6WO5BujBdBXbr10SW+DXfCDrY9eGOdR
         Xe9fzOLbRJPTo79TsveMP8qxohVUwJdMmJfyBPKvqbootE3Xm8AiLPz+MwXWScmqqtIC
         84Km4P1q4+KV8nEQ4vDFckYuiWBrpTT02FSTPwl+K8J3v1u/WZ2TeXM8tNWDOmSz0NgO
         kf4Q==
X-Gm-Message-State: AOJu0YwsXA/MVaLmMji2sP2hXxXYKgpRQcqrRMtccTdpksqgo2ZiN8P8
	2aLZ/cWNnVt7K/D1eZaYN5O5F+jpvtOj5t3wGgdTTFRGQrhjoHJUgXYg
X-Gm-Gg: AY/fxX4ZmFSPtC587GDzJoHoohSe4xZ2gbTb5ewq3DOCkqVtJtGRnbcTBKFQ2dMN+v8
	Gnuy0pH/E56ThMjch8gE0mwK6b2liIX99FwjDUu0MpYTKFnMWe3n+jJg0vltU9TIXX+jJ/WgcVL
	eIAufyHhEnnTYLv+iit2pB95lFhrwunnxEHSjKKuWxN0hwG89QK29oC5uox+/btEJet4iuZEvwo
	Bm/S0jXg3/6vDvoNQV8nqd+3EVD6Aa+pCJJ5P2Y4AETKLeAPPoOUMrC16yvF8ZM4G3/ZtRGvpk7
	5zhVMonSvFvn2lXX0+XLT6TvDiVZ6ddFtYUm3trA6/M7BDcnUjlXab46Cjm5DtloMmZkgExDkFE
	wTHMLS/q02qeQFY0/lgNXzx89tlJ00Mi4vc9uFdh8ghzPo1CgEevwBB8VhnBqD0ma6ut4qTjzm5
	QjqSUB78PunKFhdg==
X-Received: by 2002:a5d:64e6:0:b0:432:dc23:34f with SMTP id ffacd0b85a97d-43569bd0b90mr11399255f8f.53.1768734031192;
        Sun, 18 Jan 2026 03:00:31 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:30 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:24 +0000
Subject: [PATCH net-next v11 4/7] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=ZvsPAc1Nu3ncrw9ojdKCeN2DHwyPVw7plQa3n07vRyJd/cxxaUO+SA0AoD9lL2k2nzwCszWvh
 nW9AXxX1gTCCe+wxKObWzHnTXE+T7uhtZbLMIQUgtk/NLL5m5Yo7t1D
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch makes sure netconsole clears dev_name for devices bound by mac
in order to allow calling setup_netpoll on targets that have previously
been cleaned up (in order to support resuming deactivated targets).

This is required as netpoll_setup populates dev_name even when devices are
matched via mac address. The cleanup is done inside netconsole as bound
by mac is a netconsole concept.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..02a3463e8d24 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -242,6 +242,12 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -284,6 +290,8 @@ static void netconsole_process_cleanups_core(void)
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
+		if (bound_by_mac(nt))
+			memset(&nt->np.dev_name, 0, IFNAMSIZ);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

-- 
2.52.0


