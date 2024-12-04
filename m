Return-Path: <netdev+bounces-149053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C349E3EC1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE68328302D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045820C477;
	Wed,  4 Dec 2024 15:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3114A28;
	Wed,  4 Dec 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327753; cv=none; b=fsxy5YzhyT3D7zyAK5l1m4Ox/IVFF27jGAej/jdcACBjNIhcZh+uH6Ecrrws5If2BlGZ9TrOsXpGhVZwSJWCEjie1ZPvFFV36zVL4DvNi4A65XDbNjlELTF0GuK0u47o0iuwRaR7M5ktXZnLvvxYkvEp5tx8UrCsrKCCBLDXIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327753; c=relaxed/simple;
	bh=Pihd9l2xmmGC5HSoedNxdaKSkb+sm9Yy2vTemEDtCKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTf8c9+jbdNVCMs/Jap47cngdj8Trb+t5E/xVS6N1X6VvYMEmyQ5IaxFRm6QVQVaOly+zdi3oplnDrjKK/x03TpdM5XRCcAm7dNvoQA95C1YiImi9eGr542VL/7lqzwjThByS4L04r7RBd/Z7EI8gcmrpxvVj01Jdn83GqJ8FYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7258cf297d4so952544b3a.2;
        Wed, 04 Dec 2024 07:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327751; x=1733932551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiWuXy+pQoS8Q9oXJwZIdB/h1k4RcMOYZcel02t32lQ=;
        b=QbNA83pzwxqSgsfMMrJOJVlzvs3lnT/KdnpwuwriJ+rlshovY8ASkv7JG+x7cjxfQn
         lI0IKQO0UXW3yV5Yp1m4Gd/VjnSCtu+NtvGUcDm+AWIWPYYEAhw6ZT7nr1itbONLWL+G
         x7T5jTPDT3l51pgj6Ylcyvg2SA013Jz/NGcM/6tn3T7ZKImtY0UHnpfUF/wzOeR6Be6S
         sA0+Ls1DPDncfi6hnMWS7gBcuC3Aukxz8gh/Y8J05VQx5KCbIHGx1e+XPPAdRldiA2Tv
         kaszFyzQ/mZZ1ZOCAjSMY5UvGYT9sHwdeVUqV0aGZDMnKgfGX81UBjLRnPamS/3gPiVT
         TdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXa+hch3O77wVGNOEsfCwDD0VUyfB4YRkdltmjfrLuqNaJilO2oGLBVi1mi+d8rOPyL/oDkt+vmr/PUiE/@vger.kernel.org, AJvYcCVfOkiwIjxpDrTP1zhA+3fPIAfDPGocpGUC3tDMsjr9GDPjYu9nqXHmYGiL9YoNc/Bzv4jgdbE0OB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPGLFcscD90j1ioIc7keyPQH1eZlzxaeil9W8CGkd0/XfK2Em
	q9RhDMvZtIB7fuWpo9j8ojFNMTeJZ80X7Qo46p0wsAcF88pGZ63ZuSLEYR4=
X-Gm-Gg: ASbGncvSUE3IReC2bJjI9TLGVUZOyfzsxd6HtpQUsFmPrRGquXyzH3lms+2SqRxBKIQ
	eBOz7ZzzZY+CkrV7RTZ1NCCkOkdWoZRyQvkmodoWpfTBd2+wqt7g5bA407/wB2x3gAIwjB3sDQ4
	mTdu6RJIZr7FaTzEQAMkAboC5i5X9lAw+ceylj6NIzlOXUbINb0+U+TBmn1WVm+sJYTEyT/WpN/
	P/8lOoQKsD48dswhdzhegyGwWnNTjNLhRmFm3RrL9PMGtd5PQ==
X-Google-Smtp-Source: AGHT+IG98ABpTsxIbNqbbMCiEgT/Y60S5rAkzU/yZ2vvkNA0PS5xq7vZFporousGafp6pkCMuGO7IQ==
X-Received: by 2002:a17:902:f649:b0:20c:6b11:deef with SMTP id d9443c01a7336-215bd24fb57mr88476745ad.48.1733327750591;
        Wed, 04 Dec 2024 07:55:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530d2073esm106407045ad.73.2024.12.04.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:50 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v4 0/8] ethtool: generate uapi header from the spec
Date: Wed,  4 Dec 2024 07:55:41 -0800
Message-ID: <20241204155549.641348-1-sdf@fomichev.me>
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

v4:
- add 'none' doc to 'none' entry (Jakub)
- remove trailing _ from ETHTOOL_A_CABLE_XXX doc entries (Jakub)

v3:
- s/Unsupported enum-model/Unsupported message enum-model/ (Jakub)
- add placeholder doc for header-flags (Jakub)

v2:
- attr-cnt-name -> enum-cnt-name (Jakub)
- add enum-cnt-name documentation (Jakub)
- __ETHTOOL_XXX_CNT -> __ethtool-xxx-cnt + c_upper (Jakub)
- keep and refine enum model check (Jakub)
- use 'header' presence as a signal to omit rendering instead of new
  'render' property (Jakub)
- new patch to reverse the order of header dependencies in xxx-user.h

Stanislav Fomichev (8):
  ynl: support enum-cnt-name attribute in legacy definitions
  ynl: skip rendering attributes with header property in uapi mode
  ynl: support directional specs in ynl-gen-c.py
  ynl: add missing pieces to ethtool spec to better match uapi header
  ynl: include uapi header after all dependencies
  ethtool: separate definitions that are gonna be generated
  ethtool: remove the comments that are not gonna be generated
  ethtool: regenerate uapi header from the spec

 Documentation/netlink/genetlink-c.yaml        |   3 +
 Documentation/netlink/genetlink-legacy.yaml   |   3 +
 Documentation/netlink/specs/ethtool.yaml      | 358 ++++++-
 .../userspace-api/netlink/c-code-gen.rst      |   4 +-
 MAINTAINERS                                   |   2 +-
 include/uapi/linux/ethtool_netlink.h          | 893 +-----------------
 .../uapi/linux/ethtool_netlink_generated.h    | 792 ++++++++++++++++
 tools/net/ynl/ynl-gen-c.py                    | 139 ++-
 8 files changed, 1253 insertions(+), 941 deletions(-)
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h

-- 
2.47.0


