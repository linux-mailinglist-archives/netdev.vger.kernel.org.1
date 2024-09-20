Return-Path: <netdev+bounces-129123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014B97D9B2
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BE81F232D9
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244B183CC6;
	Fri, 20 Sep 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij9pAvjD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC667183CAB
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858795; cv=none; b=KGuJLguC7C/HQyQADPfT9LeMvNRukE6ISO0v6Z5DwowYZ6Q36ejAaammnPzavNDLov3y79rqKMqwvXJHP8dWmXlvvbhYIPMFuAybEziCzHRRv65hI76WpaBKd0VQ15F7bzofwSj7EhY9JdVvu2/RuNobLCKcp6GRUDMREEr6hNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858795; c=relaxed/simple;
	bh=ByrMZRzOulTIHcI+0B+WH2LAeOpai9qx0SfCbfqF2xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uP6LxUyjRPJUQccz3X1Ng6GEZmUwjC9rO7u/8SZjkiUWBvWMXGI/NdWNgJleDmuqVEto2gT1D754+MqccAeE1jBtq2yJuKzEyyiEEePWUGBgMl5NbDXKYTmTnTTS5vxF9ZhkZ6SYMBm88hEwM9coa73obdRHLSBCp7mIlTmhW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij9pAvjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726858792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ao/DYvra/X7+HKiIGMpHSnD9nuI6QNLpI7/E5DQ3GQc=;
	b=Ij9pAvjDesGr9wqgldJht5d7cPGYh5oTAM6Kmbq36wkbGXLMvT57+pk+mgqWU9N+3saoY/
	sRDskEKb3zyG4haRz0PEqJw6gtNOu33AnmyhVCsiWJZCimAdhYBcxDg1uuQla5odcRL4RP
	W+YyWUcVGXYLaPJ969oe9i197R2rhyw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-tazn4dD-Nyyiw5N8Uomz6A-1; Fri,
 20 Sep 2024 14:59:49 -0400
X-MC-Unique: tazn4dD-Nyyiw5N8Uomz6A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96565192DE07;
	Fri, 20 Sep 2024 18:59:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.33.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EF6019560AA;
	Fri, 20 Sep 2024 18:59:42 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 0/2] Fixes in igbvf driver
Date: Fri, 20 Sep 2024 15:59:15 -0300
Message-ID: <20240920185918.616302-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The first patch fixes a bug manifested manifested in the igbvf driver
when interrupting handling for the igb driver delays.

The second is just a cleanup for igbvf.

Wander Lairson Costa (2):
  igb: Disable threaded IRQ for igb_msix_other
  igbvf: remove unused spinlock

 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 3 ---
 drivers/net/ethernet/intel/igbvf/netdev.c | 3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.46.1


