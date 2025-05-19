Return-Path: <netdev+bounces-191540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EDABBE28
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A8C7A1818
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE82797A6;
	Mon, 19 May 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYFZXhSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CC27979B
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658594; cv=none; b=DKNzbIXEPUcCTvqgVprmV0CSPuiCV13Jc2UsaRIn+XThyTbZ6bs8LMMx9w8knVoi68AvHzumtMWP8qWyM2nv8yHvltV66zEmGxLFTxuNvrk6w1+QuSyaJ23a4lznRDtRj1Z534WlRNToSJBh9S5fFbNaYDlIGRZNDKvD2UDT5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658594; c=relaxed/simple;
	bh=MV8Txi9B8LqGK2uXols7i/aQl3t5MNL7WEVASiMB+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHGFys4xQLymBRrxgjuyQUnXBU9HEkZb0Mdbgy1k97N1WIHc2Ap184t5t9ztcoNqNzl1SY39CqPsie7zoJD5elcB+2Bf4TMnyxuV09fbedRImK2bpn/m9EE1LgsvxP1gqHv0Rmsyru8ivP4XxzWvPysN1IsOqF7WC3DCWr8C5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYFZXhSF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442ea95f738so34697435e9.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747658591; x=1748263391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxMAkcXuFARIK73CWp3vXcwbAzkKMuCiU9C+2z4wkEA=;
        b=LYFZXhSF7TwOSjx8K7ikE+BE5+of/noHLlVaPSLnZ02uw4nDp0Vpzue3m5DM15gQhO
         0funOHQUjggBNWPBqtynOKS7LuLQ18zSmZeJ23TEzFAJLWAg2+inNYBcZIjOQuIbaGFI
         8QwMX1/AbqI7s9Rzr7F2/uYg3xy55d4xbfTMQYHUQ1K/SKO6kDjRFP5obYeI8YIqvuMM
         v72iEyDF3yk91mwscRlfxr+6DhMkqAdDN4WuIX+rU9HHmw7ScIKU/DhwEjMwY441tSWD
         1ThU+Wiy2hvblCsmrPrNqiubFcaZGRPT5/9HTeIV2cz89dOtVDfpb0lzf+/kMzhGD1BN
         yu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747658591; x=1748263391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxMAkcXuFARIK73CWp3vXcwbAzkKMuCiU9C+2z4wkEA=;
        b=MoYJh4DCqkjcRgIRMhNQy700GsX0tBM0iI+6XMdS9rqs3mhG65fKfL/4QIn4LNG9q5
         ttRvdbisyNgzmkC1dMmmUqQODwLvpeiJixSa6i5z/PjjaVHfN0Umej+N/3oFEzycb/zA
         ght3MHmLrPiTcxuPYN+UwOuGu2XrW2IrQVm0LREUwEuoYvgfN4nXDWfxzTPladKKMJhQ
         rVL0LqF2MhDn7ycsDnmT/2t0TkUOYwEglc5F8GgcnCu27IzVV+1cbxhunqO+AuSDZ6mP
         Jn7t4AY7DMU7gTZeFHvG/VTWeQm1nGtaCeBS468JzWXF+HcVgw6+C/9xg1UpDTynbX79
         xqcA==
X-Forwarded-Encrypted: i=1; AJvYcCVbdqKwv7Scvv619aohtfCbef00dwhIf/F1w0LkQqmNJE9prYLf6kDHJETfmQrpS4cgJzKdcog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyRXUz781gQkJ7YJpuAA382ztUxmr3tSDVtlO/o6qQWIseoTJ
	rXhigQHX5yUMCaWOBqfL/BJTwurDOPChObFXbkcmJUaaXZGA70MgPi4o
X-Gm-Gg: ASbGnctxX9DfWcUYiNaSTdV5ySLfngQ0GSYyCvwVmFzTZH+9kkFxVd9VG7/uwLhcly2
	y1ERztkLjcDbfRCN0oDqjhVW+OT/UBohngtwp3O6O3TwU/w4TJvz9ERxylJtA5WwSa3VFo7AfI+
	VdC9cVIhFcoO6FHojlxhz2S2uhhfEnhIYLmR6cFoGnZZSKQSsz4mhCTvu1dzGkRCAYINLAEibhe
	/P9EOobv8xEbUs40LbyGjgWekgR9MSDIROKieMfBrSPa2lJgfgXXK05nFX1tcY79DCzQAjVMY0I
	ANiUkauw/sePbhJMRnvceXqwh9zUnnEa/Kcaz3RSXe4hPxKQTtefp7VRncK8yksk8VbpjwPsHeT
	wrbLrHZPgGKLtLg==
X-Google-Smtp-Source: AGHT+IHA7jMbGfTwbNBwbhJ8qrFLwkGT9UyGS3HGpY2JHtiifqtiQJRlVT/WTVYhLGePWGAgJwP3Cg==
X-Received: by 2002:a05:600c:8889:20b0:43e:afca:808f with SMTP id 5b1f17b1804b1-442fd675152mr81399825e9.31.1747658590954;
        Mon, 19 May 2025 05:43:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951b57sm216780485e9.21.2025.05.19.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:43:10 -0700 (PDT)
Date: Mon, 19 May 2025 13:43:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 6/6] socket: Clean up kdoc for sock_create()
 and sock_create_lite().
Message-ID: <20250519134309.35b1e007@pumpkin>
In-Reply-To: <20250517035120.55560-7-kuniyu@amazon.com>
References: <20250517035120.55560-1-kuniyu@amazon.com>
	<20250517035120.55560-7-kuniyu@amazon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 20:50:27 -0700
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> __sock_create() is now static and the same doc exists on sock_create()
> and sock_create_kern().
> 
> Also, __sock_create() says "On failure @res is set to %NULL.", but
> this is always false.
> 
> In addition, the old style kdoc is a bit corrupted and we can't see the
> DESCRIPTION section:
> 
>   $ scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
>   $ man /tmp/man/sock_create.9
> 
> Let's clean them up.

I think you need to absolutely explicit about which calls hold a reference
to 'net' and which don't.

This is separate from any user/kernel flag - and may need a second flag
(although there are probably only 3 options).

IIRC some sockets are created internally within the protocol code
and don't want to stop the 'net' being deleted.
Such code has to have a callback from the 'net delete' path to tidy up.

OTOH it is not unreasonable for other kernel activities (perhaps file
system mounts) to hold a ref count to stop the net being deleted.

	David

