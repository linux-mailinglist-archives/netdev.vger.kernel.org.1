Return-Path: <netdev+bounces-122834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C91962B27
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638D4286459
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613611A2C04;
	Wed, 28 Aug 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b="FnSQ/EHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
	(using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB21A08AF;
	Wed, 28 Aug 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.18.215.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857604; cv=none; b=OxGwgyC+82n+rMISz4E2ISZhoI9PbugmZGw9dbb0P8MT3N9U9ioYwJipySlgw1UkgVbffg6VjpURvaULoEDY4P93MMye3paXwaOS7Lp8GcCZmmfVvkw7KBgQqhqVu1pD7csJ427iV119sdjLd7A99t9BGV3ki/cf/Y0U4Ud6kL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857604; c=relaxed/simple;
	bh=sjR6z0zfk1JV9KzZ89G1lCI6RwR/rJTW1RdNkW2xf6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPjeVuOUw5L6Rz890JV63/dbulXprA+Zor1tZekZGN0wB5Ei1+XXlmyGq8s8l8C8Sakdux3YSgVUPKHaJCXqbSJIzl1tKzqQTzieYKzZsPaBtxPYjPd1Fz6dGucHrPCGEmKzkgQyHLFMKuHBad/zNvEFO7ZzjbpJl/x7s9IzpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru; spf=pass smtp.mailfrom=metrotek.ru; dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b=FnSQ/EHi; arc=none smtp.client-ip=178.18.215.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metrotek.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=metrotek.ru; s=mail;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
	 in-reply-to:references;
	bh=sjR6z0zfk1JV9KzZ89G1lCI6RwR/rJTW1RdNkW2xf6M=;
	b=FnSQ/EHiJLwLjt2SBq39i2QdpN1mZw426pSEb0bTrAkH20ATaxvNBc0+tNssrmUZqeiYRBqPeG0gl
	 yPMiSVceClRh/rbTzTdjFG8e7ZPloJOThOzYo3MQ1YVJglumvNF3zeTIWMQ8VQU8fcP5bkHGdSqeZs
	 1Djgklg3p+VC1Jd9ZjpWPqz5OtXWnm2yx3ks1RIZ6QuBVjcdtKDHGcMCKUID9qd5IRsG+BhC0wO60A
	 abD67QYa1Dvyo9XyJiZujvHMwBa125aE0CTGwQ+sn4si+zFsvm91sGGTS39dGEPrLg4fFLO9rgMLfX
	 pEjA5ADvx5BcHIRSqFP5id+kMum1tSA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.18.2.1544, Stamp: 3], Multi: [Enabled, t: (0.000009,0.003730)], BW: [Enabled, t: (0.000024,0.000001)], RTDA: [Enabled, t: (0.089953), Hit: No, Details: v2.79.0; Id: 15.krszj.1i6cmkcba.2vpck; mclb], total: 0(700)
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from fort.ddg ([85.143.252.66])
	(authenticated user d.dolenko@metrotek.ru)
	by mail.pr-group.ru with ESMTPSA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
	Wed, 28 Aug 2024 17:35:57 +0300
From: Dmitry Dolenko <d.dolenko@metrotek.ru>
To: ahalaney@redhat.com
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	joabreu@synopsys.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	quic_abchauha@quicinc.com,
	quic_scheluve@quicinc.com,
	system@metrotek.ru,
	Dmitry Dolenko <d.dolenko@metrotek.ru>
Subject: Re: [PATCH RFC/RFT net-next] net: stmmac: drop the ethtool begin() callback
Date: Wed, 28 Aug 2024 17:35:41 +0300
Message-Id: <20240828143541.254436-1-d.dolenko@metrotek.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com>
References: <20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Are there any updates on this topic?

We are faced with the fact that we can not read or change settings of
interface while it is down, and came up with the same solution for this
problem.

I do not know if Reviewed-by and Tested-by are suitable for patch marked as
RFC but I will post mine in case it is acceptable here.

Reviewed-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
Tested-by: Dmitry Dolenko <d.dolenko@metrotek.ru>


