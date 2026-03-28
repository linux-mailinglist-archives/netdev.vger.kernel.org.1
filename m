Return-Path: <netdev+bounces-272730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAawE/5yx2mmXgUAu9opvQ
	(envelope-from <netdev+bounces-272730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:19:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D634D7E2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8150302A180
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BEA30E0C0;
	Sat, 28 Mar 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="gglZyXOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621C22D7B5
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774678778; cv=none; b=PbCGoN+11H+69dFemy3GEVKgYWbHWcRTveMkj8veAqa9J11C8b1Tpl9zjFnI8XrsGjOcBXA67Hk8aOey3/ZgIQG521TDu435Z/nHpvN4KbcJ9y2pWMXdMtiIIokYG0nIiCH7o0kb7RabqgtU7m5D+NrHYjoSecvtRizfaax0/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774678778; c=relaxed/simple;
	bh=WU2xZt3YCmje/kJ14AXJ+weAoZGqbyywvIn3eOH58VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmGEX9nPDJq7Qs0pY5kCjgUdVHBlxt+7tOTt5obTNlmk9LOppE+714098mmCqlJNbeegubExy6XINSxC/Cy4Bq7NNGmaH5s9cZeelK98v78WPMwd4KlycOt7oupiIoZawFSYD9WOH/z/na7PkLJPsiy47u0+5ON5d7naVm2FrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=gglZyXOm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c175635a33so1982347eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774678776; x=1775283576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygBNExZBLlphU7WjlAjN1m9FBWe2QMN06zkttNgKTcY=;
        b=gglZyXOmNwrIPo3QgBgp0qsPH2ZRnrdnGp8O8Lm20YdFRJDiEPC6R7fVEs9k5R2u1v
         /owZb7V633jKFATmKDIpQTQL1cgqXovFWaiVnU/by1yunhUxjkZlowKUwafHQW4ksY5e
         7/XElrQiazze8UMl0EQSKQ+e5DOkgTRyDtyEU4tmCYdCv1AsOryyGTyjcqNij5PQJnx7
         b2vuZDYPM2Na1oij05f/2coZn0u++Rwi/Akp0ml9R+2iL6LmcXdK15NBLQElhEG+vZtt
         hgrIMkA++B30GQgw4Rx6a8qPPIMMa5UFO3L00DrDQPIPCbENaawYQx6foDZK8ib4hQK9
         l/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774678776; x=1775283576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygBNExZBLlphU7WjlAjN1m9FBWe2QMN06zkttNgKTcY=;
        b=JslTSLFGurtcBQPmJf2mFO6sAz80IAdWAZAOCu9wH+wckNJ7A/oThswtxqaA6yYv7V
         90oudp2TTVDG5w3NhcJbLjSart6ws2BHCzRAicpd5JZU+vJde+9u+lHWORbwv7IcsiNc
         zH0kvdkoBH5iOyjcdM6erSycJtGSYHfTYuD0zJZmr5h1KoA6hiodoxSsVs4Ucngx/XZ2
         tpCNIBuetW/JwPW4vLcy52f/eYtz/bP91WOf64/uVl1632hIy3F/emPauMo50OpakXpb
         aJ/2m3oxFa3h2iUOwSmWbf3g8Ar/XegoioGtBPeJwyAdmqTl83CBylrIxT/9NG8JayiB
         It/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhJEWGz7C6nenPrffgmR18k9CcE3QSdMZyXmzO2Eg7F/mJ9n2lTqfvcSRATUsF7PDe5K8hB4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8HwXJfUqig2nidAxZAEI8xwFBtJH3WvL/KA16c6KfsaKPyqG
	SH0ZR7buc/LMeI3XW/n0tbClOCDD0S6RauZvGb1EJiIEG+gsxb6WwLa9eoheBqJEbg==
X-Gm-Gg: ATEYQzwdY2vNq0Muo0Gajzn57I/a4D83FTlTvUJ1v5F6ehLpg7ojMX87tYDOWhFj4Ax
	FF7LAcWZJYpkffP8mjfu5e4KnHMZXiYRbdxzMFRcT5rdxq90uL+OcyzVjuhPFAabOQeaSxlhdCl
	BxpcWOoQU7ZGlhW1DUAPJi0BmdLwsKcQdqhybOmD5651gNLDH0vZP6AB/1NTsLFiVZTE7YaaP+N
	AXhzQBVSeTSeSZpp5We2cYReOYcY/uSTZNqN0K94xiNuqQwHp1IbT3YY/DxPAutH9hA34wFEC71
	SL+jCRUglWcdJk4ih6oUrslOGsjw4DdG/4b83MAKl6Ox24FtO3F4uo4nlv9Xtnua55uhFzF2ST9
	RVteYKvxaxHxaUFmsP5uLn0kFoiNCaIaAdUaSXLUERvDwzlpH5quU81gpp0U2a9o+NH1Fhnn0ae
	TeHUSaYO/qUg6BTF4ricpzU6BXXWkLkA==
X-Received: by 2002:a05:693c:3005:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2c185f3905emr2941453eec.27.1774678776219;
        Fri, 27 Mar 2026 23:19:36 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9d38fsm1791956eec.23.2026.03.27.23.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:19:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:19:34 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272730-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email]
X-Rspamd-Queue-Id: B93D634D7E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
> On 27/03/2026 13:34, Simon Horman wrote:
> > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > > interval value from netlink without validation. When interval is 0,
> > > usecs_to_jiffies(0) yields 0, causing the delayed work
> > > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > > itself with zero delay. This creates a tight loop on system_percpu_wq
> > > that allocates and transmits MRP test frames at maximum rate, exhausting
> > > all system memory and causing a kernel panic via OOM deadlock.
> > 
> > I would suspect the primary outcome of this problem is high CPU consumption
> > rather than memory exhaustion. Is there a reason to expect that
> > the transmitted fames can't be consumed as fast as they are created?
> > 
> 
> +1
> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> conditions. This is a configuration error and OOM doesn't lead to panic unless
> instructed to. I don't think this is worth changing at all.

Thanks for your review. This path is reachable from an unprivileged user
namespace. The capability check goes through rtnetlink_rcv_msg() -> 
netlink_net_capable() -> netlink_ns_capable(), which checks 
CAP_NET_ADMIN against the network namespace's user_ns, not init_user_ns.
An unprivileged user can create a user+net namespace, get CAP_NET_ADMIN
within it, set up a bridge with MRP, and trigger the zero-interval loop.
This is not a privileged misconfiguration scenario.

Also, the PoC can crash a kernel without "oops=panic" with this bug.

> 
> > > 
> > > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > > for interconnect test frames.
> > > 
> > > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > > netlink attribute parsing layer before the value ever reaches the
> > > workqueue scheduling code. This is consistent with how other bridge
> > > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > > attributes.
> > > 
> > > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> > 
> > I think you also want
> > 
> > Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> > 
> > As highlighted by AI review.
> > 
> > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > 
> > ...
> 

