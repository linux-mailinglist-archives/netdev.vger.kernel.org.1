Return-Path: <netdev+bounces-214234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7076B28941
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91935C14B6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD52F84F;
	Sat, 16 Aug 2025 00:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D4171CD
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304206; cv=none; b=Sd+9Vmh8NRxR+UTmIQD5yqAxgPquNE8/PQYGNXeB8Os52qs2b2OkZBEDC4XvPwvTj8GtAmrNCvkpPrCyay81/tFji35DxLxekHZgiLNVrmugiQUyiCsKhZ3TuE61cocNsyz1JoVmW0Lv8TD7x/rwWuZlHXC0yr5LGZKDc8mad0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304206; c=relaxed/simple;
	bh=VWUiUzQK86HWSwGuF8xInFChZoi2gS7Rymc5YjbW5Jc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=egT9xh43RK4rZxikT0LxWKT08vTgaT8gSTJIt0K2jbh++4VcJ5rdYJvpszohAa2UTQReBWgi7PjJ6B1iQjOLyF1LzbiPu8VHPTv76QTxyFzDQGorfkTbuq5rIMVT2PYmafodrC04Q24Kzdah2VNP+sYb0TyjmUTafR6C4KHbJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432d9ae89so247186539f.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755304204; x=1755909004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COIfik/RujH0ZCMLEJoppWLOYa7oLNPGVJSWQTRhpbY=;
        b=b43w8SDVHM13lqoNoGFH7sMPrZ+9wQk3Vjv8QlaAV9Q5+bN0OOqN8/Es4efo+E/jiV
         NpzdKIX+gEcw7zgg4pu1Mb7CD6TakLYZUVCIGYu2LMJZZFLEge9Fsh6kSxIn2R2KK+8X
         0Hk5db9dcuLL47Iyn3hbu/Yeaq5qVQNkJC1zDcelA5heqeGYzPq1xjNf2Zp9T3Ss2lOs
         nj1Wk1QagIsbIX2fyDXOmzvWVqOG5UjtpnbGb1k0KAy2Xqvx/ME9Q7TDnfkOEJJpr95Y
         O4TW4SlxxfbTyMoVli4clNQxKDxC39OJapPNpWCG5Wqo/+7IgiPJN2UxN7+YA9pdZI1s
         ozPw==
X-Forwarded-Encrypted: i=1; AJvYcCUntAjf5i6pCV42GwpWvi9yLck0/cIUt/2jM4EN8WKE/s/8FKU6xh+8KX7GiGIVn80iCEeRFqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2Tw39yxcKaKxgEYsjM6NHO4u/Bdo6bwYntBqT1aEGbCjzJt9
	tDQX6aclaKprKV8s/4ocUzXK9WF0Gf5dnei8DrKT03A8yIZETUXgdEX9i/3Oi/P/oSb/YpbBHPC
	ntBrmCuTnRZq+ukIBLmoB3N6j/uBr8Q5o3jKSz7RJZpGBu6zjUiNk5FSkOXA=
X-Google-Smtp-Source: AGHT+IGCPgu5VDqf/or0rvRi+5fvi5mHaUDTFi6g/UotAx5ZrpDq+WzqXhoiqrBWQWgr6NUqvygidm0bU9AuzJFp9eJfOYIlACQY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c08:b0:3e5:4869:fdbe with SMTP id
 e9e14a558f8ab-3e57e82cfb9mr73498675ab.8.1755304203940; Fri, 15 Aug 2025
 17:30:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:30:03 -0700
In-Reply-To: <20250816000900.4653-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689fd10b.050a0220.e29e5.002c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         dfd4b508 Merge tag 'drm-fixes-2025-08-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130453a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f81850843b877ed
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125373a2580000

Note: testing is done by a robot and is best-effort only.

