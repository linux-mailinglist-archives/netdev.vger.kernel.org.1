Return-Path: <netdev+bounces-289517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCn2B3iODGpCjAUAu9opvQ
	(envelope-from <netdev+bounces-289517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:23:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714E58237C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D136A3036A04
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032C352000;
	Tue, 19 May 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ieSJIB36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2E2EA749
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206853; cv=none; b=WRxBGNzksqVBMPDI7IJicgRFC0sWNk0zP+Q+3lbxSSfusAoZ48p8vruXTK7vdJTDqgJZkNf7ZOdg/JGEiXITEY+o0JoxQ5fNwwAunMXosIh9OPkc8i9+1xIJ+iAMWLx08U0NlgFnpVLDJIoASagnDw0XWt5ktF+2RD9mNWtzmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206853; c=relaxed/simple;
	bh=T826hjpNqV1T1gAZ91lncuOQV1lg6V7vwV2aPYJTnvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WI1HYYMlnTPuxJWZ+SvhyZEZRilQArkvfvqTQXb6D3qbYQpkJ+Z1EDAovU35vxaorHNXdvZfD+tKspZo6cd2fjUfHGcdBwVrbGDiSI6FbZ+wNMgdj2+r+O4eDgHwuLAuhjNvtNxGd06vx4pyFkuH/b1sEpkr5njIpxC5wohcnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ieSJIB36; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso43087595e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779206850; x=1779811650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIeiqy9zJffZ8luR30nmL4uNISyTEHJUrpfTc1trWbk=;
        b=ieSJIB36M2vs7nlw8QHMcET0ZLjSXWn4mqD9Up7p4Bz/1xoA6K7ya1ND2JSLHqRYmv
         f7wL8n4Cn3AqoRHkbO+fmkQEYvVV8ctGSBxfBrDI6D7isL5eFUJVfPohznbofEpmmjSy
         voBQBk5Dk6ufFXGZpGXNBQpWj4iBHOjB+YADPSlRZvsrH9K3uObGlRrLdXLmBpFO8w75
         BMnPtah6pRi/ZEqI2yjmr/16yDyUpZrS5W+r4Wo2WA6RBmAxXVtgREtPp+oRMKK3QFp+
         DrYbaMOUJNT2e+VjJprTwwdQHOHjEqdam6GXdacd/oQNI8G+deEk46rEtRNeOqosdvG1
         ADrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206850; x=1779811650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIeiqy9zJffZ8luR30nmL4uNISyTEHJUrpfTc1trWbk=;
        b=GVjh6ct4hpAjV44yYrxtKRdhxjNkpqvrm0R9Stp4GcPODzn3xeBi5Jt8Tu0csE8WkP
         8P9sfOft9afN9KqxfiwP4F0FWL4BmeloZtudchCPvBF9JCm5DAOuNFeew4T0QHbXdm7n
         j9Adn0s5b+1fkTcKB4LQXQMoWg3J4AiNeBv07vN0eyJfbzToojtlR4SXNY2zUQKvsU0W
         xK70vRSz1sLW5CtRHoMQa58jc1qIo0ukGgPcOew3xlIoUzs1hBmTmfC7Lp1tciX/C0Ff
         /fUWLWlpuAOowvJc7I9phMF5nQNs5RYHP3OaJwcsyUgi1XZSmADgPZKBRdKWGrjleHmU
         lTWQ==
X-Gm-Message-State: AOJu0YxXe9AZ2/EK51nl0M9CmaC94AWxg9LFy660znpuspstYT3eo0uu
	gBFsK5dYS2lplKDE2KR/kmkqXcULsfvo+ebxYowPJU9niSgo2xg19w1nHaTstDHNAaE=
X-Gm-Gg: Acq92OE6oRScsR7ZfTKhPqKZMq6alD3RzRyrhDLlH0iBkJNDExwaT18dknteBaVQWHn
	5BS2JDrQNZiZ1HPgfCSth7sqdrI11nu+7xnPiHCWsieYyKe0qPZKh3D7UyJ1WBt4lk5BC6tVk5+
	56zS4+fAJUiSJEHOzg3IXzKDuDVrsOh1flBz7aUYWtrPIMEi9ORirwCOhhf0xeKzL5yYZ1lIpre
	xr/AC5JLBxZKuyJL6xNYxuhcLXnSblHKnDPzaw/n+LWH1Lr0x01BuEkeTCMwEs/Ww4xoi1tAqTq
	WfWuGDwCp8HKb3kWNTgxHJEzPDdw+ZrqQsCEf1nn8/He7O6jPMX9m4anRuPZMQd9Nq0fSO4H0vv
	sA9rAhPa72Ftz+gACxfQQlOIOku6JNGZKgSVL+PlMCLSpvhlF6Y427qrEUrcb/Y56UrxjRSI9ie
	gs8WF2sCtbJ+zPMy1jz7iAGxS2ZMJEYTT4VMkVorsZY8wQciqlEJR072Nq/URyHFEuqn1bmUOJm
	Lu5rUehau7WFJw=
X-Received: by 2002:a05:600c:8b4b:b0:48f:d2fc:d025 with SMTP id 5b1f17b1804b1-48fe60e14d0mr295768045e9.6.1779206850148;
        Tue, 19 May 2026 09:07:30 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fffb9aac4sm408021175e9.9.2026.05.19.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:07:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 net-next] mlxsw: minimal: Use named initializers for struct i2c_device_id
Date: Tue, 19 May 2026 18:07:21 +0200
Message-ID: <20260519160721.1597568-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=T826hjpNqV1T1gAZ91lncuOQV1lg6V7vwV2aPYJTnvQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDIq5ZSqAcx8euWpuICn9Jl8GV2lVp1hT3rQK6 lJzNLwxJN6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagyKuQAKCRCPgPtYfRL+ Tuk9B/9VwjBBciiRXWFrljQDyNEp+WeY/MLGo+Ue5n0W9JqAUUPf2Ugtg7WRAmzJ3pDVF+XvpXP EU8P8T7I0IpKbiECj5ZFuMmyVj7vHBXv4fsJ6dboXCCasKi4jZJobHpNA+pz76U89C1zptQja8Y HezKh8zTLoAK0M4RzyWWxQCrmijdywtNrixiYOW9FtgLMqqhXaxz5goKEy1wswDpMPSwfKe8kO4 eIPeJhuKD8rc5a6NAzfM21Axjf/7IbBgUyHUakpQdXLxv30RD2ThBwNUm19b/8nuOnY0dd7KQxF /bFyV9lyyPzDmA0oU8kVkpauxknxiXe2uo3Nz0DWxlnvKatF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289517-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Queue-Id: 2714E58237C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as this driver doesn't
make use of .driver_data, so apart from the better readability this is
only about consistency with other subsystems.

This is the only i2c driver under drivers/net/ethernet, so this is the
only patch needed to adapt the whole subsystem to the new style for
initializing i2c_device_id arrays.

Best regards
Uwe

 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index 512933dbab9a..1fee57054b20 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -713,7 +713,7 @@ static struct mlxsw_driver mlxsw_m_driver = {
 };
 
 static const struct i2c_device_id mlxsw_m_i2c_id[] = {
-	{ "mlxsw_minimal" },
+	{ .name = "mlxsw_minimal" },
 	{ }
 };
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


