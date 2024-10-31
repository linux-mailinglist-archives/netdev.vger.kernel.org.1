Return-Path: <netdev+bounces-140652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B69B76E1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8A8287E7E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3E193402;
	Thu, 31 Oct 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkSfRebn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDD187323
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364852; cv=none; b=XwhFwJeaOj0wMQT14NqIgWWgCMa8uH0J/OUH/jzyOjVjEaLqqaWxB68JDMZOjwAhedtU2Naabm9gq3g95jeI2h8kkwdIfDst7zYIufHl6zE/Gtt83mwwDq9fpd4hA5/JdRBG9INMXf3hWnTgg5uVL5LhDukizTb7AwRSMr8+uOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364852; c=relaxed/simple;
	bh=0+GgYw62dndOpaOzNAJ/ay9qv4ea98nadKC5OtOOzS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxmwK35tCXV+2Be9gLRNLMG+evMT5Ji+jPrjnUN62wep5A/pGI2VZxMIb8Jwt/tErXbXkQjTaZMJcHc+vZW9TGqgu3n16YNs4Hg0OrzjUsOzBdzttBoO6FYFoIfjwe+UppPGHVEkF5P3/0qbyeJSey49fixpw09niZsHnX+pcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkSfRebn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730364849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T1dNlX5YcBF3OmGSXr4sw5BLykwXixyNoGYMh0J/g1E=;
	b=BkSfRebn8hag/3CspGcOfKxrjP2IGLBluCRBqMM292OifNrGmnr2CBXs+tjDbI2upwHLFZ
	XBG0ZUnY0o0PnvljxL8bNVd1CtjVoQABNFeWU+E48QrmQ0v+ejXheoZlQv5c6dSos4SWxg
	8KB+Q3/3rpjQKbXBvaOFmYE7MEprqWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-7Prd5Gs8Owu9JC9i77u-fw-1; Thu,
 31 Oct 2024 04:54:04 -0400
X-MC-Unique: 7Prd5Gs8Owu9JC9i77u-fw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 370661956069;
	Thu, 31 Oct 2024 08:54:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39C051956086;
	Thu, 31 Oct 2024 08:53:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 0/2] ipv6: fix hangup on device removal
Date: Thu, 31 Oct 2024 09:53:21 +0100
Message-ID: <cover.1730364250.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This addresses the infamous unregister_netdevice splat in net selftests;
the actual fix is carried by the first patch, while the 2nd one
addresses a related problem in the relevant test that was patially
hiding the problem.

Targeting net-next as the issue is quite old and I feel a little lost
in the fib info/nh jungle.

Paolo Abeni (2):
  ipv6: release nexthop on device removal
  selftests: net: really check for bg process completion

 net/ipv6/route.c                    | 7 ++++---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.45.2


