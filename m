Return-Path: <netdev+bounces-121472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7A95D4AA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93441283EA4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC018F2F6;
	Fri, 23 Aug 2024 17:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289E12B6C;
	Fri, 23 Aug 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435347; cv=none; b=QbtbIvSam10He55vpxnHydzJLurtINcqcUASN1PDKzriqY2NIuO3zG2E8lrlGeP6KEBmealq8EA1sjsU9aSU/PI2Mdbt95f0wpXWJUj+hTkQ0WfFMebze7vFliRg6laZRdlQ8Qvr1smGVYBIX8qhRh0bshSQGikrX8GhnsGFKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435347; c=relaxed/simple;
	bh=TiTV6Z7PO+TvZyWsW1aXXnX404Jc6SJmddMZrxT2bRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sp5SLcBPolSpY1Q9N4MF6WxdCdEQjMDQPyYqzaJ9B8LBIpT7Sp/ZdMhemc42dSulDqlwRqQolGL+zpFPrA4Ee2ci0DtM90X95Id/q2YnQhrrj4UHH6aNnO/GeVwKw8B0jCvhC4UeVM3hqWDPjKgZQXotErdyPX90uF3Vj9mjKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso3791898a12.1;
        Fri, 23 Aug 2024 10:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435344; x=1725040144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzlRu6XA4P0Ykkn49pX+TEYVI+Bp8ho7EJhrlcdBqr0=;
        b=JvKdnxA/aaeOEsqOD3croLp1+V4aTElBZ8qka/m19Ytraz2u+19va+Xv0xVawmn20g
         T10LMSZlJeSiXYtLKkcLRUrOADLbqi/a0o4ihUutpVHtstvkF2U7DWPcG+2yEN6IIqxW
         3bhVQar//wwewy/QZzFlzTBpXqt4oz3LXEzm8ItLns0wu5jvqco/qqdsSlNCE/pLfJT1
         5/p2XNHusnjzI3P7O1ddwSKFtmSD/W3VMf1TtKimVZgVBg0k30h4GoJYvCwHRgnhTV/f
         h0gwAdWH3aA6Hk95IZcCFOHB0cE1u4SCMnxgkHJeCWOzZ5AuyC0Cpe9iwmQezwLpPzaP
         19SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9v6V/kMmfULv1VbFsPdGGriVGRbwxXth27TlCVWY8XIWBqt/ndH2luC3bw3Etc/gRPRgNbx42@vger.kernel.org, AJvYcCVtaR90ubxv9gghJ0RZ2F7iwEO1MRot7NdjxoD4iuvic2OU6vXPURYP0u/LMhbYOZ48dcqZkMzhaMev8dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aiPGQKRBFbxhBpYEl1nLL8zpqFifD61YqV0jU88DO5EBJVvu
	86lIDU1UJArUkB1zVOVIFKaAARwTV8KQ7hP3SwwQecM/W5Ya7cQP
X-Google-Smtp-Source: AGHT+IGXQdS4CTXd8JthiIkhSz3X3eKgmcWzRaHwV3M1x+rW42fLZA+4esf5LcjetYy8YVns9+oFdg==
X-Received: by 2002:a05:6402:234f:b0:5bf:256a:a19e with SMTP id 4fb4d7f45d1cf-5bf2bdbe1f2mr8096152a12.4.1724435344019;
        Fri, 23 Aug 2024 10:49:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a896dsm2320185a12.81.2024.08.23.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:49:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: rbc@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v2 0/2] netfilter: Make IP_NF_IPTABLES_LEGACY selectable
Date: Fri, 23 Aug 2024 10:48:51 -0700
Message-ID: <20240823174855.3052334-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches make IP_NF_IPTABLES_LEGACY and IP6_NF_IPTABLES_LEGACY
Kconfigs user selectable, avoiding creating an extra dependency by
enabling some other config that would select IP{6}_NF_IPTABLES_LEGACY.

Changelog:

v2:
 * Added the new configuration in the selftest configs (Jakub)
 * Added this simple cover letter

v1:
 * https://lore.kernel.org/all/20240822175537.3626036-1-leitao@debian.org/


Breno Leitao (2):
  netfilter: Make IP_NF_IPTABLES_LEGACY selectable
  netfilter: Make IP6_NF_IPTABLES_LEGACY selectable

 net/ipv4/netfilter/Kconfig         | 19 +++++++++++--------
 net/ipv6/netfilter/Kconfig         | 22 ++++++++++++----------
 tools/testing/selftests/net/config |  2 ++
 3 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.43.5


