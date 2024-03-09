Return-Path: <netdev+bounces-78982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45387734A
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F9BB20FB3
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C547F60;
	Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCw03up1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94C43AB8
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009304; cv=none; b=FKsGb/rgq6XTidWaTx0RLs5+kcddAn34zupAOEnxhAPHbKsScP9q2xLDGjKbZP/zCGVRUi0w9r849/dg3WFLzdF+dqSVISlbGnKXW4R8TYq5x88BZf9iCAI+XNs9KbH5YFUOR5tmGFsSLHk4l4TAuPaLdKxXG+ErHmqn8oExPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009304; c=relaxed/simple;
	bh=TekRem5kyZG9UalGySvGaZeYSMxbF8TXA1BAjVPkaSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsruQfwp5Bks0vgKuVX9lHm9XDL68a7RVALR0V+kNR9OIa1kr7dcPMGcK8ACGbmro6bTU2XqOUS//5KLfrfjg5IuB+ksP/9ALFHyvfUWrl/+2UFjzkaeTwFEZj1YK+HOIRAdJfpJXy65cZdyGXYjrbAbHa87GtFNdvoU8iOiGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCw03up1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6333DC43390;
	Sat,  9 Mar 2024 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009304;
	bh=TekRem5kyZG9UalGySvGaZeYSMxbF8TXA1BAjVPkaSg=;
	h=From:To:Cc:Subject:Date:From;
	b=sCw03up1IFECXxNOz3wylt+oYUBwbzMz0iIOQFZED4l52lx43KwrDOon4rrfz5Xbq
	 Oo+j/S3uURtUnn7I18a5RbXFMtgWGui7Ad9e/IHKcYonIMNGVekhuBGO7HLV2z2PIj
	 dryb+zyI4uD+A24gn1kqWYEIAeir5xeKH0yAd1jftu5AxhUGr1Of2Zp7ErQHAc2fK7
	 S2D4xVr0vN+3i8jaOCn0vVCPxP2lOUG3Dt32sTCI/SFVj352MqU3Ru65fR6hfZXMMd
	 aYM3BI4YJV3i4h7M2BTJPplNKLxCDEtfSjSwP/Ou8YdWYkpO77tTjQXtPSPdysScx6
	 fYgierk/jNN4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] genetlink: remove linux/genetlink.h
Date: Sat,  9 Mar 2024 10:34:55 -0800
Message-ID: <20240309183458.3014713-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two genetlink headers net/genetlink.h and linux/genetlink.h
This is similar to netlink.h, but for netlink.h both contain good
amount of code. For genetlink.h the linux/ version is leftover
from when uAPI headers were split out, with 10 lines of code.
Move those lines into other appropriate headers and delete
linux/genetlink.h. I occasionally open the wrong header,
newcomers probably do that all the time.

Jakub Kicinski (3):
  netlink: create a new header for internal genetlink symbols
  net: openvswitch: remove unnecessary linux/genetlink.h include
  genetlink: remove linux/genetlink.h

 drivers/net/wireguard/main.c      |  2 +-
 include/linux/genetlink.h         | 19 -------------------
 include/linux/genl_magic_struct.h |  2 +-
 include/net/genetlink.h           |  9 ++++++++-
 net/batman-adv/main.c             |  2 +-
 net/batman-adv/netlink.c          |  1 -
 net/netlink/af_netlink.c          |  2 +-
 net/netlink/genetlink.c           |  2 ++
 net/netlink/genetlink.h           | 11 +++++++++++
 net/openvswitch/datapath.c        |  1 -
 net/openvswitch/meter.h           |  1 -
 11 files changed, 25 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/genetlink.h
 create mode 100644 net/netlink/genetlink.h

-- 
2.44.0


