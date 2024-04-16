Return-Path: <netdev+bounces-88496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0A8A778A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F014282F8E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4A78B49;
	Tue, 16 Apr 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I0GrcyFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089256B7A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305472; cv=none; b=tx4r/2t1/HJ1t2e08JcAOygS/wCA6AKkYGRYNvxVlrmz0WG41DQodXrWyU04v0Mtg3y0nuMmPoAev6QNu337MTZnsbz9y5LpByMwUJimPHwVJJqSLuP50IDEECJJYpB4G5AZZLJVoKOyrCS3cmvL3rfZWpXri2DiTTU5T8b1ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305472; c=relaxed/simple;
	bh=oD9osyX48WDpbBZtJEvktW/MexCBMZsaHSk2F87AEvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt2hD3rf+HLsQnaZT2/VNAX5dq3BxgvyEkCekKLAn9aseh1bSDo9QgNr90cm3p7lmabBnjsxAqJU55vjjSrDzjACt+8ZrxqwxWDp1INKmE3VN4jrklqoOwF2yvqXkLO2Gzipdcdn5jxt3XL3TRjZUyMQdRescCNY6dUPvHKaVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I0GrcyFL; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713305471; x=1744841471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZqttd8/pLLbg6S+plFOyNKEEO2gv1QYlnnTyKCY6Oc=;
  b=I0GrcyFLBspM/NHcNrnh+1e3iHCB9elZL5x51RoCz51wL4bDcnSUTNt8
   tpI+OqPI05UDVd91zVcf/GW5lCQntnWVDyr8iI76KM8xiRxab8oqDb+JR
   HPXd3DVWmGvsELFH2Gr1ajcOEqZYzLb9UGhaQjniIUCheh8gsAkPWevTO
   g=;
X-IronPort-AV: E=Sophos;i="6.07,207,1708387200"; 
   d="scan'208";a="395157408"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:11:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:55989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.207:2525] with esmtp (Farcaster)
 id af548086-413d-4fb3-b188-99a368e09047; Tue, 16 Apr 2024 22:11:06 +0000 (UTC)
X-Farcaster-Flow-ID: af548086-413d-4fb3-b188-99a368e09047
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 22:11:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 22:11:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
Date: Tue, 16 Apr 2024 15:10:55 -0700
Message-ID: <20240416221055.35661-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dc42242b-40f2-4be0-b068-62e897678461@oracle.com>
References: <dc42242b-40f2-4be0-b068-62e897678461@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Tue, 16 Apr 2024 15:01:15 -0700
> On 4/16/24 14:47, Kuniyuki Iwashima wrote:
> > From: Rao Shoaib <rao.shoaib@oracle.com>
> > Date: Tue, 16 Apr 2024 14:34:20 -0700
> >> On 4/16/24 13:51, Kuniyuki Iwashima wrote:
> >>> From: Rao Shoaib <rao.shoaib@oracle.com>
> >>> Date: Tue, 16 Apr 2024 13:11:09 -0700
> >>>> The proposed fix is not the correct fix as among other things it does
> >>>> not allow going pass the OOB if data is present. TCP allows that.
> >>>
> >>> Ugh, exactly.
> >>>
> >>> But the behaviour was broken initially, so the tag is
> >>>
> >>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> >>>
> >>
> >> Where is this requirement listed?
> > 
> > Please start with these docs.
> > https://urldefense.com/v3/__https://docs.kernel.org/process/submitting-patches.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUA5Yikc2A$
> > https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-netdev.html__;!!ACWV5N9M2RV99hQ!PswtQoZm7r5MGnH8pv3OewI_PvmSRJb29YcA0pnVOzuu8T3xvWlw4lLlLzFhzn6uO2lo0bUAdoz3l7w$
> > 
> > 
> That is a suggestion. I see commits in even af_unix.c which do not 
> follow that convention. They just mention what the fix is about. In this 
> case it is implied.
> 
> I am not opposed specifying it but it seems it's optional.

You want to read the 2nd doc.

  1.1 tl;dr
  for fixes the Fixes: tag is required, regardless of the tree

