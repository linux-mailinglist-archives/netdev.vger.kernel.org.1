Return-Path: <netdev+bounces-187723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34FAA9243
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F5B189547D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76571F582C;
	Mon,  5 May 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ir8kUvtL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E331ACEBB
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445523; cv=none; b=XP8s1RHZ6e512KcpqUwWgVX+CPzpHAyW+vQGexusXQ4NHUzBnmHv9dnqfXFm2oyofU/APzXv3yBzn2MHsjV9mMGsofUeSvswt+b/XqkPlUKo/8VFYiyz6koCe2kas9mh4OwBEYTlptEH5MJjpNk00koPvYLm2pq0guG+J3kro44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445523; c=relaxed/simple;
	bh=D1I/v0AhyF4l232u6+BbHTy9ZkqWolYzCYffnSbzQsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2qKZapvxdPMYUJ10CzZ1kCDTysirNuBC2C06QhBjX0+krY29Y/w+T/hoYt5uytgZ6+MeYEA6x40gZVigiNqARH/cOh7lS5qMhaG5a1icEADEab8GjMtOHeQs5QGdSvNJ8mc2RXwa27jsifePGW5kpfonjt2PsiZ1swenPOV8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ir8kUvtL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso28364795e9.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746445515; x=1747050315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBeejKm0uCObPcCc7G1nh36serNchoqoRBlqJIdKNyU=;
        b=ir8kUvtLl7f+cggnmNIOc47MaetxjO/S6gGAminDBJ4iMqhRhkc2AyB4EAAmMTVTqX
         FQdOCsBc0nvUwVRVhg8BNH7xUo/WaGZRx+BStCY3O6dOBrjq4phfJwYmyD3yJp3v7L4g
         ZtB5mz6vodieAzKmXl5siDoFZqSG0yhJKbsl247wr4Tz/Bs//e6wL/hmgNhPKogL6rlF
         FwTMGET86NR74TsFoooKYxrfOV6/omogV4vT6WMaDJ+Uw3NKGN/z2t+MxAAdYSU2W/lW
         RlKFMlvGcBneT23prhEFmx9bWvMEwz2NM7FchdSqG6EL6acus3BNeWWZGKjhtkj4bc1n
         7vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445515; x=1747050315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBeejKm0uCObPcCc7G1nh36serNchoqoRBlqJIdKNyU=;
        b=R54L4r9/6t3Ka9/hmjhMZ31zsBI0voj/80YPVuEGWIJ9rtVJJYs8mk6TczKApIwn67
         +6eg5TQBDZuD3y/IKLVwuQbbFjIhQPUS+d1hHQopUyM5RCeYZn8hQfuhtzAGy5GM4U3t
         uCgIGrFvU2FwsUnKzYDiCdBumP+x3ElUyuNwo0kb4bb2dgEkLHzweMKE3pi3RSW8JVur
         SE5BHrABSxyn6Ql12H4Ic0BEKqs1kDq65+AI5BQdkHxXpgiY104yUva3ADM4P+N6L+ii
         VIQ3cF8jXh+Od+yYOmn9HCF+je8RblZCsEzefoUqTOAR9kMi4STRvhtsJyHutrT4wQDP
         Scog==
X-Gm-Message-State: AOJu0Yw+6fIbmGvDytNQbxxbZ0mDUXhz78krS3ymNify+l2HPRndFJ8f
	trsExRpOq1/KW6ufUX2i9bDJpqvgeVjB+FZoz4U0JMSwlA1hFo9hXylWuCdjAkaN4Jht22RGwHN
	p
X-Gm-Gg: ASbGncuJ6kbsGMYS3SLOL0j3iVdoWfPxWVhxw0PMULU38mu8yyox/bRNYVcClsXTZW9
	5ONRwNZxLEcR5/Fk+vSOm0+U9ZmN5n51H+kAAr/uvXW28Kj/zhJ2mblewiCypvgC9WQvGezBxqI
	8cIFMh7GfpX675Od2taE9GzXoeR7ILFFenIa2+Iyg4Q2nxRaek27UPfKrdtVBfKG3DzcHUP82js
	eBd1pR3TPE5/OYmCu+FkDrd/FQvAPIxh+FEykiK8XyQPxj9ZM6QaQmm4kFw/M/S397mgB14Kjj2
	8N6ZYILi+uNt5O2ZGYiwrF4tBMgKCH2fL6pthjVCJ0qhmpffluGjKrOkBw==
X-Google-Smtp-Source: AGHT+IHTTRqZJbaHL3LguggAHQNOzEqddbt+20dHbCgc+Fh9iK9T+iTNvrkQWXQ460uWN3Ud4i5QeQ==
X-Received: by 2002:a05:600c:3e09:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-441c491fce2mr49230965e9.20.1746445515170;
        Mon, 05 May 2025 04:45:15 -0700 (PDT)
Received: from localhost (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8992b4csm134278445e9.0.2025.05.05.04.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:45:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next v2 0/4] devlink: sanitize variable typed attributes
Date: Mon,  5 May 2025 13:45:09 +0200
Message-ID: <20250505114513.53370-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This is continuation based on first two patches
of https://lore.kernel.org/netdev/20250425214808.507732-1-saeed@kernel.org/

Better to take it as a separate patchset, as the rest of the original
patchset is probably settled.

This patchset is taking care of incorrect usage of internal NLA_* values
in uapi, introduces new enum (in patch #2) that shadows NLA_* values and
makes that part of UAPI.

The last two patches removes unnecessary translations with maintaining
clear devlink param driver api. I hope this might be acceptable.

Please check and merge to get this over with :)

Jiri Pirko (4):
  tools: ynl-gen: allow noncontiguous enums
  devlink: define enum for attr types of dynamic attributes
  devlink: avoid param type value translations
  devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg

 Documentation/netlink/specs/devlink.yaml | 24 ++++++++++
 include/net/devlink.h                    | 10 ++--
 include/uapi/linux/devlink.h             | 15 ++++++
 net/devlink/health.c                     | 52 +++++++++------------
 net/devlink/netlink_gen.c                | 29 +++++++++++-
 net/devlink/param.c                      | 46 +------------------
 tools/net/ynl/pyynl/ynl_gen_c.py         | 58 +++++++++++++++++++++---
 7 files changed, 147 insertions(+), 87 deletions(-)

-- 
2.49.0


