Return-Path: <netdev+bounces-136620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D840D9A2679
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E319282EEE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514821DED51;
	Thu, 17 Oct 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7kwpetA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6081DED4D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178669; cv=none; b=Q7oPO2dBCUAHhlZ1uLR3C0IrU9h4z60g4AkXYoh81Qsm0rOk1AWMl/GehMZ9RDGKxwaQI24taOsqJHpFTwHJ1aXDwTxcpDPt6P74XzZMqv3YkjWWWA162cKiuY2sgFKrDJA4BUMONHegYO3t7ptKsICYUq20ELmZHxx+aoa+SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178669; c=relaxed/simple;
	bh=OykKxKwP0lrkTqzkAJtCbXaqTh7JZLgsk0rcLfNzoow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9y/nHShY7Ag5iAti8gBxjRicjLg2NmdxuVaj/bmyYxEUBDjzBmSw2PgsRjO+I8RxfIT85V6e5YtKp618fSMP5wPWQgIKfqijj/INOC8MkaUsTodEec1r1O0uW/hfnJZWRO7IRAljNGM9lIVhzfEle4dipyucUr1NC/xyGTabyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7kwpetA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD9EC4CEC3;
	Thu, 17 Oct 2024 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729178668;
	bh=OykKxKwP0lrkTqzkAJtCbXaqTh7JZLgsk0rcLfNzoow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7kwpetA0lX81KRkcc3HZzVPO2iHq3m6YcUqeD9+yiEzPIviJ5YSbA7YUW+FlwoN9
	 Gn+powb5iWFi73S3d5v3zxYiBvdNxa1/wRU5cSraYgFd4snggOxPyOC/zJmQk4j0sF
	 x3SZS5l3a+4GGNTxAXMGpI62miL2mfrkIzi4yL1FbpqCg3sQ/2gKUXuHmGKTpZx7NL
	 /ygYxm6a1qDoEm92ktKcMg0Zh3kKspEFhSzqOqVQe6DWacNoMTL1EquWb6Wh9CeTg9
	 lAO3TciNpEEj5uAZkwAiOia1H0vL29Pz49r20ZUYBHIvwmlyobjflkKQ5QgatKyNHE
	 7JLUHyoqkkfaQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: sysctl: remove always-true condition
Date: Thu, 17 Oct 2024 17:24:17 +0200
Message-ID: <20241017152422.487406-2-atenart@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017152422.487406-1-atenart@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before adding a new line at the end of the temporary buffer in
dump_cpumask, a length check is performed to ensure there is space for
it.

  len = min(sizeof(kbuf) - 1, *lenp);
  len = scnprintf(kbuf, len, ...);
  if (len < *lenp)
          kbuf[len++] = '\n';

Note that the check is currently logically wrong, the written length is
compared against the output buffer, not the temporary one. However this
has no consequence as this is always true, even if fixed: scnprintf
includes a null char at the end of the buffer but the returned length do
not include it and there is always space for overriding it with a
newline.

Remove the condition.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/sysctl_net_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b60fac380cec..e7c0121dfaa1 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -69,8 +69,10 @@ static void dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 		return;
 	}
 
-	if (len < *lenp)
-		kbuf[len++] = '\n';
+	/* scnprintf writes a trailing null char not counted in the returned
+	 * length, override it with a newline.
+	 */
+	kbuf[len++] = '\n';
 	memcpy(buffer, kbuf, len);
 	*lenp = len;
 	*ppos += len;
-- 
2.47.0


