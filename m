Return-Path: <netdev+bounces-223835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE7B7D0D5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B01321DF4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 02:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDF2F39DC;
	Wed, 17 Sep 2025 02:46:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDD288A2
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077166; cv=none; b=ALIqNleA2xplLRejEEpGx/V7X7kYYDaL7jPBpTNm2+YDKCJHjUgSuTcX17aXGuO0gSF0PlGy7rt2b8R6r0/eJsUxEKsMbRnan2I6FN7XJmrY2Bp325xcdLtMMrHjBJAuODrf/0iBRAle4KerpZFRD6ZiBqMsV9IWLD9ikzYLnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077166; c=relaxed/simple;
	bh=ajMBj6W+ciqqQBnUackz3l2ePoV67IEOqT90PQWj854=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cmQ1m4IhlQZbeTJ8jSf8NpxJPpl+VQrmbuEOuxmPyffqUIjYgvVozXNImAbt1dog+xQ7DaPgvyb0swm83Wb+JQRAVdQhiSOQLCv+dKZvA5sxkK5LZ9BVttz+O6fahHPOxdU5O9dOOREYNNpmHN5TsjsxqHsqHGKXXgvH3SXsjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so595796939f.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077164; x=1758681964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXr93dir4iArTuEqabwmLHhqxFVOiWIYvzd2a7vrolw=;
        b=nMjoKCANk/fgZLk6xxgBaLI/6sIbRtjJ+tIyrwMl7hLNdKiCoun4EM1y1QW+p8K76r
         qYMQ17OnbL1UuIZzZ+piPBffB4k0444V6o/R46wuUOXSd590vhilrnZTd9nx7VDnpjRa
         oMNFD6PG3S45DF6jp1Gc3ZfP7iO9UBPpMUaMMyV/p5XuBWz3/T2WHbOKjo8/H+HShtt+
         SZ0/pb6tEGWr+sZSCfyck/LtgoeoUDqWaOe+K3YHWqLKkJpnBcj8ckLIFl+Zx18A1VNU
         FFRldhTeWt4NtMYiEEibfXrSy7G4xD+yILV3lL/sIP/8cyttR9tiTUPQnhJgQz4YCl6r
         o+bA==
X-Forwarded-Encrypted: i=1; AJvYcCXX/JEOPPt5Gp8RwBcbZuWnHy9Q/s9I5xKoTzTMZSDKTHvj3vdpHEBIqzACfylYN+1evBKKPDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybI7g5OtzpbgbUBEqij5+31V+MsTCacUJPd7bTElG3qVF6N9Gj
	UfhIQ9r6WJtTJJlx98Db17gDF7tcCJgygVWKkO1aUZ/BeMk282TcMAw7ZaKNa/vNQYBGPx2y3On
	2WnLvoNtlwb7Df/7RduZIUUInoOovCLzRFYU5AFOwqG660OPqKHkVDwtwFK4=
X-Google-Smtp-Source: AGHT+IFT5F3SOVBYBfpTEN1r6Ryn4zXzRSfOjTM0hOyB/W7+O9YdgM3mtKGVFhjZgYGArN1kEvCJtF1uI8n1FOmdeBD4UX7+lmya
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1355:b0:88d:3818:afe9 with SMTP id
 ca18e2360f4ac-89d224fb995mr110124039f.1.1758077163875; Tue, 16 Sep 2025
 19:46:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 19:46:03 -0700
In-Reply-To: <00ce3ed1-f2a6-4366-b01c-34cd6a45ae87@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca20eb.050a0220.2ff435.04ad.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in napi_gro_frags (2)
From: syzbot <syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@redhat.com, wangliang74@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/tun.c
Hunk #1 FAILED at 1875.
1 out of 1 hunk FAILED



Tested on:

commit:         5e87fdc3 Merge tag 'batadv-next-pullrequest-20250916' ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6c33a7db07dbea2
dashboard link: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14240c7c580000


