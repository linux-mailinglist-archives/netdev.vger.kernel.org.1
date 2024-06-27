Return-Path: <netdev+bounces-107326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA4B91A925
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C9B284C88
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210C3195F22;
	Thu, 27 Jun 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l0C0JT3o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03038195F1B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498261; cv=none; b=kHttM67L3WcAmH1q7IyEJR2Sfx6CLTuNzBwUpy08O0Nixg+7A/WjvjolnuNq5gK8iri8pjBxZVA/ISWKFDOJJi4y8kq4J+F1QIN3llbDg2nJwbm+tW2komz9zsPPfLj2vJogXzqmVPI64kY7R3FKmBHgx+m221dpE6PPF8H4OyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498261; c=relaxed/simple;
	bh=eP++XOCKo6V6FTwjNKZ7el6fjbOEpnWNQMSYvg5b5tY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=e4Uxjx4fm+R5PsTUrcHItwoGctKG0Q5DqChOKCbJMMGFKPP/5B/kxUth+obFMP9JT88CFpmOpZruxsH6uVkX7VRXoTGaJjQJd7+4b7Bh3Re0fOCZ142d0nSj5567ZPXLR2ByFYSNX0hLZovHsxhcrBZrgkkd72UTQUhH9ulmkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l0C0JT3o; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FA1D3F73B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719498254;
	bh=8uroOoCAtfmxQT5deF8n+fhiTw+i8ftXaHiQzj+Rsxw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=l0C0JT3oT/MgzwvYAsz0gtfxZlicp1AtmquKHjzskmIZCCyvWpd9lysD1t8U4OAuY
	 3om9jJ21wsATf3DmIDa/Qxdem6fWZg7wSCud6gI45WWm5zqUSZUEIoEdnSpGtpIY6m
	 aiHSPDf04GCGO8CbpQxKOaEgeod/bI9hs96W2TsreWJeTjmBZONHTNZo2Nme7Fke+l
	 ErspdGFkLbIEm9hHzJ8nr90isj22PUbIixadjLKlf1k2I7Q6gZpmD1vegL5098Ha8t
	 siZeDDUh50OwMR8MwHfUdVCskehwspAvoA/FI01O6RbwnyxMLHGcv2cGX5Vy3RUjuS
	 mCBcBdz8cGvwQ==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70662dfc495so6467742b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719498252; x=1720103052;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uroOoCAtfmxQT5deF8n+fhiTw+i8ftXaHiQzj+Rsxw=;
        b=pzBmFOX30gEwgSfFidLr6+QEKJSglPkF0r660jbcQPgNz6uX6TEMtoJEujWBhVjp+e
         ayqRVYCr5xUmcQsjzYbEqsTY0q8uD5bTpnetzHhw6izUhBL87ua//x6aeKQbmhOIHVRe
         WcF+crMpst0HEfatGhC3sNC/07F0IFmhfy15aa/WTCdKhbZnake/uE/RhDoKd1zlhDX7
         0Kd1AABWUQsEmt0EgceeLftgMLK9/j80zl1VS0bu0uuNGNjVg8zG+oH5Fi98NLB6TZl7
         myXKSRZEL3bXd0ZIadpylMxZAuXx+K8ZHG6lhiDKfxKuDxlOwPDzHAaHoSIRDx+TaTlX
         0a4g==
X-Forwarded-Encrypted: i=1; AJvYcCUbQf/t5gU9cxWxEtE2G6+5o3wcn0aCZvNmpy79nXaNziEp1YJvmm7PdS/uiAorXC/7ivAWRDxuFCK2t63XkbHMIQeBVUbk
X-Gm-Message-State: AOJu0Yw3w+76W3jlPuIfyawcdBWdoKbnazt7VpE/MzheFyBWJWdWbWnc
	eoq+Iv8D+XcTXgkugo/2StVnbJ+ul4ErfgLwmz3AH8YFPgZ0631bHnJrdsqbQuxxSydnfAFhRO5
	dygpuBrFqNTLGSk9OhsOFafFikxie92xd3erHq5exebPg10muPy0yz3/AVSg7eiDUnLxyuw==
X-Received: by 2002:aa7:9285:0:b0:704:209a:c59e with SMTP id d2e1a72fcca58-706745bc082mr12588828b3a.9.1719498252248;
        Thu, 27 Jun 2024 07:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiOyFsOOGRx9u+Kxb7M4p420zayOOdglD3iODiKtAPknXQ+j56nQL0TLrXYusjuYudwha5jQ==
X-Received: by 2002:aa7:9285:0:b0:704:209a:c59e with SMTP id d2e1a72fcca58-706745bc082mr12588791b3a.9.1719498251644;
        Thu, 27 Jun 2024 07:24:11 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b48ca829sm1405228b3a.43.2024.06.27.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:24:11 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id CC1139FC98; Thu, 27 Jun 2024 07:24:10 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id CB2BC9FC97;
	Thu, 27 Jun 2024 07:24:10 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Nikolay Aleksandrov <razor@blackwall.org>,
    Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
    Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
In-reply-to: <Zn1mXRRINDQDrIKw@Laptop-X1>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org> <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 27 Jun 2024 21:17:17 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1467747.1719498250.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jun 2024 07:24:10 -0700
Message-ID: <1467748.1719498250@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Jun 27, 2024 at 01:33:10PM +0300, Nikolay Aleksandrov wrote:
>> > Yes, but at least the admin could get the latest state. With the foll=
owing
>> > code the admin may not get the latest update if lock rtnl failed.
>> > =

>> >         if (should_notify_rtnl && rtnl_trylock()) {
>> >                 bond_slave_lacp_notify(bond);
>> >                 rtnl_unlock();
>> > 	}
>> > =

>> Well, you mentioned administrators want to see the state changes, pleas=
e
>> better clarify the exact end goal. Note that technically may even not b=
e
>> the last state as the state change itself happens in parallel (differen=
t
>> locks) and any update could be delayed depending on rtnl availability
>> and workqueue re-scheduling. But sure, they will get some update at som=
e point. :)
>
>Ah.. Yes, that's a sad fact :(

	There are basically two paths that will change the LACP state
that's passed up via netlink (the aggregator ID, and actor and partner
oper port states): bond_3ad_state_machine_handler(), or incoming
LACPDUs, which call into ad_rx_machine().  Administrative changes to the
bond will do it too, like adding or removing interfaces, but those
originate in user space and aren't happening asynchronously.

	If you want (almost) absolute reliability in communicating every
state change for the state machine and LACPDU processing, I think you'd
have to (a) create an object with the changed state, (b) queue it
somewhere, then (c) call a workqueue event to process that queue out of
line.

>> It all depends on what are the requirements.
>> =

>> An uglier but lockless alternative would be to poll the slave's sysfs o=
per state,
>> that doesn't require any locks and would be up-to-date.
>
>Hmm, that's a workaround, but the admin need to poll the state frequently=
 as
>they don't know when the state will change.
>
>Hi Jay, are you OK to add this sysfs in bonding?

	I think what Nik is proposing is for your userspace to poll the
/sys/class/net/${DEV}/operstate.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

