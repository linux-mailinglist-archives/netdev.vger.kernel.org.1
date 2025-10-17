Return-Path: <netdev+bounces-230282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BBCBE62E6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776695E4525
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0A23BD17;
	Fri, 17 Oct 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd/hWv6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB742147E5
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670320; cv=none; b=D0EnofC6WeghsyfqO0fjcTEEMBriCHbCYK/x0DFw0dIpCstx4dXnti2s08E8SdFA0a9nqjOkDF5ZZYrDVAP7bxf39XsUSiUxRRsPdrZE7Ik+sHSPv21S/pwuPX6VoWh8Uh7Q6rgEydhua2oFIYRrJR6dAVZUY49I6/rPDKCRY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670320; c=relaxed/simple;
	bh=380/EkU9TIh1ez3W2lpQnsgyCmAC9hJZsgc0uthCnTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5F7KVXC7TD0jgBk311PXYsy2cwKA994KMUD/HA9eGNLJgpmlsP7K05BPkh8cDfcmGxtfA4EEHJHjrQFXAT8ZSNaAB83ZoKMeII2kg7mnAEC4ZiVQqj2a70Y0dRdVGVinK//RV4ecLAgXluHKq4sk0MedGmhAMVABTkM0lOPNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd/hWv6l; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso15409345ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760670318; x=1761275118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3r6CrZovcrJts/nM1rIovQa9F5q8RdL0nG42mI0GRg=;
        b=Bd/hWv6lHA481oS9gWWW9xKPgMBbuSj5N7ppHFHbzoij4dcszfkRFiao18Fk6kb+rX
         EBGepO8E8/o/fdMsM+PRPCZABFQ8sLLZijETDRTou6A06tWWQ5hsvzzR1JH0DVPKgluO
         3NYuPBZGs8hlrs4AICEwNC1AuVqOIMjeyDu/sSlsUBceuRMZ9EjljpJN/ojwlzioKkl4
         JojofvRk7L2U2gQv3guMNgfmVZHSLkDsEai9e1t4d4c8Iy7d8/6cM6YAUR0RZsLkZDdB
         v08+GhEQhOqcJXESjqQ0mzdjbKQuwDrmpIuW+ZVf2GM5ww+mMbPXHCXO+Hx8ClmZyUxw
         V0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760670318; x=1761275118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3r6CrZovcrJts/nM1rIovQa9F5q8RdL0nG42mI0GRg=;
        b=ENsbKs9AFwjjeKXV1Bi4c64Y2DTpeGIlDYoOMERT99TkTYA5zsH0JfKvm/5Zg9XtAx
         6aCYqBNE+jkAvUqy5LyAZCrvCiGVV+LghQFqc7gnSRmoXoAk1oInmvpixj39pbfBySVY
         o75uLg+7vrXHZ1feChiaKsv/asfPLH0L/a4NQ0343AZTww7QZ5bS4MxpsBngf8bv7yfd
         meEjSUb3XizFNlBSZkZhzUz3ogibill1irJ1MPwUbV3kjBtaxgbSi/icRj2b3fd6fWnA
         3oUw59Uo+g6R5I03/MxEpvoLtsqiDIdSZhPuiEKvkUVK7gfQELj8ag1LntauzY/EvsCT
         3OSw==
X-Gm-Message-State: AOJu0YyijDtxNsFBWTT4AmpHPFfD/QGlCfrYAZz2zrrg7ZElTDbXBwg8
	cadWHMCugLt9Dj0AWu9xbEXAOPBf5R7FtxowMUVykUFpvickzGYkmZtbuXmxP6JR0Hg=
X-Gm-Gg: ASbGncuJvrLz9qLQIodFi4yPGFvqxkZdRBwwcnJuJN+Cj9BJXWpKpuTfZlZVN6CkS9X
	8oemYpevmeyVX/XPJkweu/bq0ppHR3wIuQ+2dJWpuKxTqRSBVZ8czVETAbgdD+l9nhMU4oVYdVB
	whjIhXOg0Zk143p+WqCP3rpOkw6+BiAUW4iIE1YJoPQiroj7ORV2M8Jk/gm+KJxJ/bs80c5Nb0c
	oufcNKSfS5Rt82aHvjojWT5ycOjaTHWj83nsXYaRcKq/YqWp+5AApAaKX1+2kKLvTXN8cgXBltw
	sKR/fHGXLXvkRsKsKRnLXMRrHReDLw49dFmLnSyq7sCTAiR8/Sr9O0sZjTwo6+3V4f6RVLILY5h
	PF7LSzOIo3r3pHY+XR2H0jPZimHI719LfWMEp1oFvrSQVRizX7KM6NogoIRjdlgiWsDMjQW8xyu
	SsouHi
X-Google-Smtp-Source: AGHT+IEhOQFhsYeyl26rjo3iy/25Y8AZgw8NVmq1AbyrV0Op0hzEQnVj9PxbXCkTUc3JRr3t8z0txA==
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id d9443c01a7336-290c9c8ae4dmr23819055ad.2.1760670317807;
        Thu, 16 Oct 2025 20:05:17 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909939613csm45987225ad.51.2025.10.16.20.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:05:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH iproute2-next] bond: slave: print master name
Date: Fri, 17 Oct 2025 03:05:09 +0000
Message-ID: <20251017030509.61794-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017030310.61755-1-liuhangbin@gmail.com>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new attribute to display the name of the master interface for
each slave.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/iplink_bond_slave.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index c88100e248dd..55deaadf5fe2 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -92,6 +92,17 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 	if (!tb)
 		return;
 
+	if (tb[IFLA_BOND_SLAVE_MASTER]) {
+		unsigned int ifindex = rta_getattr_u32(tb[IFLA_BOND_SLAVE_MASTER]);
+
+		if (ifindex) {
+			print_string(PRINT_ANY,
+				     "master",
+				     "master %s ",
+				     ll_index_to_name(ifindex));
+		}
+	}
+
 	if (tb[IFLA_BOND_SLAVE_STATE])
 		print_slave_state(f, tb[IFLA_BOND_SLAVE_STATE]);
 
-- 
2.50.1


