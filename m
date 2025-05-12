Return-Path: <netdev+bounces-189871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57491AB4438
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4827A8EB4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809982512EF;
	Mon, 12 May 2025 19:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04D14F117;
	Mon, 12 May 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076581; cv=none; b=K48qUsr8zr9YXjBddYQzpSr0ammAn0LKpSKXhYsJlbYLdbp8az1hUcoPvWeS7XcNWlSqsYEkkq+RiBclYilnjysZljZI/3sz17+zizVlYl/60KGNZU5Q1wddBguXwhhj+EnEIuYhLv+qQebccjOc9JSuporFqJMT1uw3GZG1iTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076581; c=relaxed/simple;
	bh=zykAR7McGLJchk9QrJBIJC7FeyUDvFErY6ke/oteXU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWAxRgG2DDNCY4Uneq8SfdO3oWT01WuEGGY7tpJlFSUSfW7RLRCOgw4+C0Z9NqSn9J9fG1C5FqcuezaYitzu14f66nSfxuEyagv9DTa8p4FuG5jYpiN6DZep1pkVJb7S85p527FCWtlymx8Fksx2mjDtz5ww63hY4HEL+ejDz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from [163.114.132.130] (helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uEYQB-000719-V5; Mon, 12 May 2025 19:02:40 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Lee Trager <lee@trager.us>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/5] eth: fbnic: Add devlink dev flash support
Date: Mon, 12 May 2025 11:53:56 -0700
Message-ID: <20250512190109.2475614-1-lee@trager.us>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports updating firmware using signed PLDM images. PLDM images are
written into the flash. Flashing does not interrupt the operation of the
device.

Changes:
V5:
* Make sure fbnic_pldm_match_record() always returns a bool

V4 - https://lore.kernel.org/netdev/20250510002851.3247880-1-lee@trager.us/T/#t
* Tested flashing in a 50x loop
* Add devl_lock() in shutdown / quiescene paths like suspend to prevent
  interrupting the FW flashing process.
* Add support for multiple completion messages.
* Removed BSD function notation from fbnic_fw_xmit_fw_start_upgrade()
* Mailbox functions no longer return cmpl_data->result
* Add missing error check in fbnic_fw_xmit_fw_write
* Drop setting cmpl->u.fw_update.* to 0
* Set offset and length before validation
* Drop !fw check
* Firmware upgrades are now process driven
* Fix potential memory leak when an error is received in the mailbox when
  updating.
* Include anti-rollback support
* Drop retries when updating but increase timeout to 10s
* Use NL_SET_ERR_MSG_FMT_MOD in fbnic_devlink_flash_update()
* Updated cover letter, commit messages, and docs as suggested
* Dropped kdocs
* Patched libpldmfw to not require send_package_data or send_component_table
  which allowed stub functions to be dropped.
* Dropped all dev_*() printks
* Fixed Xmas tree variable declarations

V3 - https://lore.kernel.org/lkml/20241111043058.1251632-1-lee@trager.us/T/
* Fix comments

V2 - https://lore.kernel.org/all/20241022013941.3764567-1-lee@trager.us/
* Fixed reversed Xmas tree variable declarations
* Replaced memcpy with strscpy

Lee Trager (5):
  pldmfw: Don't require send_package_data or send_component_table to be
    defined
  eth: fbnic: Accept minimum anti-rollback version from firmware
  eth: fbnic: Add support for multiple concurrent completion messages
  eth: fbnic: Add mailbox support for PLDM updates
  eth: fbnic: Add devlink dev flash support

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 drivers/net/ethernet/meta/Kconfig             |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +-
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 260 +++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 294 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  53 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +
 lib/pldmfw/pldmfw.c                           |   6 +
 9 files changed, 616 insertions(+), 23 deletions(-)

--
2.47.1

