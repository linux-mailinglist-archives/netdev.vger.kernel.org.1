Return-Path: <netdev+bounces-237042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE159C43C49
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6463B2069
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F12DAFC4;
	Sun,  9 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSqDLK7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768222B5AC
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686379; cv=none; b=jzIIQ0Qt7TQgePOjgzD/rAqJ/rkyBZ3VKbDwe2eO+tZoJzycpmr07ICUjI4pExt8w0cOMVWaJWNKI9qAn6L9QycQ/8KwwcfO31cB2u3WzZ//RnpOoWr/I87hAoXJWxn4odpIevBUPZPZonfd4lmc+LO7Gwk4+RhOlqN3SG16PO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686379; c=relaxed/simple;
	bh=0a6Z9vm59vHUX3M3EDlQdpNuJbepNNHLaFpEBjgVj1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAPCGoFFMcsiR9zd56oTK6/B0FeG0GOezEq/vf9kBDidUo7j6eoY4fcTT27Repmw/NsASLQm4SS2KmjYVIfGDgpLIB93VT0rZTlx+JYNQdvupF9CUC9aLjfdXd7oYm64a+XA6W3N800JQ9Qd984PvOJcr9swwL1PY77DRdHcOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSqDLK7q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b38693c4dso89776f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686376; x=1763291176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=PSqDLK7q+7+x9cpznSyDTJYm/t3Yj7KXUS4bZcNOwy1Z9zFvLA6GgVQynuuveJrA8I
         8viCBBc9foVP7X4unSNMkfnnvKdwq8EfGv2P3HANFP+UffL5knxtRgkoZdbFykK3KK9b
         zFIIUjkdIgwCdgr7n5PXqs7TZn6ZxS0X5SOhQZ8eB5YfUkmj7Sv+jK27/1kH9ltqPRfM
         d88jd1laeyzm5CeXpfSU1sX+fUbg14UpE8zl1hRABqbP0llFUdhakHIOPxwq6QbLcSOQ
         dElBK4fdGwJAix8+ohmIurRoOSaF37ZAFS5reVyrfy6Zr46t5oQ8peozu/0fTeCeAKs/
         Y38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686376; x=1763291176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=fmsvgkTkbDdHjAWSvU/Yw122IRTb3jjOGCSBTFnGFMPfor+ky0wqCgZrb7DRuvVrmm
         iOKx7GNP5ecV4OtNke/l32lBrWJHENoLPMBYIru7QVOipj/tek3BP8YUlAxMt55GEs4N
         Gg9kZeO0GeENbC+yse7MJ08jHdBZHxxoaLuXOvqfSlxzWkAX+fKq6nDc566li0WIYpBM
         e+0bvDSQ5sVeoFSswo3URzk4HhFW1W6/A26MnJJvxZnOUBVbHr6wM+yZOJd14fy+xD3J
         TW56PemrspSSmhb3q2tZE5c51SX4fF3Yh/wO5xCqJX+CUHrsryQEdzCXu0DD6cU/tMsh
         Mpmg==
X-Gm-Message-State: AOJu0YyvjDIWeWOBH6ayhwm44SYObHGKAyvMP33c92b8sUMckPZiuPEn
	n5zjLgnAltKgMJdtPyzvYN6GJti1o5mOgRww+u4rJx1b6wfcPzM+wTIyoLgXNw+g
X-Gm-Gg: ASbGncsfHHTU7yFURK5OSL88C93uNkQg5eSAtY31OM5o8P7Ey0ZmCGQoLu+LTR5d73q
	AX9qCtVqoo2130vqpbnMpImHP5tP1CQsDu0Rl7klGTGoUm7O98RQaWce4Gof5teX9GEHe/KAD3I
	ZeVWiCyUEANVw39JgkJ6aM54dffi1Gt23WNfWD886OhToPKXKGZddv6QYN44XvVPg2VR8Hn3sZM
	RCAXtBprcEyqj65bDyxkAs0Ef+eqXU6kh7f9rKAMDZlymOMudKAYUp86mFX05AwO6tN70obhVBU
	aiIGe/pzgaU3MOXnGqCJlxpk1/kQFe5/1JHriYWMDn+6r3LjqKS8Yd++DJ9ES3L1qa2lRLipOFE
	F78P9Fhy5LholO2fta2RlQCzoEl4Ex6gNm23UslWmdeS9YE7qHayhpBC0dpDJyYz5Ca6r6A5tUB
	gbHRrPBt5xRGZnR9A=
X-Google-Smtp-Source: AGHT+IHFhjADorg/ZR5107ihIL53sgAhlpAdhqkAU05FL/iFU41EOoPQsS82Rvhk2qa66vEBuFTWSA==
X-Received: by 2002:a05:6000:2f86:b0:42b:2a41:f2e with SMTP id ffacd0b85a97d-42b2dbefcfcmr3776049f8f.23.1762686375742;
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:51 +0000
Subject: [PATCH net-next v3 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-1-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=748;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Po4s941eMErBwuDFYeqR/VDMArYoBzjcjN8/MMT+h9s=;
 b=Dob/xrKXJfj0d4xZnl+MCY/sthJswm5B+vonAmQ2jJUC40wOI+WQMq9EY9UZP0OdSo/OqAzvi
 sGBHZfFAmgpACXKkgVcqacoh5HiO2KkyE2FaVqEAiOjeUmhl2PYJVn7
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..7a7eba041e23 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.51.2


