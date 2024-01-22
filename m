Return-Path: <netdev+bounces-64905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E983766A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C0A2840A4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33214F6D;
	Mon, 22 Jan 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sCViFFAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E4381A9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963058; cv=none; b=sCtngBLf6LXQ80BY4fjaZgFaoLeF0bYv50EHKcfUbOk6/gjtpnek+oHWSuUqNbppKvxQdEJB5gbSMvWGMdsLdtSJMX9RSZdihodkn6rqPgqS2Ys32LjIBSZo2+1ULWfpDTV+SytNnD5YyQaOuJws9q2YsWzACNuzDC/HN6DbS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963058; c=relaxed/simple;
	bh=bjHGa4Qf9ZI5WKvJzE03pyqvnNDgiTF11A/PFneIl6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtO2y59ulzthicgMaUXEhgminAGUB13ikuC8EODbqVhxMkav/vY33cvjb4P0g2Vbjay0XF0vjybzwhJvT734BqyPd2EdPevbzvqqf6YefV3at8h1z4wtvXAHZOcuoEK3sUonUDeLgiC9cSN7RmKNolnnNJ71TYHMvSW/fcvOvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sCViFFAK; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963058; x=1737499058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROeHPLAxriCrHBkCrGvWXjokL/BQ4DAQwJmKMWG1nRQ=;
  b=sCViFFAKupxFbM358/UgcaMcIUoHoCjj0+JTHZ+MswYs24QJAYAm7PNF
   fkd83vOF5Wk4/+GejXAr98y9QHxiDcHv2Qpjpf+zdEqdzkWqY3AOyMPO6
   oFnuy1sB6LXBCkwGanKbnGbw+2rl+8Y5YK2+w1bbrmasOUbKNUI64x1/a
   Q=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="699673104"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:37:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 3426D8862E;
	Mon, 22 Jan 2024 22:37:36 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:20203]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.213:2525] with esmtp (Farcaster)
 id 0c746f30-64ce-44eb-b402-b4e8805a25e6; Mon, 22 Jan 2024 22:37:35 +0000 (UTC)
X-Farcaster-Flow-ID: 0c746f30-64ce-44eb-b402-b4e8805a25e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:37:35 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:37:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/9] inet_diag: annotate data-races around inet_diag_table[]
Date: Mon, 22 Jan 2024 14:37:21 -0800
Message-ID: <20240122223721.19732-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-3-edumazet@google.com>
References: <20240122112603.3270097-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:25:56 +0000
> inet_diag_lock_handler() reads inet_diag_table[proto] locklessly.
> 
> Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.
> 
> Fixes: d523a328fb02 ("[INET]: Fix inet_diag dead-lock regression")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

