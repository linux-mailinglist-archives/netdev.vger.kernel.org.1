Return-Path: <netdev+bounces-155105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A3A01135
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07697A205A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199A8F77;
	Sat,  4 Jan 2025 00:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA64C9D
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949001; cv=none; b=NWvwwE88dndDx95snXyQgnq3EX/U4rY+EHpJIM3H1OLFnZPcqPGH7AD48Segpew6A+no2XvgzxNO6zjELoUyichIwRH2gwa/QW6nBEiohDS8cmPVxmK1xPRq6raUDSRQnL8+akdofmBUkOeP1rMbwwgU3R2D+MAm3UOyPi070ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949001; c=relaxed/simple;
	bh=iL+QhY2jGfSA1QdIPfyZCmOe9KlDNCylLsaSMZgAp24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RumECiu8TWZVo6A1jUUWNmaidL+D5wvXUnQ5YPMQRrBeRIc3DkMaldBGtn2ed+15YBH7KJEY2Kj7617smmSRQyqSjLodE/jiVRvNxQeiF2ssfAWb9f+3/wvdDCD6L7denIQaKyKJmYmU7cugJX+EfdpPsnvf6O5JcFRdwKMczLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.58])
	by sina.com (10.185.250.23) with ESMTP
	id 67787A2B00003212; Sat, 4 Jan 2025 08:00:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5457368913392
X-SMAIL-UIID: 3FDCAF96B6FE48F9873ED17E530CF1E0-20250104-080046-1
From: Hillf Danton <hdanton@sina.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
Date: Sat,  4 Jan 2025 08:00:33 +0800
Message-ID: <20250104000035.1356-1-hdanton@sina.com>
In-Reply-To: <p5ych35cl5ofdzvoobk6uxu4s7f5h3joogy6wee2sq3g4m4mxb@py7tzqwueh74>
References: <6756b479.050a0220.a30f1.0196.GAE@google.com> <6777334a.050a0220.3a8527.0058.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 3 Jan 2025 10:20:34 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com>
> * syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com> [250102 19:47]:
> > syzbot has bisected this issue to:
> > 
> > commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
> > Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Date:   Sat Sep 29 00:59:43 2018 +0000
> > 
> >     tc: Add support for configuring the taprio scheduler
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117df818580000
> > start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=137df818580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=157df818580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8a8df980000
> > 
> > Reported-by: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com
> > Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > 
> 
> This looks wrong, if this is a bug (which looks like it is since it has
> a syzbot reproducer?), then it's different than the previous two reports
> and probably not related.
> 
In case you missed it, take a look at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb66df20a720

> 
> Vinicius,
> 
> Looking at the patch, it seems you missed some users of -1 vs
> TAPRIO_ALL_GATES_OPEN in taprio_peek().  The comment in taprio_dequeue()
> is useful - maybe the gate_mask rcu lock/unlock could be a function and
> have that comment live in a static inline function?
> 
> Thanks,
> Liam

