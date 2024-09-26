Return-Path: <netdev+bounces-129896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447F4986F1E
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A02728B0CD
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D4218FDAC;
	Thu, 26 Sep 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBxp1oTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330D1D5ACF
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340240; cv=none; b=AmfybT+7uCqWvPKYeochD4xl2d9g+c5u22uWVUhgSFyL9xFnz9nvLjogS5AuIfdLjzBk9DcxUV4PlGhS2nsYRq7CzYRRPd6Ohq/ZLQuxNq11qyzfwoRIam7mLQdiXWxKvlbQ1fqTHbt98soiqDzj+0cXECGuT6lEmdOFjlcOioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340240; c=relaxed/simple;
	bh=+kQi25LSEDV5MCVBdOPIVS/PZEML9oCRB35OWJwUp4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uLMLcaeoCY93DnKuafEclLYT/ctM5Up0yLXwVMzlB5LH3bjybF3K+lsvE1Hv8lQYhpOzduUPupBugfMi+DpP8NmoP1F2M/48QyjftMKQjcTbSMTjCMSUSlMnxCteE8fxOfsfb4QZDZYcUnb85Npl4fpXBpJsWvEozFMYrT7fmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBxp1oTC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db233cef22so592752a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340239; x=1727945039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz85LQ9OR0ZWBUIyVH/VW4mHM9ryemRNsmCVqeqIn/Q=;
        b=EBxp1oTCFFZptTaS+p31Z5+RuyxKrieoPqeovJ7b+yuDIQ2FjkmmKmVDrPCiifPeAC
         9crw2usyHk2/qAax1Jopw6mVUtPerRsePv77e4Hv6oY76F4TWB6FRv2c+jECeZxO0Nds
         V6B3IF29dCfTUGjiih8zwyhfV0YEblTlMtC13yfDWdoBY7Z9OIXhWtRux4LOh+w9O+Ae
         H4LgmKggucpfYvXGVn2F1OVhsGmaJBb2wrMzpw/5B/Ewi3UogmhTFG4axV0+Iqkr+vh8
         rYMEqz0hTCMi3XzLxTGT0+wU/vRhBuT2veVgoac71AkZTVIN0uRkhqP1ke7xdCjwq1eX
         h/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340239; x=1727945039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz85LQ9OR0ZWBUIyVH/VW4mHM9ryemRNsmCVqeqIn/Q=;
        b=nJ+p3PALOkMrgRwxbD72iDDHyB39D/0wQLZmKbHuOtIt1EAyXdQJxKhfZnK3P9YS3I
         19B9qyQPq0a2gwmSlfcObOnxCJmv0jG7MwIqGa4uMBVZynX87Fos3JtoXNL1yBvJVbIp
         DIXQAF7CN3aBKjGoXLK4P3NwmgEOiB5X1hNSEMuqrvjdP3TITTTSjvofy9FM4UdYGZU8
         cGlgHzE6B8YxKkqW7N1sg3Ad60VeOKul2/FfT/ZzKR8gsdClS2J4zY318HwSIW+ZCh7b
         XFojm5bMnkIFiZclorifphn24HSwF5xWZFqJpynuVlwrqdZTNwhZgG+mnE9rtfU8y1v8
         lkXg==
X-Forwarded-Encrypted: i=1; AJvYcCW30WMCbp2JvGQLjmK1ml6evETNATiunbaoKsUsz3G2oGPJWpjDN+ZgtyVYvzuQtCwfGUo6xO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1NCcaQuLoNYGiltRWAaPKNflgZNGEPmhW9hjGiRm0qySJ8H8
	phKG6C89rkONr8asv6EaVC1+FNI8HZz9+HS2tNpAsBgLZIKQ4Q1qhfjT3CTm
X-Google-Smtp-Source: AGHT+IHPakTHAzFUNXEVshpljFTEwVsknxndSUJBepdDOgUpI1ZDHRur2v58p/hXRl4D4iUW4x9CRA==
X-Received: by 2002:a05:6a21:3984:b0:1cf:4bcc:eb9a with SMTP id adf61e73a8af0-1d4d4aac51emr8234404637.13.1727340238498;
        Thu, 26 Sep 2024 01:43:58 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc93903asm3875888b3a.113.2024.09.26.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:43:58 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 0/2] iplink: Fix link-netns handling
Date: Thu, 26 Sep 2024 16:43:38 +0800
Message-ID: <20240926084344.740434-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling something like:

    # ip -n ns1 link add netns ns2 link-netns ns3 link eth1 eth1.100 type vlan id 100

should lookup eth1 in ns3 and set IFLA_LINK_NETNSID to the id of ns3 from ns2.
But currently ip-link tries to find eth1 in ns1 and failes. This series fixes
it.

Xiao Liang (2):
  ip: Move of set_netnsid_from_name() to namespace.c
  iplink: Fix link-netns id and link ifindex

 include/namespace.h |   2 +
 ip/ip_common.h      |   2 -
 ip/iplink.c         | 143 ++++++++++++++++++++++++++++++++++++--------
 ip/ipnetns.c        |  28 +--------
 lib/namespace.c     |  27 +++++++++
 5 files changed, 151 insertions(+), 51 deletions(-)

-- 
2.46.2


