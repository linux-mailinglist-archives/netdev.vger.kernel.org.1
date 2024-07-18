Return-Path: <netdev+bounces-112047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC843934BBC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78944284B7C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7B12C470;
	Thu, 18 Jul 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkk5yYEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20781737;
	Thu, 18 Jul 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298859; cv=none; b=NqHVCSBRfdogf8djOvB48PZn+Za5OLgXSGWz9/2HtI9oaX2Typ1QVLBED/l5NdDuSAHMQ5zmJxdKrbVk28efFxIAMMEm2W461djNGdiaB51wQYZIyhluGo1q/aysvjoZ8lEw60fJvari0+DQjUuNzaWBOxFcCYf51TFC84Vb5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298859; c=relaxed/simple;
	bh=nIki4zem//5SAhME0Gc430iDZM6F78ONm09AnzKFdaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JwICuhwxG2gbq3PC6OpR73R8j7eQFkuivY8Gr8sIsVWml6+oGOZXe3EYbwekaKwNRj6nYxFtKuzbSTSOxdRZkWWv1SaQYuMp0G+gHpjW2UGVLuhw1vo8da8C4nvSkufw9s9HPKIxZ/q0bFZ7aSwsOFyDXpOjD8X6qQ9cb6t5S0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkk5yYEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D2C116B1;
	Thu, 18 Jul 2024 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298859;
	bh=nIki4zem//5SAhME0Gc430iDZM6F78ONm09AnzKFdaU=;
	h=From:Subject:Date:To:Cc:From;
	b=Tkk5yYEN1r0nlhyqXQCC2lR4mrBQEtv8Mpv0OyMNARqppLA0VUwyah3SxxEy1Sa7n
	 YFEu+c9DHJ0Eq2njdle9C2tJU1Max8b8FwWgOIZxZob2OwM7BKxSNpHFmHQZJ/3/wp
	 xkFyMv3kh9thM3X5my9F/zTFl1mnJPWWOspC7C7I/VvJdYF4aY5HAvGM7tC/ofPbzB
	 SI9Y6l4sfkCdN8uQObRd/XzEslOsjqavo2rFUqFCcdTfhYmiKlrzEAqJQM0XmoPoyh
	 WeM8zWeeggdRO3zQ0t/yxiJI3bnSWveYa7IQEVfg8C2uLNEWrLoBympNe7JYRwU9A7
	 KrpoyGrRQuKsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to
 SYN-ACK
Date: Thu, 18 Jul 2024 12:33:55 +0200
Message-Id: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPvmGYC/6VOSwqDMBS8SnnrvpLEH3bVexQpmjw1pCaSRLGId
 29w0Qt0MYv5MDM7BPKaAtwvO3haddDOJiKuF5BjawdCrRIHwUTOKl7iMofoqZ3QUkzYIv6sKGf
 MvMJWGpTOhmUiDOYVnDQpy2SneFH3sugYpPrZU6+3c/oJqQyaJI46ROc/552Vn9b/yytHjjmVX
 LGuqkWWPQx5S++b8wM0x3F8AdFG9EcGAQAA
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nIki4zem//5SAhME0Gc430iDZM6F78ONm09AnzKFdaU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmO+ofFHTXSohnyPEVxxy9Z/ALp9haBU194jaK
 NdPPWYp9MqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpjvqAAKCRD2t4JPQmmg
 c6NEEAC5gTnPiRMwLKXLQtMyy+olLfYWmCm6vSpGKRCWoRrId93qyYXinSpUH2TwX8GLmRxWVQk
 Ocum97Yd4cFKo4dzwkzRezob5sHQmZStG2cJZ4tX8R3XDrYLE8jrwdVhH9q71kn9nPnOAXoyioh
 orYA5mCmB+YE3vZ5INd5yrKhvJ5geqIa9ytzY+nSYH2un5bR91d/6feKyGY74sx1U5UpBBxEcWF
 NfF2K5BYNGpEq7J9ISZeVBeRkm8khzKSvhNMVDq971X4W7fuFCeKs9WY9X0mWZzaW49FkIvktKv
 vvcWywSkM/bK9FzL3jTCo+lkJIbthJ7ZN9t1EZ7J6Sv+IbFY2WRAmZ00WgpMaZzc3DWxbnn7oHO
 5xePAxGJzuIJs51OH+dSXFSZe29L9lErUdRKVnF/z4jZxg8THLIa/12AygSfxPtpfVYk9akIU1/
 VHmyf52lXRKosazzXR299UtiemBJilqDpISnyRL9yrq52DX4L+mojaLrbGhd1THbhUTF3Vveh0w
 AozgjdehdHfotonjLMRS6Rt97IE7gq6vc8hUK4X/1Ar/Ywx02MCX27gZwiCB/tH+v1Gv5VKS1YL
 9dvJzB0/jYOgJAljvT/qyhrFuyLuFJTxYkOQf6guUr7QFd5bmV46IsmLybeljDMRMbChrF4JX5m
 M8PCkquAZ7ubOAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A recent commit in TCP affects TFO and MPTCP in some cases. The first
patch fixes that.

The second one applies the same fix to another crossed SYN specific
action just before.

These two fixes simply restrict what should be done only for crossed SYN
cases to packets with SYN-ACK flags.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
  comment.
- New patch 2/2: a related fix
- Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org

---
Matthieu Baerts (NGI0) (2):
      tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
      tcp: limit wake-up for crossed SYN cases to SYN-ACK

 net/ipv4/tcp_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
---
base-commit: 120f1c857a73e52132e473dee89b340440cb692b
change-id: 20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-0cbd159fc5b0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


