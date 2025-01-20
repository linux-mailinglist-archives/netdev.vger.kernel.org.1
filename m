Return-Path: <netdev+bounces-159665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CFA164BC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4483A553C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BFB641;
	Mon, 20 Jan 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UeCbAX7W"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830517BB6
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737334184; cv=none; b=AKBZBPBu6Xtnvs2Xd2fYAMwtwES2W9YiPdEj9HFtxOjhvBKDFCQuFXjr5zTSZuGS2R/io6o4JD91M6Kc4SGN/A2nKjpVdCNHJrMDYGZgYzg8TTJdzqGzBVYeyFp+KpdF4apDiGUm5D0HjFlWMmrtiBP6QqnrkHCSkv5u5mrJq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737334184; c=relaxed/simple;
	bh=nJOTqbWlSGUnZ93dV1cXs4iastQQ13XUQjlt/RIijK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbjDvkxEUwUKaT41QwakqvaYk42dkIUXYoRh9bO6Dn+1arutCyH7TICD6GBWpuxNVbJQb+5MrzaFP07N9JJYd41H1QXg+SayHmvOj57EJ1+FZGeelspBBKodb4+js9qRM6zVoWRmS2r1Ceel++R/D1Ve+teOu1UXT1OFmkWr4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UeCbAX7W; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D6E5B2C00BF;
	Mon, 20 Jan 2025 13:49:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737334179;
	bh=RFXOH7HmSX/dzcBgOvydwMG2rXyYdicfw+RcxVbMPeY=;
	h=From:To:Cc:Subject:Date:From;
	b=UeCbAX7WNkaBK5jyN2F26ZCl90Tmk7p8+WC1ZetAUZDpWAy6KxVlUr43eSorX7leS
	 DQ6xFzrd5y+n3hBmHcGZxgsPOLlNQU1QuBJsJ1HuZu44vr8+eNfFcMGprdpo58lmBe
	 9UIfg4F4FYCL42WbGEf6DbOEj2Ej0XxXcN1dYmyZshaxKGz1Gu8xHACsXKnCwVrl+Y
	 R6+jCuqXhogXfvpQADxirIM5EXDrDEkibC7MfDZ25QtoQYDp+QR/k9x4zcDcjxmnXK
	 Oway94Le4v5briBz9dpwOgNGBCdPJqKlJZ74TVVP+LvNpcGVu9BNvoUTVMHswybmtA
	 fVVrn5owL1APg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678d9da10000>; Mon, 20 Jan 2025 13:49:37 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id A94E813ED5A;
	Mon, 20 Jan 2025 13:49:37 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id A51042A1696; Mon, 20 Jan 2025 13:49:37 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: [RFC net-next v1 0/2] Add bridge offloading devlink config  
Date: Mon, 20 Jan 2025 13:49:10 +1300
Message-ID: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678d9da2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=2uogx45ClAXbkQ8DETcA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add ability to configure if a DSA port should offload bridging to HW.
The following patches add a configurable devlink port attribute, which
in turn configures a DSA port. This setting on the DSA port will then be
used to determine if HW config needs to be done when a port is added to
a bridge group.

Aryan Srivastava (2):
  net: devlink: Add port function for bridge offload
  net: dsa: add option for bridge port HW offload

 include/net/devlink.h        | 13 ++++++++++++
 include/net/dsa.h            |  1 +
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/port.c           | 41 ++++++++++++++++++++++++++++++++++++
 net/dsa/devlink.c            | 27 +++++++++++++++++++++++-
 net/dsa/dsa.c                |  1 +
 net/dsa/port.c               |  3 ++-
 7 files changed, 86 insertions(+), 2 deletions(-)

--=20
2.47.1


