Return-Path: <netdev+bounces-165353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ADA31BBB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E06167DEF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928161494BB;
	Wed, 12 Feb 2025 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAG8W6ZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB0126BF9
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326308; cv=none; b=SIU1C1HUoSMCRJ1Jujpz8NC1wcyHbLvUO5Bce4TMuEwmERqUGx4E5wi/YaSlt5Z1koHpsjrw5TNmn6l6hNo1TZ+CgSclbkgl2+eos2udQiEq7/pPgkMK3GdR3Fa295xUev1Fj6OZHZoTXH1iByB3KXzYNgO1gc1SrMqIarrBJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326308; c=relaxed/simple;
	bh=fkgttyqpGyqx970eloh12ylo8QaZ3x88sBaFwjybtk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAPalK0LifRkFMIDSBKZxQqJwcY0MLcatTO5ARrt6afNxKhSLWn02rdj0tYMPYgFHN33M5ZhtuT+yWIS/pz/H95GmpXdVB9ufj2vr/zK5y5Zae3ghy2ICh0D32suB1+40/kD4lPLa+oplw1FiCaHxPCi85RVfLfLR5QwlrtM2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAG8W6ZI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e44f9db46bso46319286d6.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326306; x=1739931106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fI9oMWOhJJRFSqN1J0MM+Tc/Jk7gnR4jwngxKgDHaSI=;
        b=TAG8W6ZIyFWQ1SHOgD8dcPzqgSoLP5MgF5yJwrthZmhdSR3SQbtFjEJJngY6a2hEd5
         4vp2Oae2IIHBRX0S3ue+L6Bs6uAAC188TrO2cuOfm21hnLvydXK2cK7lErD17slDAE6Z
         bcaaNNu9ZlhwFBYBr+fBScaiiP5RiS6Tzr/H6+NnnPThRhUK5UL1hoD5uUwrSPeueqID
         LzLbLqHfKX67a3Dj35oFzeQrC/yKlIdwdZHIGP0dl7e27R7TsJAgq3n8aUp4cKhGy1r+
         DQCsRuueZBnWkaeU7ETSUmpP+mVnHS6EhzhNGOmYRvUHiaRcip3aCKlCkHT8ZtbY1qFe
         DpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326306; x=1739931106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI9oMWOhJJRFSqN1J0MM+Tc/Jk7gnR4jwngxKgDHaSI=;
        b=rHxqwLDNsOIdEtWe+QYSoHCszovOGc2RtvwGwyanLx/6EnRXe/Pnl4lpn3ddwAtTMi
         eZOTvxBTX1L+XDWkkzc3CplL0x2O53APuP1QyrncV6Lul8aQLpu6ec8ieNrx7wkw7TG2
         AT5CjN6AABBwF3f1IGXpJlWH2aSlVABhZz6rJk8F6oswDsq18MtGqQDOU9hZyLaM7XkF
         P5uGFqT5JG6TvRokCvaRaWERj8ZjYjGnH06+omqT60fpdPwVkHYovbRlNtE8UOyPbZhp
         M5J3mJ7A7DbI06IFO4bWZHSZdCoQNZvsxC1B/Bhy/onzSH7ochHkDCzsw5V0TUnmZMgd
         n+Yg==
X-Gm-Message-State: AOJu0YwRLktFzQWokHqtPxEFUxdgsK5/gD65qkM8o2+9+FfahjrGNuHd
	O3uzxddMEolsAjy4wClNJ8P/PfeIObcWMMX02DxsSFGZMZjErPapbT+/cw==
X-Gm-Gg: ASbGncuwUrqeLEiZDbR62JA8CY5pOb8EAthGu5ecsFueu0KE7wmjAURoNL1hn/9CQW3
	3Y5TKHeVDkS9PIAinx9EYAdbV57kfGtDNTWx08togSI2JYiW8w5ppHrHFVukh+Fx5E+01mhQML8
	J1LZZPTzIDw9xDaaeDCHREOx1jOUq4reYZ5QGGGqlUrOaU4vru87QL9BXXqLyQ72zL4hcCtlUFi
	vpH9z2NjrQyFBm9+oJNVr/sEX9h3M5f+jbABgJXypzjeJb+z0lx3bSDy/xO2Iri3OzqIu4/o3zn
	9C3RAAp61X4NYldxhhrLEFREvIwAvyGUagJttdz4mP2ZTTydcljy1wDhEpqa9uE/EoVtvgQaZT9
	Vdn2DlGE9IA==
X-Google-Smtp-Source: AGHT+IFrge/uVk+ZKQ0W84gVppJ0J24aPU2kH+Ly86wA9wHrxzc0bOGF6JBger5W6LRwbtgr0XzYzQ==
X-Received: by 2002:ad4:5dc9:0:b0:6e2:4940:400b with SMTP id 6a1803df08f44-6e46ed82e4emr32345166d6.16.1739326305874;
        Tue, 11 Feb 2025 18:11:45 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:45 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 0/7] net: deduplicate cookie logic
Date: Tue, 11 Feb 2025 21:09:46 -0500
Message-ID: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Reuse standard sk, ip and ipv6 cookie init handlers where possible.

Avoid repeated open coding of the same logic.
Harmonize feature sets across protocols.
Make IPv4 and IPv6 logic more alike.
Simplify adding future new fields with a single init point.

v1->v2:
  - limit INET_DSCP_MASK to routing
  - remove no longer used local variable (fix build warning)

Willem de Bruijn (7):
  tcp: only initialize sockcm tsflags field
  net: initialize mark in sockcm_init
  ipv4: initialize inet socket cookies with sockcm_init
  ipv4: remove get_rttos
  icmp: reflect tos through ip cookie rather than updating inet_sk
  ipv6: replace ipcm6_init calls with ipcm6_init_sk
  ipv6: initialize inet socket cookies with sockcm_init

 include/net/ip.h       | 16 +++++-----------
 include/net/ipv6.h     | 11 ++---------
 include/net/sock.h     |  1 +
 net/can/raw.c          |  2 +-
 net/ipv4/icmp.c        |  6 ++----
 net/ipv4/ping.c        |  6 +++---
 net/ipv4/raw.c         |  6 +++---
 net/ipv4/tcp.c         |  2 +-
 net/ipv4/udp.c         |  6 +++---
 net/ipv6/ping.c        |  3 ---
 net/ipv6/raw.c         | 15 +++------------
 net/ipv6/udp.c         | 10 +---------
 net/l2tp/l2tp_ip6.c    |  8 +-------
 net/packet/af_packet.c |  9 ++++-----
 14 files changed, 30 insertions(+), 71 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


