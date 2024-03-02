Return-Path: <netdev+bounces-76826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A558C86F0AB
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 15:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F0C1F219D4
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809217BB2;
	Sat,  2 Mar 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBKWT2WW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738CCA7A
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709389113; cv=none; b=iI1h4VZHvs+hNsBFqaTLi21JhNQ9oqmA/uPa5wgX1vuYmxKwNZa4yM1qD4nGdb889NHM19USRlr5XRpfcf621GsSgb7Pc0Cnp/N+xmJu7mpeC2WuRujYMx3+E+cKCN8plogNn2AjJ9fLIio4+EQh4E0NNW784gKIAmImEpXT0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709389113; c=relaxed/simple;
	bh=CFKOXnBLUZILjiBg4pcYZW+JL+cXSXkj/PGmEjKzELk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PtetrkPpas8hZ9/cYfqspW+0J/IvZ25vfjuycISmyXiKYk0yMMvYA51egwCzWEJCzQmxNslBXSYHFdcWVX/uaL7oaacS7Ea2dlJ6Gg/8OU2N0YNvt0BzEZgu+Oc6JNv8Xfx/ceJWF/MGoEB6S0gQr628HGofwUy7jnMpbXSGY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBKWT2WW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a444205f764so411335266b.2
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 06:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709389110; x=1709993910; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7duGMYvWuGy3i/SPm3ni+JoXD6E8+dbuvsd+7C9Njfs=;
        b=mBKWT2WWdF+WonaXgT7Uz8JmYxJvklzAltqBF7GvmvMxGvvPsuqUEuFEhW4xZjzuZm
         2RwQiMkhooZsknYxSOQRphesx0Tm8tIAvoi7fmMJRe0KGbJLioh2I/BaWaDhnKiRcMCC
         N7HfvFgIjCw8Xj5VflQvkisswLd8eZQcKvX5Bfb1vraYPP0YggOkGo17FPyfSVNisa8y
         aOBOe/VMN26vXnr5c+hac2QGqqpf9AlDPcVpqdc4VUk3OuotMolW1PwXPa0MPnl6vpAw
         6ZVOYV2GCCF2NnMn0t5tRESoRgRyIskR3vteeNnrMEIOGSDDbmqgOlUujoM/Ule+qQ6u
         sEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709389110; x=1709993910;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7duGMYvWuGy3i/SPm3ni+JoXD6E8+dbuvsd+7C9Njfs=;
        b=iCMJxMHB05n9Cr86xciex3pl0fxUYU/HOOKnpGjfufv0VSVlQ3Lyl/r2G9VaiuHVlg
         v/MWPiUwgemS2JEUKVCJ+OjhKHNqAViiCqtA2KthRtyBLL44GRufoeTxkcuSxsmvHXrm
         EaJ2HUIJRStota3V2yjvyTc2XJJRxFz4Mi3lsLhpLzBgAbkO19O+3ht9YezlMwTTNszj
         QY12mH6eNEz9xRU9nBbgFi0dPuJt0sa38FUM9KLLUhE6RVMp17BhNHkTYSeKOjeibY18
         ydyJnzMmpqhPX3Bp70gtzEtRhDFkFYEwssp+wRhi6fmESfgjqKZw1wxYUeopr3U4askN
         xYGA==
X-Gm-Message-State: AOJu0YwWTJ7/exiGMdGSgRANK0MmAwfDXJVb1WGvnZQ8ERSaQO+NsMjU
	DAxwKcsn4LJ2O2BFyYB560JFXtJ9aWL/2MALI8OHepiQ5CVW6yYa
X-Google-Smtp-Source: AGHT+IHWuerLOCqVskzFlAS1J2oT9XzVJQRQKGG1XFrx5lccD0eHsNHLvxNHhn/IfwJxBYNE5oCJvw==
X-Received: by 2002:a17:906:344d:b0:a44:9483:b10 with SMTP id d13-20020a170906344d00b00a4494830b10mr3067582ejb.13.1709389109352;
        Sat, 02 Mar 2024 06:18:29 -0800 (PST)
Received: from ?IPV6:2a01:c23:bcce:a400:2519:2036:7f0:6005? (dynamic-2a01-0c23-bcce-a400-2519-2036-07f0-6005.c23.pool.telefonica.de. [2a01:c23:bcce:a400:2519:2036:7f0:6005])
        by smtp.googlemail.com with ESMTPSA id gl11-20020a170906e0cb00b00a448fab02easm1606834ejb.37.2024.03.02.06.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 06:18:28 -0800 (PST)
Message-ID: <ad7ee11e-eb7a-4975-9122-547e13a161d8@gmail.com>
Date: Sat, 2 Mar 2024 15:18:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] ethtool: ignore unused/unreliable fields in
 set_eee op
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This function is used with the set_eee() ethtool operation. Certain
fields of struct ethtool_keee() are relevant only for the get_eee()
operation. In addition, in case of the ioctl interface, we have no
guarantee that userspace sends sane values in struct ethtool_eee.
Therefore explicitly ignore all fields not needed for set_eee().
This protects from drivers trying to use unchecked and unreliable
data, relying on specific userspace behavior.

Note: Such unsafe driver behavior has been found and fixed in the
tg3 driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 net/ethtool/ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 317308bdb..5a55270aa 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1514,17 +1514,12 @@ static void eee_to_keee(struct ethtool_keee *keee,
 {
 	memset(keee, 0, sizeof(*keee));
 
-	keee->eee_active = eee->eee_active;
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
 	keee->tx_lpi_timer = eee->tx_lpi_timer;
 
-	ethtool_convert_legacy_u32_to_link_mode(keee->supported,
-						eee->supported);
 	ethtool_convert_legacy_u32_to_link_mode(keee->advertised,
 						eee->advertised);
-	ethtool_convert_legacy_u32_to_link_mode(keee->lp_advertised,
-						eee->lp_advertised);
 }
 
 static void keee_to_eee(struct ethtool_eee *eee,
-- 
2.44.0


