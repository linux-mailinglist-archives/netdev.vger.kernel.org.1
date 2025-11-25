Return-Path: <netdev+bounces-241470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D25C8438D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361973AB9A7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964A299A90;
	Tue, 25 Nov 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GXvbs9tA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508D29E112
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062886; cv=none; b=OmrewgPxF87LAjU9ZNmz6j99mjPAFNQsDKRYNw9JhfVgUNLZzpStKsY43hoSSUfHmfYBeLaxlvib3ULjuo9XIWkwye4Qv5T1md+EcLxxjHsQBRPWWVtXhQBFHkn5YeEBgZkIwH5wmLpSRONAvFNqQT5HtGAAwqdInyJGv/yVsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062886; c=relaxed/simple;
	bh=opPD/RcEUcbrKPn4xwUSwB9DlA/QHK6f81uYSX4h1qc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OCEAvuPYJYeN5Q1yWiXvD3c6Q4AHtPq6onZZH3OWXGBVa8jdE/icdMmEGS1al0Ghjk7nZ4G/K66CTtSrVWn0lJxbt58rwTZHT8mGj5nI4WhQDysIGtQ5ym8UybESziiN3P925L/gZd5bJwC2GvoC17GiZ1hyuIeokJT6U5ux4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GXvbs9tA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 862462087C;
	Tue, 25 Nov 2025 10:27:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xky1DSY41uA9; Tue, 25 Nov 2025 10:27:54 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D99F7207B3;
	Tue, 25 Nov 2025 10:27:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D99F7207B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764062874;
	bh=7nmvIZWPRdnSAj4z2B6NODu4QsaYQxAWoVmplcbCWo8=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=GXvbs9tASnIGgHaVpZ3ql+AWcJ3eXqQWYpe/qxu/WMAJ1WlYC6XynetPYY59c24G2
	 zrPv8uKJifPmjQVzV1Nntk4T7z8J3yzel9KnTJTjyEQDOc+9ublvXy9xRW242N33KY
	 4Ybr7kgaagR5AazW03gAdgPm6355g0XkEXg4RSKW0/u+LuiyviOFfVkg/sCjuIcwec
	 jj0GK9fzxPiMmo7GH3dkMYSppAlOw/NPlXndVmhbApoN4OHH4hWqC4aRDUCLr3s1fi
	 ExSrttmMi4/G+aIIDnr6X8jQUAwrmf1aZdGI4Yyz/kWMORIpy8hZELL/M+EkZzlxng
	 51kfxlURrK9FQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:27:54 +0100
Date: Tue, 25 Nov 2025 10:27:46 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 0/5] xfrm: XFRM_MSG_MIGRATE_STATE new netlink
 message
Message-ID: <cover.1764061158.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-02.secunet.de (10.32.0.172)

The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
SA migration, and it lacks the information required to reliably migrate
individual SAs. This makes it unsuitable for IKEv2 deployments,
dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
externally (e.g., by other daemons than IKE daemon).

Mandatory SA selector list
The current API requires a non-empty SA selector list, which does not reflect
IKEv2 use case. A single Child SA may correspond to multiple policies,
and SA discovery already occurs via address and reqid matching. With
dual-stack Child SAs this leads to excessive churn: the current method
would have to be called up to six times (in/out/fwd × v4/v6) on SA,
while the new method only requires two calls. While polices are
migrated, first installing a block policy

Selectors lack SPI (and marks)
XFRM_MSG_MIGRATE cannot uniquely identify an SA when multiple SAs share
the same policies (per-CPU SAs, SELinux label-based SAs, etc.). Without
the SPI, the kernel may update the wrong SA instance.

Reqid cannot be changed
Some implementations allocate reqids based on traffic selectors. In
host-to-host or selector-changing scenarios, the reqid must change,
which the current API cannot express.

Because strongSwan and other implementations manage policies
independently of the kernel, an interface that updates only a specific
SA — with complete and unambiguous identification — is required.

XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
of a single SA via xfrm_usersa_id (including SPI) and we fix
encap removal in this patch set, reqid updates, address changes,
and other SA-specific parameters. It avoids the structural limitations of
XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.

Antony Antony (5):
  xfrm: migrate encap should be set in migrate call
  xfrm: rename reqid in xfrm_migrate
  xfrm: new method XFRM_MSG_MIGRATE_STATE
  xfrm: reqid is invarient in old migration
  xfrm: check that SA is in VALID state before use

 include/net/xfrm.h          |   7 +-
 include/uapi/linux/xfrm.h   |  10 +++
 net/key/af_key.c            |  10 +--
 net/xfrm/xfrm_policy.c      |   4 +-
 net/xfrm/xfrm_replay.c      |  16 ++++
 net/xfrm/xfrm_state.c       |  37 ++++----
 net/xfrm/xfrm_user.c        | 166 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 8 files changed, 221 insertions(+), 32 deletions(-)


Antony

--
2.39.5


