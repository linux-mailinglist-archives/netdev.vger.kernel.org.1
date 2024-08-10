Return-Path: <netdev+bounces-117433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D094DECD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F83B1F21B73
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF65F13D621;
	Sat, 10 Aug 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p3PIkjY5"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F01870;
	Sat, 10 Aug 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325960; cv=none; b=YDvb6D7zTfSg+TRFV51LkG8/jhMp+uGQMWtTXd8F1pLpgUA5G3WC0sWVgvz2u67swqvQrqMJ5Nx+aMueKL+Rw19pNkjAnZF1gWRf0nRwcBbiN1c79EbX4yFi6UxFAC+4nRD58u8S5hoYD+96RV3nMahAdGhJB6ZzjXIDxEBrKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325960; c=relaxed/simple;
	bh=qw508Tk/XwtcTC+TKFUZtcPOAckkkwI0TQgE8/DqTHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c84dGRGjAIDRJCuZLLalNGb/5BrYII2iwQ2PEsp+RpmtZT2CDfrtlbQ3KPC3OzS3RzcTVaIOx79qmIWhZxPtlVbBg6Vo7e+pC3RqPGkN6x4Gd83E7Cskg0VQsH416/ISmQcSHlid4ypJMGcnnGAZxQVHPXIhyvT39/sg5eiocJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p3PIkjY5; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ctnoscLicxIArctnosgKqX; Sat, 10 Aug 2024 23:39:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723325950;
	bh=AGjcovfArtVFIWghu9zLuhCEXgg863nLZWImSfRoqro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p3PIkjY5oFWsWRuCPx45WQ9m4+El7JnIEJcla/v4EFisIZwg7Iqja5M5BmhhDCxF8
	 fkWjoXXXQ16oHJMhDEhj0VrJz0a+yNEZnoSNIUt3yMF4JKLZEmbmrKJ3SIP+ouFAwl
	 f/EhkNOBbJmGkSrTY7gBoxZvuLhmR92HL3A555gsh9Dy0xQGIe8cN+7Q3SXZRZLPZr
	 MVzvxXX8KRUyQhok01WgFA7YHqI79uNJkTWPH4ygB/975d+ZriGH139+QG8U/x0LdS
	 dhaq850tYf4fLbmnpz8IL/a6uzBkVaP4nNGRVny+Tfi5VHvpl5q1HTfcvkwI8QJhyd
	 pDbRsGGpXu+Rw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Aug 2024 23:39:10 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: netconsole: Constify struct config_item_type
Date: Sat, 10 Aug 2024 23:39:04 +0200
Message-ID: <9c205b2b4bdb09fc9e9d2cb2f2936ec053da1b1b.1723325900.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct config_item_type' is not modified in this driver.

This structure is only used with config_group_init_type_name() which takes
a const struct config_item_type* as a 3rd argument.

This also makes things consistent with 'netconsole_target_type' witch is
already const.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  33007	   3952	   1312	  38271	   957f	drivers/net/netconsole.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  33071	   3888	   1312	  38271	   957f	drivers/net/netconsole.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ffedf7648bed..48b309e0a93a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -778,7 +778,7 @@ static struct configfs_group_operations userdata_ops = {
 	.drop_item		= userdatum_drop,
 };
 
-static struct config_item_type userdata_type = {
+static const struct config_item_type userdata_type = {
 	.ct_item_ops	= &userdatum_ops,
 	.ct_group_ops	= &userdata_ops,
 	.ct_attrs	= userdata_attrs,
-- 
2.46.0


