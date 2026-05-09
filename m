Return-Path: <netdev+bounces-286191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPl7L9xF/2mo4AAAu9opvQ
	(envelope-from <netdev+bounces-286191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 16:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12C500123
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256633016502
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CA30EF9A;
	Sat,  9 May 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEIYU2d/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647039526F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337068; cv=none; b=iaRTHItYT5wp7HUvrfzOy11SEfYuDP+E1/5NWGfqNlmdqkdEJ0YTD26/todYBRDIFEPPNUrtjxQlCrVgMwSe7H/DX1/XG5WIZoE3JZRD/uYA+0WDslFsvXl1HQEQKWMG/RQeJS9/3x9AdwGHmTeCeXAFnwt2yxhum5+u3Pqljqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337068; c=relaxed/simple;
	bh=2hCLATevyxXXWafMagBBa6ynyFnPYA9ueds39JI3CiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsCIzqAuT1FG26hzfWu7I9XoFfa/0uHA2She5zjdnxEIug8hIR9nMIdzl+zlp96Ti8cmWFRghPWWW/uJ9T6AFSPa3Udi0pyxPyFkNgx+MsO4+9EO2KBhD7SQiWMM4GaKIFHlwc3ARwo6vrP+r3kJo0YS5ar5TuTP7zSNDKexsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEIYU2d/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso32179595e9.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778337066; x=1778941866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpgktOJrIbKUjJbm/hsB2JXMzhEM5wO1x5eV5/j3euc=;
        b=nEIYU2d/jx9GLHIHWorZyuJH8bmVyjcWBUWPeqF5YMdPK8YHBVAR2ffsH6uTHwjQZ2
         OKa0SrIkz7lQ144k+t3meV75NK5lW2dvvgp368w/EBnlnqcD++AiaWm1PVLqs3fWm3bE
         IfDvmXV2NgtRJsyuUSSutm4BGwC6HHRHzx6a71g7+N/b+aROXdLC8YS/3CT5oDTBpveC
         T2ulx90sKNalJ74ZXAQrHlKWg6hR9yxmJzNI5v7RZWVbSyJkMV+5BWF44oWTKCy+sP/a
         SUc8GLsw2KP4O+17657UcIWRdG7q4tg9X8HTNyb2tUCQNdDjDJdY17fGvTVYQ22EAdOc
         0EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337066; x=1778941866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpgktOJrIbKUjJbm/hsB2JXMzhEM5wO1x5eV5/j3euc=;
        b=qO1Jl54H45R0Vn4E2r0MvMbJEGi9IMTBOBsO5TJYNQPLsoxA6hoz1VkmWCQSDiI+UI
         tRAQX6iHomSyrKstSf17VgdCN37RqGT+9Z4ulFll9PCAtrWsC08F6+GUCrHFjujdIXQ7
         xpMrDnE4cCNkqy7oJlGRnbsupJgvQS+nOrntxgNqld8CQyXwHhvANWgm0w423QO8BGxG
         GqZ418qhVUEp2EmfDZ5LQBKyhKKbU+AQ2eixl0lY0cn7pt2+k28TFtoW0s9nsNAMaw9F
         OiYQl7dAa+emxxmoQY1u+vXx/adnxWFgN4vfAU1nsBVFDg3dF79Pb0uh6R1sn0s/Dc5Q
         q4NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C8kg7zpTMOwOLNSUmKd+wG4YNJHEZzhvPSgURWWCS5acNQIutUgJFDlSrfZPm0w5cuLdEXx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqStJtM8480vWiik3PtSDwarfvy6Z6cJW5ZsWy9gDyQfCkp0XL
	Cswu0E1j4TGDFA9d8LPHcq9VqVC4zBQ+AFuXCwKqKC69ltB2WK7ZaJee
X-Gm-Gg: Acq92OHAY+ZxhZgVNUGtDjdxk+yrYbWODLXOdfeH+3d2XbYgY5moMWbAaGVdILCUgBb
	8z+LaLcRHZp7IrT3CaH2fiXg0HZtQetS1C8PU69zib0glmwe5beUHuUD5qeVtbny1Z69XyCTYEy
	cg9E3NlzeHV1kC8Q+MrC5CiCuXr9NkKI1+iwJGzL9DN5ji8NOSGmaKd5sD7gwbEhsPR015pldNN
	HQ30tj5hvt27Ut4EtpCfEnyGk2VYq/TiXk+GLHIN4pmQH08tY+A3YqMZsx9gbXzDAAh7d0Crrnf
	iJMSSpAGfyXw43HOYBRdv1J7HuAJqK9yo725YobPoQTPRyNz49qVXJalK2AfcV3drOYrRM1UXPq
	ihY/bJ7i/qT9psOEClKHZ2zsnftS1aLzgpJlW2oIn6zseZp+rnq+JRqPPHZEBo0Js/qoqlJ4S4e
	fmiSyOseEMDhpN5Xzip6GpjDkiO3X0Htk6POJXskGVQZo7/HWgs79V5DCEX8iLW0pb0mg=
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48e51e223ccmr275314225e9.11.1778337065655;
        Sat, 09 May 2026 07:31:05 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5630sm49592105e9.8.2026.05.09.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:31:05 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH v2 4/4] docs: fix repeated word 'in' in networking documentation
Date: Sat,  9 May 2026 16:31:03 +0200
Message-ID: <20260509143103.16558-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C12C500123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286191-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reynardadrien08@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Remove duplicated word 'in' in networking/switchdev.rst.

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/networking/switchdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..948bce44ca9b 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
-- 
2.54.0


