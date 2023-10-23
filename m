Return-Path: <netdev+bounces-43531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68AB7D3C89
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9007E28143C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331321DA21;
	Mon, 23 Oct 2023 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReVHidJQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE61D54D
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:30:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2E10E5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698078601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vUKxPOoWV9B5U7uvi2XDDGj+trRuDSgbS765fvrE7hM=;
	b=ReVHidJQ4RSWi8H6KbSguwyV9zSE7Yptm+u9chTFdZdgB7YCXlH3sNRxRcnjraP6CLvKhq
	njUYmCFpkAD7FLafP1i+XYdC/Ldo9DApF3bCzZyd6rRrHgWbmQSk7caY4ru5fUrDikpv9+
	z8MX9mVZAh5n+IJ5mTzm/N/vJCOX7aQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-tZq6VPX4Mye2f5hKABNMOQ-1; Mon,
 23 Oct 2023 12:29:47 -0400
X-MC-Unique: tZq6VPX4Mye2f5hKABNMOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443E93827967;
	Mon, 23 Oct 2023 16:29:31 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 528C325C0;
	Mon, 23 Oct 2023 16:29:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	mschmidt@redhat.com,
	dacampbe@redhat.com,
	poros@redhat.com
Subject: [PATCH iwl-next 0/3] i40e: Add and use version check helpers
Date: Mon, 23 Oct 2023 18:29:25 +0200
Message-ID: <20231023162928.245583-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

The series moves an existing check for AQ API version to header file,
adds another ones for firmware version check and use them to refactor
existing open-coded version checks.

Series content:
Patch 1: Moves i40e_is_aq_api_ver_ge() helper to header file
Patch 2: Adds another helpers to check running FW version
Patch 3: Re-factors existing open-coded checks to use the new helpers

Ivan Vecera (3):
  i40e: Move i40e_is_aq_api_ver_ge helper
  i40e: Add other helpers to check version of running firmware and AQ API
  i40e: Use helpers to check running FW and AQ API versions

 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 69 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_common.c | 48 +++++--------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ++++++++++++++++++
 5 files changed, 115 insertions(+), 83 deletions(-)

-- 
2.41.0


