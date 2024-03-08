Return-Path: <netdev+bounces-78637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C11875F31
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2BC282647
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB650A64;
	Fri,  8 Mar 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbBZ1p47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11598D29E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885588; cv=none; b=A13bZqVO5+9EyslJ+0cQQNGOqyH2S+IyM4S42eTnGn3GQotpCyhUiu07k1e5LiGW1uR9xN65xsdcHdeX9DI98P8yhXXPfY9FTK7cpjFQW2+yz2TeSf6YZpL7TdaddY1k2pcbd6RyG1Bwc/VjkhShTngSG9WT8GpdxtgsICWOU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885588; c=relaxed/simple;
	bh=IRsSUUMYtqpUTFfMIKBN7pi4AnZoM4FnlAPk5FSQCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYd+5Fod0v5uMpNBe8n9X/BYiVNmnA8Ja4iiooq2KgQQ8/sjenCBmE8aA32f0N1Dj1AaKMHyPdExpFgFH4D/7ZiSnABtXCfP486brdFt6hTehnX8MsoZsysa4HPiSr6aitZC/BEJ8qH/zPww+Ay4ftaTfWwUKOmevSGjunCwdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbBZ1p47; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0e5b223eso4001445ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709885586; x=1710490386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADuoz+NHSLnx3Z/LvVNYADt8qJhfL8IK9fVTemGS3v0=;
        b=DbBZ1p47FttdPgGdlT9ZJv55lt7OctXh91DenLfyW1jPVDyGudow4nqb9DK1x1WC0W
         6DYy71RePnvhkRNiV89/062en4AefebJajOWyQYmKnoPT0dOFCcICCtRlS2uxWeKbOGV
         4aRsiPxre4G34X8Ouj4qFucc0q/MWpD5crhDaY0DAHuIUR2KMvDrTsDlvq/uH9cejRO4
         Qp5wdkh9nvTmnBTqNwiYloimD/3/6lgX+HQYYe5LjzXSMSfnGvR4mfqYqa4/STlbGnHH
         xA/vWkFNiByojgj+oXuedNjDm9RU8U6/cDTFcFpNqLtWBS8sM76ah3L1gKdgXrWJO4uS
         d5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885586; x=1710490386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADuoz+NHSLnx3Z/LvVNYADt8qJhfL8IK9fVTemGS3v0=;
        b=EjMb3BzHrvpvzHUkJBzJWw8xPQYHSRfk4OCt425EQzWeALIiyw7O9puvUkhFEKNxHk
         55Xp+zrMFM0tKKzTZhz7wL048psk5Qq0YtAUIEBGhBUmQPUewGWPnIgFGUQ9k6EAPdzf
         zXIy3+9tjBbeH9rUNTcCu+QTjc0fMONZV1qzS47u0RS2Nb687NoriyegUjOa/E7/emdT
         ixoRLqYpOJez5ZZyM6V1j/qa8GwgwfaBT4IavL7OTbHyOqgEBlZLL6FnWR/45/JH1UuL
         1Amvk2Ppa8Ua4o7JhWhd5C+NUShhs5BNR8tmlhyC3AkdvsTCOZC8Akg+cC/siLs6odzY
         zW/g==
X-Gm-Message-State: AOJu0YwL3cBNcU3Kb5xGPgWLZrXQiw+PWiPC1JXf5sfRcD7LnHyUca+v
	VLwAYwxfyihk1BvlTNAGx+UyYbty/mhVXkf4Ro+qiM1kIBk+LSt/+7aD3QNjkupVtg==
X-Google-Smtp-Source: AGHT+IGEBjaHjbiKaBToiZTMXKEhOM5clHu325qOwLZtNjnb9KT3AdrEFAD4Q47FDa+JcJNv2JLIkg==
X-Received: by 2002:a17:902:650c:b0:1d9:4ede:66b5 with SMTP id b12-20020a170902650c00b001d94ede66b5mr9098636plk.15.1709885585916;
        Fri, 08 Mar 2024 00:13:05 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b001dc9893b03bsm15698271plh.272.2024.03.08.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:13:05 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] netlink: specs: support unterminated-ok
Date: Fri,  8 Mar 2024 16:12:39 +0800
Message-ID: <20240308081239.3281710-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ynl-gen-c.py supports check unterminated-ok, but the yaml schemas don't
have this key. Add this to the yaml files.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: update subject, expand the doc and leave the change out of
    genetlink spec. (Jakub Kicinski)
---
 Documentation/netlink/genetlink-c.yaml      | 5 +++++
 Documentation/netlink/genetlink-legacy.yaml | 5 +++++
 Documentation/netlink/netlink-raw.yaml      | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..3b5e910f3606 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -208,6 +208,11 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: |
+                      For string attributes, do not check whether attribute
+                      contains the terminating null character.
+                    type: boolean
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..0f48c14a33d2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -251,6 +251,11 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: |
+                      For string attributes, do not check whether attribute
+                      contains the terminating null character.
+                    type: boolean
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..aa37af9f8a8c 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -270,6 +270,11 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: |
+                      For string attributes, do not check whether attribute
+                      contains the terminating null character.
+                    type: boolean
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
-- 
2.43.0


