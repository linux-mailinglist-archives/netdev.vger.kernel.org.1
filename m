Return-Path: <netdev+bounces-130623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAA98AEDC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C01A283B01
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6751A2848;
	Mon, 30 Sep 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="T2cUJEeo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C81A2639
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730474; cv=none; b=Qa7pYja+i5GLf2cmrCGqPHXdXYHp3AU41j2w0Z0igc9HRVSPIrUGbVF0py3h+8mgWRmvfk78aqaGy+YyejcGzIC+8VEAd1cQjkSwmF2UPgUeeacMfnlbV3yS72bPKGnQgPUa/ouekOqJ6tUFKrFoJ3KxZ2PZ+fkwPIfJQ3dZ/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730474; c=relaxed/simple;
	bh=MRG4Qw7E4YBbKNWedcjumZXZDUAA8qr4uNaUb5Zug3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COreZ3MnU6CvRbJ34ayOGC7Cs7u0l9j9lHjnDvGu2y1SuMvCkqwzATERnGxu49+m8H4TeQtXynI+4zdED3nt8Cg63dgvmOamnytdvg9bDSbhqBVFRs/L8oMWiL8y1j5ZMR3ufKVTOOXO/yhC1QYpJ6NbajBbwhAGbi5sdcFLGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=T2cUJEeo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so3609920a91.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730471; x=1728335271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyxjnZ31gvbkSw0sDH6N+yOn/m2aJIx7PHuEzDZI3tQ=;
        b=T2cUJEeoV2Q390KxDgpAWgLJcVVb3t/h8gOZ9xmQxxaY/jUrlmA6AjKBSs5FdLGNtc
         ZY0jqjj8EPYpDg3gn0Su/kvlKgZyoCzyYNqY0O2aHfk5EqxicCh2Q5YbjVNDl5rwbdbg
         ggWPBcGzxrNWCySqbAxaqbLaDxi4ks+xjVjQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730471; x=1728335271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyxjnZ31gvbkSw0sDH6N+yOn/m2aJIx7PHuEzDZI3tQ=;
        b=MkhUMfjaBPogpar/gSZAEP4xJjRyz7pRuoNAXgqZx7rZu3QHzlT3LWlhDDGC2ZDu6q
         ejdCGafR8iIuu5ELP5U3Y6avjioifPYbhDgoOPXE9XBKZLQuA9vYbyQtQJ817iEKMjhx
         +cofG/zrNf7y7kT1adpNWWLuRHcdeVpM7/9pLDN8xAs7bvWDW61zs1F6Ny+F8i0DyO2X
         n1Oj4F/+kTiQlrx6p+wlqHT1NQzCgjLFYKvDWthH7UYSG3guTcjEb6oWDfu2s5f6wz/O
         PMul+qITMUhPMwqjkKnsS6iD76v/GyYCRh54xSONKVqj+DVeMuGvqZCCYv8EorYcM5sh
         hs3g==
X-Gm-Message-State: AOJu0YzCls9YOXTVcXqNptErkfVZLddfnFfzmp5n/uA+brGrMEVMD5dQ
	ncRq8/d2WZpLqNpJyOyPndzABSFi1Cafjm+JEDYcBC3HmaHQHFZe8T8FKGSjm7QLwanwiEVVKV2
	i7oA5C4a6BHqv/3fl6xfWhwMkpXeQXhK6cpAlGDmadM2EiDo3ndofpvxHVm3MxHWMeD4xtXz1KS
	nMEHFTrydBtOcn5wuOb/D0250wN4i1bye30uHxuw==
X-Google-Smtp-Source: AGHT+IFb3oTTCic7/8l4M/A3jItkyCGk9Gws4Re4mLdNRjdN871wZIkPkYcltGIClapa/F1SPQJh1g==
X-Received: by 2002:a17:90b:1110:b0:2c8:647:1600 with SMTP id 98e67ed59e1d1-2e0b89d27b7mr14270092a91.9.1727730471361;
        Mon, 30 Sep 2024 14:07:51 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/2] gve: Map IRQs to NAPI instances
Date: Mon, 30 Sep 2024 21:07:07 +0000
Message-ID: <20240930210731.1629-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930210731.1629-1-jdamato@fastly.com>
References: <20240930210731.1629-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netdev-genl interface to map IRQs to NAPI instances so that this
information is accessible by user apps via netlink.

$ cat /proc/interrupts | grep gve | grep -v mgmnt | cut -f1 --delimiter=':'
 34
 35
 36
 37
 38
 39
 40
[...]
 65

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8288, 'ifindex': 2, 'irq': 65},
  [...]
 {'id': 8263, 'ifindex': 2, 'irq': 40},
 {'id': 8262, 'ifindex': 2, 'irq': 39},
 {'id': 8261, 'ifindex': 2, 'irq': 38},
 {'id': 8260, 'ifindex': 2, 'irq': 37},
 {'id': 8259, 'ifindex': 2, 'irq': 36},
 {'id': 8258, 'ifindex': 2, 'irq': 35},
 {'id': 8257, 'ifindex': 2, 'irq': 34}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Fix a spelling error in the commit message, pointed out by Simon
     Horman

 drivers/net/ethernet/google/gve/gve_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 2349750075a5..30fef100257e 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -111,6 +111,7 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
-- 
2.43.0


