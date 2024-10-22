Return-Path: <netdev+bounces-137694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198249A958A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EE21C220AE
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2B126BF2;
	Tue, 22 Oct 2024 01:40:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC325760;
	Tue, 22 Oct 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561240; cv=none; b=Md1DWJnh+ZgnKzLl+RTMzQmwwKm1zVyMNdbZW26dR6VkC3B7+j2LFqWD5++syJhFmMVDQHP1fj09k+xpBaperVIcfCr9Prfum1p8n9EV2eajZvsL4mALQedAzcQlDuaexzX1UDWZQD8CEah2Hpld7vFJ6TQATpZgu/IJoksW7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561240; c=relaxed/simple;
	bh=+bhStFYIUdfzusPYQvCHt45ldFDcMjOh0KIk1ivnG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWeooabV/sOZVe4bXTOs+yqE8O6wa3Wuc1p5g+K1o5IyK9L8retsTIqc3f7tYErNg6aQsPuEv58FBZZobeP6AOujmYmNiLhoONqxAGr5aWesrscRoOQt3K9biP+GljZ5i/B0oBsgefngSWAcgwrWDOOFdToNVx5zp8qEJ+J+MR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from [163.114.132.6] (helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t33sj-0003xr-3v; Tue, 22 Oct 2024 01:40:21 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lee Trager <lee@trager.us>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] eth: fbnic: Add devlink dev flash support
Date: Mon, 21 Oct 2024 18:37:45 -0700
Message-ID: <20241022013941.3764567-1-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241012023646.3124717-1-lee@trager.us>
References: <20241012023646.3124717-1-lee@trager.us>
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

Changes:

V2:
* Fixed reversed Xmas tree variable declarations
* Replaced memcpy with strscpy

Lee Trager (2):
  eth: fbnic: Add mailbox support for PLDM updates
  eth: fbnic: Add devlink dev flash support

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 drivers/net/ethernet/meta/Kconfig             |   1 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 269 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 263 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  64 ++++-
 5 files changed, 603 insertions(+), 5 deletions(-)

--
2.43.5

