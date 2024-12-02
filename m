Return-Path: <netdev+bounces-148114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC09E064F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062FE280A00
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF6204F87;
	Mon,  2 Dec 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F/KR0jhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07611204093
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152073; cv=none; b=SYbmlQdbAEPNsnsAsnAW3V/cVVjJevyw0TnUAQSer2flXlrqwkez8i4EnFh8QhB5J38cUQ3dgukgHv6/JFr2OjD+B0Bkaa5JrxwNXZMfcofpEUr6L4pnpZ1s+RFT9LbG0HZ5q4ViSSfIWVvB3TEdPckz0ihEfzUl/s+9R0/5Q4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152073; c=relaxed/simple;
	bh=ULd7HLAMrEU7KV6BqeoOuhpswSv5u3Bnny0RKVYK8Ng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uMNngtSKNba+eXLTL2ZZfrXXL2qD4EDe1c0tVzYuOmBemUf+6IYfscG1G41tuMFXGfi+5L8ZpzFMe209FtH2PzCiDt/9OFzILVmJhgfrFLKZ+OyXJOZGgNLflF2+Zu7nO+TdmHEIOnYzEcDIw3ZaSODZ2y+3ilvRbq7ANTvJGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F/KR0jhZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1451811f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152069; x=1733756869; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Vd3gVYNjuhRJ+EkLKPYA3SrVkjNuvOGctsJlVkSZc=;
        b=F/KR0jhZCsKUSKSFoz8fuDH/mYR0durkaFIDYXAOKoVLtaxV9tpWZ28/L7gydQSzvg
         k9JHwMl+2w8H4V7vHFzh9hqQwkFNMSUdXi6Fo9EAFz+bxT4NhVrqDjtUzVNwGISxVSe3
         MIr4lynt9SQ/p3afkdBeYc57jpZoUBIZbvv16QL7ptoFTHqVg4I7u40fGB5D9M39MRaY
         i632a1Ustyh5s2kRZwxsZ6PwtxdPJumgHcwGMPGx+XJzAaxAhWD8XdEeWUCPKT/HjHkN
         ONwNw3EpdixCpEl7FpBkYNJth9RhVY6bNKWtIBEgsDHfjDHi8CmFZCUw7jMqx2Hq6RaO
         BoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152069; x=1733756869;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Vd3gVYNjuhRJ+EkLKPYA3SrVkjNuvOGctsJlVkSZc=;
        b=FltA5ySCNPnW/SPfysA9h3ODaXq1jcVfDxDBhla8vBJ3a6nUs0aV3+Fyripy0V6qyz
         3hZSTyNEVOTQUBVee14Ed65Lky7vlAk1wf4qgV6jquvY08G9c+qlaLhc8jiZ/iEulaJ8
         rwKRJZ+bE7DsoijI5NDgNBkBDYHzKGii1hGvj6KVvbOB44YiVNbLhAEZ69yRGszZOQVu
         MFhfb6k7fh8J8YrWa9BAN65tnfpMYptUlr3Dmo3M54xp6Q6rk0pLOlH6QLXAlyVZhxvc
         oyIn+tKbbKYRxXFUk5UYhOyVzJBXrC84a81m5b7D8zGxOl0Jftwqhp+JgxzirRtETWhh
         kbnw==
X-Forwarded-Encrypted: i=1; AJvYcCWU3p8xFJiZPy4H/BGR5rdQ8pYmNKdG3PdeMEMS6YszFoN/gUP0jdICDbiuEOx8Exim6jUmVHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnsP2Idhb8Mzd7H0IQ7RhXIA9e/onyiiZPCbHxD+VSAF++B3z
	u9rXKaCT/mRqkibBclDdLcc5rogJ+A70U2myz5BpcTpRb1O6Ypl7Ki5O7efp3Es=
X-Gm-Gg: ASbGncsTZTryq5+1s/doNgS8Y71raLMaTarjfLFdwPdW8HzqzILZeNd4978YJ5Nkjxg
	gVJVyR4EutEJF8vNk0O0zoEUYbz9ulJzvNVHqHoP940xMXx4Vu3HTnenmEeF9zUx21YXRpfJ/ji
	tSTuWvHNYaejgaA4Fn4xoFnw6lWumWjMJ1hNP1E4ytqd16R2p/FIBWgX9N+fgIPi3onb2rFA/dQ
	dPdXNttf5a/y0mk2pC96PK68qLoTVFOmDlTLfSrUd3csfZ5p/2dhYN3N3U6
X-Google-Smtp-Source: AGHT+IE1uYOTAQ0IMw5NkWgDzQJ6v/yYNyBXMjiLK3pFzxx7xamPLm91YqcBWW5q4Jp56fgd2QVPQg==
X-Received: by 2002:a05:6000:178a:b0:382:4b52:ffcc with SMTP id ffacd0b85a97d-385c6bab0ecmr20106790f8f.0.1733152067519;
        Mon, 02 Dec 2024 07:07:47 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:07:46 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v12 00/22] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 02 Dec 2024 16:07:18 +0100
