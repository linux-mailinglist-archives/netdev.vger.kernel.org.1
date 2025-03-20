Return-Path: <netdev+bounces-176469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5EA6A752
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5477A933C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55FF21D3E2;
	Thu, 20 Mar 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="tECbdVT6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4ED1DE4F6
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477907; cv=none; b=Ss/9kF8iXCY2Hskz+mvOkVGJ7hZ3kGFUet8KO3JALT2IPhcH25HSe0DwiCzASDqd253W7WmwBJfOdrfCIZGa8wnrXJPDDZxZO73nwy/QbK5MYCmjezqiXxoWWLsQobnbkY+ivsG1NR6kDj10+cJR6w9Uw9c7mwtum3YjpC7cvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477907; c=relaxed/simple;
	bh=XjGoj4RZEecdIc2q8J7lg7CrKtxBQoTYu0PTJzg5Id8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LF/D17q+OW/ohtKPSUz3l5oAbrooEz44D7EGk7fZLqH/wrUalnnfVATQIL0uI2JH7UoR18U/ggSMo/wBsiY4tE6Lr2xnXQGzILMmak3yvc3Fzh0xcbiDpdxT9RexRWJLgKnmwMbJVLDkzXFtRYnjEPnNcYZv0kv71G57XfwGiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=tECbdVT6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaecf50578eso161956366b.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742477903; x=1743082703; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FA18/Xk3N4kBHtsdFgATp+nj0pwwBAVy6FmbehsjSNk=;
        b=tECbdVT6/Dalp1P1bIEeq60mFuFGEPvo/WC2Ks6IzKIaLREOIEyhbxzDD2z7AMe+CW
         uIXAC9jNCVuGsyxexQglP8b9M2qbHL1smRAtkz9kKRjohnECAdKkJ7MbX1GIkuoBX87r
         BxJXE0529CubGc9dTcjwP+AEpWcHLCeiBrZ61Ts0LwQe0qWbBde+4jz3votGAKsT+SZ9
         /NslDa/SSYdKcTaZvd3H/O91GAusbdLcmqIoM4ZrPnSS2w2z+PtZpX2/aP61fIN2tOkA
         2HS8KM3ApDTO/Lvz387Tl7UKxvvdBpQfkIZPmFQCd/ewRYTmSfGh4vqAQGpbf5PtN89q
         y13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742477903; x=1743082703;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA18/Xk3N4kBHtsdFgATp+nj0pwwBAVy6FmbehsjSNk=;
        b=wr3Vc/PCmQej6l8IHQCcBXBiaWQAz9DqFUnMcqAtbVhJIhz9mXsv2H2hQcmEmcOqXN
         TRTwXWUGWFmXXoyfeYq8iqfKqbWwYrQPVD3UDmD7d6ulBsYoVYBdpsQW6w6CWRrFSVKK
         96dUZjWHUGD5QtlGDhQOSjsDbCYasuNa4bClimV+MKAtSx7BWTcTgrfKJrP2+HGQZkmV
         KNIkkngV2rRWhJ9g963pG0lsH6IM/LoDbjCL9NaNSmxxx74aRhETXoN0QUJwyvp60fiA
         lm2zP8k8r0DVYt74WcrZ/m1RpFBBrDaX+ZndlmrXIEsHH1lUjjXwrk3Cwwv3Ip6kKNZc
         qv7g==
X-Forwarded-Encrypted: i=1; AJvYcCXoom3+KmcmZbCO1l2FIvN847wItEd+RubZE2HrXxnNVG7C0NuiQHILVGdvBqt/gpoIbTF+vyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyM8bdAUCHlrTQSlT7K2CmfE59OHjuBwNbvO94DjmpbL+hPHJ
	16aVAbGfeT2t/g5AIcY/ky0h5JOrYDu8wM4jpwWXPih6HpSCgejBlyGgnOWNjOvS8NEcCThk42P
	D
X-Gm-Gg: ASbGncsYEpoCfSqCPTwKDPdfQ6k+Qqz4OrFuk6GqEak7264wnRSiNEbcPmONy8O8HXh
	Qg41QJktwF7MesObugv5ErOKwNT+1vR2LzXj9auw8HH0pV1SSfqwCGt4EsnS/e8daqh1ilDFI9D
	GG+WVAmBoJI1omAxlXM9328agLGjmsotLJ643VpuhZWjS7J9kHcWPsWU3Ea3OtpLflWBA7unI7N
	Ni502TEvkMThptkKg/1H3So2PJtDpqgWwDS2Iz0GYwWy1/HAQkaTgTlmT8X9WGOmCkfsCw6KRyW
	n24vZBLr2qYtxLkVgD1daX2TrpbYysty5+qBHgv4fRQnWVHVj/063KMM/fBKSr2/nTUR/tRjK1Y
	=
X-Google-Smtp-Source: AGHT+IGSkmAmwk4uoCr+jfwDPC+9ZMzI9bjkvSxgp8E1xI1FwMseGnStkrT1GQnV52VTw2HH81OikQ==
X-Received: by 2002:a17:907:7290:b0:ac1:f162:fb0d with SMTP id a640c23a62f3a-ac3b7f730a7mr758299566b.37.1742477902863;
        Thu, 20 Mar 2025 06:38:22 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3d7bd6d01sm110875366b.0.2025.03.20.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:38:22 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 kuba@kernel.org, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com,
 ezequiel.garcia@free-electrons.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <16143c70-de5a-4f30-ad29-eae33d2e5b0b@lunn.ch>
