Return-Path: <netdev+bounces-294029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLA7BhxtHmrEjAkAu9opvQ
	(envelope-from <netdev+bounces-294029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:41:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E8628A27
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FFDF300C7C7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156033BBD0;
	Tue,  2 Jun 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4kx/Yrz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18633B6FB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378902; cv=none; b=XFLPbr7q3QsvtScunrhbdakbG55omZlrIQPqhGKUKWEYBh+2XdRtElpxGsz6hMoId+XATXcCmsRI3An4zKs9Kep5SsN5X/WbyqoHV2bnOWfUS2xCAJ71TUg00cCJIJI3TRkmYmUpN/pYkyW29Djh0rbvtq6o5vprb31fLZsXDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378902; c=relaxed/simple;
	bh=n7V2vfC1JbI4WrA583Y6PpTcqWcjqmKB0sQIXUnDtEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiPaI/IdJTpZ2Hj/FdrnCGvZMoam1wniMiReRPw8eCnl3SxkYS9e4whAWS5GMZyK7vNXMNylOFPaQsuy39zYxgWK+H0Nr6UWIByUZaCfZxSXf/OuxD/BBzTE8LllXqTpwbtV+XBkNaHQXpfkyY+u+bFMKIkaTo+OmxmnC926xEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4kx/Yrz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f53332aso768681b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780378900; x=1780983700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b87cwHT2BrTigjVd+6bwq58aCoITji6mCL2XtGIvkXs=;
        b=F4kx/YrztuquMauH+60ndA5ypfuxlqfdZPjfAHjDcdCTIDEU60N1qzQPzbvihhxzl2
         Jl++Er5WItmtWxzcepURJgCn3GlDsh03IVMuSTd77kW8oYf6jLbLsCIqA9QqQ0MC1qLR
         C1nwYLnExPKOGLmYvyGMBuBxgM8EQXfvG5Xlcgaw8w0RoB37zc8V5ZNRefM6a7GlQDNh
         +gS2vqPa18d0riFTC3rGCmtiNlYqswVktX2b0NSrFyq73vrokmdU0+6U40JyjQpzWV82
         ptl8PdcWBrG6g72V+tklqOWkaZONIXYKy1C3dqCKvK+/Bz15r2pttNaOjkAx97vW7Tku
         0i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780378900; x=1780983700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b87cwHT2BrTigjVd+6bwq58aCoITji6mCL2XtGIvkXs=;
        b=n/z/XrmTLS98mYYVgPeyIArywYrH5n4hVvmv4ktX2nRuYGq8E+WtRqtoly0Noh16Hy
         /sHRNT7nECO1URgSu1S7YDReYNRJpf42yMGTBdP3lKLQrAmA2E4p8T82LEqI2ODXu9my
         Q3S8AarPSjFdcqX/Hxzfb9Mi/1vmndXgHx9QPor7p/JEde9Yjg5kdGGdj3GpPNkLy2I8
         kUAqXeDsdgUbjp++Wyln5wOi3jx31eih3lkWIlTXCMIczi+HU7z1bC40SYgHE84inpz2
         Ji5Jj8j2VngpW/KrPhPgtUpsaGxEXX2lVqD09/KcBSr6VYsBbIvAFkiuB3gFxPd7CifP
         7QZw==
X-Forwarded-Encrypted: i=1; AFNElJ8ftCXjb2D0XjvS/0KwoW6OKWrJSV1BbzgOkAk6qc7/NBxQYuSKXa6QNILjCSb/AkiJQ4Cfk30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcQst3ea4PEK8pRXVEd6/JNY6yqQOG2s/fugGkdvl+ro2we2S
	XRFHWiOE6LZaoH5HYfxdBGe4x8OiW4dX4HQPLnFZf/DEBFloreVvJ+aF
X-Gm-Gg: Acq92OEIB92u05P26M0QsczvbbAxGKTkbdlMQgaNUTuBLkON8F2MqJ+S1eeeD4HVLxw
	vFVq2QcTmqAnjLwFm7TOYXavkIvGF6EmrwMJuhb/m8wI1lzPoDeSxnElstMu03T1BUCWaoet+nr
	wP3Anl0DPtLNiA4oa9ZmcAVzJBSDzdv1DoRlNb72UhotLehvegg5pt6+7/hJniACQ5sHwk0M9Qd
	imLVgVH/MnO0x/csCPOm5t7qucpg5Wzp+2RyuwJ6eUHmtXCi3O/DQ3EtHzwx2ImS+A5a99fbPgz
	R0t5MPm6Tm4XjooXO3k9QUpYBcrR/u3Mmvwr11u9e9AmAdAE2ltLsuxIVJrQvGFe6ns18Wx3J5C
	XLUQVgnvRnjT2O0m5W1Y8kKZutbnSZTYNDQuDm3BbtFNSVZSleIJW4Ys9lDoK9ooqS/SfMa7h2V
	XdP22XYFKJ35iJwj0zIskOQccdPslteAa67NgSDg==
X-Received: by 2002:a05:6a00:301c:b0:842:6fce:6171 with SMTP id d2e1a72fcca58-8426fce6cadmr1818446b3a.3.1780378900295;
        Mon, 01 Jun 2026 22:41:40 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:19a3:f977:6a92:60c9:fc08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842596e63f4sm4020138b3a.29.2026.06.01.22.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:41:39 -0700 (PDT)
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: [PATCH] mac802154: Prevent overwrite return code in mac802154_perform_association()
Date: Tue,  2 Jun 2026 12:41:33 +0700
Message-ID: <20260602054133.470293-1-robertusdchris@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294029-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robertusdchris@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 213E8628A27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
return value assigned to either "-ERANGE" or "-EPERM" but this return
value will be overwritten to 0 after exiting the conditional scope.
So, jump to clear_assoc label to preserve the return value when
assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.

This is reported by Coverity Scan as "Unused value".

Fixes: fefd19807fe9 ("mac802154: Handle associating")
Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
---
I am still not sure how to test this change. I look around the function
and use the previous error handler as a guidance to make this change,
like error handler for "No ASSOC REQ ACK received" and "No ASSOC RESP
received".

Thank you.

 net/mac802154/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 0a31ac8d8415..300d4584533e 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -594,6 +594,7 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
 			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
 			 "PAN at capacity" : "access denied");
+		goto clear_assoc;
 	}
 
 	ret = 0;

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0


