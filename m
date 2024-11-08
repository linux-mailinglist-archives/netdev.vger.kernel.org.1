Return-Path: <netdev+bounces-143422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCA9C25EF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C357AB21960
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A861BD9E2;
	Fri,  8 Nov 2024 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuFILfB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4C1990B3;
	Fri,  8 Nov 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095818; cv=none; b=QwlHFgbwQo1jWZuoGzgoUY8l5DR+tthzush02DrPY2lxXf3BuChf3iMUQ+EPJGjUptsE17sb6UgapesNxEz6O7Obk9M2Kcs5pgOEI0kylHAENTRvWs0hzs8BNIMBxLt1MJrirDQmgWeXJIztKtxOvJQpC5zvncnxeDNPl+dwF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095818; c=relaxed/simple;
	bh=RnRYMG0r5Tb8CA/prh1T62sDpdMwAAltux+0MaQuw+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knRr3xi5zSDtm5wZ7W2iWqDC2GvYhKwUmFdpdxp7EJWOo8t9XqPsCLLfHrJu7GH9HMefPTlA2JATqw8sSAZypN1nO6zW/tohCAx2jR6Z9G4TOdlhoEWiriAWNSJDGx5HEo8XJfvXNzhanlPsxZ9xZhxOFT9Eur51kJA7Zb7KKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuFILfB/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d01caa66so2455171b3a.2;
        Fri, 08 Nov 2024 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731095816; x=1731700616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmHi0kdn3wN+ndrULDIunuwFGgPO4PZyVJQogrQ8fKo=;
        b=DuFILfB/9v6SvX6UrmIfnHzIGG4uKczjvSncOGVJQMkp/dkVB41gZ7lKIZ3SZMqouF
         7xxmlzKJetKra0LLwbqE+4VrlYWODBxMUrWwk2JEWqPoEqiarHdd95NEOoAaZURTg1Mt
         WabIwJChIBOR1iyqKjPcvUhPV9WPw2it94X3Y7nDBe1CXbSvFsC7BvOH/B8TfSJ3xs/l
         SWDHwIIMaFi41JJTG9edbKDHayKOeJgpDG4Uun3pIb4yteiYDBQk72OZmO1BkRrJsFl8
         c4JObFQ5MW1H47prh8PUbm0HMUd491Qlg+r2/Oe3bkAVOqa27Dtgeda7yiy8FOkbZf5N
         81bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095816; x=1731700616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmHi0kdn3wN+ndrULDIunuwFGgPO4PZyVJQogrQ8fKo=;
        b=wHQRb+k2MAC48Jrv7y/vRRQVlecZVtDpbMsckgxyN03C9Ojtq8l9fqORJoB7VnxCJW
         wH9OhzfLk/9wR+ZTiGmAMTBXpczWcHpqrNfiGiv8IqaAK7WgiNGXQzTYRRDqggigDTdJ
         vl/dBqSz6WgTNP8e+4lJ333whgMsjMfibFoQQsLjGQpIEFdtmSeqwUWOom4j0UdTo6N6
         O73+lg0aXDjxIw0hRh6yfgf6WQDp4gGqrWUcDM0SFNcUAvIvFNUtnDvNI/XsvYiwJUli
         c+RdhPgW3Zo1Yhb40rAL9d9wVJmbqJRzsAWtsm/CjYPoamocvMXWZu6qQ4a2/JPeVZsD
         JrLw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ha5zF9pXHT+aI8cxl5zrZINNvEMuuWN3kq6IyEQe8RMVVEjq4NCNQcA0rgF5z/uDdEIPasiX@vger.kernel.org, AJvYcCVb20nb3Pr2SYInYqbvdd8x2MdTTmV7wwpkz9WpXnCJl8BsC5bljjWvPhpcJz8PkXBqKPGdwf02d63dvmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVNtve3g5Ewb/Xjvwtzdq9vS49pzhOVSMs/49ljDcSIRYVvc2
	UF7+TyHXWdK8/PyK4seXtYncKQELQ6Zg+jF1vDiXM1/tRpsgxPkP
X-Google-Smtp-Source: AGHT+IFTohcBku2wu4peqwuNZQdYZKLKlPBcz4eTW8IXVdP1pnayn0FCaHcbMUYyxQ2C0uZaXwzxSw==
X-Received: by 2002:a05:6a00:17a7:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-724132a111amr5586111b3a.8.1731095816377;
        Fri, 08 Nov 2024 11:56:56 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078c0b13sm4190964b3a.83.2024.11.08.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 11:56:55 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH] tc: fix typo probabilty in tc.yaml doc
Date: Fri,  8 Nov 2024 12:56:42 -0700
Message-Id: <20241108195642.139315-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling of "probability" in tc.yaml documentation. This corrects
the max-P field description in struct tc_sfq_qopt_v1.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b02d59a0349c..aacccea5dfe4 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -622,7 +622,7 @@ definitions:
       -
         name: max-P
         type: u32
-        doc: probabilty, high resolution
+        doc: probability, high resolution
       -
         name: stats
         type: binary
-- 
2.34.1


