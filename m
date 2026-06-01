Return-Path: <netdev+bounces-293775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHpuFqKLHWr5bgkAu9opvQ
	(envelope-from <netdev+bounces-293775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:39:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5E6202C4
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDCA830BC7C8
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73053A6B8F;
	Mon,  1 Jun 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu0u6XJw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTNv+sHr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56E3A4508
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320933; cv=none; b=uGyrtWIPlgZsaNwqovV8HhzCZuwx/SNACH109Dl2OHAV+/+HxX5zmLSSSgZ1dsWoaTAZuq0cZq2wXzawQHcx2QVSTCxtddxVmqmNOncW1sPnAVc3EV4Loy67xmgimFmeoIK5MptI5+MaX/mYUdUHUbpC7JYBl71uS9/eawnplrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320933; c=relaxed/simple;
	bh=lp/ptwOz8oBpXlR0XAK87MgxzNA2RgBiY99KrvD5giU=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=Nbhz5DfTd7Zqig/sUR8nz3ijXQD/7CtG3EXbzT/6ZqfcRBEuYjlp0ltyOIcfR6P3nXXTTfwjPVvgFpWx36rjyc1Y+msbHeYlkoi8yTBS1grzGt9WcowYVdD3JABFisHCWMQkns46Lr78GP5rwWdUpNUaXS4K/pazv/Z23zhOnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gu0u6XJw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTNv+sHr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780320931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nW2y5EELGA92Nmgu/h+V2tbcAAK8XuFhP0KJ13qmAlI=;
	b=gu0u6XJwmb+oDU22UFyatDx0cxlvsUS0LVVNP4YXbXhCIKmACk47lRxRUDGLvOTGkwWUoZ
	+yfAS1lkmastivX1L7qB6JWSb2D5eObar6Z/6VdojUd/zhu/kHeLq6X2E4fGFZ110fTA15
	t7vCa6qyiUdEaxXih9EMmUiXpkPNxrg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-dXPitmSKPC2T42GbHpRUgw-1; Mon, 01 Jun 2026 09:35:30 -0400
X-MC-Unique: dXPitmSKPC2T42GbHpRUgw-1
X-Mimecast-MFC-AGG-ID: dXPitmSKPC2T42GbHpRUgw_1780320929
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef55779d1so1587916f8f.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780320929; x=1780925729; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW2y5EELGA92Nmgu/h+V2tbcAAK8XuFhP0KJ13qmAlI=;
        b=RTNv+sHrjaCwXPOBU0UiQgucdG4Vvgb998iMLRjl2BuxkXbLWMtvhJMc93ZiXlTN01
         9VfA4ogsXHL/2LxEhh/AsJ6gO9AQLgcy2b2cVgnoTamTGm4aqY9unse14S0Ka3TW5oQ3
         TtabZpNcP24MycRDOGzJweGKB4XBYbLMqiPYRTHRo8FULRa506+Ww8tSfbEn8BuIjU+2
         /YMWb96X5gh5O15g5jLChdQMGiF/P+Gee5fDKGc1oAVTeuF44XbI/KOvCCi9GgNuGpzT
         XIw1S0v06ecN5NCpGs/J6zoKniqz4F8d3TRDhnZqDsMI2TkAMD/YbPRK6AunOLv/Pz9W
         vkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320929; x=1780925729;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nW2y5EELGA92Nmgu/h+V2tbcAAK8XuFhP0KJ13qmAlI=;
        b=KaoYKPrbKIpbRDvA/ZpCQ72xhD9xFA1DubcCt9M5WVnDBWNE2aafTUYsODasEt33tA
         5OCBJ5ti5opjj3KkQR19ZiAepdgC7HRI1YQWQjAYzbzjHLZt+M/VckE0GD2QYKDPxBgo
         J8zQXvsTIQ56I3oOax6wi1Z7m/M1ZC+ADNkYsP/iPlYI1ihAGnwnDtNgmLdsPPMGVxhq
         3b1oFiA6+XV8JS48ZM8idwym6kxzlxjHQp+xzzkGj9a5zRnEPYu8OqdsoUPRqCYFwbjX
         KFmgOxXrsBT1bsuTjCQVajdn5dcjqQH3XR7daAsk8w4lOn/3wcnzWh8ddggErdwsWnIE
         0s+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ElW13Zvi39yBHpN4leTSE6SD3qeb6gLNh+LN8pZ6Fb6UzxXYcn8VDOGwuEDr9HnBg5EfVOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvEk8SldBARviSgn+TYtEQjMOx5GfRlNwZD4nj6rrfK3oTzOU
	HRKPstVu0Z9/0/GfCh/XrnRTndTfnvnjhMCHXjiiwGieWjfbjcgz/NQCLmRCZdLseVaaLIU/Bx9
	wWgzhBpNQxmq087HnXn1ta4yM758a4j6FaHxm7aekDBnm2cfscSVHR3WdKw==
X-Gm-Gg: Acq92OHFmCr6suzRBqB7H52YQs4zkDYlA6KP8pQ87mXC+IBsNdWsdEoAHM7d7bEUrrA
	4YgFq2eZ2mzFXF4jxXW0tWcWZbzpPaNO9d4p4oBxbIILSKC+L5vpo6q1mGqXFonh8bR5x4Lxn3v
	23nDIzHHfeDo+IhquqT9UrWcGkk4BQIYo3/3KEgrRDsCzsF3fmTZ3Vb5Pma3FRTwJ6WGBx9KbMV
	tI9yaedR/LRMK7sVDjB7NA775pJPr6tSsqCBrsllDD5DRB+DzuYnMaD++3Lghei5037Qd1YuMop
	hnYHIK32i4J520DVbZK04e5sBeHhsgesrhTjOQDafXEIJPS1PhWHRQ/kzN8ii3tJ7dPO6+TLuWz
	tIz8KlREs0RE8ppVbV/0cp8Cb455YpatYPQzDWGl86NDxdX8TTWAQyJhrARtG
X-Received: by 2002:adf:fad1:0:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-45ef6b6b608mr14976906f8f.20.1780320928615;
        Mon, 01 Jun 2026 06:35:28 -0700 (PDT)
X-Received: by 2002:adf:fad1:0:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-45ef6b6b608mr14976832f8f.20.1780320927919;
        Mon, 01 Jun 2026 06:35:27 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a090dsm24806726f8f.3.2026.06.01.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:35:27 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org, Chris Adams
 <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>, Beniamino
 Galvani <bgalvani@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>,
 ihuguet@redhat.com, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <20260601153525.546746a8@elisabeth>
In-Reply-To: <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
References: <20260529112357.5079-1-fmancera@suse.de>
	<20260529134045.56330243@elisabeth>
	<5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Jun 2026 15:35:26 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,passt.top:url]
