Return-Path: <netdev+bounces-230293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22636BE649A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A392D4EC5ED
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F630EF63;
	Fri, 17 Oct 2025 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VllHUtkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5F30E0E5
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675026; cv=none; b=hYoJofn6sSgd5hlUwqE9RDCkL5NdSWhD63DLvn5t7xpj3rSyYl575EEWxCCbIRCaRuUIXrXZMwhDjINivs6uKOrCOhzN1NC0W+5WHBMbMqIcEXdIFD/pu8/MQadzFGIge+ORT+cBpT7zEDqqIBOKFwbz1cDDGHbGgC9hWOJfiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675026; c=relaxed/simple;
	bh=37YeEv3sX+mmDjcIQ5fmoI0jB8MoKSf0MBI8d/gZIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsWuZ/LJ7JJQrpncDWer6oQbS97AF5hC13Vt403QXXlUE/oEgy0+UYPxdniQpVIxmJ3mcdaZ4qKldNEOE34JdvEwV0P0JEUaQ+59LHFc/n53o6LKXdaJNgyBL4QS8bTo9hQVyCz/S+Oy5DfHzlizm02nVdpjDnNwMeMptRoeeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VllHUtkz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269af38418aso15271085ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675024; x=1761279824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=VllHUtkzMpkUXDvPypYbSO7h4bOUgAdTvvSKA0faHZYqPsXz3wQX/CK2IaTCL9+7jc
         3y7IrDez1pdZREPnV45jiEcl0FXjMh3E8OdTG7Gw5Iu9bAryYuxNucYUQWFpNDOATIo/
         5KVTpWnIioxUCqHO2oPvEaBixWNCGtfGrhyoa9mjqZQaOxjQybUYkzRAqeBUNkqYzcRK
         XiRAHrUxXPKXFE7J/OSXNDyXNn7SobMth4W5M3eGKfKTlmk8nXIsTShtpgS/wX26O5yu
         V/mVww6ON1msCEYb/3cODPaOOPlFJSc/QiLTiVOzeSuJxboqBXAWYIpVWgVGGJxbFmJK
         AV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675024; x=1761279824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=iTtXE1Ua/IH2SXdoBt+jQCEgG9LuX/ca5ZvZMe9CjdTrGJfnzlbBQXA2AB4N8ksT49
         LbOE5iWJ465rK6aFVJD0TdV493vPyLt/dKihRplXpv7uy8fODY4EvAyqDDXl6J30r8hp
         VwmLkLJtC6Kl1MG5qna80EVtvxb1IWxrjuAnWg1Krg2Z0nl+SgddnnvhKuUOYs391Se3
         HdaXpXYNrrlWxbNnDFKDbJjBqsHvI/eswabGaX8BAg4jl+vyk8kaVrEI8bOc+T8nb8Fj
         z7sHSh1zFdleEjAaeX+En9w66lh48v6XOtvVvWUy7/3ZW3FIiCHSDpSTYOpl2bgmXAPo
         XObg==
X-Forwarded-Encrypted: i=1; AJvYcCXO6R0M1Akjk1Kos7E8bi5xg2qcrilyJPqYbOvHJlk47lcT+NMmDNfgbppGxVQauqBZp8sFHxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkW6iY8curM4ta5J15oL3rt5RvmpJeSXBfxX5BTui02t1vTV0
	d5ByWhxZthMRvfn6DLjGokbmS11Su+02UXi4UPbRql9iFJrB+LeGR4EM
X-Gm-Gg: ASbGncvI5VyLa71vA3kQZSh1POjysuujhb+VnRaQUSVZe2zRGwiUq5VBmsEkPogTbOI
	RRVjCT7cFqei39yxuLdBpHWQGLid/PPrCa2EUw4thx3BxNijPb9Gm6WNxF+z9O829R9eK9hC01Y
	Wru+ndnZ6dPXWLuA6BkrL+ERAdTZqO86IpDobMchNjk6koY0+7QCt14SQtuBqTRRaEtyPXIUMSN
	/fUaiDZvVQWvG1WP3qb0jNAEDiqJH4m/Bn9LvT3eRSHGlfQ1bv+xoQOYkQ6s8OfcRgsWkKrjWeS
	xDluUd6ueCcj9bZ7XvCuIXwmNJ9j614HUvyPg5jZYEufbkyKJXDdNEkpdxyP6z+5smK3d0CuV+G
	e8q8UVXcr/MoJtLFtNtQ8uhbIJoF4CTrwhWtx3Cy9N/upYrV2qOnEoC1pO2kltsNhpeMM0Buiyy
	n8x+Gf4WSmwDuqfI9dZMWmkVz4Eqvlx+UJ1V3x3wbK0JUr1N3ff+PMzpeZzoDLVVAuqa87Z23es
	YxNzFuHP8Kbeo/7r6Le
X-Google-Smtp-Source: AGHT+IFs1j5KeQPUYHknhxmr73Cz8lIn7tiQ+fRQndA5W23hoDMgcJ9Yk8+rVDxwb74P5c6XfgnCZQ==
X-Received: by 2002:a17:903:b90:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-290c9c89fdfmr20658745ad.10.1760675024212;
        Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 2/7] net/handshake: Define handshake_sk_destruct_req
Date: Fri, 17 Oct 2025 14:23:07 +1000
Message-ID: <20251017042312.1271322-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Define a `handshake_sk_destruct_req()` function to allow the destruction
of the handshake req.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - No change
v3:
 - New patch

 net/handshake/request.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..0d1c91c80478 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
 		sk_destruct(sk);
 }
 
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+static void handshake_sk_destruct_req(struct sock *sk)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sk);
+	if (!req)
+		return;
+
+	trace_handshake_destruct(sock_net(sk), req, sk);
+	handshake_req_destroy(req);
+}
+
 /**
  * handshake_req_alloc - Allocate a handshake request
  * @proto: security protocol
-- 
2.51.0


