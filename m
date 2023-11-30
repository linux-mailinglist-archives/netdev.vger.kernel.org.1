Return-Path: <netdev+bounces-52712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDC7FFDE7
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BE9B20B6F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304B5B1FA;
	Thu, 30 Nov 2023 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBkT3nCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01CC171F;
	Thu, 30 Nov 2023 13:50:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332c0c32d19so1127210f8f.3;
        Thu, 30 Nov 2023 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701381008; x=1701985808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeCXfRlmQUScQLZAUqmI2JqPj6eKJj/ww0TVfVZMmZg=;
        b=UBkT3nCcmQfvJj/89MlSRYsXO8N73gjFPXqzoi67OhpQLHhk6mJjOjGBAiHQidnpKo
         08ST3dneRnES4qmrOSxVb1nuyzMlTI5xoBh6Mv0y5YEAZKxWNiM37a1G+cczkBZXQhke
         1wgkpfHiuQbeQjtdomn5pbMcefhKymJIJqCixNm4UswWKIhzHzawQQev+kkcDftHav4z
         y5WhK3Hajy6YqOqk0VxCjemhsbSUS6X+KF00XEYJuLZUsIyiTd4Zr0/fFP2G71s47KKp
         RaEJVarAJrvKvoer3ADlQhxH8evK1AqpkbLtT7LEKRHeKnQ2VJeUsZuDkiW69dKq88P5
         AkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381008; x=1701985808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeCXfRlmQUScQLZAUqmI2JqPj6eKJj/ww0TVfVZMmZg=;
        b=Smp/2qXVU4axJC2Y4pV6Y5qe9Q2VB5tQEWzUG+2MrlHZ2Pl8BFY0DyK3ZPVrmh1XuP
         LMec5UizL4kYIKdEzijRnd4ZDwBC+oIn4pMnIcM3HW9Kz/0DwIa9+Orscq0+XD29KeF4
         jxLIR2+KY/Q5q3bIAeh2rXzJ06g39Ov3ncp17MgJYpn8oarR01l8KkGdjLXozM2EYjcp
         nqC3hqzCfG3Yyx+0ym5IZdDQ7sZlnda6oKG35lOVOVXsARe9tjnGmA31doKKEJB4JRqG
         Asj5+qqBvdHOMTQT6AM5EsbX8R9JnOqhZSIyV9YECGq8dQps754ywSANorE4WLD8KPt8
         Dk8w==
X-Gm-Message-State: AOJu0Yxg895vM6IAYFX2cF9xi9eaSkve1fBz+DeIXafR1GD6GOBtdz6u
	arzRHYILESfqAlnDqjjEujF+dNH3UmCMFg==
X-Google-Smtp-Source: AGHT+IEQbhue9msYazgvW+Xoc1oRHsZbjyqLpQj8QFBb5bLHZDOWeRZBJu+hNGLCbRDFEpF9DMh6kQ==
X-Received: by 2002:adf:f752:0:b0:332:e337:7c5f with SMTP id z18-20020adff752000000b00332e3377c5fmr166390wrp.61.1701381008196;
        Thu, 30 Nov 2023 13:50:08 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id dd10-20020a0560001e8a00b0032fbe5b1e45sm2519237wrb.61.2023.11.30.13.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:50:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message' support to ynl
Date: Thu, 30 Nov 2023 21:49:52 +0000
Message-ID: <20231130214959.27377-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a 'sub-message' attribute type to the netlink-raw
schema and implements it in ynl. This provides support for kind-specific
options attributes as used in rt_link and tc raw netlink families.

A description of the new 'sub-message' attribute type and the
corresponding sub-message definitions is provided in patch 2.

The patchset includes updates to the rt_link spec and a new tc spec that
make use of the new 'sub-message' attribute type.

Patch 1 adds missing scalar types to the netlink-raw schema
Patch 2 and 3 add sub-message support to the schema and ynl
Patch 4 adds binary and pad support to structs in netlink-raw
Patches 5 and 6 contain specs that use the sub-message attribute type

Donald Hunter (6):
  doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
  doc/netlink: Add sub-message support to netlink-raw
  tools/net/ynl: Add 'sub-message' attribute decoding to ynl
  tools/net/ynl: Add binary and pad support to structs for tc
  doc/netlink/specs: add sub-message type to rt_link family
  doc/netlink/specs: Add a spec for tc

 Documentation/netlink/netlink-raw.yaml   |   56 +-
 Documentation/netlink/specs/rt_link.yaml |  273 ++-
 Documentation/netlink/specs/tc.yaml      | 2008 ++++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py              |   57 +-
 tools/net/ynl/lib/ynl.py                 |   84 +-
 5 files changed, 2452 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


