Return-Path: <netdev+bounces-193663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3412AC5040
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E367A17D32E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F35277017;
	Tue, 27 May 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ROiuG3O0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A87275874
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353979; cv=none; b=DTZRMpym0ul7cMKTYKlvCkdh2sY78S7lYzhYY7Z9f4LHADJ7Hh/ZmG3tOAgBDIi0sLzkNau+8fcJP9WihQ/JkxqzODJ/uCq1KU16tkl+e91CySnv5eJLqC+IKeIdFY2L8xdGJWBxTe7iBDKvR9hoipEp4zTIsXWlEtDLt89NB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353979; c=relaxed/simple;
	bh=Ox0MtGkzh3nh7CLtFL5qX0KHPLfrIGtHILG1V0i/ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leT2swHfZbblATGhKy3ruw8KhcNaHq5XSGmDCAvPTHOVOEKrhy2MoAsUQK+SoVkay0RClqjpAse80fmc/X0I5M4qyNgEzk+qvP83bz7KL6tEBta5Ajr6oqglRvl0wRjmPsavCitk+sENLo19ildYDvBb2ijUugDta4fO5WZ34Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ROiuG3O0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441c99459e9so21759485e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748353975; x=1748958775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=ROiuG3O02c0wqw9AE3/VRMt1BZ+2rwXC/3Px4TITBBTKfE8fS3sCVrGd2B7cuO7xOl
         LrJOB6ZlYBvqflNA5t7Fv9p/UHptfsuomIvYKiRbdnvdEf7cBzMqGWnINBRqxu9LHTvK
         gUCzXmVaocxSjHdZySWplhSdXdpUua3y1N4QrodciufvKXK5csyS1Lgk2IkFLWuldpr2
         9oq3Y5lVG3HowSHJlhLN8GZnbNbMDhp07pMsW+1T0/Z5NdFLshCFjT7pH0oRLp4Ckfbf
         wHpvhG1UJqSkNeJSVU8Ma0vqfA3Tdbpftt2wr6ofQjL7BIpchWmvjXlk9SrygQ+zCejz
         ASZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353975; x=1748958775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=XEfITqDCfh6BptpDAyzMi0icQc6G2AQ1WZRLtX/S3HVIYIuAOMrOpVXBv5+GsJxh5t
         QMYnVScOFtrWeho0XMv8b9TqCbQpQpwCGzs9biE/YM6PU+ntIqsuqnQmvrK1w4OVbQIK
         9m7HdZhnC9T1354862335LoShKoGwDlFVp0y02cPxQLqe7bt7XJLkG5COEAyNUM60uzX
         z7peVA/srw+8Ts2vNOlaZbZF8VLXRVzqFo21HeT5wfhYHVjFbvEaHQ+gyrbNuwtTsOXQ
         BExgaPxLWpG3fBt1Ta5IaMConpHdocUIHiVy9I/eTRq5rHBzKaIuLSH4DPVHt3+RsPBj
         Z/Tw==
X-Gm-Message-State: AOJu0YzKgIGcgGaL7gY2DIATE/WjNKb3VSSgyFPAMP2MgnXGYSlYdLfi
	eKVO5m6ddHnui0YLYJ0j469bFEznMyNUxlIIcN54hl5EXAGEnZlUofYmMZnTjRautvVM0rEKV8t
	lQbXb5DS6066zgAKG647f5VSMEMEEj7Eixr2BPhLCDZ+9Y1jRa92D961OJS52PEBi
X-Gm-Gg: ASbGnct/oIv/pkP1pReWkZJAV2ZBvMW8zXy8jSx02S0KxvOe1Yf47ThpRDVu3YRC+Ns
	4WjLn9xK0PlXqzKobsE1dDvB3dc+MAWg3bP3yQAPkcggCOK6JVLrfSojipzba5QEBS+ILB8v4rj
	joEvYPDiLXCzg28yfKzrurgFP9IxtIyG9TA7uGtp2CdjM4UOfP0uQld273lLmIDAgMEJhy0eihn
	RyghIK9BshcYehyJ32WuEuysCHYLAGhqUmdFUqYK4EKkhzfs7iC118Yo8dQRoir5uB8zh3BOjzd
	gwOFlo3IJRGvS/O5TZgEX6zAJtE2V3mHP72aq+zRqw8vHUuOFrTk2pmDVnPS08/tFYYhnn9P2+E
	=
X-Google-Smtp-Source: AGHT+IGqEJGqNvhf9F/8Tfg5Jr+RX3sKBK5BcSwSTidJsvQA6AKDiJ+WVmVeSr/JzLX6g520UCtCvQ==
X-Received: by 2002:a05:6000:4007:b0:3a4:d83a:eb4d with SMTP id ffacd0b85a97d-3a4d83aedabmr7248219f8f.57.1748353974917;
        Tue, 27 May 2025 06:52:54 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5803:da07:1aab:70cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm5387719f8f.67.2025.05.27.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:52:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/4] selftest/net/ovpn: fix TCP socket creation
Date: Tue, 27 May 2025 15:46:19 +0200
Message-ID: <20250527134625.15216-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527134625.15216-1-antonio@openvpn.net>
References: <20250527134625.15216-1-antonio@openvpn.net>
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


