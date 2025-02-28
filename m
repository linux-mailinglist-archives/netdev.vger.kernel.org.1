Return-Path: <netdev+bounces-170836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D369A4A345
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 20:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0265B178FE4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A020127CCF6;
	Fri, 28 Feb 2025 19:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EA230BF2;
	Fri, 28 Feb 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772651; cv=none; b=YH8NP9p2QyBZ81CVQQ6vmXhWoPliYJ6q2XzZbqa5mP0A7NdLT0igSSofJdwR1o2vqFm4JfYCh9K5cmEKetY61awm+HJfad3F0aDOkhFG9UpLy+vlflVKYI5ZkNtxNYP7fqTXC0BASdYBlICGNJItRjXFvW9od1lYeQIw5TH3dzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772651; c=relaxed/simple;
	bh=b3V4HtJ0cfwYR66QRbWlu88R6oCl7vJge5HD17H8l3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkB/9B8UYNgr+h32XiFQFP2EsagSrk0VBs36I+VCqvrrJvDuzUat/jwCiThc9kmSK+y5hiSZ2AEotdHFkskvfYBYcJG9/It43+YkJHxLjeRBWnHpoWrosXx00J197a2G94Xo9k8+yQAGIwvtWYxUie8ODYNrjt20/hAMWYPPUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1to5u7-0001Pa-HK; Fri, 28 Feb 2025 19:20:11 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Trager <lee@trager.us>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] eth: fbnic: Cleanup macros and string function
Date: Fri, 28 Feb 2025 11:15:25 -0800
Message-ID: <20250228191935.3953712-1-lee@trager.us>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have received some feedback that the macros we use for reading FW mailbox
attributes are too large in scope and confusing to understanding. Additionally
the string function did not provide errors allowing it to silently succeed.
This patch set fixes theses issues.

Lee Trager (3):
  eth: fbnic: Prepend TSENE FW fields with FBNIC_FW
  eth: fbnic: Update fbnic_tlv_attr_get_string() to work like
    nla_strscpy()
  eth: fbnic: Replace firmware field macros

 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 109 ++++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c |  55 +++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  39 ++-----
 4 files changed, 110 insertions(+), 101 deletions(-)

--
2.43.5

