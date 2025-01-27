Return-Path: <netdev+bounces-161183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE271A1DCDA
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F8D165994
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FE192D86;
	Mon, 27 Jan 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkHwJd+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F4192B90;
	Mon, 27 Jan 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006832; cv=none; b=gBAthdRWj87Fu9aMihpgRggm4NtzZS7+XcnMLpZPbIlJ7tsUdfOso1kf0DKV3cObH9H6ULtr0LU1f9AJA6fDlFS1ln04o5OlOmbex82+K3RR5Plyl5FJ/YI91Tg6zhmnD07feMDL4aczv2ZG7xkpdNYBclE6OXxe472V5DPdVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006832; c=relaxed/simple;
	bh=5jtLs1i7S3dZ5uIXzUItrLxOX3xPIPCAJfBKDbR8lKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1j5Bd131BJl8B3HpsZTsJwjLvHuqYZaE7H6HdolNUp7H2u9sOgWnGdOpmHUcWirrN2gpi9U/aI792AUO47nSdE34lkCFALyc2kJ3jX+N28P3/OkcLL2rjSm0i9hcH03Z+2n+fQJ4KZmZBR8tDEVGCTITxEHOJVLKO+lHzafkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkHwJd+2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436a03197b2so32461495e9.2;
        Mon, 27 Jan 2025 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006828; x=1738611628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUwdlp/yXLL4/N9uiP9aQ9L9sfczO9WfCZpZwJKm/3M=;
        b=OkHwJd+2h+Ia9H/jIetPyuR3U/VXOzy8tCWv/5XfCD8lttoYHbQSW9rJoXHP0jw0BQ
         3Zc9gHg6HPBVy3T0GIzN+kgYhWjyOrtjMDPxUafnQRTgEooToGdJ2zKC9gJ9uixuVSfJ
         gCRKLAhE74qol/CtBeSwtD7QmLlS42JzdeFVRkNxggptXB6wG2RmmtSanLRaiFbJU4ns
         irTIG/ISF8UtsYpK9y/DeFmYi58QK340aorBanrtnDqOXZqeOJEn++Hj3OZICVqRwJjy
         3n6y8uSdM1MZ10il/XKj4bZl8dpJIa61vYC5YB/xpeRQryxsWkkGF2vssfXhy7O3XFp/
         fwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006828; x=1738611628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUwdlp/yXLL4/N9uiP9aQ9L9sfczO9WfCZpZwJKm/3M=;
        b=ppyjFVhe73RumNE/K8GzAvQgwOzWEBafJiP4ovctoWFEpzA4gc3gTSVv3AfTG3Iw0a
         gKnHybQv9lfgKqoFEhZ8kPmiwtI3Z1+96ye1E5Hf5EQhEb/RHZEoaanVJ43rYyLbuIUB
         KKM7fLh7hk+3DJh4hSZ0SAHvlfGaYsGG5Fg7CN8NxrCXjq7ODSFQKgVIfs5TXcemf20A
         tc+dVt8qNkdxq2XvOeZvR7XE7bIz/0NfV3bucVqUtTm0xn1qbX/s6dzltqP1wgdWrPX/
         ll/+8ih73pLXfC+joNCRMI4FZ3lfEFfG66WsiMcKWuX57zJsh9Zg+qY3D4wp3eOTndoB
         jGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMGpLtMThU58rG4PmdbRzAipSWLD2+L4Eq3rqgQ/2ysRmJjohdOzTN6x4dhJw2YOuNp0VOLwhBCgO1IJo=@vger.kernel.org, AJvYcCUxSbzsGow/hvvNji6bpaYmrWCQzSsAA5ILJoyUCk2UFittmfTDDn8Axot96yPM4sl/C9GElQbL@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNNyIvV6rs06mXX13/L38MH+ePyQDKjBjsAX0DFunOCQn8kv0
	yJCM7qC0VLjeqpVDzfMFLZIH5dRMV8WJqzYGSrtz8LPHurrY+EhW
X-Gm-Gg: ASbGncuKrIPs4crSPi0yanrV+3BCzntk6QOWdiTA2OhquxkEcN33A8ue1EaGvPAYlLu
	BKQ6rdlwejrLDiG13kSIRdS6vDtpv2sPXT0JGr77/dXi6JeSh9+JQqJoFkVA6WXf9df2c1+oDxw
	limyVD+yyIZqObTDzQAKNLiEXXRRl4n0RjY0okub019iiU8GsQMEAAXB/TJQm+QiFPf2ES802O4
	Oas7YHjG5CaucWA62G0HkROT9LUozPlEiBRfVmksJQiIQjdcO2Bl0G6R8VnCUV7DgzfnM7Qsr/q
	lzj2SDV4mvZyVjiM8LCJ7UjLziioakYSdRkuHpmli7naTVmhZ6UkV6nAaw3uwXq3requxLGC
X-Google-Smtp-Source: AGHT+IHoG/uZ67mK2vwzUGEIm4aXDfNkuQ2bWWNaRsM9tAFgYrAMffHwdLNTgXvppmkadePUzQObcg==
X-Received: by 2002:a05:600c:5486:b0:436:51bb:7a52 with SMTP id 5b1f17b1804b1-438913c9c93mr398025635e9.7.1738006828247;
        Mon, 27 Jan 2025 11:40:28 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4c6fadsm141031705e9.32.2025.01.27.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:40:27 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Lorenz Bauer <lmb@isovalent.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net 0/2] udplookup: Rescan udp hash chains if cross-linked
Date: Mon, 27 Jan 2025 19:40:22 +0000
Message-Id: <20250127194024.3647-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_lib_rehash() can get called at any time and will move a
socket to a different hash2 chain.
This can cause udp[46]_lib_lookup2() (processing incoming UDP) to
fail to find a socket and an ICMP port unreachable be sent.

Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
that the 'end if list' marker was on the correct list.

The cross-linking can definitely happen (see earlier issues with
it looping forever because gcc cached the list head).

I can't see an easy way around adding another two parameters to
udp[46]_lib lookup().
However once udp-lite is removed 'mask' can be obtained from 'net'.
'net' itself could be obtained from 'sk'.

Not addressed here, but the 'reuseport' code doesn't look right to me.

David Laight (2):
  IPv4: Rescan the hash2 list if the hash chains have got cross-linked.
  IPv6: Rescan the hash2 list if the hash chains have got cross-linked.

 net/ipv4/udp.c | 19 +++++++++++++++++--
 net/ipv6/udp.c | 22 +++++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.39.5


