Return-Path: <netdev+bounces-237746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C5C4FE9F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99EC94E04E5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6B2594BD;
	Tue, 11 Nov 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g7Ut76mc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E48F7D
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897738; cv=none; b=FjnmZi7tq568F1aejq6Y29RbOfyLkPqRHVdnJTCrQ1W4A+pwQaWC8ETx5AiYGFTJTVAWvz4iUbN9Mxqkhk+gozXDZkAFbmMDTlhwob/Om0EvUq0IY4gEhlCjSegkjATOcEm0Z98uvKnxIhTJ682UzYb8JNef2W9W2s6UfVi95mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897738; c=relaxed/simple;
	bh=cSirjM1X1n+wUYGiQNqdfaExz/YFBU9pQKaP14D70Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XSn6w4Ex1YQAfsIWCTsYgu6qd/9QiPTM252uFfoecLkVHGGAug0zDCu3O03xgmtuLWB0QSs72SOioY0j8CEQh8sNoZxvILtJHFd2FutlDW1z2uzGbS9eDCunLPyWsQcCZseI7jGMwm8cS9GYauvrNuXOxnBZKzIi3v1O2c7iHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g7Ut76mc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47721743fd0so857955e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897734; x=1763502534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99I0QY8o6pjeeBILrMcxA44uCcF76f3w8I55qeCnD+Y=;
        b=g7Ut76mcoVo3dqW/PqsBrwae1umyflUUJ6FTJ/C4M5++2ii4T8/rOUEUUN4XlnZepL
         5g3c+UolqFlQXyZiE5cdu2RJ1oEux1hvjgRYqxQXWkjjeB6tzC4skp1D1jRGQ/DxT/oe
         jQ36eca9iCF3Hb1HxJJdBa68ExIk01yCstRgsnV96vM9n8bQcZ4DqGOint8RAdWcSciq
         iJdGvifEQVRahsXtjMXQNzsypYwziK/7uKEGgzoZd/OSGb996LSoPj9IAmQRIAlK7LmB
         r9vTk7wphKxlsfzJVC/sBGJsjMvgUh4hxctOkSSA4+3InIsDGPiYukD6qbuIjo7o8Kqr
         ktMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897734; x=1763502534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99I0QY8o6pjeeBILrMcxA44uCcF76f3w8I55qeCnD+Y=;
        b=VVDbaH1NmpLvCiVQcRNgcG4a0hoHJTiBgYppRahUlbi7JMUeYuhEDdicapeJQhotzS
         UgdxdHpAewq0EkC1tqkkFwhMtz/ujRKbcJch0MYxCBCbC26bc6Wwc4JH6EaaSKu+nxqc
         ZBo7Jj4AfNGnzn4a2PmbEJ0e16qkfXkZ+zAQwnEZm6caciblfJLznPWKOlLnn51l+rWe
         Ma53olb9lqlNvon+GJ1tHEI2MUSphzc3CjxAfiHZhE8MbqsU7JjRrL77Sb0E5kaRlavp
         jGqiKVt9hyaGzsttV9hsbTkcntr2Vr37+ZoF+NKLcTOsFJ8LqnLD4WyP4+HaPn9pt1XF
         zNcg==
X-Gm-Message-State: AOJu0YzEhm7w9k71RxkGqz/YLx3+uDbtYhsryoLrKI1Z4ypvDWUvnUFt
	a8hJIBRhkBBcr24+Y5iNsjVlyHnz2RaDbOXfQMBUNf2gkFFQ0QjXYVU94MJ0qULqtEpkqvBEHjz
	0ITDCJWGX29tM9wMubFg52mly3a5od/W1LDYwmwl9sxYclNb6dG4lNxEvLK1iqmGFrn4=
