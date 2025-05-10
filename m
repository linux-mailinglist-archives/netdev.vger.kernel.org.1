Return-Path: <netdev+bounces-189427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC4AB20C6
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A65505B15
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E691898F8;
	Sat, 10 May 2025 01:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CBB67F;
	Sat, 10 May 2025 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746840757; cv=none; b=ji+zfpvNeKR2yck/eUFBsRgKeYxD9YsWf6bZYeuW0hidDBC2MB1cf852Ru8/N4Jn7NHSMBtFI72qvxPy015Px7p78IzEQPlLUDqn4w9iFbDg2g4M1JOYsCrVZMUvKY/1G5xhKEYqJgNVB3NtnPzS1HbJ+7gHgKP+mp6T77NO2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746840757; c=relaxed/simple;
	bh=xgEoxdF8WtQ4LXl7GXwgSisMk5T5Altc6CL481mKxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkWp0rfPi1LVgfwW+i9eB2QPVFRQdIpcuGX/zqxLeeGU4Jzq9zvf/od7Z1hGOyhJ7/Ia7olQVpDmOgCj6axIHsDq93ppSq2iogU+cCjHjMvkjpEEws1VnqIxQjvIgISFY4d1cw1SyyZv1zUM7Ts4dllCNd3n+ALP34Oy4a/uZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uDY9X-0002Do-TG; Sat, 10 May 2025 00:33:20 +0000
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
	Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/5] eth: fbnic: Add devlink dev flash support
Date: Fri,  9 May 2025 17:21:12 -0700
Message-ID: <20250510002851.3247880-1-lee@trager.us>
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

V4:
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

