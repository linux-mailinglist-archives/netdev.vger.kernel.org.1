Return-Path: <netdev+bounces-169976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A77A46B02
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34E016EB44
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D723BCED;
	Wed, 26 Feb 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaYDl7bj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4C239597
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598111; cv=none; b=IK2/Sc0btm5yzQn3otLVQm19DFliCOXUOOnTTf8prRwgNOeOPiTz70lDzm1OX7bvoDlNQXlt6NRzyJIB/+GPG3enoDnBkb/GztI1ZBWJGAcKZ0i6PpzMA2AqlLVainJUu+OQpppg4zRv0XEnn+wynUvQhPXrItwYKz1m09CpTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598111; c=relaxed/simple;
	bh=tZ4mEjz0mMBNAvIEKtBrdqpxwP3sR5OVhL8PyV1SRr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BE7cXZEHJivvJul7FQqQ+cdYxf6kEjs6/Hy8akKzyYzUe1gcVfo174mTUtbqZbM48jXPjeuQadQCiANeokvZk3RqQVaJqG/vT34unOvGAUkFGRqpQIluHJAdLOPCk9g1oDf3joW8em4cxPDty9E6y5xugJo+cWWAtKxjB1ZseXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaYDl7bj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so349191a91.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598110; x=1741202910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAHfytQNUsiD5c8K+E1ZBkdfL4DOZcpSAfUWQ+cotG0=;
        b=JaYDl7bjX5h0huLcAR1OIKmxjCo9+3BOJW4FfQeY7V0kDeGvNWRtTCBQ8DUUco/W/3
         0hp+RPfL5nQXwbB78Uzq4ijgG+T6IVGen0M9WNxSzsJnp7f+7YcPjKIND7viHySSwA9G
         SwYG/XklvpZbx25GurISQmV4kfWvKOGUi0Rmhwjcrr5r4fd8vAUdb0K0FqFR+MryYp0f
         ThbuOPbr1Rg2qAmnnanuvDfV+v+y/WwZ71KlOlo7TOOJpQJ0YrQMzPvS3FmrGfWg9WHK
         Y2syXJMs2cGBy6/4gy/sBlMV/Y3uZcXxH7bJsHqfkqlORW17PP2TeLhRIbYAJykYjqjS
         HxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598110; x=1741202910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAHfytQNUsiD5c8K+E1ZBkdfL4DOZcpSAfUWQ+cotG0=;
        b=JbDQJMHc4UpWgHRkT6QyPnKvQhjjmioZbEQE0OjuZzzEltahCPO6SEwqDcABbgxRaf
         dJGTpPhSxMF7OAkFq9eU7fjMHl+ucJZ1Rr0DIdxQfZKWZLmt3A/kp1+RIK2CtsLuKP2e
         URowWe7pXCDzLQ0+MzPAo7x5ukB84rOyauMCQ9oA14oX+HYj1X1xKZOR71o3NLHZAqch
         EaALkZDinNtiouDnwlsQ3y5cwB8gBFZ8grWIqurubZnUa4owxmCKsQA3fsl4g/gR54A1
         XVLc8bj6CUAljSqeaDNNH5IKxJ9pizMLrFlODrB8hBjoORnoRloyj9keNObFgDlTauqT
         Gx9Q==
X-Gm-Message-State: AOJu0YyNfmYZBR0yCdXCdeX5gZoNiFX8yci24tLDM1m9ZSCXPoXWNlXc
	Jd8uefXJGe54PJizls5VSBK9cuZFdSPyA08a/qqNJyhndeAPb8rRvaxeW4vzMK6F10ZLeEu21zc
	KC2J4Ob0mbhs/HxGuPbhCn0hIj0vhqeWiv+ZqH2Ra41rfQsVQdl5cItr+9uNekfvJ/3NCrHjJoW
	IBOu8fS8clXTmxAo54DiZILGe9NZmimpyY+Teg5f8+lw==
X-Google-Smtp-Source: AGHT+IHnpgBcjLWJK3P1K4UEwO48PptHkVPMDaQtRyrbfS1CeCFR9+JXWBlM+SMFre4xrXqt/dk+pNsU4kVPXg==
X-Received: from pjbsg17.prod.google.com ([2002:a17:90b:5211:b0:2fa:2661:76ac])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d88:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fe7e2e0f5dmr6628296a91.4.1740598109628;
 Wed, 26 Feb 2025 11:28:29 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:24 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-3-krakauer@google.com>
Subject: [PATCH v2 2/3] selftests/net: only print passing message in GRO tests
 when tests pass
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

gro.c:main no longer erroneously claims a test passes when running as a
sender.

Tested: Ran `gro.sh -t large` to verify the sender no longer prints a
status.

Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index b2184847e388..d5824eadea10 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -1318,11 +1318,13 @@ int main(int argc, char **argv)
 	read_MAC(src_mac, smac);
 	read_MAC(dst_mac, dmac);
 
-	if (tx_socket)
+	if (tx_socket) {
 		gro_sender();
-	else
+	} else {
+		/* Only the receiver exit status determines test success. */
 		gro_receiver();
+		fprintf(stderr, "Gro::%s test passed.\n", testname);
+	}
 
-	fprintf(stderr, "Gro::%s test passed.\n", testname);
 	return 0;
 }
-- 
2.48.1.658.g4767266eb4-goog


