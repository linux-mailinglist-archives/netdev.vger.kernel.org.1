Return-Path: <netdev+bounces-230755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81831BEEB7A
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404233B8CA3
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4D2EA49E;
	Sun, 19 Oct 2025 18:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5452AE70
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898724; cv=none; b=ZaeO/RNA6/v1xSzRyTPLrECPw49c+MQ86fZKvJYAvuESJZK21I+NZ5/lQZ5MBSBuCoRjMgDIEdAis518NP3zOOdG9ELimZSFPc/yvmvMkrt2FvmcZNB7g6wjhy4jMa13MytmSRWp/FkCAFu3qBaqtkm4JkbePRIrgWOQgwAHLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898724; c=relaxed/simple;
	bh=HHeb0jR6aSYDmtoEP0JmvDVwW3x4j4N6RHPTjew9aME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T/ygIG3REfy0yf9dhz6Troi3hj9o5gNwqAJp2qnFPY0hDi4UvBs57JmRqF6yFQxtZdK0J1E2P74usQU8Lv6fTinmPzms7HhclHbK8VMoQMwl0LOfltprv+xch+LM9WuF6BeuDe5We16O2fht0PBwixRgkYmaIStvImecNkWbSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-930db3a16c9so338492639f.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 11:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898722; x=1761503522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFwXPw1e2ivlGMUj1+kXUajiusWa9Irps+eBbbnlApk=;
        b=S6eDwrrsnb753X2uXbqtRaIZYmThwyN7v7NaCpO2bO0kYgS0tmYUi7mVbpVXNpL+Oq
         YIbd8NVnqz1L/gcK13Uh45dlzVpKSANcM0P75aX1Bagl9/jPTR1ToK4iZ3pxXr/G0NPi
         wRKWCH/2QTZ7ibaOWJAdq8sUENNkrWOc+E0iqwYIfJ5vLrCWeKEjMIr/y0yP00dwsRi3
         24WTYPHrcWxf5B5vXfRaHQXXetaQUETke9MrbC68YJJF7ZLqw9uIiYel37qeOBOYi5SZ
         J6AI8KVEePdZjPqKgVdb5blTDRVGBIR8PB6JcJuxAPWlb3LU281YNPvTrHkGt7qrznag
         fibQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCY+pmrcSH03dLOyYD8UleGgMjEgiJDw++3vUn/xkf1Sw1odlJcHYnBIEBVCH4aipOdyb3Ch0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ddrdtw8ifGueWp2CTvzeWLnAmWm+jC6DTwGu3qssLqZY98AZ
	55wpEe/K0aNS/BQEngYYwVarz1YWylPQL5AtZ2lntEAtnSaxs45tFr9a2W3RaEF8N6eyLI6jyTx
	ErD+mzTEegUSbOl9YSF9OxKXiwVnmsdu8lewdLp2NZl1VY+eDWcYerpceN2c=
X-Google-Smtp-Source: AGHT+IHOwXOriawi4lwzabE1tV9DS26wydGAP96MbDL5rzpwJdasEH2aOPdeeq76yHs3P5mDN3ReBhya804ISZ8F8H+fKi0/VSGb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:5de:b0:940:d779:82cf with SMTP id
 ca18e2360f4ac-940d77987famr197390039f.5.1760898722104; Sun, 19 Oct 2025
 11:32:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 11:32:02 -0700
In-Reply-To: <ac912e45-9267-4c0c-b700-dd1b602ef2c0@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f52ea2.050a0220.1be48.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ssranevjti@gmail.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         d9043c79 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16621492580000


