Return-Path: <netdev+bounces-63983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834B830A01
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBB31C2176D
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253821A0B;
	Wed, 17 Jan 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mozzu9K+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9422301
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506485; cv=none; b=OqEvZux4ONDpZzN/W9oFkemYqs9yyHyl2zBNV4x+rp18o60h2xw205fOLk/dKjlUtLx3YpYsOUoR/+UAgT76s6falPh+kOK9tXUe5p0cVAEPCeuNPYFmKaVDQCRezCyOQSIj5ym9outA5SOHu2UNScNk+FWSz4I3fZtUsnkoXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506485; c=relaxed/simple;
	bh=mu7VhaAc515ipMhWdzPtT2TPxqqmKOKMcNFGqTwz8wM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=kI/9JuuBe7DG0/RmPpSA3OivvAWsjsPBnbFWg72KvoFBOhawZTtPBnvKuLLkjXlCT9sov6YcjzS6A7OoNejw5fzS5vLLslbD7uWgj6dE+X2tda9sTxR1PIXKyVYwc+s+ik6W13ktfzOIa80t+8KMDE65wuTqJ682TJYWRu0M0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mozzu9K+; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bed82030faso60661339f.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705506482; x=1706111282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBwQPpl+zXik806WtECeSYlAHrweUHc1hm7lYkwTJFs=;
        b=mozzu9K+nmHJy5WeFP+F0bOU78P4JJr4xv1z1j4HKBISbL89EbcfFZf+0Xx7H/c2VA
         kTf9A8Xi++6dB+1h5Xuy9/asxCN+b4PQYI4DcdqjJkS6qUJpyNzF8zBvoEttVWPyN1Fr
         PkCiGQlXesvlySenB2Wt1BongGGycIn4kVxg9SWqnDqaJFhjltlTEJelguJTD4GzAdYo
         hg9rD9Fb6gd75W6YrDUNvBvFFiLy4Jwp7TbZrKj7ovSxQ9uSIbSfg/kk8K4RXJK4pUq4
         2Q0eAlKluaBg9CsFolEkhHbG9ojPdnrWBmeaevZ7aRG+bAA2CWoWyyJX5OMX2IuMUPYB
         3erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506482; x=1706111282;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBwQPpl+zXik806WtECeSYlAHrweUHc1hm7lYkwTJFs=;
        b=BxCCDcKCiNJxDKltkHec5xc3kKlzAdVowxu3W+lWoeYsqRYuTd5Lw03cX5+Eh06RZs
         JEU+BtRdMIW6Njqy9FsAwvzNuDTDH+vAq0Cg8jfaTw8qNKHOvoZr2fXERclg0ZsmDY1L
         4deLEHgWBGpDydQgzFCVgShaBzcoJ3MqF/dCHnxjm41/gOIDT3pwEAwWwGA3wX38Ty2P
         3p7ckvpgVR+7f8Wpe60H3eBVxyC+X6fUPBjnC+vN2Gv6UD6YyabyabZnKpbMyk0P1nrl
         YJ6R971Iq+a4AWfZMgCsUa6s9X+iID4LI4mTuNewEf6Cww4oITlLG4fCGFYVT67lDqv5
         qZag==
X-Gm-Message-State: AOJu0YxxTXqP5reNw3NrB1LGu1Xy2ApuFcxEPkciOhpC8ZP0sW4KnqP9
	P8RxHPAYxpSnfEIRElbU1Qsza0uFFTZkpQ==
X-Google-Smtp-Source: AGHT+IFZZGSI3LvvEy+XRSDgw/MUW2O98Sa/T0cEKhvZ1zzsrKqvOW8y4/IMwgbP32kgoihbqtn42w==
X-Received: by 2002:a6b:5803:0:b0:7bf:4758:2a12 with SMTP id m3-20020a6b5803000000b007bf47582a12mr8519442iob.0.1705506482496;
        Wed, 17 Jan 2024 07:48:02 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c34-20020a029625000000b0046e4c2f9f5csm482353jai.28.2024.01.17.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:48:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20240112132657.647112-1-edumazet@google.com>
References: <20240112132657.647112-1-edumazet@google.com>
Subject: Re: [PATCH net] nbd: always initialize struct msghdr completely
Message-Id: <170550648165.620853.7074880501945877841.b4-ty@kernel.dk>
Date: Wed, 17 Jan 2024 08:48:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 12 Jan 2024 13:26:57 +0000, Eric Dumazet wrote:
> syzbot complains that msg->msg_get_inq value can be uninitialized [1]
> 
> struct msghdr got many new fields recently, we should always make
> sure their values is zero by default.
> 
> [1]
>  BUG: KMSAN: uninit-value in tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   inet_recvmsg+0x131/0x580 net/ipv4/af_inet.c:879
>   sock_recvmsg_nosec net/socket.c:1044 [inline]
>   sock_recvmsg+0x12b/0x1e0 net/socket.c:1066
>   __sock_xmit+0x236/0x5c0 drivers/block/nbd.c:538
>   nbd_read_reply drivers/block/nbd.c:732 [inline]
>   recv_work+0x262/0x3100 drivers/block/nbd.c:863
>   process_one_work kernel/workqueue.c:2627 [inline]
>   process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
>   worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
>   kthread+0x3ed/0x540 kernel/kthread.c:388
>   ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> [...]

Applied, thanks!

[1/1] nbd: always initialize struct msghdr completely
      commit: 78fbb92af27d0982634116c7a31065f24d092826

Best regards,
-- 
Jens Axboe




