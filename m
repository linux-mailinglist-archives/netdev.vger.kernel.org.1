Return-Path: <netdev+bounces-194456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D90AC98CA
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 03:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305DE3B1766
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38029D19;
	Sat, 31 May 2025 01:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856D1F92A
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748655185; cv=none; b=eF8hMb0oyExCpv1zSoskTiSNWvvhcD7L+bO6soGZxJb6DPAwPnVyfGvJjtiEPOICtrVmKzZGHHZYzgfy8+kvdv4vdo1Zb/SFHrskoAKM9tuEO5AN0WZ2lB+eqplVOrr7DDYwl8r41TafKVrgGmLjywtwvsazkKSFl4pDSqLSjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748655185; c=relaxed/simple;
	bh=8AXhBefoFK/R4XBK96I+XaEw80nCTiWICu0cUz+1J5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bbqgauBK2LAuQtUYKAOv49sBY4nK6oDU1SrwjEjG1IdRe3idq6wqqCTEwq9AfWsebSJzC9kVxfvriaMA1sQg7cvKKrgwjdW9a6byRnpVHemXd7kQlsTeYYDefk3/PaTuJNtj03ynGFGqlvFsUMyqRDNomi+78ZEW9wNxajlpl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dd78bfeac0so27366095ab.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 18:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748655183; x=1749259983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrAooAO0eA9dkl4xsiBOdhOrw7MeEo/UVhjo5DU+RhM=;
        b=M7RwW6bOJ6Ntq72rlE4uqvldjbkuZt7PQ/CZTaeAdvmrtFlTHSl60kXZPI1/EdPfLE
         QscGYXP3p/QMxUqcL1g20STzC1mhiJOvHl6oz2zwl2UGOzmPcc6BJbW1L1x9FKDW+Szx
         lgObLptOkmyTxM1H1z47vFOJCbrUV28EVffCSgtgJaObhQQcaLPjbkMscCnCTbTtGwCc
         EhS3JkcW+4npy3MnIhtwjG1tQonnONR/b99ZxtU12m5uY6p0Lx4m0eTqMi+cyBTJn+z+
         sUkTDBnAPvfAqKgCD5TZvdphkfNwAVsItbs36Pl0100DGRGteVUkHOkREUiD9ekFxHSb
         QZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXyQJWrGpqX+eK0fOIwXY0+uf7Kxl5tghCrlARVUDSoYisDQKysJQ+NZW59vHD3skqWguC4QH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcqZpE/aoj4GmQVQAkSMhVI99LgAKWVn885bxdFYadixXb3Uv
	J4C6IOJfNcGpC7H8IGPv4MQlU+Z5p1NbD0JHhX21G7Pa68/3/Jm/NSWvRLVzUNelFjfpl6mD0u5
	SKXRwNMxOYhEn/9HQBKm6BfwRNz8DnwHI+SS2+b6OofY0bp6+4+mYMpYwChc=
X-Google-Smtp-Source: AGHT+IGx4jTzgiH+6ygy7tZbN+oY9byRGDtT48Ip+NBhJ4baZT9lgdMEXUTOuy6g36q5sW9IXOeLgCilTsf4anolmqp0Dg2t/s7e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:3dc:8667:342d with SMTP id
 e9e14a558f8ab-3dd9cacc967mr45817895ab.12.1748655182810; Fri, 30 May 2025
 18:33:02 -0700 (PDT)
Date: Fri, 30 May 2025 18:33:02 -0700
In-Reply-To: <20250531011248.2445-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683a5c4e.a70a0220.1a6ae.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_newlink
From: syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, jdamato@fastly.com, 
	john.cs.hey@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         0f70f5b0 Merge tag 'pull-automount' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15927ff4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a01551457d63a4b
dashboard link: https://syzkaller.appspot.com/bug?extid=846bb38dc67fe62cc733
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b8ded4580000


