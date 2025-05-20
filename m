Return-Path: <netdev+bounces-192090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99467ABE875
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376F74A30E5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F64A3C;
	Wed, 21 May 2025 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FRbsbLTD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED823A9
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786177; cv=none; b=gpAY8GZ9GSo/yuJHW7Qv85yHx92tFglNxr0syNWopiPY80WaX1klAnDgYtyZ+mqpNfbyRNlrO80QspsGlK5Jlm+nAkuukmzpVscPrBue4yz9H7EgeM1D4D2uzOJnu3asG+LcCclu3Df59eCAb8lEhwLkThrZ2Inh1xlnZMOdfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786177; c=relaxed/simple;
	bh=fIa5tB62kgfbF9o1oVT885eZwcOLVblGO+tyZLBYQ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sa05P2VP+ZMrZabdnI4WuhJ+Kbv4Ra6fAt3/Qo98RPS4Ai70qQcqC3rvxFTAwujJoCpNwj2VLyh59srF7jnR3iJHuxV5+0LUSwK38DeYl915uVnQGs1XDJuYOY3JhPd+8Nry6HoEBNf7RwcoCR+Gj5U2iTRgmp1Jeqqr+HOry+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FRbsbLTD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a37a243388so1203723f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747786172; x=1748390972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kv/6jnh4+oXKsp5KCTVI6X1EQTgxtma71uLaFS6Id4E=;
        b=FRbsbLTDKMp4n6T5CBbRyGwUzmwrXjjvjSeTcvOD01aa+ZimSPAZzAPEYA/Vcl/rLK
         PRHVyPd1buPEOqGaSOoCa/QH8WTKhRTsB+s/DbVdx9tVK8FaSULL3YkNycVET9TNcyUd
         9U6drUarSIIhpkeIF1RJ8l3FelAxz6u2DPb3lTaHfJYJpFTMdWwnl8LTUxEOYmLrMNaw
         zqtL3Wi/AVG4nUq0kMkRegabguwi6+j7arc5gwbYlpxSlEOJ9jUPHzK+9aqHePsqHORa
         adxLVgHSqShnUovEh1oTpQ+lYPTBQDZG27gWOOLcHGDFhAH/Upydjl5MSxvLmelJKpma
         i15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747786172; x=1748390972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv/6jnh4+oXKsp5KCTVI6X1EQTgxtma71uLaFS6Id4E=;
        b=UJuBvoo1iZfYw4X1ngs3aBYjDnl7P9TUmXufEP2/nrAZKg/eTA1GnuEgWBzUTf6SD3
         xbVif1RzPuakL65VR0Jk6X5XHqKn2XYYIH80aAod2k5muYqXMxLbwwzlsQV9iYaR2mx5
         UmgE4z/YAbdV3SBmd1JrW23zRybxe5SyMjkEOzDN7cp/tx64xGihCiYvGLNbnqyKMMTH
         gcN/pfGUgWAYZImavvNuvmA0NGCHU8FNv2sH8Z/p19VmS8V93GgDtijMaAjYpQMHGook
         JiWlKG+ESi6y1TjI6dnTkzNH7vL9au7VluTw+JleyWMHheGh91AgRr4CwwRvgl0Vg2FA
         6qBw==
X-Gm-Message-State: AOJu0YyOWovl/MgT6hR5QkJDKbWqatWM38RjZCzROZk5pMMKrJXqWSBK
	ZiG3NqbpdtO7QpG8r7A4Ikd8hqvfhiDoypqfPew+BkSBZHScellxksko4QC5aU0CibP7hhbOYEZ
	EVb309jSc4/zoNu0l3FMl2WSvoc89EvUWLc7TUITOLdExriyqPaaIukIacSP+ePod
