Return-Path: <netdev+bounces-242283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF2C8E47B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EE773524AA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE9331A69;
	Thu, 27 Nov 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKXtZQlT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EA3314D1
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246932; cv=none; b=nLtDStj7kMeBpiKDwtnS3UrNUO7ONX1cAI4SzgCynJJ6Q2VpCL78nSjCYS6eFJuwHAX8pfcTDaNoIoJEBaVKeUGhYat3gauResPaeelCk1zqy4nWiXFnfPYsp9SNeH966ptq9IZwZhR66EkXvhs/NcpcyqUliiDuEd8U/tOrgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246932; c=relaxed/simple;
	bh=0FDBQgD/WbD9xj1dDF1gPq7NyjyfJGnGGRSZGnr4ZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcnyLBojmIKKDxNEXaPvtsgIFeKxZpxvytxNkrcyGh67UX40W4tOyxWb8F0ztFIE7p41hKAcLfoD/X/Q+3dlL4n+qRmsnGbLFDQUZiaFfUizMb79ptrE0PFcKCE9Z2O4QYX805Pdhe7UPM+LH2FxPl997dO+3BoeWX9ibG+L6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKXtZQlT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so490900f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246929; x=1764851729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W10nyLh56RvLREhpVcYR0h98rN9abER2e9fA19uOK34=;
        b=TKXtZQlTkNtfi+b1mcY5zvdKhaPmvN+vfZhQqUnAg/7iDRPY7hFddpBAL1VW7YuthS
         RwQCUbf41c/dXalfGawYOOj8v7EvzAp8k17hrt1Irq1uzVmkxk2CPJSCqyGkiVwto3v/
         t6qM1PWt1Xy42LuJ4s7t3NR2nsa60muDiXLAEARYH5ISlG8E272VOZoRr4sszSQz5AY+
         OG3lxB33OwnUgKkzuumv8mhPLRSsdqcE8nwgwJDwsnZvlkyop/45+tURwmxWUozT1zO9
         R20wxBQCJxL2ixFovK8GMscsQlGosWSWsw9dKmpK0uIzpMYYMaqq6SsY+7NWq5GcdXuY
         p8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246929; x=1764851729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W10nyLh56RvLREhpVcYR0h98rN9abER2e9fA19uOK34=;
        b=WV5pWW/hZl67Xzy7F+9v4bGPMsPlfFTAv3sXeD1KjhqC9wZsn1kFDgBYdrHkVHd8yE
         4N+3Y+EgVhD3QctFfLO++vsD37RtM8i9HUNu91vwDQViGtLEIW7w4Foo44cvU+/Liyce
         H1Fs+eAqxZ5x1t0OodMWOYVgVZ3n09HLb38iHIQh/HkYt+vuSZM4e6MQOLQijidZPotv
         VnmOOeg4PVMl++HBvC+JEuhxxItis6YeULBlLO5j6XDBQieywFSGMHDN0rsfRDTjbrHF
         gNkiJRkx+Dl7P8O1WGKtMcOcOg05RoOo9iKHm6IE++cNHBLtE2RbtJeazofGFt/d02UB
         aQpw==
X-Forwarded-Encrypted: i=1; AJvYcCXmyZnYhFnxGymKIEsjYwe0P6UYEOdfo8yu3JN8byOnZEtHFrAyg4aDyHhpyFOGFJTifG93XN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SQYcofSmINP+tZ0JPiKsZo4cr1R1kdXfZQUBjfLn2AS7f7Lx
	mWwAHpdAIgFOw9h2kOiQR8qTgauFUDKPhaV0uDJ0tf0RV1DpBZ2lJrVo
X-Gm-Gg: ASbGncsXrmWwVjQhkXTnuYm1BBH+1mr6EAWkCKS5QcsnJOiUhxxFsOemtxL3Rjq4seD
	YzxrFbxYOcoK5XOhuyhu3SsB143m5wOK+f3zncOc6EPUCuxOCpvBkDFH8hOS500fWDMJGy5LVJW
	Qwlbwcj+u3tcBWWbiOEjPUHQ32Nircg9//ZxUwzx7X6LcVJXeT7aRdDehsBgUc7os0WazeFVbMC
	vAKMTi/mLB0Ch9uw8Gs2sfyiw70PbOyD7gw3TBrPyqEUTU6ndkzP6CK1j5EJk4PetzRlwVLC98t
	UlC4KFu1GPlcwuuUiDKkGlpPwWscMl8HqVULU+7h4cNyIUtKInypvFjcMMz5kXcCoX11lZUBYJz
	nQP8Y5zNATRKFw3tziR6jrS2MQg0CqrO0kP6F1pDO+FCOVsVzQWpOXKpwNEdYzHCKz2P1YDt2ul
	hE8i/KyLc/IEl8JRv6IFcu49E25w==
X-Google-Smtp-Source: AGHT+IHXORm3KFNXD04SNdvnPgnH0/frSdf1r/gKWxW9SIbJH71wBa9z1k//4rtrUz0r/MeNpOLoAQ==
X-Received: by 2002:a05:6000:40cc:b0:42b:3cd2:e9bb with SMTP id ffacd0b85a97d-42cc1d2e29dmr24285467f8f.32.1764246929109;
        Thu, 27 Nov 2025 04:35:29 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7864:d69:c1a:dad8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm3220718f8f.29.2025.11.27.04.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:35:28 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Florian Westphal <fw@strlen.de>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 4/4] ynl: fix schema check errors
Date: Thu, 27 Nov 2025 12:35:02 +0000
Message-ID: <20251127123502.89142-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251127123502.89142-1-donald.hunter@gmail.com>
References: <20251127123502.89142-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two schema check errors that have lurked since the attribute name
validation was made more strict:

not ok 2 conntrack.yaml schema validation
'labels mask' does not match '^[0-9a-z-]+$'

not ok 13 nftables.yaml schema validation
'set id' does not match '^[0-9a-z-]+$'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/conntrack.yaml | 2 +-
 Documentation/netlink/specs/nftables.yaml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index bef528633b17..db7cddcda50a 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -457,7 +457,7 @@ attribute-sets:
         name: labels
         type: binary
       -
-        name: labels mask
+        name: labels-mask
         type: binary
       -
         name: synproxy
diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index cce88819ba71..17ad707fa0d5 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -915,7 +915,7 @@ attribute-sets:
         type: string
         doc: Name of set to use
       -
-        name: set id
+        name: set-id
         type: u32
         byte-order: big-endian
         doc: ID of set to use
-- 
2.51.1


