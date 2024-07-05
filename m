Return-Path: <netdev+bounces-109523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE9928AEC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372911C22C9B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649F16B3B9;
	Fri,  5 Jul 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="i9hV+lBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976614A08B
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191187; cv=none; b=gcPeJUjn9tecMkXJAeKqi3AUaFe+EuH+JurXskMSta4RLV+7QGem/b0n8jue6m/3swBjwpOIfMcvUZpYKzHlkMGbTgSB6JnCvATGu5NAf+K/ZMEzepxzv899/jS9DgooOd7oUP+B9XRampXalm6JIuOaynoRktL9uB8EzP2LCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191187; c=relaxed/simple;
	bh=+pqWVBqkqyyxaxHPjqVZeshNZhGJ6wL6xpok/fIsgRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJr5KhproXK5hfLiG9KJKiI/osxcjukS7T0rHM2xzCKcVcwgGkzKrAPccP2CfvMYrJxUCrkQnLLJpX38pUDKS4kE+DXHRPXu5w02zFeQMnK3urryrHKoyviNxjHnSph9wGyo94ubyoiny53iMv/XCmkipHVFQIG+M64YbpkEyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=i9hV+lBV; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-367990aaef3so1159195f8f.0
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720191184; x=1720795984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo/5SKx7wk2yt6V2uqgEtL5Y/bvMQ6AfCdpyIiS3yaI=;
        b=i9hV+lBVTQzCYpiDHwoh9KLHVBnfAyMbQtQPspyaX9G0YyfOu1WseoJkx9m+skm9Hg
         YiHbbZ7vxe2jpmKETTqqhYdpBWKPOMRF86XiSuEEs/8KCvEVe4HOUsxQ1ncDlOxxRDx2
         0KjwZjJmbTNY3i2wF4KKyPqOP5l0uNAgSOJYYJMj9axSp8YaRYhoW9/P8vWwnMQWcRCC
         wty2zed+Go040y5Qogb7LynYkaGqrGgP2ea1E3CcdUXcj/fs7fc3Mw0rl1pWOSvzoI7G
         h9ujxmBD55h7Dz2L69GKhDjJS54G+Lao+Aj5jzt7Erxx2xii9gt72sW9CpO7QV/XOwNv
         Mb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191184; x=1720795984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo/5SKx7wk2yt6V2uqgEtL5Y/bvMQ6AfCdpyIiS3yaI=;
        b=w3ObYe/wmCn07VBuT/TDOOsSCPwhouZSzF2BJq/zFfPXfbVLB3CBHNUkebuFPac+YZ
         8Tgt0l1GueLlkCHqDoW6tD0opViIEreh/8JraNxh5LkaS6OYAyMIZFfTTbjdZ70I+ek+
         cUxaA57c0nlypQQ2hrwT0GXsy1fXRbpCuO70eeSYxd/Lhewv/rb85o6AEff358jrpgPr
         bJSjHL3Sb33FVeqY3Hv3Dsvbx0ojgbP1cZ3kMxTTNcbCFThx7xoZ5bZ+Le2lq+GspwUf
         EksnlUXIZ1Xzc/tU1NCL1Wmvg1EP4wg1IqiK0Apzkkf/Iem9TT22H4vtYG5xIIT1kYRC
         zEPA==
X-Forwarded-Encrypted: i=1; AJvYcCXA0gbNgEUhJDeU4wqw9Y0n8hAhHC6mAxGWNkS39ujgVVhRRr6iTjfdEQW1IcS0AqBKL/CxLd9nZXRPJoRR/TQOIJtN2DC6
X-Gm-Message-State: AOJu0Ywo8lR65rBIKFuIZUgemz6bxFu3M+j3kAGf+Lyjjmc4tugR3zeu
	DcXNnID0VvinBviDUakWgWjUdraLgYxsWcwdG0CY0Yk+pCq8Py6Oycfx5OHSBhAwf5ZpNlQTIwn
	6YRvdOpRjTQln9YfmB0Q94/aTAHMnbNQC
X-Google-Smtp-Source: AGHT+IGRyz5ZBazpzX2eLaB9v2Tz7oE4ieCEnDHzI02CNK/3fnMXDteuTMHE0PLrBatJwy2EyRC4IdrXkhqC
X-Received: by 2002:a05:6000:ccb:b0:367:9b8b:6923 with SMTP id ffacd0b85a97d-3679dd7c286mr2774095f8f.69.1720191184097;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-367a183afa5sm80623f8f.4.2024.07.05.07.53.03;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id C633960117;
	Fri,  5 Jul 2024 16:53:03 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sPkJ5-007Cqe-GH; Fri, 05 Jul 2024 16:53:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/4] vrf: fix source address selection with route leak
Date: Fri,  5 Jul 2024 16:52:11 +0200
Message-ID: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
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

v1 -> v2:
 patch 2: Fix 'same_vrf' calculation
 patch 4: remove test about the topology type (only symmetric topology is
          supported now).

 include/net/ip6_route.h                          | 19 +++++++++------
 net/ipv4/fib_semantics.c                         | 11 +++++++--
 net/ipv6/addrconf.c                              |  3 ++-
 net/ipv6/ip6_output.c                            |  1 +
 net/ipv6/route.c                                 |  2 +-
 tools/testing/selftests/net/vrf_route_leaking.sh | 30 ++++++++++++++++++++++--
 6 files changed, 53 insertions(+), 13 deletions(-)

Comments are welcome.

Regards,
Nicolas

