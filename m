Return-Path: <netdev+bounces-72816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE952859B73
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EE91C21994
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C331CA98;
	Mon, 19 Feb 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bJIVCS51"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02318257D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318504; cv=none; b=ULj2g+RQyE3/yWPbwyiVnWkw2jbCAuyizcyZ7AJJcltTD+hfKtM+KnfRggQrIKo84sBe85SI680s9zNGml7CrfNgiCnl8YNIOBLDqqBZr/GttqSogrilyud3IMIYJrXX1yQFfB+ZD03pdQTXuLQjTIGMUjrm+mMifOrVk3fF8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318504; c=relaxed/simple;
	bh=Zy37Di/CY6HFxojfeS/ALLuKwlaeQ8bqPc/I6/tOQ78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRYeFSIso+KZlmuu/Cml7e7MZ8WdVUoxGqXh+IIXytGIO42IMD6U5VRJMIDdiif/qh/Qbmm4B+bbyfFn3I2tsm+LxNlK8neyAYN48HdTnIOC9E1p/FUqHKtTyWv2ZfWImxvCDyyDbuBtkuhv+SZLoCrYF8fKtPWPVembC6o148I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bJIVCS51; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708318503; x=1739854503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ew2Dg5UT7JbyYZWMe0YKyNT8x5O0Vg7S9udmp/5Jzy8=;
  b=bJIVCS51BBBIN1qujVCdNxfMGNZDhj+eOXbg7KKPASUjStXNbPcYWFKD
   JzobcbeDGGd+Xc47dAEUhtvRIcM4vQyerlXH6CIGidOLxLyN8cPmidqCp
   o/xa00bzPNQZy9UpeIc0CzJAVXroMNxlYms+sp+c6yzZ0oiFozeHDx0gS
   4=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="635068595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:55:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:17383]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id 1f655141-7125-424b-a384-304e438fa450; Mon, 19 Feb 2024 04:54:59 +0000 (UTC)
X-Farcaster-Flow-ID: 1f655141-7125-424b-a384-304e438fa450
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:54:59 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:54:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 07/11] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Sun, 18 Feb 2024 20:54:47 -0800
Message-ID: <20240219045447.99923-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219032838.91723-8-kerneljasonxing@gmail.com>
References: <20240219032838.91723-8-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 11:28:34 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch does two things:
> 1) add two more new reasons

description was not updated since this patch was split.


> 2) only change the return value(1) to various drop reason values
> for the future use
> 
> For now, we still cannot trace those two reasons. We'll implement the full
> function in the subsequent patch in this serie.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

