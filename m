Return-Path: <netdev+bounces-90323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B38ADB8B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB50C1C2127C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430317C66;
	Tue, 23 Apr 2024 01:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162B168DE
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835866; cv=none; b=Mj1L3I6k+CTXyvxqe7nfQmmPUEd/1Y1gfpQPjgBFz31Q96IOaL9i5CbuOlijTIhLAQqnGL1AE8/dR2n2HNPHwk381HRaWJvl9XKIbgGp22pt3zD4NgivS1ffi5boo40ibYn5dXODZwlfT7xkN9BOFwCfDyh8SvP5XI5JwAl12oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835866; c=relaxed/simple;
	bh=22JucIr333S5hWoQojYq8sDzxWaVqwg8jNiaohfDBE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEwopCdwFc+/eYAYmrMN/jK2z05rD1b1DECNLpRCFVUgZX+IYHFKp84+BM7EcoAgKd7cow2SXZgN2V99GOwT0Lz0SHfHhvF+xyQvlC6jufJZyB/xaJqBn+tfsDUfNYwZFF+d22PJ+kWJOFSAz1MuI9J6V20/Fqo+sY5s07vhKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dc08afa8c2so104601939f.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713835863; x=1714440663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3oNrlg/tZ0pVKzc2WrDO3+pRPfzflWiDsR/M727fk=;
        b=ZwQuNdKpjLx8fcV6DhkyQUf+Y9rhrRodzQFe7ka3mdLfi9wJ2RqQFWp9yTlDr5R+Dm
         iP33XuFveMET9Z489a5DGBsxM74K2X2VA4yUzZDO7dGwXHFP2iffS4lMOi/5DeQ3IZ+X
         7Nf9ZWQSxiVq6pGVQOukcZfZFDXEgqU8M87vTNm8XgK6pNlUHYEIrneZtcASPDbharZi
         w7XOb187T0d0KdtmUUf0va0BosO02VLhfywReI1chTBgsQVhDnJwaNtEJM7hz02cMPDu
         2A8ogPfwDjQsteesHa15ooowYguDlCk95wT5zOgEpa/cMKmqXT3BkGpBbYru2e0JcysZ
         GApQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW/jsA4xD1/gue65nXVUmi4UEY2asfXHLyrY7A2y3QY8qq+eMKhYBwifrrlCW+136fLoeHa0ieF5A3+aq+kPOce1WawGHy
X-Gm-Message-State: AOJu0YwZ1Pyz9latLAi0Ug273JTRlOkmO1K4NeZAYbHEaH4WhoNk5BUr
	aFZOdJT3sbKDse+5px8JGTq3cF/mQAzTf6ESvb4MyG3kPfoFfmiTMWmLhp8YGaX9WWeOP9ptORJ
	8QlqBM/bLvZPSRl9iKsmKvCvBXlKS72JWuaF5bJ0KLXLiCDLysu44G4k=
X-Google-Smtp-Source: AGHT+IHodPS3M1cJI0kzh6PKVQhHFuy5lI2gp/FKCQIK5MUvSHRJwKXkmGBl7t3+5hguQZybcRaW0A0Oqr+8oMCpedZQCN1uEESx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:485:6cb9:9a79 with SMTP id
 ay38-20020a056638412600b004856cb99a79mr103537jab.0.1713835863671; Mon, 22 Apr
 2024 18:31:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:31:03 -0700
In-Reply-To: <20240422101622-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db97ee0616b981a2@google.com>
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com

Tested on:

commit:         bcc17a06 vhost/vsock: always initialize seqpacket_allow
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b58abb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

