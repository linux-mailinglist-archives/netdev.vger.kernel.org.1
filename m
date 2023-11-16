Return-Path: <netdev+bounces-48377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130647EE319
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428851C208C4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF81C28DA9;
	Thu, 16 Nov 2023 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYAGySi+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A146C4
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700145686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0n2sOTqh54K6KjJovop+KA+rmVAdCcqfFg/Rllk/gGo=;
	b=AYAGySi+wL0foSh3QHeZusCZ+oEduVE6MsLQ4KV0c9lY7GeTxBoGn5acr0xzqi9ySdXq4y
	5EWjamUlH6/zp4aEuGWFCxBxzvVf2afVhHKCjTyw0q+2CsMZYo7DFIU/UjJ20QkqNb2jUO
	J4pPuwTdSoWK4s6KSsBzzen+LLZ+Iz4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-ahEH4LZvP-aUNoHtbYXUAQ-1; Thu,
 16 Nov 2023 09:41:23 -0500
X-MC-Unique: ahEH4LZvP-aUNoHtbYXUAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CC442800B42;
	Thu, 16 Nov 2023 14:41:22 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 956761121306;
	Thu, 16 Nov 2023 14:41:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/5] i40e: Simplify VSI and VEB handling
Date: Thu, 16 Nov 2023 15:41:14 +0100
Message-ID: <20231116144119.78769-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The series simplifies handling of VSIs and VEBs by introducing for-each
iterating macros, 'find' helper functions. Also removes the VEB
recursion because the VEBs cannot have sub-VEBs according datasheet and
fixes the support for floating VEBs.

The series content:
Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
Patch 4 - Fixes broken support for floating VEBs
Patch 5 - Removes VEB recursion and simplifies VEB handling

Changelog:
v1->v2 - small correction in patch 4 description
       - changed helper names in patch 3

Ivan Vecera (5):
  i40e: Use existing helper to find flow director VSI
  i40e: Introduce and use macros for iterating VSIs and VEBs
  i40e: Add helpers to find VSI and VEB by SEID and use them
  i40e: Fix broken support for floating VEBs
  i40e: Remove VEB recursion

 drivers/net/ethernet/intel/i40e/i40e.h        |  91 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
 4 files changed, 371 insertions(+), 390 deletions(-)

-- 
2.41.0


