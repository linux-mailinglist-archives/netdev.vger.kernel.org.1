Return-Path: <netdev+bounces-230337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B80BE6BFC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1305F4FE610
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F330FC02;
	Fri, 17 Oct 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0+vrWH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6F3346A3
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683551; cv=none; b=J3/P9aSuPOoBng88p2HM7rAinLbvlxgP03LlrGuK/mqhgu9RH7rmhMoTLO8ENIFA4k8d/atDfR5eMmLHEaanN/gW+5+bA/eVwwmNVuuriRlYWosaerGE21uHsiQmSUGPXnTB/rDEwpsb9JBU9syewIbuiKzNlIQyRCbG7X2xwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683551; c=relaxed/simple;
	bh=FYvJjju1WVaSiGZ+rPPQkrZA9117N9fCrf8pnzruHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEu3SpWKD1GOLlfGQUyYbxwH6NuwwAwyuhh591+dpp8Vb+Bj8OtTNRpljP8cy0Nyq53NH37fnkrVDnQPj9bP2J9VcGjsd3D6vwzk7oj+aJZyoE0n2BDJ+EeZJBD2T5Y6VLRiT2QyBpl5f2fq2Fh5FUE1hSb4QHi4k2TkX48cxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0+vrWH2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so1078566a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760683549; x=1761288349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OTXlHG1bxvEhqF+MtL8+GAk+TyLUEMZOGcZpRcNlI8=;
        b=N0+vrWH2KiVaSXwLjggSvWpLJc82iPNfw3euYD4UirU7w7bLhwOMSHiT8i/JCQeHna
         iyJ2PfM6OL07cydWFXL78RBCrBqqCEnCWJaLOrpmAgr7PZj7LJeLQfj5jfUVKQpSCt2D
         H3Kqw/d9krBPlxqj6qgOcjlnPKTJ89Px/TWkBHic5myGic5jtWW56tJf3zOMZqd/RyRl
         KjU8Ddkzw7UxwJ08LzzUQJHUFbEVqp/rS7qwFstn5cga1GZkrZZON3+Gl0ayaEkiicMU
         +KK9MD8YJ5TgsmwuHdz9KL7Rlk3er4bg+r9Wra9Tur1HEum1aO6al6zvOA3pQxwyHWnF
         h9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683549; x=1761288349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OTXlHG1bxvEhqF+MtL8+GAk+TyLUEMZOGcZpRcNlI8=;
        b=pLd+1Vn8tSbyXpYvtXe3FNG4i5B7E/YJyRkKiMg61uNmaddVKvMaQE6Enkxoz1v6rG
         wJimQi6/dEw3NfZoR/s9TiCfQbSrzJz9MKDhJ6r3j0Un+DInARIHcjpYhlMzasNg6Rb2
         9Wz6i3Zh39yf+42gda8rIr+UwBX9LmoqtNai+17uIbmWaDg59cb0SDNZ2CVbiL9ElWnI
         a1oX4TKRCPOxQcsfOdNYFc7b9joR8nyLZJXYhyhcQemFNZUZMezwlthcHA+T78YdNoB5
         4dffPpY0jsbi43fqrzLMipRp4LI578QyzpX6iGvAQoiBWpKUW0OXJgPL8jZXLg25dqkE
         c4sg==
X-Forwarded-Encrypted: i=1; AJvYcCUTIpwfaaQm9cRHfu0BxtHKxlk6WR7XK+4xAMo7Fv0NrFuK0sCA11uqXg7xF1uUZY9bxILKvIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsHPXNGtF/ebplpyIIpzGQ/VkZsDaXZe7bzQFG2arhS39nvIF
	TyUPnCwBrxmblS0gswnbFAlTx9UYWAyQOk8NVwfXhM94P2TK4CWlV0ZX
X-Gm-Gg: ASbGncvNn0hQJSI22GJ1E7mRmhj8Z8fWlGc8VftqSCinqtounTEC8N94GA1VySwz8XN
	D/zFnPFiqFdl78xbpzLlliNTO2BkQsIei9jX8BzxkTEswD4/JbYqpEv2+bXHfxkMAEejbh/4Im2
	f1dBUYQYKi795syDVgowCOzQXePArJIN0EOlZvfabWFHYIfaiNfG0Vt7jwa//FtNGZkfMxJ8Y1e
	wZD7q0Kqj+vH71ux0ywsBB/nMnOMn3JsCsNQoxNqaWGv/FLio/7UBHvbjtH2F5W2VzpI+KoXLj5
	DVpLKjqAUapeI5OC0+6B5Ug/kDq6zOMSTW3PswEy0g1ga84RVpfu0Z6n07um9OB3hbmUffHnEPU
	JHf66s5XIzLdi3LTYe0UPQd172T4SQf6s/opNA3bpQNmVQ/d+wGFRrLeyM3ijoypRDZ1Ty4AIu7
	BRCO4=
X-Google-Smtp-Source: AGHT+IHcXLWHNbzKsIB+C9Oh/hpylcx5d6i9aDz/MdYArA+TbwBPxFJyXT0U63tzhiO5gzo4vkuOVA==
X-Received: by 2002:a17:903:11ce:b0:273:3f62:6eca with SMTP id d9443c01a7336-290c9ca804emr30281085ad.18.1760683549284;
        Thu, 16 Oct 2025 23:45:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afd74esm52471495ad.113.2025.10.16.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:45:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B8F034528BFC; Fri, 17 Oct 2025 13:45:44 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	linux-hams@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 2/2] net: 6pack: Demote "How to turn on 6pack support" section heading
Date: Fri, 17 Oct 2025 13:45:26 +0700
Message-ID: <20251017064525.28836-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017064525.28836-2-bagasdotme@gmail.com>
References: <20251017064525.28836-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=bagasdotme@gmail.com; h=from:subject; bh=FYvJjju1WVaSiGZ+rPPQkrZA9117N9fCrf8pnzruHlg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfnxwUPzdpYU3+lm0tx07E8/eWPhZeNY3Ffk7Q+lczh f0etrhEdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BeAiGxgZ9pXxfn2fOvuMYbr3 88+b8v6I3UroLnkQeuFfcXzLt+bdixgZvq3+l+sxee2LV13GyyxXndI741XyXuYW80GbRZX5P8K msQEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

"How to turn on 6pack support" is a subsection of "Building and
installing the 6pack driver". Yet, the former is in the same heading
level as the latter as sections, making it listed in networking docs
toctree.

Demote it to subsection.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/6pack.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/6pack.rst b/Documentation/networking/6pack.rst
index bc5bf1f1a98fb7..66d5fd4fc82128 100644
--- a/Documentation/networking/6pack.rst
+++ b/Documentation/networking/6pack.rst
@@ -94,7 +94,7 @@ kernels may lead to a compilation error because the interface to a kernel
 function has been changed in the 2.1.8x kernels.
 
 How to turn on 6pack support:
-=============================
+-----------------------------
 
 - In the linux kernel configuration program, select the code maturity level
   options menu and turn on the prompting for development drivers.
-- 
An old man doll... just what I always wanted! - Clara


