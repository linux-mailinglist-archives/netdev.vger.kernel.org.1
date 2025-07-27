Return-Path: <netdev+bounces-210349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE5B12E13
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 09:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4C93AC63B
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E01D7995;
	Sun, 27 Jul 2025 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="b527FfSS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A5747F
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753600959; cv=none; b=S+J648WGDCLBepnofE1S2v7AGo/KwsD8V5yAgzzF+7UjgrF1L3NchzDaqVgC0QB+FU1OdE5/B3kAQjgFTzZhVyxoQz62AoVhkn1wFx2JlAPYn3pNKadGphVD5zOo3fW7kC/9GdPWOAbJ5XIMSgc4MkwL4xK0LdeEeKtaNmM5ttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753600959; c=relaxed/simple;
	bh=6STNvONrv8ehUpkMkEsqoCxin++63XKeh11098s8+6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/B4BafBaSyqKG5CBcuMNzksVLNOHl7JEn0vN1XcMZN4ePJTD7MqhdP7c33eJ3erSs0wfKrU7m4NGrFAAkN1yFHfdlgFsIyM1mAiqUPinU13p22FepmvjE256Z/Asg/d1kWsvWm2GcBWBsWl88rg9bih1aQl0Y1MJwOlu2saHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=b527FfSS; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazoncorp2; t=1753600957; x=1785136957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+coXo4GtgkCU4YdEoUJioMHAPLW4MC5haSzwl8DKz4=;
  b=b527FfSSeHTPAve1uDXoo2TYkUwEyZhN5iPrG2cecd8duMf3gsfFG2NE
   Afsgx1qybobBHiyz6i+NYsGIVY77Rw2CdFBbQwlV3n/RDQzzz2XDwppT9
   AJH+sg331yNOLqZLURQ5PD3I5092CUOfuhOdTltvZAuLB1GSSPJAThNfk
   MKzGdqWNyoh7DWu7cmam5e1Vj3bMMsSKYqoN9yZ4HBe0ev1xrPmuI3SB9
   AFmw9bFplT8G6ytvB3lBeUkET7UDcHCM9LgcgIWyGTNLwaGoox+A1sv7R
   UhT2zk6bDWDTsaazgrSmvCVS8vcXie5k7J8m7TLqMpO67fkfCUyJ3e0KX
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,339,1744070400"; 
   d="scan'208";a="217686555"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 07:22:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:35446]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.204:2525] with esmtp (Farcaster)
 id b9e6aae1-7273-4d6b-9f4f-4740ccc24efd; Sun, 27 Jul 2025 07:22:36 +0000 (UTC)
X-Farcaster-Flow-ID: b9e6aae1-7273-4d6b-9f4f-4740ccc24efd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 27 Jul 2025 07:22:36 +0000
Received: from 80a9974c3af6.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 27 Jul 2025 07:22:34 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jhs@mojatatu.com>, <jiri@resnulli.us>, <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
	<syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com>,
	<takamitz@amazon.co.jp>, <takamitz@amazon.com>, <vinicius.gomes@intel.com>,
	<xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v2 net] net/sched: taprio: enforce minimum value for picos_per_byte
Date: Sun, 27 Jul 2025 16:22:27 +0900
Message-ID: <20250727072227.22748-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250726113743.0e9aad80@kernel.org>
References: <20250726113743.0e9aad80@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)


>On 2025/07/27, 3:38, "Jakub Kicinski" <kuba@kernel.org <mailto:kuba@kernel.org>> wrote:
>>  struct sched_entry {
>>       /* Durations between this GCL entry and the GCL entry where the
>> @@ -1300,6 +1306,11 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
>>
>>  skip:
>>       picos_per_byte = (USEC_PER_SEC * 8) / speed;
>> +     if (picos_per_byte < TAPRIO_PICOS_PER_BYTE_MIN) {
>> +             pr_warn("Link speed %d is too high. Schedule may be inaccurate.\n",
>> +                     speed);
>> +             picos_per_byte = TAPRIO_PICOS_PER_BYTE_MIN;
>
>for the path coming in from taprio_change() you should use the extack
>to report the warning (if return value is 0 but extack was set CLIs
>will print that message as a warning directly to the user)


Thank you for your review.

I decided to use pr_warn() only because taprio_set_picos_per_byte() is
called from two different paths:

1. From taprio_change() where extack is available
2. From taprio_dev_notifier() where extack is not available

I plan to modify the patch to handle both cases by:
1. Adding an optional extack parameter to taprio_set_picos_per_byte()
2. Using NL_SET_ERR_MSG_FMT_MOD when extack is provided
3. Falling back to pr_warn() only when extack is NULL

I'll submit an updated version with these changes.


Thanks,
Takamitsu

