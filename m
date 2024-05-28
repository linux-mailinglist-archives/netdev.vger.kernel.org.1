Return-Path: <netdev+bounces-98710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6918D225D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D7281828
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A317332E;
	Tue, 28 May 2024 17:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAC14E2C8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917045; cv=none; b=P/lIj5jmJGCIzrHzOqSalwrN8XQRxlA16VTxlsMefTOosBcvOj1aww267F5PDCePWfesUlGVEVpx5PHo0Tz5x3/9izAtg3clRt4jSOAN0w+9MHrmw7+04CcjMGfJMKtcNrYfoxJ9Vh3Wb8nRco7AeA4sI7FJ4IZZi0TLZ7KZvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917045; c=relaxed/simple;
	bh=NwVtVqmDmpgrpeeU20NOiY4IDvcu6si3adnNSFoLIcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hmu1FJx5qBPnWvZqlNL5kNXyKKFaxCER9hTkujugxtlBnKWDvwYNQEhp4tqLGtoR+l8GOuZ9TTjFdcwK6f091rbzgZzo0/UlWrzZiguFbsH90ywsKvQEq+r5McgGX41D1UAOEE8//gEVTMrMJ0IwLLNt1Q+l5F+vKlP237tkp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ead27b49d8so138272039f.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917043; x=1717521843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yNlsejU5OKeaQhEzar8+GaIUKly5Zi3CGh7ZerUnuo=;
        b=s50zGNdE8RhhyW66F4g24JmT4qE3D1JQSpLSkBj2mzO9kbEqqqULDQqDDsAlvnt3jA
         DLGZOrCl/kgIT0uM9DhrtZxIIMT1uuBtzt2xP7A0NiE+TqaRUBfNXlZhgWjav+UO//bX
         B7dwyGnXhxebnJXgZsBijgQAh1nA3xXPhsEQwlQfCMRY5/A4F6mlwVFkNaqkIWpFNInu
         r+2c98vCV4Yh8OYx/INDR17Z0F1PJYQoIR+ikVVpbl3fVKffOMSPVZ+Xq04tknPvVTul
         XSNx+IUUtkHD0iOgd9QBAQCabDngd9u94pY6iyru8mO+8/GeXwALn8UkEe035wIMEcTX
         xKZw==
X-Forwarded-Encrypted: i=1; AJvYcCX6TV95Swx70uf+lgTgxmrmHwGdt3Cekr++uIQwW2TDwZwIzAhdkBz2N+mA/Hbd8HcgFROqcE8URCGils4gJwmBuhK24Gs/
X-Gm-Message-State: AOJu0YyQpYA5UvTxJcrMBUv2fbWgRYW69eje8fAnJvyj8b/VWsmPr7uE
	mo/PoFcRd3CgwJCITYFC/GzQLjFHhzlnt1va+wZQqZSZvL54N7TvHXBgd5pD1tnMgGvSAck6DGR
	Iu6s9GeiYKaKrCVQx5uv9cfIEpSXRqA3XOf7AAMrYYuj0tR2zfy81UFw=
X-Google-Smtp-Source: AGHT+IG30kQLtKtkvjC2J6X5T5H0ua9sojkjqLBvu8WWwXDx31u9u2cxlt161wplXgK8/zmVo2ftC8Qefn7vAEuFgzp1fcfrBGmL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cc1a:0:b0:488:c743:c19 with SMTP id
 8926c6da1cb9f-4b03fb9b001mr473972173.4.1716917043060; Tue, 28 May 2024
 10:24:03 -0700 (PDT)
Date: Tue, 28 May 2024 10:24:03 -0700
In-Reply-To: <ZlYIoPEq7avOkjCW@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076009c061986e67f@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

Tested on:

commit:         c80d58cd mm/hugetlb: Do not call vma_add_reservation u..
git tree:       https://github.com/leberus/linux.git hugetlb-vma_resv-enomem
console output: https://syzkaller.appspot.com/x/log.txt?x=1763ba0c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

