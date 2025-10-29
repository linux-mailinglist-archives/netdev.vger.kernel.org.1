Return-Path: <netdev+bounces-234150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C4C1D4A4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3921A189F2D4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34B2F83A7;
	Wed, 29 Oct 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI8NuLpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FB21579F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771044; cv=none; b=lJBGPqqk2nfBrKpTcyHZVye74cAdYIvEnhY9PR95EUwVn4HdcElesIOlhm9SufkaVOJlOrexRAF+ol1zlHJI3CPKcEHVX5VJaye+YhSkKwUoeaVhYPcoOH1V2TsmM0pfdODdL1JNP9npmYfZpSyCsjH3k3x/OnHCFXNW4dksnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771044; c=relaxed/simple;
	bh=6zjWDKHvDUmCspfnhUpUidENGOH1u4Q7Al0J9CBMnyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cxgm6AZr35pzE50MlcFrRMEOA+z+nxfIluKEt2DgFnlQS4Wnr0eNhzvj1NKNhHlXbpQ7BqLaZ79scOkc8ECiLc3ZLWKFnKQqo2WB+MZANs+QQN5oz4e3QExacuguhU6b7kmxbpYY0ZGillzHzsZJT+r2NlMYq2LkaCsexKWknkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI8NuLpL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42708097bbdso47102f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761771041; x=1762375841; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhItZvJg11h14RqD8DEUafH4SOcvlIckRX4IB4jy1L4=;
        b=XI8NuLpLMLtEHd1v6jOs/Xn65v1qzCSkyduXna5NyAOEMV2MUSdgrA7FZ2yf99NJ+L
         Cg6wWp2critoCEpOGrsEIOXUNY5pg8D18lxMh8Kbf/hp0InIFopGWw22y3sdrRSjtonl
         1UFTzmzq3LHwjIt4LbbZwBTWMbeR61rDOOq1Gdu0W23lhxOlLIGUFW4IxDhZQ3f2FiTp
         Vjt8KO87WXLRdp1Pre966wgZoXCaDVDVWwOcZhimGrA+8NHDY586ajoE5HlAY3tu9Zy+
         SoIKY+15ICHdi179rYLfo99ENKogyEetvi05kqa+MhlJiSrPsviYBoGGWJ7fgTZNcPfm
         N4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771041; x=1762375841;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhItZvJg11h14RqD8DEUafH4SOcvlIckRX4IB4jy1L4=;
        b=DQPxTUKmpjmkpRmvAS9vffhvs/Uka0sMEl1JdLSm/B3i1mM8T9515pB1OBUioxNZaM
         93rwJEa721T4/2q2tyfQjpLbVpi+8TZ08PG703L6QTyaeoN/ohhq0uB5vxYHU+Tf9Y6r
         4Uut/RFVV4EVlrw1GqDGx/fzDBBdpAJU3txBLsHQcNqq5DCj7CF9CYOUg8QbHnrpM3IB
         WtGMSPXVrUqz3B+c+19lpcBB9nWzQWIbasjrJQCCjhNkLQtSI8uF4jdDCFRSCcR4MCaT
         aGZiYBkTKZMfXQxL5dLQegUHd7HwH0031TRhpXSCb6JWkXwXMQvvqGeFazScE3NAW1FF
         X+zA==
X-Gm-Message-State: AOJu0YzjuZX7DuGlRVU2W2temH/pOodKo6ahVWyJjYw0jjoXfrkhBBOH
	Z4vNU4HkGC/91e44kwl/pKab3jjMQj+ghTfnJ7eyz1ZV0/2xJNS1tEIo
