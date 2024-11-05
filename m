Return-Path: <netdev+bounces-142072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB79BD478
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9469A2838F6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A021E766D;
	Tue,  5 Nov 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMyNXRPm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625D13D52E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831047; cv=none; b=tekh7G2mbRsKkYkK3adhTV0dQI8OEg1WII6Vcc9zAS4o14jK1jHXRFOKoFQd2oxzqR+MXpSrnpzvhtP7wqjg4z8zD9jbYFqblqVn8w/jZDI+Fuxk4JNMHDF8ABG/+qONq3Ggx+VimqgMxM5uxttoqD0eHRITLuFYn2P05XRmDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831047; c=relaxed/simple;
	bh=ynLH6n5Pr4ZxOzwF0y8pcyk94Ps7SUdfGFPrT6aubWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7WElNd9MKqr59506cAR/OcIIJwi0WlQdHleHZMVVUKXU5NZgBIzl8OBbO9EnFYJaO/Zgbsr47lK0ZzRaldjDbGVQp1owdV3igGuRse5aZk5jbgqbb3Mu5UVDQ3W/6IxbwWef3qEQ7B9EPXH0Up3hebKtoGmJ99wAlEzNKk5RhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMyNXRPm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730831045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cWzagkOpqON0DTEOaf3JF36NZicTs95TmDUMpi4MDn8=;
	b=IMyNXRPm/eRTelIbHUFyGO7VMs/HWnejDhY5xsMhPOy/aULYzlH06TzkP0O8x3joktqpJ8
	snowmw3TndIVu/ge0FgFBG7Np6ipb+1QMAbqMx8Z0rb3gBREX6u+39pLZbufhl7epteqsW
	0XGRpx9jdNJwlxoaKWuCvo+wwiw/THo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-7fI5p4pFNxO5DfYgoercEQ-1; Tue,
 05 Nov 2024 13:24:00 -0500
X-MC-Unique: 7fI5p4pFNxO5DfYgoercEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D50919772E9;
	Tue,  5 Nov 2024 18:23:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ACE019560AA;
	Tue,  5 Nov 2024 18:23:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net-next 0/2] ipv6: fix hangup on device removal
Date: Tue,  5 Nov 2024 19:23:49 +0100
Message-ID: <cover.1730828007.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This addresses the infamous unregister_netdevice splat in net selftests;
the actual fix is carried by the first patch, while the 2nd one
addresses a related problem in the relevant test that was patially
hiding the problem.

Targeting net-next as the issue is quite old and I feel a little lost
in the fib info/nh jungle.
---
v1 -> v2:
 - drop unintended whitespace change in patch 1/2

Paolo Abeni (2):
  ipv6: release nexthop on device removal
  selftests: net: really check for bg process completion

 net/ipv6/route.c                    | 6 +++---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.45.2


