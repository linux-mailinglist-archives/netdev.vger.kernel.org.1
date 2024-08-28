Return-Path: <netdev+bounces-122869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D328962E9E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873BC1C21A66
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF619FA77;
	Wed, 28 Aug 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/l/P/4f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810B47F46
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866573; cv=none; b=rzzLnk9ySMwZRWQdwRJASZfcfHgzZKtic1bhLvBzUucfJi/xhxmti+CufEIRVdAs2P0TnWk5cKFbnPMauIHMzmzrb90crvpkD8MNeNV1snLzxO1sqpH9sPAttYZeneun4btHszPQQkMjYuFqzwtqWxH5+2fLhIq8OtxlbhVJuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866573; c=relaxed/simple;
	bh=6EEBbKkpZ7L3uoi2yfjLCdZeuPW/vNzeodd9JW0L/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e0L0m2MIOG8cdk1LDhqD5bosUTUqHy60f5k7aqEW3vb4Ra6EU3mqPetNHOlcHN52ySsIIRp8Su+Cl4atzaMYxCLg8t0/jT2DJUWpVREpE3jW3dWLEJAcSACrs8evwlfYIzleO23SbNYL2om1ThPqsblhcGF+TXOfsTF+AGT1csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/l/P/4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D9C4CEC2;
	Wed, 28 Aug 2024 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866572;
	bh=6EEBbKkpZ7L3uoi2yfjLCdZeuPW/vNzeodd9JW0L/oQ=;
	h=From:To:Cc:Subject:Date:From;
	b=R/l/P/4f97a/Yodl+CGu36XLQDqmeaPslzaW36UOZZNUoHU8tBIaKTTMQpD7YsM5o
	 gr3KPrY7eObAiwcQEWJeBqK5qUNhSvLn8fZF64smNIGySy7aT2QbbsXaFm7nZrP3/T
	 pfgJhlUswGUPuyYcHndxfdBuVY7Kp/1syf6KOhzjDsJK95I2LFQkyEHO8fpw9QKlLf
	 jM44rLZb3uP8IlrlQFXtoY72V9VjtPu2JK1Nx5VbGU6P89D48ZBJvwlae2cmaoOxsa
	 wve4G1Nm/Fu9Q4qgc5mn9T+DOjDmWALB1vYvMclC5BlVcv1idnpz+k7UwYsCzoqglD
	 Q0YX4WAGsIwWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	martin.lau@kernel.org,
	ast@kernel.org,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next] tools: ynl: error check scanf() in a sample
Date: Wed, 28 Aug 2024 10:36:09 -0700
Message-ID: <20240828173609.2951335-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Someone reported on GitHub that the YNL NIPA test is failing
when run locally. The test builds the tools, and it hits:

  netdev.c:82:9: warning: ignoring return value of ‘scanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  82 | scanf("%d", &ifindex);

I can't repro this on my setups but error seems clear enough.

Link: https://github.com/linux-netdev/nipa/discussions/37
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: martin.lau@kernel.org
CC: ast@kernel.org
CC: nicolas.dichtel@6wind.com
---
 tools/net/ynl/samples/netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index 3e7b29bd55d5..22609d44c89a 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -79,7 +79,10 @@ int main(int argc, char **argv)
 		goto err_close;
 
 	printf("Select ifc ($ifindex; or 0 = dump; or -2 ntf check): ");
-	scanf("%d", &ifindex);
+	if (scanf("%d", &ifindex) != 1) {
+		fprintf(stderr, "Error: unable to parse input\n");
+		goto err_destroy;
+	}
 
 	if (ifindex > 0) {
 		struct netdev_dev_get_req *req;
@@ -119,6 +122,7 @@ int main(int argc, char **argv)
 
 err_close:
 	fprintf(stderr, "YNL: %s\n", ys->err.msg);
+err_destroy:
 	ynl_sock_destroy(ys);
 	return 2;
 }
-- 
2.46.0


