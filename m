Return-Path: <netdev+bounces-249724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE407D1CB8E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DCC301A1CF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB136E496;
	Wed, 14 Jan 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkz+PnHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703934107F
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373403; cv=none; b=LpkGWe4ATqopR9kGomOb55ZJACpr1aSdqq1No0oZScAkfszFT78jA1Dv9tWxKBPlaepXLc4Jwew+gRAuEZT9AyL6nBjSYe6z44Tz1VIMhLVaL4oDtFcaUEO4pVxWd1S2qRpMix6cYDEqQup7zhU8bHOZFnTN0Ggh1m0dAkIs444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373403; c=relaxed/simple;
	bh=BayOriLPbqMfaHBFOoZc4HEtQYI5iJpN0d5/54XKytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRWqQANjAMDd/IzpPqncO5usSchY4qvhzaBClgaIrabzO/3KLjQAzAQxqziVGSFrqD77Tl43vsocU3UZ1f2rByv0PJo3VQJqf9lV+H8JXI/mIWbEXpGidTwkU0iLraCC3d8KswIJHqCW0HpQkiT8tQl+mxJP4h+rq92A6rlLRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkz+PnHT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0c09bb78cso4132395ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373390; x=1768978190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpHskSlCFaOI6dQ6xmzezOZiBd5LtqsF5PG55W/Nq/0=;
        b=fkz+PnHTytLUVld3vlYbXEg2ifBuEyeCjAsYbFh00CNdhECXdZgn6hcffsTeIfq7QS
         PvXhw/LnO2vqMW6S0rPLS8TMtTJwwWcYHz1RInzwUPuyMl7J33wra5s8cTBl5yuzbzhd
         yyO9VViLuLWi2yPiOFHiErWRkkTfyhVJyKGYSRQhTlQdN94RlCRlRsIH8G6PQ/eA5E2n
         4CJ22/LfsjoaQT+3SvNNstqg46G4Iv82SXF1fBGh9u0DRz23Ob5xAKbP9cRJ2dIyMNm/
         qATPcmFaPDGzncWUq55CTJi/oJxeiDjk6zNqtXz1iSRcE2Ns+sbcgywOxwzvGiNxQ8xv
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373390; x=1768978190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpHskSlCFaOI6dQ6xmzezOZiBd5LtqsF5PG55W/Nq/0=;
        b=aTy0pelU9+/6RdcztUurVHwoNjFddNV4RLsZJW8UmVKqvvrAXIw/ri21/J8+ukI3yc
         VZ6yY2o77+2RAzfuKRHXfxHkH2t8bx3yzYp/u07ejP/NfOFwJ+BMxZ4uWI4fTSuozI92
         +iXN27wTdLqSKSSHamd2WbyJMqHqxIL9przjFtnAC+22Gd2qpYvrvXc1YXObm10Am6Zi
         F4prgfvVPvu2DV8+ydFAYLSwPIcob8PnYWz3i0ZsDAOI1TCyc6jmkXtqXdIPKaYxXL6a
         umXvbQfiU1Jti0BXwqnDm6plTIuSihx1+1XMmIf36vq+mGzP7TlDzIABn4p715VbNfLE
         FioQ==
X-Gm-Message-State: AOJu0Yw2UZa7BbqzlLYMhMYs6a9WgedvWk1/VRwswVFIgzxoBjZk6QnS
	yHDuuTIvJFhjVgYOBniK8qPiJbXc6KgF3U6f69MEXsI3BiOEAOsh18q4xqbs1j6M
X-Gm-Gg: AY/fxX5QfBM04dK+MfZuyOnQZRw/qy1a8vl6cfF/Rz6AQeft3jJNduHPyIBIdpbIAFi
	sxYUtWtivDONuIh8OuQN4QZldLfgongAwwWeEGgXQJ50AmAZB5WM5StJSoa75WG6zqn8M0KKHAO
	tvfuZMZF538J7dlXLKMp7y/94SXlN+gZbKwUZEhQluHhJhRm4k4CAOkk8C/FRME44Mg76uodVE/
	UPS4GCyzbhtUKMCA7hx+jIStElY/NcZ3QyYaBffdYNSslS6kUaoS3QjAlwefNvYkrgdvKzfJpVc
	AvxaIQUcPYOWZDOe0e9ZtdpmaVeCiRLCk+7YMLx6tl9mH7bA0Js2ZfXCfXCCpn1+cqhrwvxF9c/
	yrK4U8JKMv//VF1igdBldcbth9BBUBg+C9kLgOnMaI6FKmZ0r8j2GogVcPYarRsZ78s7jDWQIjG
	r1yHEG+8ZMwus9iwo=
X-Received: by 2002:a17:902:e184:b0:2a0:9047:a738 with SMTP id d9443c01a7336-2a58b51b64amr33338845ad.19.1768373390001;
        Tue, 13 Jan 2026 22:49:50 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:49 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
Date: Wed, 14 Jan 2026 06:49:19 +0000
Message-ID: <20260114064921.57686-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When disabling a port’s collecting and distributing states, updating only
rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
so that the rx_machine transitions into the AD_RX_EXPIRED state.

One example is in ad_agg_selection_logic(): when a new aggregator is
selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
not set, the disabled port may remain stuck in AD_RX_CURRENT due to
continuing to receive partner LACP messages.

The __disable_port() called by ad_disable_collecting_distributing()
does not have this issue, since its caller also clears the
collecting/distributing bits.

The __disable_port() called by bond_3ad_bind_slave() should also be fine,
as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Let's fix this only in ad_agg_selection_logic() to reduce the chances of
unintended side effects.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..bcf9833e5436 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1926,6 +1926,7 @@ static void ad_agg_selection_logic(struct aggregator *agg,
 		if (active) {
 			for (port = active->lag_ports; port;
 			     port = port->next_port_in_aggregator) {
+				port->sm_rx_state = AD_RX_PORT_DISABLED;
 				__disable_port(port);
 			}
 		}
-- 
2.50.1


