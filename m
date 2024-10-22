Return-Path: <netdev+bounces-138020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498D9AB83E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D033284857
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EC1CB306;
	Tue, 22 Oct 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b39Dyxyt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959E18DF6B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631521; cv=none; b=OZVUa8zT4YM6I6IoOkJS7Ldo7oHR+Ar32Vjha+bMvl4tR94bdB2h2GxxS26gvPAPkxy6hwmFzCK56li1HJnrP8rpgEghrP5uG61FnHrkI09VP3Wr6HlkPaRKR8uEXwLexk8wXXD2KE+8d98V0RAOhEwpR+BAWPJ0FPLjUan8P+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631521; c=relaxed/simple;
	bh=iUakCUqWNgCwHIgGJjcw+q8KDQDWA6ZvqyI1yJPkpqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8KFG1IiX646hePGHAwqr6grOydTOcaoxuruHCJnSJG+ZelM6WiWHFVQAKTu5e8ObrLYAhmJF+nq7sramf6in1KOs6j4YcqO6lZ04AZy8pLph1y/3YSry1KCeKZ182HYteDq+bIi4BFGDQrbvKNg2RgHMr+I8dDLoXiFulWS4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b39Dyxyt; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729631519; x=1761167519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUKl8jB1lfHVkSNyYZtp3bgEH8g9o7d9aI0q0eI9yxE=;
  b=b39DyxytKj2oGE5tKRXrMBr33Ftkcbx/QSdPpIf/InI9y+hSwjpUF0ZE
   PA23Pkt5dCxNc0xjWD6CaSmZxQDBc35cbet9BmgoC+yraeyL/3R37N9uX
   0raqOKQ2JT6aF02faHy0XH8ZMbdu0AIT73XRI0Mz0LhMicjIkvw+H2Pe/
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="463689431"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:11:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:32596]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.58:2525] with esmtp (Farcaster)
 id 7f6b1091-a19b-4805-af7a-b228a6efc287; Tue, 22 Oct 2024 21:11:58 +0000 (UTC)
X-Farcaster-Flow-ID: 7f6b1091-a19b-4805-af7a-b228a6efc287
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 21:11:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 22 Oct 2024 21:11:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <gnaaman@drivenets.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] neighbour: use kvzalloc()/kvfree()
Date: Tue, 22 Oct 2024 14:11:52 -0700
Message-ID: <20241022211152.88270-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241022150059.1345406-1-edumazet@google.com>
References: <20241022150059.1345406-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 15:00:59 +0000
> mm layer is providing convenient functions, we do not have
> to work around old limitations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

