Return-Path: <netdev+bounces-98524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29948D1AAC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845E81F23EF8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26116C87C;
	Tue, 28 May 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QRErW/GP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350E13A242
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898111; cv=none; b=RKwShJE03yMR0Ix++kqNNPOwagc6uXeFqCa6ofAoRtAUD9ARTXsEUPz/6tameE2gjbcOrJrDY37/I2pGAig+5j1wNMkvjmImPShbEEFGVBbq1aLOTY3Lsv4OEWo8jwXhDr10czM+2HNq9GW8In6dL3EjYs3zeig/yNtOGa8D1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898111; c=relaxed/simple;
	bh=h11Os2JDCwdjHp6XjbK44AQSfLeUfRzcekllnNHk0Wg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIKzY+uCrO7nq6GmjMrd+m8dvnZlVYMtHFMzdCC+zmHG0IuzH1m52jc6MH3YXk6x2yXcKMmaj7C711DBpUP1oe92O9M6sLA27Nle5zWjZAdT8SXar3LAb3uGLEWW1QiPrK0Vuns/ggCgafq704io4/JqdSqqrXaQupBh972OKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QRErW/GP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354b722fe81so509294f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716898108; x=1717502908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5tCjk/1mXFG8ICJoXb/9fn8uz0vdilIBJSVF/91XJA=;
        b=QRErW/GPtpieP+liMaXciliIbELaGc4geZ+H+JZqw8Lmmq5M+oPeOM6OB+tHfjMb4L
         A6tN6ExDZiaMMbD2PffpGGNal3UWlEIihPxaUEsN6cPXUi8JCElIRj7825t1KfZpPmfA
         KYrUHRfcs0PqBK/7tViq358Ugccn5eCQ+/CIkVQczrh/joUJO0rmnxs5AJCru0gjDl0J
         CKsDkbc6Obp3wZDcV4WMmSln/QYHmBbBHmy9DWHpzWWQ0rdeo9WyCES0KtazVZeYiXmG
         BFHpy1R5iWMVV8XVWpnEEZVPjBuQgW111Qfrwo9MGTDBzUIxT1hX4VS2m79HhhmScsbS
         VRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898108; x=1717502908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5tCjk/1mXFG8ICJoXb/9fn8uz0vdilIBJSVF/91XJA=;
        b=KLQVBtLsw9/P1A+EBRh1sxAY5BlASxBJLlvEo0L6+qXqIDM2J2zDhM//jfPVEoP2da
         dbeTzU87joW+feG1Hd+vX/5K5eoyg7x4h3kV5ZwpNhXyt/KleGAgidSyIS/5mgjEfpHJ
         T1RhJxggZzYlO6PFgkgATvUNyVukl/HTlO5vZmlR+egO8/FvzlXPGDGhwOC8YTOpx9JD
         /RHANAP2rVGnAbeMb+FILmhYwSq/h8aMNz98BVmjc2qX1DMxE3LcbTqF/0H3B5YrQ3bL
         TZiQs0zi0QnzKeBG8Lq8hzW0cUfnpIs3zypSdxWUgz118hMSVXOST+pQyukE3Mhg94Lx
         e9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX8P0GX/3pQJ+azdOvbLzzMnSvN8UFe6PO4e6mbGMQO8/7xMg7MFt6FdGTH0o8fL6nBiYY+ILwDseIPVPriBjqClmUe7x2r
X-Gm-Message-State: AOJu0YzBPp7hZDDq5eNJ5GkxHloI+RiAyYwIZ/XAD407hesHD4/kL5xS
	xWyyzwOQPuQJJ7sh6hlh/hZ4C1v3DAlbtxnLeP31xpesqVACV3CMCd7TLVlLYlY=
X-Google-Smtp-Source: AGHT+IEF+rn2o/HZ0ZeGXHf/QjKZLMejcsSQZPkViOgwYcQ8K9jxqNzNKZXFAHqH3CwVl7nGyyml6Q==
X-Received: by 2002:adf:f183:0:b0:354:f5f2:198b with SMTP id ffacd0b85a97d-3552fdc828bmr8456181f8f.46.1716898107691;
        Tue, 28 May 2024 05:08:27 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7ddd5sm11512600f8f.3.2024.05.28.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:08:27 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 14:08:25 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlXJOfSLb-2iuJeI@localhost.localdomain>
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

#syz test https://github.com/leberus/linux.git hugetlb-vma_resv-enomem


-- 
Oscar Salvador
SUSE Labs

