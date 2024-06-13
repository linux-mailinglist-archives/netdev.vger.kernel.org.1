Return-Path: <netdev+bounces-103254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB89074CF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CEE287313
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EF145A00;
	Thu, 13 Jun 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3uRsaEib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382D143C75
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287949; cv=none; b=FIKHWozMmd2xb5SuvwR3ec+JHLTcTBLLa3cObNI+CKZ1BWL91rLlgyKP8uGE6i3/4/oQ1VX6PYT1IpqJPn3peeFy67QQETc9rZ7EUbs4IXP3EZCPi8akAu6ANx8L+Ooiyv068KbTglexuL8BNcyD0WraLcrR74KxRStxhddlChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287949; c=relaxed/simple;
	bh=GeOGbq3v86Jc7ISOy46ykJNRjbGIpr55PK9MA4z5Jag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lRmPC5f1eFfKsY7/izOTrC37/8CCSBSzvdjmrthUU+38QRm9fdGnAvLOZFjupX4E923Qr8GIU1268DV2WeEfk2IYMQNEaJ8tKTwFPPlW8lhty6gEl4d3vKa97uHDsnz8MNIJpz9H0+GwU+6SHlRrV+YCFVMplGBzziLkgLNyhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3uRsaEib; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso1609132276.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718287946; x=1718892746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86PihGtHJDuNcrfp9OX8tE5hfkdUir73Q4eXbfslXlg=;
        b=3uRsaEibDNoa/RSXrQgUOz0Wfjf6hLrUXmYcchOJ0na48CKrWJdt8mXWgghGVFBnk+
         RKB6oCxunENmKXvg3pSIs+MF0z4pRdF1xHcTtPKMCObkkxfNMTF6FMaxkW9fTQ6aQXqY
         m6EPwEUTTTTPHyYpu/qk0yw4aE+cn3Z72iLtETNG/gU0J+//eXeZlFIZvhVhWipLNYaD
         q4kIqnXdJkbwUONGjSDIJVjPuLLmx+WV6zF8RECjm702vFxdAjzLSl7VESEqukDv8640
         uwankkw1o5JLyRb0t8j1cuUgMM1PY4CtjdQ9pJnfo38hLh+JGJLuKNK1Yr63s0GYiXgs
         5o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287946; x=1718892746;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86PihGtHJDuNcrfp9OX8tE5hfkdUir73Q4eXbfslXlg=;
        b=WyrpRSBl9PEDhh2Ua9vDmaEeTSeulgpmjm8ZiZ8tcVbl4m4zSXBSl0pZ5CWk0oUhhd
         zOPeMgrjHJ702xiHDW+MC27GKgk24Gbz8j7J+rYZWuUp/5niujm1GC1uGlau3D2bwNt0
         mi1dBEfRrn8COvg3G3SXn38JDBAxF5/r5l4aIJpLC6H9JcDeqVhW3fySHyTdsSCdfQQk
         JzfRGbMj2eE67wdaqagUT8jttx6eIvAqvzPVCBPZqIZSM2ugKCC7ALc8v6bL3Gr4MRh4
         NCrtmd6JTPqttlrZiMz4lLectZjAuqorGZ30VFFvLIHTme3BAYMF8T4DHMST6cz9h+JI
         fmbQ==
X-Gm-Message-State: AOJu0YzWDSCmOO3rX38W7b6epJgWbxRHrneuLrqvHo3oGSavPCQCElA9
	9L0+JJ5Vh6RMAx63QYcQS8swnWEu/0f1mRFi1bpW6SnYKI5r8GYCizPBF2XajpS/s2rIsQ==
X-Google-Smtp-Source: AGHT+IGRA9G+zdZsw6nNiJsUVC0TCc8AMDfYozH5CJc139YMJSax0Sw4HDZ2/VrA47n+Jogrngu59yZR
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:39d0:ab84:9864:b0c6])
 (user=maze job=sendgmr) by 2002:a05:6902:100f:b0:df7:8c1b:430a with SMTP id
 3f1490d57ef6-dfe65e7eb4dmr1387455276.3.1718287946593; Thu, 13 Jun 2024
 07:12:26 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:12:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613141215.2122412-1-maze@google.com>
Subject: [PATCH net] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

without this Android's net test, available at:
  https://cs.android.com/android/platform/superproject/main/+/main:kernel/t=
ests/net/test/
run via:
  /...aosp-tests.../net/test/run_net_test.sh --builder neighbour_test.py
fails with:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_dump=
_ifinfo()")
Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_if=
addr()")
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 45fd88405b6b..e1d12c6ac5b6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3892,7 +3892,7 @@ static int __init neigh_init(void)
 	rtnl_register(PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
=20
 	rtnl_register(PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info,
 		      0);
--=20
2.45.2.505.gda0bf45e8d-goog


