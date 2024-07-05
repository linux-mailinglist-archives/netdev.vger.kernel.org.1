Return-Path: <netdev+bounces-109439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26CE9287A9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE37F1C2095D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A2149C5A;
	Fri,  5 Jul 2024 11:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AC1487C1
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178285; cv=none; b=j56GDE2dm9T1ksUFi8u5NNjOtVYoe4MxRD2ncIERTMwHQHRSSkP6Z9hrBzjQXmxkvvGWyIuE8BEsZ/p7B42BaXx3xkdIgzI4RvVF0RpDU7FYQ8epqh70BAJNfnF5VA2PFgm7B8R8Fn23VyCyJAJkQ3DOejmsT4kqB1GbWSls28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178285; c=relaxed/simple;
	bh=DcEvBQzYn4eHzbpGBy15PzrDsQIOG4YC35uyd6YyNUg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CoJl8pv7+FbjChP2q267M7acd8T5sDosrMs1B12px6Om84l4YHzHGDNzhxKu27yb3j/6p9+MX73PYwEfE70q5ZM0irotDLQ7KGPGZOvA/xEeYsHN2zwHUE30JXDX6y+oNUYfwkyChoRPahrJADNHh9+h6xZBfp43vPfGqwJA87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f664993edbso203570939f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178283; x=1720783083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcXD0BG3kuwJsqIbgzDKmojoQKPo+GlBR5V8khmyXns=;
        b=IzLRXL4keIAoKP32MCRVylr93m+AjQZ68MZIg+7zOeugH043wMIR/5G6Zy/Q3rtA7g
         Un0wROPMgYVS/LE6QAROsvKL1oum0g2WcV3RjMOneFetslfg+lniCa2hIwZ40aJOmKhF
         0FmKJMwAgHGuR+s8PabxI2+1EP7CWKl2ziFbTRs0ulDkMbNKYKs9EB6QuZK2ThiqrP2P
         xX9BufBHWLKycJHW3aZf8uXhvaTKGYnCuZ5dDYd+F8Wu/pwoOKOqOGMK6mHoYsTNuqoo
         DS0T+fZHBgodVmEzcmKeqx9Gq0WWeEJhTjCFwr6TJK5AUIwOChORDMKdU97fd1Z2VmO5
         y+aw==
X-Forwarded-Encrypted: i=1; AJvYcCVSk8RvwKa/Ek/gOkq1qHi7wZmv3tHtcxhzDs0SIO/ptmDWUE8lEnJcxWXlDLYRfK4PCPLcA4Np2XFbOhKQ/KsivyvTt3iJ
X-Gm-Message-State: AOJu0YyVYkjc7XpCBSXmNxJOFo6/tRhJYe4Ez1Dvh2fHmbp1TicVmZ65
	ZXQp5mxGopRh0lkIVnRQar424Yeq4gFBm54ITEsa+gfg2PH8xy+AtrjwrXBNz00NAG42LhLYSuv
	/Lrrz8t0URjautur0C/Iv/PJE0CNFFhJLac58072MDyT6lumRjhceLaI=
X-Google-Smtp-Source: AGHT+IFMVpbI/oyUD/Nzf6SMZz+ORuXDMuVeo/VwepvtWQMChUOmoisakOynndWpToGIlO7sv74oPSteHwMvhUCQGIieG7LgFupM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ac:b0:4c0:7f51:c3c5 with SMTP id
 8926c6da1cb9f-4c07f51da77mr85862173.1.1720178283056; Fri, 05 Jul 2024
 04:18:03 -0700 (PDT)
Date: Fri, 05 Jul 2024 04:18:03 -0700
In-Reply-To: <20240705104821.3202-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000832194061c7e37c3@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: fw@strlen.de, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com

Tested on:

commit:         1c5fc27b Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152db3d1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1395cd71980000

Note: testing is done by a robot and is best-effort only.

