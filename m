Return-Path: <netdev+bounces-167809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1643A3C6BB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C051885CCE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5F1FECAE;
	Wed, 19 Feb 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MT2JJQ7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341341AF0D3
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987508; cv=none; b=UUncPfKdCCGhKQd8o1ZCmPq5mhgFM74TPZC1hSc7bSHxFptlYcRVIYViUNBk8t78TR3lysLcK6p5DpVrPpWR06u9L0TkU4IUewqQiODsywtz+r7HL9MnFGavRgq+s17zCckj+05fk2MHngYkCSboo4uknrKw/dtvdxM5IOPMZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987508; c=relaxed/simple;
	bh=lEZz4mHpfslPWLW7341gecKN4IA+iwzXo7iOXEK3WPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5wUKSYaYqFow90SDCs8tkPF/pGliA6S1qbZ/jIYcs9tuiHGAC6Cy860QcUobh2LwlIEcLKte51R60nwEF5lJeo18MVgYNcXgMuB70XLjVLiT6Vqtt41qh+uOphRys91urcCPaQ6ZCc0BTz4crwg4ntRfOZQ4+oHlBQLt1spwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MT2JJQ7O; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0b0ca6742so4138385a.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739987505; x=1740592305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrMRw+Mc/8Jx430eNqd73IrlG76BWV0j9faRomGwI8o=;
        b=MT2JJQ7OAqkgBwNuxZc0Z3jMNfO/8rzN5gED8eX0zURlRJ4crlayz9nacL5bNjA6ED
         z0cwfLy+osFUtwoNjesbEyOZYgmcxk1ei8zYe1tyutbQVdN/oc4bUGe/Yt4KAJSUgWER
         3Sk9WoD3KeO/Y6mBtSnDVP2gqFRMgnGciONlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987505; x=1740592305;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrMRw+Mc/8Jx430eNqd73IrlG76BWV0j9faRomGwI8o=;
        b=an2n0fAMod/kAKj04ZqOKphPcy15/31E8b2SSQj5BojUD9itcbheuSR1/IG6G2GWtm
         oqTY05j2gGMI6LHhvi1QlAkJMgtYyybjLdBajlTxthM6vaRxMqhDKSlmOIfbF10yPnNx
         CSZO1fbUdgGAyo8f1TzAJFnDDrYohGc7EDEAGC5yMdBMNvv+g8kH5R6qhDYXBm3m3PhK
         rX4YvXalZyqaeXX3Cuevl2RWcj8uIwqcw7HrE4xmRuEDLR/VC81aELP9Sh14HwOKgmgV
         TmkoAyl1epCun/TTVw/PbxkN/rJDJt6T31BiZJuBEztFT+SmrVi4GL4Wj8uu1IZzq1IR
         xnpw==
X-Forwarded-Encrypted: i=1; AJvYcCVDAPLlfAdpmjSkwqpGShWLsRpYUTTCEcY+oidGRkOY3+U2694VGFmc0rsvIXpdowGj8qclFPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RRsDiRFlyhJb8jluHXtTyDldoVZoKh7+ehQ6vP8eD6bmVpIo
	V1JyFpeY9/WuOknNasumWHMAtnaYK1fkf2NxgrYLg/H7WOVA4M//lKlh2cdvvJM=
X-Gm-Gg: ASbGncvSPqFsVq3lPIuQnH0fKhAJtzwEE/n2H4xrFzrGDh8aaD9L0PJLgsErMIN+10M
	XrfcymtLgHXsPeDuN15Hwq22an1EMGNORG8jsRtL8RXGbKMymp/CgQf9XEm0crSMghl7PrsrsJd
	rM4QkRJhoX5njunO4Rxmy20kLUPGafOQwFIR9KyBUtKmk3X15jujFEKGsEAxymmgDgFJK1S07LQ
	EdeS3+8XGN7CJ8etq93j5DLv828Nb0WQ3xCYZnrk1tzYgOxaqP1GPpg1wLTUbDLsYRy5Le/gKb0
	biNCP3ksSNdkGwDOo4JvMfdoKXPXkU8lRhKLcTUy7mwGQHf3q+w7Iw==
X-Google-Smtp-Source: AGHT+IHApQu5GuOGRlxUUed1aJja9KJUXPqMCjqow4lDfmqrja11JuARF6fyOdqZ0NDKDqPkBA++Rw==
X-Received: by 2002:a05:620a:414b:b0:7c0:b1aa:ba5a with SMTP id af79cd13be357-7c0b527404amr648255885a.33.1739987504799;
        Wed, 19 Feb 2025 09:51:44 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a439esm77203766d6.67.2025.02.19.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:51:44 -0800 (PST)
