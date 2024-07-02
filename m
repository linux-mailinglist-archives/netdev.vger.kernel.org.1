Return-Path: <netdev+bounces-108353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76791F0A8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5BC1C21519
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238212FF7B;
	Tue,  2 Jul 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsWIANMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0514B960
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907209; cv=none; b=oISa5+HaGyI2c/Xnlznx/oXBLQQ8YkGLPxGZfS9kh6UdgCUJ1iU7Kpedxp4Sh01NnXorWu+lbocRfweF3cnE+Unti/yOrCwyaeSWOGpesRWpGLrAxFs/PZIZIwRiAo0Hwt2umE0DTBGlCvOWbwVWEM7T8IgYXcrEPTJ8oR0jPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907209; c=relaxed/simple;
	bh=QnCjHQ3v3sFYVBr6IgVTx2rcuQYAqv7bx05CjStLZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3chvTX4u04EWF/Nu53tYvWKTm42R5e2g0wW+AqtvCP/BDxIaeXa23oy2eiCg54onjkMJjDlHsLP9M3Nh1aZlngogjoNGN55zt7YAF3iPqMmOFNvBS3E5EnwfN/U8FSElzfPeyfLTN4S4kp6MWeYXZEbg/b36XfnNcmNqDi9ciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsWIANMa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a5344ec7so27714005ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719907207; x=1720512007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y61zEMQUsNIc5tU+r3K6Kzv7ri/HytQMZQPZSk2Szoo=;
        b=HsWIANMa2opibCHEoXyQkWzl30q3e6GXwtjLmSgikqgG9stgmop6ayFCFBETKBNUDB
         oE5D7PKWBdn9Pzf5rn/bYaAoVd0HvQjWU0aOCy8nMfCwPrJbjv2K9na89p/WNt92gbIF
         WQTw3E5t99U6Zqf4iVscaWgjR1n1nytVrIYK0UC+g6CsnOVTKaidkuOh3ULGK+xJt5zn
         U52QPKXRSTOziYevD/A1dLG1P9o0pX/rvlUhA5g4novnAtZg8T+eAvHxMRQ/HfXrb+NY
         5f24Zno2+DOyiKM6IT6j9fM5i4zXnUHvBPj1LotlV7quiU/Mznw4tLP6pvetEtYTSBkH
         HOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719907207; x=1720512007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y61zEMQUsNIc5tU+r3K6Kzv7ri/HytQMZQPZSk2Szoo=;
        b=FsIYaf0CtdqFBiv57CIG3WTRSy8gZbrqwfdLNqe2meLgdWHg/Cw141KEa4yVDYfnoy
         n6TIh9USsKIiU6s8RIXYGY4mnIWvjl7XTZZSVgJ97qzsUJ4vIGO4+/7wo/Z8enLOvCOH
         wTj25Ztc3QqW1LZfCcuufbV3qP9aO9GeKYXLzkBsUw0kS0HGTXX99L9lHb6O0AOB6BFN
         t45ia0IGqsd1PCq3e1WD+Ebjihxq6e4mMqnbamgImfQmuYEeQegdSiiuDdGc7WimGdVb
         UaE/4F5JcBqT+2QwVteVdirHwZSqZyrAOgn9guorqq2sF4anf/AGq9x8CvkpKz/b+tiK
         nFmg==
X-Forwarded-Encrypted: i=1; AJvYcCWScvX9Qq+CoG/2ubnrR3XH3xcrOWxWl2pgjcfNMxglJFxKObegQEmhUZrhs6ei1pGHfEpD7kmE01GXNEPJdEBVVFx1YzCt
X-Gm-Message-State: AOJu0YxkjlDK2sUB0lIKU/AQ9CD28lOx8eaTtTXK8RFt5lQHNM6T16Op
	Mt9pxYRYSeQYyWbd8sKWdEYYUC/eepL//0wISb/Nw/yJr6C9bHA0
X-Google-Smtp-Source: AGHT+IGxv1WkyUQ0016TLgHlGViplzIU+qB63dX4YUSumwDR7VQiBV5+Vpw2eNOrdYnEyHeRyXdv/Q==
X-Received: by 2002:a17:902:f688:b0:1f9:f6e6:5ada with SMTP id d9443c01a7336-1fac7eec818mr184307585ad.22.1719907206617;
        Tue, 02 Jul 2024 01:00:06 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:62b0:7aad:184a:7969:1422])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569606sm77480425ad.222.2024.07.02.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:00:06 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:00:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <ZoOzge5Xn42QtG91@Laptop-X1>
