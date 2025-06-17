Return-Path: <netdev+bounces-198452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00EADC372
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A807A935C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678D22AE45;
	Tue, 17 Jun 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JtTO9nKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB728C022
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145727; cv=none; b=qaDPD89XlQqTNNlmbjHhWF8GsQcclXzFnx6n+J6B2PfMiYhFfZKApHHlMIcT7cfBnPUIbwYeQK3IMJpBC1YCfAIDT/tSD/P1yoh+URIR/clgdI0PBv4hrwBPhy6hHqksn7s2H3SFYyG+J3aQL7/TFgrMzxBd0v1wODdaLgObQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145727; c=relaxed/simple;
	bh=8E7L+2tQKhnJFTnt5SXSgwV5/56pSG2wFG8c5SFSbj0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lth3nQ50yj6N7XYirPMGV2aowqbEQWElNxGIX4aoTtcUMlMunyjzrhzNos+YmDdw+4u/ZyuALVCpzFNGFovh7MGZG4b/Yj5dRB1XmHgB8MRPhAIrrzBx7ViS6Rxz7IfsARH59TnG8mR/2AB9Y0+TagefaWduHAwIURlz7G80QD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JtTO9nKU; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750145725; x=1781681725;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=8E7L+2tQKhnJFTnt5SXSgwV5/56pSG2wFG8c5SFSbj0=;
  b=JtTO9nKUh9sArHt8srVApWHJGXBbRMpXnLlzEbTVJmYrXbnPuIVr4nuo
   tE3vK4e6vc0Xzof2dtSkJctptMDWT3a7P/FnKYkuOUa6QbAlo76v79h2v
   YZGCFPkoWiiu/CY2o8O9xo+EpfXeB+myVwwYE2VBbf09pgr6vMEjwlSUb
   RuHa9LsK6vsMqibHUzmi4NHvG4/SQPXTnh4aD2Izn1/8yORD/9Q/CJMpQ
   c3q1vSrkitE3S6KAmFyjtqT4sYIvlED3g+qlcWCCnrHEePGEu+IOyme0k
   D5b4ixgKCqjDXfUMMH9r6SwEJIkjtljs1EROx8APkHyT/VMpGbwEuLfkf
   A==;
X-IronPort-AV: E=Sophos;i="6.16,242,1744070400"; 
   d="scan'208";a="105374300"
Subject: RE: [PATCH net-next 3/5] eth: ena: migrate to new RXFH callbacks
Thread-Topic: [PATCH net-next 3/5] eth: ena: migrate to new RXFH callbacks
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:35:21 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:8051]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.93:2525] with esmtp (Farcaster)
 id 70271acf-3d11-4e25-a0fa-f683c1b96b14; Tue, 17 Jun 2025 07:35:20 +0000 (UTC)
X-Farcaster-Flow-ID: 70271acf-3d11-4e25-a0fa-f683c1b96b14
Received: from EX19D022EUA001.ant.amazon.com (10.252.50.125) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 07:35:19 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA001.ant.amazon.com (10.252.50.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 07:35:19 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 17 Jun 2025 07:35:19 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>, "Allen, Neil"
	<shayagr@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
	"skalluru@marvell.com" <skalluru@marvell.com>, "manishc@marvell.com"
	<manishc@marvell.com>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "sgoutham@marvell.com" <sgoutham@marvell.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "hkelam@marvell.com"
	<hkelam@marvell.com>, "bbhushan2@marvell.com" <bbhushan2@marvell.com>
Thread-Index: AQHb3ymYIDksRSFg40KbuWeQ6mrAm7QG6dCAgAAMIUA=
Date: Tue, 17 Jun 2025 07:35:19 +0000
Message-ID: <a2ef14e7839148d195c051d48dc3ccb2@amazon.com>
References: <20250617014555.434790-1-kuba@kernel.org>
 <20250617014555.434790-4-kuba@kernel.org> <aFEQI00XSUK4OQ39@9fd6dd105bf2>
In-Reply-To: <aFEQI00XSUK4OQ39@9fd6dd105bf2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> > add dedicated callbacks for getting and setting rxfh fields").
> >
> > The driver as no other RXNFC functionality so the SET callback can
> typo as->has. Apart from this minor typo entire patchset lgtm.
>=20
> Thanks,
> Sundeep

Besides Sundeep's note, the patch lgtm.
Thanks for making the change.

Reviewed-by: David Arinzon <darinzon@amazon.com>

