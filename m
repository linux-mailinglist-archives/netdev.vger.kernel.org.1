Return-Path: <netdev+bounces-183106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B89A8AE38
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5403B92D1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1341A23BE;
	Wed, 16 Apr 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NbWwR4O3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673622557C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770954; cv=none; b=C8TXJ6z9yByiL2eSJk8DWx9cZzl+n0XbM8ALSJO3GPheAgEk5si0YA9KiTonKTTwzQXh0QgWhc2oS6xrkGJmJEaiXKq7uJt1JfnU4gvVdRcMKPaMXzhq6PhX6tOtoeoeQootynmLQkEcls94iCBd87aJl2eGC0ziqtlaB2GWOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770954; c=relaxed/simple;
	bh=e200zRzNaEn3jqsOMzmyJvAseXmcT2O+pzPqH9/gblU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4AAZT+FkvVSaF7oDB6PTUVq8AXeXNfdPXtas6t8ikHi44Kx+MOeBznpRsjibPCuMuQAjfhXC/PDo3hEvDPBA2CtwNXVl70PL0OHpQmFlwgO2cPBjW8YC0wev5/Mx3bBM/1gNGTHoXxraff3nM/Elj9+x8jEXsafg+cjyxN0smU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NbWwR4O3; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744770952; x=1776306952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmSxlf+mPUfS6qcdX5JF4WIkZZnOrsIJKp1xhwrP4Kw=;
  b=NbWwR4O3MuPZhK3yjozu7vr92lDZnNFP75o1cTwlme3kdaefiUj6HUbd
   AgCu3qhb9QUB6Hb7/ERZ1lUHXZQx0WAe52HojLcpGZUewlsywqI7/eT6N
   tEvPhWH46HZb3ljUeN8NqEhkUXlhCOTTkvn7SFMYvy0VufWxBhHIusMrk
   I=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="489757067"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:35:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:6682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 456c79dc-685c-4e8c-870d-22cb0a180e3b; Wed, 16 Apr 2025 02:35:47 +0000 (UTC)
X-Farcaster-Flow-ID: 456c79dc-685c-4e8c-870d-22cb0a180e3b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:35:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:35:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <renzezhongucas@gmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [BUG] General protection fault in percpu_counter_add_batch() during netns cleanup
Date: Tue, 15 Apr 2025 19:35:20 -0700
Message-ID: <20250416023538.42335-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CALkECRgvg9us9Mp79G-cQ8dOwUA=oHH8jY=Q0ApLNDDNGAg4OQ@mail.gmail.com>
References: <CALkECRgvg9us9Mp79G-cQ8dOwUA=oHH8jY=Q0ApLNDDNGAg4OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 15 Apr 2025 11:39:31 +0800
> Hi maintainers,
> 
> In case the previous message was rejected due to attachments and HTML,
> I am resending this report in plain text format.
> 
> During fuzzing of the Linux kernel, we encountered a general protection
> fault in `percpu_counter_add_batch()` while executing the
> `cleanup_net` workqueue. The crash was triggered during the destruction of a
> network namespace containing a WireGuard interface. This was reproduced
> on kernel version v6.12-rc6.

v6.12 is LTS, but -rc6 is unstable and too old.

Please use the latest kernel for fuzzing, prefarably
net-next.git or net.git for networking issues.

