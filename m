Return-Path: <netdev+bounces-75918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D350186BADA
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D761F23EC5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3372917;
	Wed, 28 Feb 2024 22:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DF1361CC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160260; cv=none; b=Q6aLJZ5M65A6N328rUgnTNRV8/InXG2D12YgJE0OKiOyqTdsbS7yDk36SgrcwILhbMSgnY8Kh/q4gjn6YG3EhK4hEZEWBNz3CDFwAllzvPaSeK0ddFT05eWyobCh2zNpmn5p7wvyTOcJ/B0BHGNa+eMR26fcPljl+9h4L3e0beY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160260; c=relaxed/simple;
	bh=5fyca7Im6DJWqM0Nq1UEUP4OBBcKpECT4aRKU0cGVjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqnMIWXCDlXebSIWn46yTqa1yQ8QVF2HHgqHnhV+yTrFtlhcGq8BKuPuJI4q9bu9eb7GpQhEzV9lW5RpxVoqM67DldvXI8aixCuHv/odb/3BF/pd8R/4i4lwt6DwZw7E70CgAUZVpxgCI2+Q/mhHlF5X2QJsOE2BBpXF+W7Y/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC2F220004;
	Wed, 28 Feb 2024 22:44:08 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 0/4] tls: a few more fixes for async decrypt
Date: Wed, 28 Feb 2024 23:43:56 +0100
Message-ID: <cover.1709132643.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

The previous patchset [1] took care of "full async". This adds a few
fixes for cases where only part of the crypto operations go the async
route, found by extending my previous debug patch [2] to do N
synchronous operations followed by M asynchronous ops (with N and M
configurable).

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=823784&state=*
[2] https://lore.kernel.org/all/9d664093b1bf7f47497b2c40b3a085b45f3274a2.1694021240.git.sd@queasysnail.net/

Sabrina Dubroca (4):
  tls: decrement decrypt_pending if no async completion will be called
  tls: fix peeking with sync+async decryption
  tls: separate no-async decryption request handling from async
  tls: fix use-after-free on failed backlog decryption

 net/tls/tls_sw.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

-- 
2.43.0


