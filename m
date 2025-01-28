Return-Path: <netdev+bounces-161325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB2A20B26
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04119164E90
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2661A9B4D;
	Tue, 28 Jan 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Bb4urRsS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA91A9B40
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070174; cv=none; b=uOPAqWYt7fYMDH28iFQY8BO8sXl6fMVYoHBmbsXmZoPArLOrUgtdMDR/+7wGjfNU21F/BEce2lfdUXCuP9wDRFAShphXgrbW4Xz3ecrwmRpxwadWQY4QWzrdw60pc3Y3yYgWm9Kfg9CBfkSadJbayTD9uNVo61HXv8rm00dn/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070174; c=relaxed/simple;
	bh=qEghCYw90LvLl/UsHV0yG5FBhJG01TkgMBGl7th78es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoxYJBj1A1cZTFH5wIvxQibqlE95dEb9BGxr/ndo+KO88tntFNP94uTgpH9tx1HwEHTBJf0OW67+4F7ZOvJaFBlc0j8nkg2dspvvlTx5DWHKkUER5/ogRpJFT6cM2ACxZs5tz2a8HaqyHatbbtG1XIxSzTCez1ahmcUtMdaNi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Bb4urRsS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRo-002exw-Rb; Tue, 28 Jan 2025 14:16:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=50sw8+RLYxtrONIEeNuYTgWEQ2DmBdco7580O/YdZEI=; b=Bb4urRsSXepjlV/UbEYOiBfbza
	Er9217poUVswq9HMXXkliZT3lvhKIPVnFq4lGMMgvl1ptLIEpVlBjl90JjyEKifaQe10Ozf45a+Zo
	muvLjrhBTHFTnG4d1WnqNxDJgjaU+zyiQ2CQQLn2BqzvG/EzibdJx2knc3hvBXyHDJ1lti0bHIcNS
	7LQ5ETDZws+CvCzcmosaDt0ELAAA9PbFJGUEaaIXJASC+UpVb3BxCuEHKO+/SruEUHMOo4HgTqf8B
	N7kc3IyWy4yWl1LN3HXY+qgpIe22pxUIReM2ZsdK9kHE6/j+p7Vj3cspSNy0g6LxyUpEnUqxoaLGw
	hsXiolSg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRo-0006wY-DV; Tue, 28 Jan 2025 14:16:08 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRJ-000mZg-Py; Tue, 28 Jan 2025 14:15:37 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 28 Jan 2025 14:15:28 +0100
Subject: [PATCH net v3 2/6] vsock: Allow retrying on connect() failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-vsock-transport-vs-autobind-v3-2-1cf57065b770@rbox.co>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

sk_err is set when a (connectible) connect() fails. Effectively, this makes
an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
subsequent connection attempts.

Clear sk_err upon trying to establish a connection.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		if (err < 0)
 			goto out;
 
+		/* sk_err might have been set as a result of an earlier
+		 * (failed) connect attempt.
+		 */
+		sk->sk_err = 0;
+
 		/* Mark sock as connecting and set the error code to in
 		 * progress in case this is a non-blocking connect.
 		 */

-- 
2.48.1


