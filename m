Return-Path: <netdev+bounces-194281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6027AC8579
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6D7AA487
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40825487E;
	Thu, 29 May 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kVDTFufO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61A248F57
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562623; cv=none; b=a5xtcMJe4ujWK+13fVEoAHqaOzfQUN70iHLnwDuqEFGAMXjPCLrU2JyMu0MQ78XYkNkAHTq55H39pRCd3ympxnVaCiPp03fN+tCan1+kdBKcJaFLtnt/ymRI6PYquHwMg/HNGyP2oy6w3/OhB+aLYu2CiulpbYY0mAYirmrfdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562623; c=relaxed/simple;
	bh=CYs1g0ekdBblN/jK1cAIme489gvuXetb79Xt6LZ/mUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1WpYhicaGuz251qoJbXN+/GnmwXHe0k41UeqlhoS1KtSbHvLSyHcamrtTn4GcmjdxBlpY/8QI2Sf7fFmxrzNfj2iFm3t5b0wkPDXJMOxm2b/ZhfrG9WupviDgDrnUnMlAKbUQ9zp9miVB1x5k6Qh+SPPZKzKbCUQDffO8aFvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kVDTFufO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23035b3edf1so14708115ad.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 16:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748562621; x=1749167421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbPqPQiDWRer0P2e/HJQrUigZTmf22Qe/ORDOfEZJcI=;
        b=kVDTFufOOAXwPirL5C5BaySyE9K7blW6V3EGXnWX1GdNDfNK39RLWabv7ZQJsbE6WY
         X8xaeEJSYkxi0UCAdZu3HPdDm756gGbpi9lzvJjHQvJVYLeG8g2uciuUEsFH7byWzHuk
         0nw/5YNuEmDwiER8nvzw+lcldT2zIsxq8h1YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562621; x=1749167421;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbPqPQiDWRer0P2e/HJQrUigZTmf22Qe/ORDOfEZJcI=;
        b=e5UWwDe7QP4VnLULKMiL3sLwFYx027tN9xXNKATqk9cLVK/ojGOhhJ67fapgGnw9G0
         QAvbwiEVSNjSjtSdRZbzyNl2zIiUFWqEPvpC+E9xgbjfFs/6OZkrubkG2XhAyvuZX0Qd
         gOgnzoJTWdvR8GJOWbTmiHj7QIr3st2l8QZ8qJGmOKoHhNIMHV8IMgrgmsfDtzj1iu8o
         3aJvnUnNpKK7iAPKT0uofjNQQE9XajY8qgZ+WOuGsxAhgR+rGS0C7KpT1CSlmfLlyRK3
         /n75J3VW6V9hpDLHGfWyJVvqAztJtybi2imIcY3iPJlZPz/BA/xme4xJqRvQDKCzp0ee
         LKJA==
X-Forwarded-Encrypted: i=1; AJvYcCVLOlshc85IEqXG22UIJprAxpY4RTd1ygKEMo2rsHGHfry9Ak03xmBLAcbX4Kj12GGCadRArd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLWHiS4o+R7iduZqdUMr+M4TnbnLl9OXSYSDCM48NQmuvtu8n
	txH0af2Li9WSdrqqOvgMP6spsDyPPy4OrV9Tb6Rz955sB+OaOc63+oLUu5PpuYyOOB0=
X-Gm-Gg: ASbGncvL/bQu14PCwF2v4FAlmkWg3UNrffQhj09/5RuTpM7ru3gRHDOIk7Qe0LY1AxU
	ckngNItcLDSqAqfaW/C6Lw6dr51EebzyQi4Atwu5775a2fqVqCU3Rjmws7aBfGr2vFo7UAdQ6RG
	s22chVfVDzdOcMn3TEs9i+QJ3ygZAAyeHZ/ThUz57X9v5fRxgM5dlvaNG1qjt7XDDppyIp7YjZr
	SpFSH15yRqcNdUHBzBZCwWT03NMWo2YSps2rPRGMRLC7KuwgtvjWH2JC6ePx3QiIyxWiFYbpUfY
	48nrL1H+hB811rNBS/zIdtpr35saFZIj4hbbHIr/EJRlnUy3Qjc4FwI93w890LXE3A0N9p2FJvX
	06KKCK3cKQiIdFHPvTDJcxsc=
X-Google-Smtp-Source: AGHT+IHEsxjJuENX6L+gwyU6IIgM3kSEYP7UoEirxCoFSx20PDVXZPjPogvWOHA0V2n2wPouICBg8g==
X-Received: by 2002:a17:902:f611:b0:224:76f:9e4a with SMTP id d9443c01a7336-235291f59aamr22225185ad.14.1748562620648;
        Thu, 29 May 2025 16:50:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd36b7sm17379365ad.117.2025.05.29.16.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:50:20 -0700 (PDT)
