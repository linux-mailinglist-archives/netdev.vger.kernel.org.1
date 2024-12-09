Return-Path: <netdev+bounces-150075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FA9E8DDF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BFA188597E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661FF21571A;
	Mon,  9 Dec 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gOO8cSgY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5552156ED
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734383; cv=none; b=hNnCG7CjGsFa0pMxy+Xc+dhEbGbxF0vQXw4y6LZ+qDaJgbAmCcqqL5ZDG/8MhUaO8frwSoEQgECDgh0wljd1Sez3PI7TZdsewu2vpU0NFUzyXCaqw1NIh62zlrTKOe5GRlLrv1vU4/KCfiG11kvmUSGZmKjcBEkqKwbR9mf84qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734383; c=relaxed/simple;
	bh=RkDN0/Vb8fDj5cc6k9aNnBeYuln+qmKNXSoCz4G0uVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RXWKlIMjJx8Aamvvecp0CcKau0i66QK7ryB5XjMNu141lE6nPthoUwSC2alDdw3ioPevQ/NcEKcUrzByKfipWM7bKUyT/npIFgKD3ybB6o7R+dZHhDBljSLMz4iB+NztuE44NsE0/7njmoZlnLdGKj3fA4e5v97GKbwtCdUy0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gOO8cSgY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385de9f789cso3117005f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734379; x=1734339179; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eR7CIRiihnkEDc9vfsU2jeME4MDn3oB4Xk1lBVF28Dg=;
        b=gOO8cSgYHZuT86iXWfa+5KX5sZG1aGH4Nn1MdSJCuASKZV6DedL2IIVyG0MzRU7E8t
         46+IFBZwtxAKcQD+aGFIUelofZemnZBPUR+1E3j2BBg1bqkZGC4CKQw9Pdv9HhqGCR89
         m7GuMN9EYno6RdpQHCDqbpmp0LKjpxY6ML76hwLaOK1gfxc/6UhBLIvqmo8olLgezx4R
         B+S5Nz2vw/qNja2gxjm+r5C5wvE0WKGgQ6Hwb5pghI9u9t1oUNSiKXvxLFw2N2evaYI/
         dnizWDMEAzrzQP4q2Tejn2+NxOdVVtlgwfxdEGahTH5ptinv9Js+ZhSs5gGaWqUWKLEj
         QL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734379; x=1734339179;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eR7CIRiihnkEDc9vfsU2jeME4MDn3oB4Xk1lBVF28Dg=;
        b=sUHWQoutG3MleHKQEgMcJEDgPBGLBXZyxkFZ7lOhmsr2goexcVZO3DjOyXffofIcSw
         2IZxpwx20fYtuizpraQL630QYH65VjJOTGQGSuThizUcJxPhQB/6x8SZRTqB+UMxvtfZ
         frWgDWulGJzflwAuPT3osOt27Kmoz35fxorO26ss9KRiYV30NStGiDQw8HYVSaFmugd+
         ECKJqwEtpErcu1E8652Bj5cZWLK6U0b7fyYHqf4OpNTfcMUAbnTCzg/rQ0VkkEoKY2iS
         rbeNDIlRl6rWDJefi3ud0nZaoas5GTXhSbtC42h2veFvkzKOwp2M1gMc/6DYjTlkFtGu
         f1nA==
X-Gm-Message-State: AOJu0YzrTRSovzUf46SPJn1zznKpfDM3Kiz7dsLF2m5o2Dz8YopelMv1
	x6gAiCFMmZx92/PmGN6C5WxJps3qI5Y2XmyzxPW4iE7sgIioW9UYe5teYLVMhV7DyqNAa381QBR
	j
X-Gm-Gg: ASbGncsVwI4spaUv3xQQck7wIxw7Qf3rVnIK039tWZuK7FTNqOlr3nxzpJAIsg3fcud
	mTLnVQkpXueRoCIx3nyKiqOCgXfnnj6dtC03zO8680pRcnyNBdk7KSv6Ue9FGpMrCBZQwX2lZeL
	k5sE5WEFBoWM2VE7tYP4SCGgl3/aSP8arS4sdyNHbjwkxyXNuD2kIQF3u+BC7oAOnBkdr1AwvHJ
	kfmoZaegnqDMJ/SvtgwlN4Zfg9ck7NJa/oIZqQyb6sS62+1xwdinCVmL4Tb
X-Google-Smtp-Source: AGHT+IFSR8X+VYTzpQnVeSsBHsd9BHKmZdVPzboPMez7w5Klu9PNklx3H6O3O6LDgaqBuSilzHEgbw==
X-Received: by 2002:a05:6000:401e:b0:385:e1eb:a7be with SMTP id ffacd0b85a97d-3862b364931mr8712834f8f.26.1733734378726;
        Mon, 09 Dec 2024 00:52:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:52:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v14 00/22] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 09 Dec 2024 09:53:09 +0100
Message-Id: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPavVmcC/23QTW7DIBAF4KtErEsLw1/IqveougB7qFkUW9iyU
 kW+eyeu2lDJ3sHjmwe+sRlrxpldTjdWcc1zHgstpH46sW4I5QN57mmDgQAthQAeNR/XqXCkT5n
 Oeh2A0empYsrXfdQbK7jwgteFvVMSw4w81lC64T7pN3v5DLnc5ZDnZaxf+x1Wv/ufNmn/2lbPB
 Q8hou8BTOjN6zhhoeSZxu0tqxQNBfOgUpCNZ2eUcM5FdAdWttY3VpLtUVt/7pwKcNQLDwvND6K
 ALCifklMqJn/Uq1rbPFcqstalqCNaaxH+223bvgEQZ2NwuwEAAA==
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RkDN0/Vb8fDj5cc6k9aNnBeYuln+qmKNXSoCz4G0uVA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrASVSXzn1cotAscdJxO9+UUvicacz39zBOkU
 C9KKvYXe8OJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 h9QvB/0caCT2PDLTFMHRUt6gXQGwRnKeORFMmTSkbfq9HI/1Xf+arGqQX0ssQHHy45SzlxcEyaN
 +su6RdoGdX2rh4hzIeo0q/uzk855Guvy6H6Lg/KGl4D91CHU78egFx7YfdvKH/HsXTsVwApd6w5
 VIjzJFleqf7tKHx1DWwl4j5ym2ocbhqKKnl+k5nwc1tnCduwWEqOxaSF+MjbDxyXsatIXNIbY1e
 v79eq1oUonrv+SX0t7+XKYOlqC3KAvQF08IINIRnpi8ajn30lTckzY9/X6EaoCQzM4gAePfzovr
 6+0IQ9UQWMt/l02RkJh4BdL3U3ogjhIjRuOi7xycYA9ykxQL
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v13:
* included linux/ipv6.h in 07/22 to fix build on nios2
  (reported by kernel test robot)

Please note that some patches were already reviewed by Andre Lunn,
Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
since no major code modification has happened since the review.

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
 drivers/net/ovpn/skb.h                             |   59 +
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
 50 files changed, 9592 insertions(+)
---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


