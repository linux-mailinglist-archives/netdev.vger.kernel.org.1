Return-Path: <netdev+bounces-262789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCqfG8zqpWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:53:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D51DEFCC
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35BE130048EB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501552EA468;
	Mon,  2 Mar 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="MV/o0MZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4321770B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481087; cv=none; b=uQ7Rr44kVawBZfNUGm5zA45soPHi2htOuXeyL2IC5mYv/O5GoiudlFSNliNjt+YM57f/FqUPsoIXdA1o2pAgmPb1GX76I0pblZRd8Z/PkPC+k8CM+9bBHzbJ73DlI3o5NF7bSzNN/tfIPJm/OZXMAQjXBCu0ArHI6o5jyk7/J30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481087; c=relaxed/simple;
	bh=/kTpfZrKyWp+cEaRxHtx6VbK2qooOV8cRxgEG1K/vW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZetbkLkA4YOUbN1f7XKpUTG5qvrco9SO8IgKNfWUpb6SfvFp0veA+3MaNIxNWPMbk8G4nwiKsgsmOAvgtplbKTJLWeNJN89G2iqWRDk+6WLk50VNRtnhz8M55B5V6zdQhWerEkg7+SC5QbQ4R1D0vE4Os0GGYhl84h4Jw6l3VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=MV/o0MZ6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069df1d711so43162221cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772481084; x=1773085884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut5Xp7V7VTjUJdB90zahKAu1ytOb4dHgZckIHBXkVIM=;
        b=MV/o0MZ6MOMXfqfkrY5HQ0i3h6XkDLh9wElhtUgkg9LggAw2ppWrkYbpJbIO9VKpfV
         ib6HctLrD0XuqoUKZh8r993zXi5l5PDHQCzYcU+3PUHQM2gVgzWd38oXoSmxQFx7Uad9
         PV0IdUho66W/A9hmEXv2zBmxpVh4Bhisj1riO6ogYV4RbhbmSKtElhedXzC7H6uDAfcU
         oVVIebAL7LaoSYMXSr0JgRHSsOyt0cPTa8G0JbhO+zBO1hKG2kLTPdEdoploSX8tnfLP
         ZxHhKJJDs5QRHWPi3Z/kfom7ItKwVzK1h20ZHO9XiCGjoWtP+wRX+SoqN04VDsJr7QRU
         DE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481084; x=1773085884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut5Xp7V7VTjUJdB90zahKAu1ytOb4dHgZckIHBXkVIM=;
        b=iEPLNLyGcD1LeHwHKTqpgwGTxtvS0/284Av9Bg9UnYq6P+6zbXiR8hwceHkmAOMhg3
         MwtEsYJ9U22sbod9FtYjWgpapltCz00nzo55+ZCgHKh40czzI2WywCjNUQ21oBP6mm1W
         pH+djQaihPJwBss6MK9K2suI4LVRxr1VShHNVxnerCMCjgJq3PHXD2K0Vc0uBXXUFqox
         owgadXRB/7a5HTWxcwKWSKqv+q29ZHS+rozaJSqm+i/656VJLQG86yhjAph7kZ1lkpGF
         JhzZJzJKvXDDbPQ+FcYTHQ9Kzh5GGxrl5Ph3H0DV3adRh34peA8QEB5TkGQFsClgznUf
         jCvw==
X-Gm-Message-State: AOJu0YzqWuyjQ2X+49nHkncSX295S9IX+6L1/MAnDNQip1PqKBcRUpyu
	swj01m95Fu+glqU2YCas8wIH0G2YyM46rAYR3wkCNr+BsLRrVZ4KmXSK6CllCmXVG3SEuF+nxoL
	RyBo7hK4=
X-Gm-Gg: ATEYQzxG3atm3SQ9h5XmYeT/uTILjq5jt/heZ0SHcAmkdCb0T2BQ+9ZaX1LWpP+Lk5Z
	JR16WXeB2llTbUgtF0pKld2d4vbwCbd31xMbCT2L9Bx2geVFxCg2nR8mW+96iWKC4amHzrwzjD2
	R8/5a74ITKadhi9ZcMOc2AWX1bc7I47uZLz+WTMmh7IJxk4yKYD0ARvHpMTYMC4NGGXT34xgZY2
	hl8KpbZnLq4PWSRXuzbO62+/kuBETwT6YfjcKqn2fgtdq3FF3ePUNhKlnTVCyKfJ5fQPNW/JRJ/
	n2lGcpZ8Ni2HsLisieHk3WDGaVN2gSMDc9c7EQI5khCUTA5xa09FgA6L1m3JCESwmW2634oomKs
	UM2a2RAFlIOviXqo2dAM5x3vPrVPoGNtanoyB8h0XYMy+8WDFC7T+ydMz1WnuEfjW1d9mc6+b9A
	1Ga0SrD/xiVNiZStGZpyeZsNLSbd4GKSSnz+QmAtIQWNR0hDMFDqB+azPfMZL0Fw==
X-Received: by 2002:a05:622a:1b87:b0:505:d0ed:230b with SMTP id d75a77b69052e-5075270d042mr162452841cf.27.1772481084189;
        Mon, 02 Mar 2026 11:51:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630absm117524421cf.5.2026.03.02.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:51:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net] MAINTAINERS: update the skge/sky2 maintainers
Date: Mon,  2 Mar 2026 11:50:20 -0800
Message-ID: <20260302195120.187183-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A0D51DEFCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262789-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim,marvell.com:email]
X-Rspamd-Action: no action

Mark the skge and sky2 drivers as orphan.
I no longer have any Marvell/SysKonnect boards to test with and
mail to Mirko Lindner bounced because Marvell sold off that divsion.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..59c72e795bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15374,10 +15374,8 @@ F:	drivers/crypto/marvell/
 F:	include/linux/soc/marvell/octeontx2/
 
 MARVELL GIGABIT ETHERNET DRIVERS (skge/sky2)
-M:	Mirko Lindner <mlindner@marvell.com>
-M:	Stephen Hemminger <stephen@networkplumber.org>
 L:	netdev@vger.kernel.org
-S:	Odd fixes
+S:	Orphan
 F:	drivers/net/ethernet/marvell/sk*
 
 MARVELL LIBERTAS WIRELESS DRIVER
-- 
2.51.0


