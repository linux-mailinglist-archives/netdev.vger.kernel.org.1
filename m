Return-Path: <netdev+bounces-194768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBAACC517
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671F817369C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA314231840;
	Tue,  3 Jun 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rm8w+NAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86D22F740
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949096; cv=none; b=ZncbpG8gNlxAUY9HsAuIchlIFp1o+e+ieuBaUXIpXBu+rO3rqskeuhBl2EKsK4EYuZV7zuWkeagw+yBppQenJXcRRvA/VjdOd4LK3mMWhMAA0p3JD7F7aY25qIXu6yvEqRksYsd5vVBDYOz64yt+Zth5Ij1uGMEu29Sn642IHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949096; c=relaxed/simple;
	bh=Ox0MtGkzh3nh7CLtFL5qX0KHPLfrIGtHILG1V0i/ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIVuzHyybF5+7iFsLgBDZiiEyXi2bWM2oFUDSKfTKNSkNgkXcinZioCKw7DbLKumD96ZO6OvS3tUfVD6Psra0mobNBqD3/OOI7yUKON7kv62isFhucPwecO9MONRZpMPjDF6OR9lpYCmxu99hM7bPS8U+0aOqPXtrbsliAPt2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rm8w+NAr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2183201f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748949092; x=1749553892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=Rm8w+NArYqhVy4s1WQsAk+hCXuXeJBlhTrGX5Y8gtROJ1qsPlOS6yABIU8b6GdS8MI
         Up5bx+UnvuQ5XILAbMnYqk1OuA3rLykrx28yNiLJZ1opzetsygbNc6ykFX36dVUhQj7x
         vRhX1+D5uqrmdQZEcyvavFqpRlfAioIclCspFmM5h6M7l1XvkGz9wg2uvhd1sokKjNtf
         RzHvJyLRSrqqkb7WvKwDO5CkRp5XYQHpr9Fb0jSyDQDfbuleG4L0wlRvcuz0k17ASI2x
         AMaww9iWRE8xSLS9IKpqEApabg1ANLiueSUBiiDSJts6U0Dvq/ZbXs8dNQCuP8Z1CfDG
         bU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949092; x=1749553892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=ht7KqpkOCMvw0GMjwGvChXFvjnbRoIBd6PMWR+8wYatOATaSz8jKnlbcm0/qSpjui+
         Jb7PL+zmF/QvK/GuZ4R/7sU02v2h5uZ7ujRYEXRxw/u2HXazpB5TxgfVkSjPadp5dbQ6
         wx+Ae0AycqUYJpo5xMXOJVnB9/Y16qA45jbcL8Op21XPqnTo9A/Bwdlnh/g33bAuP+K+
         2zWoc1hLjYDYrLtG3UVQ3Ca+6ywqyCGppdppTUvmzfrzz1/TZeak4TO5dmNtw5j5HO+n
         apLkDpKssfvQQTZpXyf+QbobNNLiY9DxiS3Aq7vGfbaLwLWA9x6sdNo0HFU3TyySt88q
         gqDA==
X-Gm-Message-State: AOJu0YxjLC7gG83hOYstUZjIGVGS8YvovA/bHXsy3MEd7np869Vc8gZp
	w6lFObYbjcm5LMU6lGjg6j737+XTSTknVui23+g5OpXz4eTZF5xQtrIHXXRBE5++/cgnZF7PzDz
	pCBdnIA2C7MRD9VEeyuYUud0+l0iklzITcpjXdENsg0FmJC7UbHFsVHxP2M+cBqdk
X-Gm-Gg: ASbGncvscb7lrWLYE2lMKVHaN2FAWmVXWYoUmcUGnkxg4x9E36arjlX+prjURFIxE16
	F0cKj2t9JMfpHF2Z+wd9x7ZLczvNvhqwroo7Lkm6/8VGO5REscXlzylLNcvnRHs23f6CA0ALG+7
	8X9b++d5MiEOVSX8kl5MRLbtJtf427AunniLeVZQAUh6T+FoOf1Z7mrNFXdaquQ5sOGzoLa8frm
	CAY800QCFymW7RZihBm5mfkhHWWFLFWi2kNUjyNHbhVb3sf6fi4i31gpEUqwMbDkahWYXFMt4V/
	lYxHszwKG1WPpIWH1iimw9uy0EMkYwbPZX2fx6jUx1Xn2947MrJ/QFo37mGTeoX4miee7NicZZ8
	k3/k0kDU9iQ==
X-Google-Smtp-Source: AGHT+IEPpADIvrPcZR+MG/r4MeP+hMb+0l/2lWjb0NDxnfs2JCHxp5Y+aGCHiWxXKqYXzOevbQD1zg==
X-Received: by 2002:a05:6000:2308:b0:3a4:da0e:5170 with SMTP id ffacd0b85a97d-3a5141cf473mr1497267f8f.27.1748949092378;
        Tue, 03 Jun 2025 04:11:32 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm163244525e9.13.2025.06.03.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:11:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 4/5] selftest/net/ovpn: fix TCP socket creation
Date: Tue,  3 Jun 2025 13:11:09 +0200
Message-ID: <20250603111110.4575-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
References: <20250603111110.4575-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP sockets cannot be created with AF_UNSPEC, but
one among the supported family must be used.

Since commit 944f8b6abab6 ("selftest/net/ovpn: extend
coverage with more test cases") the default address
family for all tests was changed from AF_INET to AF_UNSPEC,
thus breaking all TCP cases.

Restore AF_INET as default address family for TCP listeners.

Fixes: 944f8b6abab6 ("selftest/net/ovpn: extend coverage with more test cases")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index de9c26f98b2e..9201f2905f2c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -2166,6 +2166,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 		ovpn->peers_file = argv[4];
 
+		ovpn->sa_family = AF_INET;
 		if (argc > 5 && !strcmp(argv[5], "ipv6"))
 			ovpn->sa_family = AF_INET6;
 		break;
-- 
2.49.0


