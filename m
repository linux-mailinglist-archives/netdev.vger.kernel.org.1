Return-Path: <netdev+bounces-235743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57011C3478A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7B7F4F4082
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BD2C159C;
	Wed,  5 Nov 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaiFqWEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB502C0285
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331341; cv=none; b=oaQRhQTpqd+8wvQ6K+f/LGbmxfSOlh/QdubxD4K4YiglOepA8chf5YbG3b9ECj1IFf8arvVQ7gAT45R0lZdVEK5UeIB0eJEtURv7JQBeQBl5OFA+FSRuxG7xY87J1BiHLALx0Dr+WsooK1J6SH8pg/XfWfcWLTJGBIz2zHt9At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331341; c=relaxed/simple;
	bh=utVy6JvlKERgKujYhOgnVpCTFIWZ2va0wC2CkiqbEWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWstqSqaZOwg/jZ03J1T8wAi8eDz1PWvrqsy/BNvcQ6Ud8/yeImWqK5momDpvp1jPNqbREJwwV6jt0Nqws5GQNKuEz3d/LhOnWPK8Igx9SpACB6i5NwNEP8S99uFdvrH4axJKoQayHCR4qDq9cZKkU1rrbJrUv9dAEGXVtmqhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaiFqWEY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-294df925292so59230545ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762331339; x=1762936139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=EaiFqWEY6Q/K3Sl6dC9+Q6GARbwPJsG+OvLfUMpAHQbo3HRHNHbOQAVv+tTgfPRBpK
         JSbLV8a8m64NQKWsSVHkArJJJpUxH6yhAJpDZMmJelJPIevGpYyxJL0uoNdWjFUM8Dlr
         mVde0aq22JjEmQTpBJxVZIzQ/ziO7vPJHUyM/sSKfX3XSa18/jAEgxeFvPkTvqk6U9Kg
         h3TRBKnlREvE/if3d3/2J10LLgIXgZlQEqkrmco9b84Yh2vkfJpCNERk6GEfQJyb4tyi
         4GhwS4XLGJjHX7SghG0B132MnynM5VPf2+USbBcQzyEOmo6Nv/CFK3QrMAgbeM/r/fjz
         /kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331339; x=1762936139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=XJQVroEf8PdegLeiJCk1zuKjDuWvJy6eEIY4T74v0hiC6uqmRL2n7ywaf2sd+sqtZN
         /ga/O4GMM9zJtibtvFfEPnR5y+/N86HpR7/ggBrkrb/YKHmDRwpgrZ85hxcxqFOgRHdT
         UOMmRvi0USvO3z13sNdP25DwAyp0ekHxzo/ir8NiQJU27GY9bAS8J4Ag4souhWOxbwGD
         vWdF/txVbebyTTpD32JK+XXDHzbfvkcSYBAAAcWcFRhW+11cQnrVgyyFMQyuuz0esY4O
         8iQf6jB/gNK039lt4Sk91xie5duBgqhyXlfQt85Xga/obAmrxBK435Wc0twhv3di+TDK
         +t4g==
X-Gm-Message-State: AOJu0YwEng7F1rFxMUm7W5fhsnC3L9+zSjGA9kdotEQKTbTTbcVk678v
	30MSNmekNru7LBbvey6E7Ae9K6bheWrR5R0vNJlRSmuG4Tbxpia/m/7YNU2oEG4OZ4w=
X-Gm-Gg: ASbGncu0I89pjWXWz3di1ZPdTOjZ5DbeyszsN1Xe3EBJn8m0fzDJhlJ+GmOW+1CbE02
	K55uPS3CidMvu/GiEZZP2eOngeglhDgTgkCrKh1iYPfZsqyid9lPx5bJG/Op/fl9gzK5HC96uRv
	mYMjjg9LUiKjM56/7EAx7vn6bQNmaERTshVc9DQu7sf67lWim64D/DWm3CywsP38sJBt70Fuj8D
	IUIHYWKWoHNLBmy9b0Hqce2UVpGQ9+IDeL2CiSdG0xikJ5kOesQs37RkEduynI67All0/Co4a70
	jU1yMnIrYgDicbQOBr2dZd8BQyDhBY9V5hzrY08QlMybR0jmPmMrih19HpJTnQIUsE2hgp5ujV3
	53PBxiqdS9mW1c49OW6uvPCtATHGXBr2L+KgEMOHscZLf1k2vFzPbxVEsP6eZzr7adgCZSNgK5j
	JRq5Ke
X-Google-Smtp-Source: AGHT+IHMBnAoq6eQjzAFvxshpnJPSaT2joAxTFlo6CayXufhJump0lrNoIzXGzUXxHgee7G4OZcgeg==
X-Received: by 2002:a17:903:2ec7:b0:295:a1a5:baf7 with SMTP id d9443c01a7336-2962ad96af4mr35248945ad.37.1762331338804;
        Wed, 05 Nov 2025 00:28:58 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a0c9sm52171705ad.55.2025.11.05.00.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:28:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Wed,  5 Nov 2025 08:28:39 +0000
Message-ID: <20251105082841.165212-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105082841.165212-1-liuhangbin@gmail.com>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing support for parsing MAC addresses when display_hint is 'mac'
in the YNL library. This enables YNL CLI to accept MAC address strings
for attributes like lladdr in rt-neigh operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 225baad3c8f8..36d36eb7e3b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -985,6 +985,15 @@ class YnlFamily(SpecFamily):
                 raw = bytes.fromhex(string)
             else:
                 raw = int(string, 16)
+        elif attr_spec.display_hint == 'mac':
+            # Parse MAC address in format "00:11:22:33:44:55" or "001122334455"
+            if ':' in string:
+                mac_bytes = [int(x, 16) for x in string.split(':')]
+            else:
+                if len(string) % 2 != 0:
+                    raise Exception(f"Invalid MAC address format: {string}")
+                mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
+            raw = bytes(mac_bytes)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.50.1


