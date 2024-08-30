Return-Path: <netdev+bounces-123726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B096649B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCE7281FE3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A41B2ED5;
	Fri, 30 Aug 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="M44fLIUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258541A287B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029656; cv=none; b=L0VVUej/fvcsL4zcoKAKn+j9aSOLI+3lktof3a6oYROGdQdooeFRwVRWBziDU3FLPAiciS9YrTXoZd+HLtGTTEul9UakmqJEWhGNmawM4IpNFK7FrcX4MKaoF40fHcRtiUMu0eeetAe4ZDrPpP2E+9Cr1dgMBrLAotOhcbnC6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029656; c=relaxed/simple;
	bh=dc5bRy15ONVTTEBc9aLEo2ukaqbrY4WWZWtKTlLqz3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFdjTJDuzXIl0xWgojJBFOYATmPZgMjch9D01H1D3SfQoJU9emOJ3jJBPNV5dhVsbYXc+ywLXJxS0E/ug6CgPnalOXFrDewL+bcHZbSV3gxu2wlt/1GSTR1GRhjc4snyW4fEVZ17ud18IbwNQu9BqzXU+AESR0AX0ayJRqkf3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=M44fLIUe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281e715904so2689195e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725029651; x=1725634451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrcokWaDtnovzXGcwzep+zxvnhENL1QqZzp8TzZhMRE=;
        b=M44fLIUee0IefkxMTMhcDCjJmOJ0t4UK0O3rj32t3mD+6kdGoKCQ0BcbdymRUwaDkE
         tmY2Qo9SlKLSZz7HsOyIH3BmmaNcNGJMMCecFh15G3HDvHtssMwqN/Ot+qRDhXsl3ufF
         KT8Xut4dJgXK5XMke1r+im/HRqvH2E0SM969iiL6NPH97EGoEq68OfhIdpIy6Xjh7eVZ
         c9Ee6WYqvlw/B/JgbcjkD7OEhoIBsLQbYq/34RtWZ0B8MCb5ivntq9GChuoE/d+RfoVN
         y9BoZS5kuzrx6zw6Av1uQkvGz0ldolDcy2gFco8lkIAJQhBqUKknLYqA0cJX12zSjD5C
         gTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725029651; x=1725634451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrcokWaDtnovzXGcwzep+zxvnhENL1QqZzp8TzZhMRE=;
        b=FK7lrJHdkJ/2dH1cgjxp377Dak8l6BjfJrDMARkrAqI58+KlGN/NlE+jIeYPWhyD7g
         dd9rgcoMJHOIyJt7ZL2Mmr8kSHUDACDS4KKkz0zdB/+/1/f5rrcxIKSTqxLLm+/Ho2q2
         C3Prru/9aTyyUWVHgHq6DFILWqpt4u9ElDw/s+BaG5vibNeUKbUpNtiTC/gRgEVGZ2qx
         hBss9jVwvW3bUdaJUAVDfvmeNeEPg/sYZFsMfkIqKZTSJhkARpjEh084q8yB7eSJwLy8
         Wu+VmFLDnvBTl8Cu+6DeJhZr7Chwv0EwgMHfH7pBHEIwpir6NVZhjaXq/yDIpZW4yQmR
         l/UA==
X-Forwarded-Encrypted: i=1; AJvYcCViKXwUWnmGs67QaY8ihWJ/4u11Yth3VaNhxzkvMeO0OpM85t2V7586tmJNZ4QykutdpFJ1NYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPURQbPS9SOuSl+ARnZeyezgX0LNajnBR93NmUFA7UVPDFyCJ
	GdNAMpyBwaej9bi1YQ+WBOIOXKZvn5bJ2uHxYg2ypbjJ0q559doaEPHunbNQ3M15wCIkkNaDneM
	9LEI9iLOrKkb128Sg9utcRcnTwNPZL0MFn4EsQfjaPJjLoZs=
X-Google-Smtp-Source: AGHT+IHzCrZfGKkqZIrpmvjmqPrDiRM+M6I5F7pFZ63yccDIP5YShJDmbt3sx8lfrlWsn0wQtLPLuw==
X-Received: by 2002:a5d:5889:0:b0:35f:247e:fbce with SMTP id ffacd0b85a97d-374a9551535mr1079432f8f.1.1725029650638;
        Fri, 30 Aug 2024 07:54:10 -0700 (PDT)
Received: from localhost (dslb-002-205-017-144.002.205.pools.vodafone-ip.de. [2.205.17.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm58394655e9.15.2024.08.30.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:54:09 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: allow users setting EXT_LEARN for user FDB entries
Date: Fri, 30 Aug 2024 16:53:55 +0200
Message-ID: <20240830145356.102951-1-jonas.gorski@bisdn.de>
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
update:

   if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
           /* Refresh entry */
           fdb->used =3D jiffies;
   } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
           /* Take over SW learned entry */
           set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
           modified =3D true;
   }

Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
by also allowing it if swdev_notify is true, which it will only be for
user initiated updates.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user=
 as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 net/bridge/br_fdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..c5d9ae13a6fb 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, =
struct net_bridge_port *p,
 		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used =3D jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
+		} else if (swdev_notify ||
+			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
 			/* Take over SW learned entry */
 			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
 			modified =3D true;
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


