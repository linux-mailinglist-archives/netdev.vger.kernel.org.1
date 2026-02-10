Return-Path: <netdev+bounces-258086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFGCOtwwi2kFRgAAu9opvQ
	(envelope-from <netdev+bounces-258086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:21:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFA11B2D4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2650F3039306
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288F328B4D;
	Tue, 10 Feb 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQAFei3i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92F3EBF28
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729688; cv=none; b=aEsRx9NIJA5tPsCnMCDyiM+J0Ak9gWHamoBxgZnoZc9DQx5c+cGy4Oyosln9BUMJLz3JWksfiglSWaRM6AJpU0nxDuNo5lAPnQ2t34/LsLSDhKwah41qjYy7bq3dcEWWapPzce/Ru8D6sz6xvMqHF9ah+nEowBmxiUwJJPGE+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729688; c=relaxed/simple;
	bh=49wWjv80CmOxR9Z6lX1l4jznsqX8vyDBV8vw6cdn++0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ/HwOcoxCVMP0aqQAsNjUe+KDJKAoGHwxwdkrBUbUo52lv/GKjAfZVDXz9YZQEloQOD5Qqq7DmuEiAQxQkd41Y11Haa88WIXpiDehbfl+S69frM9tVaaGT+4r1+uio/VMzRGmN/AHqXqwyAbzAaczt3lFd4oIyUjFAWxlNDuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQAFei3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0CAC116C6;
	Tue, 10 Feb 2026 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770729688;
	bh=49wWjv80CmOxR9Z6lX1l4jznsqX8vyDBV8vw6cdn++0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQAFei3i93fgG0Xae0tgFo9nBmHb8HJebSzo+2dtdvTDbyDo6uUoekbSK4bCuHKZj
	 BsI/4Ofr5zNsftESCYHk/NhCszQZBr7RD/KtdwrzBDjw816cIEkbiSRABXzKSn5Wvw
	 94OXfif+nsb8jHvVWBzBNT/CsJIK9aFLlHxSAzQE=
Date: Tue, 10 Feb 2026 14:21:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	Hirokazu MORIKAWA <morikw2@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in
 __ip6_tnl_rcv()
Message-ID: <2026021011-imperfect-shrewdly-315f@gregkh>
References: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com>
 <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
 <DGBAG46Q9YLJ.PX4A4EM1U4DF@suse.com>
 <CANn89iL5ksZZCJr7SK9=4Sw6EejdOzr5_m6pBMM8RVtbLy_ACA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL5ksZZCJr7SK9=4Sw6EejdOzr5_m6pBMM8RVtbLy_ACA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258086-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,suse.de,davemloft.net,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,l2_tos_ttl_inherit.sh:url,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64DFA11B2D4
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:56:14PM +0100, Eric Dumazet wrote:
> On Tue, Feb 10, 2026 at 1:42 PM Ricardo B. Marlière <rbm@suse.com> wrote:
> >
> > On Fri Jan 30, 2026 at 9:00 AM -03, Eric Dumazet wrote:
> > > On Fri, Jan 30, 2026 at 5:15 AM Hirokazu MORIKAWA <morikw2@gmail.com> wrote:
> > >>
> > >> [REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
> > >> commit df5ffde96693
> > >>
> > >> Hi,
> > >> I am reporting a regression in the IPv6 tunneling stack (MAP-E and
> > >> DS-Lite) introduced in kernel 6.12.67.
> > >>
> > >> [Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
> > >> the OpenWrt snapshot, IPv4 packets can no longer be sent to the
> > >> external network via MAP-E or DS-Lite interfaces.
> > >> [Environment]
> > >> * Hardware: FriendlyElec NanoPi R6C
> > >> * OS: OpenWrt snapshot
> > >> * Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
> > >> * Protocol: MAP-E and DS-Lite
> > >> [Culprit] By bisecting/reverting individual commits, I have identified
> > >> that the following commit is responsible for this issue:
> > >> "ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
> > >> the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-edumazet@google.com/)
> > >> Reverting this specific commit on top of kernel 6.12.67 restores
> > >> normal connectivity for both MAP-E and DS-Lite.
> > >> [Steps to reproduce]
> > >> 1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
> > >> 2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
> > >> 3. The packets fail to reach the destination.
> > >
> > > Thanks for the report.
> > >
> > > Can you provide detailed instructions ?
> > >
> > > Apparently none of our selftests caught the issue, it would be great to add one.
> >
> > Perhaps l2_tos_ttl_inherit.sh [1]? I've seen a timeout in this test that
> > went away after testing commit 9990ddf47d41 ("net: tunnel: make
> > skb_vlan_inet_prepare() return drop reasons") like mentioned here:
> >
> > https://lore.kernel.org/netdev/DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com/
> >
> > It seems that that commit 81c734dae203 ("ip6_tunnel: use
> > skb_vlan_inet_prepare() in __ip6_tnl_rcv()") uses the new
> > skb_vlan_inet_prepare added in v6.13, which broke 6.12.
> 
> Greg Kroah-Hartman backported my patch to 6.12 LTS, but forgot that a
> prior patch
> from Menglong Dong inverted the skb_vlan_inet_prepare() return code.
> 
> Greg, can you backport the following to 6.12 LTS ?
> 
> Thanks.
> 
> commit 9990ddf47d4168088e2246c3d418bf526e40830d
> Author: Menglong Dong <menglong8.dong@gmail.com>
> Date:   Wed Oct 9 10:28:21 2024 +0800
> 
>     net: tunnel: make skb_vlan_inet_prepare() return drop reasons
> 
>     Make skb_vlan_inet_prepare return the skb drop reasons, which is just
>     what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
>     it.
> 
>     Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>     Reviewed-by: Simon Horman <horms@kernel.org>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Sure, will do after this next round of releases goes out.

greg k-h

