Return-Path: <netdev+bounces-98489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E18D196C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21D41F2336D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C85C16C69D;
	Tue, 28 May 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHQYcMfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215316C684
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895773; cv=none; b=ri8B/YoRx/OkoUyiUPatsi02obDAWOdZK+S6wgfA1vUWcfY6ogBqGLX0O/mkEBvnnmr5P2UlTNUIloN9ZustRCzOqP1oPqfCp7J253VHpNC6SBKNi00nb6uyDw/uon6zEyKaHWa98Cfffvv6Ka7vN7392KQJcBWv5ZgYMwUr7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895773; c=relaxed/simple;
	bh=Fhx6TTOqibqI01CNB0tq59za6TZyBibaHI3P84V+iE8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjg0zHfR1X5G7BfWfdEw6zifC/qu/F82AcVrkLmImikB8x1WV9nmzpX9K+RPvo/xmLX3DPAivGmIJ1vAf4lnOIcRQ5pbQueKICxugAK8rsvlE6120vSlf7+bHTkMoTU7Z2BMYFAEkIwto8i+k4fC9nkclYmJozgLukokLlXDFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHQYcMfl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3588cb76276so1155892f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716895769; x=1717500569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5oY5QDj/F2VjFpREI5FnfmpEsPpu1JW9qQI7HQyBXo=;
        b=HHQYcMflVg+OtmBs1SqR7Lzq+2HtlGvu7h2cPgb9t8GSsriHxCgP0BINbIUHfP8AhL
         IkbKxLxoZSYIMcaOq0c3jaU/7wAUppJEXuuLBJjomkm44xUXb1MFNrEX2ySSS+v/W7oM
         IwcM++5Z01QH5z3o+M1UbaWOKzpDb2MKP1BapgzGVkUXp07UmfN7XcV0f2TFEk7Tkow0
         rpkgaQpNafIgoJ4hRXza24dH6TjSw4enPuoLu0Rg2tNsu4gFsp29od8YavJLUaZFYC/u
         BH8kqxmo0VQ9408RAOVlWkFWRfbQA4TSCwZjUjt2K2QR8dz+j2OV+HvwwJ6UFlDhs9OP
         AeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895769; x=1717500569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5oY5QDj/F2VjFpREI5FnfmpEsPpu1JW9qQI7HQyBXo=;
        b=pQ85o0nE7AFfDlDRHTd1aBiMv96kFpkFBiNAN3Q33lIA4uAyGRbCQYjVw6flxRv39a
         deJcYPcRsr8jdL4IeyE8WzHk2BEGanMlkDRINypP4nQRfNINmVpMEmqMp5lN5ZifQCTD
         ItIqfNgBvgeC/lt+uFQhLRUbWy0MC+OqLj+Poj/YboDtITyQXmq3ylvuViwI0W16KOH1
         98MucUQresh6UOA7Ez2Iy+zuuiuxgs/7z3182p4bHKlsKna0GgjD0kR9iySnJFYgjcIU
         2G8P8zijpbRzxvze8/nAJSU99Cw+iGEGmVsaJPC+y3nwJa5iaTKpx1F4T7Wc+PMNCdJP
         zNUg==
X-Forwarded-Encrypted: i=1; AJvYcCVDah8PV5r5R5wdRwEYZfYNRzPM98N4UwYTNZfxEyVRKe+P4PxAjlkfgMjAeFLFZd92L2aXbbHQQ91NpyHfIWgS9AGVZ8MT
X-Gm-Message-State: AOJu0YzxnmNDTKXEzvzHqFbc+O231ZAUTWNROt4cLKiVmT+HOa7rcqyF
	ohpbM5mbrA4SgF60hwz23N0HwJHJnXWgxdiBAywfOB+JmVCWpj4a1A/bN3K8Q4s=
X-Google-Smtp-Source: AGHT+IHEhP3H8xEy5lW4Agk2rSDU8yNaHdbHbk2CspUGWoXeNFtS8ar0NeKjZ/WLL0Q89fYZoR3UBQ==
X-Received: by 2002:a5d:47ab:0:b0:357:a6e3:8748 with SMTP id ffacd0b85a97d-357a6e3877emr7780899f8f.1.1716895768949;
        Tue, 28 May 2024 04:29:28 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8bcsm11458124f8f.44.2024.05.28.04.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:29:28 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 13:29:26 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
References: <0000000000004096100617c58d54@google.com>
 <000000000000f9561b06196ef5b3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9561b06196ef5b3@google.com>

On Mon, May 27, 2024 at 05:50:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

#syz test

From 917fa54481422c650425c8b0330439f8a3308479 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 10:43:14 +0200
Subject: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM

sysbot reported a splat [1] on __unmap_hugepage_range().
This is because vma_needs_reservation() can return -ENOMEM if
allocate_file_region_entries() fails to allocate the file_region struct for
the reservation.
Check for that and do not call vma_add_reservation() if that is the case,
otherwise region_abort() and region_del() will see that we do not have any
file_regions.

If we detect that vma_needs_reservation returned -ENOMEM, we clear the
hugetlb_restore_reserve flag as if this reservation was still consumed,
so free_huge_folio will not increment the resv count.

[1] https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/T/#ma5983bc1ab18a54910da83416b3f89f3c7ee43aa

Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..a178e4bcca1b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5768,8 +5768,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * do_exit() will not see it, and will keep the reservation
 		 * forever.
 		 */
-		if (adjust_reservation && vma_needs_reservation(h, vma, address))
-			vma_add_reservation(h, vma, address);
+		if (adjust_reservation) {
+			int rc = vma_needs_reservation(h, vma, address)
+
+			if (rc < 0)
+				/* Pressumably allocate_file_region_entries failed
+				 * to allocate a file_region struct. Clear
+				 * hugetlb_restore_reserve so that global reserve
+				 * count will not be incremented by free_huge_folio.
+				 * Act as if we consumed the reservation.
+				 */
+				folio_clear_hugetlb_restore_reserve(folio);
+			else if (rc)
+				vma_add_reservation(h, vma, address);
+		}
 
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-- 
2.45.1

-- 
Oscar Salvador
SUSE Labs

