Return-Path: <netdev+bounces-287174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AlgAAo0A2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:07:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E5521F5E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 706F6307A79A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64108390600;
	Tue, 12 May 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9G/dVSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311081A267
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592743; cv=none; b=CE795kTjK3c+TiWX5suUAo0CslBmNHzUHne7J1nXTycgILWPX6NeqGEwe2/kmDJcLH9mB9mWHIR/i596uck0Jq7Y+jaC7kumOxmiGcIViRjTpZgnyrh/lWOI7G3RId1zqHCSXMID6310qRAAPVP27ZKxsSn3lwfwrYsscicgNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592743; c=relaxed/simple;
	bh=Cgpsbn2DkZpZS3BgaGqMF6WQ8CYCubeafRvaZv0Nr5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEnLtYMQ8eP3PE6VyjDxqta2rZnj2L6jriDKsnX7TdQThF3zA7zsbamnKEL9OxsL44k+Zr1sGUjIq5NtJmSk3r59PpnR0QCaFRfxHieJnDmQxRFP2yiQc8E4sndVWR38q3EblLron5beiPzPr5Ac8QXja9c1Lt+oQPDkWkOVRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9G/dVSK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-835399c11e0so2515839b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592741; x=1779197541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+G1CpOAyOxANA+SPh/GOBsJg+6uFI1md7kNT04Z6aes=;
        b=n9G/dVSKQkvqYYaWPYb4ypU0wiuStGS8nWlby5RPv7rBVTJ/5nTsVNR9Bjsaaj5NF8
         bqStEq81p5cz9rINxJPRIB0vWx97P6EL12M/ZHyqEWJZf2fA5K4yHeJ3HrlE7LPACReJ
         eCYYdJgLVq+Hwzlyy8Xx1GZIhsmwuaGyRcgAjwKs8zSOnK82a5AX3asH8k19iKOK0Jn1
         P9JrfFZtuw1hpZA47GXC8ZV84DAoxG5YuhR3M7RaTbZB6iBYJDxBpR6Kc+El5IZuYP6L
         M1l/LaHWOUjU/L0CtKqbOVwyeNG8+1FVx19woZnkU76exMTZ64Dqq7t0+ACv5meZ0HrX
         cq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592741; x=1779197541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G1CpOAyOxANA+SPh/GOBsJg+6uFI1md7kNT04Z6aes=;
        b=PD3a4/6Me96euVqxyqM7fDGWGC109WDI0TeoopS2Y5fhqgNR59yDyg7jkiIx1pbzj7
         31Gn3M/OGQezX7lUdHXnIi7U0mxMgtyxPJ4kDUcYdmm1vmgGNN1OVkA71kYlDlBT/Erp
         K70vPsPVV5oy9E3emrGjcYDPb03LHxk+yitlagSpgc4pz6GhglJdKfdL+uL+8RFKntMn
         XVtTTKWDI8r061WSlNBHuc2Mzs4Nb51vhzgIG3pcmYLZYLMQAPTz3WnDag8fiVyHCHA4
         Ob5zTJ8UeAY/Ld6t52yiY9hYd3TT7E+w0eORmU9yFDVUaXyi7EKHa5p/wvUnLW54Rvdb
         XECg==
X-Gm-Message-State: AOJu0Yz9scek+YezGgRgdiV6For2KMjKJleRibuP/ts/OJjNspL24Clr
	T5fJSv1hx/aubOoe8RgZxaaWBuez6ft5Qr1F8E9YPOQiFGzJIrmYhEbWbzEQcIEZ
X-Gm-Gg: Acq92OGoJMxOLg9Pz0jqeiczum3xiL9i1RkopJDG0dlQvvkX1rp8UaJ2OgKRG0o0kE1
	/+cJqHE9FmDxStZWsXufRgah3Em0ADY7+ghQHg6hNY9rBO3DqEyGnns+dxe28s0gMj16iRErsOj
	7qUSjlInEWSwzh+JARRrf7B0cwW/04gYNR1Fm0Am2K8314K24OLCJEVfkdzLb0LxvfUpb29fnWj
	PgjXWy/cgL3LJrPWU8iyYzzJtVMC6e7n1V5UB/oq/gXVtvgZcu6K4TG48NgR6pzEG2jG4nc1eqe
	IjPIiVxGhywsPG5/P7UP9IJblh0Xq/pkUPq2xvkrIky85Xm6JZUW0R+sWcGuDuzBV4GoXCjKGq1
	MsRcyv/8s1a+1DCmBlMepYrLrBTPcnGMuIw8AlXSbyMjf1DJD/EU7D/GYQBU2TMjPlD1tq1qdG1
	XT+3E9qy2fHRLCodDUKzLGHrLm1QrQSFEC7xzpWljL7TpyM3LW5zzuX4NxT9PvJA==
X-Received: by 2002:a05:6a00:b48:b0:835:351c:f236 with SMTP id d2e1a72fcca58-83a5d09a78dmr28663707b3a.29.1778592740983;
        Tue, 12 May 2026 06:32:20 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f38fsm22849934b3a.8.2026.05.12.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:32:20 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	corbet@lwn.net,
	jiri@resnulli.us,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-doc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] Documentation: networking: devlink: stmmac: fix typo in phc_coarse_adj
Date: Tue, 12 May 2026 19:02:14 +0530
Message-ID: <20260512133214.1773502-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F15E5521F5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287174-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lwn.net,resnulli.us,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

"Functionnal" should be "Functional".

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 Documentation/networking/devlink/stmmac.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/stmmac.rst b/Documentation/networking/devlink/stmmac.rst
index 47e3ff10bc08..fbaa81ea782d 100644
--- a/Documentation/networking/devlink/stmmac.rst
+++ b/Documentation/networking/devlink/stmmac.rst
@@ -24,7 +24,7 @@ The ``stmmac`` driver implements the following driver-specific parameters.
      - runtime
      - Enable the Coarse timestamping mode, as defined in the DWMAC TRM.
        A detailed explanation of this timestamping mode can be found in the
-       Socfpga Functionnal Description [1].
+       Socfpga Functional Description [1].
 
        In Coarse mode, the ptp clock is expected to be fed by a high-precision
        clock that is externally adjusted, and the subsecond increment used for
-- 
2.54.0


