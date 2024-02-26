Return-Path: <netdev+bounces-75116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4F868344
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CE61C236BC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66332130E3E;
	Mon, 26 Feb 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5yjaAzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4C1EA72
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983621; cv=none; b=ao/Th6zC/EdNEtoeS177WKVBiXbocqKRzySahszuII/nm1M6s6kYj0HTy+e6nYTYouF9N20VxICprj97BOxUsjJYTYkdE4EWy1L78Mpc9xOeFlEWpUgN/F8Pl19F6rZg2SXGvToYApT4FOBPIwzyDD5jkYHeoDgLEmaAg8ASGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983621; c=relaxed/simple;
	bh=ykEPYXCdPRzlJ39hZUxP9wBS2gTrw3Pl95X4Oaugfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3sFFPSzHO1kOQKSsA6I0qNbw7vGRhHtZ7WIG29EZVh5CTFaPtY/tjU02V/8Frg1Zp5nlz0iczGlu5MP2HRhEfi8jNrId7pEGVW5xQD2yY1eFQiEXBmYpq7eqL/WaxDqEBFycuyxAFLKDoiPfGjfeR3jzDvMN5JPzRf9S0xxI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5yjaAzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88443C433F1;
	Mon, 26 Feb 2024 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983620;
	bh=ykEPYXCdPRzlJ39hZUxP9wBS2gTrw3Pl95X4Oaugfuk=;
	h=From:To:Cc:Subject:Date:From;
	b=G5yjaAzQSCjFU7rFqame6hjMnsPDruHd/yKkhOWcvr8C5A/JarVPiBw2djXwthycR
	 qptQD+zyj3597ltQtnvfKL6KvxCcBoOi2b1ay9H15XJzHbI3O4Eqhz8uJFtze9AKY0
	 oj07MSl8WBxkO4ZMpbEC3n6iMv7dN8lUSrmkPTqOQh0I5NKNM/8WzdYuSByQbOpQuJ
	 Q8TurUk/Oq/hcf29rnvlng8F7zNtpIxYqY72ULnWw5VWmT0cKFe0PvuLwH767nzPAn
	 lN+2nUtbKzvtUgI3+BOn5t5+PW8U7dGPV8UYF6mtCllTdMKr4s7/nAwF++AMuEo/uE
	 gntlsa3YYvV2A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	nicolas.dichtel@6wind.com,
	willemb@google.com
Subject: [PATCH net] tools: ynl: fix handling of multiple mcast groups
Date: Mon, 26 Feb 2024 13:40:18 -0800
Message-ID: <20240226214019.1255242-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We never increment the group number iterator, so all groups
get recorded into index 0 of the mcast_groups[] array.

As a result YNL can only handle using the last group.
For example using the "netdev" sample on kernel with
page pool commands results in:

  $ ./samples/netdev
  YNL: Multicast group 'mgmt' not found

Most families have only one multicast group, so this hasn't
been noticed. Plus perhaps developers usually test the last
group which would have worked.

Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nicolas.dichtel@6wind.com
CC: willemb@google.com
---
 tools/net/ynl/lib/ynl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c2ba72f68028..6bc95f07dc8f 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -585,6 +585,7 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 				ys->mcast_groups[i].name[GENL_NAMSIZ - 1] = 0;
 			}
 		}
+		i++;
 	}
 
 	return 0;
-- 
2.43.2


