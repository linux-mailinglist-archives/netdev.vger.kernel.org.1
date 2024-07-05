Return-Path: <netdev+bounces-109449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA759287EF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BD81F233D8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32814A08B;
	Fri,  5 Jul 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2OeBTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EC149C70
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178830; cv=none; b=W8vWr1G5nZb+1Hz3jD0dAWiz0jbrnUui2Z/Q8sccrUAX6lEgMXKgdBsp+9zzqXbo1404Fv5o86wnMmpgWqiP8ADP4JnR+Ry1G6tBU/N5/52EtGPHCOP0WHo3ZrlX6JE059SjJaPqjuVz0AU/PJHxrVGGN8z+RqTzNeD06EyotOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178830; c=relaxed/simple;
	bh=6dJ7y7qGSnXLmbLAgtUrsUwlBeYudAdFnLWyh4KHBD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucN4drM93YDooshHz9jgUmHuj4IsmTLFRfp5Bejdi110WWl5RT37rHzpZ9EF0e0RLpW5mM0DHUuRRADBOp8LSl1rYctShMoP5sIi0bd0FvovXN5j/uyAb9IjcAeqxr/KWKLoi+MyXf/XYnevF2NEEfjmlZyTqZL/NtLLLM1Jq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2OeBTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A3FC116B1;
	Fri,  5 Jul 2024 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178829;
	bh=6dJ7y7qGSnXLmbLAgtUrsUwlBeYudAdFnLWyh4KHBD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PM2OeBTRf8DHeuKDWxCE3kZcgLXobrGygJYJdr6mWG6pYy5wEkI6ZGHOgUCg18w+j
	 PDFvZ7ttsKeYgR8iX9sjpu8OZXJu/Nvc9vh735FZl7/YjbR3e9mKbsY2JNunYgJhRl
	 OFF9DZH1PkvsXguhCWN01G50+qUkiCbM5pVw+0/QutGrIlgbGNZzmEo7k2UiwpLML4
	 1VU4qyPtgzdUYDfJ01j0NfjLl6cz21Zb1f1/AO3O309ZyR2VOj7nIutayWXLmZbabQ
	 QOjbV/wjJdmcunzR8sckBtK+/UBblIOQeSZK9Zgm9nY2m8zpAsVXjh5g/rpH3iaJSm
	 BxHHa5Es4JltQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 05 Jul 2024 12:26:49 +0100
Subject: [PATCH net-next 3/3] bnxt_en: avoid truncation of per rx run
 debugfs filename
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-bnxt-str-v1-3-bafc769ed89e@kernel.org>
References: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
In-Reply-To: <20240705-bnxt-str-v1-0-bafc769ed89e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Although it seems unlikely in practice - there would need to be
rx ring indexes greater than 10^10 - it is theoretically possible
for the filename of per rx ring debugfs files to be truncated.

This is because although a 16 byte buffer is provided, the length
of the filename is restricted to 10 bytes. Remove this restriction
and allow the entire buffer to be used.

Also reduce the buffer to 12 bytes, which is sufficient.

Given that the range of rx ring indexes likely much smaller than the
maximum range of a 32-bit signed integer, a smaller buffer could be
used, with some further changes.  But this change seems simple, robust,
and has minimal stack overhead.

Flagged by gcc-14:

  .../bnxt_debugfs.c: In function 'bnxt_debug_dev_init':
  drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c:69:30: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 10 [-Wformat-truncation=]
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |                              ^~
  In function 'debugfs_dim_ring_init',
      inlined from 'bnxt_debug_dev_init' at .../bnxt_debugfs.c:87:4:
  .../bnxt_debugfs.c:69:29: note: directive argument in the range [-2147483643, 2147483646]
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |                             ^~~~
  .../bnxt_debugfs.c:69:9: note: 'snprintf' output between 2 and 12 bytes into a destination of size 10
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compile tested only

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 156c2404854f..127b7015f676 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -64,9 +64,9 @@ static const struct file_operations debugfs_dim_fops = {
 static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
 				  struct dentry *dd)
 {
-	static char qname[16];
+	static char qname[12];
 
-	snprintf(qname, 10, "%d", ring_idx);
+	snprintf(qname, sizeof(qname), "%d", ring_idx);
 	debugfs_create_file(qname, 0600, dd, dim, &debugfs_dim_fops);
 }
 

-- 
2.43.0


