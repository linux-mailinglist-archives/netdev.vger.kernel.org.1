Return-Path: <netdev+bounces-57093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFF8121DB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D697E1F219E5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386D81834;
	Wed, 13 Dec 2023 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxIZgcVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F21735;
	Wed, 13 Dec 2023 14:42:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3363653e180so1822123f8f.0;
        Wed, 13 Dec 2023 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507317; x=1703112117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGGuSPtvQjmJveVx9q+4NS7dvTSHaVo6X8DWdsSuIuo=;
        b=NxIZgcVbuxZ1jGSlWweTMwDpXdfZOIrlyZcXpi1Orem2bN+nZz1A5LyULtkVrO5U4r
         LMkpygFjRd/YiU9VxsTL8ksTtYHZtwBzQWzR8RZ94TxiRVKmzT/OWJICQIBizJ0IjTm0
         Rsy85oYCnPWvaocT7dJEnRIeMthsb1sD1V2fhnXVgjj4LJrcuXfi5c2tBCbHhh84ZzdK
         TUJJ340gPalHw2BnTGkKpQsDWnaD4gKYVHGgPbRjQUGUhucNbKnLrZunQKm1gJFI6zG8
         TX0htCfFjzCMr6izaLvjF13C9dfPVwLltiamQLKNVLyYcUKTM3DPiM5LiNcDPGkNCcfx
         wHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507317; x=1703112117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGGuSPtvQjmJveVx9q+4NS7dvTSHaVo6X8DWdsSuIuo=;
        b=GNydcbGcszldcuiLGgtKArOv8qU69+ChUYpWD87+KVJehjqNmOULU2v8PAGTBfAJMK
         OQOL1nEL1oeJKXuoqayycEcwlHQfhNicXbighkMuY+blwYQFYp1Fw2IS+DXHM8p/ZDxo
         3cIFGpCG6nm/lJguxBJfXg3huVU4yq9kGKhGOx4ewfmbG0YgafwAhXeaXgfT4IljTgmz
         KggBom4nsuM6YyhF5JKGsS00eg9FJi/Q0l/YBjngt4EvET3oxNZ2qmpgSherWgkZkrTV
         U938+X1msYlPCGwFivOMaXhZFFVt7UAqtX30evZhcwwWraKExMxHjE6jYPJU3caym+jU
         H3eg==
X-Gm-Message-State: AOJu0YzuezRz3xZmoA/eXD9iw0QlnajLlnce2EDh1gpJp6KfZZ84aX2e
	klixSwnjj9yWsDPc1ZHrRzVmr+sDDsgJfA==
X-Google-Smtp-Source: AGHT+IFH3EDPsVtChMY1I5Qt1I1seuhGUZL4LbRrbu9J0MUJuCx4+FvDWhJ9VtrZCuC7w8Cg5BmhlA==
X-Received: by 2002:a5d:610f:0:b0:336:41da:92da with SMTP id v15-20020a5d610f000000b0033641da92damr659927wrt.40.1702507316938;
        Wed, 13 Dec 2023 14:41:56 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:55 -0800 (PST)
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
Subject: [PATCH net-next v4 00/13] tools/net/ynl: Add 'sub-message' support to ynl
Date: Wed, 13 Dec 2023 22:41:33 +0000
Message-ID: <20231213224146.94560-1-donald.hunter@gmail.com>
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

Changes since v3: (reported by Breno Leitao)
 - Remove an unnecessary make dependency from the YNL_INDEX target.

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

 Documentation/Makefile                        |    6 +-
 Documentation/netlink/netlink-raw.yaml        |   65 +-
 Documentation/netlink/specs/rt_link.yaml      |  449 +++-
 Documentation/netlink/specs/tc.yaml           | 2037 +++++++++++++++++
 .../userspace-api/netlink/netlink-raw.rst     |   96 +-
 tools/net/ynl/lib/nlspec.py                   |   55 +
 tools/net/ynl/lib/ynl.py                      |   94 +-
 tools/net/ynl/ynl-gen-rst.py                  |   31 +-
 8 files changed, 2788 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


