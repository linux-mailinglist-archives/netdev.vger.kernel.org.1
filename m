Return-Path: <netdev+bounces-226848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E6BA5A1C
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB844C6904
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9081029E10F;
	Sat, 27 Sep 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="sKhmHb+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta9.mxroute.com (mail-108-mta9.mxroute.com [136.175.108.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08129D267
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957660; cv=none; b=N43JlWRDoovvqJWSB5ATPzroOaHHZYagLJkQ8N12O6kvPI/GHjwm4HbyddO8R/Na8Xz7X1S1YU8Srot4YVrXEYorZPIpB739r8YlElDYi3ptYPJyw+Ol4MZkMc90xuvnOO/cxapPlvvxOW6nZjNSiKz6mqwtT1ZM+O3hmEPV/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957660; c=relaxed/simple;
	bh=xgYxOpaT/Iobs1BrJfegcD18K53mxzzZ1+TaiJteypg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=coG40M0uIeK8prL/6M+5SZ6YP8eVxrPRyEw/QKpTKZL3WsScgDoZL9BOEsylYLPISihrOJpnevvEjSWu3PFCOjlHQ5MO1JZ4CEBxjmc07OZFil5DjcXIsFr/t+AyUbaVc2nm1qx+PE+VBaaXM4lefDFl8DctMiAbXZXY3bUXvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=sKhmHb+h; arc=none smtp.client-ip=136.175.108.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta9.mxroute.com (ZoneMTA) with ESMTPSA id 1998a0723ff000c244.006
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 27 Sep 2025 07:15:47 +0000
X-Zone-Loop: 4907d34813e86061ab8010c6dd9a2ef533c48af7be25
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=ifFTIe/bJAX4sMNv6aWG1MK5yvIqxjIeJ9DcYQN9/j0=; b=s
	KhmHb+hiGBbIozrrJ5ug8TR9V0EHC3kpqdRZ6Nb3ax5pYvVC6D6sZW2E79jOmlVs+ilJ4hOVtDqLq
	DpritBOt+m06vM2FPg1vICFVcQB7doSbZ87cv/CyCjuxiCZYLBDetZrx6UOyaiBAHedLaWhnx/UZX
	mb9lDcEbyFGnap6wDTdumpKztE5qYGu9tyA7nVWmmBgpM0eVR+UrxGzstxnPLfhhNHTw8gY7vJMOR
	15ZIsdnvnWwy6gXyiN73Sc7mm5i9i6ciuhLJ59EoCz0kvgMuyHG54BjmQnTjDcqdj+sncZEDLoDxe
	xLd1i79VUlBlCo5mkqKzqvzDybY/wReag==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH 0/2] octeontx2: fix bitmap leaks in PF and VF
Date: Sat, 27 Sep 2025 15:15:03 +0800
Message-Id: <20250927071505.915905-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

Two small patches that free the AF_XDP bitmap in the PF and VF
remove paths.  Both carry the same Fixes tag and should go to
stable.

Bo Sun (2):
  octeontx2-vf: fix bitmap leak
  octeontx2-pf: fix bitmap leak

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 2 files changed, 2 insertions(+)


