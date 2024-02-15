Return-Path: <netdev+bounces-71981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731C855F12
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF29B2B06F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173196996F;
	Thu, 15 Feb 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlugLhh4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA069953
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991962; cv=none; b=DoY8QUYTcLCSIoAJ/q+rSt4dZ5FXvne9ZaiHV0YkyHMYBuYJ2bgtWubhjRzYc3IYvC8dYmz2+ov3rUXrMFLNbdsjQkpMdtz/GfTikqBXfLB+BJ7MZLFo9OyKMA+qEqnEEHc3zGo1OGvnoNDbY7l6voWQICLgvL/1Nus7tpWFxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991962; c=relaxed/simple;
	bh=rLQqnd+cTB4SZqPRWWD9AfwqFUojKkJ96dLJbN+GyVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmmDKwtThLrqMuGVazUTRmpJqA4dYV4+koIx9md+vwEhuZ+bln/P26iyxrPdO6y46a6uCn0xKm9KbdhI34gQ6zijtyLkiIgcPyidH090lguXtndCc95G+y5CfnTMmKfc4/6euqD86yg77mpaMptdttF7Hj4AZXNBORzZMubBiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlugLhh4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707991958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGF3wI1uc7RGq1ZZN5DTSZ39+YRRcxkrztsB6zkCzPg=;
	b=VlugLhh4kDhReghFnnThMBUQBIvkNrXBfJbTUDEG8EKBhqlNxt+vmZBMTwCVGWPfNHj02H
	RBI+rafqRf1/twN9s1cCC3ZztpMjsgkoqGFc8xSoz68hhgfCN4EWY4EJbBYwgTQTM13FWe
	y8BcCVpUb7OFZgK6nvrIam5wbHC6yoY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-WvOjgOtsPseQuOlqZKSUGw-1; Thu, 15 Feb 2024 05:12:36 -0500
X-MC-Unique: WvOjgOtsPseQuOlqZKSUGw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ce3469785so94729f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 02:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991954; x=1708596754;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGF3wI1uc7RGq1ZZN5DTSZ39+YRRcxkrztsB6zkCzPg=;
        b=kG0M3KlJrZIAyecXMu651OUhACFDIbM87O+Uoy6E5n3yXbVkdIq6i1CWWpdIBJWa85
         moq5e5uH94J63Y9YkZHXpvFoBaXZiTGL3OmOw1WNjJb8Ond4KafQTahqgd3Axi4SJbM/
         WcZZzxZ8eYkI6Pm49hCVmL9+kQeNxAmffVwBDmZdtXpu6JFyCFHeXhg8XzZ9GnU/KAzr
         4x0DsM0HdxmT9f7236ESrnIVpBC/1XMC3rstT9hPz2A+qkK+nKfripiAhNshrjk2/t2b
         mXSMF2clhKiM56dvo4GfJEY8/9iFOSC92Nmis4GH72ltkQYg+xU3sPrSgITHJQIxOVO+
         9Q7A==
X-Gm-Message-State: AOJu0Ywjncp8tzA9bp9Eh7p0O72m1BwbkAqt9+8eqzfkT3IteaYxkolf
	QUiPn96gcRFHubRZwYvY/UO6SIHNjmKJ4S61p+G4KwGgkQ2nPeY2Eo7JSsQBi6Z8QKamRMKoHD3
	WIkiYG0P1HTIvtILWWaQQ7PhlGBmxFVQOZ8iOdDgmTYvuDBZVmCwlgg==
X-Received: by 2002:a5d:5b0f:0:b0:33c:fae6:d4bd with SMTP id bx15-20020a5d5b0f000000b0033cfae6d4bdmr1045330wrb.4.1707991954431;
        Thu, 15 Feb 2024 02:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2ZK3gLDiXTkLJgAl6zWE30LlbNWY9bGuqepTyM8pe96nV1z9LDmml3V2naKzeajYlmw6RA==
X-Received: by 2002:a5d:5b0f:0:b0:33c:fae6:d4bd with SMTP id bx15-20020a5d5b0f000000b0033cfae6d4bdmr1045312wrb.4.1707991954095;
        Thu, 15 Feb 2024 02:12:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id q3-20020a5d6583000000b0033cf77fe255sm1293245wru.54.2024.02.15.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:12:33 -0800 (PST)
Message-ID: <c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com>
Subject: Re: [PATCH net-next v5 00/11] introduce drop reasons for tcp
 receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Date: Thu, 15 Feb 2024 11:12:32 +0100
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-02-15 at 09:20 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> When I was debugging the reason about why the skb should be dropped in
> syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> general. Thus I decided to refine it.
>=20
> v5:
> Link: https://lore.kernel.org/netdev/20240213134205.8705-1-kerneljasonxin=
g@gmail.com/
> Link: https://lore.kernel.org/netdev/20240213140508.10878-1-kerneljasonxi=
ng@gmail.com/
> 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new
>    one (Eric, David)
> 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket
>    allocation (Eric)
> 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> 4. avoid duplication of these opt_skb tests/actions (Eric)
> 5. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> 6. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)

It looks like this is causing a lot of self-test failures:

https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2024-=
02-15--06-00&pass=3D0&skip=3D0

due to tcp connect timeout, e.g.:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/466281/9-tcp-fastope=
n-backup-key-sh/stdout

please have look.

Thanks!

Paolo


