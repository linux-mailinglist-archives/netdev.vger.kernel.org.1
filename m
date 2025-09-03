Return-Path: <netdev+bounces-219701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695EB42AE8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C47B1890A4E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E93054EA;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkQZDPrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CB2E9731;
	Wed,  3 Sep 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931402; cv=none; b=mxx5USWLCGnq2JCiH/cx5Sb9EyXMg8MtIgskRHjl6slNYF+teXgkuxHgGZUDrhrEOkm02vM/pME99j+807DN2uwzPir1UCncix8Sgo+vhTWGZZKV0SYLV1DF2+fmaiRLth9E103wKTPGnAONStPNWiCJy01I0Vvd8J2pt6Tu064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931402; c=relaxed/simple;
	bh=GaOBbZnTDqpis7Ev0gz2xVSYm843uhg9SOiJBrzjv1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C+t17qOUPmJhgJwF6wQztNNfed4mVecVmREpcFbphgOH+jNsLlCIl9bNeXcEie8PLoPW6xRNgYjwun5RY5NnyQUXDWpkEjUlSNjcqYI30D6uJu56If/MO14auPpucCSy0VB58gJTMQhKeGr5rEu7IWWqFyPLCwTpERiWQ8dfmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkQZDPrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D22E2C4CEE7;
	Wed,  3 Sep 2025 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756931401;
	bh=GaOBbZnTDqpis7Ev0gz2xVSYm843uhg9SOiJBrzjv1o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dkQZDPrVRCqgQGqzTnXmRNFKBUsBLoQy9MS199H+J1iGAr1GrCzevtfehKkazvqzp
	 +wN9+Mr2CVq8/fLKSY7iamBrfVIk1WB5Q/WhV9e/8/3gEU9ywdem9rprmKYw7eDvco
	 jEfD5PN1ZV5a7FuODCXkeluH8eKWAdlroGTAvuMEKEhRbzNJcuCNDykkAppT8lCIqq
	 Fvk6MNG1sVZS+v5y0ITI6WZKqH0SlUa+NmZvhG7wKZWSSiUtl+td4CXhKPtB2+kQVR
	 1Ob33AGyNw+b9JRY9LrJRzoqZ/tS1tTw5qdaRo9+eNyblMqxJHvg2vZDaTsdoOLisa
	 hdUjCtGrXxmjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1262CA1012;
	Wed,  3 Sep 2025 20:30:01 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Subject: [PATCH net-next v4 0/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Date: Wed, 03 Sep 2025 21:29:47 +0100
Message-Id: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuluGgC/43OTWrDMBAF4KsErTupPJJSuaveo3Shn3E9C8tBE
 m5K8N2jGAIJhdDl4/G+mbMolJmKeN+dRaaFC8+pBf2yE2F06ZuAY8sCJRppEcFrqOEIboYpGsi
 lwsDpx3FFoINCr6MdjI2iAcdMA582/FMkqpDoVMVXa7wrBD67FMYrfuteJ8fpuhy51Dn/bl8t3
 bb/zwNLBxLQWDRRWhOD/3C5SW4f5mm7u+C9ZZ9a2KyDUbLvPTkTuj+WurOUfGqpZvVS4kBBvWm
 tH6x1XS8G+lWohwEAAA==
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756931399; l=1860;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=GaOBbZnTDqpis7Ev0gz2xVSYm843uhg9SOiJBrzjv1o=;
 b=xgsWuaBHcG5YI0JdO0N3FP0Gj+K+NNIq8fKh5IJohqY7fNyBFNy40ytX4FHb0yDmXgs8yWgWm6Sh
 3Fs4iH/pCU5BexSd8Te9xfvMI0lTaN9y/2aMe6eKdisnCJbuir7E
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

On one side a minor/cosmetic issue, especially nowadays when
TCP-AO/TCP-MD5 signature verification failures aren't logged to dmesg.

Yet, I think worth addressing for two reasons:
- unsigned RST gets ignored by the peer and the connection is alive for
  longer (keep-alive interval)
- netstat counters increase and trace events report that trusted BGP peer
  is sending unsigned/incorrectly signed segments, which can ring alarm
  on monitoring.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Changes in v4:
- Remove struct tcp_ao_info::rcu as it's no longer used (Jakub)
- Link to v3: https://lore.kernel.org/r/20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com

Changes in v3:
- Assign NULL to md5sig_info before call_rcu() (catched by Eric Dumazet)
- Link to v2: https://lore.kernel.org/r/20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com

Changes in v2:
- Fixed TCP-MD5 ifdeffery (Reported-by: Victor Nogueira)
- Call proper destructor for inet_ipv6 (Reported-by: syzbot@syzkaller.appspotmail.com)
- Link to v1: https://lore.kernel.org/r/20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com

---
Dmitry Safonov (2):
      tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
      tcp: Free TCP-AO/TCP-MD5 info/keys without RCU

 include/net/tcp.h        |  4 ++++
 include/net/tcp_ao.h     |  1 -
 net/ipv4/tcp.c           | 16 ++++++++++++++++
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      | 37 ++++++++++---------------------------
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 net/ipv6/tcp_ipv6.c      |  8 ++++++++
 7 files changed, 45 insertions(+), 45 deletions(-)
---
base-commit: 1d8f0059091e757973324ae76253c2c059e0810f
change-id: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