X-Gm-Gg: ASbGnctV1ige4Xm9JeaQHAUVaMHt/osu5zCMux0u6C3fbkJu8AqJWt1OK3ThMB3CTyn
	Ywukj/SNaSKf70OpFVsJSmGqCVLgXKLHFN/Osi6vxyE4ObWoif2GPEdPeVbLEVVdIteTm7pTUvg
	/HJuKB9bMF00rdud2qN/KAbz3NAfD8qEj5hayuKS53YYeUhkVYytXXCRLmzTjQvIp2QxkbNZ9hz
	9Hi7zS3AoHkBz23+yRwgWcI94rV8KQb4AX7ZQ0aKhda7CfTsz9ZbPVVxLRIB00l3lXfpnjecdta
	GLpU0Jo9gAvyCxqdkRuIfbRK+c246ZEvT5urBOkeJD5poUTWE0gz8XhtDErGUlN0gOL9ixD9t8x
	+cvyGK37ZYH7D0O+KZWfhy11LDgd+6XcxyvusC2Vui5Dtrda/i0Ba8t58akVfM3tseI+MltLvOg
	RtSlk=
X-Google-Smtp-Source: AGHT+IFNSHCKQVaEkNNF6OQaV8zGl5KuFF0WiI/XF0XmsBzjv3pnZsHeYY3KYhcSA/ruRUVTWFvagw==
X-Received: by 2002:a05:6000:2088:b0:3ee:1125:fb68 with SMTP id ffacd0b85a97d-429aef70b89mr2039673f8f.2.1761771040974;
        Wed, 29 Oct 2025 13:50:40 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79absm27775131f8f.3.2025.10.29.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:50:40 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Oct 2025 13:50:24 -0700
Subject: [PATCH net] netconsole: Acquire su_mutex before navigating configs
 hierarchy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA9+AmkC/x2MywoCMQwAf6XkbKANPqq/Ih5KN9WApNLKrlD67
 4Y9DsPMgM5NuMPNDWi8SpeqBuHgIL+SPhllMQbydAqeIip/c9Ve34xFfrilpphj8bnQ9UiXM1j
 5aWxuv97BAnjM+Qc58uNzagAAAA==
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

There is a race between operations that iterate over the userdata
cg_children list and concurrent add/remove of userdata items through
configfs. The update_userdata() function iterates over the
nt->userdata_group.cg_children list, and count_extradata_entries() also
iterates over this same list to count nodes.

Quoting from Documentation/filesystems/configfs.rst:
> A subsystem can navigate the cg_children list and the ci_parent pointer
> to see the tree created by the subsystem.  This can race with configfs'
> management of the hierarchy, so configfs uses the subsystem mutex to
> protect modifications.  Whenever a subsystem wants to navigate the
> hierarchy, it must do so under the protection of the subsystem
> mutex.

Without proper locking, if a userdata item is added or removed
concurrently while these functions are iterating, the list can be
accessed in an inconsistent state. For example, the list_for_each() loop
can reach a node that is being removed from the list by list_del_init()
which sets the nodes' .next pointer to point to itself, so the loop will
never end (or reach the WARN_ON_ONCE in update_userdata() ).

Fix this by holding the configfs subsystem mutex (su_mutex) during all
operations that iterate over cg_children.
This includes:
- userdatum_value_store() which calls update_userdata() to iterate over
  cg_children
- All sysdata_*_enabled_store() functions which call
  count_extradata_entries() to iterate over cg_children

The su_mutex must be acquired before dynamic_netconsole_mutex to avoid
potential lock ordering issues, as configfs operations may already hold
su_mutex when calling into our code.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..9e17632e0bc6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -931,6 +931,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	if (count > MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 
 	ret = strscpy(udm->value, buf, sizeof(udm->value));
@@ -944,6 +945,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -969,6 +971,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_MSGID);
 	if (msgid_enabled == curr)
@@ -989,6 +992,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1003,6 +1007,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	if (release_enabled == curr)
@@ -1023,6 +1028,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1037,6 +1043,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
 	if (taskname_enabled == curr)
@@ -1057,6 +1064,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1072,6 +1080,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
 	if (cpu_nr_enabled == curr)
@@ -1100,6 +1109,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 

---
base-commit: 210b35d6a7ea415494ce75490c4b43b4e717d935
change-id: 20251028-netconsole-fix-warn-c8f0cf294276

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


