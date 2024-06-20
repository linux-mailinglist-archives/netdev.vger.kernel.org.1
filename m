Return-Path: <netdev+bounces-105264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9279104EB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B58BB23A22
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35591AD4B4;
	Thu, 20 Jun 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeAS/3vU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FB1AD488
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888172; cv=none; b=R9WvPTgSo9Lfnssx3ZYskie0RlQVp0OKeAS0fjVYTkPWbqrye48Sw3UBUqIHrFmYUgRyF+k6Les+LL6pv6aQlxK6Eq8eV1g29BgQFpR2fgkmAMyDZvJoIrb3KrCEkAd360c3ICvHLycoEBXxf3G1qZbIBxB66f+9YWHCD8No70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888172; c=relaxed/simple;
	bh=10et50jH35WKzbJAGft92Uw+63bW3vRyEyR3/dmjRo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONliwF8WeIPcTFZnDuXEswFgHpv8u3riigKPwTYDzm579L2Uxo8bICPP1+IsGA7u6l79BmjhJ5SOFm8zNO7A08KM8AOkmaWfblS1M4Yot13rTogd7JlBafFeHYUNUkHFjgcTrBVmtbrjTfVU9xnud4ObweqTu78C9TBms9vQIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeAS/3vU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ito9Ah+hBKJWq7ZSXp0iGlPI2JE2GdQxnkVVV4tpaqA=;
	b=PeAS/3vUf2D6ZvfVT0zCfasPps6vqxVOtZWXsnBp+gy6Zn9WV0CsIEjoDNb/vAZFCXZK1f
	tRYd5v7/uPxFILm13wNwIxizm3UvawibVYV/AjUiJ8rg5LxJkuhEI8ij+iYtmjoRKb8Svl
	hpTyHx39O3sWBFL7uqy+fJxTs2heasY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-BqFq2gFIMd6GpFyNA9tjVA-1; Thu,
 20 Jun 2024 08:56:08 -0400
X-MC-Unique: BqFq2gFIMd6GpFyNA9tjVA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B8D419560B6;
	Thu, 20 Jun 2024 12:56:06 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F29B81956087;
	Thu, 20 Jun 2024 12:56:02 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use the internal ovs script.
Date: Thu, 20 Jun 2024 08:55:54 -0400
Message-ID: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently, if a user wants to run pmtu.sh and cover all the provided test
cases, they need to install the Open vSwitch userspace utilities.  This
dependency is difficult for users as well as CI environments, because the
userspace build and setup may require lots of support and devel packages
to be installed, system setup to be correct, and things like permissions
and selinux policies to be properly configured.

The kernel selftest suite includes an ovs-dpctl.py utility which can
interact with the openvswitch module directly.  This lets developers and
CI environments run without needing too many extra dependencies - just
the pyroute2 python package.

This series enhances the ovs-dpctl utility to provide support for set()
and tunnel() flow specifiers, better ipv6 handling support, and the
ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
the pmtu.sh script to call the ovs-dpctl.py utility rather than the
typical OVS userspace utilities.

Aaron Conole (7):
  selftests: openvswitch: Support explicit tunnel port creation.
  selftests: openvswitch: Refactor actions parsing.
  selftests: openvswitch: Add set() and set_masked() support.
  selftests: openvswitch: Add support for tunnel() key.
  selftests: openvswitch: Support implicit ipv6 arguments.
  selftests: net: Use the provided dpctl rather than the vswitchd for
    tests.
  selftests: net: add config for openvswitch

 tools/testing/selftests/net/config            |   5 +
 .../selftests/net/openvswitch/ovs-dpctl.py    | 366 +++++++++++++++---
 tools/testing/selftests/net/pmtu.sh           | 145 +++++--
 3 files changed, 450 insertions(+), 66 deletions(-)

-- 
2.45.1


