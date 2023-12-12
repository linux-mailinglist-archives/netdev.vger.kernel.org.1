Return-Path: <netdev+bounces-56616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005B80F9FF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1681C20A60
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EA63575;
	Tue, 12 Dec 2023 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK6nB9tv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23721D3;
	Tue, 12 Dec 2023 14:16:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so35203375e9.1;
        Tue, 12 Dec 2023 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419384; x=1703024184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jwb5Ba5qERmLre1QT18SnMWZ03g/ub2BxGPMWa4ABU=;
        b=ZK6nB9tv9a1qpD4lwdCdR0GyDtrAGLLZF35FWi6vJMC+4ZieuvJ/9MwDxlmcNhZm8W
         QQIQbTkjQQx8MamnCZgbFUGgeIWw0fgXWA4glutA2RVySs2PbSjVIS4BlBgs5T6Gybia
         xZCR3O3HoH03X1qpiT7xdOzcnyo/OVLAnTjuLbl/Pm2HzWgudxRgNRpriIy8Il3x7EJ5
         9WYM4nNIxwHiwqNjpG2b0P1JvUVFJh3CKSQR7vOSiimd3vz8iIZweUmCaeD9Mb5yLgNa
         kGiOar/Pd1u1qkLyLDm2NeMpE9skr/N6+0957BCyiy5yyT3tnKY+Z+8kkVCRg+e3QO2V
         JXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419384; x=1703024184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jwb5Ba5qERmLre1QT18SnMWZ03g/ub2BxGPMWa4ABU=;
        b=SS/T5bjYR7aZXVRgP5tNFsqy8XKpU+c+U3oJwgVhLvcTAwQOuBo7Vm48iLXtyGLggm
         5X9eITBgcKwKQz7y8MfD5gbRk3IhT8BPjwuET6ZyKS+To4Q/R9k+qnK3Hns22BY+UqcU
         /s/1vJYhfiwepJm4x7F87Pt1H5gTL2G6pwuueB/WOvYlZaKHp5jfmrIPi+/oW3eqI3YF
         hahWYYMF1n8hR9eSVE0L2Ujr04S8mVBUBR/wcEBf5UEVJW4GLbAf4tTL/cT/dFvvIQZg
         qKSswk8YF8WIvmU1UF7DB4pSIb7hCmjmvyGp//CL5sSTQr/DUmcMj1ApvPNTXgDjHb5f
         KJrA==
X-Gm-Message-State: AOJu0YwEG23/r5VztMH9fQGqIhx+MGrtTOi6tZAVW/ofPe3FqGKhqusM
	X769QXpEd0lWHySCgUf1jrpjxTC03EtfZA==
X-Google-Smtp-Source: AGHT+IFZ6CmvLjMGzbIKpueWU/S6VccC4x+tVwV0E4RPKHxBdVLSelkdIuRPFp45O3cumQg2oGyHiA==
X-Received: by 2002:a05:600c:4709:b0:40b:5e4a:2368 with SMTP id v9-20020a05600c470900b0040b5e4a2368mr3637354wmo.106.1702419383583;
        Tue, 12 Dec 2023 14:16:23 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:22 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 00/13] tools/net/ynl: Add 'sub-message' support to ynl
Date: Tue, 12 Dec 2023 22:15:39 +0000
Message-ID: <20231212221552.3622-1-donald.hunter@gmail.com>
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
corresponding sub-message definitions is provided in patch 3.

The patchset includes updates to the rt_link spec and a new tc spec that
make use of the new 'sub-message' attribute type.

As mentioned in patch 4, encode support is not yet implemented in ynl
and support for sub-message selectors at a different nest level from the
key attribute is not yet supported. I plan to work on these in folloup
patches.

Patches 1 is code cleanup in ynl
Patches 2-4 add sub-message support to the schema and ynl with
documentation updates.
Patch 5 adds binary and pad support to structs in netlink-raw.
Patches 6-8 contain specs that use the sub-message attribute type.
Patches 9-13 update ynl-gen-rst and its make target

Changes since v2: (reported by Jakub Kicinski and Breno Leitao)
 - Fixed ynl-gen-c breakage
 - Added schema constraint for pad/binary & len
 - Improved description text in raw schema
 - Used | for all multi-line text in schema
 - Updated docs with explanation of what a sub-message is
 - Reverted change in ynl-gen-rst
 - Added ynl-gen-rst patches and grouped them all at end of patchset

Changes since v1: (reported by Jakub Kicinski, thanks!)
 - Added cleanups for ynl and generated netlink docs
 - Describe sub-messages in netlink docs
 - Cleaned up unintended indent changes
 - Cleaned up rt-link sub-message definitions
 - Cleaned up array index expressions to follow python style
 - Added sub-messages to generated netlink spec docs

Donald Hunter (13):
  tools/net/ynl: Use consistent array index expression formatting
  doc/netlink: Add sub-message support to netlink-raw
  doc/netlink: Document the sub-message format for netlink-raw
  tools/net/ynl: Add 'sub-message' attribute decoding to ynl
  tools/net/ynl: Add binary and pad support to structs for tc
  doc/netlink/specs: Add sub-message type to rt_link family
  doc/netlink/specs: use pad in structs in rt_link
  doc/netlink/specs: Add a spec for tc
  doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
  tools/net/ynl-gen-rst: Add sub-messages to generated docs
  tools/net/ynl-gen-rst: Sort the index of generated netlink specs
  tools/net/ynl-gen-rst: Remove bold from attribute-set headings
  tools/net/ynl-gen-rst: Remove extra indentation from generated docs

 Documentation/Makefile                        |    8 +-
 Documentation/netlink/netlink-raw.yaml        |   65 +-
 Documentation/netlink/specs/rt_link.yaml      |  449 +++-
 Documentation/netlink/specs/tc.yaml           | 2037 +++++++++++++++++
 .../userspace-api/netlink/netlink-raw.rst     |   96 +-
 tools/net/ynl/lib/nlspec.py                   |   55 +
 tools/net/ynl/lib/ynl.py                      |   94 +-
 tools/net/ynl/ynl-gen-rst.py                  |   31 +-
 8 files changed, 2789 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


