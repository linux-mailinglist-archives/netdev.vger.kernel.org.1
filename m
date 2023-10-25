Return-Path: <netdev+bounces-44137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EF7D689C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A00B281C76
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B3200D5;
	Wed, 25 Oct 2023 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecIQHqv4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066E26E10
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:33:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F2130
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698230013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sLw+xTXfry5r3/ti5ulvPxarMfCsTLFS8WTKCXQP2us=;
	b=ecIQHqv4i77MxN8nHsATOSNvgOhq10Vsi1/xTqwmmzJvHV6gOdNHam9O/M3kNt0FJ6MUQf
	zQaM/E0oqIr5+YqsV5FcisJyfGRQk0SqYi92fRTq0BRA5uNA4seL9wiBm9PZSaGyuJZ1Of
	xuNycKUtPzwbV8hJQcBWx+W6yXc/xNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-M_ahc-PIPiGpIOmS0EWofg-1; Wed, 25 Oct 2023 06:33:17 -0400
X-MC-Unique: M_ahc-PIPiGpIOmS0EWofg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF36891F28;
	Wed, 25 Oct 2023 10:33:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1F971121320;
	Wed, 25 Oct 2023 10:33:15 +0000 (UTC)
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
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 0/2] Remove VF MAC types and move helpers from i40e_type.h
Date: Wed, 25 Oct 2023 12:33:13 +0200
Message-ID: <20231025103315.1149589-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The series removes MAC types for VF functions and moves inline helper
functions from i40e_type.h to i40e_prototype.h

Ivan Vecera (2):
  i40e: Remove VF MAC types
  i40e: Move inline helpers to i40e_prototype.h

 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 +++-----
 .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 76 -------------------
 3 files changed, 80 insertions(+), 99 deletions(-)

-- 
2.41.0


