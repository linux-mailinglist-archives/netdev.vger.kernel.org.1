Return-Path: <netdev+bounces-220246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D5B450B1
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C662D1C840D6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592B2FFDF4;
	Fri,  5 Sep 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="M4jZiYPy"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20B2FDC4C
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059219; cv=none; b=YUgmUOSFGptQtVG03KXj3U74rXX6Ep8es2Dc9akzw7kep+QD5wrXA41IX6iAV/LY4qtzy+vVmkj+UZnIosGRQss9eqiYPI+act0F/hSJcQ4YkUf+RciLiP75ASEQTaVdwYD0YEwQpEDNaejGIaUFV9iSDyOF1qV57iQy7FJ+P8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059219; c=relaxed/simple;
	bh=PKcGOE27La506O4aJ9TtCKuqbs1DomPlb6Zmksz92aA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvDNOancK7sw38MymQfamUshYfqb9u/KCdC7pEmrY7WHI6ghGvvXxXXwZzuBqgLp/tpxnPeW+wqP1wCz5aPPA6QLxHXH28HivuUo+FBvx4H9iToGiQpmTknlzSwMv1A/86ppOKCzgqVkteDTGNWUmlTK1IdAgftm2d1QdfGAXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=M4jZiYPy; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1757059217; x=1788595217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HXzv/7uddS7ljsL/f3TDhdHJme57eSmb7lfaxu+rYQ0=;
  b=M4jZiYPyBmwTuJbNQMhzCFasnLxZBw6JKeD+DQqsRpYN9PD2jIAm0132
   8+dL4Zs+xIXa6VDl3E0XH0g6Ez6NdAtgtdT0cKyNeL2H94qaP2X6dgF0A
   Nc5ljmVNam3l5cBbG0oEv+m4Rsd13I/X0NVa2Pw2jPBbruFhN7LpZ0aGf
   2mZYZKxWxDdemchQ1l3duGwicl3HC3DFUOYdIWXIXrhQA2sMWh8/aeeoL
   HhwOECJc8ZeWwPya1bqGOFDK5zPFuHTBWYjWBSGfEB87ZNHkL26OpKfYN
   zQRfjiVc0EFBb3mQC4uT5Vm9fcYbXn4umJ7Bj+Mys4NrbvksX7QcGutZ7
   A==;
X-CSE-ConnectionGUID: ZuLwnq8oR3iQ40YOEzU/nA==
X-CSE-MsgGUID: FtNsuUevRNCdB9aKQZKIHw==
X-IronPort-AV: E=Sophos;i="6.18,240,1751241600"; 
   d="scan'208";a="2467935"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:00:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:35883]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id dfada9d2-8a61-4815-9173-ab7255ad4eb9; Fri, 5 Sep 2025 08:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: dfada9d2-8a61-4815-9173-ab7255ad4eb9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 5 Sep 2025 08:00:15 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 5 Sep 2025
 08:00:13 +0000
Date: Fri, 5 Sep 2025 08:00:10 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: Paolo Abeni <pabeni@redhat.com>
CC: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
	<jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <leon@kernel.org>,
	<ye.xingchen@zte.com.cn>, <liuhangbin@gmail.com>
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <20250905080010.GA88822@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
 <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
 <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
 <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Sep 13, 2023 at 08:28:13AM +0200, Paolo Abeni wrote:
> To me both cases look the same in the end: the team driver sets and use
> header_ops of a different device that will assume dev_priv() being a
> different struct.
> 

Hi Paolo, we're seeing syzkaller to run into this exact issue (type
confusion) in ip6gre_header, when adding ip6gre device as a port for a
team device.

> I'm guessing a generic solution could be implementing 'trampoline'
> header_ops that just call into the lower port corresponding op, and
> assigning such ops to the team device every time the lower has non
> ethernet header_ops.
> 
> team_dev_type_check_change() should then probably check both dev->type
> and dev->header_ops.

I tried implementing such trampoline for header_ops.create op for team,
and have the following problem: 
At the time header_ops.create is called on a team device, I don't know
which port device will be used to transmit the skb in the end. 

Could you elaborate what would be the solution for that, please?

Kind Regards,
Jakub

P.S.: Sorry for reviving 2y old thread, but I felt it's better than 
opening a new one since the context is here. Correct me if I'm wrong or
if you'd prefer otherwise, please :)



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


