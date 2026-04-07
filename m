Return-Path: <netdev+bounces-276057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uADnAOwk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883E3B1245
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC44330F20CE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D136C5BE;
	Tue,  7 Apr 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0nqhnSR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185183B9DB0
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575911; cv=none; b=btODO+l7XZNrW3QgYMckdlB/Dqok3lTwev5UvEeGaX+CeDcgf0pQrJsbA2HQSMAR5PVUuB5Kyfke9bV6xiZn00cOpOTsluGXNzpn4hjWstUy6eSZDsIBIT43rmmOIjXtFUrL9MTd/pKzKnLjUd3nZBQVtvWc+rFHAe5aEUdelCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575911; c=relaxed/simple;
	bh=ErwOnT0JgTTw7vhCQZp+f8jltSpFdP+zGg2SkB2ZJU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzesewn7m1siD2xMBp1HLyTx6QTiWgvTexXtf2YTi4KM77YJA3g3jOdw3prZzecODPr7jXfKQDjmeO7dT14DRxBPnxZ0ZxI2nMGM404ZN3Od7Eb9QyHlfn4lMBAwV845uBgtG9t5oqdbRLzMYACW0F8wGJI1xcnmBF2RF9GPT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0nqhnSR; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-679b072ed3aso2875275eaf.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575894; x=1776180694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=X0nqhnSR3HYwifc2qEGucW1AnHnR1rytZDhMIWCfNxIu8bypgopAGa2lUrTJkxq0bl
         ccq/nBSAYrnn5VHqX3g58YR2132fR3VFdAliKJrkgnzA7/+bR9At94cBdSLfhGc2OJ4f
         Qt2kgj19FqFTHdE7bAzwmAaPRFlNJRnKGWbmmBdsF52EpW/J/WFcBLynkx2TZdPYldRI
         LP/g76FcVjByq5/9LonvtGF67V7uYpK2QefuBwlhh5m9nhDiWrHVvWH2ya/msbtgQIWk
         cG1y9BGr4+DeL+64rihqdgcA/6TDhewq+N32mr3RrFyDrX6ErnH5DEVPX7SHORigUpjw
         Zb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575894; x=1776180694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=sLbht4BcqF6+m9CoVXd25QAuFLkXCs9jfcK6OscsMuVu4V8T2/ZJFfRRRQRfxWr7yP
         t427JtnM6/4vZZXH4dsyfEn2SSWO4eeRfeXR4b8Pbvg0ANuSzn7XZJ19czDXlrta1RZa
         iP2/zub8sM19eWh0wVo/y8lLJJNujcslUEzQeCl1AIJ3NRh7Q6rN+VKiu5zjamYAHgKc
         GYMairdggO1VrM5gvLdfi5/o6cSVNSWfkqAWVFkF8Rhpth1J9cKDWs8ylinjDLf1OewV
         jm2Seqj99t+ebBc11fcDiuz9SC6NYqSSpgKYya25urUT5H/mEJpr9C4GSwsh6PPbzrWi
         XBPg==
X-Gm-Message-State: AOJu0Yz820txw2sl4bMw2fQ2YgYBKzc6+VzHBaparUEnkKfZSRzXMxBp
	VrTyrushGgU4I88vN4QiZp81LJC8R28UJvKtYJgeWaLF//M4HQyGA4x0lwPwXP1YIeE=
X-Gm-Gg: AeBDietXH89zTjDZ2aAC0vyN2cYAocFXfMYiy8Eqm06kwzw1kwuNJc3TtpgX8TX7kQw
	+cX5tZFRaADI1C5EcjyBHWDEIcJIScj8bU2yn4FmUtWVMTYghwm0cC3qYCTIrdFt/Y+sfc+EHpi
	JlJGRL7SZj0LrVxnYOsHpAZgoTmGhHFHwCd48/+VWbOmiW2zpCFlMLF/i3K4eWpRPNAHtqAlwLg
	6BCQGoBxYn/axtBDbDCk4tUvjiKmwYbhgSX6HqWl6UbXs0+wD+CYCJZXB+cGHxQWF9bRAZrhVUU
	EGGi7/JOYeI4yL+VBQeNy/NCi/6Jb+g4tXDQW32GDQWgRxW6CCUsnJnYTSHEDgGrZKSLbBSAua4
	fY3jSG5Wih9LHbiOFq2WGENaUVNu+hyOLF4Nkq+Ai+HDIuJrO1qWDZjrRDPEI5+9cLqcosTuvZT
	MSRlRbsI8lz4aFydW00Q==
X-Received: by 2002:a05:6820:2219:b0:684:92a9:a2e2 with SMTP id 006d021491bc7-68492a9b397mr6552549eaf.39.1775575893877;
        Tue, 07 Apr 2026 08:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a63c7fd1sm10299958eaf.8.2026.04.07.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:33 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCH net-next v6 14/14] selftests: net: use ip commands instead of teamd in team rx_mode test
Date: Tue,  7 Apr 2026 08:31:01 -0700
Message-ID: <20260407153101.3694714-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email,jvosburgh.net:email]
X-Rspamd-Queue-Id: 4883E3B1245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace teamd daemon usage with ip link commands for team device
setup. teamd -d daemonizes and returns to the shell before port
addition completes, creating a race: the test may create the macvlan
(and check for its address on a slave) before teamd has finished
adding ports. This makes the test inherently dependent on scheduling
timing.

Using ip commands makes port addition synchronous, removing the race
and making the test deterministic.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/bonding/lag_lib.sh    | 17 +++--------------
 .../drivers/net/team/dev_addr_lists.sh          |  2 --
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index bf9bcd1b5ec0..f2e43b6c4c81 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -23,20 +23,9 @@ test_LAG_cleanup()
 		ip link set dev dummy2 master "$name"
 	elif [ "$driver" = "team" ]; then
 		name="team0"
-		teamd -d -c '
-			{
-				"device": "'"$name"'",
-				"runner": {
-					"name": "'"$mode"'"
-				},
-				"ports": {
-					"dummy1":
-						{},
-					"dummy2":
-						{}
-				}
-			}
-		'
+		ip link add "$name" type team
+		ip link set dev dummy1 master "$name"
+		ip link set dev dummy2 master "$name"
 		ip link set dev "$name" up
 	else
 		check_err 1
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index b1ec7755b783..26469f3be022 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -42,8 +42,6 @@ team_cleanup()
 }
 
 
-require_command teamd
-
 trap cleanup EXIT
 
 tests_run
-- 
2.52.0


