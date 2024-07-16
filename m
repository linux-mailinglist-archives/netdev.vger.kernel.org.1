Return-Path: <netdev+bounces-111706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4196932250
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2162A1C21B75
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238D1953A3;
	Tue, 16 Jul 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGUnkUxl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7F41A8E
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120267; cv=none; b=SFaELY00UAZV11UbyfA5v5BBaD9uwZRNoJmGYbSA4oy2ckEadlKVwjkj52d6Y2hxHdHfzoZhwCEIuRs5ZhOs3rVyZ3ElVN4KjxkUnm2FhRB8I5hnaQ+cbYOH9CqJ7+mWAZmq4kpCon7RnlhMlZqEM8y5gDSf7BoOq3SlHbqu1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120267; c=relaxed/simple;
	bh=PgLWc3nNRBTRJLGa6zCfYj3eTLDWNjdzoXhaHnkaD34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J29s+s2jzq89sDWCyjfP2UonvYpgXy0+KNzOwEPizR/+2m+RvGwpWtcxpKg9gExNVW2uiwwLcFe1zAf6acmGes4rTd1UIOgpXfzeRXBupb716RVKOScz3tjUS3Zd04HDejo2z/GtDPCTyIrFpqMb/uQc9FF2xSsyMkHvlVVqnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGUnkUxl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721120264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGxSHEyLIA3wCuOsYtpJShSoDyZl4G0GdWmyYMByo9U=;
	b=eGUnkUxlwFhud7+hBJ6/LLTuvD5TXGHoZolazhzQaz9N2gVlrbJqhVabwN2g2L7eR+i2RI
	6Ep+WRACT22kD5lf+F22fSvgv1GMn54KNMEwP/W8Yexd4Pg4juw+l2O+h4CiUIOELsUvFk
	54jst7wueuKQclqNrgWDZ5l6pdXXl8w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-DuHOziLlNXK2LTMT1tW2uA-1; Tue,
 16 Jul 2024 04:57:41 -0400
X-MC-Unique: DuHOziLlNXK2LTMT1tW2uA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C14501955D47;
	Tue, 16 Jul 2024 08:57:39 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.170])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 929051955D42;
	Tue, 16 Jul 2024 08:57:36 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
Cc: David Ahern <dsahern@kernel.org>,
	aclaudi@redhat.com,
	Ilya Maximets <i.maximets@ovn.org>,
	echaudro@redhat.com,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v3 0/2]  tc: f_flower: add support for matching on tunnel metadata 
Date: Tue, 16 Jul 2024 10:57:18 +0200
Message-ID: <cover.1721119088.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

- patch 1 updates the uAPI bits to latest work from Asbjørn
- patch 2 extends TC flower to allow setting/displaying "enc_flags" on
  TC flower

Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Davide Caratti (2):
  uapi: add support for dissecting tunnel metadata with TC flower
  tc: f_flower: add support for matching on tunnel metadata

 include/uapi/linux/pkt_cls.h |  7 +++++++
 man/man8/tc-flower.8         | 28 ++++++++++++++++++++++++--
 tc/f_flower.c                | 38 +++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

-- 
2.45.2


