Return-Path: <netdev+bounces-150715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7A9EB3C1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106D3188C6F2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9411B6D11;
	Tue, 10 Dec 2024 14:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F71B422E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841844; cv=none; b=JBPuK6gaWOz4mu7Za0plMHJ8peN9S65srVk3vOm/1UTp2pZBU6IHyuA7yYJv34HQQ63FOPa3jmbyoEPcgbNgnmM4z74X5nBNGgbQ2vfmuj6nF9C94eiCYI5OXpnN6i63PloQ5qmAu/WJGmURoborCtw5nouMQI7kS7Sb6ZkIouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841844; c=relaxed/simple;
	bh=UJwFBO9vbEOarQQdzEAtnm6eWrTvYdifQjQmy9S6VNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sk+vA3WNoyr88lpzwfLIrA0Mu51gRgvKav1Ax/zx9KOm6Oxtse5mrI9TjqDCTJRTVxjU7Vib3cIJwiXTpvv/VNTYnqdRBWqN4/rur+Hvx1UMjOT+oXryCq9wgTBkT6Z1woEO9wA71txKLVQVB71SxgU/GYekOUyqB/xOZVkGbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so29114285ab.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841842; x=1734446642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHRmglB/uTlqO78lWJ+GcsToPOMC3b4XV7WsgLDkrd8=;
        b=pUXbOaG5LciK0uc0Z0DMe6KPLA/ZbC/C1lm+7LSLD3ii363ZETg0X9os6jc4V9NA7f
         aismV3hIf3RpmkH8OayxVxI8+DaI/+5EHRVLeIIDcHKB6SxIr+HQFcRS3P+jyXVKLwyo
         lYL1ClzkwVXoCL40y7FjjjXQdl/vexjz84qefClff0d8S78fJiKpGax8AxjngAgyet2p
         +Yt0Kq2V9oyY1KGE1ojrJDH77l2R004HCHY5sUdOSxh3XUjG9Y3tg60sxayoR+R51MYN
         ZUuwDstcC1j4tMsFUtxruCsHMJabS4npcuEcsLUTk2/KA6fSZxgfRJ9euJORWtnk0eDF
         hGzg==
X-Forwarded-Encrypted: i=1; AJvYcCUlyhblaWmhYqxhddY3nCbZIlM9omaD6WRm6kwkW+lZrXC56niHs66KOgcUarr+5xVOBHqYYVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8alWaWGtUib+uYdwGsL9O6eTqggYQEefafGe15bpUk/9QPHsW
	1XgPS6R9bokd18xrJBDogfTSfUo6RDJJJsMNGA9NI28BhSvnW7PBSCUrCZh/YA1wkpGzdbqClH7
	hlLimg1pz8nNZbFI8Z4CsFDHM6gC1KvS7Y/sR6g6a2e0mjG0f90bSIfM=
X-Google-Smtp-Source: AGHT+IGGgYznzK9FyGa6Y3SQoRd69Sy14L/LftCeFxE3fEamhn1CYv6QsyjuW4JiisG7CRdwe3bBn4Sam8D0BTwyfYYIVTU8kMOm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a9dbb2b21amr44928275ab.21.1733841842547; Tue, 10 Dec 2024
 06:44:02 -0800 (PST)
Date: Tue, 10 Dec 2024 06:44:02 -0800
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675853b2.050a0220.2477f.0065.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
From: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b341a0263b1b804d329f864c2dc24815364510ec
Author: David Howells <dhowells@redhat.com>
Date:   Wed Dec 4 07:46:46 2024 +0000

    rxrpc: Implement progressive transmission queue struct

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bbeb30580000
start commit:   e58b4771af2b Merge branch 'vxlan-support-user-defined-rese..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=147beb30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=107beb30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff11be94dfcd7a5af8da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cb93e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3d4df980000

Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

