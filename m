Return-Path: <netdev+bounces-100722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A598FBB5B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F91C21A0D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FA1E501;
	Tue,  4 Jun 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0f1f9pY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857B12E1CE
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524917; cv=none; b=Hd6dNYKIfoBoBlSiolFh7UpQSxw2S7CVrsEuKCWaRtoMZEUiEWQKAZuLjsR78s5RtHA+cB/qc4ACu/x08OZ9WTzi2PGWEEINhEmPB9goSgAEysFR4q6nyxVBMHlazy4Eo3OrANgzMkz/Zrk+zNX5HREZfGpZ1jg3781J6dxzvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524917; c=relaxed/simple;
	bh=oEBYDA+l1ZT8i3xc/B4pWvUGI/kBufHifLifs3/13QU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FVhimzVU+HeSGHV7zW4Z29OMde0TKvyTZGd8oTuZmYcYU20cYL1PCkaPsuey2lexAr0gcyYRKFHVWQw1vuirb5uW3cE3GwMjJ/J9NG5Rpmys/hYnvhBDHp6mBfNHcNbWJaZqYydhR32qgw63jqtUf95FOrMHh/BLziaYzRctQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0f1f9pY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso2086412276.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717524915; x=1718129715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YT+emaznZX/ZPNGwpF0CBnQBYnTw1oR4awevf0HGUvA=;
        b=g0f1f9pYvrfajCQOp0oABHQhYvWIFcFGKtxUwS7/D/VPKNhqttMGzJH+VSfejs6d42
         /dxLtzGZY7WE6N8PEEqF0z1nY6k2Ec6A/3qKnA+JllNe4Yp4OlZAoGB2HN0smr0NMh/7
         6sU9RuYCiciEN2rnxzjgbYrHopFb7INucM//4ELNMofulgoSoZklKEhRLQNYk6uXoPKZ
         AbQnrApzNF1nCaIZrvHdqXAbLTIC+YYc/Y/tXnA1RjqdElc2k0DvfEA3oEU17j15cPGU
         1aMXq2ZTAnUvrYIyR4ZsbBDKrVBeYA7qM5GR66530LEnL4gxNSLAxM3ufvYdU45JfEYB
         Tklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524915; x=1718129715;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YT+emaznZX/ZPNGwpF0CBnQBYnTw1oR4awevf0HGUvA=;
        b=KKj7Hnffr0aN83dHNxjAsxvbwYwnfkUcJjHvBjKEDdWEoll8LV5txcZiKdecrFTemH
         qYHixKb2meUJ/RUBe/PKIEC+I8Ly59iM0oP4JGrSjv/zZNPopJUJ62t/nRo/SrTZzUd4
         OYsipZosCdNeKS57jN7RpO2D8JpVK/5411t1LPJx7UhePCqr070eXt6zJa98dSuC35qS
         n91yuuuf+TUZ48CPAAXefOZwmE77K5lqfR0o/yBt1/zpSINY77HdOWwN9afZ/YeKy/c7
         4LZVmDm/pQzPL1txsqrErr36OPes841eMsQ1q1zH4b7mghNkJZHnxAFVmxT/iHWx9X+D
         i8iw==
X-Forwarded-Encrypted: i=1; AJvYcCUbVcoU9eanMT9jMHZHmS5/n67huAvAmklMMq3GhiZQ5N/xDYfXtUGdjOcxONh7lfCslw9YkdC0kSfqr+8tjwIIRcs2gLzN
X-Gm-Message-State: AOJu0YyJ0jgYaZFIXa+9pUEPib5rIEwy1BzfzsaoUjX6DQLFjGVBBNth
	waeYQEb6hrEMdS+OCn9xBPpyrg368BH2bFoHHvqYsi778CWtf1tHjpnIct3rjLsVK6am5nW0bPz
	BabsQOXZwEg==
X-Google-Smtp-Source: AGHT+IGIqqocMO+p754OGQ0aCI3oubKlZSkRKK0XaB4rozfrESn7l0+KKPuQ/8FnH8IptD89mrs11tAJkDy1rw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154c:b0:dfa:59bc:8867 with SMTP
 id 3f1490d57ef6-dfacac3f11emr5034276.5.1717524915105; Tue, 04 Jun 2024
 11:15:15 -0700 (PDT)
Date: Tue,  4 Jun 2024 18:15:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240604181511.769870-1-edumazet@google.com>
Subject: [PATCH net] net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Noam Rathaus <noamr@ssd-disclosure.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"

If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
taprio_parse_mqprio_opt() must validate it, or userspace
can inject arbitrary data to the kernel, the second time
taprio_change() is called.

First call (with valid attributes) sets dev->num_tc
to a non zero value.

Second call (with arbitrary mqprio attributes)
returns early from taprio_parse_mqprio_opt()
and bad things can happen.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/sch_taprio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 937a0c513c17..b284a06b5a75 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1176,16 +1176,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 {
 	bool allow_overlapping_txqs = TXTIME_ASSIST_IS_ENABLED(taprio_flags);
 
-	if (!qopt && !dev->num_tc) {
-		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
-		return -EINVAL;
-	}
-
-	/* If num_tc is already set, it means that the user already
-	 * configured the mqprio part
-	 */
-	if (dev->num_tc)
+	if (!qopt) {
+		if (!dev->num_tc) {
+			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
+			return -EINVAL;
+		}
 		return 0;
+	}
 
 	/* taprio imposes that traffic classes map 1:n to tx queues */
 	if (qopt->num_tc > dev->num_tx_queues) {
-- 
2.45.2.505.gda0bf45e8d-goog


