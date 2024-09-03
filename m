Return-Path: <netdev+bounces-124428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E129696E5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9664928234A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE70201246;
	Tue,  3 Sep 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="sB+HiUOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28741200129
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351618; cv=none; b=U5y+jWocPdO/lMdWdizvyKAQH4rRTATah7cj0XBb8zm12oCag1FHG1MfIMeeDK5OKPBxsYHyOjEcaJMWOFSRdSb3AMjQ3rGZBrm/f2lrQkxhly4DkZDeL+gpBb1DD8HiufqRQUJzuXRuhvPyP8cnMIdH4Aso/tYBNR/Cdo5Ytv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351618; c=relaxed/simple;
	bh=zQ7ucgyJvJz5JjcFYbNwCsbg4nagkKxZ+nZ3sV8msGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McqmS8fgl1tmLRzHQzUKvYG+reILf2bFKoSD66avWAu/qOV3V8KEyCoSLdAuRM6MgnDzoai71ydn5x7rUhG3yJyh3GtDubtPNBZvF2TN/2BFVcFomulNdqQBK5nFyeZ3WQpDIuDKxfjbKT82/IDvRKiQoKM1/cCYZUEQZILc4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=sB+HiUOy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bbd3bed1bso5130495e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725351614; x=1725956414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=sB+HiUOyKHJXiq/sWK5pJVtBJWtZtPkULfy9u/NqGUUuhyqg65tF6DEXbm3R3kXf1b
         a0LhGQ+EyBzQk5YtWmi0sPa1hei1mVXPmkjUNUuWn1nIePJc2sIi2AtuNWlwCJWWM9C3
         DHjY8zvV8CVm1RQCOUGdnrIDE4Y2TnYlFRmPhWHnK4TRx0uds357rZLBMK27eZvGzEY4
         pxVrMBM+Zn/h/viADzqOGGOWDDrmxGuXBMaG3PxNUbjd7/xEHya5rVq5BHCheLx8cJKK
         XjODprF47UlcxltJA/CFXse0uO2fYzx5tMjGA2VFwcRo1YoVjSpNllDJdO9pLvFkn4V/
         SN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351614; x=1725956414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgKUHrUOMpyjZi6C5EjxXwCmD9bSiBGL0khiLuKOJRk=;
        b=UQiD+Grdc2qD1EIZZwxeOhi7Jtx8pylYT06JPkcxsRKGY0wf3sFTYPMkYeNV8ytJkP
         ++15zqz0sfwp8N4tXamY+sow1aIlr8YESlnZ3JrndNfpXUHOQpLh5Z3jzsh5vGTWqUc7
         c3uiZGTBCpzuDruvGQWuA4lu9hWiVT3PIQ0ClX4JyZ3PHXkc9jEUrI1j9aQN4nHnXxEw
         tcrief3b5YVzEqkB4Ly/E5OxIUTPyvjowvltYHzBu5/nBEFt7OjB5vcXZMX/mh8oNsk8
         PkjcxAhHghnFV5k6aUxYI2SgTfBEbg3s2P29q7ZFz6U/BXgh0zgzVpxfMAk2QgQ3oWWc
         zCVA==
X-Forwarded-Encrypted: i=1; AJvYcCWoMiUIBbldQoGGSS/RU84H6dyIIWkaDpfcDkRE5QToTVDCghjLB06BQQ7oeBrGLDhO3PK5L7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXlwrIrRgfTK3F5/fVRvZGYTSiSCawQHc0/mWa1CXUl4cwHpU
	i9/drvKgnBPSsHncttfv5hLSimEXXb0CqYiQ+utHlBa1yvpIVdtgjnnBXXWmiM2rQNQcE9Y9IrF
	MAy73VqKDfFlIMtiVkqXZrXiyAQV6Q+N2Yez64vvQ30SGeeA=
X-Google-Smtp-Source: AGHT+IEFFqFL6Z+i6DHqcKyxe8/RJtfANtTvmRv05p6nE4LwpVsuRRRoI4GM1xfpkOExobdfMfIk6g==
X-Received: by 2002:a05:600c:4f4a:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42bbb10d9eemr52777185e9.1.1725351614019;
        Tue, 03 Sep 2024 01:20:14 -0700 (PDT)
Received: from localhost (dslb-002-205-017-144.002.205.pools.vodafone-ip.de. [2.205.17.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db07sm195757675e9.34.2024.09.03.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:20:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>,
	Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN
Date: Tue,  3 Sep 2024 10:19:57 +0200
Message-ID: <20240903081958.29951-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

When userspace wants to take over a fdb entry by setting it as
EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().

If the bridge updates the entry later because its port changed, we clear
the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
flag set.

If userspace then wants to take over the entry again,
br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
update.

Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
if this was a user fdb entry or not.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user=
 as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
Changelog:
V2:
 * always allow setting EXT_LEARN regardless if user entry
 * reworded the commit message a bit to match the new behavior
 * dropped the redundant code excerpt from the commit message as it's
   already in the context

 net/bridge/br_fdb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..ad7a42b505ef 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
 			modified =3D true;
 		}
=20
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used =3D jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified =3D true;
 		}
=20
--=20
2.46.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294


