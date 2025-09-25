Return-Path: <netdev+bounces-226370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36151B9F9C5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD71C22A2D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CF275878;
	Thu, 25 Sep 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="jFHwPNYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A526CE0F
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807611; cv=none; b=jGHdV5NEIRSMYzXUgdFZ6yk8/G1ObifHYtRQThzs913f/p/TKxbxT8tVXkyIBnxCJG7i35Wok4gHt4/hHN+/sFazXp0Wp1h7yCfZ2qNKArG/SmV0MRwSlk6+CvYK6XC4R6/xR0HGMbTbvf5nky+fsohvQe1BM7jRwOZtyglY1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807611; c=relaxed/simple;
	bh=A/h/juuCPsvd250S715gwteOI9pU724vXu2yT9Odr6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ze+U/vdkQ3yA3M/sqPA4RRWIXBvEvjXX9Kcrp7YjFdNPIhgBshnRmr+CwDKMItIMim9niexRWVEVIyBt6apWtHj+bc4jKEBu0BIFmkHH+G1UTFnqSFnMChGtpfiYWEnYBzY2f//vDHgbQDPA8TX3/vX5NgpIoJgT8SN+unHmxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=jFHwPNYr; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1758806997; bh=A/h/juuCPsvd250S715gwteOI9pU724vXu2yT9Odr6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jFHwPNYrPGOppsG8JtxNE16F/hYWoT/UDrsgYLPJKLCndrQPDiXdQ9ERpR70v70qH
	 Etlg6hvAfyNk/NB2NMxVdlDr5aJEZCdpAjEwValo3ef8dNonMYFBMh7PG/OrSWFW8n
	 Rhau2pz4QaSS9PUnP1jDlT1GOUpE/YHoh4aObXrVpEbgENoVL+RzBqHCHeErXCGhzW
	 o+3Lk2DC5MsUIKLaSSqTBLI9UQrcGAxKdKKZqxPVZOZBscROkm+wWCFmhG8GRlth4A
	 flu6eHMotG+69USiC5fVBrb4L+55jjlgi9MwcBXBFeQBC7qOO2LGgSJZ2tdXpy5xT4
	 K7PlLUXb08fhA==
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonas =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net/sched: sch_cake: share shaper
 state across sub-instances of cake_mq
In-Reply-To: <m2ecrusy11.fsf@gmail.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
 <20250924-mq-cake-sub-qdisc-v1-4-43a060d1112a@redhat.com>
 <m2ecrusy11.fsf@gmail.com>
Date: Thu, 25 Sep 2025 15:29:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o6qypsmk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Donald Hunter <donald.hunter@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> From: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>>
>> This commit adds shared shaper state across the cake instances beneath a
>> cake_mq qdisc. It works by periodically tracking the number of active
>> instances, and scaling the configured rate by the number of active
>> queues.
>>
>> The scan is lockless and simply reads the qlen and the last_active state
>> variable of each of the instances configured beneath the parent cake_mq
>> instance. Locking is not required since the values are only updated by
>> the owning instance, and eventual consistency is sufficient for the
>> purpose of estimating the number of active queues.
>>
>> The interval for scanning the number of active queues is configurable
>> and defaults to 200 us. We found this to be a good tradeoff between
>> overhead and response time. For a detailed analysis of this aspect see
>> the Netdevconf talk:
>>
>> https://netdevconf.info/0x19/docs/netdev-0x19-paper16-talk-paper.pdf
>>
>> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  include/uapi/linux/pkt_sched.h |  2 ++
>>  net/sched/sch_cake.c           | 67 +++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 69 insertions(+)
>>
>> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sch=
ed.h
>> index c2da76e78badebbdf7d5482cef1a3132aec99fe1..a4aa812bfbe86424c502de5b=
b2e5b1429b440088 100644
>> --- a/include/uapi/linux/pkt_sched.h
>> +++ b/include/uapi/linux/pkt_sched.h
>> @@ -1014,6 +1014,7 @@ enum {
>>  	TCA_CAKE_ACK_FILTER,
>>  	TCA_CAKE_SPLIT_GSO,
>>  	TCA_CAKE_FWMARK,
>> +	TCA_CAKE_SYNC_TIME,
>>  	__TCA_CAKE_MAX
>>  };
>>  #define TCA_CAKE_MAX	(__TCA_CAKE_MAX - 1)
>> @@ -1036,6 +1037,7 @@ enum {
>>  	TCA_CAKE_STATS_DROP_NEXT_US,
>>  	TCA_CAKE_STATS_P_DROP,
>>  	TCA_CAKE_STATS_BLUE_TIMER_US,
>> +	TCA_CAKE_STATS_ACTIVE_QUEUES,
>>  	__TCA_CAKE_STATS_MAX
>>  };
>>  #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
>
> Hi Toke,
>
> Could you include this diff in the patch to keep the ynl spec up to
> date?

Ah yes, will do, thanks! :)

-Toke

