Return-Path: <netdev+bounces-51159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACCB7F95F2
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D81C2082A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893F14F85;
	Sun, 26 Nov 2023 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp/P5cIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBA12E79
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECAEC433C7;
	Sun, 26 Nov 2023 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701039489;
	bh=z/7x+bGlzkXrn4vzoLLsKd1d3vWH/NDa3TmO1ESO+PU=;
	h=From:To:Cc:Subject:Date:From;
	b=cp/P5cIZNJ/F+g6LGi2oT4qvwDr/2iQNVaBDw2olNOwLbeAVntOlZmSUkboP986yC
	 LAqkR2EeVIp55WElG2hHf9ZyqLzC10whwQlrLmROnC618dMzsghzbCP713f6FDjsgX
	 djarfJ/+XYGbKfnVDtIcQjPOVHbiqkl416+4Z/Zq27N39ja8eFJNSEMEfS8KmEBkA2
	 BUJpD30knPlOfhS/v7jNaWXpyAa5EifXmv7K4LKaih1SMeypOlAAryk7IqduM8OCQe
	 Aa4wx8IlQ5wgjiJdiZnhXf0nIs+Fmtz3BtQYePvpf2JhB/VdavXrk0G7vHTfGEB7fY
	 64lyzapZaMmSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	f.fainelli@gmail.com,
	mkubecek@suse.cz
Subject: [PATCH net] ethtool: don't propagate EOPNOTSUPP from dumps
Date: Sun, 26 Nov 2023 14:58:06 -0800
Message-ID: <20231126225806.2143528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default dump handler needs to clear ret before returning.
Otherwise if the last interface returns an inconsequential
error this error will propagate to user space.

This may confuse user space (ethtool CLI seems to ignore it,
but YNL doesn't). It will also terminate the dump early
for mutli-skb dump, because netlink core treats EOPNOTSUPP
as a real error.

Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: f.fainelli@gmail.com
CC: mkubecek@suse.cz
---
 net/ethtool/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 3bbd5afb7b31..fe3553f60bf3 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -505,6 +505,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 				ret = skb->len;
 			break;
 		}
+		ret = 0;
 	}
 	rtnl_unlock();
 
-- 
2.42.0


