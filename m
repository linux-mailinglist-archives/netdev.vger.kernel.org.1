Return-Path: <netdev+bounces-230042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0ABE32EA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7DA2357D15
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79631AF00;
	Thu, 16 Oct 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGYwDRjN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF03164C5
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615492; cv=none; b=J679E24s/T2gHKwZqjKfpp7ODP4aXJwDXh0bZufq/xiZsjqs0nUAU9Tl3Ox087IbZLF8ejLDevRZkjzdVHzNfMcCgLPYEOk+nItbdItCovfCZrEPJQup1HhTMJx/d4UZQyi7/3f/Wkumd+5/WqmwDRdN57rfSZi0CM+ofH83IHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615492; c=relaxed/simple;
	bh=OjSFPt9VSLki1A6DdfmFDkboVmlze/zQvmvT8N/9c78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esrtR3Ef4KDTY8d0v4M24UBpDs7e4q7g9v+PXX5WgHzLYG7JEBsWJhvyj4MV4J60FCGfxc4UoGgrK6R2F/FNzN9AocYvQWxd9K5Mnd7ENOXhZ/ff2kWbjkaxRLAjKawzXtCg1W6DJMsk8eGHFtwgnb+EjarqFsrXELgYG7dA5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGYwDRjN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so636407a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615491; x=1761220291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xOSgUz/V+sK4rxHUTxiLltJs0nxQ43/KoDm+SVlcFk=;
        b=LGYwDRjNKNwDwjGBsxq9exanu3UObAhmamcVszFPj4GSq57Je2XPMnS4avpQVPnpuM
         zQF2K3sb+jJfb43zVwcBbwVqEAqxvuvQgKROwbuUYJ/DYCFgHpqVfVOcRJwICw2Inc5I
         f2FkhQQlOBvjiTKCMMzeej1cea0m7sMHT4wLIZ3nIPVxlNbTte/6nX7gdR0tXC4cTl9p
         ptSggJ02UINtRF6nRKOMHaRRpXYbuHniDBm9cpHz/l840v0fVkRrLRqHcQMzn/yA+lH6
         NCMi6qiZUX1CuVScXYKB3niePC929oZ6jWrR52HwzufHJwLV9PdL0wK/S8jDQaNLgMX5
         +6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615491; x=1761220291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xOSgUz/V+sK4rxHUTxiLltJs0nxQ43/KoDm+SVlcFk=;
        b=I1GCefbqNS1yvKcfchkN0RAKDnkrhHOOPrbXgeZi4zg2RGeC18wo361PjuPcHnLg5F
         nnSNcO1xHVT1ebuxcUS8NQEtmOiNT6BMCG0Us5gkzzj1QvHugrtdsTUCWXcA/4jzGuqy
         CMhHy+tywnFDsmeoy4GIhyqQ1kqTY/BoRVVWyr+L3xYOREL3biNSQhewoZrFEnLGEoDB
         Phb8wWyLoAgsZrKGM54IJC+MSqv1vLHrqi2EvMAbO1jhG/UuwlLRIsn16RjBw2yeacmd
         OjU/kW18RQqtp7Uf90aJ5VlPKI+vWpn5AgLU0KoUXfX4E/tcMj2TcaM2XmwJdV7q4xmd
         ofEw==
X-Gm-Message-State: AOJu0YwJRO5X3NSg6unVNpQSCe6oIXgKehQ7KFB+GkAhhhrlM0nopcPT
	/kRYCgkla7BzshzCn3KO64RUuqU0pXg8FSDEgudCOzZvymn44AKPVtvwhOcF5MFN
X-Gm-Gg: ASbGnctxEFnlEb+tfkxWaHituYqwJVUfQeAE1BCsQBoLJj87JAV4ll4UTgkhpv8/jdY
	A15aw70imaLxWE5wFo2Tes8D4delP5oDeW2XBEKRVOac9upE6pjY6NFOMZwsOMt8T8a5kceowMz
	p3UGTyKvmRRqEsVpbpPDo8tqUPwPNp3BFU+gxYn7TmC0ikKtIZzquasHABu83htZ+msskZAJnvj
	m+sVYn0/SBRyiTaMcdLM2SSMLST+zbQ5iSoMLkfcs8py34CPNi1lOol+HOfM0NttRJ0WJrE9yq+
	uI8gLBmfN5T79nMtDDwZhq9PRFFJ3Su742+Up/thwWvujimkdx1ORYapvp/XbLV/PwLt4sKen2+
	AVfQE6g2ZojKDUWaLbSBgEreaSncgGGr5KCyc9lfIMrjfWy8uIcprZiTZucge0wDKCNYI68J/vF
	qkN1Ghbxfdou38Kbo=
X-Google-Smtp-Source: AGHT+IGUjrpNt81xK5XYmxMFHwQECczgygWd/Jdjrk5myepWQRq28snnZf/9ogDTe5oN1TolYatp/w==
X-Received: by 2002:a17:90b:3843:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-33b513b4c9cmr40265283a91.32.1760615490541;
        Thu, 16 Oct 2025 04:51:30 -0700 (PDT)
Received: from fedora ([27.63.24.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6519421sm1695909a91.1.2025.10.16.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:51:29 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [PATCH] net :ethernet : replace cleanup_module with __exit()
Date: Thu, 16 Oct 2025 17:21:13 +0530
Message-ID: <20251016115113.43986-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update old legacy cleanup_module function from the file
with __exit module as per kernel code practices.

The file had an old cleanup_module function still in use
which could be updated with __exit function all though its
init_module is indeed newer however the cleanup_module
was still using the older version of exit.

To set proper exit module function replace cleanup_module
with __exit() corkscrew_exit_module to align it to the
kernel code consistency.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/net/ethernet/3com/3c515.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index ecdea58e6a21..4f8cd5a6ee68 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -1547,9 +1547,7 @@ static const struct ethtool_ops netdev_ethtool_ops = {
 	.set_msglevel		= netdev_set_msglevel,
 };

-
-#ifdef MODULE
-void cleanup_module(void)
+static void __exit corkscrew_exit_module(void)
 {
 	while (!list_empty(&root_corkscrew_dev)) {
 		struct net_device *dev;
@@ -1563,4 +1561,4 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
-#endif				/* MODULE */
+module_exit(corkscrew_exit_module);
--
2.51.0


