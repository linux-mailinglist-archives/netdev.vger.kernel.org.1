Return-Path: <netdev+bounces-228475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FCBCBE7B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F91A62BE6
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D202749E4;
	Fri, 10 Oct 2025 07:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AC26FDAC
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081048; cv=none; b=TeJlt8NdwCkNaD5jdVIauNydqFVzqjRtEalr05PHJCV/ufwKg1djsGI5bqz11UXgHEzCEnSf05DzGpMM5w+UePrk+X8O2E9SCEDg0Nocag2/Y4vW//WBuHy1d33pq+duCIBo9mo37VG7HPkRzbhX0g+Wco4clFVcUe83emJetu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081048; c=relaxed/simple;
	bh=Jg+d4M7SD0tg1BCcESORZKIiOOrCQxdG8BTeosz9N8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qgy6B7YZlOWOIhmD2Lp/oNx3bX+XapAuTH2uCwCDJ+OMJI9m23EHRF30hwi24eevl83J2ko8pMUhp4JuMDouk/ffLxdk9LdrUogtUbMFeHtLekRVNJGfcb00DKcSDxHPrAOmFAG0h+JcPusSLHRlENUAfNUufxNsY/g7Rfe0Stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-927f4207211so578884039f.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 00:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081044; x=1760685844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85c0lO31mJmxX7OG2HQ6romLReQO9OCVh5cFYAjQiA4=;
        b=iV+CU9JyiUYo/vW3aj9LiRRvHg4vY2Ss7UJQJ2YleHxrtlPj/HYJ+Cc6iNxQiK/QO2
         IgdkvRqSS/IwBHTIcXXg7r7x8iPUqXCmOavU/m6AFJdDZsXTqVYc/1kTxqag+jnvHhvn
         TIdPgnQ6AlFhcZU7JmesVs8ksTXXOojZbrrY3eirh57t/bCJ9Gk81wIGmR9pakhGNSxf
         tf1pEiJfbGvb5xz1O8KD/qyLKuKJ1CS4a8WQC6IU9jklAhFe5/wLG1H/kZQ29MHmn9aO
         lUvtteA7SW2bHSFB9g0qwQuqcRjOKOjGGQt0CnRWqRmFGQNdKeDY9H8WhP13clauEAbK
         lEFw==
X-Forwarded-Encrypted: i=1; AJvYcCXJyhbqhEJrP/Z8c0LD7A8Nr06ZGe5cS+R+MaK7ApnICF9or3JoTMNvhHZCZv9g8CYRLdBxVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjhgJOWvUr170c/QtF7h8OZcyhnn9IDJhLAX6jLa3r5tla9An
	UlPotTOcF8LqoW3EC0Jp89Z8P3FBStJfTNG/6sH8zTismLDETB6y/ST385barDserZfR2pTHIwC
	72F4UQfTh1l3Vy13/yDRE/lnZgL7es+EhPL5c0iQOmDD55nVHJUs1hGuGjRw=
X-Google-Smtp-Source: AGHT+IH9YdmnB2MPeJu4hJxqiBrxo57sGfjXN0vwjr7W+/+/+p6zwPPzsFWiRrpzBzWe7uajTaaIEEhiQD3ZQbKbM5mUjQccgD7r
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1514:b0:8fc:2095:302b with SMTP id
 ca18e2360f4ac-93bd191f136mr1284776739f.16.1760081044336; Fri, 10 Oct 2025
 00:24:04 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:24:04 -0700
In-Reply-To: <20251010033310.8501-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b494.050a0220.1186a4.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __set_page_owner
From: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
To: ast@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com
Tested-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178251e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120851e2580000

Note: testing is done by a robot and is best-effort only.

