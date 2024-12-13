Return-Path: <netdev+bounces-151714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBE9F0AEA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9574280F7C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545A1DE899;
	Fri, 13 Dec 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/7g9QoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB51DEFD9
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089159; cv=none; b=vE0IokF5m5Z26ete3p6/qtixJNkVZ0ZulYg1dOvm+C5wLqyKuq/MkF+urFt+qbOD95qzUcEvr/9P0K6XjQqUYBE15mc+bKEfcfqbUUqrFA82mG1fOuKexqr7n7NMq+pcwR2nkM2juFZTAcFiRkN+DNG0jasfCHqYZciHjcIO6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089159; c=relaxed/simple;
	bh=C5DyKWRrJmp89zunuXlZvYB4FONLrxIxxcXMiw82pIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtrLmAq/uWFrrXtBvg/daXk/f+mki6uU2bUwZdilsiT2L64gfdqaguxxi+ohj0DuUrn25l8pLT1pdsoAvFgK4cQ6FYFh7c06cIJuP995lrSf7TnIdrms8Xb8XA3RIQ7+cnmZZTH8XUBgokNxl8sAGbQi3PfuPDpSv35jKaKCOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/7g9QoC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6aad76beeso247088166b.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734089155; x=1734693955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lB6IxK8mzcFuvNtXhWuqF+wJOmcio33wWwCQP3bRdo=;
        b=a/7g9QoCK1knfVvh32lLmuZRJD6rBIKTUbT8TOwp3bOm1lUcHhPfh1JvgGAuMW7gdH
         t1BmlbxmvbNsiooVv2jeU6gKMCCK7yyrW2fqvEyb0f513YjtrAMkDi1AE/eVHrHfegUY
         UGt/PLBwVrAmPCZ6RtZDReeMxeju70oGf3+YeeUDsLVjRnJf1v1XLo993EiJcsTIj/5x
         ZlVPH4/Hp4cy9rattgbj2tvaDywbudySwu6pgLuS6aZQ7BPbh1HysKmnl4+FkudMtlWQ
         mc2Kl9Xm/eVMhse1BYV7hDpvFRhyvFbL0TpkrQ74mdxjg3Z+YUt9PGsxlfWvQLfgoCyD
         d6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089155; x=1734693955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lB6IxK8mzcFuvNtXhWuqF+wJOmcio33wWwCQP3bRdo=;
        b=ViBN6S3UTW7aFd7O/UWF7vbK4HWYnUUVC8Tp3VT6Yftr79UD9vIwPVU/i9VqMhk7eg
         Iqx9FFNoAF9lQW3TjNTFOOilJHZQGh1ptUKxDeb2MXQRyODnzAxmVa3uu/5x/HIcBRM+
         nD27Lx/phRC/YG4tlP5EybKqM1IIwF/2Po93v2xLciO0u2apnmiuVqtC9zFNS/YlQW4g
         W6J1K/UjzamM6GTWsEwmzIYQfHgyJTDe1D/g4FzG7kDv24mVo/KCmWdrgsX5q1ror5Wp
         qQPiHb6ZNsYLS34KH675urDTlybmBLUBG6VJREd5PSMe4AcZ9SdiQzx6mmtcJzo5BBPP
         YUMw==
X-Gm-Message-State: AOJu0YxTyhTOwM8Jghm24U5GJtLHNH2B36ujiN6Ty1SRP5u7+N74hgSQ
	0TMdmFsfKyBXSTndjXcDU3XoyZ7lgAAGn/b8srZOQNAfoJW083v3LlV5Ag==
X-Gm-Gg: ASbGncvsw/HrgTna37pmgIp4RLxgNcsCnIw/u8xxmtupA2Eat6aBv5CivciYZbDeZxO
	1F+GxuH5dxO8KG2cUZTQnaKAWmfU+tsrWhzkmgkjtWD8dy5ic+RleeJzd9u2pZm2vKHnqEUNz8A
	6jJK74l2OfEPn0dFNFMnoAQOXDZ1+at5Y2rGN/zadSS7lvvrda8MNnqBTje436uK6QoA0lU0yCh
	u88iSHg8hmG1TYy85vVeAB8n7Dgm4GtNA8cn+/erjbdczBOJ+ohjybAio7ovOo7oTc4lkE/3Zw=
X-Google-Smtp-Source: AGHT+IEjrVAlcovTN6P8Sg4ET945afjp5W9VW3q5pvD01b+6xNmCbzcmPwfl+D0uviJu4IjChMAprA==
X-Received: by 2002:a17:907:7807:b0:aa6:6b7c:8a62 with SMTP id a640c23a62f3a-aab77e9d9b2mr198025266b.38.1734089154952;
        Fri, 13 Dec 2024 03:25:54 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:dda3:d162:f7b1:f903])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm922049766b.128.2024.12.13.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:25:54 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Khang Nguyen <khangng@os.amperecomputing.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] netlink: specs: add phys-binding attr to rt_link spec
Date: Fri, 13 Dec 2024 11:25:50 +0000
Message-ID: <20241213112551.33557-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing phys-binding attr to the mctp-attrs in the rt_link spec.
This fixes commit 580db513b4a9 ("net: mctp: Expose transport binding
identifier via IFLA attribute").

Note that enum mctp_phys_binding is not currently uapi, but perhaps it
should be?

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 9ffa13b77dcf..96465376d6fe 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -2086,6 +2086,9 @@ attribute-sets:
       -
         name: mctp-net
         type: u32
+      -
+        name: phys-binding
+        type: u8
   -
     name: stats-attrs
     name-prefix: ifla-stats-
-- 
2.47.1