X-Gm-Gg: ASbGncspPiTZb1MD0HFYo78E6pLxdkLMGeV3Lo9H0bzt/WIldr32TQj1+3spDCYSWiW
	hYPg2hHM6FxJL2CZwYxXXNuWicVnsUaqAaDZbpN3v7MawyMAr9EwdIxR+VBIVe4S2sBAbIxsy/8
	ZM6qD2JOHEodfSQXuigw4vs59OCQQVNiFvDAloTBvUaog7Na/PYoPf+8fVCdZQ/UQ1R9iwY2Ubp
	BiX0a3ocAbc5wMsaOn/AsbEmQd9pAaWyPXNzzeMuPaeeyHSbgAic5IrYhlXZf4MNEnv0XeBuUvA
	u72cuFXfIqmR8Mu63f2DSBixRd71KI6Jn4ppAyXMBY4XU7b4SljH0/E4x+44MIs9vvjM4FOuKw=
	=
X-Google-Smtp-Source: AGHT+IFh7cB27gYwLp02Jzw5+HALglk26sJSpAH555xrBoUO/5B9/qwv9bXnVDqPI9UeuQr5xZY62w==
X-Received: by 2002:a05:6000:e4e:b0:3a3:6273:802f with SMTP id ffacd0b85a97d-3a36273835emr14227889f8f.14.1747786172537;
        Tue, 20 May 2025 17:09:32 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:95de:7ee6:b663:1a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3620dbc6asm16625042f8f.88.2025.05.20.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 17:09:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 0/3] pull request: ovpn 2025-05-21
Date: Wed, 21 May 2025 01:39:34 +0200
Message-ID: <20250520233937.5161-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello netdev-team,

Here is (most likely) the last pull request for net-next for this
round.

Patch 1 substitutes a call to setup_udp_tunnel_sock() along the
cleanup path with cleanup_udp_tunnel_sock(). The latter is introduced
in this patch as well.

Patch 2 fixes a critical race condition (leading to null-ptr-deref)
triggered by ovpn removing a peer, while userspace is concurrently
closing the transport socket.
An earlier revision of this patch was already discussed on the
netdev mailing list and this version is the final result.

Finally patch 3 is fixing the TCP test case in the ovpn kselftests,
accidentally broken by the introduction of the UDP IPv6 test case.

Please pull or let me know of any issue.

Thanks a lot!
Antonio,


The following changes since commit 9ab0ac0e532afd167b3bec39b2eb25c53486dcb5:

  octeontx2-pf: Add tracepoint for NIX_PARSE_S (2025-05-20 12:37:37 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-next-20250521

for you to fetch changes up to cb4cc0e4a5d0ddb655f72fb9626408f060c2c15c:

  selftest/net/ovpn: fix TCP socket creation (2025-05-21 01:35:07 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* dropped call to setup_udp_tunnel_sock() during cleanup
** substituted by new cleanup_udp_tunnel_sock()
* fixed race condition between peer removal (by kernel
  space) and socket closing (by userspace)
* fixed TCP kselftests

----------------------------------------------------------------
Antonio Quartulli (3):
      ovpn: properly deconfigure UDP-tunnel
      ovpn: ensure sk is still valid during cleanup
      selftest/net/ovpn: fix TCP socket creation

 drivers/net/ovpn/io.c                       |  8 ++--
 drivers/net/ovpn/netlink.c                  | 25 ++++++-----
 drivers/net/ovpn/peer.c                     |  4 +-
 drivers/net/ovpn/socket.c                   | 68 ++++++++++++++++-------------
 drivers/net/ovpn/socket.h                   |  4 +-
 drivers/net/ovpn/tcp.c                      | 65 ++++++++++++++-------------
 drivers/net/ovpn/tcp.h                      |  3 +-
 drivers/net/ovpn/udp.c                      | 37 +++++-----------
 drivers/net/ovpn/udp.h                      |  4 +-
 include/net/udp.h                           |  1 +
 include/net/udp_tunnel.h                    |  1 +
 net/ipv4/udp_tunnel_core.c                  | 28 ++++++++++++
 net/ipv6/udp.c                              |  6 +++
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  1 +
 14 files changed, 146 insertions(+), 109 deletions(-)