X-Rspamd-Queue-Id: A4C5E6202C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 12:03:59 +1000
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Stefano,
> 
> On 29/05/2026 21:41, Stefano Brivio wrote:
> > On Fri, 29 May 2026 13:23:57 +0200
> > Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> >   
> >> Chris Adams reported that preserving insertion order for same-scope
> >> addresses is causing SSH connections to be dropped after stopping a VM
> >> while running NetworkManager.
> >>
> >> NetworkManager caches the IPv6 address configuration, when a RA arrives,
> >> it determines the list of addresses to configure and checks if the
> >> addresses are already in the right order in the kernel. If they aren't,
> >> NetworkManager removes and re-adds them to achieve the desired order.
> >>
> >> As the order changes, NetworkManager is confused and reconfigures the
> >> addresses on every update. In addition, this would also affect to cloud
> >> tooling that relies on IPv6 addresses order to identify primary and
> >> secondaries addresses.  
> > 
> > By the way, I'm still looking into this part, trying to find
> > "problematic" examples.
> > 
> > And I couldn't find any, yet, because it looks like there's always a
> > _single_ IPv6 address being used as a secondary for a primary IPv4
> > address.  
> 
> FYI, the order change also affected some specific scripts, e.g. here
> with MPTCP and packetdrill:
> 
>   https://github.com/multipath-tcp/packetdrill/commit/1b7cd4482ce8
> 
> Because the order was not "natural" before, and different from IPv4, a
> workaround was needed to keep the same order. I was happy to remove it,
> but now it looks like I need to re-apply it :)

Ouch. :) We were are also pondering about some kind of workaround like
that (https://bugs.passt.top/show_bug.cgi?id=175#c9) but fixing the
kernel looked simpler and the right thing to do... until last week.

> It would be nice to get the "natural" order back without breaking the
> userspace (or with a way to choose the order).

I was thinking that if we implement a label like NLM_F_INSERT_LAST
(David's proposal for the name), we could patch iproute2 to set it on
'ip address restore' at least, other than using it in pasta(1).

But that wouldn't be enough for your case. At the same time always
adding it for RTM_NEWADDR requests in iproute2 could break somebody
else's scripts. I guess a reasonable solution could be to add an
additional parameter for ip-address... 'insert_last'? 'last'?

-- 
Stefano


