Return-Path: <netdev+bounces-81847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74C88B451
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6AF1C3DBF9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B081207;
	Mon, 25 Mar 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xXWbnsRH"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928D7FBD9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406354; cv=none; b=Bck8cSBtfa3M4Xx5slqLazWs6u7yyBLdc9pWDZu6MY3SJPiRSNtEg22XtZ/s0Z2OyIZnlDKWn5/BIWAE0Cmbjm/Na6ku/j/bpIERgI/3b0XYcRmwM4snQVx9z2WTBrUgumVVJyhRoTrWm7PgTb+ihh6e2UW6JbfCLo+tZKSFJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406354; c=relaxed/simple;
	bh=pBTmPfAh/eip5pJzDGiwMy5xPzDHeKkOsdT2xm+FNhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxQUsR9/4HLcbGFzxmrLS3/cURFWnkPNyWn/ymlUUjIzTuYFK09BWO25GRxd5StPIVoYJ6HHqmqFBEHZeHdqddGgf8UYfkJ5DiK6Vf/UZq9wQpfwPG86sR76Jnf3SuZqU9lx3yQqO4vntxPoLXUWJcZb9EEjnFyXgBZThwQM3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xXWbnsRH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LG/MWDdSEtY6L30f5O5r/oL06s3CH4T8FQAWYoAGqL4=;
	t=1711406352; x=1712615952; b=xXWbnsRH87QsRSp7MqABxNTVgQ136UWu5cLCDvP7EBvBcVg
	/J3PWjxyWVKayYCvIRXfG9FrX87YiIGPNCgmMLtjfCDsEzHd3pWcYPNGT8SlIjdUz8SjfWN1W4udl
	6fPbeF8ABmIlUf5i/RJ8sUOORVhYvsu1NXJ33jjesGeFKqcYoXL3w1zmgIxwo9fUPqIKsMxvCRsdc
	zOiTLjWRJFZBYzawvNwIT2IKFY+FJSGRWpAF3J+XEQDNUJmGbo28lGxk3Ov4Vp7L3AUlD0n9mLVvs
	cPrm9myftzmRNnzzg2SfgQ8gDXFcSnWisAquMerHmXp9R2m8encs5M6NSTZsE9HQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rosyD-0000000Ee2Q-1wlh;
	Mon, 25 Mar 2024 23:39:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] netdevice: add DEFINE_FREE() for dev_put
Date: Mon, 25 Mar 2024 23:31:27 +0100
Message-ID: <20240325233905.90fc450462e7.I1515fdc09a9f39fdbc26558556dd65a2cb03576a@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325223905.100979-5-johannes@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For short netdev holds within a function there are still a lot of
users of dev_put() rather than netdev_put(). Add DEFINE_FREE() to
allow making those safer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/netdevice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382..f6c0d731fa35 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4127,6 +4127,8 @@ static inline void dev_put(struct net_device *dev)
 	netdev_put(dev, NULL);
 }
 
+DEFINE_FREE(dev_put, struct net_device *, if (_T) dev_put(_T))
+
 static inline void netdev_ref_replace(struct net_device *odev,
 				      struct net_device *ndev,
 				      netdevice_tracker *tracker,
-- 
2.44.0


