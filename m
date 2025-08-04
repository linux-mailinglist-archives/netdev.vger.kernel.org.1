Return-Path: <netdev+bounces-211622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0AB1A86E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0370316E598
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F728B418;
	Mon,  4 Aug 2025 17:12:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0721C18C
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327527; cv=none; b=H9Vxr7kGxIjaENHHbQxSOUnvNk9X8B000N/ndRjMMHrq98kAT4znhgdSoviKJl+WTuHfiaU11rDIe+ZLtWkHizI9PmQE4CP69CSWgbzZ6XIyO4aWoLF5eOmR20iKym6BzorsF4R/NCqZplBrThiatu/KJWX6LONIHs8qHGPQFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327527; c=relaxed/simple;
	bh=jDpBEoLfJLg9TqVGHMxqi8W/lOa5wlDa+Cxrc0dThmM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FnLoVi5gMiw8ZZ0teeDFbUuNJ9SzQR5ygrOuaSjqbseMtPYpJrwC6d6WZXvI7BORdkZqxHE5kX5ZYT6sqOWHQ6K0WkkXRCyZslKeVtQnksw/SUfjfaDxJ5WxJ9ZJkW/DXdpTkKPdtWh0xU9chvq3i/38YiXO76bDwHpfCVdE4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so42400015ab.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 10:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327525; x=1754932325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhBvl7iz+VJC4CiSokTX2+c4voXR8HDcpdVyTYId1Fc=;
        b=QZY2AY/lQVqM4ns6FPgdce/HtI4UlwahzTJ+RzOMStcm3ixxIqWR6EKVRX8e7dCbYc
         F6j82xcWFix0ULPLmniL/cBBSybHyZ21C47auhys4R/zt3ZRDrp78g1Zs6sngoH6nuy4
         8DVZO9O9WGNVhd7d0+dzdD9/gJ5HAJjiZ7F2S7guJh+mXrUig9De36M/6ZUrUPS6HGgA
         PrEPt+HwISx4WUVgxY2KP1TBflC2pTGP9RZmJ/apupW0YD9FK2WSJqeJxQoNw35l1e2y
         a6tf+uhFXJV2j0EA4cqpRKlfL4LlrTCOHkMjVd7zexJb1vpNHQxeWDwr+8dGZSV7SdjP
         ozJg==
X-Forwarded-Encrypted: i=1; AJvYcCXGf68RaWbqGGarUlKfdOau/8iHokSGP8X7ev0/cXlaNY8nrkCJ3vWwgnrfrK4KFQ39zBDmBBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+X/V43yyMu+bV1dI6+pc0KletgrsgAsjzbo8oXXF6bGkqpG0o
	wiSPUBC6stlFMx8TRykErxJf/MbUJ6O+7xkMKnJp3BuCJk636M+0d+DEepO3oRrl8PUM0jsUk5i
	D5kyo64Nm1b45zrvz/fz3h8sx9rYdunpvduUC/fHPJ3BJa7bEgsTsJd9lgZs=
X-Google-Smtp-Source: AGHT+IE+SKpu/FvgBMpn8lo33FeTbVK/4xovIuT1L4gu42wiX5R6DCpseuD8a6Ely9yqVRdx8660/OJX9ocSrZq2PfpBNyc15cZC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:3e2:9f5c:520f with SMTP id
 e9e14a558f8ab-3e51037e02dmr6379235ab.3.1754327524968; Mon, 04 Aug 2025
 10:12:04 -0700 (PDT)
Date: Mon, 04 Aug 2025 10:12:04 -0700
In-Reply-To: <CANn89iJusO-iDNtUYQKKy6mmrZVqkJ=20_w+RavDup8bmTJ=pw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890e9e4.050a0220.7f033.000f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/ppp/pptp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         5c5a10f0 Add linux-next specific files for 20250804
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151dc6a2580000


