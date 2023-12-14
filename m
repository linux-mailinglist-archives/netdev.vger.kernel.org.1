Return-Path: <netdev+bounces-57430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0F81315C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E4C1F220F2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025F55C04;
	Thu, 14 Dec 2023 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2fQwETM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54010F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:25:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e2eccf79f8so19133237b3.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702560327; x=1703165127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mhP4t0btZKR0/TW9pUz2FL4rewCv2oadSpMb4oTgd8=;
        b=d2fQwETMICZ/OO5gbMBqNB2HyQSa8MmnkYpKQt0JXKETwoyJ/h7ro0bVZh3PB0W9MM
         2biR2BgEYwHebfiN5TJN40sxyCTjakhHLSxvWrTfBXLmttR5Ox7IblRPAoau8xG0cS9S
         r1MNeTms6jyTf5IqYZl4OG7c71yo6hPu5KdQ8YOEWbgsdziSekTvNUzV40HCAOsGVvsf
         8EWAzcEQcy944jIe9U+0JjE+M2A4uahP686WOyYSU5Pi1lm/3jSZnF+xqLnUwb42PM6z
         Ksi8R+Dl+UaW20rwSDcTGVYiW4angGIrKV/bMnLcE9oVeVyQm83T/7FzuP9fdIvn0JOe
         8MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560327; x=1703165127;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mhP4t0btZKR0/TW9pUz2FL4rewCv2oadSpMb4oTgd8=;
        b=dRXLTtJFRk7laBN+PLj4DORrR88mb0GWh4+1kKfVhGZREyCYPA6EtoTUdf6h12LA+7
         i586ca7snFAHX5NoE2O9EeweOYIdm2tD0IuhoMVAQfMjag81a/roOz1adbq/6DZFB8d3
         xjiSMEUuuHR59kxMjNy2g+921lMnBYnZ6PIT/ZAzS2JaTf3zqyqCn9JiwaPwnx0Dm+9S
         +CBrnMcEgfqtSX9bJ2TgWfEMNC+co+qIVvyD8oAHqH0Js2myiwbUwvrNY/+3xM4vkcYK
         759qS4R2oYxuqHIrLK2o1bl4qN0Q7+AfUVR1lOw3Q4bdleViFXpvjB3qQChrtpgNV6Ml
         j2tQ==
X-Gm-Message-State: AOJu0Yx/R2gaXmX097BK2P2c2Odq383bm3YLsRPYtcDWArS048sN6lDf
	abjPt8jMktOs5YDmafphgaKMtf0W
X-Google-Smtp-Source: AGHT+IE8bIn8SV2li013BZXV2KePtXGoWBnVD0ACCTjAoXNBMrH8qXd67lYod3qpT9jha14b2R7EL9Tl
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:c062:ed85:e322:32af])
 (user=maze job=sendgmr) by 2002:a05:690c:3747:b0:5d5:5183:ebd7 with SMTP id
 fw7-20020a05690c374700b005d55183ebd7mr108247ywb.7.1702560326886; Thu, 14 Dec
 2023 05:25:26 -0800 (PST)
Date: Thu, 14 Dec 2023 05:25:23 -0800
Message-Id: <20231214132523.929567-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH net v2] net: sysctl: fix edge case wrt. sysctl write access
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Flavio Crisciani <fcrisciani@google.com>, 
	"Theodore Y. Ts'o" <tytso@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The clear intent of net_ctl_permissions() is that having CAP_NET_ADMIN
grants write access to networking sysctls.

However, it turns out there is an edge case where this is insufficient:
inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
which can return -EACCES and thus block *all* write access.

Note: AFAICT this check is wrt. the uid/gid mapping that was
active at the time the filesystem (ie. proc) was mounted.

In order for this check to not fail, we need net_ctl_set_ownership()
to set valid uid/gid.  It is not immediately clear what value
to use, nor what values are guaranteed to work.
It does make sense that /proc/sys/net appear to be owned by root
from within the netns owning userns.  As such we only modify
what happens if the code fails to map uid/gid 0.
Currently the code just fails to do anything, which in practice
results in using the zeroes of freshly allocated memory,
and we thus end up with global root.
With this change we instead use the uid/gid of the owning userns.
While it is probably (?) theoretically possible for this to *also*
be unmapped from the /proc filesystem's point of view, this seems
much less likely to happen in practice.

The old code is observed to fail in a relatively complex setup,
within a global root created user namespace with selectively
mapped uid/gids (not including global root) and /proc mounted
afterwards (so this /proc mount does not have global root mapped).
Within this user namespace another non privileged task creates
a new user namespace, maps it's own uid/gid (but not uid/gid 0),
and then creates a network namespace.  It cannot write to networking
sysctls even though it does have CAP_NET_ADMIN.

This is because net_ctl_set_ownership fails to map uid/gid 0
(because uid/gid 0 are *not* mapped in the owning 2nd level user_ns),
and falls back to global root.
But global root is not mapped in the 1st level user_ns,
which was inherited by the /proc mount, and thus fails...

Note: the uid/gid of networking sysctls is of purely superficial
importance, outside of this UNMAPPED check, it does not actually
affect access, and only affects display.

Access is always based on whether you are *global* root uid
(or have CAP_NET_ADMIN over the netns) for user write access bits
(or are in *global* root gid for group write access bits).

Cc: Flavio Crisciani <fcrisciani@google.com>
Cc: "Theodore Y. Ts'o" <tytso@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's=
 owner")
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/sysctl_net.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..2cdda78308be 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -62,12 +62,10 @@ static void net_ctl_set_ownership(struct ctl_table_head=
er *head,
 	kgid_t ns_root_gid;
=20
 	ns_root_uid =3D make_kuid(net->user_ns, 0);
-	if (uid_valid(ns_root_uid))
-		*uid =3D ns_root_uid;
+	*uid =3D uid_valid(ns_root_uid) ? ns_root_uid : net->user_ns->owner;
=20
 	ns_root_gid =3D make_kgid(net->user_ns, 0);
-	if (gid_valid(ns_root_gid))
-		*gid =3D ns_root_gid;
+	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : net->user_ns->group;
 }
=20
 static struct ctl_table_root net_sysctl_root =3D {
--=20
2.43.0.472.g3155946c3a-goog


