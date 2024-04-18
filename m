Return-Path: <netdev+bounces-89358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5F8AA201
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE66281CB4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8A17967F;
	Thu, 18 Apr 2024 18:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E916C438
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464838; cv=none; b=quMGJ93INhLryuTyc8rSAmK5gNjI3Nl0NvkTAjaR9MU2WPiSX9tuTXqkt/gJNSVZS6ppx/zN1FLCU0telsDQQScTA2wQnTxjtayPWvSWf2cczqCd1wKzVgUgCAB/0UN6zs7BnUHvOtqRkdw0FK9FVqsE71T1T6YqzhpK8nM9RSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464838; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sy9thJRM7u4SZ6aSvck/FQVk31OGjhn7BrF9WcXxYU2fafYx6QpcY0ZWY2S84Bp8+kF4x33di2dY2Wcb9cbQmCIjCE/qU8libggyAWgcg39hZXBoMs4rGmGi0ySIEiOldvt8M2YbDF1VCr3Ov+LEaO0cjtANZyGjcXOe/RoSJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso148842639f.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464837; x=1714069637;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=lH+Qaynkaj8pJ6YBnO63UGdUrDcAwxdRwFQDe6XeiLlE1khQcZTH8A9B7G51u7b6mF
         OxnYj+vOBe37mllQwaXJiN/WSXG2ll9mhrEB96Py3dIAybs2JKZ7GSeGzgQqwXBVxcri
         sERDqdq7Zmohr7vpscDvsg4QDPKcdARAmsf1rfnmFVKSmPuzvAgtRazPZzycjC/WkXfk
         3TBLgWvLwAg3xqTlBLS6L7LTjeJj8CWParQXTMcZesXQTokgboUvZVdT0xvBIFmmyieE
         e4Yh3LTk8qoHWXEXoTQJCbjIUtkSUMf0/Gf9Z4ivumUyAfPbfChjj1Sa/DDnkZR5LFhP
         GYTw==
X-Forwarded-Encrypted: i=1; AJvYcCUm7/sZazbWhrwhKz1gD8EDWsiMNAEJywOR1+t2iROilK9Gyk0R0WbAsGbq06F4Cuq10yohLQmUt3fZ+kzlUjWZCUIvE0xh
X-Gm-Message-State: AOJu0YzAQJkAAPUbySBdDO0YNEEQtLbi1bdoIGl4tHTaTENZMD5LlJbO
	CkzzKaJG58MS7N36FC9swWVpwneIblF5rhHApoaIRH/ZEW5/ng1vYNjXiAiXHDycWDUmKuFIRKV
	nw7ali9eABsOOhyd4k8xydvYcXxX3OOlmNlYMAy+9Eq23tSo3vwD8icc=
X-Google-Smtp-Source: AGHT+IEzDA31gc0F9RRvsZZF/gSZWsQm4Y6V2uPL90Ae6Iw6pW6GD1T2cNU2+K7lft+xRk0EoqR8YaFFWMJEAeNWAMQhYQXxDrC6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:36b:214:bc2f with SMTP id
 dj7-20020a056e021fc700b0036b0214bc2fmr165289ilb.3.1713464836829; Thu, 18 Apr
 2024 11:27:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:27:16 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef47400616631ea7@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

