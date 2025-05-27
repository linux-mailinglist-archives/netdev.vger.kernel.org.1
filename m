Return-Path: <netdev+bounces-193661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F1AC503E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470943BBFCF
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1856275878;
	Tue, 27 May 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aZ4j5MFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE42271464
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353976; cv=none; b=P482mKL9NYuRWOL7EBtXwNXuIIp+arNHPrC2XA9Ih0xrOspk4s2OGMj8KxKN25wZ9cTp9NYkERJP3H+lwkqUl1npOYsEJRJWTuhsZ68PfBn2xLPPbfqN9LKIipoR7i83Po+JERrjxVGmSwd0ftjvIxVnH5UTktrbCKRiNB0FkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353976; c=relaxed/simple;
	bh=5ObGA7Q+NFOpwaFXvk6EpfvselNFpqlOnbQ83QqwFpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5jM+sXEYMkcRkk5hyoRJh0Oct8/6JxKOcF/Cml/8QfCwWfw3YpQX3uI4acitH3fL4O0AaL5J/IuUCTTtfv/bQQ16wwd25QkOuKwDzkLo6oFf0oL6cyB7XLNY6oitQVUsh6pjm/6zd7LSSraevcAb93dTw38RYnUgm39NGgNTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aZ4j5MFQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441ab63a415so40501315e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748353971; x=1748958771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d04peGyLVSSzpp0Fgxh9yhLMuMOkwIJUEECCRgcgBMo=;
        b=aZ4j5MFQoCiQ+JcK+EWYD6tYSJ/NBJiHxiQ7Daq7I8gjLAi8IUHaSKzcoCiZ+wPLt3
         S/z8+Fghqj2S1aLbTFSDYWLAhdp9Ma+ZKHNN3NschdPf5mhS96gMNg0joJs2FXtNn4H4
         lQqYXQba0Y4bEjt61MW0ZuHn8jjx1K+y/e4Nrs/jjI7oxbo8wmCEmbAZ14xEhCTP4Ktg
         pNONxxfoaBENaiBD3pbNDv1kjDEC71gU2VoBZaHmZECfVIzKI24H+Oibw6GPHNYmv3AH
         QtuVRhgdNtvYMENASnzUxk+X7eS5CkJ7XuwWK1eNGV8J4Sv9Io0nb73H6SekT8ekK7WZ
         ICHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353971; x=1748958771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d04peGyLVSSzpp0Fgxh9yhLMuMOkwIJUEECCRgcgBMo=;
        b=eyrFpG1Jmxxn/INpr6SOe5oxcN4kq4Ae7Y5tof1/6o7Qiy02VJwyE+VoTyPvKQG4Hp
         XHHCPzxbiGuz1i8f1lfXTAd96+Zub1aDrYZp+Vdgx+0vTQYZQnJ5DOqUmbJfwpDMWt/5
         YprEL6K+dDhbQmgO1NUUtMrM27RNSK1/8dhnJdVRJWNRPzaV4GqAj91Spl2p8jaoOxpB
         mOIAp08CfNBBfOFXNMVOy8n11sfyXleZsluqcBXI08Vtb07sLxYstnYAvZ/Z/t0MqVLe
         KzuNZMHGXmKIhxR615LGzZ5j6HiTp8CUYxIG5bI8WiIVKEzl70dIiyzBj5U8Gndq/t67
         j0Vg==
X-Gm-Message-State: AOJu0YyMMNeRmgw7sOrw+uDn6Q0bALU/UCTYndfHrrjNR6OBuvd/N7y1
	0+bummCk3eOuC+cw78uViHFb1QQR4JNwAEZJPNT6ymEnQoVnB0YZa6/qYuF+4JCTSosKxcuvf89
	fRoN65YYcC6vzQ25L/4heRFzEkL6Tp548FUTXuFR3X7/no3xMRqHAZhV2Mr8WZG9V
X-Gm-Gg: ASbGncufml4zVXg1ODts4sF7S86tpk2iV60V5wR2YSCPMxoT1RbZVUacM9HmxC8Y+U1
	+6LP78B6CZsaelajh12T2nAyVfaO2dxyrMkiFJbg6l9lpAr1k/a164RKUOiWCTmScqE3VDUk8ue
	AYz8wS3b0hKi0cvQ1kKFAG6tG3SlnMmbxFrlfl0STshk+EyovkNUG0BpHzBM2S+Pb2v7NvElvcI
	rVar72pCw82t7SOEgnQVnX/S7MLxN/sraIEvaH6nD+Th7SvR73F7iWZYnDgYOPMcw3medFitUZN
	7fKqhOnFBpUOzJp9R1uTkL9+/Z7f/gjg+MadLSWS67nGOuxLEpSHqmek/RPjFG/JsBnxFd9upSw
	=
