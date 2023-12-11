Return-Path: <netdev+bounces-55983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB080D240
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EC2816CD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AF1F16B;
	Mon, 11 Dec 2023 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrkrjmgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F98E;
	Mon, 11 Dec 2023 08:40:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so49220745e9.2;
        Mon, 11 Dec 2023 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312854; x=1702917654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkCf0DhZvaO2gkb8ogtkdmwQwzvrHCMJQPh/ypY2+UA=;
        b=HrkrjmghCxeBfUrKoseS/rzYVwJwcTUPAQUMPULZlqDtVC2GFAs2pneVZCRokXwend
         mX4VDlav5WwvsEOHeC3dQJZOIqUd/1UNUwPZ55JSJMAvAVGOrkLZrUnpRx/bcejjw3Ct
         RBaNADp7cXVshTqh30v1MNCpVc0RhdoH2ZYMP4M1VzCf7PzkBzAxsOOPrJgrK3xn0lQh
         k9IaH6rSVQQ8VYdHrp5zZFkkcRlwdc26CIXMX1I8iN6oku28HRLEI9Np/2AyxNXwiMmJ
         Cvp2UUkax6KJd5d/nZIe1wrC9ybSkEMso0dAP4UU2ncOuwP/6hCqa00rO8SIQx+K5Qxg
         8FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312854; x=1702917654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkCf0DhZvaO2gkb8ogtkdmwQwzvrHCMJQPh/ypY2+UA=;
        b=iyIKDXiepDWobK5ql9wu7/krX5o9Rs0dBZByXBGbdZRL4iwTEPSNG90ngYOt8GSESX
         zzm7MD2bp2SWmG0JBtB7M46mGpzHNGB+97P6ov2zmljSL7XZFm+E/t6IKngL8qEh8TXK
         8ZQxXd9xCuAL8FzfY4X/BKIV+uTa8vJwwT7IGrAMtBm0HPUuJVt2DJTRT2dogl40f8LZ
         wYW3UAkXEOMbGojCxgwKPuBRKAIteUAudlz4+5CmaHV6DDH9wjsrRjtqPCJYfxZhlLbc
         mJ2kV/5Ntrpo6iisByqhuaDUleNuhr6E4gWkbEZIJ66r/fhEjl36lEkzdKzj+UeUzBfZ
         v7hQ==
X-Gm-Message-State: AOJu0YwIj331kETePO30UazmxkRcaZck53O/PElp70DdYXiKH5z2pIos
	Pdw8dmnVhuWr94W3D3sU7m/ems4Nb4MCag==
X-Google-Smtp-Source: AGHT+IH5VkYMmuyZECS86G/xP1g4J8VVdveSnbzr2Q8HGc12HRJSDfIjBcpfk6dF/fvjcxLr6K2Ynw==
X-Received: by 2002:a05:600c:4f87:b0:40c:3e9f:c777 with SMTP id n7-20020a05600c4f8700b0040c3e9fc777mr2230516wmq.62.1702312853513;
        Mon, 11 Dec 2023 08:40:53 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:40:52 -0800 (PST)
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
Subject: [PATCH net-next v2 00/11] tools/net/ynl: Add 'sub-message' support to ynl
Date: Mon, 11 Dec 2023 16:40:28 +0000
Message-ID: <20231211164039.83034-1-donald.hunter@gmail.com>
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
corresponding sub-message definitions is provided in patch 5.

The patchset includes updates to the rt_link spec and a new tc spec that
make use of the new 'sub-message' attribute type.

As mentioned in patch 7, encode support is not yet implemented in ynl
and support for sub-message selectors at a different nest level from the
key attribute is not yet supported. I plan to work on these in folloup
patches.

Patches 1-4 are cleanups and fixes in ynl
Patches 5-7 add sub-message support to the schema and ynl with
documentation updates.
Patch 8 adds binary and pad support to structs in netlink-raw.
Patches 9-10 contain specs that use the sub-message attribute type.
Patch 11 updates ynl-gen-rst to include sub-messages

Changes since v1: (all reported by Jakub Kicinski, thanks!)
 - Added cleanups for ynl and generated netlink docs
 - Describe sub-messages in netlink docs
 - Cleaned up unintended indent changes
 - Cleaned up rt-link sub-message definitions
 - Cleaned up array index expressions to follow python style
 - Added sub-messages to generated netlink spec docs

Donald Hunter (11):
  tools/net/ynl-gen-rst: Use bullet lists for attribute-set entries
  tools/net/ynl-gen-rst: Sort the index of generated netlink specs
  doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
  tools/net/ynl: Use consistent array index expression formatting
  doc/netlink: Add sub-message support to netlink-raw
  doc/netlink: Document the sub-message format for netlink-raw
  tools/net/ynl: Add 'sub-message' attribute decoding to ynl
  tools/net/ynl: Add binary and pad support to structs for tc
  doc/netlink/specs: add sub-message type to rt_link family
  doc/netlink/specs: Add a spec for tc
  tools/net/ynl-gen-rst: Add sub-messages to generated docs

 Documentation/Makefile                        |    7 +-
 Documentation/netlink/netlink-raw.yaml        |   53 +-
 Documentation/netlink/specs/rt_link.yaml      |  436 +++-
 Documentation/netlink/specs/tc.yaml           | 2036 +++++++++++++++++
 .../userspace-api/netlink/netlink-raw.rst     |   75 +-
 tools/net/ynl/lib/nlspec.py                   |   55 +
 tools/net/ynl/lib/ynl.py                      |   94 +-
 tools/net/ynl/ynl-gen-rst.py                  |   27 +-
 8 files changed, 2748 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


