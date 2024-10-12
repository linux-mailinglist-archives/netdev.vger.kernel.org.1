Return-Path: <netdev+bounces-134760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1999B061
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 05:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE841F234AE
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333A84A22;
	Sat, 12 Oct 2024 03:14:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0B17BA5;
	Sat, 12 Oct 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702881; cv=none; b=ObVJJSqqzmLc8cUcow5fejPa9jeVMi382+TfXVnoijVqmyvyxz171YLOpsJZSLjkvpWn4CN1RQgGjSnwOnVfEPQ8ithv7gvvnxzihGHbP5dRIrWtaYduvMPaADXInI8glozOUrgcDRtcTPLQbQglR58pFvnA7bkk3z4wi8sEVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702881; c=relaxed/simple;
	bh=DxG3jFhJxBZHy9y4ut7XkUjBm+Q/CU+DcDmSa6Et+bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7C+JLbrY+cfywBHyMb46VqwBQxStyRA3/9r+18s2gjCD1YCeDlCdEPnIvOdn2B+Z+f/oezeUlbsT8jE1vxn7J5IT91zReD4I08NnIBmGDf/Q5qMUhQ9DE2bAH2uG2/uP+IVZQT8jkykwGyN/7kVJcz8zaN0s9HlzGyKF7mBcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1szS0P-0005hE-FC; Sat, 12 Oct 2024 02:37:21 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] eth: fbnic: Add devlink dev flash support
Date: Fri, 11 Oct 2024 19:34:02 -0700
Message-ID: <20241012023646.3124717-1-lee@trager.us>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports updating firmware using a PLDM image signed and distributed
by Meta. PLDM images are written into stored flash. Flashing does not
interrupt operation.

Mailbox support additional adds support to utilize the kernel completion
API with firmware. This allows the driver to block on firmware response.
Initial support is only for firmware updates, future patches will add
support for additional features.

Lee Trager (2):
  eth: fbnic: Add mailbox support for PLDM updates
  eth: fbnic: Add devlink dev flash support

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 drivers/net/ethernet/meta/Kconfig             |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 270 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 263 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  59 ++++
 6 files changed, 604 insertions(+), 1 deletion(-)

--
2.43.5

