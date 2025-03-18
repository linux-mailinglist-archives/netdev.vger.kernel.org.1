Return-Path: <netdev+bounces-175602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000FA66A2E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA95189A74A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0911A316D;
	Tue, 18 Mar 2025 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBhgeNj5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E051290F;
	Tue, 18 Mar 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278493; cv=none; b=NAwmVvLugB/STPg7JNpIx+EDakVduwb0eybt5kJZJcuPLMqro++UcOOHBUnMB3BbNi80F/C3bqSS5+EA2HGwJpK/iyP8CKF+q87i7bbz1B8+SDhmC6VLgntjJO0PgiML1HvQwW91It7YmTsaoQeox0LWk2LdO+nnL8EBh6GFWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278493; c=relaxed/simple;
	bh=Gtnj5kQROMjxg37cGTfBNCf5fuHtC2s7BZDYJzC4d60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJ9ZhebLlHQqhc6HSXNh7cJKxyYWfbS7wpRvUNEMMxV6TqsOejFpLDj3ObvfJTsA8ASqIjEbtJ1drpbGbYNKqcgkkNjGC/2g6NbO/a6bfozlTlDaw2Q3MjJQ69QmRvyAs853RetNOFWIKuIC9IB5DgtVR2rsmngT1IPDaGtv42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBhgeNj5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so90052735ad.0;
        Mon, 17 Mar 2025 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742278491; x=1742883291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyYTblo3Go4gS7PCUVXkp5H6saiDkosqM0q0E7qSpCk=;
        b=hBhgeNj5IZqgxTaSFP2USvNiYAg9SnSFFVVg4R8g/zurbIlq/N4DY98CPUIs/6oy4s
         7kdduvylB2/4G5Wn7Gl4ie89C+wV1xf9rV72sZSM/7BbFuEzADmhq/MPyZj+w/RL9z3B
         c8v3s76zEeUlWj9mUcEe42qBRUmtz+bvHsauh34L3+gtgs8uiWK1geaJJLukzvALWqxt
         /l3aEB1A0Bn3xueEWGc/2uhPrdg0pKkuBl/jQGI+bjH6SKqJ/znfCRB3FbDejiF2ur2N
         2knYufu8iBxkHWpXni/W62WjpsS5cECr+qnR1/jJsmvewt8TBBII2P1XDMhMSMdjTrUX
         DCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278491; x=1742883291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyYTblo3Go4gS7PCUVXkp5H6saiDkosqM0q0E7qSpCk=;
        b=FAvQqAtwuLppzziiQjc+B6oAgse0FgW0OrWiUxtvSb49JEfQSwgcnwCrHmsPBUUCNc
         oeUeoE9CWFk3LyofaoDPLn1DflkKyECrZxSbnzD6lGYepUO2fPAyIqJLbk5s7GljL81R
         2R6Gh3ux0eiCqQ6Cn6RY7efdBaz8uTCL9BhdPRcy71vk7qiwd54VAf3pd5ThE1IePRmd
         rFDLF6cmbGxJVDIXU7gfHxYPnR2iUZUy3Dd5g7bpq6pACFd0ePmcfm+fWSEV7/7bAV9X
         XbQwSMjRB4BAZjE3FIPAjVmBDbrJ8bBU7OZOtRvc2YD9YU+Elj+CbHl3ZCBQ7HzMq+eX
         BoTg==
X-Forwarded-Encrypted: i=1; AJvYcCVV0mwef3kImz6aERLHA3H7UWRgPOGB6ZvyotQU5MknSC6iMhjQTpuwTdb5C2RSnvS9Y+QlfzsA@vger.kernel.org, AJvYcCXlEY7zh1vEEACBqh4Ic1Av0Vtti0ZmO9ODJdYciTWzEE7g6cHQhtvmh6R6bvvQFLS4dCyRt8yaIxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHttqLekJQIm0CtGgOTqIP07EcCz0E1N/vG7e4WNWzNFx6nqqH
	yZ51or5DK41Z2z8zc5AkslbROWzC/NWu3/psM6zzipY4KocYfUMf
X-Gm-Gg: ASbGnctmsHa9Z6FtZBKK99TLYX4t0nhXeDHwvsOyhNJjTHeVF7u4VWMq9oZATmwTckC
	1zM0x/bIle9rmH0RBzQlXQIZqMgd7/0jZJwZLO/Z2eSwX3jlwQKEdDXI9dORitAKra2Gaa1S9IQ
	Q9PJbp2x99Ew7uXogmEtpvF7TCKQU2bVPBq3NkXn8Sm/n2ZpqKJddNkAtbllODEK46JAdaOjSff
	s0l/BaUu9mJj9U/WrYnu7jrxF/fOcdqtUdeUap8E/om16Iuh4ZoJ265mdxhDkaSUbalX2/iWpBQ
	58b2PnQRqNzuZNazK+/h9SeNqtl4kQ9nXdmjgLGpYQYHrK6tnNgiRCfIJuOlf+t5dQc1r9zBU0V
	uQN6HcX6HKA==
X-Google-Smtp-Source: AGHT+IGmbxdINLBI7rtKGYMxXUneyJ7nnQAQgKQLbaZKROKl7Qcon6wI0LUOa89i0J1FawJuOFiy/g==
X-Received: by 2002:a17:903:291:b0:225:b718:4dff with SMTP id d9443c01a7336-225e0b2a4d7mr209695725ad.53.1742278491278;
        Mon, 17 Mar 2025 23:14:51 -0700 (PDT)
Received: from ywashizu-z4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5b27sm86287255ad.255.2025.03.17.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:14:50 -0700 (PDT)
From: Yui Washizu <yui.washidu@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	almasrymina@google.com,
	sdf@fomichev.me
Cc: Yui Washizu <yui.washidu@gmail.com>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] docs: fix the path of example code and example commands for device memory TCP
Date: Tue, 18 Mar 2025 15:12:41 +0900
Message-ID: <20250318061251.775191-1-yui.washidu@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the old path and fixes the description of unavailable options.

Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
---
 Documentation/networking/devmem.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index d95363645331..eb678ca45496 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -256,7 +256,7 @@ Testing
 =======
 
 More realistic example code can be found in the kernel source under
-``tools/testing/selftests/net/ncdevmem.c``
+``tools/testing/selftests/drivers/net/hw/ncdevmem.c``
 
 ncdevmem is a devmem TCP netcat. It works very similarly to netcat, but
 receives data directly into a udmabuf.
@@ -268,8 +268,7 @@ ncdevmem has a validation mode as well that expects a repeating pattern of
 incoming data and validates it as such. For example, you can launch
 ncdevmem on the server by::
 
-	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
-		 -p 5201 -v 7
+	ncdevmem -s <server IP> -c <client IP> -f <ifname> -l -p 5201 -v 7
 
 On client side, use regular netcat to send TX data to ncdevmem process
 on the server::
-- 
2.43.5


