Return-Path: <netdev+bounces-149824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A672A9E7A96
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610EB286F3E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC67212F9D;
	Fri,  6 Dec 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bf6b9jv6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA9213E9D
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519925; cv=none; b=AOuQTQUCSHaJc2T0SawUdBM5ekUoDfiEZskkghB1n6gEWorSwQ6MsmP6XpUD1eYetWTLboq8kTjouH/EWaRF/U3aGboZZjSOrvCFiQpOQgVQqVfz9nypQAUf+/TMksFb7zpxWW2alPKMCLNQIPbZXRswEZeNYXoAToRMi8LFp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519925; c=relaxed/simple;
	bh=MvEsVP8hXCtCrw4UungUHRRmCT+a8bDAC62gOJ5+jCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=owVv02S+HQ/NALb/lISHn3IkNmTimW+fIH+VCXm6MYq9aJRhz1lZQYyFbwAcBT0Yzc0O1pmlR+zV48PxRWZMjUN5RoGQCbtxXnGB4WlZM6s5qjbefvr2MsMAcW5bhpDU856jTOcjNjgbkrzOIvQKGD5bCq/fhIvX+10crncTvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bf6b9jv6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so24856035e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519921; x=1734124721; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6k/HtafWG23ZRD5P+kbSuayenytQx7oGP+nNIqq90nQ=;
        b=Bf6b9jv6HSRJpRkXpsNVonp8O53t7kKC+vCYa9cerb8aPBEB89UlM2waINoXYCO+oE
         97+3KsjDrjaQiLUDpd9+EvUfXLRblAso23JahfDUij6dOnGWI441Sfv9fy3Wi94wKSF7
         v15X4JUVqyElx7rbbCABmcgegxYCcTmXr+yR7a+fu8jhURdbMtH9sMEuAqVXdRJcGHyX
         x+zOsfhnGCvQUIoFY46pC2kfZR3Jvk9o7NtXcDR5h0k+zWAvhCxaKnORqi7WafCSifjP
         EZCwU8vzpKiGU/M8rHc9jE/vfHsy2IH/SEbXeLUmwRdR36NaBLp1CKIY+5rz0Cs9coPU
         stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519921; x=1734124721;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6k/HtafWG23ZRD5P+kbSuayenytQx7oGP+nNIqq90nQ=;
        b=YPxwllEakTJuiB2oZJ5i8iNg2RTTee4lUnsn/V7Rkn0QQmHsgxaHa5m+6pxNA2J//4
         9/eRzcBnwdOvb5/VOXGVwHCR/DgOmSwvHldxNArsTTK/vqLefHNfgF7jHGFrLXKios5O
         pLgbbxH/XsgFqtJPo7GcTkAx99eODWP3nhZ6Fu+5NAqkAMCmpUzOM2DSu2/jvoDVYgNv
         o/Ym/y+EK6iRQ1Je7bnzODuj8xQmEMsibzG3UKGZLc1RAicdCIiJj7Bq5JFrW1YUO6ta
         mh8SwqoAmscAtUpb3f5wCmpUu9zsXyRGsrOe32TL1zYvfUxeYQVcs71312ogzzHdCQLs
         XYMg==
X-Gm-Message-State: AOJu0YyzwtdFYOqbyhVyQdI44VU8Jj42/tA844CxC5DQ68pVXh+yv4Ry
	ujWq4QReLuvmJDQMZMWKdOS6As81yENIBdXACOMCdpVWXn7i5pbHwqjERxSmNvM=
X-Gm-Gg: ASbGncupx6BdkEORaYyHFIhYhv3qcMl7MtLPs60eFLK+cc0m2tgqIvhEnfUsMuocQ0C
	r0niiLFvatNVjh77VR3dKgt6O2pVWo8k9nbOfoLcF5is6MpRs+8vk23lzz9lyQ5Stl4PeQU8QZb
	8xpvcBFxW5hCPdFTF46UCRSTEzwUbzCJZLEd2nXx2b8xDv2ugsOLDvt/aLGzAzU5Vyi6fgaqVac
	OnpGp/XgNIfMU4zdTtTO0hg598r1QDXuvoxGJfAeM/SLuU69HNoD5s3A2ALTg==
