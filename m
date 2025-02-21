Return-Path: <netdev+bounces-168424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58452A3F02A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E8019C66CF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC60204689;
	Fri, 21 Feb 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG6imV+E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3F2036E6
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129846; cv=none; b=DMqPuA9y5mpFlQkzeF7z3cRqoqg1DooWMo9lFcBpdf/KrwZaiMchBYDEwRGmzfMqvCEzLqraQvxo+/+colUHsNhutL1jsRUAZf85cmtRY1/kAsZQamYiuqq6yym7czIp9uYJGmRGhlFJLEDXVgjd5fZu9J4BzKfgAQLYAXWwB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129846; c=relaxed/simple;
	bh=kdF5pR4j7093VZeahgZx4dDFbgbqcWlaBztyY0Ftc2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q5xevNs3o3mOrzK11RCxG9ZUzDmUmUYrTP3zLK/zRfS+sNDuyhGjlg1SBK0Hn65vmMzBKnhqQkSYRTSeDGP/6c/Cf1NiWJMQPSFeiaH86aZNeqQOnellGDzJ5rnsuQ48cLmbR6al+8zPj0TFoq5NDTfgtEAOtdOJzdIs5R0LqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bG6imV+E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740129843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QhWMRdSmMrgzWxT0II1IowCWe5OdxJdnx7uya+tDWGA=;
	b=bG6imV+EMdbflH4O/j9fmfslc5mBO9oE7QSuF6m9qe6ym0E8snE+Drv2GTJj773K6ZvSG+
	UGDJeo786L35YdScbRYRGNOkF8qaMMwlTjZ83urRDOnPsv0GZGHA8aJ9nzgLIkB/0y1ySF
	gI9AU2fBbCmdifNX4PqJORB2/ekyiE0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-5JSYXsUHPxCck9e5M1hxBA-1; Fri, 21 Feb 2025 04:24:02 -0500
X-MC-Unique: 5JSYXsUHPxCck9e5M1hxBA-1
X-Mimecast-MFC-AGG-ID: 5JSYXsUHPxCck9e5M1hxBA_1740129841
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so8714215e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129841; x=1740734641;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhWMRdSmMrgzWxT0II1IowCWe5OdxJdnx7uya+tDWGA=;
        b=WYbvm3eU91jsW+SqfW+pBwnVYgtdTedHGo9HF17I7Wdr7qINmnfOLuEsLd1f6nrB2F
         5tAtSOuZpBsyv70h3a36wyzz8zfTeGJ7cZbpl+dN+kQ16VDsGAQAqs0ojnXcywrPIVMX
         UrNHzpKk0srpT0MPS5xNIyCldxi+zQJ+SN1mZGUPeKmqtLnTmWuvznjBtCqeev6X6Dh9
         39U5OhXqH15PYMKabJGNTW0MUHGKxfarAJC6gRuzVvGNWY2IgnK6cWoctLWLB4ZypLE/
         tqvKebmfNt4d/rs/TdplRnLx5rgHsrgu2cUBSBOYfGoh0l7E6LBgW1sPKbtiY5AqWGNS
         cQdg==
X-Gm-Message-State: AOJu0YxQ8IYozwC9VbnR4iD55BsW2B4b6M8VLePvHQuLBpDMwVkvaKQN
	ZV1gORyv9rz1xw5Y0JM+DCwyrnbqIsyN57pqxl7y3Ws3DyNIz08gt8cT0h0VIjWx7PDozbdZPX/
	fSehQHT+YyOI2h+7NeP7xb2jXhvDw2tXmE+zjFwZv/Wjc7Su/+NXHmw==
X-Gm-Gg: ASbGncu3P+3jq44jjr3wIuGMxJ5aRKTkpSiPNS8AK5gVwWYe6s7Ga5rHeSZETUQHOtM
	UrXyWXDgJe6Q/IOTvfPu+bWggsnL0K4PkXZnchnMfDy9fgUxKwOfkOWNe1TlKCnsTm7Hq+w/8sO
	V4ITX/zAS0UF6ydAsnRL7ZvPxNLoIHr9StEmA8kVuaMt3rWNv1GNA8mBiRxi07fcDMtERgeQAUR
	B9OD0lUcvLiIMMkWaDyy8l9aG36FK5z8GtnSeZWCdjvn4mLB6dDnRA0pLTi9aOLtmCKf5e7iBOa
	iuQ=
X-Received: by 2002:a05:600c:1396:b0:439:7dfe:f12 with SMTP id 5b1f17b1804b1-439ae1d9704mr22060765e9.5.1740129841097;
        Fri, 21 Feb 2025 01:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+OzWYBsRDbrhjn5zU+LtWQBP4DN4n8mxjasZn0FDa6L9HQh+cxU4QDXh85SZemYSsfw4aAw==
X-Received: by 2002:a05:600c:1396:b0:439:7dfe:f12 with SMTP id 5b1f17b1804b1-439ae1d9704mr22060455e9.5.1740129840614;
        Fri, 21 Feb 2025 01:24:00 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030bdb4sm11542325e9.27.2025.02.21.01.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:24:00 -0800 (PST)
Date: Fri, 21 Feb 2025 10:23:57 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net v2 0/2] gre: Fix regressions in IPv6 link-local address
 generation.
Message-ID: <cover.1740129498.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

IPv6 link-local address generation has some special cases for GRE
devices. This has led to several regressions in the past, and some of
them are still not fixed. This series fixes the remaining problems,
like the ipv6.conf.<dev>.addr_gen_mode sysctl being ignored and the
router discovery process not being started (see details in patch 1).

To avoid any further regressions, patch 2 adds selftests covering
IPv4 and IPv6 gre/gretap devices with all combinations of currently
supported addr_gen_mode values.

v2: Add Makefile entry for the new selftest (patch 2).

Guillaume Nault (2):
  gre: Fix IPv6 link-local address generation.
  selftests: Add IPv6 link-local address generation tests for GRE
    devices.

 net/ipv6/addrconf.c                           |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 227 ++++++++++++++++++
 3 files changed, 237 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


