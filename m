Return-Path: <netdev+bounces-144524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2899C7AB7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FE7289072
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA3204024;
	Wed, 13 Nov 2024 18:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062B201249;
	Wed, 13 Nov 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521429; cv=none; b=bH9F3AH2V+GIZGC4VllkbNXWc9tr6oWPzqCW2oEoYm+BGtYTMKD9WF7WO8dlq4z94lROAPijLxP356oJ40IUUQB2Jp6TJm3llCkxbpccQmskjthg65AcyBagn40WzkF/rjVXakSOGBMjXg8Vby4vxBkmaWShdgZFPkmFp9PdpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521429; c=relaxed/simple;
	bh=8YE0gJnG5Jc5NkuY0eYkee5uJq1dLqtk2+WmfvMWT3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZ4dc1fzFKuxGABXTxfEYb0izwCJgBRQJFKs8z/I6mk3aJJF1zwQEp4TqiMhMDZFi9npXYRR4aVr54z5yxZ3JYl+0zG2/6Y6ffFP/ONBZ0BmiP5hgV58u5WtrMhU0ikymu2MXQz8KohjoGWALpJu0AjKkzbL1IaZmSTN1rDM5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2113da91b53so53527995ad.3;
        Wed, 13 Nov 2024 10:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521425; x=1732126225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNLj4GFkTe8uBlnR/w5pmWiy4M7z2ZtobUlmLPyGTzo=;
        b=iNsBH1G/phGjhgdlXPBFjTDvMd0kWUGtBvSK8VhxvUlLs+mQ3CopPS1aBJ/tmj3v/M
         +6yVm1Vom9t+mn6Goel6+SiJl1mYfsmoQoA4RWaUH96Tf0wCMcDxvt/3wTweVEInM55j
         k5QkxKTfH+OsUEg7ynOo1qjX1MOn3rF/7u69WCsKuwhFMCZqYvk2jrR1MXiNw3M9KPBv
         iWF/tY2TKbDkrpwS4WWDd4H8YaRb+57cIQRCV/OOPtL+N3id7iZ2hWOSmjAF+rB6yDOX
         tLlaB0mZ1wkyWS3TC60Ds5/DQ7qmHtTEhdKyi7c3ZmPV0JZT+imUWXoc2VXSQp930uGT
         Na+w==
X-Forwarded-Encrypted: i=1; AJvYcCUxJeJlmWyDM26P5nIyyUHldaK1aM93oosdUTUCzXXDKUMv5REs91wpXoUdZ9fFCHEAjtJM+LVqYinSn8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wpMgtjYJQrMMv+/6vRPNb+vypa84ZtgSGfTgkHgMQK2IBwy1
	3Xp3buqSbboPK11XAtL2+tLYsQAVn3KbCeiryDrAHzr8Zawef3ILfw7H0sg=
X-Google-Smtp-Source: AGHT+IHrf3Tx528upXsJVsI0GEebvUPg6BWINl2Z9XnJQCERqfvQNjsXWu6YcE7Tmm9YTNsj0H9z8w==
X-Received: by 2002:a17:902:e5c5:b0:20c:83e7:ca51 with SMTP id d9443c01a7336-21183d6320cmr287138725ad.26.1731521425198;
        Wed, 13 Nov 2024 10:10:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a73csm112803045ad.246.2024.11.13.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:24 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 0/7] ethtool: generate uapi header from the spec
Date: Wed, 13 Nov 2024 10:10:16 -0800
Message-ID: <20241113181023.2030098-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep expanding ethtool netlink api surface and this leads to
constantly playing catchup on the ynl spec side. There are a couple
of things that prevent us from fully converting to generating
the header from the spec (stats and cable tests), but we can
generate 95% of the header which is still better than maintaining
c header and spec separately. The series adds a couple of missing
features on the ynl-gen-c side and separates the parts
that we can generate into new ethtool_netlink_generated.h.

Stanislav Fomichev (7):
  ynl: support attr-cnt-name attribute in legacy definitions
  ynl: support render attribute in legacy definitions
  ynl: support directional specs in ynl-gen-c.py
  ynl: add missing pieces to ethtool spec to better match uapi header
  ethtool: separate definitions that are gonna be generated
  ethtool: remove the comments that are not gonna be generated
  ethtool: regenerate uapi header from the spec

 Documentation/netlink/genetlink-legacy.yaml   |   8 +
 Documentation/netlink/specs/ethtool.yaml      | 354 ++++++-
 MAINTAINERS                                   |   2 +-
 include/uapi/linux/ethtool_netlink.h          | 893 +-----------------
 .../uapi/linux/ethtool_netlink_generated.h    | 792 ++++++++++++++++
 tools/net/ynl/ynl-gen-c.py                    | 128 ++-
 6 files changed, 1240 insertions(+), 937 deletions(-)
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h

-- 
2.47.0


