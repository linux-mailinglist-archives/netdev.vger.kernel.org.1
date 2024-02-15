Return-Path: <netdev+bounces-72143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F799856B56
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9519D1F26E0F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9D136995;
	Thu, 15 Feb 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftMnwCeT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB81353FA
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018886; cv=none; b=LM9cpeugRLTXh3IfADox5KESvFdY+bFQVksFpgpXnpWdRmPhy6Pjwd0MdRv0ZiJJE+YL7BV842zYsYYEuq9/u2YnHgb1CTxGRztDbyP1/yfHMBLHfoiMb65XexJeqMH7qbS4vafN+G5vgUDrzoshYYPMRD11bRn3bzhvMlJWFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018886; c=relaxed/simple;
	bh=2nt51Mgp2aV8+Qg96ITupHU3npusE6ImfhDZbMjyfXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGzGe1FzzuB12lxxGJFawZtjM952LOqgw7j5iJdAwLoLnyy6MgWVdk34IqBmNP1FLpX/Y3vUebdfB2wapFLXC5Ss80bOFeQR6x41kjHa8d02XB1ZmSFySyneAl8g17HKgwXivMMoRZX0zMVr+hjDMP8BQxNafH8e+sTz2Bv9YVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftMnwCeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708018882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2nt51Mgp2aV8+Qg96ITupHU3npusE6ImfhDZbMjyfXc=;
	b=ftMnwCeTov8B1KLongsKtD5jZ16zHtuB3BkQ03eAR+YYpTRliG8IaI+fojkCls3vL9Aepz
	IbJiXOntx+/joGQ1bP9So/Wj4p8G5v20cvUgWRzio3KsiSSHH3JS0oDiJGPoiyRTijPm2o
	k16I4qMlNgn4omheSqg3i9tW39dQgBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-fbjXs4DnNHiILch1flbnsg-1; Thu, 15 Feb 2024 12:41:21 -0500
X-MC-Unique: fbjXs4DnNHiILch1flbnsg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41232628d57so340895e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018880; x=1708623680;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nt51Mgp2aV8+Qg96ITupHU3npusE6ImfhDZbMjyfXc=;
        b=vrrwfcL0uWxv7eJ6qbSxWcIOJl23UPzAWXYokGp7MorB2+DVpLacqpwVCI74a9jz+v
         AOuKajiyFJd1cxvijSyS6VanghWzzYDRwlVmpomVnTFrDqG262Shhn+mL02a+SdFTmLu
         7iBsOED7LphshmES1iEyMkXZPWEWVPlOhSsJNLlwcVHBIDT3rNIucvYrVyZE4qS9WNmF
         BRt8vh0AJSBHRyP6iIZFup3MWFpozOSO7HLHFRZkbYE/wx4LU2qwmV9tY8kwtgs2Ddud
         W4vcXUnay4Kqk4x2rIoAzuifhFUPb5AluqMsLl1lLL99jaYDwjlYjU1a8TX6ad4LuU22
         zOKA==
X-Forwarded-Encrypted: i=1; AJvYcCUqI3Gp9B7PqqXR8q5FSFJuT5sQBl/oFnUvUsYfwCe0BibrZWiRVd7w0AbKWee6Vaw2hfhSubDl9HpwvvZlN+2qJls+QXXC
X-Gm-Message-State: AOJu0YzLfBegz5BdqbOMAyfH9alslv7/XJXz3YFw0rB6e9RgDULaX6Mn
	Ge6sqGxHDeDe/RevPnsCk8gXzNf3quRMbvRvn05doD6T2+cP2GAXlcNHFio+db3VGn0n/RGVcgZ
	7fp74Ya1sBUAF5LZJ/gwuY4rTC7Ms/bTFnVqeW41LtizMcaAnvZl8Zg==
X-Received: by 2002:a05:6000:69a:b0:33b:10ca:d85b with SMTP id bo26-20020a056000069a00b0033b10cad85bmr1801385wrb.5.1708018879981;
        Thu, 15 Feb 2024 09:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6gPozbzyteRDfoEzFbq1eXrFspX+afEVA859A+jRqzLM37iUUdnBaTE+oiRXKJQ7ni1evpQ==
X-Received: by 2002:a05:6000:69a:b0:33b:10ca:d85b with SMTP id bo26-20020a056000069a00b0033b10cad85bmr1801376wrb.5.1708018879651;
        Thu, 15 Feb 2024 09:41:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id ay14-20020a5d6f0e000000b0033b2799815csm2648744wrb.86.2024.02.15.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:41:19 -0800 (PST)
Message-ID: <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, netdev@vger.kernel.org,
 davem@davemloft.net
Date: Thu, 15 Feb 2024 18:41:17 +0100
In-Reply-To: <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
	 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
	 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
	 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
	 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
	 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
	 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
	 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
	 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
	 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com>
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

Note: please send text-only email to netdev.

On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
> I wonder if the following could be acceptable:
>=20
> =C2=A0if (flags & MSG_PEEK)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_peek_offset_fwd(sk, used);
> =C2=A0else if (peek_offset > 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_peek_offset_bwd(sk, used);
>=20
> =C2=A0peek_offset is already present in the data cache, and if it has the=
 value
> =C2=A0zero it means either that that sk->sk_peek_off is unused (-1) or ac=
tually is zero.
> =C2=A0Either way, no rewind is needed in that case.

I agree the above should avoid touching cold cachelines in the
fastpath, and looks functionally correct to me.

The last word is up to Eric :)

Cheers,

Paolo