X-Google-Smtp-Source: AGHT+IGGQpzrB3a9/4Uv6ahXv4efXK3WxlWC3azLP7vKSs9ws7KQ6YMCJ6AvzY7IVXNQf2F7Pqofcw==
X-Received: by 2002:a5d:64ee:0:b0:3a4:e2f4:a856 with SMTP id ffacd0b85a97d-3a4e2f4ad10mr2330337f8f.45.1748353971311;
        Tue, 27 May 2025 06:52:51 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5803:da07:1aab:70cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm5387719f8f.67.2025.05.27.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:52:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] pull request: fixes for ovpn 2025-05-27
Date: Tue, 27 May 2025 15:46:16 +0200
Message-ID: <20250527134625.15216-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi netdev-team,
I am targetting net-next because ovpn has been merged to net yet.

In this batch you can find two major bugfixes:

Patch 1: when releasing a UDP socket we were wrongly invoking
setup_udp_tunnel_sock() with an empty config. This was not
properly shutting down the UDP encap state.
This patch fixes this misbehaviour by implementing an "undo"
function called cleanup_udp_tunnel_sock() which properly
takes care or unwinding the encap state.
Implementing this function required some extra changes to the
udp/udp_tunnel code, especially to avoid race conditions with
udp_destroy_sock().

Patch 2: ovpn was holding a reference to a 'struct socket'
without increasing its reference counter. This was intended
and worked as expected until we hit a race condition where
user space tries to close the socket while kernel space is
also releasing it. In this case the (struct socket *)->sk
member would disappear under our feet leading to a null-ptr-deref.
This patch fixes this issue by having ovpn hold a reference
directly to the sk member while also increasing its reference
counter.

Patch 3 and 4 are instead fixing minor issues in the ovpn
kselftests.


Please pull.


Thanks a lot,
Antonio


The following changes since commit b2908a989c594f9eb1c93016abc1382f97ee02b1:

  net: phy: add driver for MaxLinear MxL86110 PHY (2025-05-27 09:36:17 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-next-20250527

for you to fetch changes up to 545e4c173cf94b4e5bbfe8ee09de2fbe556bb75a:

  selftest/net/ovpn: fix missing file (2025-05-27 13:50:50 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* dropped call to setup_udp_tunnel_sock() during cleanup,
  substituted by new cleanup_udp_tunnel_sock(), which
  required:
** implementing udp_tunnel_encap_disable()
** implementing udpv6_encap_disable()
** calling udp_test_and_clear_bit() in udp_destroy_socket()
* fixed race condition between peer removal (by kernel
  space) and socket closing (by user space)
* fixes for ovpn kselftests

----------------------------------------------------------------
Antonio Quartulli (4):
      ovpn: properly deconfigure UDP-tunnel
      ovpn: ensure sk is still valid during cleanup
      selftest/net/ovpn: fix TCP socket creation
      selftest/net/ovpn: fix missing file

 drivers/net/ovpn/io.c                              |  8 +--
 drivers/net/ovpn/netlink.c                         | 25 ++++----
 drivers/net/ovpn/peer.c                            |  4 +-
 drivers/net/ovpn/socket.c                          | 68 ++++++++++++----------
 drivers/net/ovpn/socket.h                          |  4 +-
 drivers/net/ovpn/tcp.c                             | 65 ++++++++++-----------
 drivers/net/ovpn/tcp.h                             |  3 +-
 drivers/net/ovpn/udp.c                             | 37 ++++--------
 drivers/net/ovpn/udp.h                             |  4 +-
 include/linux/udp.h                                |  2 +
 include/net/ipv6_stubs.h                           |  1 +
 include/net/udp.h                                  |  1 +
 include/net/udp_tunnel.h                           | 13 +++++
 net/ipv4/udp.c                                     |  2 +-
 net/ipv4/udp_tunnel_core.c                         | 22 +++++++
 net/ipv6/af_inet6.c                                |  1 +
 net/ipv6/udp.c                                     |  8 ++-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  1 +
 tools/testing/selftests/net/ovpn/test-large-mtu.sh |  9 +++
 19 files changed, 167 insertions(+), 111 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

