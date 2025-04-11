Return-Path: <netdev+bounces-181708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C5A863F1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8523B1273
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD817221FC2;
	Fri, 11 Apr 2025 17:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAB2367D4;
	Fri, 11 Apr 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390876; cv=none; b=az+w8i4DLWl4YFyb5o6CVm2Gsv97NeI+F5wtDhL64rRaq0yp9OKBr6bJUqlrDWO2oKanXK4JKoSey1/yohN8p1cXZdgPI8ma3gxzu8uhssPMueZ/UWgQtXJRO2U89kaJqsG1v1zEBDUpe4EjJEFovWdRN6UFIjeieyXyvqAXBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390876; c=relaxed/simple;
	bh=HSZz/J8OsLYjC/ROSdHcxkLp0rgmkS70ZHME3CFezHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QI4NK2OYPaHxqqUXOQ4As9jBjGl7Eq5nULfSrCjLAOpP+pYEGpGJoFlPT6Pxd1+XFRGEqNCRpB7BbhquIw8aCrZ1C6B7R4UK7BaTpFmyeRl2EmJRY/l9ZiDu2+6/UQZmS3yKMa08SDGqAUzeGa6e6XP2Zd5tP9qW/hLlaeQB2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac339f53df9so417390266b.1;
        Fri, 11 Apr 2025 10:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390872; x=1744995672;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY/v3WW9SQPOrr34FUznkgLPnhjrJ/SmM0/ToHXTygQ=;
        b=ZgdNaapIPX0nLybbLdmGgNwRMaBgSlYCWkSGsowns6GKQE1x8UPTDUXtBELkoW6oE1
         QGSd5QH1ltuzUqDYr0UJRVl4sJQTiIJ+MQtbSkPqn7iouF5CLUf5pSvvFUagqOU2Peae
         OycMlgUYMmc7Cfc16GAiqw6eaLvnt3Ifh+5+25/qBkB1cB+Eyb+PFc7lw68Qia43bIqB
         j+iR8Hnqjs5elzz6s2ApeXY2ZzcOWOUj8T3UGYNGncDAkI4hiXNObT58ApWhwib9mGxF
         4am5Y73mRluyDHT2fO4oBHJfmtY9XJ5PeeZvetPu7R3BCnaTYIfdrCTnwE5VUkoO9YjP
         Asag==
X-Forwarded-Encrypted: i=1; AJvYcCVixbZON/8+pGD1YK4RQwr3Fw0DjuEKlk5EsTv/PGmllJHp3BTQKbMDKV53/7/FxOSw6nw4pPgTZ2028zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKPy6vTEO4Alw5NpC8ZWlLobPvjSE/W6c1ruQLeLod9Qsszoh
	0PwQivD2GNl+2I54Bpq8WbeAUDe5/uj8s7EpTHlLNWuXxhkESrku
X-Gm-Gg: ASbGncuRpu/5PGzkMiS8cvlKOGmpTlVwSyHSO4V8B6JrmZFd7Ykt79VamPLRI9OW9l0
	hTiLvzU944LF+iiW+cufyNZGzKuZG3x9o5OJj6rcAAAqZVSvjWLejGAqTGPHR7t5zImc51P//S8
	crV/KGXyBQ5ZNdL9L1bpj/T4f3YKKIj9MNyyS4zfytLnWdIlbDQA3V/yJbzzi1ppnULt1Zi3RfW
	pkcq6W/J+Frjtq+eoDWU1Einakd2vxIhXkvxP5h+Q23AmYHMGIHSoN/W+baxB6EuFQ/tVE+Qw+z
	9WG/IZghUR+nlV1TqHbr0hG3TtDqZDWbvksH1XNtkC8=
X-Google-Smtp-Source: AGHT+IHf6++unxKUTYF3dDzM105nSzxZbfmqcbpU/spFyzMU27Dr78Zr5/O3L6fW18EjhNdu/DFNAg==
X-Received: by 2002:a17:907:1c8c:b0:ac6:b729:9285 with SMTP id a640c23a62f3a-acad36d91f1mr346277366b.55.1744390869994;
        Fri, 11 Apr 2025 10:01:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb317dsm463790266b.2.2025.04.11.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/9] net: Introduce nlmsg_payload helper
