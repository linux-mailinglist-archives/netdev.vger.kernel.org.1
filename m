Return-Path: <netdev+bounces-133097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEA994956
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD79EB23691
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EEF1DF266;
	Tue,  8 Oct 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezSZizVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D31DEFCF;
	Tue,  8 Oct 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390106; cv=none; b=AbxsXuJPcEdL3yupqu9ycUvxuEFbF6SMJXQAWXg6Cob8PKvwPL3qMJch+06g84Pcl7HZQ++8bnAI5OqU4qAa1EvDzNNf/CWow+utq8Ix9/39tzSGNekxizIA1E9lHaLiMsic28lULF+ovP9MwdWCBHtTzsscHxMkKv2h18IGph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390106; c=relaxed/simple;
	bh=sqhgYCxFuTkVsFmP1HNPMt2rIfrZun5s0g/k+WRejo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meOxeDjndw1Bf67mRrWdSNK5eSiC6JRwI0QrFmWpgIVuweRGZ0WsKFW5qCG4L+rk8WufnmA81BA707+3FQ+YamQr/2I8TQOX+P2Lfjbtqj0duERjCIsTZtWi4fY6KLiRQjJ6GEv2LQldiXTYbPRCOPhS/+aHtRByL+HQj7GeaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezSZizVk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c544d345cso4441795ad.1;
        Tue, 08 Oct 2024 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390104; x=1728994904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhnd7an3fFD1i9UA4CB9lXLmhhSXpvyBfaplEmuqQys=;
        b=ezSZizVkw9k6mvbklPNTO5Hklywi6MLBo1vXW+cKXappmk5qaHzGjQ3mb/vriElPk1
         hmYTg0R0dwEINSwcMGKHpZuHN9AbAqoQruxQJ302TrCxngRv2fm58uYWwVO+ZxZjbhv/
         gSYjkwJkt/r4LrWlQBIu5AXCHk0F1TMmkQCA8ZzOa63Ld/DqS1qmVuIqsvaUdPhRl+Un
         Wb156yrd4AjL6xOgQ+Ug7JoHxrtp3zcKafXS1tPaEOxVusvw/Agikf1sF+jTNiPraey8
         5FwgUO3Fbjr1m9QbBpyKb6AVUmhPFU6uL84DAsuSj09GQQ0K2QHs/a5w/d9KOW3Wz01J
         6Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390104; x=1728994904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rhnd7an3fFD1i9UA4CB9lXLmhhSXpvyBfaplEmuqQys=;
        b=Lb8jy2YKJOBOBJCEKXq0hXFI4HctXhMsf0KjJzKZzX4AlVARdzbMBQsM8sN7PodAQG
         XeHqDBHYggMebIkdyf6HUgaryGs5ImkvNOBzmeSSY25ZcGKa/v2UKEtN7ndQ1FplqUSt
         qTfVx+V1tP1KVoAC9sP0KICS+98dVNJHkmnmO9QwHcKnDJ+/gYYXsgriUvUUQewk1Jb3
         7vKF8rBJokRiMo8cx8i17jjiLrZ/WhFSYuKk2kDEVoIFllDxEfeHP7g7saD8nTOj7DcJ
         N567oVLviA+k0KV0kcHVIMpbXtm8yBwARTa7jfNv0cbiHHifzyeapzTER0k3nLqx+3GP
         dsBw==
X-Forwarded-Encrypted: i=1; AJvYcCUmIuEjay31uRcqgdIqzZceQyOYUr7zCugMHNnHlXPOOIhrVSXMKorpavO1+4Y5rMFcUdN69vXEpB2Lm5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzp4hxfX0LvAS2Pc1D3dR9TNHh7vJhA2KwA+E2l0o/JWhIKUKs
	x714acQM04T0Agt4Y9UWN2uWicI0J4ELEXqBtwqsRQcI6oDgFKBms6iKJkX0
X-Google-Smtp-Source: AGHT+IFKDhuhEOXGjDNugiywUgPBT9flDfwGC0KH7iRkjtLfUwBHpszDiLRpCwR61toT2FyO5mK5nw==
X-Received: by 2002:a17:902:ecd2:b0:20b:46c6:3e47 with SMTP id d9443c01a7336-20c4e387b19mr57807315ad.29.1728390104159;
        Tue, 08 Oct 2024 05:21:44 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393175csm54737175ad.140.2024.10.08.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:21:43 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/2] netdevsim: print human readable IP address
Date: Tue,  8 Oct 2024 12:21:33 +0000
Message-ID: <20241008122134.4343-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008122134.4343-1-liuhangbin@gmail.com>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, IPSec addresses are printed in hexadecimal format, which is
not user-friendly. e.g.

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
  sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
  sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

This patch updates the code to print the IPSec address in a human-readable
format for easier debug. e.g.

 # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
 SA count=4 tx=40
 sa[0] tx ipaddr=0.0.0.0
 sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[1] rx ipaddr=192.168.0.1
 sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[2] tx ipaddr=::
 sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[3] rx ipaddr=2000::1
 sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[3]    key=0x3167608a ca4f1397 43565909 941fa627

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/netdevsim/ipsec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index f0d58092e7e9..102b0955eb04 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
-- 
2.46.0


