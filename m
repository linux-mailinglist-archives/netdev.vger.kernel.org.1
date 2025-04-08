Return-Path: <netdev+bounces-180016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA81A7F1D2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB2117CF88
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A625F973;
	Tue,  8 Apr 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fo7neAck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC525F789;
	Tue,  8 Apr 2025 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073670; cv=none; b=CB8sAidRE9AU7fC4LoWiIDPEXMZzBEgwJe+BhFNwkrjAQjrsc5v0INYNKkEJ3cUY3yQydAK3VoNx9b2CEJbT7wAZRqj3Yp2NZkG8SiljTV/e+tLgbzUCFF2yAuc3mLH51ofVpj8ICWvX/6kmuDZ1O22zouUq77Stp1yI4J3ZS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073670; c=relaxed/simple;
	bh=pJpeS6UDHGbVjpYImIei67eeZth3rh0ZwvC8QX8E05s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm+X3UQzaMir/W3rfZtFGm5cFjseo699ZQavqx3r+Y1+35MwT75SvFKqq5GYcRnVLwdkDen0XyCfm2iEesgyGEQ8WqZzf16OyDEa0wrTQ89XLwm8EMFNPeXMb7tItX7nGdgZjlMzlHmXKGomjb2P5t8K6oC6G2NXs+7/R+ZIWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fo7neAck; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744073668; x=1775609668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgadiJU1w8yj5XJQ01I/QKqBYxUhyf+os7wrkgro9Yg=;
  b=Fo7neAck6FmZuZtKWG6DCUY7jugp1rUXNWauz+IvKS+ukOYNVKJRDvKR
   YOdyV6q0Mi2R99EjqC1ei9yaCcPagsaiYy5snm/TP7emMftLyADEZ/MGR
   yeCjYiNdRnZWDTh5FMiFu/9odeF0wmVFf0miYfXk5ThZjUT3bjNIBme1r
   s=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="711903701"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 00:54:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:34745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id 735bb698-a981-4318-8a7b-aa579c2e66da; Tue, 8 Apr 2025 00:54:23 +0000 (UTC)
X-Farcaster-Flow-ID: 735bb698-a981-4318-8a7b-aa579c2e66da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 00:54:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 00:54:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <mathieu.desnoyers@efficios.com>,
	<mhiramat@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <rostedt@goodmis.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next v2 1/2] net: pass const to msg_data_left()
Date: Mon, 7 Apr 2025 17:53:48 -0700
Message-ID: <20250408005404.10223-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407-tcpsendmsg-v2-1-9f0ea843ef99@debian.org>
References: <20250407-tcpsendmsg-v2-1-9f0ea843ef99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 06:40:43 -0700
> The msg_data_left() function doesn't modify the struct msghdr parameter,
> so mark it as const. This allows the function to be used with const
> references, improving type safety and making the API more flexible.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

