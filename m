Return-Path: <netdev+bounces-178580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307BA77A32
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3048E188C1CD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828E20296D;
	Tue,  1 Apr 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/37PlTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C241F0E29
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508669; cv=none; b=YLsU1V80OzCUmIG+M4a5gKrHAV+PD7e1XDY8dt7NFnBWHzUk4Gw+LARN5GFvAAy+y4ogeaI7j2QBfp6qX+b5r2RXwQrtLMc0p+I0HSuouCcEUILJkmFRYMVuZI62PzIjvAD9+2fyBh9dKRNd/CTg91/VLgyjkrIW+QEOGRwpWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508669; c=relaxed/simple;
	bh=l7kYpJSyNb4LT4PNP24Ib/mZ3/rLHCzQ/AGuD9oUJk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQM6Z8M/qgk8pXNpVlyhZtAeyIIl3g7m5T2iswgho5zAaOha92mdLXzCD7bskuvDEHE7WMTFj65TGq/4UJGQYeGg1G8W9qcoS9xsdmwaiRk6kRcQHzjkxQFdR6V7O8jKbhBunMWUHiCQQ5gEU4pCQpmqgkCwEC7eFFex8qjH3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/37PlTe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39149bccb69so4872561f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743508665; x=1744113465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjzUBL0mWJbDDZlrnw5hFFgQWXS6aH/9lQwvSCFdxu0=;
        b=G/37PlTe6dVwtK9jB1BqXUvwRl+5HIqSeAa7rNxVGIkKQUhMT3dFtMPXFYxQXkv37U
         hcLg+ocC3N2ycdiJ6F66js4JvlqYZ6bQdRB7YtAITOpWmTVTXE2NSy/7QWyF6WvvMWEW
         h8N0VmWCEnfYX7W0N1U4k/L5ki0UDlSJYQAMLRiKGXWixqD9J2D2DeBoEPPBRAVhMeYR
         oDe5Q9ZidjV6wl1vRF+MPqFux1l5r0LNICOYE/4zXOR6FMVm5AzSebk9EVyAfKUF/Fub
         2zE4b87Vz8CGvhJh6+Z+sTkOK+mRKcRKg6qoMm3jchj52NISDvRCVFx67aSGWSEmNU2C
         axFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508665; x=1744113465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjzUBL0mWJbDDZlrnw5hFFgQWXS6aH/9lQwvSCFdxu0=;
        b=escjJcmYvXlvRhvGrgJA7RbCorKEGeNUTmADOrIahDwddEHaHBL6HDzJK/xsWqbrsY
         h/dQF0AU32tdKlhCnLUCF2E9bR1TJVNfwEXBhZpJMeTZkNe5tWBNcRBv56NS/894S3iH
         KNcdhQTnt1qC89C3D0l8LTt19YJoqzo2Kw4etatSwLzudbBuw2a/ui4kKqG+Tvx41son
         6niIaOIWlRbBQ9eP1CjMABK8iJ9YA5P8tF1DvXVfsEko7olKoZ8FHfmTnTCLXQlkEV/I
         15a2khLEDeIcDKm8oi/Tzd9tXZbzwtsM63Tq7jn/huJSzjn1WpwtVyi/T5Qa4XMI82XF
         Y87Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvdsYVAD4D18cgCBMkBg4mFlmVjB7s6LZqxkM6+xbmNVgl+b3SSqt7SWO73NBvCZcuMM9Ak2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cnMBYMabs0030J5ORCtNOWWoEIlDpRLtnUQKCOTFcfW/OC3h
	6K5oYEYrg0W/AKAHBGHZg1/krrPAmceBdWSxAYL7cJc3L3m6fky8Ar1gocClNyQ=
X-Gm-Gg: ASbGncukqhn0iY7CE5XYw4aBejZKyXSBuMqIgNV2gFXDfx2c1l4leS+uGAZ5P4Af/C/
	QFm85KeNuEikc4eqnJRdvEsrcDbBBz6Eern2agYC8QZIsA8q8wJ+oMDB0alYVdhOVybrIiA3vdT
	s93LOMLjCob+0BnW2GA1539/P6QCH/eUzvHZTmwHDTnD5grWGz/48u5z/zpIWtSiM/OXu09yHqq
	tpQTkkFmT/cLjlNk5yi3SwJbDfAcKlrWDWNKztO6+YHWJGh+6dyCjBEtEr2BzNaaXUdIHYpOR/y
	/RLXjHWe/kXdWSbJVqn2WJD5iReH5VoJbuhJ/v6GUsuQuj7XZesrCgfBDw==
X-Google-Smtp-Source: AGHT+IGf9wJpKPB8sOAif2cBapevtQFgZEdOvFtRWa5cgAStYv1CeTH/1WOTDBZFxqFzQq9JOq6DIw==
X-Received: by 2002:a05:6000:4282:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-39c120dededmr10748348f8f.14.1743508665067;
        Tue, 01 Apr 2025 04:57:45 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm14130150f8f.91.2025.04.01.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:57:44 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Date: Tue,  1 Apr 2025 13:57:29 +0200
Message-ID: <20250401115736.1046942-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v2 (https://lore.kernel.org/r/20250305170935.80558-1-mkoutny@suse.com):
- don't accept zero classid neither (Pablo N. A.)
- eliminate code that might rely on comparison against zero with
  !CONFIG_CGROUP_NET_CLASSID

Michal Koutný (3):
  netfilter: Make xt_cgroup independent from net_cls
  cgroup: Guard users of sock_cgroup_classid()
  cgroup: Drop sock_cgroup_classid() dummy implementation

 include/linux/cgroup-defs.h | 10 ++++------
 net/ipv4/inet_diag.c        |  2 +-
 net/netfilter/Kconfig       |  2 +-
 net/netfilter/xt_cgroup.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 8 deletions(-)


base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


