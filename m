Return-Path: <netdev+bounces-181889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3281A86C92
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 12:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE0F17740A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EBE1A08AF;
	Sat, 12 Apr 2025 10:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266319E7ED;
	Sat, 12 Apr 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744454460; cv=none; b=OaMpWRksVZni4C08kUuNDc+MiCL4hcyPX/EvbS+BlnX6ahOCvY+hrL8EQzSfVrlA/KHTn5Hu2YXCGhnKEmVtmvQFUkwUxlmFojHKLUHj5/j/WSWNWCIAUaFFkIogA65Eqtq5fm1cv6TpH7AxtP+KMaktfBkaD4iK+8TcD/zN1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744454460; c=relaxed/simple;
	bh=1JyIRWLYbbGPyvyz+jktTJKne0DLaNrSnI6GUVG/O/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seK6AhBK3x/rzgjIrmLMU+tbyZ6S6WNRjOxg4pKaG7FZtQAb5nOsSB6g8a9AdR6CZ8/Fhhta1jCXkkAs190gWLhWsJgKHM+cEGUqjAUG/LEPD3ZVsEIVrVyZ/nWS9MBz4jc1FBTMlOAm5SPY8Iyq1LRAeDQtPAr3IDx2Ay5eCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so30344385e9.2;
        Sat, 12 Apr 2025 03:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744454456; x=1745059256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPpGEdLLDLP9afcNxJK057G2Q4dt6mDwWuMuvaUGFQI=;
        b=fgSUoBaFV/ei5P45d5H2Hm7In6bNyiSwBiikKuekPFHUoUOYgB/WGvarZw+ap993Os
         gPYEu91cwgR9znL98n1Bfh5jm9Kk+jDcgZXHc+y+6TNZm7M9+bqNvwOx/wW5HwHHinBB
         /rOqn28zrDdM8ki9UMGhg8v6BeU4E9HaxQf6RbeK8gELtgHuuKCG8gmJXt5i/onLkEIJ
         C+dwV518aOxZo1oosT5FXycfIx6zRoUCR37D8ZwunWytUABCmd1tNBMGIPvFT0s+/A0W
         KCZ8MkhVuyQ4lqeVQo4wq3OQ9907gIrn3MHhGPk5ZnaXg0D8KEc0r6yN9Or2KoPmQ3tC
         cxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK9fcWs7ofbYUxa26x5K2IMaZtLPKxd6CCplvqtRzMazX3u44iNnv8MECLBIJlC7s+CPJn01cf/8l4r1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGptqHcKJkwVLrs4MY2j1EK0Sv2SHu2TW+2E9XMFF3xF3aQ0PR
	iVP+loY/siQrAuMdgOQ9nbis0EaltocP3VdaUGAyivlwu9FuAIXdiZmkA+uO
X-Gm-Gg: ASbGncuC3VEo9w25eTPKLJ6TGkLjJQSZpXf00GreucbpHYPSh+kz8xz18xD0thLXXMt
	qYQSzrTtSYcKKiEzxpip1udipv09/kKSoPioqd6J914g+mqc0dvy/Z++He63ZHTNCR0sS2QJB++
	mXlqqvHfVu3HxHBv+TEfD/ozqFTM9syZDyq/FMI7CHwbB6JtuN/56I14chRXGPgiO/onfzmPKOV
	vBF6oPc+R94adeWsAjPgCKHqxJGSfAKngtpvxAnGsLe5LlVkbo+UM8kDpgInxNLxc91eag59Tvr
	U9aQBYApTTcrfEJgaGnyZCDL8Um6AyPIWjz/L8mQ3cIHy4kpVVciQB+Tn51s7w2iS53k8kkY/GT
	dtXc=
X-Google-Smtp-Source: AGHT+IGzLyaTB1RvYYX77BpfekTlQrZrf+ZGoA0FeukFOp/MLONdezaHDAiIfqlDbTgoFbCOAgtV8w==
X-Received: by 2002:a05:600c:b8f:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43f3a93f343mr53814905e9.9.1744454456112;
        Sat, 12 Apr 2025 03:40:56 -0700 (PDT)
Received: from im-t490s.redhat.com (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206332d9sm113611045e9.13.2025.04.12.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 03:40:55 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Subject: [PATCH net] net: openvswitch: fix nested key length validation in the set() action
Date: Sat, 12 Apr 2025 12:40:18 +0200
Message-ID: <20250412104052.2073688-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not safe to access nla_len(ovs_key) if the data is smaller than
the netlink header.  Check that the attribute is OK first.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
Tested-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/flow_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 95e0dd14dc1a..518be23e48ea 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2876,7 +2876,8 @@ static int validate_set(const struct nlattr *a,
 	size_t key_len;
 
 	/* There can be only one key in a action */
-	if (nla_total_size(nla_len(ovs_key)) != nla_len(a))
+	if (!nla_ok(ovs_key, nla_len(a)) ||
+	    nla_total_size(nla_len(ovs_key)) != nla_len(a))
 		return -EINVAL;
 
 	key_len = nla_len(ovs_key);
-- 
2.49.0


