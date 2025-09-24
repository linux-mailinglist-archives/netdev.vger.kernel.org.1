Return-Path: <netdev+bounces-225830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93E9B98B91
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B32A2A6A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8C27FD64;
	Wed, 24 Sep 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5rmQ2ks"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECA2248A5
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700987; cv=none; b=j5c1yDNkg4w60UhqtGn6Uzi1WhBDx7huPo2jlePNZo4ICSA58piXh1A+nPPcgoSPOjM6dBr0FyIhuaTcWbei8JzNzrbuxjOIdkxo0WJ1jsMF4YzC82B+ZV4pxX1KgLvHhM/iIWFKYHQngF8BIUDHkK22QfwSpT2y6VoCXk+zg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700987; c=relaxed/simple;
	bh=gZYO00dsgw1/sZf16O3pqxqviKudSlUhSQE7SGYKT4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I30kTpD2vQudZ0zhYD/Z22UfHNlvARv3nXO0+lcgF2hdkKdOslwYcmoHeCvU7JyQpenrkbCn5zR0olmrkcvYrF7xckq6AqjWZMktITN+QRo7jLq/rzy1IHAJr4vSfV4aVrCCNrAYfG8Ar3uWjdXoXkjBVjKBhUP5+m6kEckzhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5rmQ2ks; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso7861366a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700984; x=1759305784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehfc7lW7bxLwmLG05CxRKvZLBCPLLvWLd72j5jVN5N8=;
        b=A5rmQ2ksjJV+pH7ww7oZxhdxMVAJ0gYbbfAM/WrQGTIw58y4P4Jk2lqIzo6/ORDGsB
         12H5G2Bl7oHGfFvDzPhe4nB1SZ8Ij/ldLcOVUtaebURd9kfKxb0XWQiRG1cZoKLI2KaX
         Bvv+VL4QOTY7UlAnBIRV4IpLSIChPshAK6gwQBRbuVla0mzqlLfYjGsECHPx2uO3amo9
         yNU4NXW6yDQyIB7+DJ6RQXPWuAMdwq2AKVe/hrAnOhMc2WZ1ScOvIXQdwdE9LkCnJBKN
         po+S88dsNg13plFmdClOuJcyCauaMueZ516nahpV4bfGpZGUy9v8MtDXc8+9fokE0wuP
         I83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700984; x=1759305784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ehfc7lW7bxLwmLG05CxRKvZLBCPLLvWLd72j5jVN5N8=;
        b=rw2sR5lClvW2Jzqs+hBjFepsCoy3aa6uUQmv+RC65eI9DaqajjHTJLmVPcSJKOC0Lb
         JkMqDlMYKHjqLskXKlx04Uajk6APzeNzKCyFMuMvMqSQDC+Rb7/7L11pShpUoEgDn9bL
         wQXyfuIaAaykelx79MNKdb+yMfP2Pl190jiZBX41eNHB6Ds082FtK86nKQWOTUnaOjFZ
         0zyX4XGmd5aSxHRg2ofhJuAm34X8KpEviThSvI3IKg4xnBForxAHP+zdOw0FMXNCgH/Q
         H/MVawHpFjsce7Fcff8oUqXJCnGR2LiCMHn1A31v9I8zJYdIXKRXvW+QqREkW6oH7T2A
         EutQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9EKtQ57CbkbS62qyDFRYw8+BTzGUfOo6qFQTXTtJKKxDx3uRNMnDJ93Wn7ZHzIgevm8uykDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJFXnzVhVLggfdiUwG1s0PU+nk3mSTg5WE8cUYENsLRgo0FeS
	fe34BRQpgvHQ9VdEgrqxGpqPFFNMV+BP1NEzfRUAVetI8k9wKUXhAZKBHA/ojLgb7+GhN94cfM1
	ILB3Fy2sqQ+KnPXMfVQvr1B+syj6xJEjTXfwa
X-Gm-Gg: ASbGncsv4CwahpFVseHP/LnovnzBsERYei+PWYZbQTO99v1mxMKxj2U2PTDvjY4tVq2
	VHdam5qHdxosv8E2i72cBu6OgTpFY64V2G5e77aJGtHPYvVI7/A2M9RU4BFg/Qjh/fCtMSLBUow
	qu4sLeiPW7zr4Qmm+abPCvoUMuwnj0dDLy4Kgu8vlBoAuF5Ww8Ayd1CkKd8Fn1nLvpHtLRNpMrU
	pha2UrN14wKmlbwpbItOIyNxv8xkYGYbtUcstZb+jIvTXstfeLUMQ==
X-Google-Smtp-Source: AGHT+IFxLHXew9N/JexqdNTfDfR/A0LfnbXCLzDT8ABYFnADQGfGxHrMbIpi3ZFG4X939kYRjpoOubp/hHRjAOYou84=
X-Received: by 2002:a05:6402:254e:b0:634:4e0:836f with SMTP id
 4fb4d7f45d1cf-63467795097mr4196054a12.1.1758700983944; Wed, 24 Sep 2025
 01:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch> <20250920181852.18164-1-viswanathiyyappan@gmail.com>
 <20250924094741.65e12028.michal.pecio@gmail.com>
In-Reply-To: <20250924094741.65e12028.michal.pecio@gmail.com>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 13:32:52 +0530
X-Gm-Features: AS18NWA4QzzqyxonbnUZkhNBqNGPKS9vhQ2TwPcWTvWPtTGvwTC0T-6N-mfumR8
Message-ID: <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Michal Pecio <michal.pecio@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petkan@nucleusys.com, skhan@linuxfoundation.org, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:17, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> It's not freeing which matters but URB completion in the USB subsystem.

Does URB completion include both successful and failed completions? I
decided to go
with "free urb" because I wasn't sure of that.

> I think this description is needlessly complex, the essence is:
>
> rtl8150_start_xmit() {
>         netif_stop_queue();
>         usb_submit_urb(dev->tx_urb);
> }
>
> rtl8150_set_multicast() {
>         netif_stop_queue();
>         netif_wake_queue();  <-- wakes up TX queue before URB is done
> }
>
> rtl8150_start_xmit() {
>         netif_stop_queue();
>         usb_submit_urb(dev->tx_urb);    <-- double submission
> }

I wasn't sure how to describe the flow of execution in a multi threaded program.
I will resubmit a v3 with this version of the execution flow

> > Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
>

> Tested-by: Michal Pecio <michal.pecio@gmail.com>

Thanks,
Viswanath

