Return-Path: <netdev+bounces-235695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FC7C33CA2
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 03:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5BF4617BA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9022A813;
	Wed,  5 Nov 2025 02:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBD221578
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310478; cv=none; b=QZHCdpwqn79P42E1BLpHCLsv7bQApeJ2CC2H4UGTpY6Y9+6zbl6pml/7nMqxv8T/+PoK8mBzrkDxf+5x68eV21tQjM/jt55I4GftQehRSIxmdnSTJr4BcbsvrAJFiDoaEHumFVXY7d4hmV1FbUi7egeApEYiPG1Ji6NzcRU7q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310478; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/OyvilcA+81/YzUPzx6o1jBrsXtKpjnfUi4dw7oRmmQTqKyWpIAaua/q7G60aLzynObDROhg+bRLXulDHPMKTAuThaqmgRKPfFuXw1OkVdClNVtGiLtsTYK70z2te6Z9FsE1NwCEIjlYTqHpzPY2FUBeMANnHb03/CqbiVa1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433312ee468so4518875ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 18:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310476; x=1762915276;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=pjKo5228T8ehBIgYHLyMcyeJs+S6eGcJxYQRj0NDIaxgObjeOV0hz23BNu+yMXsJxv
         agcN42bp+nI+jd3Msa5onDE4UE7EqI9QGG46vAfynKVwj0XLbrk/urrT8TUBLJeEc8Us
         ozcrcd4IE73XKH8q9Vng9BtTgycd1tfSnaGFVlEMReU8sjN/Nhl58nai4uaGtIsbiHl7
         AnaEfOMzwxn8mzIlSp2Uc/LD55eTc5Gf+r6Y8rzrAnyIrPoNsatUmE8/jV42yDcHEr6/
         cIbYtFF0uykh23XYItsUPWh+/uXChyPF2yg4sTdkOiiQtP039xjpdzSEltfVIvruECPH
         6ptg==
X-Forwarded-Encrypted: i=1; AJvYcCU89s0hLkAnOgBRWbpWSBD9df0Bkj5kDr3ksGPk3R3cSglqOvBnCguodPdJM+Euyv90YDi+hVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgWGKn9BCXWSR/mb18xbruBuAY0ySPcTf06/2jeyJ332dM+qO
	+uphOMiX2yIY+RUM3X8daeZugARTOZ7uoSwjjrIZs/VFV47GXejWZi5nnsDHkWzfOENeeFYpQ01
	d/0xdBU5F6UBWJh05pz8PuQo/OFABAjiO6YXo5M8fKZL+pNgL3R61CPGUpzE=
X-Google-Smtp-Source: AGHT+IHn1I0na2eQYhmDaS+CFGlkJ8/sOH/VNzbZeaDqFqCLaE8H6ck1EwJUU6s+CFz0kzcme98O19W525Aohtw24EmnqhTHwWEI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c3:b0:433:3396:5fd3 with SMTP id
 e9e14a558f8ab-4334013f5cemr30262115ab.4.1762310476435; Tue, 04 Nov 2025
 18:41:16 -0800 (PST)
Date: Tue, 04 Nov 2025 18:41:16 -0800
In-Reply-To: <68954e82.050a0220.7f033.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ab94c.050a0220.2e3c35.0000.GAE@google.com>
Subject: Re: [moderation] WARNING: ODEBUG bug in free_netdev (3)
From: syzbot <syzbot+8bfd7bcc98f7300afb84@syzkaller.appspotmail.com>
To: ahmed.zaki@intel.com, aleksander.lobakin@intel.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, samsun1006219@gmail.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com, 
	syzkaller-upstream-moderation@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.

