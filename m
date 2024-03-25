Return-Path: <netdev+bounces-81695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E393B88AD2C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F18F1C3D8AA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D95CDE9;
	Mon, 25 Mar 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MerxlVmB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219D55761
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388240; cv=none; b=HgK1c/uPMGZzDCucLeTGE0fIaksEpGP096cTre6dRTsC5Li234aeYd6WbGmynIw58oCSsiguuq3TuH25k/oLgNITT7EYHH9JICww8diypQ7NVNgeA+ULtUT43h9DI2Pywehez+6f5pfTDTJnRSPVGT3lU8H463qHawa1ehxI370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388240; c=relaxed/simple;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzyEEgwNhukbmjpMR8soi+ZK24BJMV7ctvVPaKE+AJRfVA+yZzg9qOFER7zeYr7debZKTSwDB6CA16JluRiSf/QJyCiLrz8ytuB1m5N/6E+wGwogzAnjOA+44f18VqTEIiDWuj3p98tvFlxAwzY87Qngr+khk/3jGytMFGsI63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MerxlVmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D9C43399;
	Mon, 25 Mar 2024 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388240;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MerxlVmBZ8cYUqitl1hpf9nL1diqA67y/j5uM3lwFc4h6QKZ1LPVO2YZNlPi+FJA0
	 JVMVG531n47GZ3+o9MaolopnOF+45NVurAPwRn4hkmZp0OROgy0wvafy7k+LD2dRpn
	 Io4zr6A22hmN2roEPrfdVREeZWiYy9VV8zwntxseYJXpMh1d8IC2j/Col0AJBV1MAn
	 OO3/Wo1lsyeeJGBszC2ALJjbvHMO0cZKtLxZa6M2LhhgV5CzlcEqtJhxTO9CvLvCu6
	 7hLGojnlb756o1EV7ULHF46JwLP0ovoYCddt/B+D5WZRfJlsN4vcNpNYlEDsx6wQ1P
	 KCrm5621SIjbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	jiri@resnulli.us,
	andriy.shevchenko@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	pshelar@ovn.org,
	dev@openvswitch.org
Subject: [PATCH net-next v2 2/3] net: openvswitch: remove unnecessary linux/genetlink.h include
Date: Mon, 25 Mar 2024 10:37:15 -0700
Message-ID: <20240325173716.2390605-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325173716.2390605-1-kuba@kernel.org>
References: <20240325173716.2390605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only legit reason I could think of for net/genetlink.h
and linux/genetlink.h to be separate would be if one was
included by other headers and we wanted to keep it lightweight.
That is not the case, net/openvswitch/meter.h includes
linux/genetlink.h but for no apparent reason (for struct genl_family
perhaps? it's not necessary, types of externs do not need
to be known).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: pshelar@ovn.org
CC: dev@openvswitch.org
---
 net/openvswitch/meter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/openvswitch/meter.h b/net/openvswitch/meter.h
index ed11cd12b512..8bbf983cd244 100644
--- a/net/openvswitch/meter.h
+++ b/net/openvswitch/meter.h
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/netlink.h>
 #include <linux/openvswitch.h>
-#include <linux/genetlink.h>
 #include <linux/skbuff.h>
 #include <linux/bits.h>
 
-- 
2.44.0


