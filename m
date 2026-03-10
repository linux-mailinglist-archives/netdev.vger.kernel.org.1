Return-Path: <netdev+bounces-266024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLoXKaL/r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:25:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DC24AA5C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 024423041C89
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A43876D3;
	Tue, 10 Mar 2026 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPDrxpkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB3387368
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141836; cv=none; b=KCp1W+APFQv0v4lW4aC0bQVngGdhCD38zCq4ibdkU1bBO2FgAMWUdVY9oV6tpAiI76eZiAia38Gq6pE6GBOnH9yU+6LEKADMG0ZYnJwCsztIJ2oMv/lT0UtbdcniLwGttgeWCykfKWVMxkIYXR6KDbuoWpLFQlyLsqXrntwuii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141836; c=relaxed/simple;
	bh=W/1FEAlYojWL1bU8tkO80Dm54K6ucsxIJSx7uRiiapU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mveDN55W5zjDEtIkLYWO3e/OB1AwE+onswCVpOE0AApmOqpwqGYchP+COvhBBEI+F4Mpd4UtzK5Q2Lq2/BLDsGpW3ebaxjJetBk42dU1G45HyXROrJtxRWzsS4uPBIZpWkzfC5dAWjNTFH68EUnDiK1RenZSrb3Aw4DKJc9VGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPDrxpkH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c4a93841so4875845f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141832; x=1773746632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9v149es6iuld0S7eGKDXVf+jDyagFR1V8/Oqt8h7Ak=;
        b=lPDrxpkHjKYzxP2SZVW80t/lvry7NcXPQiQ6v6iMxyvP4P48ipWQHWjVybIGzysc5S
         iv68ILbtw6Zrpn1BkWcKWYF2r3E55vYFiz9ElbmuVXgU3HQrmOj1XckBDyM0fKnsB0Xf
         bNAXjySEOsNk4uYvQp/HBuyo0kg2yc3JByKGI7NQNbsCHl+FdxOjCwaQgfPACbYQ3SHD
         8iUsfCAB4gNZZrjfo0xtFrMnt1JuRFn1dwDb1DoUXtSrZ4ybqyeFhgVJxA81zAMVQMt4
         sWW25LzRuasup+HTf/MaQVupiBgS1HT6e/vrfQ677ez2qPiAPGjDvsmQ5K2xZZ0lw66S
         cq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141832; x=1773746632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9v149es6iuld0S7eGKDXVf+jDyagFR1V8/Oqt8h7Ak=;
        b=Uij8ZdQw8TEBQmACbbFtKu0K6NDstxMcboGKY5C4SDqMXHcJ5BjHJd2DaNLxeWCP5V
         RyARvokZsCpm89m69A/g5sC/Nz7PCpTs930OeCnF2g0MvMdJSFdxyZNXZRQb2F63SJGS
         lZ+claqvvImZlhs7irQeTwkEmC9RAfvJcOZ7oGaouMn0IpvfqY0uPyWzxWGjiT5Re9wu
         oqnFWnNcB3Cgv8wLaqOUFwJWJgXH2gK19jsRoqqInEd/Ud47FoZA1ucVEjEtdoMlju2z
         yQ5fSkUjE0EUQBM0sZ41IupDKKrp87sbAgZ8w3CgGultmTOd4GPpTcraU0HAubHI5HwI
         fQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXowiIrh5sqChHKsbAH3+E/PWbS66DWOSl0uNxt6a5ISEngZxIj/Y+6Wfs3uTdLhOU9J0ULMIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qhO6qPFGD0JdfLRkt0csDXIMZEABK4846efW/XJ2Vkb9ZSqT
	Gm+XoSUOUE7FnwcZhM+d8C/YtsOCw1zrsFGXoXcwRpdodhcDJ6RSlyCm
X-Gm-Gg: ATEYQzwKZBtZ0ewn1zG7YRIQp5EVSDfdUtIaVxAigzCqZFkLs7FmCrg6ih3jzrbg+Px
	bHMI9Qo9ERjWb6tFDSSi3nhcThzQomjuS56UWNzFSVZp5MbZ9K7MjWkhzHPHAn30m0l7eA+2Kxv
	r7JTPhfgyukkBw0P3+ra3QyEcJF6IZ+lNCNk0GGMJbtDv/0Em+eubBz0BOQchXuIPgLyz7+Kz50
	X90DXQY3NhXimrXp86hA8mBXzoNRZvQlaTcGSduGRepArKJweFlQgU/E2jCpjr8fvc6uVRmgZ6w
	Vse5yScoeJQRhJXX6BjLOFAb4b5P7q14Sym/1AZxX2pN0ELpOdyKK3Ye1QoVD8ivuRSHz6YoqJt
	7G2l1PzQsdU/OnUuw27xqj3KeOGteoVUBOTQTnW3I6lnOyxl3jMfz8ZVSt4alX8/vXx5fzyci3f
	baI5LblBi/ZhlJ2SLFFUhdh48=
X-Received: by 2002:a05:6000:144e:b0:439:bce5:6508 with SMTP id ffacd0b85a97d-439da351a52mr25257592f8f.14.1773141831963;
        Tue, 10 Mar 2026 04:23:51 -0700 (PDT)
Received: from T15.. ([46.175.113.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97abasm32238560f8f.10.2026.03.10.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:23:51 -0700 (PDT)
From: Wojciech Slenska <wojciech.slenska@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wojciech Slenska <wojciech.slenska@gmail.com>
Subject: [PATCH v2 0/2] IPA support on qcm2290
Date: Tue, 10 Mar 2026 12:22:29 +0100
Message-ID: <20260310112309.79261-1-wojciech.slenska@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D9DC24AA5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wojciechslenska@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This series adds IPA support for the QCM2290 SoC.

The configuration is based on SC7180, as both SoCs
implement IPA v4.2.

---
Changes in v2:
- Order fallback list by priority
- Add leading zeros to register addresses
- Use RPM_ACTIVE_TAG instead of RPM_ALWAYS_TAG in the last path
- Link to v1: https://lore.kernel.org/all/20241220073540.37631-1-wojciech.slenska@gmail.com

---
Wojciech Slenska (2):
  dt-bindings: net: qcom,ipa: document qcm2290 compatible
  arm64: dts: qcom: agatti: Add IPA nodes

 .../devicetree/bindings/net/qcom,ipa.yaml     |  4 ++
 arch/arm64/boot/dts/qcom/agatti.dtsi          | 53 +++++++++++++++++++
 2 files changed, 57 insertions(+)

-- 
2.43.0


