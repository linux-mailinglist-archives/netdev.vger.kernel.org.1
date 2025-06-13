Return-Path: <netdev+bounces-197642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25DAD975B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773FB17458D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B828D8F4;
	Fri, 13 Jun 2025 21:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F928D8C9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850204; cv=none; b=R8zXY71Ppn+hZliQZiQC+Z98fWY7g6i5RuyMKIBoV0wxZmfAbT4zd/tEyoTnV3ZwGqfQLm1c2ENY1OebNvCCvJ2T/U7xGNU4ItP0Td6qlalu7OPWQCp0186hI26TbU/N9mS89xHUS1re9r0U+ci7cH4lFJ4LT8yLpFvb0wFF3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850204; c=relaxed/simple;
	bh=VVCtDi/THMNaziVez+/Kfyif66Kw1La+EoS6lUhoS30=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IIr21xD9ZK3sTQFq3o8wTbi/ArQb1CCP21SY8E3OEpUllkxCWPv88Yc68PJqfhBAIH4KJCoN1gwV4xEcC0EFvT652OswRm2+faWuSz1w8haOviKiIvsMZAh4zCSKhGCiApohF5afIhiWDZBmWVLSlBqxsdsIH/q7xB3piP2aato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso28170835ab.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749850202; x=1750455002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39o0uOIy8QjGOd/DbwJtSHVgR+dZ0CHMjvotGtElSDE=;
        b=OXBEoHTqPKfLb6FFl+9pNv5Ga8YHsoxEMqdWuxYCAJ4CnSrdsXmACLzwHiPwm1eSv3
         lNiW35svI9RrZueXyFZS/DI+nW7fCeWIAs9RQUJ0JpeRsR3cZDfwlVyJmkJrbBHGdR7A
         ul6q3aEFC30cR+sjW4Nrca0HTM6J58th8S8NgxWGVIh6cCEmXQn28j5b8HodJLy2cbOb
         pquqrtfvvIq5jIWfPsXwYOP5ZSLZN+j85Flp91ouoq493XUN3rZSs6feH9K3U5hxcs50
         YuCBMIFkiqFsPcaW3U1L2W4lQQipSLbsdPU+zUPbDiuTFSx1IwRX+b+bVO8S+/ZTTHyq
         kkCg==
X-Forwarded-Encrypted: i=1; AJvYcCWwqCz1rOyj0puTKpGzYxi5Jqe2wasNMfVDyjXsq7nZwErVhaQ9Q3qx/mNAbO+SbHJjPEcYAGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOf3oqG26EBjNUM8/kPjPkBDLhi4ENHBUb/Jf3wt7fs6H+QHQL
	alikKgpJbpKTL6RbhoaLTC92+PIcIKat+Oiu09eyA2ok7l6tK4Z8sipi3GApZxeU8n1XHtDwwVl
	892kgc1O4hXfx7Xyrjpjq0ZsYkWxEYXW3D0D/cKqpC4nzWCr7zjDAp4vGhUE=
X-Google-Smtp-Source: AGHT+IHkW+PxD4B9B39h1g7efcqLTlZYeOaomRymEnK4adDkhv/HoIAE6ytX221HzaU3iJ8HKARthzS1ikAXB3lVCeVNH10HpKzP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:3dd:d1bc:f08c with SMTP id
 e9e14a558f8ab-3de07da228dmr14435435ab.20.1749850202173; Fri, 13 Jun 2025
 14:30:02 -0700 (PDT)
Date: Fri, 13 Jun 2025 14:30:02 -0700
In-Reply-To: <684b6ff9.a00a0220.279073.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c985a.050a0220.be214.02a7.GAE@google.com>
Subject: Re: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in cfg80211_inform_bss_frame_data
From: syzbot <syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com>
To: johannes.berg@intel.com, johannes@sipsolutions.net, 
	lachlan.hodges@morsemicro.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1e1f706fc2ce90eaaf3480b3d5f27885960d751c
Author: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Date:   Tue Jun 3 05:35:38 2025 +0000

    wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f60e82580000
start commit:   d9816ec74e6d macsec: MACsec SCI assignment for ES = 0
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12f60e82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f60e82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=fd222bb38e916df26fa4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1042460c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1442460c580000

Reported-by: syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com
Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