Date: Fri, 11 Apr 2025 10:00:47 -0700
Message-Id: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9K+WcC/x3MSwqEMBAFwKs0b20gHwXJVYZZaNJqg/YMiYgg3
 l2wDlAXKhfhikgXCh9S5aeI5BpCWgad2UhGJHjrO9s6Z3Td6mx8zn0KdhxCl9AQ/oUnOd/nA+X
 dKJ87vvf9AKDLLxVhAAAA
X-Change-ID: 20250411-nlmsg-2dd8c30ba35c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=leitao@debian.org;
 h=from:subject:message-id; bh=HSZz/J8OsLYjC/ROSdHcxkLp0rgmkS70ZHME3CFezHQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrTzzQv83IpkzISdlIEZ6glS37soFKNHoSH2
 thhYBquqRuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK0wAKCRA1o5Of/Hh3
 bTacD/47YliauK/dfacgUku5bKARkLozY4Q4UUDihtSOHodOyckyzjrB4JS8+2B0y2kkWDXHA+V
 j1/r4E18vpgxCTC9VO1Rdb+WnFUt0T3x+6ww2ytCSWz1C/TOsiJ3O+hUPO0bxFoQvOaOKGTlV7k
 WG01p0yQjRYZjfgfaX1CoDZ3pE8hDtbjGIWR2vOFtLzc9d4CXR1Os0S+MRlE0hCZI1GjGvUt6wR
 AgJyTrALKVMDZEpPaYfcx2D182/dtaPnAA9n8JaUkruqNSEJWUdx2GzqapmVi1ynCIbCprjuOu0
 qaDA29NorwVAAum6e/XD5pgHvLqZTddwBgWGiqPgmUXN79X/+cNxBSpbBs/KqY9joECM4o+ohku
 xeWDfB8xzdyrH4AHpICx/A9QrvvV+AmoEIADqbhyTBcveUR4Wn289AuGW/92mQJxDq4V7F6Ui4S
 +HdNNjemtU3LMqyVZ7iU8Thqxaw8JZH3XMvPXJY2l/8g83AgvmTHtF/qBmUe/K7fgMmNT19D1KI
 h4zZC8tbNDVeVAAk976L1gfOptBhjY1VLriXbQEeiy9cpzD1gKrLhPaS7aTEI/ecZOAIXnQNaRL
 MiHwDez5YC9/UNKnuefN15zPOLClQTRLI/TECPEVJ2v/J2IaX9jTtL6HBQhGlpzlE4+SD/oyE5p
 Lg8smjiSJgmVIxg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

In the current codebase, there are multiple instances where the
structure size is checked before assigning it to a Netlink message. This
check is crucial for ensuring that the structure is correctly mapped
onto the Netlink message, providing a layer of security.

To streamline this process, Jakub Kicinski suggested creating a helper
function, `nlmsg_payload`, which verifies if the structure fits within
the message. If it does, the function returns the data; otherwise, it
returns NULL. This approach simplifies the code and reduces redundancy.

This patchset introduces the `nlmsg_payload` helper and updates several
parts of the code to use it. Further updates will follow in subsequent
patchsets.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (9):
      netlink: Introduce nlmsg_payload helper
      neighbour: Use nlmsg_payload in neightbl_valid_dump_info
      neighbour: Use nlmsg_payload in neigh_valid_get_req
      rtnetlink: Use nlmsg_payload in valid_fdb_dump_strict
      mpls: Use nlmsg_payload in mpls_valid_fib_dump_req
      ipv6: Use nlmsg_payload in inet6_valid_dump_ifaddr_req
      ipv6: Use nlmsg_payload in inet6_rtm_valid_getaddr_req
      mpls: Use nlmsg_payload in mpls_valid_getroute_req
      net: fib_rules: Use nlmsg_payload in fib_valid_dumprule_req

 include/net/netlink.h | 13 +++++++++++++
 net/core/fib_rules.c  |  4 ++--
 net/core/neighbour.c  |  8 ++++----
 net/core/rtnetlink.c  |  4 ++--
 net/ipv6/addrconf.c   |  8 ++++----
 net/mpls/af_mpls.c    |  8 ++++----
 6 files changed, 29 insertions(+), 16 deletions(-)
---
base-commit: 0c49baf099ba2147a6ff3bbdc3197c6ddbee5469
change-id: 20250411-nlmsg-2dd8c30ba35c

Best regards,
-- 
Breno Leitao <leitao@debian.org>


