Return-Path: <netdev+bounces-137538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BD9A6DCC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9D11F2276A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE951F9408;
	Mon, 21 Oct 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aiz2T1wr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B3EEB3;
	Mon, 21 Oct 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523670; cv=none; b=LSYCQUg3XXwVvygZW9QDs89IKynFWw1JWNJHOMFZpf50xHV/FvUOY3TNO3cpAgITI+s/a56FFu9UZK18N6JdpDQ9dDm4WgGCsTwEu69G3Feud/X32mkpCYg5GDiWmpU1Z/FkbXUjOGLdyVtxkcQrcWmN54zN/ixaklajvPWqFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523670; c=relaxed/simple;
	bh=9Ci3URL81eTgLvYVIBvGyCPDi5UDYbisHdT29x4F5Vc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ViBxXgL2KbAYzwaUDPqkCD1HR7hyQhNI7gh8AP422kwpFdSSZr2RLHHdOZDdTabxNE9LKiIWEShPe+VCh7kbYBw/7JpIbXIdINZ22TKBzG56dUXiQjwESOpV4X5kWX4ERRndgz/aibAFua53taEZCLyPsbH6dw0D6ZrncPXlnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aiz2T1wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C8C4CEC3;
	Mon, 21 Oct 2024 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523670;
	bh=9Ci3URL81eTgLvYVIBvGyCPDi5UDYbisHdT29x4F5Vc=;
	h=From:Subject:Date:To:Cc:From;
	b=Aiz2T1wrGx4PRpFelsNC3fQjyF1G1m1tgcKw0i3wg0jkRC5vqDURVlPy8VwZDGvD7
	 oZui0ChdnwxicVTWv9oXwumatrAOMh0t2nyq55vyWXvKsiwrJeC3ppLTVtt4cWrmMX
	 VGyzz7dcWoZr3suwzDCvn69dv22m0aWS2fiD4vHYpxa+ywbfyQtAMO5kPsu/QFeS3s
	 lxy/dO40uO+yR9U3EUUc7xdN6R7LgWojSuBJlQRGKpeBW0KjhHYIOr/N12s6qgqAlg
	 KozOsKtk1dKaw1Bwnpa9FSAMRKwY3L26vWP++9lckixsk7BH5R1NpCj7ux1hUw38NF
	 zeKOxaFXOWiyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: various small improvements
Date: Mon, 21 Oct 2024 17:14:02 +0200
Message-Id: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpvFmcC/zWMMQqAMAwAvyKZDbRNFfEr4iA1agZraYsI4t8tg
 sMNN9zdkDgKJ+irGyKfkuTwRXRdgdsmvzLKXByMMlYr3aHnXLgy7iG7gLskhy1qQkeWqLGGeFJ
 Q8hB5ketbD/BXMD7PC5v8Oxl0AAAA
X-Change-ID: 20241018-net-next-mptcp-misc-6-13-c34335423ea0
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Davide Caratti <dcaratti@redhat.com>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9Ci3URL81eTgLvYVIBvGyCPDi5UDYbisHdT29x4F5Vc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFm/SwdUTR64cmNwmbeZD8w3h9o8NigR+iSL6T
 P3kQUANCbyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxZv0gAKCRD2t4JPQmmg
 c9T4D/9t6LvYjS7aLGlxvd0QDPpzJ9Xqxf3vzG3ffoOhs1vVR6hvkdb69qTQOu6djrxMBNVkDNT
 V4P7RzoG+j3lvvBOGKmvo4Hwp+eVdjcKbYH5YyMphF5z+ehts8Y7QEhuCWi35eZjur+GXxy3tDt
 mD+x2fbw8xcvUIpEBK7PVzQHzEE/uJMUa7pBbP1nHlx1PLbxfAEfHenf089VZP5ww4/u+gPzjkw
 T2S31uusjxBVeVGlUnIKbXJjDS4kHpSskxxvIZYEr9A8ZG6SJAktrDYzH3SWFxMn50y+5MQbPKi
 zZfOTvOLNxs8D3NPz+xxuB83vlhqIs9dVMishz6dn4PaBZjIXXI1XtOv5+/akTMPE0qkNpyFQng
 HqZ1m4A3X5sbhW+rN6N0PZNwbjqyTiEPiRg2xTlNGpi+kXSlfhe0Q3+r/weNLVpAR1kO6SF/mZc
 Wt6bzy9U2cTQ8w9XXwKLaKefYkIe3hAIx1n4tlAtZmqxtfw6zf1lMneAvC+GvJ3g9jn98Pwx7IC
 CyhAmMiwtju7eCfQ6nUkMoA0t1YBfOKsXlz7Ec1xEIjTndaN74EvwP6bayiR92y5qlJB/7hRB/G
 itspyHzNCT8jQWPfeqO2glAzZMjVa52st4Zby86baHIV9AzFr+jq2Jy85Nf78zmSUXWKJDCMxH4
 DPq0dQIPYE2JWOA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The following patches are not related to each other.

- Patch 1: Avoid sending advertisements on stale subflows, reducing
  risks on loosing them.

- Patch 2: Annotate data-races around subflow->fully_established, using
  READ/WRITE_ONCE().

- Patch 3: A small clean-up on the PM side, avoiding a bit of duplicated
  code.

- Patch 4: Use "Middlebox interference" MP_TCPRST code in reaction to a
  packet received without MPTCP options in the middle of a connection.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Davide Caratti (1):
      mptcp: use "middlebox interference" RST when no DSS

Gang Yan (1):
      mptcp: annotate data-races around subflow->fully_established

Geliang Tang (1):
      mptcp: implement mptcp_pm_connection_closed

Matthieu Baerts (NGI0) (1):
      mptcp: pm: send ACK on non-stale subflows

 net/mptcp/diag.c       |  2 +-
 net/mptcp/options.c    |  4 ++--
 net/mptcp/pm.c         |  3 +++
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 net/mptcp/protocol.c   |  8 +++-----
 net/mptcp/protocol.h   |  6 +++---
 net/mptcp/subflow.c    | 16 ++++++++++------
 7 files changed, 33 insertions(+), 20 deletions(-)
---
base-commit: 7cb08476e19fb3d0dce618df7c11713434553e27
change-id: 20241018-net-next-mptcp-misc-6-13-c34335423ea0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


