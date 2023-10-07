Return-Path: <netdev+bounces-38747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44E7BC51A
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 08:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B10282108
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1779E1;
	Sat,  7 Oct 2023 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86479D2
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 06:41:26 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8CCB9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:41:24 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3976fLPA021199;
	Sat, 7 Oct 2023 08:41:21 +0200
Date: Sat, 7 Oct 2023 08:41:21 +0200
From: Willy Tarreau <w@1wt.eu>
To: netdev@vger.kernel.org
Cc: rootlab@huawei.com
Subject: Fwd: Race Condition Vulnerability in aarp_rcv of nfc module leading
 to UAF
Message-ID: <20231007064121.GY20998@1wt.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Sili Luo of Huawei sent this to the security list. Eric and I think it
does not deserve special handling from the security team and will be
better addressed here.

Regards,
Willy

PS: actually there were 8, not 6 reports for atalk in this series.

----- Forwarded message from rootlab <rootlab@huawei.com> -----

> Date: Sat, 7 Oct 2023 03:12:17 +0000
> From: rootlab <rootlab@huawei.com>
> Subject: Race Condition Vulnerability in aarp_rcv of nfc module leading to UAF
> To: "security@kernel.org" <security@kernel.org>
> Delivered-To: security@kernel.org
> 
> the document format is markdown.
> 
> I recently found an race condition Vulnerability in the aarp_rcv, which leads to the kernel access free'd atalk\_iface object.
> 
> The vulnerability code presented below is located in Linux 6.5-rc5, and it is possible that other versions may also be affected.
> 
> [Root Cause]
> 
> key code of aarp_rcv:
> 
>   *   aarp_rcv
> 
>      *   struct atalk_iface *ifa = atalk_find_dev(dev)
> 
>         *   return dev->atalk_ptr;
>      *   use ifa
> 
> vuln: aarp_rcv use ifa without lock.
> 
> steps to trigger bug:
> 
>   1.  let thread A is executed in the middle of 1 and 2
>   2.  then thread B free iface via ioctl(at_fd, SIOCDIFADDR, &atreq)
>   3.  Then thread A will use the free'd iface.
> 
>                                                   Time
>                                                    +
>                                                    |
> thread A                                           |  thread B
> aarp_rcv                                           |  ioctl --> atalk_dev_down
>                                                    |
>                                                    |
>   1.ifa = atalk_find_dev(dev)                      |
>                                                    |
>                                                    |
>                                                    |     2.atif_drop_device(dev)  --> free ifa
>                                                    |
>                                                    |
>     // UAF!                                        |
>   3.use ifa                                        |
>                                                    +
> 
> 
> [Patch Suggestion]
> 
>   1.  add refcount for struct atalk_addr
>   2.  Use the right lock
> 
> [Proof-of-Concept]
> 
> No poc yet
> 
> [CREDIT]
> 
> Sili Luo
> RO0T Lab of Huawei
> 

----- End forwarded message -----

