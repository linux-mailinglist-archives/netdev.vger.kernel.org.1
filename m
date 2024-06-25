Return-Path: <netdev+bounces-106476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA069168BC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399551F23341
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF315F3F9;
	Tue, 25 Jun 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwVgCJy3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383091509A2
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321641; cv=none; b=NjHdoNGeGAHFzFgLauUNI3GAryqvEqWKtiy9VONm1vpTP7zdG7tWhb6La8LiklHc6yyRgRKcZCEDr3NoZIPvd0dj1fiOcw4dlEc3NPP0VoWG+wEJdZ69HMtYox83q849zaTwe1WAnL7f5ZhzBRhFptDZFsAPmw8OYcTdi5XMtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321641; c=relaxed/simple;
	bh=Sz6HzsSs24V3LrifEgy9lvXYymx2kFSHTUUfQoAmcuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FIaQVOkC0lQDmQYbqb8jxYZ6ZpZFgZ5919VA49bqSf10v7f5RVTOSLZ/ByCnDpIN9PiEomcvhNlfojZ84iTsApWMjffMiER+nqCkNl1JGCxd6j8g22oyOykLtPdLpV+zf4DpzljFVOkcSMJa28CInQLPeYSkv84rQJGaDWWfyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwVgCJy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719321639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/e9z7Yv696hRI+pz5DLLkpBHy/fSwbj7SUwfZZ7dpq4=;
	b=VwVgCJy3QODZ/mJdkvG+0XmKYgbiMqg/9vyEADbEHmWEBJlhz/XBoXaYy9a8uvZwWO8eHp
	Eg2ac+4nizs+hROj35CdAqdg+vS+E0M9leUMoGVbKwGYN6YCcN9L2d7UW/tybRaNxOyqno
	kp8Lp75KlRcq4o3qAVjr/W9g7AL1Ca4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-SpxmM-NWOy268opMx0QYAw-1; Tue,
 25 Jun 2024 09:20:35 -0400
X-MC-Unique: SpxmM-NWOy268opMx0QYAw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7389319560B7;
	Tue, 25 Jun 2024 13:20:33 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CCE300021A;
	Tue, 25 Jun 2024 13:20:31 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Shuah Khan <shuah@kernel.org>,  Stefano Brivio <sbrivio@redhat.com>,
  =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>,  Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
In-Reply-To: <e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	(Paolo Abeni's message of "Tue, 25 Jun 2024 10:27:03 +0200")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
Date: Tue, 25 Jun 2024 09:20:29 -0400
Message-ID: <f7th6dhgnvm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Paolo Abeni <pabeni@redhat.com> writes:

> On Mon, 2024-06-24 at 12:53 -0400, Aaron Conole wrote:
>> Aaron Conole <aconole@redhat.com> writes:
>> 
>> > Jakub Kicinski <kuba@kernel.org> writes:
>> > 
>> > > On Thu, 20 Jun 2024 08:55:54 -0400 Aaron Conole wrote:
>> > > > This series enhances the ovs-dpctl utility to provide support for set()
>> > > > and tunnel() flow specifiers, better ipv6 handling support, and the
>> > > > ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
>> > > > the pmtu.sh script to call the ovs-dpctl.py utility rather than the
>> > > > typical OVS userspace utilities.
>> > > 
>> > > Thanks for the work! 
>> > > 
>> > > Looks like the series no longer applies because of other changes
>> > > to the kernel config. Before it stopped applying we got some runs,
>> > > here's what I see:
>> > > 
>> > > https://netdev-3.bots.linux.dev/vmksft-net/results/648440/3-pmtu-sh/stdout
>> > > 
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS vxlan4: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS vxlan4: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS vxlan4: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS vxlan4: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS vxlan6: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS vxlan6: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS vxlan6: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS vxlan6: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS geneve4: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS geneve4: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS geneve4: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS geneve4: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS geneve6: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv4, OVS geneve6: PMTU exceptions - nexthop objects
>> > > [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > # TEST: IPv6, OVS geneve6: PMTU exceptions [FAIL]
>> > > # Cannot find device "ovs_br0"
>> > > 
>> > > Any idea why? Looks like kernel config did include OVS, perhaps we need
>> > > explicit modprobe now? I don't see any more details in the logs.
>> > 
>> > Strange.  I expected that the module should have automatically been
>> > loaded when attempting to communicate with the OVS genetlink family
>> > type.  At least, that is how it had been working previously.
>> > 
>> > I'll spend some time looking into it and resubmit a rebased version.
>> > Thanks, Jakub!
>> 
>> If the ovs module isn't available, then I see:
>> 
>> #   ovs_bridge not supported
>> # TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
>> 
>> But if it is available, I haven't been able to reproduce such ovs_br0
>> setup failure - things work.
>
> I'm still wondering if the issue is Kconfig-related (plus possibly bad
> interaction with vng). I don't see the OVS knob enabled in the self-
> tests config. If it's implied by some other knob, and ends-up being
> selected as a module, vng could stumble upon loading the module at
> runtime, especially on incremental build (at least I experience that
> problem locally). I'm not even sure if the KCI is building
> incrementally or not, so all the above could is quite a wild guess.
>
> In any case I think adding the explicit CONFIG_OPENVSWITCH=y the
> selftest config would make the scenario more well defined.

That is in 7/7 - but there was a collision with a netfilter knob getting
turned on.  I can repost it as-is (just after rebasing) if you think
that is the only issue.

> Cheers,
>
> Paolo


