Return-Path: <netdev+bounces-143965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7079C4DBC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 05:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048542878C9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A31A01C3;
	Tue, 12 Nov 2024 04:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83072D53C
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385868; cv=none; b=VBFhgKwUrAExY4E24cBWudEGeDENS2sF9EDDyfWe7lOxN8xHLn8TSbaps6I1GHBn6Nh7Db8JleMxaq5Jac2ZbTu6QY1VBvjBjQ72L3KeRzFZ+jwuc0A1gfNcpqAOHkrHTiQPPsLcEWGVbQzfXTTvDne+ouyCqUZndXwq5ixSk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385868; c=relaxed/simple;
	bh=UXtpxBefUNr3VcIYNI9rVjNQrYCyWHXXzZkWnLQ35Tc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gp8829AaSloK4cnez4JMEQ0hZIZ4TdHGfealYVHc/M/EGPN3QxmywLi44V3TAxPCExqKTLVI8F5FX0HL1xskIxQlYHYfIC8XftU9LIrFXtS08K2L8xiS9Az3oFvBeNGZ5NHnjeA3a9KlaelED4Bob53ODOLSbKPAIQaCRtd2InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cb771556so64889655ab.3
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 20:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731385867; x=1731990667;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57INWnZiq0HfAnj9yObF5CBGSGscztNUCHjuo+6K0KI=;
        b=c2x/SQVXmaG/hwALjRG6ysa3K6EIMcwM0pADvrQs1qbWiTBa9WJic5iBxGM1iBlzRp
         UE0CnNVZakfZoU4KiBL2O4quL4JzwD+YlJzveOcnfda+FqWPUbWnW6YZLjBKB34U88uf
         LDWeqKqLpI5E5T9mYMFyiNj4kRjc0HWm2szZIwule2s0yUaQHSF6yBc5rZPgEp3Ior5g
         3KFeJ82aIVETlPgjmAmJcNWhz68gipBPGc6wcVjsnhz8NdCVG3fuFxTCrFh+Fduzg8Wo
         C7hl+gjrG73URul/NbkB+m/pwehUCHdMlksRV7FkMVtYegQ8JVGxcKOWl4Eg2BnFi6it
         cFKw==
X-Forwarded-Encrypted: i=1; AJvYcCWYg89E4eDFhvH/SySP4H67xzO1cvh4SgRDStzqywZATxVyYapElZCEpZUtTHjUVycN3SLuHyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsUJCFTH1vMNB8ACTCr7qZgkOFTBLLgLa1yRiJy3IR9NTYJjn
	sPlz18oBwq0YHSV+J0Kd9rZbpcIK2VeBPXYSjH2P63DK/6Nezub6piwy7D+5z5CYuVUD/NiVwau
	9ATXuY3XbGCS70WNwwxfjW/a1+w5bFiVk1yZ6SIA7REG5biaJBTWpxMw=
X-Google-Smtp-Source: AGHT+IFFUDjXKPivqzf1Tpm1sYMybaBdZY0FjaiXxICZysfVPEn6SL2GpDXPpaOREbFWte39HRrYxumuNBSVZgs5bBmZdVwHU/rz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3a4:ebfa:2ac7 with SMTP id
 e9e14a558f8ab-3a6f1a0a674mr158303905ab.12.1731385866731; Mon, 11 Nov 2024
 20:31:06 -0800 (PST)
Date: Mon, 11 Nov 2024 20:31:06 -0800
In-Reply-To: <20241112002134.2003089-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732da0a.050a0220.5088e.0005.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, dmantipov@yandex.ru, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lizhi.xu@windriver.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stefan@datenfreihafen.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1608335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109ed35f980000

Note: testing is done by a robot and is best-effort only.