X-Gm-Gg: ASbGncsCwvTOTkkcNdGG3UHFy+9RxqZcseOEU2O12gwTGopPQnjrXeWQWbZXXbj34KT
	dEgkBbjDGK0EpLDpfdl9PNSgIBqurKaVkHgHmFaL/sBGQuH7c5yLyqiOi9OG60K44bqDw8q6XDU
	Ec6ZbKWO5KdJLUTw1sFUUbLTub+x0eki/gnVuJUNVeVO+oTdohG2TNIZOtUsnt7aXu4cFaejdkG
	SlPmg6B5myLwFs7bPGqjSBXSmODfMPHmN4fE6NWzGNIxJkSbpzGvJB7W+6BXMlJWROFp2W/LslU
	7xXKU+fIrffRQW1g1xUQCvGCXBt3wg/vh0idswmL9BZv01GK7gp1QIjrUwj+1AoAWE1Ome8GvAZ
	P/rnymL7BOfyGA3DUKYJawRl0zjsAuJljkasjYqYTwakrbeWVdbi3wqw/b+U9GJ8PKpSo0gT37P
	bjFX3KWSBMmBe6heAuaNACfWomqgNstqTk5HQ=
X-Google-Smtp-Source: AGHT+IFRMFOvCIaXvcxk6B9Fdp3Tx1sBaIFQG6KzIpYPOyiTVOfTmsJUisBxm482Fw40sERslUHSQA==
X-Received: by 2002:a05:6000:2dc8:b0:429:cdd9:807f with SMTP id ffacd0b85a97d-42b4bddeeeemr529518f8f.61.1762897734412;
        Tue, 11 Nov 2025 13:48:54 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:53 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 0/8] pull request: ovpn 2025-11-11
Date: Tue, 11 Nov 2025 22:47:33 +0100
Message-ID: <20251111214744.12479-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello netdev team!

After a bit of silence, here is a PR including a bunch of small
features for ovpn.
See the tag content (below) for the highlights.

Please pull or let me know of any issue!

Thanks a lot.
Antonio,


The following changes since commit 21f43f4a2b57cfeddf4e722d0969a85dd6185dcb:

  Merge branch 'devlink-eswitch-inactive-mode' (2025-11-11 13:17:57 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-next-20251111

for you to fetch changes up to 84623a8944c866aef670023d163cb6ae708e4386:

  ovpn: use bound address in UDP when available (2025-11-11 22:18:13 +0100)

----------------------------------------------------------------
This batch includes the following features:
* use proper len constant when declaring array in CMD_KEY_SWAP parser
* use bitops API rather than manual operations in pktid.c
* send peer float event notification (netlink)
* exclude link-local v6 addresses from RPF check
* add support for asymmetric peer IDs (TX vs RX ID)
* improve memory allocations layout in encrypt/decrypt
* honour socket bound device and source address in routing lookup

----------------------------------------------------------------
Qingfang Deng (1):
      ovpn: pktid: use bitops.h API

Ralf Lici (6):
      ovpn: notify userspace on client float event
      ovpn: Allow IPv6 link-local addresses through RPF check
      ovpn: add support for asymmetric peer IDs
      ovpn: consolidate crypto allocations in one chunk
      ovpn: use bound device in UDP when available
      ovpn: use bound address in UDP when available

Sabrina Dubroca (1):
      ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit

 Documentation/netlink/specs/ovpn.yaml       |  23 ++++-
 drivers/net/ovpn/crypto_aead.c              | 153 +++++++++++++++++++++-------
 drivers/net/ovpn/io.c                       |   8 +-
 drivers/net/ovpn/netlink-gen.c              |  13 ++-
 drivers/net/ovpn/netlink-gen.h              |   6 +-
 drivers/net/ovpn/netlink.c                  |  97 +++++++++++++++++-
 drivers/net/ovpn/netlink.h                  |   2 +
 drivers/net/ovpn/peer.c                     |  13 +++
 drivers/net/ovpn/peer.h                     |   4 +-
 drivers/net/ovpn/pktid.c                    |  11 +-
 drivers/net/ovpn/pktid.h                    |   2 +-
 drivers/net/ovpn/skb.h                      |  13 ++-
 drivers/net/ovpn/udp.c                      |  10 +-
 include/uapi/linux/ovpn.h                   |   2 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c |   3 +
 15 files changed, 294 insertions(+), 66 deletions(-)

