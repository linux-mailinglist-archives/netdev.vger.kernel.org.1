Return-Path: <netdev+bounces-64958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928618387DD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50091C22E6A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60451C3E;
	Tue, 23 Jan 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggNS6PAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96450275
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994283; cv=none; b=OZqP+BG3V6Bl7PBps6PX6CUj3ANrscvRMCDlnPNuSzzQ2p32FZ3E5KFg1gXlgZeAM/dgph/yaYAHfm0DHXIVfjWyrfvDPVVCfWonH3pv3Md8saeB2RLrv+4vaY2fCaxgEc/FA7yp2V1GDlgnmnG2GWXminqwPtaiGG8U4cFk5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994283; c=relaxed/simple;
	bh=bxE1S4AariWp7GxtzFmxvODFmaDjNqEjtVlojLqHhFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEDbdATFwyAyQwLYxgCNEpZMeYRav6lByM3la35ZoX2jPeRGRCWB17NA/b3OvWTd7EaCoSEXv8PlknkjDLNTZtGO/PcEflB/5sS0yMwZ9K/bJTP04McZ67WbBVRhipAUvR24YU/JMxYQ8EXC+evpEN+/7hIco8evxgN7gtZGois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggNS6PAD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d748d43186so12246575ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705994282; x=1706599082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIVFkWSFTQdABKSR7Lhm5hOqC1if4w70pkn2KCeKSIA=;
        b=ggNS6PAD4ggT9VTyBC/F+NA5fcIEqmnzNK12hafhCJcezqk0CGMzcsbjx2fezGLJER
         vofKO9z+NXg46+aHtzQ3h+Wc/u60zrsRtj36arz6LAZGEXa71HESMAhQbqK1tOyWcuoy
         y85fOPHT7HzWFmwMOoM35zVqfBrK7iYKTcYeB4yAg0TqO+9deZRDgkwOhgYwJCq8Cvvp
         78xaTjaTxlvZjsErNomWJDEVrA+zB02u+CJRcONLabP2RjUkMTvRXml4ongc1SZnRuQY
         23/jflrFIXMoDPpib4WqiNQRnNSJy0kl7TwDh5qGpCVTpXHkBVaQZB5r0DUVhm3NwBHh
         rvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705994282; x=1706599082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIVFkWSFTQdABKSR7Lhm5hOqC1if4w70pkn2KCeKSIA=;
        b=jjnbLekdjq+GPgJ8m0fPP6ggeCaitH/erw6xAOJgvgioSRVjogjGAbOYTWY1/UKnWz
         ehZrxNbO7cPYuqNKRqeW5V2I1kYnpc/sz9+vApp14SeYKizTruAv2V+Svdxr6fi/QQKi
         Nwf4WeIAdMXHf70OAR2dDepHviZ5i4UkpKt7iB3ho96+U0Zby34HAl0BtWO8YSOQ0y6A
         E5OqzJGEufw/066MJnBQ2Uq5jlJ0X4bDBrR43K83sNKaatOTsStlzDMCb/V/Fwqnwt/S
         zXzh6BJ9hKsm9kRhzLClIDl2E7sXW3T6ji/PnmuCPw0Jb2XeTr0MOxQ/hxJ+KFOcoukT
         u9aA==
X-Gm-Message-State: AOJu0YyPFHPsvOhOqPFL4d9NWmNhtoZPSyVX+pHIZCmR5N3Zg6ulFvUh
	rREuKxB6zExxGQgqRS5Qgxjf8bB81MIx1SPUtth5XRwO9DNIXJUr
X-Google-Smtp-Source: AGHT+IEkvX9lAQEG/HVJG0VyMmJ5xpvxD4KJHbHicxppoEvddD4aaBLyFwx6xJlFCfEIwoHGhMn5LA==
X-Received: by 2002:a17:902:ea0a:b0:1d7:4a2c:81b6 with SMTP id s10-20020a170902ea0a00b001d74a2c81b6mr2675426plg.135.1705994281815;
        Mon, 22 Jan 2024 23:18:01 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001d6f04f2b5dsm8199444plr.30.2024.01.22.23.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:18:01 -0800 (PST)
Date: Tue, 23 Jan 2024 15:17:58 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] bond_options.sh looks flaky
Message-ID: <Za9oJmof6QYVHw52@Laptop-X1>
References: <20240122135524.251b0975@kernel.org>
 <17415.1705965957@famine>
 <Za8439kp8oPxwb7M@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za8439kp8oPxwb7M@Laptop-X1>

On Tue, Jan 23, 2024 at 11:56:15AM +0800, Hangbin Liu wrote:
> > 3) I'm not sure why this test fails, but the prior test that claims to
> > be active-backup does not, even though both appear to be actually
> > testing active-backup.  The log entries for the actual "prio
> > (active-backup arp_ip_target primary_reselect 1)" test start at time
> > 281.913374, and differ from the failing test starting at 715.597039.
> 
> From the passed log
> 
> [  505.516927] br0: port 2(s1) entered disabled state
> [  505.773009] bond0: (slave eth1): link status definitely down, disabling slave
> [  505.773593] bond0: (slave eth2): making interface the new active one
> 
> While the failed log
> [  723.603062] br0: port 4(s2) entered disabled state
> [  723.868750] bond0: (slave eth2): link status definitely down, disabling slave
> [  723.869104] bond0: (slave eth1): making interface the new active one
> 
> It looks the wrong active link was set. It should be eth1 but set to eth2.
> So the later link operation set eth2 link down. Not sure why eth2 was set to
> active interface. I need to print log immediately if check_err failed.

Ah, the log did print the error message:

# TEST: prio (balance-alb arp_ip_target primary_reselect 1)           [FAIL]
# Current active slave is eth2 but not eth1

From the log, not sure why eth0/eth1 down and thus the eth2 become the active
one.

[  716.115869] bond0: (slave eth1): making interface the new active one
[  716.116914] bond0: (slave eth1): Enslaving as an active interface with an up link
[  716.117792] br0: port 2(s1) entered blocking state
[  716.118022] br0: port 2(s1) entered forwarding state
[  716.234644] bond0: (slave eth2): Enslaving as a backup interface with an up link
[  716.235716] br0: port 4(s2) entered blocking state
[  716.235926] br0: port 4(s2) entered forwarding state
[  716.373537] bond0: (slave eth0): link status definitely down, disabling slave
[  716.374651] bond0: (slave eth1): link status definitely down, disabling slave
[  716.374920] bond0: (slave eth2): making interface the new active one
[  716.484168] bond0: (slave eth0): link status definitely up
[  716.484909] bond0: (slave eth1): link status definitely up


For other passed test you can see the eth0/eth1 was not set to down. So eth1
keep as the active one.

[  498.558083] bond0: (slave eth1): making interface the new active one
[  498.558973] bond0: (slave eth1): Enslaving as an active interface with an up link
[  498.559724] br0: port 2(s1) entered blocking state
[  498.559962] br0: port 2(s1) entered forwarding state
[  498.632107] bond0: (slave eth2): Enslaving as a backup interface with an up link
[  498.636366] br0: port 4(s2) entered blocking state
[  498.636684] br0: port 4(s2) entered forwarding state

Thanks
Hangbin

