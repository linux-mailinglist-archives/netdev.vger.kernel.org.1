Return-Path: <netdev+bounces-272804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IWMlJtIkyGkyhQUAu9opvQ
	(envelope-from <netdev+bounces-272804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:58:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B634FB4E
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85965301680A
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F3333C194;
	Sat, 28 Mar 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q277r79J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766533DEFE
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774724300; cv=none; b=ADv5GdC9g6Q+xiQk8rayNJmx6EeHPysPsjv0dVpm/oWbhJ+c+ryWf1YCxBTgC3YtcKyn7Do/610nDMjrtWGp5PVyphYQqXu+bZ7QjUUXT2ZALWsPj/syUx0XpOB2M+9wAJQG/Ff+ZjHWp/aVLXy0FTWR0wISWQYAKaMZCNfWsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774724300; c=relaxed/simple;
	bh=TY2hsxKzRdg6cVTU5tH32Ru8fM1l3UVUUf+AIaD3Bug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7+WrDVZ4Ih/Je+ktB4BtqYZkpwV3QYouoOTTs+yDwy4S7BZyZERRxjvKyf/3fgrN5yNnDGxecSuTUxUlML9h+WeF7xqdYp9sggAnlmth+jl3NQia478JKovSknoBrdL7zun8BRtd0sFYmhoIU4CLNcSUDYCCbbQvJiJN6s46cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q277r79J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad617d5b80so21867185ad.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774724298; x=1775329098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWZCRNA7sq5TKfV/GxwqqTIp6ycx6O3DA7KXt4hfRiQ=;
        b=Q277r79J2yZ72Kx3XeYpKwiAmpKOu5ZxmDkdQHGCpWeB/U4KM9bFEacDl3NhhJedP9
         cSv74bT9JjdVkMhYsD4siNtHJIqKbH+OLQ3USw7O6ZzuFOLBfnGH5wcOG2q50FkXUNSv
         cHu22HlJkUYGk0tkhu9AxKgAaFI24r6G4Y/86QtdwY8taK4rwiNSo9Jb+JTZ91WpY5J+
         g2CdF0qlzb6hWuYqZ8JvZy3X2fQmLJTy4z5PF66grPDOMx4LFM23I9IfIoNJ0U+8JWvZ
         ZVnjBmL9pQ/DJlG8UOvN50VyJHjKZ+FUsDMC91XX2wBrLbaJs4qUD03INcODD1lBKeX8
         /r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774724298; x=1775329098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PWZCRNA7sq5TKfV/GxwqqTIp6ycx6O3DA7KXt4hfRiQ=;
        b=natdhqa5LtGEhoYjx6ZkiLT8bsdb0Uehn9xQ/YYWeDRfyzhLAipqNd/lJj5YogDZJZ
         lRr6/H7ngS3tbA7A0b5DH6KWdoD8HlJJM/zjlnBHw1RajSous1/iiR5yF5/omtFOY+Hf
         HQTubETFiZvjHwpo2oOKE+5RC+ROpdHY2MKMDk/WO/fPcfTy2dXn74E3mgNwBhkEaw7S
         6+nJSebGrf1ToRIF4TNlh+cTy8MtWsaMGb3wfukPJNPyXIO4K+LGCLZ2vqN4Qv74fD3m
         dWRnXEUmjKAvoifDo6AFwT8ZznOvXEhGvrK8lnPhWTkBembYGYtT5LYH86m8hs4Mp4lO
         FhUg==
X-Gm-Message-State: AOJu0Yym3zLMj/gxo/HtxnqBf2F7eCqwWAVX8trStOCwu6ZgQggm5CE0
	+PISZ7noSXO8O7g6x/lVdZbMZK0PD8vU7+JfEGg5uC5L/y3b+320m676
X-Gm-Gg: ATEYQzy+YL43+VFZCXwvFOUkR8g+ZIQEOr8uGbUaddDXx4P0FW5DMWitvTf9ZxjDPZ4
	qTa7/0HxWn0iVEAFLzTGAx95e/IU9GSxaMutmHWtZ3EQKdJ6Ckc9l3NKjDMLf9a4eiWGBrktvuQ
	qViZkIV0G5RLgCzQCMEANLl86GH9muYaPmzwVBK7YcOiISDX9C9JjTaooY7tK9x3QEhKY31Sai7
	vWP2guiQ9bEsu5pvxvEm2svSBLh8Wfj3fIRLdsY/pu07geaSiSH0lZ6K3qxjTePPqUjzZrUH24N
	JzlzP9T+gyQD0eEstffUes5mvCNbUFDX1FdDMAotCK0y4VWL+e+XIYh5jxtHCWR84LG9SoCztAK
	SOnrbuK1M/JxwIr4OKVFMBwmaN0QvZ5xxoZERS0sAImXPLJfLBCOF4KStDfXdY6t7qZ11vDQWh+
	wT8PeTKDqvKRmJOH4z5w==
X-Received: by 2002:a17:902:ef45:b0:2b0:4eeb:f807 with SMTP id d9443c01a7336-2b0cdc3e969mr68503115ad.13.1774724297746;
        Sat, 28 Mar 2026 11:58:17 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b1ef0sm37793225ad.74.2026.03.28.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:58:17 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	p@1g4.org,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net-shapers: free rollback entries using kfree_rcu
Date: Sat, 28 Mar 2026 18:58:04 +0000
Message-ID: <20260328185804.41325-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-272804-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,1g4.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A5B634FB4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_shaper_rollback() removes NET_SHAPER_NOT_VALID entries and frees
them using kfree(), which can race with net_shaper_nl_get_dumpit() and
lead to a use-after-free in net_shaper_fill_one().

Use kfree_rcu() instead of kfree() to free rollback entries, since
net_shaper_nl_get_dumpit() protects shaper access with rcu_read_lock().

Cc: stable@vger.kernel.org
Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 net/shaper/shaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 94bc9c7382ea..8922f7f64768 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -434,7 +434,7 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 	xa_for_each_marked(&hierarchy->shapers, index, cur,
 			   NET_SHAPER_NOT_VALID) {
 		__xa_erase(&hierarchy->shapers, index);
-		kfree(cur);
+		kfree_rcu(cur, rcu);
 	}
 	xa_unlock(&hierarchy->shapers);
 }
-- 
2.50.1


