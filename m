Return-Path: <netdev+bounces-208377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4192B0B2A4
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34636165168
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B36235041;
	Sat, 19 Jul 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axDLBqpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545831FC109;
	Sat, 19 Jul 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752965090; cv=none; b=GWxa24Pmn47bVkgfI5fIyfglbGpFwdhrCON/LeDiKNBNwUpY/gC+B/KTY8G36RaC+Hhhn9eTkZQUjWCu4eZ0GscddvCpqrB4GNUPODJMK+WbiVeeaTZMBZzdfShSvI4B4bem6u3DOvdhn3HIYkrGmAb+OkFzEvmvfk8X6dS4rb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752965090; c=relaxed/simple;
	bh=tqgCbXQqa963OTPgIIvRmYCGD3/5MkX9tRJNavyTJ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnfigTDg8c8a2VrmQLbTyS+KnatFuNtahhKUNyEeyZu5ijtK7o16LbClBhs2ztZ0zvFLfPJtbeaOwIUt2uFh5Yv0I9yn5WVAK5hv3o4u1BoBUGkOwOGgJnHTIcgpYG3UiEo2sQELei082Eav2wycmwvE4jHEW4JnoGczdFz+CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axDLBqpH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3225727b3a.1;
        Sat, 19 Jul 2025 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752965088; x=1753569888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX0Pf8REK9TMWdAtTnj0GB3nrEpt4gmCBu2EAyyPZWc=;
        b=axDLBqpHzVMGEsBkff2LGzUUiGbtm7q8bE8jw4aKjF7YRL/5AjJQYi1dcVoID1kDLk
         vCSzybIdz7+MGyev2I7tvf+Ts7jBBv0uTk8vhX2AFdfugX+3xM9OLBgX/9xMA8OcDb/K
         s51UhAhT7NBjlKVIMAZWPDkoM9EsW2WXbY6qWffynpfKfUyOVcW5lGzZBYCPzzjRT7mF
         ZM76tmcOzTI4ZLr6PdAoKyr5MItLIFS8H7+334ycgBdhFWd9OeovsJn3kqy6G+jA/wFW
         B87c2/6qUdc84owQAO2TOFO/+qwF5caIx+uftpw+St39c26w88wn86x1g3VzXxPcAuYP
         ANiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752965088; x=1753569888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX0Pf8REK9TMWdAtTnj0GB3nrEpt4gmCBu2EAyyPZWc=;
        b=EAAqsRLCuSidh8FZOPUW2/QICR++GpxZ+oqqlv38GDkxVYHXaE3Cw9wys9zxIwFkgt
         PG2TJM9CjReCbPIe+n1P4oXY2fg/kc7YkYwkUNMzoi8S38dVLqxRYAmsgWp0R0ucgOlZ
         T7jmXq7IY9X4v+8d8pZcQnCt50cb/rwG5oFM9TMjEHHlKr1zNcQ7xFGVO6tBxKXtm8Xg
         yS7pUtzjhZ/qkWPJE9MdegD8VrvKknMLLbhMcCDIwe82m5CEb5KYFZYl6CY7l/9/FK8u
         fBzMLtR2U+r98hKCa21PDTE9LCvN8hXFUE/obl6OY3BOYdQ9Wcg6qXGIIBX9/GZpngPb
         Pp9g==
X-Forwarded-Encrypted: i=1; AJvYcCVKOQ6mSaY0MnUzpNvPi5aajeYiYOga7jKFo1VRgq7d9DjhzC6Fnwu9NTqJyj/XDxAVJhS0Awbs@vger.kernel.org, AJvYcCXnHRDEcPOLpV9Z0T2QToWyoS82kq+e3UICFpv68wrGfjoXUff1wyEhkp0KjaYEnfrrHQHDrf95oosbBSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0r6w+KMW9uE3UvoDN6H+20+ZvMdS92mJZUVJunhbU42qsSWc
	g++vkMFvxop3ftszzwskojmpEHRHAY4X570Luxu+biLVpSAkh1dWe/5/
X-Gm-Gg: ASbGncuaxCWqI7FhK1Kw+ChLjAZkFsSxM9tVVm8uc8t6Eu28+ziLbQVwTKRhLXzOy+Y
	/LCXVE6W2aUF3RmaJsTKF8J1tMTzdSPgpQ5ue9UEh4CBb3dUM/pfazUp88tK0Awh2ESeHp9bp+q
	qqhpzqCgRAUofd71Zo1N8XRSkjqhwdaL/l4BZQ3fb4uAKxNqe72asjMbOVWbDkKRz5+4ykOsU6o
	mMVmrfzVzktdStUtqnTwnrbDf1hPRO4qKcx+KHt/iEoirdsOdgAspTfUSFCoidxPnjdIHoijeNe
	FgOjgbUS/WyWpL8MWHo3fuoxPOzfP8eM6OjX+ZENwrtm3cY9E2Zi9CQLdD9y/PVdN3m75XOZAcq
	GkK2u0wuj8d0jDRYBz2wHig==
X-Google-Smtp-Source: AGHT+IH98UpilUFLm3CbbeUiySk0nOKqWXRoCDy4nXd63SqnoDS0iSFLv6lrwRFkLte9JmXI2aSaVw==
X-Received: by 2002:a05:6a00:80ca:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-75969abde55mr7634461b3a.9.1752965088409;
        Sat, 19 Jul 2025 15:44:48 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15761dsm3340124b3a.67.2025.07.19.15.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:44:47 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/2] rework wg_cpumask_next_online()
Date: Sat, 19 Jul 2025 18:44:41 -0400
Message-ID: <20250719224444.411074-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Simplify the function and fix possible out-of-boundary condition.

v2:
 - fix possible >= nr_cpu_ids return (Jason).

Yury Norov (NVIDIA) (2):
  wireguard: queueing: simplify wg_cpumask_next_online()
  wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()

 drivers/net/wireguard/queueing.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

-- 
2.43.0


