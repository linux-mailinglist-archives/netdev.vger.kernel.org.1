Return-Path: <netdev+bounces-199542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23AEAE0A9E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8203A70A1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC422343C9;
	Thu, 19 Jun 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouQZ2LGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC312EBE7
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347440; cv=none; b=gViwbc/eL4OugaZoo/oCSMuSwkJeDmJPRDj8Yt9TdLhfprosaX2CMB60r6wdyOzJXN4nhchz8J6Rv4AZ7xvaOWWHzKV35sHWZwqRQUPfG6tM2RZehLxDOs85/kLtMK7AV1ViL4nUl+Wt9il28r7oRIhi82pvIicyDPubmmzxP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347440; c=relaxed/simple;
	bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvyRf92H1xQaX7mOuL02CZGq7X4gA5w9I8ByDoQAYLTVkE5LOwe1cZqhnGrmmLVt7oEQuw3ZVPfhztKfNuK5Rm4VJRVWP23j/FQ/CNIIsRMekQSRyOB8gXsCmwhsV209XhYxKmJRPn9y+256t4MKRu3N/rAxRFl/dMGf79AkfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouQZ2LGr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so131865ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750347438; x=1750952238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
        b=ouQZ2LGr/0PFqeCA4KDuupwvVP8H7CZscgUtikIsJ18+P5MMl3IZmEab226FHxr/ll
         4zFN0fKQbTkLSa7QRYqOeZlAgU8OiwfXYBMsINd289xfwgzeEkK4wRYF2H62vP5F4dsD
         haGX/BTpsIyJEvXGsvR5K0T6Q4axZTnGG00KmgUyio9QKMovZWH+uNAfiKzX6uODB9A9
         aNUafiInSUUBBU7fJ7z/9IpVWoV8snZ43j1Pz7+9LZOO04q13riYK8ElWB+8jczIXDY/
         ouUo0vGPIy6yuziBNlEZGJVui5BCiPLKYdXos1gmbiczvwUwMxcMk66TenVArsHGhaSX
         c/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347438; x=1750952238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXqBNC79E8+zULge9cmYzz8aTHkD1900PAbJWPHai6M=;
        b=Ee66MDBD9It3vHlRMStqzVaw/6sOsQ7f1e9hpzooyTd4hhaPdtizXQ8/yvwdU61MJl
         L0bCPxhnMiVtzDc46OSYeyUBv7ly1+QBHZjAibDJETDyJR18R81PpwI4Wjf476nwkhkB
         7nSnS0nI+WPTxPZJnDaqnMFlnGxVivnVvf4LI+3mq5NHlTsxKSO8n4Oq1IRsLk0kTEbM
         /w0W9xRGPOeRjii3IsBBWdw3yepwTJE126IOvV29XHC4HDlJSQuc6NdHXDDTa9o8RwGb
         TzeSIwJfO9gwleXeZlkPU6dbXlZiDpvLKTpI72KkCIIZQI1/ioucYRVMnuTTOJNA0b2e
         PyYg==
X-Gm-Message-State: AOJu0YxXorf2d9cQB44Fg7F7d7/x+ZyoG+AE+NOv8o//lXW6S6xfvVUH
	2EhoK+qiOXynjL3C/V5JUtuLCfZJd5u2mTWaPPOAeLcW+9LRjGfvbFoNMXomOxXj52GsFrNqlk+
	/DwQuosVwgA3OkPH7YzC5OfxC8irGe15jR+1GumES
X-Gm-Gg: ASbGncu8vs7m8FQleN7Af08dTO6ZDiTe3P4BwaO71Ml+aPdJBpdeQTVTzYCBlPCwwOD
	wrj1C8oN7JzKMHYKGz8OAo5N9WhxI/vtQa9ulhK6LRfOFrJV8r7uOAunyeA+nLX3hbBm/R7YRfk
	8jBMUULCRtk3ahzS1ZjxOKso7MEhHF2sY5RN60F4cVIrDZ2MKpoRVHW9c=
X-Google-Smtp-Source: AGHT+IEeijlQPpJuvXLonxzDPjlDUwYkzvUY7s0SbGkDqtAlVdPJnNp8p53qHr02gdS8vRw9Ecwmxce7UO+kYeJGCME=
X-Received: by 2002:a17:902:ccc9:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-237ce035db1mr2436035ad.7.1750347438284; Thu, 19 Jun 2025
 08:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org> <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
 <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
In-Reply-To: <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 08:37:05 -0700
X-Gm-Features: AX0GCFtbSJkA9B2FmfN23HT-G5zxw5AQXqfUAsX29ALKFUjOOk7WFn4t987JlLo
Message-ID: <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:24=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
> > Does this alleviate your concern? Or do you still see an issue here?
> > There is still a delta between our results, on different
> > hardware/configs but results are in a sane range now.
>
> Now the results a sane and in range :-)
>

Thanks!

Jakub, this patch was marked 'changes requested' for good reason, but
after investigation we found the patch itself is good and the issues
were elsewhere. What do I do here? A resend of v4? Or does this un
'changes requested' as-is?

--=20
Thanks,
Mina

