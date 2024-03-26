Return-Path: <netdev+bounces-82239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244C88CDFE
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633981C668F7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1F13D2B1;
	Tue, 26 Mar 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX3PZ/nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F913D250
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484008; cv=none; b=qcekgJbw9Cnpqe+Z+t14UgpLMgVm4sVC5gC2Qsh9AnECW1aVM5NHe47Ezn/O6/2HUtmiSNwRZOU04/xkhLUlU7RlsmBEjbutAdZ55JyzsU9FH+MflOyB5ttjDVxetaKrxLKYd47hnTqEFxbvcCJJJrFb4CRAWjIYNgElFoRtkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484008; c=relaxed/simple;
	bh=rGIOyINDShe00hSVpMm1wSNft7enYdM0jZ7h/mfwwgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e21Jii74XeM/RESkZ/PnZeEqSD3/7UoJJRcwGGA0HdlU7pAZz+4o/ei+h+ruvns98ey0TK5lpDmmF1uMucIpPynUh+YvzKHye8uPAZavPgFJda+0t9O2yzg1APmAao6sfKS3DjlSrg1H3DOs6xWscDcDwcHX7dGeEKmjAnh4+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX3PZ/nl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e704078860so4360931b3a.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484006; x=1712088806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3h0wutVogfTEc+9/pFFbc1vxbNPg5L7YbBILVlkXO0=;
        b=GX3PZ/nlKnt+AnftDO7wd0tlGA6QVsOwELQ33lYYg30fK6/o+d7hh/c40G9lBLj+rU
         vhfEobABy3vIZ2KAKiFwupWsh3oLSu5PVbxA198rOrviyr5b7AFwxRNl4ZIKX+TM6yqy
         Nkhw5MHTEJr+68MYraJadB/2Txr/zH+BGJLDvG2cSWZ3JQwGqn5RS9fdf6Kr5YMmS3kj
         E8fMQ0aWjL2nPqsfiZsgShAFbp+C1yeowhfPjQ9jNB9Y/yskteGxjBv8vam/L7mcPLv2
         O1qRmgX3cuYK3UdDVBBcVaUcd1nHUwadcxDOYxkLHgGLU8d+aImbPRubWF1wuhufMwSw
         /SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484006; x=1712088806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3h0wutVogfTEc+9/pFFbc1vxbNPg5L7YbBILVlkXO0=;
        b=J4e/O6kRQHlhBj5vpvAiXybciNU8bUunK63zOdbEInUw+mm5BEGgzqG3RvrK99G2fG
         k09+YbhexCS3uiHoGwgLd/T5Zo30CLKRz3/YjHwX8hUo8VbBQg25siN6zJNpi71/LpvA
         aGJJ35KEgAsonjnBO6hAVG6PrAzggq0NKQGMVDKMSAgCpt9UTjEJmbREbl9Pcz5z0VX8
         UVrBlhSonp65WgF+aU/+Ma2seuVPXfxf28K5yn21PhgVcJoJmGVuiH+rG3k+PYoNzQv6
         e2GzzP+g67leCynO0e7tUkFM7R9ZmIFpUTjpQMp6bNisZmjBxFsYJixNQAXvl5nmSwxt
         6H2g==
X-Gm-Message-State: AOJu0YzpdbVyqnzEVp5Jz/cicsyLaYafGj1RxGPzcQEtXLwNX+Lx5RYa
	nd5MmZeqoibd/XJwvyz//JjMQRH5LpEdbxB0m34Igqo6OiPppQq2DixMo6/bxeE=
X-Google-Smtp-Source: AGHT+IGtA0/VVTC0dZZGBfZGx+CM5ClQmB4GgtRN9UZ0z+dH+rtp35c3TkT1mBQH9Y0/aW7PpR98Tw==
X-Received: by 2002:a05:6a00:1a8f:b0:6e6:270a:9303 with SMTP id e15-20020a056a001a8f00b006e6270a9303mr2409135pfv.32.1711484005623;
        Tue, 26 Mar 2024 13:13:25 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e647716b6esm6648939pfd.149.2024.03.26.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:13:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/3] doc: netlink: Add hyperlinks to generated docs
Date: Tue, 26 Mar 2024 20:13:08 +0000
Message-ID: <20240326201311.13089-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extemd ynl-gen-rst to generate hyperlinks to definitions, attribute sets
and sub-messages from all the places that reference them.

Donald Hunter (3):
  doc: netlink: Change generated docs to limit TOC to depth 3
  doc: netlink: Add hyperlinks to generated Netlink docs
  doc: netlink: Update tc spec with missing definitions

 Documentation/netlink/specs/tc.yaml | 51 +++++++++++++++++++++++++++++
 tools/net/ynl/ynl-gen-rst.py        | 46 +++++++++++++++++++-------
 2 files changed, 85 insertions(+), 12 deletions(-)

-- 
2.44.0


