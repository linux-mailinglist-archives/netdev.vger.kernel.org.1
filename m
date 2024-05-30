Return-Path: <netdev+bounces-99590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4588D5667
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D202A1F239B8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA21862A1;
	Thu, 30 May 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HgqsFLjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D7183A71
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112615; cv=none; b=T0grZwaL9otJOTi568PJhwAuyEBplcWe7L5YnzN+ZuZrwoS/lZ9f0+xRl/r2ucp4inK+oaH/pVlXj3+jl3yjsz4RwOAKz9oYAEPZjNYoDt728wRQq1wYKU0ZghDYHyOKr6aDbtNuUtwDT0sHWMGwjqOhESSz3xvhCxeHW9L8zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112615; c=relaxed/simple;
	bh=ltzXXLPD/ETo7voCPkE9iyg3r3LgEMh7nkLmfXKk4pY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ACbQL9SpS4cARcQVJkdn7F8W+HkNRABSrDiOi/2ldU3kGEJQ6bfDvBNMa/koOhGmYHjThAaOuGHum+s6rvGCqizBBNQjBjWjScgIRXkG5JC/7s81py6NMD1UXdzdML768wF9eJMCxVJ4vbzsWZXEQiR4wcT9axvY06IfK5HR4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HgqsFLjB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b4404dfso13343885ad.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717112614; x=1717717414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9pq2FYeJqKIzHZBODKgIJ4xCnulDhV4vBp41eJFOEo=;
        b=HgqsFLjBLfpvUEnQTNUmKyaS7rN6Vmhuc+ZPw92tpXqE016O/4K4zX/BggFkLPT3v7
         Wk1iVPK+KrdsfE8DlfOmdILIeBpjPCj9fjoxExvAJ0O4GjKEWhCxuYn9rEWZ8Iz5l+lK
         aHZFqWPTYjgkSSV6i9kH8TH8L9gcvGSMg4+ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112614; x=1717717414;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9pq2FYeJqKIzHZBODKgIJ4xCnulDhV4vBp41eJFOEo=;
        b=KlVSF/+EEDmZ26a+5iUN41HcjXFhfKai2iHDoxw0s2FKsVn1eJpTtP1Wj1DZkVKnG5
         0wb4lZwFCVzFB1CtLm1TM+p1uxx8TYvbmItPKiKr1EyOtKWNlffUfjNgzPyfUn7+MTT5
         w7oBjoSqLTWkfTxo9XBK+Qj9qrVbMgCp8ZxDEyhSmRJA6xu89lwUmpbos2oZt75FgBmq
         S+hJT0zHPB4n1lh+m4NTUgf5a+GaOr0llLGW7zyLRV9JefWQpEpEKT5bvXw2dZhPyuHJ
         TdLqsFHjOcsHqGruLAfsmJMCIWSu10r+BkPdgP28x91rNsJ7jtetz7resnWbKduFXypc
         PZfg==
X-Forwarded-Encrypted: i=1; AJvYcCV2664pLiNaNmPwQgvxyqHcYsyb1YphGU0MGh51vYAv7naocOSncKvS2vETQWFUQIEcuD3ra+j+FHN91f0mW7haBTOCJU+E
X-Gm-Message-State: AOJu0YyT7lZiINdf+HNqwPIQ468krM+wUqMdDr5u/bSmNR6RyDXF7kDd
	zTwhc1LdB3+9Kv2KotzWzlloh4jbpg3MuZKGHx1CeiPrXjbDZNVAOjqynuJ6Xg==
X-Google-Smtp-Source: AGHT+IFzh5XzJPXNr+dYh9ZG2MQMwUQ4xDLkV3daefC9PB62bsOX5ogl4Mw9hYuGxSfZLlxDMNS2jg==
X-Received: by 2002:a17:902:e5d0:b0:1f6:d4b:350c with SMTP id d9443c01a7336-1f6370ba643mr3254985ad.56.1717112613789;
        Thu, 30 May 2024 16:43:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:564b:72b6:4827:cf6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632416d90sm3459275ad.285.2024.05.30.16.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:43:33 -0700 (PDT)
Message-ID: <66590f25.170a0220.8b5ad.1752@mx.google.com>
X-Google-Original-Message-ID: <20240530164304.REPOST net-next.2.Ic039534f7590752a2c403de4ac452e3cb72072f4@changeid>
From: Douglas Anderson <dianders@chromium.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hayes Wang <hayeswang@realtek.com>
Cc: danielgeorgem@google.com,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Grant Grundler <grundler@chromium.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH REPOST net-next 2/2] r8152: Wake up the system if the we need a reset
Date: Thu, 30 May 2024 16:43:09 -0700
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240530164304.REPOST net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
References: <20240530164304.REPOST net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we get to the end of the r8152's suspend() routine and we find that
the USB device is INACCESSIBLE then it means that some of our
preparation for suspend didn't take place. We need a USB reset to get
ourselves back in a consistent state so we can try again and that
can't happen during system suspend. Call pm_wakeup_event() to wake the
system up in this case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 6a3f4b2114ee..09fe70bc45d4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8647,6 +8647,13 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 		tasklet_enable(&tp->tx_tl);
 	}
 
+	/* If we're inaccessible here then some of the work that we did to
+	 * get the adapter ready for suspend didn't work. Queue up a wakeup
+	 * event so we can try again.
+	 */
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		pm_wakeup_event(&tp->udev->dev, 0);
+
 	return 0;
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


