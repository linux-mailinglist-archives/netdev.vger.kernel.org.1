Return-Path: <netdev+bounces-128745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6CC97B5CF
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 00:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057C1B2A0E7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC38318DF78;
	Tue, 17 Sep 2024 22:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA4166F0C
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612264; cv=none; b=cSwJmuOA92x6zkEc29ykEKCbbTz0hLKlugBbRY0YZMqg/2v5hZSFrq+sOHJ6oOX4ToWhP3mBmDgakR6uY/+2vFTEg1TwPSA/O6CvseMD5qV3JWib7SrHW17+dm5Edu0KY4x8XgGOZ7lfP7Mxjam4xrlpy4bi+unSJ7Q4MIBNLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612264; c=relaxed/simple;
	bh=aIHRx1WAh0Ssb9wQuea37MU+hqs16wu6+clcJa0mIeM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TDtmPYYzTtURg+2zS5m8pJ6nn5CgbjIiimAlOf0jMi3xdNWvvcKUIvGO7tC9/JuHF8BG/dxFHlA537wxkVIma2OW5HaKS7+jhEBdNo/IG7gjSBtEo7rcg7bkkk0l2TBi/6izlh/EqVoKRenEbQCxX0d0j2fAJkq/8dUVQfgr5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso116418995ab.1
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726612262; x=1727217062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxXvBeV1O30goxwxHgQ2uBduCiUKOZu0aee0Uy9tPlo=;
        b=B5Jfyne713vicMUcRaI6UphDaQ5EIjoQDXV7IEomDJK49wJFGKBpr1/ZWdQNNkEIrT
         S40rhygPRGiGehJKrPFF0bQ9kKgIQhNVXZQ05b9yvNMyrSg3sz/AX0RnaJffllwO0PEC
         75vItJnCaiXSJWJ2aVPxmPE0Z4DlxuBKUhJPDFCyt/Y0jQ9hI3RwyBcYGO9FV9IcgaZ7
         ugTAh7PnQqEQB4sXpb2xYXKQ2BQm5n44NHzcqfPYo/hHFX8rR8AeWNYu0qNPdpfXw7ZS
         ZJVbfeltanhOxBSDg6icpPgmV+kEdjCoYpv3BT30G4zE9dt6N8hWp3NTDy5xni8+uPt0
         ATPw==
X-Forwarded-Encrypted: i=1; AJvYcCWwZyYM+vJAADFwl6D1h85OgGOnUnPvtL9qJpwFQLc1nqJSgOFwBTZv1AZOPR+fqxb2grRBcKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hstxbIFFrgyL4o4aQ2xDaDFyp4CpjHQB0qnwRkPb+o+im2AZ
	wLWcT50Fv5Z5W7f4KCsEKd4vGKQUDhFa3NG+vz7PFovnKAMUAh26jowo1vBHMnQf+eGCH5WzCJA
	ysygZaGXyslN8MNYLfuONopD2weUugvwXmRyFPrzn83sXSnmxYVMmbXU=
X-Google-Smtp-Source: AGHT+IEJ/nUo7tEQDiIzKno+FsLEiL+0en6penJAx5m1i+GqtzIkl07/dRJl99OHLrggknVdei9JpWrBGxV2bbnM0LmLn4Hu/72o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9013:83f0 with SMTP id
 e9e14a558f8ab-3a09013878amr126859565ab.3.1726612262547; Tue, 17 Sep 2024
 15:31:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:31:02 -0700
In-Reply-To: <aa2b8eb7-a60c-43cf-ae70-9569dd7b9e85@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093078f0622583e6e@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, srikarananta01@gmail.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/ipv4/ip_sockglue.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152784a9980000


