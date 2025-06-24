Return-Path: <netdev+bounces-200561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A5AE6190
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF533A26DE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EBE28A1E0;
	Tue, 24 Jun 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="u8Glw/DF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3D27AC34;
	Tue, 24 Jun 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758874; cv=none; b=G4ONPF/yZN+oPHTAdsjMozpagph+GoDmYy5FxUEXh8Z+3Y+Hk7RWapliq9vUlOsISGXLrwgrKCz/QQWVAunfVmuCDo6RgrQVYkd6jaSskQBnph0iRf7aGzc8r0N5ihQnc9Uf0RNBt9HMt/1lTT5kQOEzI2JQYBqykUszXlmr158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758874; c=relaxed/simple;
	bh=h6b3Dvy0m1FF/YKgCnBBN4Es7WMUn/3ltvEA8B2lkI8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dFizEJy+i7f+TC2GeX78zsZqYhc42FHTliqxc9U7x32+C2uUEcRf5Y2ijSq5ElI97W0/ACydO5WwSGoP4Y73s8bX6IJ1YCGYe+oBLC2Cc+9zMPU381EQk0Vd+/H10WJ6pvwy9QqmKkzWVtjpqlaEiCxRLX5bcgNCOVWH+FAxY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=u8Glw/DF; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M7-00AvYh-Go; Tue, 24 Jun 2025 11:54:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=jBuOc98pgrI/yzTm/QMABM9kBiwU1kMFlEWq193r77E=
	; b=u8Glw/DFBwXcE460G5UOXstjbE3Ina9VfqabOnviDk4Rlvf9//0MKmR4R9Ml5b0ggNj4bz4aq
	DICbXAubLsufy2T6YJi7wX/qlmryyuubaEffAzOkqFDQqo6/Qxnoi1AkDCEtEnUWSfLlkpFmDBJdm
	WSsBUG6qSPSDdAJaQ9bEln5TwUfPraHGyiDxd3EUXQA3tuW1VmbuQSHteDAN6AYfafBBDZCkx0K9M
	v+VeKqqtBjvdvg74pDL+9x3VL1dYzMfNdtPOPxouGKu+brusYEi92+PkuWQWImILYr+seRnUAfHnE
	4I06AYDK5OXrHL0KuJR4EcHiRSmpk6qWFVRbNw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M7-0005ui-4w; Tue, 24 Jun 2025 11:54:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Li-00FYQf-MM; Tue, 24 Jun 2025 11:53:54 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next 0/7] net: Remove unused function parameters in
 skbuff.c
Date: Tue, 24 Jun 2025 11:53:47 +0200
Message-Id: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKt1WmgC/x3MQQqDMBBG4avIrDuQBCvBq5QugvnbDsgYMloE8
 e4Gl9/ivYMMVWA0dgdV/MVk0Qb/6Gj6Jf2CJTdTcOHpBh/ZyiwTONel8KabIbNDjxSTD0P01MJ
 S8ZH9nr5IsbJiX+l9nhdqOeEfbgAAAA==
X-Change-ID: 20250618-splice-drop-unused-0e4ea8a12681
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Couple of cleanup patches to get rid of unused function parameters around
skbuff.c.

Offshot of my question in [1], but way more contained. Found by adding
"-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
skbuff.c warnings.

[1]: https://lore.kernel.org/netdev/972af569-0c90-4585-9e1f-f2266dab6ec6@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (7):
      net: splice: Drop unused @pipe
      net: splice: Drop unused @flags
      tcp: Drop tcp_splice_state::flags
      af_unix: Drop unix_stream_read_state::splice_flags
      net: splice: Drop unused @gfp
      net: splice: Drop nr_pages_max initialization
      net: skbuff: Drop unused @skb

 .../chelsio/inline_crypto/chtls/chtls_io.c         |  3 +-
 include/linux/skbuff.h                             |  5 ++--
 net/core/skbuff.c                                  | 32 ++++++++--------------
 net/ipv4/ip_output.c                               |  3 +-
 net/ipv4/tcp.c                                     |  7 ++---
 net/ipv6/ip6_output.c                              |  3 +-
 net/kcm/kcmsock.c                                  |  5 ++--
 net/tls/tls_sw.c                                   |  2 +-
 net/unix/af_unix.c                                 |  7 ++---
 9 files changed, 24 insertions(+), 43 deletions(-)
---
base-commit: ee1a0c653f9cad7e2634a39f6c530e12edddf0fc
change-id: 20250618-splice-drop-unused-0e4ea8a12681

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