Message-Id: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbNTWcC/22OQW7DIBBFrxKxLgmMjQlZ5R5VF4M9iVkEW2AhV
 5Hv3omjpFbV2TGf99/cRaYUKIvT7i4SlZDDEPmh4WMn2h7jlWToeCFAQa2VAulrOZQxSuKpTNu
 4GkHw7zHRJcxr1aeINMlI8yS+OPGYSfqEse0fTa/scMMQH2Qf8jSk7/WG4lb+adPN21acVBLRk
 +sADHbmPIwUOdlz3WopWm1QML+oVsz6ozWVstZ6sv+wesu6DauZ7ahu3LG1FcIf77IsPwYAsrh
 DAQAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8057; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ULd7HLAMrEU7KV6BqeoOuhpswSv5u3Bnny0RKVYK8Ng=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1hiB9ATBpF0pj/Q883zgoCjJtMeRKvIVWHw
 CS8ODLAB3iJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NYQAKCRALcOU6oDjV
 h/04B/4/WGk8gs11+J7Pvs9EYOjDNT2oP9GIBG4svwm6iAHgIx/3lRVR2KQmklrXWWUNQPvmIXe
 5u4WBvNb53axTi2XiXaMfuN+FafHtLEhZWENz1Bl0jHmXtDkvg/Olza8TPbjLQXIPBA6ow9guXf
 EUdQi+6b2lIobbPIY3k0qo0Hwq3dP741aRoFVFlPAOxmHJETAtbIWkjrbxPDMYsGIwIHigNwAI/
 IFGT3YbubQFz9hAtPp0Ziej7YhE6uDsKGh7CvNN8WUnXV1tuqUn8I3l8sDKud+BQG+ymyDgkMPi
 E4nOjhrUhwwApXMCSfongzgzagMLtrFj3JYTiSL+KYpM6X+w
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This is the 12th version of the patchset.
Hopefully there are no major flaws that will require more resendings.
I am sure we'll have plenty of time to polish up all bells and whistles
:-)

@Sergey, at the end I think I took in all your suggested changes, maybe
with some adaptations.

Notable changes from v11:
* move 'select' entries in Kconfig from patch 1 to where those deps are
  used
* mark mailing list as subscribers-only in MAINTAINERS file
* check iface validity against net_device_ops instead of ndo_start_xmit
* drop DRV_ defines in favour of literals
* use "ovpn" literal instead of OVPN_FAMILY_NAME in code that is not
  netlink related
* delete all peers on ifdown (new del-peer reason added accordingly)
* don't allow adding new peers if iface is down
* clarified uniqueness of IDs in netlink spec
* renamed ovpn_struct to ovpn_priv
* removed packet.h and moved content to proto.h
* fixed overhead/head_room calculation
* dropped unused ovpn_priv.dev_list member
* ensured all defines are prefixed with OVPN_
* kept carrier on only for MP mode
* carrier in P2P mode goes on/off when peer is added/deleted
* dropped skb_protocol_to_family() in favour of checking skb->protocol
  directly
* dropped ovpn_priv.peers.lock in favour of ovpn_priv.lock
* dropped error message in case of packet with unknown ID
* dropped sanity check in udp socket attach function
* made ovpn_peer_skb_to_sockaddr() return sockaddr len to simplify code
* dropped __must_hold() in favour of lockdep_assert_held()
* with TCP patch ovpn_socket now holds reference to ovpn_priv (UDP) or
  ovpn_peer (TCP) to prevent use-after-free of peer in TCP code and to
  force cleanup code to wait for TCP scheduled work
* ovpn_peer release refactored in two steps to allow implementing
  previous point (reference to socket is now dropped in first step,
  instead of kref callback)
* dropped all mentions of __func__ in messages
* moved introduction of UDP_ENCAP_OVPNINUDP from patch 1 to related patch
* properly update vpn and link statistics at right time instead of same
  spot
* properly checked skb head size before accessing ipv6 header in
  ovpn_ip_check_protocol()
* merged ovpn_peer_update_local_endpoint() and ovpn_peer_float()
* properly locked peer collection when rehashing upon peer float
* used netdev_name() when possible for printing iface name
* destroyed dst_cache only upon final peer release
* used bitfield APIs for opcode parsing and creation
* dropped struct ovpn_nonce_tail in favour of using u8[] directly
* added comment about skb_reset_network_header() placement
* added locking around peer->bind modifications
* added TCP out_queue to stash data skbs when socket is owned by user
  (to be sent out upon sock release)
* added call to barrier() in TCP socket release
* fixed hlist nulls lookup by adding loop restart
* used WRITE/READ_ONCE with last_recv/sent
* stopped counting keepalive msgs as dropped packets
* improved ovpn_nl_peer_precheck() to account for mixed v4mapped IPv6
* rehash peer after PEER_SET only in MP mode
  addresses
* added iface teardown check to kselftest script
* Link to v11: https://lore.kernel.org/r/20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net

Please note that some patches were already reviewed by Andre Lunn,
Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
since no major code modification has happened since the review.

Patch 

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (22):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ovpn: implement TCP transport
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local UDP endpoint
      ovpn: add support for peer floating
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  368 +++
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   14 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  383 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  212 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1178 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   57 +
 drivers/net/ovpn/peer.c                            | 1278 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   58 +
 drivers/net/ovpn/socket.c                          |  180 ++
 drivers/net/ovpn/socket.h                          |   55 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  579 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  397 ++++
 drivers/net/ovpn/udp.h                             |   23 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  110 +
 include/uapi/linux/udp.h                           |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  182 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 49 files changed, 9601 insertions(+)
---
base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


