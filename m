Return-Path: <netdev+bounces-221224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6AB4FD35
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4815E3E4A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECDE3570CB;
	Tue,  9 Sep 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Fz/YLx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA103570B3
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424560; cv=none; b=l/UAykRbkDj9Sf6B2fCR0DGRv0s0mLiHPbieF6JqKZ7EBlJnqwHew+bOBcHrePCwy0YrtohKiZ6rV3Nk6dkx3OvMI9+gOcXn/fN0XTxgGNST0HajhF5t1auck1HE7tdD0SPaEmZwR0hhyGPB4LhetAyD0AvGwv1WMHahlPc4ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424560; c=relaxed/simple;
	bh=sdAUUAnXyg3K/25QJcJ/H03t1J2tpAN5WH0WT43DIUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aAKdDAshWl+0r3AnyIIdYJGWJtks4ZkB1Wy+2x9b7MUlgfxJxH6MDHT9MmIGXJOyboKfbGrvQEzbGUT/DtKe+zMQ1D1PgAesFn0n62UBn2+i2okjwQJ/YMfvPIOgBBo8yNt5fPlr22pYy9grL6OCM+S7hxE8j60ALqpAV0JaK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Fz/YLx2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-401078bfacdso31938015ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424557; x=1758029357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=3Fz/YLx2M8b0ASqOsObwg/F7nj6Bz1m4S5gi2raA8xXcMWalm8Vza4oIPHmgsbAJOP
         fVjQ3DXRLa9zsLK16oheajgZ1lUoH7Kx1dfepg6OiMAn7rwb+iVdWN0Qm3Rdf7EzPzIW
         5AH1DjDwM7M8WXhc6Uuhg8+ckMZ17hLSh/1oAt86eY7xXKYGw0db1TVux1ylNkQzWL95
         StKd7j5VgC6YIulq5Iaz6k+GCU3MgvZraHDajQF3s7jIUGU7cDC7K2j6EA28rOkxZTWP
         UG/2n2HTeY3uE0Bpc9RFOlIFcKrB2Nc3wEIF6gOh5r2Ns6Jysh5pDMyG23QsNs/4hIA0
         kl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424557; x=1758029357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrUpdS9XW8kCmiI/HdKgdDuMgaTmT22blEzvxDbI6UY=;
        b=c19HNz1nSPmDXdTQ7c1wP0dv2fFIsCksZdnEorhugBUgMtiSBjGo6YQnOoTt6fL//U
         jZYvqNhC6zApLJhzx7xePmEegkbYuonAyYJjScZn5ifi7NvZHSs4xp94wK/ofDHjrmey
         CxIPAj5CDm8aCgvHDUWGsYJy9p2cgHQMnP20QK28pr+fvWuts0AeEylNgMXruqKQ0/+R
         oTKyYFaikft2lQsXL0NOg8nC6zH6vhLa1H0JjrhZVGEWNDdapbIWV3gVvyGxzf54/1l5
         nBKAUhpX2sYUiQsIryZZME0pdDPx2krrzbF5dfZdJHEQKiwoLkHdZFBay9V77RaQsBzz
         r+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBsg+rsdV4zNwUzU3kLKZ7hrfbdMxxHWBUFxFlybYttCjW+pcQpAmp62/zsB7ftah4f8omaDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LoXhAWQIU8bA20oZzTwPZvEQsR9fyv9aJqhogSxdGSUkC5eC
	xTmVjtaSyChwdaz9hDkryZEiqwPh7I5NJjzDCYh8UZqw4VHb7YEWozb52VmVtg7szC0=
X-Gm-Gg: ASbGncugrgs36XUUMBOQlbEVGWexT7PmhA6UgW6K67Sdh7Gh8iILJJag7+5TT0LlfyB
	zKr+XeIoybTCTcq0Bti80uZiVQ0tbW9h1l2uHt4GFBdn60J4NXmBdE0M/gyJhcv89Hrc5+CnH8K
	qWmoIIzWBWgMPKz5Tk6HXdYrj1jhv2pIR6wDSW+PMMP6P0zatkdz/ULYzHqaQ7/HztDZ9poqKhw
	/t0inkVanm4cn/7SP5y7l+aLprBy1X63qcuA6sdGd7WgoD+RYGvSkQiV0WnbE+6PFGf5k9si2xM
	d2tjbo6MQU9HcRfVJD3Z7HDiP9KY42qhbtlSYygYPbbdlrUspXCphDJAU6NTRXXgwp2UOWl1/zs
	mak9ZpO+2KlKUy0U+7WpDyjC6pLm3ZBPKLSM=
X-Google-Smtp-Source: AGHT+IEIjWqcE1zYENpDxaX7YutdAIuak1sO9GmLbuURziKcQXpN8xbXlPbtAPoitLTAuWNCpHzs7g==
X-Received: by 2002:a05:6e02:3784:b0:3f3:bbda:d037 with SMTP id e9e14a558f8ab-3fd965c4d04mr182350825ab.26.1757424557099;
        Tue, 09 Sep 2025 06:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31f6e4sm9895116173.47.2025.09.09.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:29:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, 
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
 Mike Christie <mchristi@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
 linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20250909132243.1327024-1-edumazet@google.com>
References: <20250909132243.1327024-1-edumazet@google.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-Id: <175742455632.75115.15346620038817180242.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:29:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 09 Sep 2025 13:22:43 +0000, Eric Dumazet wrote:
> Recently, syzbot started to abuse NBD with all kinds of sockets.
> 
> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> made sure the socket supported a shutdown() method.
> 
> Explicitely accept TCP and UNIX stream sockets.
> 
> [...]

Applied, thanks!

[1/1] nbd: restrict sockets to TCP and UDP
      commit: 9f7c02e031570e8291a63162c6c046dc15ff85b0

Best regards,
-- 
Jens Axboe




