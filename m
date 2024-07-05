Return-Path: <netdev+bounces-109350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427F0928132
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2911C22AA6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7C1F94C;
	Fri,  5 Jul 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qDrNsgoo"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFD1CD02
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720153185; cv=none; b=QM016qTynB+OARxtBbm+t181lDCP0c7hreorbrNInCXFFiozsJD/VVVz2pxOZvd9pz9CoIHv3ZVTFStmfQbvTyjTPFLCsr5FhROA0/HWjS4u3jVrYhhJV4WIHtU6o7+RZa1Rfq/el3zsUGiVqgcBjddRTvkkn7YDEGlWDKoCeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720153185; c=relaxed/simple;
	bh=gNh0l1AFuu3YpgwHKDKlh6Df9CuXiju26t26NPlmGKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoS22MxtTjKhYsPv1vqXZIfGEhgtgQFyS3pWGNwAW3P/+UCMP5Su55/jFEA6IbBM3ljluKLWb3iqKIXJVLCGDarMEAKzDfPYji554pRcmmSE5CAh/mOplKxroBlfbLPV5TGy6GnFi+nQuYbocy83tYMX0OvLL7PI2Icj8KjaOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qDrNsgoo; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 38A7B2C0241;
	Fri,  5 Jul 2024 16:19:39 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720153179;
	bh=JNA15ySDVBqVrJEPESwywKcVnn+Zm/UvWWTM0j769ew=;
	h=From:To:Cc:Subject:Date:From;
	b=qDrNsgookMTzH+KW+uBOWP1EYYpzIzmRG2LK0g4jsK1yCA4uL7XxoAbPHuqLA5qXx
	 ktj/D+dcWCt0QZrFojson6jJL8lLLfZ9RZuT2zH/OXzontZezc6Z7d0S1DF1nP+Wbl
	 eRQpNVMxYaZzBFogPwFyWHp8idNHiP69Ey1Brsae/eq5JdiHe3xgnv+1XAsAxXhfsc
	 mfWXEToSJSq6oCu0lrKcfsysSH18DsSgjg7vX0rRWJSiZ4SyAVuzMfl5OswZ/oE5Bs
	 HxDR2hS+8olIFU7JhdCLT/fKsIXu8/95lOK7c97nHfrXK4OPbtpXG2mQu7/NmKfo3c
	 J48t3jpr3UhQg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6687745b0000>; Fri, 05 Jul 2024 16:19:39 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 009FB13ED5B;
	Fri,  5 Jul 2024 16:19:39 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id EEFBE280930; Fri,  5 Jul 2024 16:19:38 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] docs: networking: devlink: capitalise length value
Date: Fri,  5 Jul 2024 16:19:35 +1200
Message-ID: <20240705041935.2874003-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=6687745b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=eJwZDefbqxDfYRb5NuEA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Correct the example to match the help text from the devlink utility.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/networking/devlink/devlink-region.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-region.rst b/Docume=
ntation/networking/devlink/devlink-region.rst
index 9232cd7da301..5d0b68f752c0 100644
--- a/Documentation/networking/devlink/devlink-region.rst
+++ b/Documentation/networking/devlink/devlink-region.rst
@@ -49,7 +49,7 @@ example usage
     $ devlink region show [ DEV/REGION ]
     $ devlink region del DEV/REGION snapshot SNAPSHOT_ID
     $ devlink region dump DEV/REGION [ snapshot SNAPSHOT_ID ]
-    $ devlink region read DEV/REGION [ snapshot SNAPSHOT_ID ] address AD=
DRESS length length
+    $ devlink region read DEV/REGION [ snapshot SNAPSHOT_ID ] address AD=
DRESS length LENGTH
=20
     # Show all of the exposed regions with region sizes:
     $ devlink region show
--=20
2.45.2


