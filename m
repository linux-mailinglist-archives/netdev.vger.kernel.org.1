Return-Path: <netdev+bounces-290988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H+QKhT4EGp0gAYAu9opvQ
	(envelope-from <netdev+bounces-290988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306635BC229
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 320A0301E98C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9262376FD;
	Sat, 23 May 2026 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT4yurX8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43E201004
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496887; cv=none; b=EjCqiSLASWU1sRPdkaqIdTcvBIUR6MccfjM/HUTBE1ukQ9phJ1b/JQ4gLG02dkTCBdTvLYaH5Cg3+XBMVKjKpnw+y+u8H2gNoydsK5RVgGnBKZg+/5mKJNaMdKrywSF8A451AUd0EuZ0ixfnZdKei9p9NT0bKFDbieSmGl9n7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496887; c=relaxed/simple;
	bh=7B9Me30lI4Ge0+kGlZBt+RspI0sONljRo+4xoaGXXxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnJKRA/crW6BmNaEjELdaXjs3vUoUQxSN/tB41Mu/CM51gw9/gsHmClSrjMzZB3nbzg6u0R6tPBF8KqCiiEo0X5mOXb9jM46cfoFHJknC5owZ6dBg1IwWrW4S2ihLLT1ojpEL2yEPJ24HoklKR2hZq72/Ix2kaOvX4tfNbR1Eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT4yurX8; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-482de4ef03aso5413633b6e.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496881; x=1780101681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B9Me30lI4Ge0+kGlZBt+RspI0sONljRo+4xoaGXXxg=;
        b=JT4yurX8q9r1WsdwH76BICVevVn1cKH/4D/8D/dlbAmKrgXfReg1uel6BUP4pP7kCG
         nUGNtxFTRyZFB1WeAj1ztVjMxNS8uOL20WiJeQXrCl+eJm6c4EVt/dPXsm2OX3oc6V6D
         N7omb+F+ZHGiELZMPdxAAeu3NZpKy9T1zVJMYvN+A7ei6KGRNsX26G2sSSm9PrmWli+0
         614mUg4tM8Ud3NppmQHv8mQk0S6VeoK+n9nFkY8eLZSq00dTDXo5j3F4gyuSuzK5Zrlp
         EyWtL73X6EggMzoMbhyw2U/ETT/tZo8gimX4ZDUJtK6GSsLXp34Zkue6kq+R65GKfeMT
         sg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496881; x=1780101681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7B9Me30lI4Ge0+kGlZBt+RspI0sONljRo+4xoaGXXxg=;
        b=jpqtr8+lGPIb0mVLmqqDJua0xIpCPH+kqGsgMwgCD32JI6dPDzSR3WUFX+NnmGUFDn
         ak+ASZbUn7F2uMG//mXn0eLQeUbjBtHrvpsy1syGi0CPaugYFTMxkQpShtEvXItRMzZw
         OiYKtYGNx8hDus95K+bQYHd6gDF9FeqWr1ya4BXMYTbGlYP/EkVusoELq8OSSYbDel4l
         iB8pS5wqoLIPM0acmeafyxb4kNkjR9SSvvVUUQXt/Fg5ygovqKH0DI8NaE0/ReTl3FD6
         qWNBZ8/bknMNfXOc48ojKlsRvMKDYHTpXFqIhX5+b+P6yHOe2FgiThAEzmtD4QvQ6kA6
         0bog==
X-Forwarded-Encrypted: i=1; AFNElJ9UFXbjwg/TMGcZ9YwuzniWQQEhlpqBN4gAbR3FshRR55Q+vSnHo7DZSTgqLDTUhcCUHNWWSaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMk0XYHRyeUKVRb61DPHSp6PRAfIP2RcvbcV6plaelWUt1pwlw
	3daGbGzqgiPg2S91r8nuyDgeadGBcsqrTm5JgeFwekmfg6Bhdtu9aIh4
X-Gm-Gg: Acq92OHJosbP5DnM1YETATVvSSOjVIPNXm7cygYMttHiIPsex3V/goQwir2Zzad/JFZ
	u/scyNkY3FiFs51n+ei3ZKgeRF1leDXsSxqbouX9bD2kUA/j/sRKYMhiaBV8zbbFy1junqDo3Tr
	9n7fSJVL/w/NDOUKD89l8A73wK7Euotys0Fe06BjklKRYGxfD00VlhNbgSUiLRNG2hEMNClYrLX
	Om6bpxTKb/ifmdwzROFiOCK5FW25NiufUPKwJ+A+UMuLJqhg2NwaEYHeXvKZOpJLrS4PhLC6vBZ
	o89hTvC6SbtbyrD+537eNW+pVQqO3l9nm0Lf7HqjmsUZ09xyy0qfvoVz0sQd9pRe6h/ARV+JQMp
	XIMFH4lNWmgJrEUPdBYbIMmAl1GBzB2UJZEDpU8PfPdLztx8KQx7DdsFN/A6tF0MWErkrqMWdcJ
	zMpwwtjVHPpUJdjEp9eig8075ZXv9G+m2hViEwHcZ3oWxlXIb1xTRf9g==
X-Received: by 2002:a05:6808:360e:b0:485:4f07:eefc with SMTP id 5614622812f47-4854f07f952mr1616300b6e.15.1779496881266;
        Fri, 22 May 2026 17:41:21 -0700 (PDT)
Received: from Dell.cheetah-searobin.ts.net ([108.243.219.47])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad38sm3365739fac.1.2026.05.22.17.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 17:41:19 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: krzk@kernel.org
Cc: akash.sukhavasi@gmail.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	hkallweit1@gmail.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: Re: [PATCH] dt-bindings: net: mdio: remove deprecated .txt binding stub
Date: Fri, 22 May 2026 19:41:18 -0500
Message-ID: <20260523004118.37647-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b3a268ff-6f69-494a-9b9c-11995f35b9c2@kernel.org>
References: <b3a268ff-6f69-494a-9b9c-11995f35b9c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290988-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,armlinux.org.uk,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 306635BC229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 20:41:28 +0200, Krzysztof Kozlowski wrote:
> Why removing it? The file was left on purpose why converting, so you
> should provide reasons why now it is worth to remove it.

The file is a single line redirect, untouched since 2019. No files
in the tree refer to mdio.txt, and all existing references already
point to mdio.yaml exclusively. The redirect no longer serves a
practical purpose. Sending v2 with this justification in the commit
message.

> Don't do such patches one by one.

Noted. I'll batch any similar cleanups into a series going forward,
and make sure commit messages clearly cover the what, why, and how.

Thanks,
Akash