References: <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
 <Zn6Ily5OnRnQvcNo@Laptop-X1>
 <1518279.1719617777@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518279.1719617777@famine>

On Fri, Jun 28, 2024 at 04:36:17PM -0700, Jay Vosburgh wrote:
> >Good question. The monitor application want a more elegant/general way
> >to deal with the LACP state and do other network reconfigurations.
> >Here is the requirement I got from customer.
> >
> >1) As a server administrator, I want ip monitor to show state change events
> >   related to LACP bonds so that I can react quickly to network reconfigurations.
> >2) As a network monitoring application developer, I want my application to be
> >   notified about LACP bond operational state changes without having to
> >   poll /proc/net/bonding/<bond> and parse its output so that it can trigger
> >   predefined failover remediation policies.
> >3) As a server administrator, I want my LACP bond monitoring application to
> >   receive a Netlink-based notification whenever the number of member
> >   interfaces is reduced so that the operations support system can provision
> >   a member interface replacement.
> 
> 	What notifications are they not getting that they want?  Or is
> it that events happen but lack some information they want?

Yes, e.g. when the switch crashed while link still up, they can get notified
from LACP partner state if we send the info via netlink message.

> 
> 	Currently, the end of bond_3ad_state_machine_handler() will send
> notifications via bond_slave_state_notify() if the state of any member
> of the bond has changed (via the struct slave.should_notify field).
> 
> 	The notifications here come from bond_lower_state_changed(),
> which propagates link up/down and tx_enabled (active-ness), but not any
> LACP specifics.  These are sent as NETDEV_CHANGELOWERSTATE events, which
> rtnetlink_event() handles, so they should be visible to ip monitor.

That's the problem. It only propagates link info via link up/down. The link
info is not send if only LACP state changed.

> 
> >What I understand is the user/admin need to know the latest stable state so
> >they can do some other network configuration based on the status. Losing
> >a middle state notification during fast changes is acceptable.
> 
> 	This is a much simpler problem to solve.

Good.

> 
> >> Well, you mentioned administrators want to see the state changes, please
> >> better clarify the exact end goal. Note that technically may even not be
> >> the last state as the state change itself happens in parallel (different
> >> locks) and any update could be delayed depending on rtnl availability
> >> and workqueue re-scheduling. But sure, they will get some update at some point. :)
> >
> >Would you please help explain why we may not get the latest state? From what
> >I understand:
> >
> >1) State A -> B, queue notify
> >       rtnl_trylock, fail, queue again
> >2) State B -> C, queue notify
> >      rtnl_trylock, success, post current state C
> >3) State C -> D, queue notify
> >      rtnl_trylock, fail, queue again
> >4) State D -> A, queue notify
> >      rtnl_trylock, fail, queue again
> >      rtnl_trylock, fail, queue again
> >      rtnl_trylock, success, post current state A
> >
> >So how could the step 3) state send but step 4) state not send?
> 
> 	I'm going to speculate here that the scenario envisioned would
> be something like CPU A is in the midst of generating an event at the
> end of the state machine, but CPU B could be processing a LACPDU
> simultaneously-ish.  The CPU A event is sent, but the CPU B event is
> delayed due to RTNL contention.  In this scenario, the last event seen
> in user space is CPU A, but the actual state has moved on to that set by
> CPU B, whose notification will be received eventually.

Is is possible that LACP event (The second to last state) in CPU A is delayed
due to RTNL contention. While the LACP event (the latest state) in CPU B is
sent successfully. And later the LACP event in CPU A is sent eventually.

This would case the user space receives miss order message.

> 	Looking at the current notifications in bonding, I wonder if it
> would be sufficient to add the desired information to what
> bond_lower_state_changed() sends, rather than trying to shoehorn in
> another rtnl_trylock() gizmo.

I'm not sure if the LACP state count for lower state. What do you think of
my previous draft patch[1] that replied to you.

[1] https://lore.kernel.org/netdev/Zn0iI3SPdRkmfnS1@Laptop-X1/

Thanks
Hangbin

