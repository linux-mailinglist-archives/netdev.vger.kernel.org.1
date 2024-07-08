Return-Path: <netdev+bounces-109971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558A92A8D4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EAE281FEE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525B1494A9;
	Mon,  8 Jul 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="K0M6Luko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A933981
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462559; cv=none; b=FoBq5xWpMYKhHuSGZfMIXQynW0Gs7rZC3PArHcLkhvXcCYZI+qSIBaFfha8hK+0MAcXZ/DnlZGoXGynn6vkATyA8qT/3NhX7VZ2KfOgIK4TZHps5xgpfmelaYnf5tuxivh0wjF3U4dMzuoiyJC0kSyodUXgNPZudGg/pOv0+XYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462559; c=relaxed/simple;
	bh=m/CErlLRJJ3fUO4NWJoDaRmhaR3MNBei7okUnUdAaUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVd0zyMpgj54HgMEViwyQzdyxqL3E1a1msIGnc68+R9ngBOdvyODaY6s2DIxGq3uIzmZDY5/cxu0cumF8ln+ufj++y7suT2HdrWrCxrlgbIxOoa996X1xgpfPpt4BWpNPwlzUYkMnF61eqW5J2dACeDB+B58YGh+g2QIwctGqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=K0M6Luko; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so7068855e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462556; x=1721067356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkE/kK1N0TqOPt/eVFl5tIxooYFR+lpS9WPcoWZaHjA=;
        b=K0M6LukoxLriz8Mmy8Fh76g/GNzOXj/sOGa1d+a1FiZCr8oV+D7L9MckEt62B0k4P5
         YoyG86H3z3Wv2216VzTYPvmEStnEtm59dNqHYg5A9RHU09cSIisrgKkUSPzOFRuh9ykt
         tTUCi5MyCfK1NbpHr/9hhhqU1orb2UaMIoNJvM2P5QnBSM6tN9NMC/BtnP1OVjyIQSW1
         agjCvFohFg3W1VODOptdCqmirOtqan5Wt44T62xf5Opuhq9NbC8TKJb4Jjg7B5XIJNlp
         y9EQlAYOkQrfZvJ5wGJajqj+Pu7MqC0VlQQjU/+qB8lQyRkMxlUaLrUMGT8JSs8oAoqB
         4p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462556; x=1721067356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkE/kK1N0TqOPt/eVFl5tIxooYFR+lpS9WPcoWZaHjA=;
        b=TQaC/Fa3F+Etv+IW/FcPB5U5kgGaX6f2XYCH5rpdDFKrcXXaqotgKvrWwGg52WtizZ
         PNvVywqvlF7+ro698cWYYTCJOdtzgRoZ0+AxWQI3bL4/xdA5m8wEL8NHVE1gea/UyiTI
         TkGd0PSnJ04iZk+cje5niXPWJQf47dKW7mdbuDgOeV6Ydct9QelDXFHEuq4lAhHTccys
         uVJRp9NdnVOl+Qx0n0lQmcZ9lPPujOMOuTY9Ab05cXep4XBNCBl6vIWKYuN4GZq2LGj4
         6EJU4/k+NFIW1QwYhWONeKvvZllI4vERmBhYmGv6pm6HCVhtgH+X1rBJDyewS/GVsJJy
         DQGw==
X-Forwarded-Encrypted: i=1; AJvYcCWkAbNxhD1Cpb6iBO0DVhMrXmtEXwjoh4GeeDDWG1igkbuERgcB4SjagpaOkcjH517MRCjLulyll0ETBBGlbvLDIzY8Kfcq
X-Gm-Message-State: AOJu0YwllkJtaQ4q1D74PNEZWZwB1nP05u0CN5Fgmx5hj8aKmbEw0tqE
	yUOz5yM2P0/xWD9mGKKp1fXJX2axR3TEJnkFsf1UcjF4A3kLVrL5bF4q3ijEoLB8i5k0Ezqc/Id
	YBEGNtvUxptDYAcpa0/a8uHKN9sQj7gnA
X-Google-Smtp-Source: AGHT+IGm7aEr3ewNQfqYc2QwfdIsMVn3kr+1EuPX9gYgzjWjYJCNbD1kiXVvCc9eVCVbwTXA8t2znZYSrO8S
X-Received: by 2002:a05:6000:d11:b0:367:96a1:3c91 with SMTP id ffacd0b85a97d-367ceadb1c5mr264956f8f.62.1720462556344;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-367cde7c7f7sm9767f8f.1.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 1209060216;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP8s-Ol; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net v3 0/4] vrf: fix source address selection with route leak
Date: Mon,  8 Jul 2024 20:15:06 +0200
Message-ID: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
I suspect it has been here since the first version. I arbitrarily choose one.

v2 -> v3:
 patch 1: enforce 80 columns limit
 patch 2: fix coding style
 patch 4: add tcp and udp tests

v1 -> v2:
 patch 2: Fix 'same_vrf' calculation in patch
 patch 4: remove test about the topology type (only symmetric topology is
          supported now).

 include/net/ip6_route.h                          | 21 ++++--
 net/ipv4/fib_semantics.c                         | 13 +++-
 net/ipv6/addrconf.c                              |  3 +-
 net/ipv6/ip6_output.c                            |  1 +
 net/ipv6/route.c                                 |  2 +-
 tools/testing/selftests/net/vrf_route_leaking.sh | 93 +++++++++++++++++++++++-
 6 files changed, 120 insertions(+), 13 deletions(-)

Comments are welcome.

Regards,
Nicolas