X-Google-Smtp-Source: AGHT+IFDY/ChlRRet2udJDnpbbaiDJ4ri2B5rp7bJ8kjyZyLEYYPwJawwVeoS6Qj9j8w2o2qmPqOpw==
X-Received: by 2002:a05:600c:4712:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-434e29f0392mr21307065e9.5.1733519920887;
        Fri, 06 Dec 2024 13:18:40 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:40 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v13 00/22] Introducing OpenVPN Data Channel
 Offload
Date: Fri, 06 Dec 2024 22:18:25 +0100
Message-Id: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFqU2cC/23QQW7DIBAF0KtErEsLgzEhq94jymKwxzWLYgssl
 Cry3Ttx1caqwg4+bz7iJgrlSEWcDjeRqcYSp8QbbV4OohsxfZCMPR8IUNBopUCGRk51TpJ4Gdu
 1vkEQfHvONMTrNuosEi0y0XURF04CFpIhY+rG+6Tf7O0TY7rLMZZlyl/bG6rf/E+bbv/aqpdKI
 gbyPYDF3r5PMyVOXnnc1lK12lGwD6oV23B01ijnXCD3xOq99Tur2fbUtP7YOYPwrBceFnYfxAF
 bMH4YnDFh8P9613X9BpH7CeN/AQAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, Andrew Lunn <andrew@lunn.ch>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5981; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=MvEsVP8hXCtCrw4UungUHRRmCT+a8bDAC62gOJ5+jCM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pROou47psABErvdKXTO9Z6JS9m/QOaAe69Z
 oOtAMMSW5qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqUQAKCRALcOU6oDjV
 h+q2CACNUdLXY8S1PhZBAH1mR0ST4Ya/8hHqYW4LK2CpM4SuhlDxa9ZhX99mwYAEy632uVArblJ
 FuAAEHXxDqf8JZKB+WnT7icbTJXCy0DIoWVMSoUHdY70CmRjsZpV7y16PkS/cGlv5pGvXKLlcZk
 l3pGS8VpmJ3vp7SrBIOb1PcBG9huwvETGHYZCdo63D9Pus1/vctXTnSLVoZVWTyKDV2vm3Wym3n
 c2ZUbmQ8msvazJdRIDkOj/xyhv3JXerYPXA3VGU2Mrh7LbykdgD1QCd1Jzbu/ycx5fH5dALxEhU
 cyWl3Jat/Q1CAe2NyKZMV6a4VqI3SNn0shsMCcGtoSfHm3NF
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v12:
* dropped extra ovpn_peer_put() in ovpn_peer_del_p2p() in case os
  mismatching peer
* ensured ret is not used uninitialized in ovpn_udp_output()
* dropped useless call to skb_probe_transport_header() in
  ovpn_netdev_write()
* used rcu_access_pointer() to avoid rcu_read_lock/unlock in
  ovpn_peer_check_by_src()
* moved TCP ipv6 proto and proto_ops creation to init function
* added EXPORT_SYMBOL_GPL(inet6_stream_ops) in af_inet6.c
* added comment for barrier() in ovpn_tcp_socket_detach()
* dropped call to barrier() in ovpn_tcp_close()
* deleted ovpn_peer_unhash() and moved content to ovpn_peer_remove()
* fixed clang complaint with ovpn_get_hash_head/ovpn_get_hash_slot
  macros
* fixed deadlock on ovpn->lock in case of TCP socket error while sending
  keepalive message. Fixed by sending message via scheduled worker,
  without holding ovpn->lock
* get rid of ovpn_peer_del_nolock() and directly call ovpn_peer_remove()
  when peer expires
* used local variable to temporarily store new socket in
  ovpn_nl_peer_modify() instead of peer->sock directly

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
 drivers/net/ovpn/io.c                              |  445 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  212 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1180 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   57 +
 drivers/net/ovpn/peer.c                            | 1266 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   58 +
 drivers/net/ovpn/socket.c                          |  180 ++
 drivers/net/ovpn/socket.h                          |   55 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  578 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  398 ++++
 drivers/net/ovpn/udp.h                             |   23 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  110 +
 include/uapi/linux/udp.h                           |    1 +
 net/ipv6/af_inet6.c                                |    1 +
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
 50 files changed, 9591 insertions(+)
---
base-commit: 152d00a913969514967ad3f962b3b1c8983eb2d7
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


