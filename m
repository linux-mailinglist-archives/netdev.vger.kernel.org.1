Return-Path: <netdev+bounces-108791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91579257BE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB851F21C02
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731B13D8B5;
	Wed,  3 Jul 2024 10:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA33AC2B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001104; cv=none; b=k/+4Sj/8RTKViDcbSvk7v2zBUEtd2iVd6XeVEA1IykKJ8l0zk1xJv/KCaWPC/HLVnZGhvBBv8x/sSvO6oW9PGnEY96nAt5VLI8KRe2KQ6T4jZNwuNWbScuq1OSU242Ugt71Cb5VH5zaQyvjdxbrzRQhPm4C7jY3BOiG8aAStazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001104; c=relaxed/simple;
	bh=lY02iI+B7TXFliWps88lhx90cA3byB256b6ITnKObts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rn9XoJ6596lDoNEANmm/t0dfcpKIIkky9Dn2mRgK9I6SI56NcAiuz2qZNEF5E1BLOi0P6TyYvisabr1wJO1N1fqjBHNKgK6mImImn0Du9Kq74YJOH/exXlvuF+EQ/lsOuMhrG/P/dUOhYhLQc1jhH3ad7xk3X7PJ20hTjT5eCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f63ce98003so377109139f.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001102; x=1720605902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OjQVQEuGrs6u3VMzFp1UubJUIckBsLReRRFoFVd7NU=;
        b=or9j1skO2D+h2Z9Wheb0q/yj4YIOM73CJS1GwOQvlzmII1cH6NTOx10SnGmPTBHN0e
         i+MOIkcchWYniSnk/9cswY0ste6J4wVqZCFy2bSZHlUIg/PEIV2uBF8BUYmSX3j1I77x
         5HQ6mAJqGByYzE/WLZ3rj8bkkQ1ZXuIHQE/FQT6Xo+BdjILqFsLEF7qAhaKA2Fg1numU
         IMMqTL082gQcJOghUbJWXMvvxon/3iaksgKGl8LLmr37JFEDKJAXqPr5PT8II14oy5xJ
         fpIewC5moYIubCnBg1STHR1qaDDvL66vw39JPjbFCdNV0vp4WLIwJ//FzPNdP4RQRtwu
         3daA==
X-Forwarded-Encrypted: i=1; AJvYcCXMy4J6c7HtDhQ5EhnfKQbu5NRN9TpdGERRQmII0pW+AFQtsD1xKKs3JPe4yoz6C12W+hB6b/4iKse5dAhXgPx4pWuNvKkA
X-Gm-Message-State: AOJu0YyewhoA3hAzqMk90l2IrwPOTTzODrU2djUYy2Lo5isb+8SjtKt6
	lUSVVrF8terWSxWwEIs89oajFU9bPrqvegL4ATSAqXe0hSKEqgmJfR87RSgQOjKxTKBhJHlWYE7
	h27B0hqVMW6BgrK2e83Cg/hwrrstfhLIWpTDXt4Y1MYLVc6ZOcGlxzoE=
X-Google-Smtp-Source: AGHT+IE+nWoimz/rt+8CMHech/8plLH1wFoD0v09eHstCt2sAJ2E5x9mSn6BuMlizRmYyIaeC8jc9qRfjlShB6NvWOevBJqDotK5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:7f6:1f4c:96c9 with SMTP id
 ca18e2360f4ac-7f62ee8d43amr87550539f.2.1720001102480; Wed, 03 Jul 2024
 03:05:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 03:05:02 -0700
In-Reply-To: <ZoUeCoDMkRA/9DSi@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba1a80061c54f686@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/l2tp/l2tp_core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1788ff1e980000


