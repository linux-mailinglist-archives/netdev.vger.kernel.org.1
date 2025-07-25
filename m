Return-Path: <netdev+bounces-209957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF0B117DF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA4A3AE945
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1D617A318;
	Fri, 25 Jul 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="IK6vK652"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AC4A08
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420924; cv=none; b=OluvUEKHk9Y32hcu+RBGksuULw4fDGWGpR/nDy+wqkRrtHssem3pSSPptQOpDq3Y8vkUySsofFhsqD6/wJuZ3UTaYEo5nzNiMhrqfROo8iiRb3rpdlRnd/K1rFok1QZP+b4Wen3CXEwnVEiRpxg72Kb6/YuiCyqAfv6YrL5Vhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420924; c=relaxed/simple;
	bh=W4Jxyrp4wi7NQzeEqMNGiWcgXwlbR2Uz4//Mp4kqm5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNxOzPWT/qdyMGff8xpKDIqPULBheT24sMOBGWtZ4yadEZaTEB2IBV464IVVIdoo85zizIIuzg54txv+SMhTKvbZnyrsJ93UlEo2N+hcrdb0X4BVcHASCVa90qCD0VbaLqP0dPNLpKjLn5l3x4kKyQ774S94aIqX52IIQB0d1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=IK6vK652; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazoncorp2; t=1753420923; x=1784956923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EoSyH/U+vg8NKM7TKGy5JPX9jXfEqwTVjCqlQUIFU1A=;
  b=IK6vK652I8FOmXFUIY47/4wygQzHKiInxPl4KdO9p/oBs8PA4uHS+VXx
   R+Ddj7tUi501+srQa4v7BB5BZ1jToqsBQDnwZm+MMIeXBhKYzNH6D4Zt6
   A/+Q+JeEY9OqwiIx8f9TKqw8gGAURBVj3Y11b4OyAslivlUiVBojr/z5i
   LvG0rghXHHl0TmyAs+i2V+gWCNw2eX+zAaNrQwLs1uW7iENYzqZXl9sTE
   bWRhPmRT0KKLifp52lR23z33lkxyLhi7TzS6P7docsbIIf/Ez1LfIuULb
   hzosNyJo9q8kuXDFIJiu+EEn1C4iFir+9+W3hXyIcLxTegh2E9i1/pffw
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,338,1744070400"; 
   d="scan'208";a="744134608"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:22:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:45507]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.141:2525] with esmtp (Farcaster)
 id 07003778-a6d0-493a-8767-4880b1e32121; Fri, 25 Jul 2025 05:22:00 +0000 (UTC)
X-Farcaster-Flow-ID: 07003778-a6d0-493a-8767-4880b1e32121
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Jul 2025 05:22:00 +0000
Received: from 80a9974c3af6.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Jul 2025 05:21:57 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <vinicius.gomes@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jhs@mojatatu.com>, <jiri@resnulli.us>, <kuba@kernel.org>,
	<kuniyu@google.com>, <netdev@vger.kernel.org>, <olteanv@gmail.com>,
	<pabeni@redhat.com>, <syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com>,
	<takamitz@amazon.co.jp>, <takamitz@amazon.com>, <xiyou.wangcong@gmail.com>
Subject: Re: Re: [PATCH v1 net] net/sched: taprio: enforce minimum value for picos_per_byte
Date: Fri, 25 Jul 2025 14:21:50 +0900
Message-ID: <20250725052150.48532-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <87ecu5e7r0.fsf@intel.com>
References: <87ecu5e7r0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2025/07/25, 3:58, "Vinicius Costa Gomes" <vinicius.gomes@intel.com <mailto:vinicius.gomes@intel.com>> wrote:
> Takamitsu Iwai <takamitz@amazon.co.jp <mailto:takamitz@amazon.co.jp>> writes:
> > @@ -1299,7 +1305,7 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
> > speed = ecmd.base.speed;
> >
> > skip:
> > - picos_per_byte = (USEC_PER_SEC * 8) / speed;
> > + picos_per_byte = max((USEC_PER_SEC * 8) / speed,
> > TAPRIO_PICOS_PER_BYTE_MIN);
> 
> 
> Thinking if it's worth displaying an error to the user here? something
> like "Linkspeed %d is greater than what can be tracked, schedule may be
> inacurate". I am worried that at this point, taprio won't be able to
> obey the configured schedule and the user should know about that.
> 
> 
> If we see people complaining about it in the real world, we can change
> the units, or do something else.

Thank you for your feedback on this patch.

I agree with adding message about this here. I'll revise the patch to add 
a pr_warn() message when the calculated picos_per_byte would be below the
minimum threshold.


Thanks.
Takamitsu

