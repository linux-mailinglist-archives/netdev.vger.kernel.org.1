Return-Path: <netdev+bounces-302025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oaFPETFSPWop1QgAu9opvQ
	(envelope-from <netdev+bounces-302025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4766C7508
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:07:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kQThqkgq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302025-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302025-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFF0F3004694
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD32F8E9E;
	Thu, 25 Jun 2026 16:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA72246774
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403546; cv=none; b=VRm0EGV51CLopvyorCgoWGiH2XjKPMVHqyQ2aHAlq94Ca9ypypmhRkkoy1K+mskefV/CcT6UKrv8W/b4YTi0KVihPVDgBzU5ZieiV/tu9BoNGX7NvIPWYxahmwU/aL3WMY64AOy5JoE10ynX5KCnDN2Ulhwgnfc3yW1Is4hmcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403546; c=relaxed/simple;
	bh=aPwu9tkA0CCSJOiGcoonMyOYAK6gBWxb4aTk+URHuA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZSANnsoisRK6egJhNjBeam/gAtPKf2P9e7pjqxqKJ64kmrFy47nPOcTxROtBsVPhTHnmbVhj/WPnwunFtyp/Mp4K0RGBDOPnsTBXXIVedjvj9pXX6xMtzejW5buuwWg5fkfz2lLiEtMX6uKP0zi0AQfsFPAT4yXegJYzXEGt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQThqkgq; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so515875b3a.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403542; x=1783008342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwD3T88si+zfL1G2RyvLxMNC+vMuHH67pPeqGXtEpf4=;
        b=kQThqkgq7npN5rnO0dUeau/+/ouq+KQlMsBANKQK2vzYMhoyZYz+pgJgDP/3dx7WR5
         QqXYfLhW3rm9FuQmf7TdGD/WCSVyZS2IjdL8Q4dqmj3VQFR0I93634sNmJANrfW/L6as
         O95tIO9j3PNXSNUBQN8M4PKdbWXeHIafF7ySUxEQkhsiptTUlyIR/nFPuppVdtNXyfwv
         JYZ7kmNY5nq5c1reRAvJ5NJhXAf1Uiv0ht3XcINy3HXgVykRELl8mpzAuLrkS9D5h9/H
         M0WXfEbNMjHhbSwwBwUC0IapGEBmo/hqRub6ALH4oAHyAEdamMCpV5o3TbF8KZ2/saST
         I83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403542; x=1783008342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwD3T88si+zfL1G2RyvLxMNC+vMuHH67pPeqGXtEpf4=;
        b=BOb7Wdp3n0o23Y7TfmogZsBAZEvF7swf0aAr/IGEj9kB2MhVTPZfHO6e9yinlcfY6Z
         8/mbi9sVacJPDa0cYv9V2BOpgqv3ySX/Hii7+y3vDVmYRh3nAG4E3qnv1dkgsjr5G70I
         r42XL/YzTuQVIpk4GJeQZo7R8qYR4fq8u7IkGOIZYog/VCoYbB4YC49lsxU4Bp5mLyfz
         cjAbfyjIWT5fAkKznnMHSYJCGhI4Gr7c2p83j4KSpt2tGDiG6KcC15L+F0Z6imJh2nfp
         uzP0Ta7IM+eA7kCNiWjSgvN9I6eqt0DVlsGen0dEIC3XuREQ6GF3B9CqUdYs5DCWzAj6
         lQ/A==
X-Forwarded-Encrypted: i=1; AHgh+Ro6hzc1ePRwbvBA7pCNFiRBzJeO5m8vpkuiyK9QOR+ZDSnDUK45aYtKa1tLjte3o2DHhfuLai0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdknsD/+jIbjI3CndZZfYpyTgJJ72PXyHycTJ7wrWhZGIdz47x
	Pu6kRL82AiBv7jy3Shm9t3MloRQ1mKDiwJFSVZdKmYiYMEDIM02Hfns4
X-Gm-Gg: AfdE7clmbcF03V0l6TpuudCpo7RreIRI2nrIBMRT7R4SLSiGcXiub5pPK56ylVs1lxQ
	6Tsxq97SgzdzsDAa61rI3MMuztUYJuYS5LJELCVggSt1K63nTcIWcuDo91OsIA/4R05y9LX/Vh5
	YgPb1QktCIil24JKKDRXGMDYZdPNgfXfsOo3cy/a+gOyVwXgHF2E2AWAkTFs7EuEtjQWaucA0RO
	DahNmctta62tGktVtBR18dm79sVBbB1mZWhWp2u0+gnqoWUlPYkJq4D4SXX1roYQJSBuRZPSqwc
	rcpnk6HHPySWN2MYpNyJCvl70GF3HV70ik8avSflDdDqfk9cYQ+ctOZP7L+Sg3MmJjq0FB/KG1k
	DzSNYOOrGp0YFMfcQKD1R7SxXJQ5OtO/eCweP5T7wxxLCAA56SM0VdV8SQTg+QbbehW3cwlPyUV
	Gxp4xT
X-Received: by 2002:a05:6a00:2195:b0:837:735b:826f with SMTP id d2e1a72fcca58-84591d0009amr11653276b3a.32.1782403542224;
        Thu, 25 Jun 2026 09:05:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845c39a5c43sm6927b3a.47.2026.06.25.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:41 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:49:24 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, n05ec@lzu.edu.cn, 
	yuantan098@gmail.com, kuniyu@google.com, nb@tipi-net.de, aleksandr.loktionov@intel.com, 
	dtatulea@nvidia.com, syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com, 
	syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com, syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Subject: Re: [PATCH net 3/4] vlan: defer real device state propagation to
 netdev_work
Message-ID: <aj1N_W_RwvNxPrLk@devvm7509.cco0.facebook.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624182018.2445732-4-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,m:syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,m:syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,09da62a8b78959ceb8bb,cb67c392b0b8f0fd0fc1,9bb8bd77f3966641f298];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4766C7508