Date: Thu, 29 May 2025 16:50:17 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: John <john.cs.hey@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug] "possible deadlock in rtnl_newlink" in Linux kernel v6.13
Message-ID: <aDjyua1-GYt8mNa1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	John <john.cs.hey@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
 <c9b62eaa-e05e-4958-bbf5-73b1e3c46b33@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c9b62eaa-e05e-4958-bbf5-73b1e3c46b33@intel.com>

On Thu, May 22, 2025 at 04:05:05PM -0700, Jacob Keller wrote:
> 
> 
> On 5/21/2025 5:52 PM, John wrote:
> > Dear Linux Kernel Maintainers,
> > 
> > I hope this message finds you well.
> > 
> > I am writing to report a potential vulnerability I encountered during
> > testing of the Linux Kernel version v6.13.
> > 
> > Git Commit: ffd294d346d185b70e28b1a28abe367bbfe53c04 (tag: v6.13)
> > 
> > Bug Location: rtnl_newlink+0x86c/0x1dd0 net/core/rtnetlink.c:4011
> > 
> > Bug report: https://hastebin.com/share/ajavibofik.bash
> > 
> > Complete log: https://hastebin.com/share/derufumuxu.perl
> > 
> > Entire kernel config:  https://hastebin.com/share/lovayaqidu.ini
> > 
> > Root Cause Analysis:
> > The deadlock warning is caused by a circular locking dependency
> > between two subsystems:
> > 
> > Path A (CPU 0):
> > Holds rtnl_mutex in rtnl_newlink() ->
> > Then calls e1000_close() ->
> > Triggers e1000_down_and_stop() ->
> > Calls __cancel_work_sync() ->
> > Tries to flush adapter->reset_task (-> needs work_completion lock)
> > 
> > Path B (CPU 1):
> > Holds work_completion lock while running e1000_reset_task() ->
> > Then calls e1000_down() ->
> > Which tries to acquire rtnl_mutex
> > These two execution paths result in a circular dependency:
> > 
> 
> I guess this implies you can't cancel_work_sync while holding RTNL lock?
> Hmm. Or maybe its because calling e1000_down from the e1000_reset_task
> is a problem.
> 
> > CPU 0: rtnl_mutex -> work_completion
> > CPU 1: work_completion -> rtnl_mutex
> > 
> > This violates lock ordering and can lead to a deadlock under contention.
> > This bug represents a classic case of lock inversion between
> > networking core (rtnl_mutex) and a device driver (e1000 workqueue
> > reset`).
> > It is a design-level concurrency flaw that can lead to deadlocks under
> > stress or fuzzing workloads.
> > 
> > At present, I have not yet obtained a minimal reproducer for this
> > issue. However, I am actively working on reproducing it, and I will
> > promptly share any additional findings or a working reproducer as soon
> > as it becomes available.
> > 
> 
> This is likely a regression in e400c7444d84 ("e1000: Hold RTNL when
> e1000_down can be called")
> 
> @Joe, thoughts?

Sorry for the delay, was out of the office for a bit. I agree with
the report that the locking order is problematic and with your
report that it was introduced by the above commit.

I wonder if e1000_down needs to cancel the reset_task at all?

If you look a layer below the original bug report, you'll note that
e1000_down calls e1000_reinit_locked which itself has the following
code:

  /* only run the task if not already down */
  if (!test_bit(__E1000_DOWN, &adapter->flags)) {
          e1000_down(adapter);
          e1000_up(adapter);
  }

So, it seems like the flow in the e1000_down case would be something like this
(please correct me if I've gotten it wrong):

e1000_down -> e1000_down_and_stop (which sets the __E1000_DOWN bit) ->
  cancel_work_sync -> e1000_reset_task -> grabs RTNL, calls e1000_reinit_locked
   e1000_reinit_locked -> checks the bit via the code above and does nothing

I could be totally off here, but it seems like in the e1000_down case, calling
e1000_reinit_locked is unnecessary since the __E1000_DOWN bit prevents anything
from happening.

Maybe a potential solution might be to move the cancel_work_sync out of
e1000_down_and_stop and move it into e1000_remove directly?

Something vaguely like (untested):

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..62a77b34c9ff 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -477,10 +477,6 @@ static void e1000_down_and_stop(struct e1000_adapter *adapter)

        cancel_delayed_work_sync(&adapter->phy_info_task);
        cancel_delayed_work_sync(&adapter->fifo_stall_task);
-
-       /* Only kill reset task if adapter is not resetting */
-       if (!test_bit(__E1000_RESETTING, &adapter->flags))
-               cancel_work_sync(&adapter->reset_task);
 }

 void e1000_down(struct e1000_adapter *adapter)
@@ -1262,6 +1258,11 @@ static void e1000_remove(struct pci_dev *pdev)
        bool disable_dev;

        e1000_down_and_stop(adapter);
+
+       /* Only kill reset task if adapter is not resetting */
+       if (!test_bit(__E1000_RESETTING, &adapter->flags))
+               cancel_work_sync(&adapter->reset_task);
+
        e1000_release_manageability(adapter);

        unregister_netdev(netdev);

