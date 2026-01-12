Return-Path: <netdev+bounces-248935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A01AED11903
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623C8305B6EA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677C4349AFE;
	Mon, 12 Jan 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQaZ/Iy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71C34AB05
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210874; cv=none; b=ieOKOiso/odhM0Vmsc3eilL8yA0NNhrGLxnUxD9SMsBck+Qt3Dm9HFZH58GB0lexS9hIzFoiPlm3NcU+KNC/EU2JjSDcqBA5+OgtpsxVeRlOZUaTt37kWrc/0XjTDOZFCYLv1e03rw9hryR9bYybIK9jnv0PzoSx65zBZSq56Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210874; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh/imBIJWkYPiTAiC7ppem0W33sv21dTII+cLIZdAbugNwCfwHhuuNXV5S+40YpWT0nDd4PvWYdxDrqs+xMw+UNjA7Xt3P6u7TabaDHxZvMOY29ir+20wKUjUjZhkZBAK6m7wlHs7ItUVfWEeFCx6BtzJvggitU/Tk3XlLBgg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQaZ/Iy6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so8732308a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210868; x=1768815668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=hQaZ/Iy6Dl5sfj5+mmauSTFRztpCLtxoD9hULpPz3qNgL+UIDZn0s6bTLSxwvwrPCI
         0jrwlx7a5RR7C2JoaztGTEEXwZQHWK/bOtlCYpynYSFBPmVjJ8RAk+6YKv4vR3XZ+5oM
         pvcm54a+N1khUkf+mo/+Hclh2iz7rZ0zc1aY8XZ4qh157bC1h7eQDpGWE5okbyhVSfP8
         ekT9nbeeO3+sHuQ8zydFJrESDxJQrHi39xF5CeuFqvQ3ZEi7CC+7gtV3kcWzKgSrp72W
         goKlClZGhtK658aZYtCQ4oH412UqPj35jOOWfbs3Kq6v4n4Du0a52rVae884ch6Rmqgj
         HPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210868; x=1768815668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=um3PSIaZS3L+A8hcPhMi1G9h1J6sPnsW85ucs7ERxM9nGnvHl4/HmK8Zkm8VWqpNge
         GayWmP0NM2u48noIX8irge0Nm5dk9xk7RZ2EHStz6LX2g5kYCIMPIEZz3HCZ4IM4c/Gf
         /fIILKrFvPtP8I/S6m0Wjykav1czbci9nwJdKDX4Nnik5gpVQu1/Tg2ety10QHg3lzgj
         Ssv7PxpP9xo7lCMefeHmq+aCXgzTtm3DatrNn+3f1WGoUeadjl/Pct1UTsiPvM0KAtGR
         5j1YLvuc55D6TB92g4zp9DrLgqoRqgq+PQiArpmXg8HbBgmyelii1eMQofdf0mzOHiV3
         mB7A==
X-Gm-Message-State: AOJu0YyidA4GqyyawTr/uwSTd7t/JZak44f02aeuPjiB9kSnUO1ksUTq
	uiIbOhuX4Ih515KwHSFmxiznTba99J1PrvT96a8mIQ6XosjWzdLYxjHF
X-Gm-Gg: AY/fxX65sMyafRQIkC1iP5m/NGHTe5WwM8SnlV/GCEXcaQCx/8murSyQMQReQTtwx7C
	asXNmyQkB3NF+RHf6K+AKwQDx8ghH13iUdWy5gbvD4zHoMogAY1sZZUbMK2aLaNNemudfNQykpz
	R9XzjGI2qKwJKOT1smpnFMh+IvckKHMNkRTLaBcnIWKU0txPwVyS5ZG/rqZeBLokNntZAMQa9H9
	rc/yxFRJM2szgxfLUHJJ0vbrNoCyzF4K/G1+9gyJ/W5NVrTXeuHxp3Pj4H6HFAt3KyUz+Ai8mTA
	Kk862wErn1UUIbk1m5WHvnUb0bHifvk3S8PtNcAXTPjih01tINEy5hB0rCH26PZFxLrQeASKREJ
	PDBEDUUxDAvQmDZPgwa8ZzZL9YLrKPupv2RgOUfvpimDSau30HP/7tBCiapeqW48CfNO6d+3jdG
	zcKh6pg+ElXmqdx1vGoNFbzYE3
X-Google-Smtp-Source: AGHT+IE7196ejl7yFzSqk+olKRAYnC2uk75Y2D533VodUBlVEhIaeYQfNJUulVJjCL8VsWOCEwYsAA==
X-Received: by 2002:a17:907:d64a:b0:b80:48f6:9cc6 with SMTP id a640c23a62f3a-b844500df90mr1559904666b.32.1768210867980;
        Mon, 12 Jan 2026 01:41:07 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:07 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:54 +0000
Subject: [PATCH net-next v10 3/7] netconsole: add STATE_DEACTIVATED to
 track targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-3-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=dlucml7NE6QKov7VCIJKrbKl4nY7P7ygZT0UdSvjY2SvFgYTxYH1Iq9sObh2A0E1ovc8n6xTw
 wvyp5z1BJvmCxctm7jBsrYjDXJcEvmZxerynakzqwbN8JVznlQkw3AH
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


