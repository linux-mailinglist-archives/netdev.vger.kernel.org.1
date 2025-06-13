Return-Path: <netdev+bounces-197335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAAAD8255
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8007C7ABC6F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19D24DCF1;
	Fri, 13 Jun 2025 05:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3BD7082A
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749791470; cv=none; b=aRLtbVCrVPFbgU8036DjjTchjaOne9NQDJsyzQNBr9AIDDKeNF+1LQ58CJBD5A+554No7CXA8fjkA3sc6ew8di+7rwvmDgUB/m/a6t+KF2LS4qzFnE+0qEgtVjbHcREYupRpvxPxSBBy1v8UQncPRJnuBAw9cWveqM9ckzbIRMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749791470; c=relaxed/simple;
	bh=cUvwOLl3mEuX6bXFhiRV8ofP3klCN+cY8uC/h346d/U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z83ExODtEvTSjbgVWkOPwCu8Bno+lBrAP4p0TYA4r5w9nX2gX/R0EI+caCsr8BOmdbvucy6rNhBJ7sF7urAA4gZ5ifdaa9qWTOLQQ+kt4qqPcFPjHhn4giOPNeqlaj45sHQS3wexFARu9IwKyvkeX5KfMQZbn10IGNMr6m8ACH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8754cf2d6e2so177003339f.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749791468; x=1750396268;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nw77KWnxaR6xG40zkWU1KSH5QZlyIGcQ1pTP4BctBbA=;
        b=i+MjrYueKLSPAZskdpKGLdKOrPWTq0kis+9VRT5jOm2HrGCvqEMbbXe05zsHY7toIQ
         //Rg0lI3UfRnxURopMAhX2WouCaCQtEdW66OAwDvB9hVTsWzEly1HGTVAC28T+UOyEDq
         SnbPtYC1qJ2n7/3lR9iLzCjjnpcOwdMS4D6WDmBqktiyLBfVKhvv/ZvcMkcLRQ4vId/e
         WYTJpJpvoLiOaCcI/tn0qoYW9SIP7UGsSDLff6Y21X8n8egN9WYZplWo4HP/oyL4s8if
         tPjLtTIKn5mbzFYEfYU89SJNE0B4LzkxrYCpd7CorWlvgHgZKGEyRLz/VFKrS5+RvXdu
         bxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjIUfA6UmSyvelTD9HBE9Y1xW+NWCq0psnR/LYX2oZ7vUFNzzMBCtvn+2Xkrr+w5Hzz1N1zyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww62E2UzdamS8vgQnRQdxjNuSgfa6wxA+YHiKFMlPScJqEPefS
	NjlSArwZmzy1cppwYMBnYFTb7as+ICwaWp943OILc2bkEcu4ZhppAbr3z/PMY5Sy5ajOEYx3jCm
	6zCfd14SKhH8aqS4gbtb09TV6Zv07jx1prUQsQo+QJA9NkgBUEVzfyg4TxdI=
X-Google-Smtp-Source: AGHT+IHWVnmkvnP7OgPlPOI+KaqLRcddj988eaBzrh6EYBlD2YrWLZz76gr7ACyFRtgGWaQChipknEfOkKvAlLNMuQktm8BzzHvh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2593:b0:3dd:d995:5a97 with SMTP id
 e9e14a558f8ab-3de00bea30dmr16390805ab.12.1749791467999; Thu, 12 Jun 2025
 22:11:07 -0700 (PDT)
Date: Thu, 12 Jun 2025 22:11:07 -0700
In-Reply-To: <20250613042412.328342-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684bb2eb.050a0220.be214.029a.GAE@google.com>
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, kuni1840@gmail.com, kuniyu@google.com, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com

Tested on:

commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c21e0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c0d10c580000

Note: testing is done by a robot and is best-effort only.

