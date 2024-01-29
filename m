Return-Path: <netdev+bounces-66806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56941840B9A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AC6287826
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646515698A;
	Mon, 29 Jan 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3qZdX3K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553715696F
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545902; cv=none; b=fQGXq/Ua7z4cjexMdvUYOiKwg1cC/tLHkcMPwNbc5ctNY4UwPZB0MijtCs60a99BqHx3cjjnyr+LXjL1U5XNAS0n9B+Byjy8YbxKZi0plHTRqystXi4SrRN05JZUjnDjL/secfu4Qgc2l/q0tk6Z+zYNE3gqegvDeObJvdFYv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545902; c=relaxed/simple;
	bh=2BRuyFVgIb5TO9+dXjYlhFBn6zs2JQjXvu4w8oiWPMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXnQTbhmln8AStQw4ipatx33zhvaJaDQr9V4KVgWTH47HCauQV9D65gEZOrac0MB99X7+4vnwul7EcCDwde/TQ5r4tRV62iqKXrTrARMl8q0Yc5Q8VPxz+9IIwHzzi2JNUc35Cf2ML1XjxQ7Xa/xVi2yPPKE6AU0fwBkslTWCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3qZdX3K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706545900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PrTG93nwnjNZo4an7WIc5B85b9vutnOPs+JSgyzyASE=;
	b=Q3qZdX3KAB3qGkq4QfGbR85juD8JmZs/weukLgzx25x00ZyOFQj6foeHuceejiPdhaS+OP
	p3aPtvmDz2DXwDeAz7Pi2B3RR209iA/B0q0Job4UQO33ziIeYAh2m0b1H9gWPc+EPp5LyW
	kdS4Uhz6oKikKANhsBiZLJGCkCklRrQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-hu-Iyo0fNb-w6YtgPTQgFg-1; Mon, 29 Jan 2024 11:31:38 -0500
X-MC-Unique: hu-Iyo0fNb-w6YtgPTQgFg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-214dbd547adso269620fac.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545897; x=1707150697;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrTG93nwnjNZo4an7WIc5B85b9vutnOPs+JSgyzyASE=;
        b=r7++aRZ3SkM6MqLPCG0IhmCv+eqJRwyNM5CjV/t5NwAi8O2yCc1iGeq3M1T79RgoXq
         mKzbeC2wKrX2KB8NHay3ZH2yaOAZ9H6Pq/qwrUeSwhLuRh2dJPWtlBS40AtSYcs8eZ9v
         JtABW9Yf87t4Uzx1deFL27bBhvAuU7PR0L4/WheqXHuMGD4FaTcJRD+Fx64mpbmYWs8H
         Woi+uCUSxEOErKR8rk4KN7u6+bPGzKsnGnZ7VBjPINn8mMzGn8rgarctavBAXJvf2k5k
         6xMkVzTFY1G6Lh5RCYKdr9a/PVCvtzEQCyKLxvRdVOyAvHa1mJeqessg82Utj6hk+nQu
         bu2w==
X-Gm-Message-State: AOJu0YyTO7Q3/0VdIc5u7FwXz3piJ/2lyY4w44uhrUT9C8LuWYhRoMBQ
	gtmhKWWNjJ4lCjB/3D6S3A9TcLOK1KMGeOPDSfEJbpRSU/zYuBOTb1T9vz1Vr9BdWdb4co8IJJC
	7j9Nk21J4Uue1dHtIL7Mk74JeXmDB7InpPzhahl/agDVt9DFPl9h+NA==
X-Received: by 2002:a05:6870:3911:b0:218:57b9:ad8f with SMTP id b17-20020a056870391100b0021857b9ad8fmr6937855oap.5.1706545897444;
        Mon, 29 Jan 2024 08:31:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFThX687VxZzjsxhIIg+Ch9y3yZRwFJukTobief8WTlZnd/BqsCAihyBcGhsy1V9KCABPdmYw==
X-Received: by 2002:a05:6870:3911:b0:218:57b9:ad8f with SMTP id b17-20020a056870391100b0021857b9ad8fmr6937828oap.5.1706545897145;
        Mon, 29 Jan 2024 08:31:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-151.dyn.eolo.it. [146.241.230.151])
        by smtp.gmail.com with ESMTPSA id ph29-20020a0562144a5d00b0068c524a70fbsm701463qvb.66.2024.01.29.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:31:36 -0800 (PST)
Message-ID: <d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>,  Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Date: Mon, 29 Jan 2024 17:31:33 +0100
In-Reply-To: <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
References: 
	<21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	 <20240126115551.176e3888@kernel.org>
	 <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
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

On Mon, 2024-01-29 at 10:11 +0100, Paolo Abeni wrote:
> On Fri, 2024-01-26 at 11:55 -0800, Jakub Kicinski wrote:
> > On Fri, 26 Jan 2024 16:32:36 +0100 Paolo Abeni wrote:
> > > The big_tcp test-case requires a few kernel knobs currently
> > > not specified in the net selftests config, causing the
> > > following failure:
> > >=20
> > >   # selftests: net: big_tcp.sh
> > >   # Error: Failed to load TC action module.
> > >   # We have an error talking to the kernel
> > > ...
> > >   # Testing for BIG TCP:
> > >   # CLI GSO | GW GRO | GW GSO | SER GRO
> > >   # ./big_tcp.sh: line 107: test: !=3D: unary operator expected
> > > ...
> > >   # on        on       on       on      : [FAIL_on_link1]
> > >=20
> > > Add the missing configs
> > >=20
> > > Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >=20
> > Ah, great, I was missing RF_RAW in the local hack.
> > I applied manually because looks like this change is on top of
> > something:
> >=20
> > patching file tools/testing/selftests/net/config
> > Hunk #3 succeeded at 73 with fuzz 1 (offset -1 lines).
> > Hunk #4 succeeded at 82 (offset -1 lines).
>=20
> Ooops... yes, indeed it's on top of the few patches I sent in the past
> days.
>=20
> > While at it I reordered the values a little bit to be closer to what=
=20
> > I think would get us closer to alphasort. Hope you don't mind.
>=20
> Sure thing I don't mind! I'm sorry for the extra work on you.

Uhm... while the self-test doesn't emit anymore the message related to
the missing modules, it still fails in the CI env and I can't reproduce
the failures in my local env (the same for the gro.sh script).

If I understand correctly, the tests run under double virtualization (a
VM on top AWS?), is that correct? I guess the extra slowdown/overhead
will need more care.

Thanks,

Paolo


