Return-Path: <netdev+bounces-72853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C89859F41
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9387A1C21A67
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653132375A;
	Mon, 19 Feb 2024 09:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF922F0F
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333682; cv=none; b=jkOl83AWBhgBkoWo+fEiJVM0UzmLUcuvs4KTLo0BBJU8Q+40CtNJH0A7SHGRSXG8Zgzac0xmq3Aps0vOsiKxmEs1w75pisg5+0f2A9UWTJ3DYOOUddYbENmHxtbMmWK4pH52pAoGHfbpoVlztyfs64AMNkKH3JQb9fHr/wWQ3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333682; c=relaxed/simple;
	bh=PfNMPsRx4N5oOyNehjzN3v9q3JhSAQI3pxZ9KsEJJ30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxcXB9NEa9fhiN49xTpnsHtI1B4WFr5hWn+CqmMwPvT6u42qGQyQg+LViFpP8Sl0WBJSNmwvkSO+FV+5WLOxToWC8UyooEN+sJTpYi4EgXolu2NQDFCOI/rG9JIAx/jPxmcdJ/8TLjNYejv3wA/PdNKaYImcFVbbcoQO1uwYfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 25AD37D10E;
	Mon, 19 Feb 2024 08:59:09 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 0/8] Add IP-TFS mode to xfrm
Date: Mon, 19 Feb 2024 03:57:27 -0500
Message-ID: <20240219085735.1220113-1-chopps@chopps.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
(AggFrag encapsulation) has been standardized in RFC9347.

Link: https://www.rfc-editor.org/rfc/rfc9347.txt

This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
take advantage of the AGGFRAG ESP payload encapsulation. This payload type
supports aggregation and fragmentation of the inner IP packet stream which in
turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
Congestion control is unimplementated as the send rate is demand driven rather
than constant.

In order to allow loading this fucntionality as a module a set of callbacks
xfrm_mode_cbs has been added to xfrm as well.

