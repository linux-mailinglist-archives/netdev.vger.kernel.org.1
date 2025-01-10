Return-Path: <netdev+bounces-157234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C673A09909
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16903AB001
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF4212B01;
	Fri, 10 Jan 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QI2xnspt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E391224D7
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532114; cv=none; b=BJah0QbTRlIJB4DdQMD6xUI87ZWFYOhbSwDBybNY+YadJnSAoYASupvpHv4nc2jHvGA7J9lBwZsiZE1GOt12Z2ngvJnNK9eOfFUCteSF2O2nYSIiSzQZvUvqaP5lPl/t3mJECwlKv531++ldKdAnHnUfy9wkk2EGazLgytuWZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532114; c=relaxed/simple;
	bh=Z4UXGe7ECPYl7yU1O12FNqqmp6VrFqvyHX9jrf1R388=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1k/o1/+HZrT9Llk2fiDNULzG18hYYbMV9+DvK2IKQjn8oJxMMRY5X61DYBCHIuW+CCv6aR6WSxVUmhGpEjgSIV8IXlJ/yY6WQJl3auBNWlHbVBoOTK3ereFTpwwNNeEkPFEiKvXl6ubx8eC1J49wQQiH/mUvMN7leoxq6g7b2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QI2xnspt; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736532112; x=1768068112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEmR5UEtps4cqJyrRFZgztJvI9Kn60gwrU+xAkifl8k=;
  b=QI2xnsptXjS+sae0CHI3TC1CBq+aSkBwMIJaVwiBu6uC5cwFqLKW4eGu
   Vbh9Egpgn4Tp2nbb1zO+I34jGdwamwoLAQxfG4TmEuDxb8zUOVDDcEaFQ
   YE3Yeofw8jrxl5k21bTSIrT9Isi7kYa2ZmCJ0wHHex07m72eIW1m7ZKoA
   E=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="453323051"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 18:01:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:64665]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.174:2525] with esmtp (Farcaster)
 id d471b738-b639-4e45-ba98-49cdbd8e199e; Fri, 10 Jan 2025 18:01:48 +0000 (UTC)
X-Farcaster-Flow-ID: d471b738-b639-4e45-ba98-49cdbd8e199e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 18:01:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 18:01:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] tcp: add drop_reason support to tcp_disordered_ack()
Date: Sat, 11 Jan 2025 03:01:34 +0900
Message-ID: <20250110180134.57158-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110143315.571872-2-edumazet@google.com>
References: <20250110143315.571872-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Jan 2025 14:33:14 +0000
> Following patch is adding a new drop_reason to tcp_validate_incoming().
> 
> Change tcp_disordered_ack() to not return a boolean anymore,
> but a drop reason.
> 
> Change its name to tcp_disordered_ack_check()
> 
> Refactor tcp_validate_incoming() to ease the code
> review of the following patch, and reduce indentation
> level.
> 
> This patch is a refactor, with no functional change.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

