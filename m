Return-Path: <netdev+bounces-78149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C492987437D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6564CB21F04
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7451C6BE;
	Wed,  6 Mar 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9VdHQDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E61C6A0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766654; cv=none; b=m2yjBYnSrEiQ4X0XJ9BYc3MhVqRQJqRl0iDIOtzOqSx3ZM6I85066stZ4wpmKWc4iR5d9N1Lj8moKpfKfmjrO5BbU3MAzw/rSYvJBezqXUFUUvZtBkn2X6C0k4/Z/qSfWqr4r9DI1q0dLyzPx9BxAjeafr7JoAIMtVnsHUY8bQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766654; c=relaxed/simple;
	bh=hC8Wq7nCkFf0XLB3z5+Bxk/a4x6cq/HhcmyLFdI37so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEdmoHlhmxF9Jpp7Rm+SKx+OOC3znOBEagZM2E7eJ1bUdiIMMaNRiYqsxqkjdLNS6kHospgOed3Ydq34+uJqnGyW/jD+ifpvG9Z9zWILuMUj4OLkcA0LjBz3x46QD8nIuYEULqUIOsHHCZmIioKAxc/Ml+Q5nGdGgcWXEPvJL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9VdHQDR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d28e465655so2953881fa.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766651; x=1710371451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wNsPVmH2NME7We1G0cF37KoxsIHROAjALO7Hk7XQS0=;
        b=L9VdHQDRZq7g3DQZ9mrUY+atggn1r1YwvboxfOlq2Ogk0MV9sKuIyh++A3ONUgW3Y/
         AwbopRCfqbRyeRaufMtx7FXOGeCBXZcs0XGn4Ns2n7+aj6WVWCK9xuKKO8E9v1M3iALo
         fDNpDYxS+J64BDU5iIMwPhedsMgEumNWw3x7KhrwxsOSMPMxZzbhR9XLsWdWqoy2ckKM
         qkxGv6WF9bk72wnC3aedAdxn9EoYIFdldHZnf1OJr6BRsEM5LW+hJeAOJOotv3rFJaxb
         GD1Kp0PFOX2+ruQmxArAqcAESnWxPnET8B+hO92G+AVyN1HD9LzrI7bqm35PPGO3PqtU
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766651; x=1710371451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wNsPVmH2NME7We1G0cF37KoxsIHROAjALO7Hk7XQS0=;
        b=Wyc+ODnOxRpK5nynag4SyeqmqU/veRyaQUZFdY1bw1v4w6nP1HMU1imq4uKt8TAQO9
         JRRprfbv2s49v1yCby/dTCDxav5XpOTjNs4UYnZk1Ywn/EyOWahyhAhphq06RdPs5r6D
         d7N+hE0EnkWRWeQOWdcnh57aPv0/vzNI2sG10DDEcLrbew3qTSVNIwrP8NmyW5cdhVdn
         TsQr47P1HRKiPh9CbBUEN9MOCu8FOyIcv7vKvMf5IsT+GB6GAwEFb0B0chCoURent6Ps
         PsgsqlyD/AFAZhEuGckuilw9Y3U8qha9nZKQZkuUKNo/HdraKS9umV5BptzruINrlh8Y
         kblw==
X-Gm-Message-State: AOJu0Yz5XfEkHuOBLEZwRL6ZTjHof1CKC/heg2gsb4egvEssmv8R/kJ8
	3ms+WWA5Pl80FefEI7MVkCWeG58s0RJYM+fNcgwwzTULhE3kHOVeJ88V33dIKyI=
X-Google-Smtp-Source: AGHT+IFN70Ooy6xb5WvSBfnic0CHpFLgZJD+QUql0bXpu8Z4Dk1qrE00y5ZbTF4xFs4q3FShw1W+Ng==
X-Received: by 2002:a19:ac45:0:b0:513:5808:72f9 with SMTP id r5-20020a19ac45000000b00513580872f9mr280230lfc.56.1709766650345;
        Wed, 06 Mar 2024 15:10:50 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 0/6] tools/net/ynl: Add support for nlctrl netlink family
Date: Wed,  6 Mar 2024 23:10:40 +0000
Message-ID: <20240306231046.97158-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new YNL spec for the nlctrl family, plus some fixes
and enhancements for ynl.

Patch 1 fixes an extack decoding bug
Patch 2 gives cleaner netlink error reporting
Patch 3 fixes an array-nest codegen bug
Patch 4 adds nest-type-value support to ynl
Patch 5 fixes the ynl schemas to allow empty enum-name attrs
Patch 6 contains the nlctrl spec

Changes from v2 -> v3:
 - Add a better description to the nlctrl spec (Jakub)
 - Format all codegen names using lower-kebab-case (Jakub)
 - Add a patch to fix the schemas

Changes from v1 -> v2:
 - Added patch 3 to fix codegen bug
 - Removed multi-level array-nest patch
 - Added nest-type-value patch
 - Updated nlctrl spec to align with headers and fix compilation

Donald Hunter (6):
  tools/net/ynl: Fix extack decoding for netlink-raw
  tools/net/ynl: Report netlink errors without stacktrace
  tools/net/ynl: Fix c codegen for array-nest
  tools/net/ynl: Add nest-type-value decoding
  doc/netlink: Allow empty enum-name in ynl specs
  doc/netlink/specs: Add spec for nlctrl netlink family

 Documentation/netlink/genetlink-c.yaml      |  15 +-
 Documentation/netlink/genetlink-legacy.yaml |  15 +-
 Documentation/netlink/netlink-raw.yaml      |  15 +-
 Documentation/netlink/specs/nlctrl.yaml     | 207 ++++++++++++++++++++
 tools/net/ynl/cli.py                        |  18 +-
 tools/net/ynl/lib/__init__.py               |   4 +-
 tools/net/ynl/lib/ynl.py                    |  19 +-
 tools/net/ynl/ynl-gen-c.py                  |   2 +-
 8 files changed, 266 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

-- 
2.42.0


