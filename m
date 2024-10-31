Return-Path: <netdev+bounces-140654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D79B76E3
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD2F1C211C1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDA191F95;
	Thu, 31 Oct 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4hU9UFQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E4188CB5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364869; cv=none; b=e4Yc5Oe/CiIGZ/8BsWofdeGDcE5psoT1Tf66wPZvTofONTit2m3791FIxqWcoBx6A44l0hBYFsApZ8LCJYuIaWTW78oqIdEz2Qz5Z5tZdF4DhFjpTy3YRLnVTOBJtztNDHPgnZDNsr2ejoO8KayYCjtfVWUDXwha06y2JRYxewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364869; c=relaxed/simple;
	bh=vr3Sv/+c82v6CtX9a+kMIZ6s1FUOVbpF9h0hlQAI8oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGU75qO0ULWd833bPvp5NZbNUKfeEJbupxV/s9/PkhhsjR2g6OiGTGDABpYPqusBga9HJiqwa3kGTiERvMAxWa7YyoSyqAEN0rfy7LuVpeqgZqeShPMZOMAOLDDUFl1PlnwQv/XFdzgQB9fb2PLX5TSA5C6+yiZz5ZT8/OgG4lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4hU9UFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730364866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbAjl2Shden4WnBpQYkGv2fcUa8pXm9RHIlYLMS16Qs=;
	b=g4hU9UFQ28C1PBUxB67W4TGTZQB/nKyAMmN1BoWf2toQ01Sn8WldJjyT9Hzvz3DbhdKb0T
	DmpGaQS1zNWSJOQb3tVYudjaC9k+jQ3umIjhDdrT7uEWXpa8JEAJ4eRt9Layj8B3idzLlm
	F5v361PAERvfdYDdYUk6AVrbG3/WnYo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-8sbxwU_OOPmFuUzUzCvGgA-1; Thu,
 31 Oct 2024 04:54:22 -0400
X-MC-Unique: 8sbxwU_OOPmFuUzUzCvGgA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD3E81955D48;
	Thu, 31 Oct 2024 08:54:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44FB41956088;
	Thu, 31 Oct 2024 08:54:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: really check for bg process completion
Date: Thu, 31 Oct 2024 09:53:23 +0100
Message-ID: <d901a9ded301d63d9532c17ec4cd1a0164b966a0.1730364250.git.pabeni@redhat.com>
In-Reply-To: <cover.1730364250.git.pabeni@redhat.com>
References: <cover.1730364250.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A recent refactor transformed the check for process completion
in a true statement, due to a typo.

As a result, the relevant test-case is unable to catch the
regression it was supposed to detect.

Restore the correct condition.

Fixes: 691bb4e49c98 ("selftests: net: avoid just another constant wait")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 569bce8b6383..6c651c880fe8 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2056,7 +2056,7 @@ check_running() {
 	pid=${1}
 	cmd=${2}
 
-	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "${cmd}" ]
 }
 
 test_cleanup_vxlanX_exception() {
-- 
2.45.2


