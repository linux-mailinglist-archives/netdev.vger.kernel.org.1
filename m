Return-Path: <netdev+bounces-233844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A0C191BD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDF85661B7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F61231B806;
	Wed, 29 Oct 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjF6nqiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB531B10F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726193; cv=none; b=KL1gPFMqDfb8CewtXqQdSUG/2LesOyzf8bU3RVHhmxeX6ggGm/99iP9sZuyCwfjBcKx5zwOJuurvpWkKzJ+CO6kiaahpWGxCUW5CV5aTZZ36gKeesCA2QFRYnduTFDXOYHiSKSLTePI9qL0GmKSTvdpPsQtu+C73lG4RCpdjUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726193; c=relaxed/simple;
	bh=IFuBS7haZi+1kTM8IJzSktIKoNv8ReAXS+1kQ+tJtak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSE98o0/NgJp880laeaUoyQt1sD27+yUjRAuNbhoRyCaE29CwxYXQZcyKdO4UVe4U8WVZDdeR3kxW42lEEwNtBtXGlQ7bztdcXO97qYjxwr0qhCE0OCcBY3Knveero7uq3la+Lk9i2qHFi2JMFl26lMV4GYSXRvxCFyNxluHDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjF6nqiO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290d14e5c9aso98604145ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726189; x=1762330989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaHhDa8PHuXgCu/CZ7lCayELGigeh4dQ1UWKLOa3cv4=;
        b=jjF6nqiOy5y+9FrxgIVGL3Tt4hE8MQrOVvlig5qPexfEoZAktmRy2nXZoh6l1cEsgh
         GIXCtrEWcJP2rqOF+1+S6VmAh2ZnsL4gatmOWv6Scomak+ZsgJ5R4wtrwEZNH93kAJr6
         2kxx8ojwx81mHvOyoHKEdAyY7y2i0uWz6CLyhYcMPGcfTS+qTMYD8X+BUVQwIeCcpkXL
         7j+ivMP8y9RfxWvECsAR2NeTeTd8dq7hDd0xqrtSXvIeKYFhOV6GqYq+pB6wxUGKpu0w
         40IfIfRYGVDj6kbS7Eb6d8bckinbo4Frxt6WakpmPCdKAmfJt7VKD7wFA5NgUUk1m7mw
         7tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726189; x=1762330989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaHhDa8PHuXgCu/CZ7lCayELGigeh4dQ1UWKLOa3cv4=;
        b=hgLdforNIeKIbis89e7V/a1aOWta/niLcWssgRjJHk9bVYE3Tno5vxVbrBYOqX+pc2
         ymRk6Lf/bSnZsjeICZiMs33LB5vd06qjqxrq2F0NpAm8bwlJ9y/cCnZKF93bxMHh1+sN
         Xxkr8XVjxtWj/wvER8oX0QhY57Ee5E6gHGLV0mecW3+u0GfMWLI3XmXCJp38iL65NT1L
         KwhFIs1ldiJ46x2HyYzn5gVD+3G8PsGyFWwYXcSNtbN6gM9usOGc+vea366fGOBxupI9
         95Ky+6ERhwr8ATfraKegs5gB4YZAw/kYx9S6j+MFl7fl7SDMQYpQqLc3rFEy+TS1IBPY
         aYqg==
X-Gm-Message-State: AOJu0YwNkr87q56BalDF4/FXriFfjEWBlqN2pNrWhNBpf4Oq/9+PSJJv
	UQdQYFcYUq/hrRoysA/cIb+Gno71SUCosUqQdW5cIA/hiPhzdMYyDFePi3UwOTZ0LJo=
X-Gm-Gg: ASbGncvB+7kUCI8S2N52PCROj9bG2P3d9EKJirhAV2q3FQt5Ka6z0VVBMaZZm7oB+uH
	06BtjJfz8lzJIIFOazaPx5vx5mn144+4RJUsoylnsgJMtvgn6kI53NQAgyoCaHW8rNVHf83azZN
	5miftmH7NqsDsmTt9c8dRM7zoZRVHOYG17vbjU4Z2NPz0AjNkZgGuzoCleWhaiUA6VXszRulvOP
	faLw4ryCP8uCuQUveLWwfCW+VKX0lD1hYF/HjZynca5wO0x+oQYuNJ6avEM2gCdLDHXggk71El1
	ogW58tFIjz/M8OTqDJzQoPoqugqex/vm8HmfjiHcZEjw6BRTzKME/22RbZH+q5pLj1GZ8S+ll3h
	mPCC+QBFlVzWyn4ovOTCCuhWHkR/owQQUpDpbTkXPZpZRvZFTQha6mPRCaMhh/zSwa4U5603v1n
	VDQOaK
X-Google-Smtp-Source: AGHT+IGtSlDxg0T2oukXZlxpD3jzIWP+RA1AXUJtoVRhfHR08fUfLWt0lsrBketiOK0arzNKfhB91A==
X-Received: by 2002:a17:902:e78c:b0:252:5220:46b4 with SMTP id d9443c01a7336-294dee991damr22816595ad.37.1761726189151;
        Wed, 29 Oct 2025 01:23:09 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:23:08 -0700 (PDT)
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
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst attribute types to support IPv4 addresses
Date: Wed, 29 Oct 2025 08:22:44 +0000
Message-ID: <20251029082245.128675-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029082245.128675-1-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with other rt-* family specs (rt-route, rt-addr, rt-neigh), change
src and dst attributes in rt-rule.yaml from type u32 to type binary with
display-hint ipv4 to properly support IPv4 address operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/rt-rule.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index bebee452a950..7ebd95312ee4 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -96,10 +96,12 @@ attribute-sets:
     attributes:
       -
         name: dst
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: src
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: iifname
         type: string
-- 
2.50.1


