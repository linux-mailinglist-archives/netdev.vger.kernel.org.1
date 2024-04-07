Return-Path: <netdev+bounces-85531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832E89B267
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CBB1C20E3D
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042C376FE;
	Sun,  7 Apr 2024 13:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E639AC7
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498344; cv=none; b=M7YjsKmhMsu7wVPbLLEMQECxs41HqibbTIS0VohBnYiTJ1Jik3xl50QHyHwOtjqxu2ew9psiQWX8kAxPCMSTpAKmcTbmhl3k70xEaB/dsdy9nLnDXF5SwLrJUVrwNTc7pY4V+fqGOrfwkUlinD2E9yQCnVQRus3pj7YVoxCf66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498344; c=relaxed/simple;
	bh=G3SuHFbHFzh8ypZatqs8OpXqZOj87aatW9KjH+JX3+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oZqUkyEIrn8BdSfyMhNC4zAKsTdk2ZgEjD3fJpMeKA2DX0ZCnBpyNddMB6hrdAwnAotGFt5SsHCJDLs5mGMAkEdoNsEpdOeLIF0VQJrLjFJHgOP1uA/G+4s1znP6duk6cdZsSJu2O8WdNOnHOltttAeIIjv8YHEg1Bgvg0u3pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a17a4b594so11322045ab.3
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 06:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712498342; x=1713103142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8th6mi8YZ4SsK+AiWToLd2PxMqZqV+eb1WyXiyTunM=;
        b=FUxOnJpacejPt2J8agfZU7kVb0f01yOHrjkbuZ2iQ6W/DwRUoL3CQLqwn4+juzT1NJ
         C1V9tNTvh62lJnqxYLDpO+Gw1ylLWUnn9aHg5zmjFw06W4W5rSLTwD2N4McmmRqMR09b
         65X2CdzrU9iF2+/eIkUFYHLXWQxwV1PqMm+cmDCitkUAFJzMxOb48jvTnwfQzA6qK+tx
         1zydgA63Csn3pxA/XXpf3C9ADJZme4JvTbebpY/a0sM0ZcvWiQgvOv7A/eDypqCTf5am
         bX4/7T1VEz26vlfe9ZQAfWZiciu+mKoLpOdz8kPfKyNF7FJ3iSK1JQW8JnwVHTeV9HI/
         UsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnLoCZer89CYzUe/qFLQwemzd/kRdBdroE8g+qqhVTISJpKwtRHnvmlzHpUa7MnIXK1Pi6+rZzGdaDrzFxYQqun9QVh0mG
X-Gm-Message-State: AOJu0YwFq9LoBGBXjaF/QRRUtCgNcDrGPuvk6o8jcLRtreHyuMI7ljqq
	X6UO0mLPyQxu5lHqjCHanlXCyun8plh/0jRI64qYl1MRXIQoVe+dRvA+B0m1AskLwtNtsKPUPoT
	h6Yvo7uUq76Q5wnIoFu4lSflQHH1csaYMUHFQX8grBuzHhqmLvcl9WW8=
X-Google-Smtp-Source: AGHT+IFRKc+gPnyLAxAH5+XQEeRuYzDRDNS0sDrq8v2ttGi7NqWFtGQeCgDhZmSWhznz4tsckWDm4Cdcag1QA6QB0dcB1gsjCuuz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:368:efa4:be00 with SMTP id
 v6-20020a056e02164600b00368efa4be00mr555322ilu.3.1712498342650; Sun, 07 Apr
 2024 06:59:02 -0700 (PDT)
Date: Sun, 07 Apr 2024 06:59:02 -0700
In-Reply-To: <000000000000dd84650615800e67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000647e5f06158217d9@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a0bfde167b506423111ddb8cd71930497a40fc54
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146c679d180000
start commit:   8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166c679d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=126c679d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338efc5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15428f4b180000

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

