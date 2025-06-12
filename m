Return-Path: <netdev+bounces-197229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D83AD7DA5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B011B18909A3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E922E3F0;
	Thu, 12 Jun 2025 21:38:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202C2253B0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764288; cv=none; b=ND+BYnC9M3bPqEyQZqg/gv9LRad6xbFmpBnQJ4tImZcuvHRJW3GlejLIhJeMtOd8Xf8iRAozHwYq8DsNodpxAey2rxorB6m9K52JCZOtxUkTTYpNK3aPTl+jBLnAuru1ey1kwSdKzo7DNRNR2ve14rz7g1FuCIlKhEMWcyE2CTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764288; c=relaxed/simple;
	bh=ghXJGWovtlevUxhJ6b02bvIr70MGxHrQEahbVyzbrUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ENeY7yh4+d8joKkcGHkfFTxpPkZgndUHpNhNq/9+oriEPVQ347+h849GvrcswkAUlLVk9PwInoWUmYj/crpHciTMWR39Yx5blkZnsSDVsBW1NodDMoKUGLoxdx0DmSUDSZz1v9rB/1N89GW4nZ3UbpR203o1dU6fjhPvWh7h2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87326a81ceaso235141639f.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764286; x=1750369086;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEPUJZD4frWaLI++xX7CIld0+KosWT7GVS1O1Tac6wg=;
        b=aLSIbf9LhNwNodg8a0wnwP62TQivTN2HzuKu63MCNigxWny6JcHo97c4/CY48+CEOc
         veZdPzL6FaWU6B12qKY1gvaA3IqOW1QvpLC4plgKuU/tz2WZfmkSatTOiLqpsWE7zcGl
         OxRn4cVwqjbCequru1AeadiZleFvU9MZCV/KSWBBz9QOqUWKNKSmMos7Cd99QWQFLnEu
         LtFOJnERXUZXFTwJkrDFTKOldGdi6apfjT6TfBcn7yP5n9Ov2zSRmUw7S95uyFQYV8pK
         bQlAOj16jyK8/BWZZED2R6uTqcFKvYSdIYlK9b4WF7PmYWqNG7soTsZKEU3yjlZzqvD3
         9XGA==
X-Forwarded-Encrypted: i=1; AJvYcCWU4LFdiNzR/VqMS90citQvDA/NeVXOd2BdWPDSNMLtcoAi+ik+HLaFeZls8m4Mr7TIYjDteGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8FZfDyPU+51bpLYugEVasMxgeoR1tZyXhoiIKBgo/UNulKf8
	7hkAeykh6tI/19dTl49f3SehA7Wq+Rk2mq3JimypYZAm7LUIf7/XrQPOLwN8SYvRXX8ngW/Ku3X
	YmSjCl5li5yrG5DQu2SlFLjHo5X8SAIPTFI/0npMyxFrc0mP7HbABk7p8Ca0=
X-Google-Smtp-Source: AGHT+IF+g3z+jimjn66TfaQax+CXm+mlRYr8TXr4NCKN/KCdEPYOvVhC6OITFg0tBDAXeokvhpFRmFoDLM7MgO8PxvmHpu81LDA7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3605:b0:3dd:b540:b795 with SMTP id
 e9e14a558f8ab-3de0167404dmr1585665ab.3.1749764286354; Thu, 12 Jun 2025
 14:38:06 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:38:06 -0700
In-Reply-To: <20250612211610.4129612-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b48be.050a0220.be214.0292.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfs?] WARNING in remove_proc_entry (8)
From: syzbot <syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com>
To: anna@kernel.org, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jlayton@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neil@brown.name, 
	netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com
Tested-by: syzbot+a4cc4ac22daa4a71b87c@syzkaller.appspotmail.com

Tested on:

commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1033d9d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c8362784bb7796
dashboard link: https://syzkaller.appspot.com/bug?extid=a4cc4ac22daa4a71b87c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1143d9d4580000

Note: testing is done by a robot and is best-effort only.

