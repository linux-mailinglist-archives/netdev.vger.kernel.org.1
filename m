Return-Path: <netdev+bounces-65520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFE83AE68
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E82B249FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CE2207B;
	Wed, 24 Jan 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4UuPzvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB4695
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114053; cv=none; b=BeglyDQpPHbv9wEfsLOaueYpy01WO2mDQFpeZFv4qNQL6SOUCVI78TrdHXIW6LryyeLSXdhG6m4BAVRUnlal8Ve+gcc9z876xjafyPkCBnvPNVY/99KIfF6I7nY+moKDiR0U2TJht7VtAQS2eyWcuNFScFHJrT1NUdH8WzGveFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114053; c=relaxed/simple;
	bh=HCGI2ysO72BD98aEj1ZIcVN8Lqor1J8jBpFzCeiyU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMtHEuJnmveb2SWiPBc8NJyiPlD75dmXHLQPu4Jj6rKfsjMLl42mU7MCoaKYRq4ypMrdyk+lwOLlv18pYiJrmor0LuQ038g4mmFwLGzdZ+dScyxnSQ/dilUw6aHFzgbGTRjg6GM3KVMSPGj8Qa6FchQpX0jpxphGFRqtDDQD5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4UuPzvA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso62419665e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114050; x=1706718850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxjjw7kWT9fxiWeBYhuayl1Pi23w8I8NIg2tr01+uqM=;
        b=N4UuPzvAOqyHVZxas48nI7OVPsIePe19Qza2D8QY8TIx8gQdifQDLJknkfULSNSIk1
         dz2Al2Xb7rYNYK3mZtpnnS8MK55VMCshMrZb0TQ/jWSQx/GPLPSPVAoR5a0+A+fHYPJO
         3oDxEwvZyqWcFF1qkS71xR6j0kcDSx8XB7AG/J8aSQc4VnJROc9R+EMyXo6fvfpxLjqU
         VtmKrvb3oHPbb3ggzphtC1sQ0ApVE1PSvuU3utadbbJ8h9pWblHPQTbPMEfkSnFgt0Do
         ZMNLbSJU/3Y4xNSJ5XVnjmNShI5pBK/wC/Jp4pkVuCcl8Q3NkoA49eyMyX8BO1UE10RT
         OyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114050; x=1706718850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxjjw7kWT9fxiWeBYhuayl1Pi23w8I8NIg2tr01+uqM=;
        b=n7aW0KrKOHa9sayCoGQDEdTmIoW9coP6iXXBH2+5UiIu+Bq+GMYd2fgblJsd8JZD+4
         x8DZBuKGjQTzYT79KKFwRe0WJFQnCBPPGqAHTMuLLuUZnMboCID+y8UQE1s1rM6Obcd+
         wuoTPby3b5kBUaZvoyXZTInKbtJuFnjWiA8ZMG9MSzJ1uYOWcQjicUbZ1WgOKPdn7qqi
         /x5+/c5aD3q2pW8msw7Flm355yyBhbejZK6EWbhsICNbXjiMHf6jsJxUpJI2wNTCc92t
         6C15nDnrSuUmRQEZ8fjR7890+IkWsmH5NZjn12b2fSrMtA1+zF62bLfNvN45ivYGYapd
         biuQ==
X-Gm-Message-State: AOJu0YxHDFW73mrNvKa2dsIJwoE8XhxYwV0sfus258diuHvq9zVFEZO5
	Dr9kgiiGjjhlOhH//kAgwvjHeabJJh+Sn48PUp5xhx0lOafADcsH
X-Google-Smtp-Source: AGHT+IEQK9yk8a6xXWMQSx7Kz0QKUH+yEkfqPUQ0/mWYILH8zLqYgv2+q/0Xv7UNImUndvncs4qAMg==
X-Received: by 2002:a05:600c:3f94:b0:40e:42ae:8872 with SMTP id fs20-20020a05600c3f9400b0040e42ae8872mr1637632wmb.118.1706114050058;
        Wed, 24 Jan 2024 08:34:10 -0800 (PST)
Received: from fw.. (93-43-161-139.ip92.fastwebnet.it. [93.43.161.139])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b00337aed83aaasm19082866wrw.92.2024.01.24.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:34:09 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
Date: Wed, 24 Jan 2024 17:34:37 +0100
Message-ID: <8d37a9994848af6c9230e39e7977b3612019a88f.1706112190.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706112189.git.alessandromarcolini99@gmail.com>
References: <cover.1706112189.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
entries.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4b21b00dbebe..0468070e7872 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3375,6 +3375,7 @@ attribute-sets:
       -
         name: entry
         type: nest
+        multi-attr: true
         nested-attributes: tc-taprio-sched-entry
   -
     name: tc-taprio-sched-entry
-- 
2.43.0


