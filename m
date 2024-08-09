Return-Path: <netdev+bounces-117304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221094D843
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B248C286604
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7111607BB;
	Fri,  9 Aug 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsSQRDx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E7224EA;
	Fri,  9 Aug 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236930; cv=none; b=htv/hULcL4kL4/uP6kQT09wvdQnq45x6Em5dX4LMf5hO2PFYV7kU3SQ9dfhKs1ycdQd02lVhSO4jvaM1jdHUE3Pvqx2f17Q5987mAHMxHJZgqgFgmRUJAJiOTqvN/U5vAmUGzskzpW4iLPi00rdNicbQkftH19nuFaE6kHXV89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236930; c=relaxed/simple;
	bh=FOXIA3s7/523aDSN2iAsaaMkgGW8Z0eWkZ/Jd7tkMxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMI4T8KUZLcRbDAYZrOm82fDjHmFPOpRqH+G7LYv84l4wHKNKvZZVzlcpwWnk/eNj0zpJYbEpFsUDaoAcBqjbzC9ymEO+rWMzZENo4iCnc8Z6DtInrItFnWThcczhwXrmKublDu1gz3qGRcP27DDa9KSz2EKpoH2xWi7dseUIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsSQRDx+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so2292088b3a.1;
        Fri, 09 Aug 2024 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723236928; x=1723841728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c1GqHTN3Y+hCZ7uh3Ld3nYqp+FsWYJYMIreLXNgkPE=;
        b=SsSQRDx+Z31NqoeUKqjD2ONXKLcnDaMx05pPRsoKhUrdVBEwAPDhEKp8TXJ14brmIN
         l2IfbYKIak+ZzOvluTZ6zf/73LPIkWgIoWfRl6O/WC2Ab5MEZgs/uPbOjUonXvkqZ9+I
         HPN30jfADDllA4pWtaui0DTrTMY+EylsxF7pw7EiOmMNVhF2MsMj47CbVKLjOzVKKCit
         tLTrgdbj+8Gwtc7zzNcXZNS00waIK39crxOrcL33X3MdNgIcRuKO11f3CY/xo0xdvhvW
         6tMuoA+E3/npo/l48vG9SMDK0x+YNqHbgNwf8N9cWrnPYOAfrVbpCxkQoS2wqFpdSnjY
         kaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723236928; x=1723841728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c1GqHTN3Y+hCZ7uh3Ld3nYqp+FsWYJYMIreLXNgkPE=;
        b=QedFtdB006iX+CZdH+vD0ckyETDCtmWBtzzLmBApLzlXwxIAaIfl92QmIPpVa3Mbld
         MoAH6FxDAw7GsXsKW6n4ILKD5O8gs+SQHSjeMKquXZke5gjexAWmTlYrSAV/biQXWXm1
         gibnZ0X21tgT97oTnZdN8ZH2tz7TZZnzeNC/V8/MMTqzWPXJeRRLKYLl4ZBiZh1Bfwac
         4OY+nNnHx+QETylrJXdlut1qVrik5sdvcQeLbtD6wkfIE/oUeUQOWq0+w2TvzpjlNjQT
         FicESdpgaBV46OlGDlDL3aVrRaT6QjHIF2hCGRkpwKlvIYLWqElCsMdGjlUFaj2Ei8Df
         vfeA==
X-Forwarded-Encrypted: i=1; AJvYcCWrNv/Iyzk0PoOl20dtyTjbqKhX7cF6mc287B+mZD7hs+zfyVa8ljiksaBovz+yYVQLx4Zt5pjnGJkeZsDH4ea2PFeW4b4V9AMxqs58
X-Gm-Message-State: AOJu0YzinG2OEUn3rlvUK37VOBo9g8Pf4LtGxAdOFOiUOpouw/qfhCgO
	nokCTrAiJma9zLNN4kllwwLQFQKjHXnTgf/n7g90jxnaOOQcmpPaX3lSDh4r
X-Google-Smtp-Source: AGHT+IFAQ1Sd98vpple3fOUc7JtnanGjIaCMtOADbr6SVZi/8q5KpDR5wL6GDA6+X3CuTMY0+6h72Q==
X-Received: by 2002:a05:6a00:17a9:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-710dc75f7f8mr3855902b3a.15.1723236928060;
        Fri, 09 Aug 2024 13:55:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab56fbsm169021b3a.200.2024.08.09.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:55:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nabijaczleweli@nabijaczleweli.xyz,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	justinstitt@google.com
Subject: [PATCHv2 net-next] net: sunvnet: use ethtool_sprintf/puts
Date: Fri,  9 Aug 2024 13:55:18 -0700
Message-ID: <20240809205525.155903-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler and allows avoiding manual pointer addition.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/sun/sunvnet.c | 34 +++++++++---------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 2f30715e9b67..1e887d951a04 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -114,37 +114,23 @@ static void vnet_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct vnet *vp = (struct vnet *)netdev_priv(dev);
 	struct vnet_port *port;
-	char *p = (char *)buf;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		memcpy(buf, &ethtool_stats_keys, sizeof(ethtool_stats_keys));
-		p += sizeof(ethtool_stats_keys);
+		buf += sizeof(ethtool_stats_keys);
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(port, &vp->port_list, list) {
-			snprintf(p, ETH_GSTRING_LEN, "p%u.%s-%pM",
-				 port->q_index, port->switch_port ? "s" : "q",
-				 port->raddr);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.rx_packets",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.tx_packets",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.rx_bytes",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.tx_bytes",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.event_up",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.event_reset",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&buf, "p%u.%s-%pM", port->q_index,
+					port->switch_port ? "s" : "q",
+					port->raddr);
+			ethtool_sprintf(&buf, "p%u.rx_packets", port->q_index);
+			ethtool_sprintf(&buf, "p%u.tx_packets", port->q_index);
+			ethtool_sprintf(&buf, "p%u.rx_bytes", port->q_index);
+			ethtool_sprintf(&buf, "p%u.tx_bytes", port->q_index);
+			ethtool_sprintf(&buf, "p%u.event_up", port->q_index);
+			ethtool_sprintf(&buf, "p%u.event_reset", port->q_index);
 		}
 		rcu_read_unlock();
 		break;
-- 
2.46.0