References: <20250320092315.1936114-1-tobias@waldekranz.com>
 <20250320105747.6f271fff@fedora.home> <87zfhg9dww.fsf@waldekranz.com>
 <16143c70-de5a-4f30-ad29-eae33d2e5b0b@lunn.ch>
Date: Thu, 20 Mar 2025 14:38:20 +0100
Message-ID: <87wmcjakkz.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, mar 20, 2025 at 14:14, Andrew Lunn <andrew@lunn.ch> wrote:
>> We still need to disable bottom halves though, right?  Because otherwise
>> we could reach mvpp2_set_rx_mode() from net-rx by processing an IGMP/MLD
>> frame, for example.
>
> Ah, that answers the question i was asking myself. Why does RTNL not
> cover this...

If we zoom out from the single-CPU perspective, another path not covered
by RTNL (which is how I ran into this) is via deferred switchdev event
processing. Here are the stack traces which confirmed by suspicions:

[   32.161265] CPU: 2 PID: 6198 Comm: 55-init.ip Not tainted 6.6.52 #1
[   32.166445] Hardware name: fooboard
[   32.166450] Call trace:
[   32.166453]  dump_backtrace+0x98/0xf8
[   32.166464]  show_stack+0x20/0x38
[   32.166469]  dump_stack_lvl+0x48/0x60
[   32.166478]  dump_stack+0x18/0x28
[   32.166484]  mvpp2_prs_hw_write.isra.0+0x194/0x1b8 [mvpp2]
[   32.166508]  mvpp2_prs_mac_promisc_set+0xac/0x168 [mvpp2]
[   32.166526]  mvpp2_set_rx_mode+0x15c/0x190 [mvpp2]
[   32.166543]  __dev_set_rx_mode+0x68/0xb0
[   32.166549]  dev_uc_sync+0x80/0x98
[   32.166555]  vlan_dev_set_rx_mode+0x34/0x50
[   32.166562]  __dev_set_rx_mode+0x68/0xb0
[   32.166567]  dev_uc_add+0x94/0xc0
[   32.166571]  br_fdb_sync_static+0x58/0x120
[   32.166577]  br_add_if+0x720/0x7a8
[   32.166582]  br_add_slave+0x1c/0x30
[   32.166589]  do_set_master+0x98/0xc8
[   32.166596]  do_setlink+0x2a4/0xec0
[   32.166602]  __rtnl_newlink+0x51c/0x890
[   32.166607]  rtnl_newlink+0x58/0x90
[   32.166611]  rtnetlink_rcv_msg+0x12c/0x380
[   32.166616]  netlink_rcv_skb+0x60/0x138
[   32.166623]  rtnetlink_rcv+0x20/0x38
[   32.166630]  netlink_unicast+0x2fc/0x370
[   32.166636]  netlink_sendmsg+0x1ac/0x428
[   32.166642]  ____sys_sendmsg+0x1d8/0x2c8
[   32.166648]  ___sys_sendmsg+0xb4/0x110
[   32.166653]  __sys_sendmsg+0x8c/0xf0
[   32.166658]  __arm64_sys_sendmsg+0x2c/0x40
[   32.166663]  invoke_syscall+0x50/0x128
[   32.166670]  el0_svc_common.constprop.0+0x48/0xf0
[   32.166677]  do_el0_svc+0x24/0x38
[   32.166684]  el0_svc+0x40/0xe8
[   32.166692]  el0t_64_sync_handler+0x120/0x130
[   32.166698]  el0t_64_sync+0x190/0x198

[   32.166704] CPU: 3 PID: 11 Comm: kworker/u8:0 Not tainted 6.6.52 #1
[   32.166711] Hardware name: fooboard
[   32.166716] Workqueue: dsa_ordered dsa_slave_switchdev_event_work
[   32.170392] Call trace:
[   32.170395]  dump_backtrace+0x98/0xf8
[   32.170400]  show_stack+0x20/0x38
[   32.170405]  dump_stack_lvl+0x48/0x60
[   32.170411]  dump_stack+0x18/0x28
[   32.170417]  mvpp2_prs_hw_write.isra.0+0x74/0x1b8 [mvpp2]
[   32.170436]  mvpp2_prs_mac_promisc_set+0xac/0x168 [mvpp2]
[   32.170454]  mvpp2_set_rx_mode+0x15c/0x190 [mvpp2]
[   32.170471]  __dev_set_rx_mode+0x68/0xb0
[   32.170476]  dev_uc_add+0x94/0xc0
[   32.170481]  dsa_port_bridge_host_fdb_add+0x90/0x108
[   32.170487]  dsa_slave_switchdev_event_work+0x1a0/0x1b8
[   32.170495]  process_one_work+0x148/0x3b8
[   32.170500]  worker_thread+0x32c/0x450
[   32.170505]  kthread+0x118/0x128
[   32.170511]  ret_from_fork+0x10/0x20

These are captured from mvpp2_prs_hw_write(), patched with some
temporary atomic_{add,sub}_return()s to detect concurrent execution.

> Maybe the design was that RTNL is supposed to protect this, but things
> are happening outside of it?

Yeah I was thinking the same thing.