On 06/24, Jakub Kicinski wrote:
> vlan_device_event() generates nested UP/DOWN, MTU and feature
> change events. It executes an event for the VLAN device directly
> from the notifier - while the locks of the lower device are held.
> 
> This causes deadlocks, for example:
> 
>   bond    (3) bond_update_speed_duplex(vlan)
>     |           ^                v
>   vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
>     |           ^                v
>   dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()
> 
> The dummy device is ops locked, vlan creates a nested event (2),
> then bond wants to ask vlan for link state (3). bond uses the
> "I'm already holding the instance lock" flavor of API. But in
> this case the lock held refers to vlan itself. We hit vlan's
> link settings trampoline (4) and call __ethtool_get_link_ksettings()
> which tries to lock dummy. Deadlock. There's no clean way for us
> to tell the vlan_ethtool_get_link_ksettings() that the caller
> is already in lower device's critical section.
> 
> Defer the propagation to the per-netdev work facility instead:
> the notifier only schedules netdev_work_sched(vlandev, VLAN_WORK_*),
> and ndo_work (vlan_dev_work) applies the change later. Hopefully
> nobody expects the VLAN state changes to be instantaneous.
> 
> If someone does expect the changes to be instantaneous we will
> have to do the same thing Stan did for rx_mode and "strategically"
> place sync calls, to make sure such delayed works are executed
> after we drop the ops lock but before we drop rtnl_lock.
> 
> Stan suggests that if we need that down the line we may
> consider reshaping the mechanism into "async notifications".
> AFAICT only vlan does this sort of netdev open chaining,
> so as a first try I think that sticking the complexity into
> the vlan code makes sense.
> 
> One corner case is that we need to cancel the event if user
> explicitly changes the state before work could run. Consider
> the following operations with vlan0 on top of dummy0:
> 
>   ip link set dev dummy0 up    # queues work to up vlan0
>   ip link set dev vlan0 down   # user explicitly downs the vlan
>   ndo_work                     # acts on the stale event
> 
> Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com
> Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com
> Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
> Fixes: 9f275c2e9020 ("net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

