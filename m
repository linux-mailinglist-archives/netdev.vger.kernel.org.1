Return-Path: <netdev+bounces-292029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLykKa5DFmpskAcAu9opvQ
	(envelope-from <netdev+bounces-292029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:06:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0075DE255
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 264553016CE6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B072BFC85;
	Wed, 27 May 2026 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b="fFvObx1G"
X-Original-To: netdev@vger.kernel.org
Received: from linode.cmadams.net (linode.cmadams.net [45.33.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EA481DD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.75.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844011; cv=none; b=JG8bxNxA4oSuUWEmr+EvMFoy9gpOcbkMpLw3V8DwE19EPZK+cYeAAnhrnyMpW+Hwiq/vusc3vGfx1u/7OVZ7j8X3+mLr85aM6AzLv4emxFujBb61mQGHyvS4nMnxfGK6E2sI1eWM3jtXt2pG5zY0CzdaZrWm+0nTKb7uUMDDqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844011; c=relaxed/simple;
	bh=KyxsvcvzdNx873OhojVRbcb3NwWg6a+vZs0vFW1hi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6hlIyiU7QH4JdXCF4kuktQpIdbQz855CWq2JJvQvB44F8UjX/3qkU8c39Rj/lEDu5e4rcHYuX8/tQRumdPXQE2xaqUE4t9k0q+rijkl8wDiQWKYKxPdE99KbSowtVWs0U0dWgkoDv4HBTGvCenjv3qn1xyMAC4DoAk8qiADffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net; spf=pass smtp.mailfrom=cmadams.net; dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b=fFvObx1G; arc=none smtp.client-ip=45.33.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmadams.net
Received: from localhost (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gQBKH3Dn4z6tTF;
	Tue, 26 May 2026 20:06:43 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cmadams.net; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received; s=20220404; t=
	1779844002; x=1780708003; bh=KyxsvcvzdNx873OhojVRbcb3NwWg6a+vZs0
	vFW1hi5A=; b=fFvObx1GMbXC5FZYAnJ22CMbZzkoX5NStz3hib6ycob205vgbPx
	wVQdd5WMrdDn823rhjQwMKz3f54YV1uJ5L9R8TtRvDQgwOZMkLa0dfpCzMnQVv14
	e4qxuaQkV+Ri0efVjFCmaahEarnPqEwfc7iFj8ODihvRYAUB3jHuiakECqu2+KJu
	xnhXZ3pXIeCi/LH502Tje376QAPzozSwx1vsJdxKEv4lfB2W/SRl2ivI8wcK4W1l
	zfNI7dkRRfStlZiHxlzkVnWQGX5OuVMJvvhTNPVm/VMufEknfoFpfconLtY7sy3X
	Q8TOV/o4+QSo4uzZUw6Q8yHMzAxAl19+Rew==
X-Virus-Scanned: amavisd-new at cmadams.net
Received: from linode.cmadams.net ([127.0.0.1])
 by localhost (linode.cmadams.net [127.0.0.1]) (amavisd-new, port 10031)
 with ESMTP id Y8j2iB8y7Y48; Tue, 26 May 2026 20:06:42 -0500 (CDT)
Received: from cmadams.net (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gQBKG0CBhz6sw9;
	Tue, 26 May 2026 20:06:41 -0500 (CDT)
Date: Tue, 26 May 2026 20:06:41 -0500
From: Chris Adams <linux@cmadams.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ido Schimmel <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260527010641.GA21073@cmadams.net>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Ido Schimmel <idosch@idosch.org>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526175743.1f2c3761@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmadams.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cmadams.net:s=20220404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmadams.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@cmadams.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cmadams.net:email,cmadams.net:mid,cmadams.net:dkim]
X-Rspamd-Queue-Id: 4C0075DE255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Heh, I opened a Fedora BZ on this and JUST updated it... RHBZ 2480928

Once upon a time, Jakub Kicinski <kuba@kernel.org> said:
> On Thu, 21 May 2026 08:53:10 -0500 Chris Adams wrote:
> > My normal use of my desktop system (Fedora 43) is to suspend at night
> > and wake in the morning, and then immediately SSH to my remote server,
> > where I stay logged in.  I use NetworkManager and have ipv6.ip6-privacy
> > set to prefer-temp-addr, and SSH configured to use SSH keepalives.
> > 
> > When I upgraded to kernel 7.0, I started having an issue with this - my
> > SSH session gets dropped, usually several times, in the first hour or
> > so, then I usually don't have any problem the rest of the day.  If I run
> > an IPv4 session at the same time, that seems to be fine, so I don't
> > think it's a network issue (I know that dual-stack doesn't always take
> > the same path).
> > 
> > What seems to be happening is that privacy addresses are removed while
> > the SSH session is still using them, before the timeout even.  I wrote a
> > script to watch public v6 addresses being added and removed, and this is
> > what I've seen so far today (the number at the end is the valid_lft
> > seconds), with the public prefix masked:
> > 
> > 2026-05-21 07:39:17 removed xx::f4f/128 4673
> > 2026-05-21 07:39:20 added xx::f4f/128 5400
> > 2026-05-21 07:41:20 removed xx:3e8c:f8ff:fe60:1d5a/64 4922
> > 2026-05-21 07:41:20 removed xx:7cb1:c518:1be0:d81d/64 4922
> > 2026-05-21 07:41:23 added xx:3e8c:f8ff:fe60:1d5a/64 5398
> > 2026-05-21 07:41:23 added xx:596a:f6f5:67b2:1d8f/64 5398
> > 2026-05-21 08:14:43 added xx:fac3:61f6:ad18:d712/64 4987
> > 2026-05-21 08:14:43 removed xx:596a:f6f5:67b2:1d8f/64 4991
> > 2026-05-21 08:30:26 added xx:84b4:244e:bb14:94fd/64 5398
> > 2026-05-21 08:30:26 removed xx:fac3:61f6:ad18:d712/64 5120
> > 
> > I woke the system at 07:39:08 and SSHed at 07:39:39, which used the d81d
> > source address.  That dropped in 2 minutes and I reconnected, which used
> > the 1d8f address.  That dropped at 08:14:43, I didn't notice right away,
> > I reconnected at 08:31:28 which used the 94fd address.
> 
> Hi! Adding more people to CC. Do you know if you upgraded from 6.18 
> or 6.19?

It was 6.19 to 7.0.

> Would you be able to try testing with some commits reverted?
> On a quick look the candidates would be:
> 
> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")

It's this one.

I figured out that it happens after stopping a VM (and I usually
start/stop a VM for a bit in the morning, which is why it happened more
than once).  So I set up a VM with a nested VM, running up-to-date
Fedora 44, and then was able to bisect pretty easily, and it landed on
this commit.

Fedora is using NetworkManager, and IIRC NM does some part of privacy
address management (right?).  NM didn't change, so maybe this commit is
confusing something in NM?

-- 
Chris Adams <linux@cmadams.net>

