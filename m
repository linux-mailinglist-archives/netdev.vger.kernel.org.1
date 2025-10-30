Return-Path: <netdev+bounces-234284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283EC1EC1E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7EB19C51B1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06D337109;
	Thu, 30 Oct 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0ZmbZzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6238241695
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809408; cv=none; b=YfBj9i/QZTUeGPfdqP3Bd/ql1gqapK3SQ1S6zqwXuysX9dQdgcctFICE4QVfWpVl+UOi2VcaKO43cZbEWdbcZLKJA8RPR3mGUR2IVqgt/N+ws5WGzwYFnC65vfZn4wAJt6HCyuP4CBqnbKnMZZTq5fGl62UfnTtXon5y0LMC+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809408; c=relaxed/simple;
	bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzW8WTpO6qNFm5dU1st+nKgPxT/56GY6lBOPL1fHiXAzXzOLRWvLnnIJgOqlFsVRv5JmwbTllF2Bi4oE7FzibG5XsVCaKGOTuBU2BU9YS6mXXGUeTBbgSTAEUUAxu3dAv4M56C045aXS/QxnGISnqWukzZxih5PBZg4eaCFWrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0ZmbZzI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so840299a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761809404; x=1762414204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=V0ZmbZzIGnlOpu/06RNsyXxKeyupSXjb2mOzW3Wqkxq1KrJRk9iKcal67eoeNvpXJi
         FuOSNPtyqOcDo6QeOpicA7UxeRi99wd0BDn5IPVSXesgeBJvW/ewK8qmvPpDgJFJfGq5
         Bt6MrW60/qHSifP2n+o93iQeTKGtGGLEpfNwOHx9N3HpZ8aS4jRrR/JR8CjFiTo7TjRW
         WGxO2AdkSkZjUKtQHZdWh1cQ1ck2D1yYGy8x4bOaT78FmyCLGbNGeNSdu1Hvs3k7kGUS
         ihHqzSio+tTZvyz9+hqiEGn+Cl+p2lJ6jhoYLNGWZEcSq5umb0Eo/ng3VFBrM/t99X5j
         ossw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809404; x=1762414204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=J0E3drEJrvOEaQjiT8qmg3tmO4qM0S4nFoysE8T2dds8e70Lf0dSIhN3rzZgsaRcwb
         +gMlF8c6FfbrlToxXj4hnIzu/sKuVSakLtnZ1AX+oGI5JkTYjFLpK7ijAO3t5HOYQNF9
         /ZO+ZzwXMDaVblmrtr2gho83exXyU5JoSequhswri8Bw2y8gwUgc+z6fVAGklRr/p16C
         CreI0uKBBYqFtdiD8/Fxnd4oZp/yQB37dmirXaRhGCuuekuW6UMgMVZnXfBN00WkK0by
         xfOiTs8SpEIxFYENyM2m8DMPpnxQCds9TPYOcnNZ8ovAkbWZ8ea0U3EeiXrpQofL/slV
         XwtA==
X-Forwarded-Encrypted: i=1; AJvYcCXf4KoZ+MYyejADWMK3QmC1rG8j0A8GXQIXzGo1hwAszjyWtjWmczbchvimCGy890jhc07qy0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwKGVUxjZaFC7FBESOo0neWhmbrF7qlqnHz2/XK38x3ts6ocm
	l8WNyvlZ5XHjWwponybSMzbq7E4Xc+nsJupIsgrzw9AKkD/zE8MnXr5A
X-Gm-Gg: ASbGncsc/lhFZdiyGt767TSjP3FYqsQ+k1TTUO0lBkVFGBE49ekbDEpeSKLb6Dz28BL
	fSHLaJ5kGNAy5d1K3RwYD3WIjJlf1apaeB+9rm/xQJx9TncQ4ux6IY4cqgxfrqgg5yp+SIIfu7L
	9Cfa3sjkPa+fMLBYiSE0YiSiLHwRJ/bw36Uk0gzIvGTKdUcPrCUNPoOiGL5PgmnlgKAMTFzHhiY
	LEnN73TpCB6xRe3vaHlyB7AJK7F65f8QyGQohUbp6JKrJB6WvA4SkVSkZIPbbKVwsZKYA78mxa/
	MSlZPNcoW/SPzs9rb/LkbJiG0tPClBmkJBleXFTnICG4brjekdklshyQOtJL9UUrToExLpEWxMC
	RFwXSjOyF92Bs6AvBO5jD7UWqkfizB8fX3MlFRj7UClZIY5PYEbe6niag1nwVazHzFmqyY9qGp9
	Ce
X-Google-Smtp-Source: AGHT+IHmZ2LrOAPsOHzLCV0R7WL6u7SHBbA5fx1AuypMoq9aZiir9lY6E508nqoYTXIY9ZDt2yElfg==
X-Received: by 2002:a17:90b:3906:b0:33b:ba50:fccc with SMTP id 98e67ed59e1d1-3403a29a3c2mr6444652a91.18.1761809403953;
        Thu, 30 Oct 2025 00:30:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3404be704efsm1002505a91.0.2025.10.30.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:30:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 358A34209E4B; Thu, 30 Oct 2025 14:29:49 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Documentation: netconsole: Separate literal code blocks for full and short netcat command name versions
Date: Thu, 30 Oct 2025 14:29:44 +0700
Message-ID: <20251030072945.38686-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=bagasdotme@gmail.com; h=from:subject; bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnMwhlOXPI/DJQmTfk5adEEqQUnNix8yLrm1ou9Mbpf9 rlcfROj31HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJTK1k+F/xcGfWlaBJJ//J ZvqcPx3p9qUw4oXfE9sDYj9fV11zW6zKyPC4x7tt2V7RhLQMT7s017pXX1aHaCvv7b3DduBVTH+ XHhcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Both full and short (abbreviated) command name versions of netcat
example are combined in single literal code block due to 'or::'
paragraph being indented one more space than the preceding paragraph
(before the short version example).

Unindent it to separate the versions.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Apply proofreading suggestions on patch title and description (Randy)

[1]: https://lore.kernel.org/linux-doc/20251029015940.10350-1-bagasdotme@gmail.com/

 Documentation/networking/netconsole.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..0816ce64dcfd68 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -91,7 +91,7 @@ for example:
 
 	nc -u -l -p <port>' / 'nc -u -l <port>
 
-    or::
+   or::
 
 	netcat -u -l -p <port>' / 'netcat -u -l <port>
 

base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
An old man doll... just what I always wanted! - Clara


