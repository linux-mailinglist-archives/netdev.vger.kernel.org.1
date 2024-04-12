Return-Path: <netdev+bounces-87259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3B8A25C0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A2B2386C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E981CD00;
	Fri, 12 Apr 2024 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7Q22T6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C11CA80
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899983; cv=none; b=u08o+B9a8TPqJRB8y+4ahmhDWuqJPZYVVHTO5oA7jP74iEhnFbYmG03ELV6wy5ZYXgU+rpg6MAoFxRVSTmJ4lEIGa85+PzBgU5v/w9X4vKfMaf4XWskCqLIrbpztLnLLJwgOsTDr3x9cCnRkYEWPBPwUdpRjdsnQ83xbbXykBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899983; c=relaxed/simple;
	bh=RhU7H8LigBvMKXz0iBQO81D77/UFtCO8smHv/Pw+CsE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MvEtXqTCX+YjHsTUYfngIZUG9wBSlZKMyuDJV6jDaO8Ey2xgF5ovQItEZ5vU6kWVTUmpz723Z0empK7bmz0J0aRwVjtto9bKDfJ3xik1Z04/mWJKzCYqi1052wBiEudeSzuZDYGXJFeuUszrEnJUmQF27nBLFXaSI/ZuywhgmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7Q22T6u; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed2e00aa22so460945b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712899981; x=1713504781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I18PVS5+hp88W36auOHHd3utzWkizZTfFP6CdDHLunQ=;
        b=A7Q22T6uIJ4XQLbs5EGEA9P6yiv4s1cHoM/1CMTQt6lOFQBuwQPYvRbymlyuN60CdB
         ofm2FNPA6HoBv+HocLyPyp4+lAx6wTf7JVbid8pljgs6h0fGJOxHwjsmDmxQhknm3xjv
         n3oanEAARrZ2YCzzDSn7KdjgizdoBdxf4WHhf80TwRBMazWBOQZj0Nqtg8wSpCydMa5H
         23qNS45SZk+Z8fCHugnqcKL6VfbUrFq+Zn5qWOgCulMPfxY9tl+aBYsbDj1OZKBYgBi4
         3CeujhRW3qBG8JkwPhPB5fuFalsgynyUxY4yNuwDfKF6S6kpO7jC9cVYLHX5U+sJEh50
         9pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712899981; x=1713504781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I18PVS5+hp88W36auOHHd3utzWkizZTfFP6CdDHLunQ=;
        b=hz4ZDjw7zHfUvhwRzVpXkkOipbsF3O381afFbAMGyQMpvjsmuG6OnWJq1qJvadr750
         w/Re9bkl8vDqx7RJg3s1hcwB4+EnPjJILxPmXA3+6fJkz6NpSKimalKP0oXJ+zDRUMVf
         YEekT+JkwnrVUod5aMvyih9govg8Z6hzay3rH9f0iPEiTOLA/PXuJJbbvAcsoYrbYphf
         JTCFzlPgPyNlWI6DjR6lu5reHrpmanXWGmtSUc1gbOapfo7b7S71+6hcA27/A/wsVDou
         niiRAdQiSTkdc3i+tRndIBp22RVz4DBM2g1uRDrvYbizhGR4iV6B8WqdIT370Fn4GhGb
         KX4g==
X-Gm-Message-State: AOJu0YzwRz5Sa9QsQkMcaFr8DR5V8E7uKB+SKsu1spHgCJnSdv/6jBeo
	N09ONT9A9yAvdb8uqeYmHd94oadxhB+Jm+WtBSv8SmLUZ06OsxnFGIbW+czATqkrPGZTNAbtOsv
	Vm+7aGpJiYnfbmay6BkceEIPYfK9Mpjkq/1YIo4wnEfNdacxfSM74T5KLRa3kKRoG8H1P20c9i2
	MAwU1UqrYd03MdEHpKllZK+OB43ED/apz+nqC0zw==
X-Google-Smtp-Source: AGHT+IFaNpZHpB9MK3Cn3XiFZhZknOnR/sTxD2BrCTzipkjLHznnmowuIgla7funhNYy30T2RQnz+gwgGqQv
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:9ba8:8a0e:3bd5:11ae])
 (user=jfraker job=sendgmr) by 2002:a05:6a00:3986:b0:6ed:beec:8496 with SMTP
 id fi6-20020a056a00398600b006edbeec8496mr124382pfb.6.1712899981155; Thu, 11
 Apr 2024 22:33:01 -0700 (PDT)
Date: Thu, 11 Apr 2024 22:32:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412053245.3328123-1-jfraker@google.com>
Subject: [PATCH net-next 12] gve: Correctly report software timestamping capabilities
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shailend Chand <shailend@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jeroen de Borst <jeroendb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

gve has supported software timestamp generation since its inception,
but has not advertised that support via ethtool. This patch correctly
advertises that support.

Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v2: Used ethtool_op_get_ts_info instead of our own implementation, as
    suggested by Jakub
    
 drivers/net/ethernet/google/gve/gve_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 815dead..299206d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -784,5 +784,6 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.set_tunable = gve_set_tunable,
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
-	.get_link_ksettings = gve_get_link_ksettings
+	.get_link_ksettings = gve_get_link_ksettings,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
-- 
2.44.0.683.g7961c838ac-goog


