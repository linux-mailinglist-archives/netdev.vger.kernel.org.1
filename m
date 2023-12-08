Return-Path: <netdev+bounces-55175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2CE809B2D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C92B20D13
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5994C83;
	Fri,  8 Dec 2023 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfUyJNOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE010DF
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:51:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso1210151b3a.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 20:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011101; x=1702615901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUypEyHe6FZ/tY3Lu8OcnY0v8EJ6vWIxwcYdiILbA4s=;
        b=JfUyJNOyWUHbfpG787TpCSzZwKRa6uEiXXjZs5CTHdllvDOIkURImK7GOLu0yjMVjo
         iCgHIOjGJQTg/b+lZLEk+lPHtkoYpYwr4+O2M2hwcCD45Lhywpa2DB/UmjQfv5BjgZX2
         NtugJ+y5WqR9inct+MJEXPCKjmRU9E4WYKEcIvP5bj2xgMJIwuDvMLtxVIDQFBsh1OG7
         WdeYGhDQxx4Jc3wswTDTXV60jmCMvGHDKuxQUfrOCtk9vsEMwHQ1TAJ/P79MCudcOfAD
         RbuV3joTV0ZgZQW5W90xPc972xYM3qdLUzJVOhRt8wCtVXgzK7GU9JglFbAsCtzO0kDd
         y76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011101; x=1702615901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUypEyHe6FZ/tY3Lu8OcnY0v8EJ6vWIxwcYdiILbA4s=;
        b=maAf62R9NuKF/4tU2SGGoghcfQ+LsR1fSPWQPhsHYX8sisFg0K/UoypUSiW5R194UW
         wxZhIJX7t0893DF/CXxioVQoLKJ0FdRZr2++4NbEfNJGQadtM5ZI6kx37nKkg5/i84H6
         dgGAyYy2FDk9qX9NUOrNqRazdriVSoYDzLXWmLdYR3lY1UEDm8IDCC5cdzdFVvubcsXa
         Ea1oRZZrgmfeCDV2/AME8wAZbX1zUTTldNXxDTXwORITxSSoF3tFeKSLAf3xbdC+qAbs
         axLb3Z+9i1+4nRLhTbhIszX4AWchoHM4Clg88Z0wWcVjZhwVOU8khsjsaC0AmJ82nMMs
         4VDw==
X-Gm-Message-State: AOJu0YzbW6qyDcu2qNX8dXZLXfFdtQq1zNeMbVj0MqB9F8NhdvVO1ra1
	fSkhOw5JkZZcCnkSqqNYbqEaeD/ADkZsidiG
X-Google-Smtp-Source: AGHT+IGtnJ8OLJG9Fl3GB8GjgYn1mA0iEKj7NLrF52XYNd1ZL9F5iQnAREiAQyIwd+yIX7tyIMeIXA==
X-Received: by 2002:a05:6a00:8e05:b0:6cd:dece:b73d with SMTP id io5-20020a056a008e0500b006cddeceb73dmr3426349pfb.18.1702011100770;
        Thu, 07 Dec 2023 20:51:40 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b006cbae51f335sm657865pfe.144.2023.12.07.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:51:40 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: [PATCH net-next 0/7] net: dsa: realtek: variants to drivers, interfaces to a common module
Date: Fri,  8 Dec 2023 01:41:36 -0300
Message-ID: <20231208045054.27966-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current driver comprises two interface modules (SMI and MDIO) and two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO modules are, respectively, the platform and MDIO drivers that call functions from the variant modules. In this scenario, one interface module can be loaded independently from the other one, but both variants, if not disabled at build time, must be loaded for any type of interface. This approach does not scale well, particularly with the addition of more switch variants (e.g., RTL8366B), resulting in loaded but unused modules. This also seems to be upside down, as the specific driver code normally depends on the more generic functions and not the other way around.

The series starts with two preliminary patches. The first just cleans an unused function declaration until someone actually references it. The second one moves the of_node_put from the driver remove to just after it was used. We don't really need to keep a reference for that node after the MDIO was registered.

Each variant module was converted into real drivers, both as a platform driver (for switches connected using the SMI interface) and an MDIO driver (for MDIO connected switches). The relationship between the variant and interface module is also reversed. Now the variant module calls interface functions, depending on both interface modules (if not disabled at build time). Although probably in all devices only one interface will be used, the interface code is multiple times smaller than a variant module, using much fewer resources than the previous code. With variant modules as real drivers, the compatible strings are published only in a single variant module, avoiding conflicts.

The patch series also introduces a new common module for functions used by both variants. This module also incorporates the two previous interface modules as they will always be loaded anyway.

Finally, the series moves the user MII driver from realtek-smi to common. It is now also used by MDIO-connected switches instead of the generic DSA driver.

In the end, the driver relation is simpler, with a common module and multiple independent variant modules, and we require much fewer resources.

Tested with an RTL8367S (RTL8365MB) using MDIO interface and an RTL8366RB (RTL8366) with SMI interface.

--

Luiz