Date: Wed, 19 Feb 2025 12:51:42 -0500
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <Z7YaLuho0hXL7Jb1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
 <Z7UDCSckkK7J30oP@LQ3V64L9R2>
 <87jz9mghfr.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz9mghfr.fsf@kurt.kurt.home>

On Wed, Feb 19, 2025 at 03:03:36PM +0100, Kurt Kanzenbach wrote:
> On Tue Feb 18 2025, Joe Damato wrote:
> > On Tue, Feb 18, 2025 at 04:18:19PM -0500, Joe Damato wrote:
> >> On Mon, Feb 17, 2025 at 12:31:20PM +0100, Kurt Kanzenbach wrote:
> >> > This is a follow up for the igb XDP/ZC implementation. The first two 
> >> > patches link the IRQs and queues to NAPI instances. This is required to 
> >> > bring back the XDP/ZC busy polling support. The last patch removes 
> >> > undesired IRQs (injected via igb watchdog) while busy polling with 
> >> > napi_defer_hard_irqs and gro_flush_timeout set.
> >> > 
> >> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> > ---
> >> > Changes in v2:
> >> > - Take RTNL lock in PCI error handlers (Joe)
> >> > - Fix typo in commit message (Gerhard)
> >> > - Use netif_napi_add_config() (Joe)
> >> > - Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de
> >> 
> >> Thanks for sending a v2.
> >> 
> >> My comment from the previous series still stands, which simply that
> >> I have no idea if the maintainers will accept changes using this API
> >> or prefer to wait until Stanislav's work [1] is completed to remove
> >> the RTNL requirement from this API altogether.
> >
> > Also, may be worth running the newly added XSK test with the NETIF
> > env var set to the igb device? Assuming eth0 is your igb device:
> >
> >   NETIF=eth0 ./tools/testing/selftests/drivers/net/queues.py
> >
> > should output:
> >
> >   KTAP version 1
> >   1..4
> >   ok 1 queues.get_queues
> >   ok 2 queues.addremove_queues
> >   ok 3 queues.check_down
> >   ok 4 queues.check_xdp
> >   # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Note the check_xdp line above.
> >
> 
> Sure, why not. Seems to work.

Thanks for testing it.
 
> |root@apl1:~/linux# uname -a
> |Linux apl1 6.14.0-rc2+ #2 SMP PREEMPT_RT Wed Feb 19 14:41:23 CET 2025 x86_64 GNU/Linux
> |root@apl1:~/linux# NETIF=enp2s0 ./tools/testing/selftests/drivers/net/queues.py
> |KTAP version 1
> |1..4
> |ok 1 queues.get_queues
> |ok 2 queues.addremove_queues
> |ok 3 queues.check_down
> |ok 4 queues.check_xdp
> |# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Has this xsk netlink attribute been added fairly recently? The test
> failed on my kernel from a few days ago (kernel from today works).

Yes, it was just merged, see the commit date here:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=788e52e2b66844301fe09f3372d46d8c62f6ebe4

> I think there's room for improvement though:
> 
> |root@apl1:~/linux# NETIF=enp2s0 ./tools/testing/selftests/drivers/net/queues.py
> |KTAP version 1
> |1..4
> |ok 1 queues.get_queues
> |ok 2 queues.addremove_queues
> |ok 3 queues.check_down
> |# Exception| Traceback (most recent call last):
> |# Exception|   File "/root/linux/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
> |# Exception|     case(*args)
> |# Exception|   File "/root/linux/./tools/testing/selftests/drivers/net/queues.py", line 53, in check_xdp
> |# Exception|     ksft_eq(q['xsk'], {})
> |# Exception|             ~^^^^^^^
> |# Exception| KeyError: 'xsk'
> |not ok 4 queues.check_xdp
> |# Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> I'd assume this shouldn't be a Python exception, but rather say
> something like "Expected xsk attribute, but none found. Fix the driver!" :)
> 
> While at it would you mind to add a newline to the xdp_helper usage
> line (and fix the one typo)?

Jakub currently has a series out to change the test a bit and
improve it overall, see:

  https://lore.kernel.org/netdev/20250218195048.74692-1-kuba@kernel.org/

It looks like your concerns (the typo, newline, and better error)
may still remain. If so, I can submit a follow-up once his work has
been merged to address your concerns - unless you'd like to do
that?

