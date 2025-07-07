Return-Path: <netdev+bounces-204535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD0AFB11F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA0E17F00E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CA293C7A;
	Mon,  7 Jul 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdhquR7G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29561DE3AC
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883890; cv=none; b=VRg03mGFizdEBUfigajG/DRfpQY/GM3YavZlpC/2CpU/VEovVlNNO170VmQhdOD4Zlw5zFZQ2qKWU3KwnfSy9jlOaNZMcz/vtkI1IhkanKUNdJvj6rH8fbN1UVz3v+h9eE7X3wMJ9GVOvyiLAidJ6Bv59OhwSty/OhuuQhkp8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883890; c=relaxed/simple;
	bh=MLJFXdV+zNK1ZuhNtUUtW5D8Mcd2Km3jyqtOGr/sR8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfXaD4wNh6ewZUihiLAqUpmnXbMgNu9ravlCARSR6SpvyBKft05V1qEzK/usivZYvk6oQ66MnOUCA2O6LWc+S/nqgMspCRa5Qa6P1lpei1+ovEzpDGI65yUOyvxLRQfNZUyhsLA5ypeRfPm1yI2eKxmOmUY43h3kE3DTON6pv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdhquR7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751883886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jKrMSwx0A9Y2yayFOqoqu96ALKC9wDHuSwf+9nBv8n4=;
	b=NdhquR7GUONabPOwXkKhGDP5+fQyjH0KvFuX2ER3hzy2tu409J1mlkfxS1AoKWY30qgvdR
	riIYY1TOBzcloTfM+Qwv/7BJAIeWF47k/r9r99ry1AEIzjy///qdDBhsoNkIqYSXO9gSeS
	V3T2At1VOBI3sShTITZM1HtaofDpLsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-BBBVyMfnPUS8bfUNDnGgNQ-1; Mon,
 07 Jul 2025 06:24:44 -0400
X-MC-Unique: BBBVyMfnPUS8bfUNDnGgNQ-1
X-Mimecast-MFC-AGG-ID: BBBVyMfnPUS8bfUNDnGgNQ_1751883883
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD203180029E;
	Mon,  7 Jul 2025 10:24:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85F6C195608F;
	Mon,  7 Jul 2025 10:24:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] rxrpc: Miscellaneous fixes
Date: Mon,  7 Jul 2025 11:24:32 +0100
Message-ID: <20250707102435.2381045-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Here are some miscellaneous fixes for rxrpc:

 (1) Fix a warning about over-large frame size in rxrpc_send_response().

 (2) Fix assertion failure due to preallocation collision.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix over large frame size warning
  rxrpc: Fix bug due to prealloc collision

 net/rxrpc/ar-internal.h | 15 +++++++++------
 net/rxrpc/call_accept.c |  2 ++
 net/rxrpc/output.c      |  5 ++++-
 3 files changed, 15 insertions(+), 7 deletions(-)


