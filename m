Return-Path: <netdev+bounces-197317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901CAD811C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194A316B54D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0124677D;
	Fri, 13 Jun 2025 02:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F0242D98
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782406; cv=none; b=jDXuj6JguiYpmuWqgKvDgcvtJ+h44oCTJSK+7a1GQ3Je/aDQsJqke6hUWDTj6HmUdBoy5aUrIMbG3sYIohDpORM0VPxzv9RptUF46VvBx0qAN2uLzsMdDQDFbeGCSRH9pO/6Ghlnqc2OyX3GO02uBbehViZWS3Zkues3bQdOjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782406; c=relaxed/simple;
	bh=E97w1N1Bih5T6H7uKEn970LihNn6kp5QuVS56TtF2cw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XuxeY+GXa8qD9xMxT06yu+n+W2yJ8reuPauh/BYydANHL15dSHwI7Rr1zF35UZFtuBWL1lPQM/7MNjUPmzUXbE5PU+Smx3xwa3Y2MQGZZhEn6Pl+bwMSbKMJ7NELqPlB88fO6/nZmmkXF4BXdOyMT+nNTwLUULB3FDfrx+zCnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso39587655ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 19:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749782403; x=1750387203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEQThB/QZWYATXEHZtIzkAUfqU170wP7qCTpelfegTg=;
        b=aCnr7ozoin2LoMb7KFbMpiblnxJIhG4OfLHPCbfEatlzKw/dTA8hd0oDmryLUU7svA
         CwTW6u+lJwiDQyhwc9GaP7kT3LYhaZbbFl5V7k1ahxI25ahsNlL0JFnwW4NW59d/UTyl
         wm9vl53UQuPia9Vv6fh4Cd9M/K4XV70OSZXBWl2//H7Hwq/uZHWma6/K17WZCMd4UncJ
         GGIAGVJAQiYSycW7oVK6HwrdWQSkkwgxHVPVxGRVM0nM6kd1KgoDLjXwMbik1lkf/37N
         dCnVkKuUOzzV3aCyPBIfn/+1sUUEdfDYpCZIR1+m4iPHnsHiXNErNbkksMV8vou7WXqR
         drfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf0q7oMJLS/bvwFEOc21YYb7Lwk5los2s5X0ZkiFuWj/RJlrpNs0as2GJSq/R7KGaOy/Qjvjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRUqs5zUW2BcQ62te/MLUzlUJ0zRC5GyO4XoHhYcIhT1kWsjl
	02l96gYPuQXvzJrg/gysJqCjJc0umlf+sg2LL1LUvhdONENWX3fae46Gw+nBp17NuSNHvhPIFi/
	QrjgDudygSVo0wQLymDbHlW4oVtw4qm02ImtGqq1qaHiFOmD1C61sI/j4Le4=
X-Google-Smtp-Source: AGHT+IGGk2ews5bjEXEz9NVZoL8Fs9M4uT9iy4AWHWcnfKyIC4/gMozcjos4QyhO8bjyDSz8dc4tQ6gCWLOW6CvFJ8llBR+AiyF4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:3dd:b808:be68 with SMTP id
 e9e14a558f8ab-3de00b9f6b0mr13853405ab.16.1749782403616; Thu, 12 Jun 2025
 19:40:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 19:40:03 -0700
In-Reply-To: <20250612234950.40595-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b8f83.a00a0220.279073.0008.GAE@google.com>
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, kuni1840@gmail.com, kuniyu@google.com, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/atm/atmtcp.c:293:24: error: use of undeclared identifier 'atmtcp_hdr'; did you mean 'atm_tcp_ops'?


Tested on:

commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1183ed70580000


