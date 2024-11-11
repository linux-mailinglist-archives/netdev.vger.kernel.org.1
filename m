Return-Path: <netdev+bounces-143649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53E9C37AB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C6B2829B2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084514B08E;
	Mon, 11 Nov 2024 04:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4836B;
	Mon, 11 Nov 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731301050; cv=none; b=CzICVlfHF8bbwFk2dwSjZslIrFZr5tHoZipNKw+B0HnXB+bUa9x6VS2q5C7wWP142JKd9yO2RyS2CW1WdZkkh+gOgnyjJLjiQiFOxpuogdSHaXyMHpUY6FyAoxEiKYg1DCt2c9iwG4EpOLK4ecdejQ3CQw9IPx8Iov8bTjIokqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731301050; c=relaxed/simple;
	bh=tirkX2MXkpsNllxEwZssgmKIa3WBGc3jCTm1t2AzfnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsqUqdAtTSlCjvGqfuy4a6GEDY/9K4T80ImtkDfd5SuEd4kI4gY3ATMQl6wxDTKnLQ6rAgIxElq3X+5eYUdxtoPhTaS0dPe23BAdrrHcIMyyBxwzqDmuqL4g5iN1JIG9EPUJMbxwUS6iTNWVP/6SvdEAnfj6TOAb5F5KY7R3nHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1tAM5J-0003KI-CM; Mon, 11 Nov 2024 04:31:29 +0000
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
	Lee Trager <lee@trager.us>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] eth: fbnic: Add devlink dev flash support
Date: Sun, 10 Nov 2024 20:28:40 -0800
Message-ID: <20241111043058.1251632-1-lee@trager.us>
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

Changes:

V3:
* Fix comments

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

