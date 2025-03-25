Return-Path: <netdev+bounces-177624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F03A70C0D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237241712A4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D727267B9D;
	Tue, 25 Mar 2025 21:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90632269820
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938266; cv=none; b=TE5nYdtTEECkF0l9KGeQ/zAA1k6ioH/vIbNNyxZkE6RsWse76/A8yK5sKPe9o1f7lnOwGzONI6EcHXLHIQQWbD2Evz1wCKI5QsjXuuuC5VJgE+lej4f9d8rPmARWPsz4eeTFLfVaPRw6vpxD84JQv6JZrSInB5kruezB3MQ10+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938266; c=relaxed/simple;
	bh=No/0VfPK7pHniKtbbaQJ0cyWQL9HoLVC3b3WbWBLe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSgUcmNCiGVInV8uz70IArkItZTCmZT6bc++r6e5nTDkIWf9OSP3coqYHDVmL+ArrNd268VtWTbIZbwzdh2KEyOMea6qus0qExC9RTmvE/M1Fzvn4W4dP3dVvfNEZG8xHckp+cJJ1q5ACwxeZ30BcjcPQnYjM9RC2xM1UQ9wUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224191d92e4so120824535ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938263; x=1743543063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOUxfu91P1ktbOKHx7UEPpGlhg2bkdrt6E9z1Gl/UMk=;
        b=N7nUwE7gDDB+Yhu0LCZ9OCLZj6cuse6T81g17adUbcdjoiCAOlYIg4dG2y+MtH1aMs
         /oeWqDY2/FAhEHmwrJq1y6dBpz2e2hskBS3K1vpjUwnFbjm6WUJ8LkcXWJZWiUWPBwcn
         pGU/B308e4scy3dYm81gviQP9kikfRBkiwpGam8241/nRj112ZmW9HbTWt4WZPI99cp5
         yB98OHlP/MYF3EMRv9Om1bZLCaTt8qxOuRIrGHTbxOFvS9aZsjje/I/5Fe2w7+mbXfRI
         AFvHADHWevREzUsRMrgPt07dEKhinrRXfQiezwTdFb6Fn8JO4bkCLAxCRdEKVT993L4G
         YH+A==
X-Gm-Message-State: AOJu0Yzp2F4HYBMT3fpwTmj1MXPur5yjl62Cagbhn63hqfiFLU5g8qKN
	J9RZoyQPVoReWxYqOc5FYXAXhlYS3O6Kp0KVr2Akb2Z4LoPWkL2xDMCRTBIvIA==
X-Gm-Gg: ASbGncsnzLYrgm50zU8T3daWXJfEcZIe5NaQ88/dnyUBpigyBzgdXLIdZ4+Mgyasjrj
	AD5DBqI5ZDs00rzzyhNWm40C964H1svuE0qxbrE1RdXp1a2Yzwanc7lk0wFJ90akuPYSEANjGZ/
	b8Kzmm1p2ebVKhchTbAbVZGseuAe3WtXd9F/5PbPMMidKa9jK3bfbaMoTauyLPtrzIlAZ/T4o3X
	LZoiB7BBW/UKo9xRMiETttphEuvj7vCgvdqldGHTJx48ebFd+/T62u2Pnz/RJbXefGvv8ThzH22
	TLKbDaVEXfu9ccwmdgUth00nI07uZzgoWdOzWi7si0tN
X-Google-Smtp-Source: AGHT+IFaTFXA4c18TXOPsCkqdzuAjLzJMdJ36/UE6qKMgOWlpKRRDkXbBhWA5/eqY04gB9GIZ8gzNw==
X-Received: by 2002:a05:6a00:14c6:b0:737:5edd:9805 with SMTP id d2e1a72fcca58-739059f802amr28215118b3a.19.1742938263303;
        Tue, 25 Mar 2025 14:31:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fd564fsm11077708b3a.52.2025.03.25.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 4/9] net: dummy: request ops lock
Date: Tue, 25 Mar 2025 14:30:51 -0700
Message-ID: <20250325213056.332902-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though dummy device doesn't really need an instance lock,
a lot of selftests use dummy so it's useful to have extra
expose to the instance lock on NIPA. Request the instance/ops
locking.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index a4938c6a5ebb..d6bdad4baadd 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -105,6 +105,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->netdev_ops = &dummy_netdev_ops;
 	dev->ethtool_ops = &dummy_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->request_ops_lock = true;
 
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
-- 
2.48.1


