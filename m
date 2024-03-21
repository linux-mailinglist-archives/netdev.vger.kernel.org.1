Return-Path: <netdev+bounces-80999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493888577A
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785E01C21555
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D527456;
	Thu, 21 Mar 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJjXeciO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE11F95F
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017109; cv=none; b=jeZvxd6r1eNzC6dta+/loB1bHqk40lgZK4YeqfcsQyKEfMg7Ih3AEAfzrfxOUsEal9w+wAKGx6roOqt/dDF+9vYZAx09SSipR0o1+41TlePpPct7z0qpWeDuQDZQ4wyECERGZRXOc16ZWfVV8WkydgDG2/+n+0PmOdj0qQT2f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017109; c=relaxed/simple;
	bh=qrAPSr/2hKJt6tofgtaxEuVTZ83RATwk68X5umTxr+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/IkeqpZAsg+Cdh1sRXRla7OuT2cJ4uP/Rw9sfEM/McKL7CC8wIcGjMG463L50tM9S19vZ/wGZ+ays8coa9tK4hzuaord+Pz8/1kByGmSu7bxdmY+PMAAZlm3YOy4Bf6mHycl3XnH+T/3+dWNj9r6puqQ4jAsB8IWKK2VmbnI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJjXeciO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711017106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HWutRb+BC/KyXEZzVnQQbmesF8Bx2Puf/xuEZBqN4Z8=;
	b=VJjXeciOSLWcgREZ1Nl2633Hl5XMInFuCT9G9M30afc3DhV4LHwHcElVBtU5Mr2aBPV99b
	Y+XSE4jk1QfdhQe21UtECQf5N5zqcGGOzlW2/J9W1h4MCT5o2U6M9h67vXlz9jFhm0wWC+
	3dQWuiiG46dZ/5MEvI7/HGj/cVnQDq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JiSEIT15OsWsUsPE3H80Yw-1; Thu, 21 Mar 2024 06:31:44 -0400
X-MC-Unique: JiSEIT15OsWsUsPE3H80Yw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso164480f8f.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 03:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711017104; x=1711621904;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWutRb+BC/KyXEZzVnQQbmesF8Bx2Puf/xuEZBqN4Z8=;
        b=PNp3iLG4gMa/rWQiKINrd2Coqx+NwMUNjZxrFTjN5F0nQnCAOCJKXWCx2TNYEHt369
         qVz4n4ifG8hT3ZMkH+xi+Zw7F5ORDaC8ip8XJXGYiw5Ehv3WWsIog7Tf0sBTsMEva6vq
         1yGWlDHnaUfmF//VcTKOIWLum7bHU3/brgpEQ2vk0XPP4TtANlPZ2sKX8/SxN38fMbji
         VVsZcDO4npzFyfSuVhMNa3Yb+cZyeFeQ0SSba0RfMA+nWaE/k+5WfhJp+VkWxIPM9lK1
         nhah3mniEoW1fSyQ6en143bzxnS3La/QZdVyVxxvREX8Fakq9xtR2xN06+kv+cr/5lPW
         jd0Q==
X-Gm-Message-State: AOJu0YxU0Px7otUXVosj80EdEoOoH1TZu/ye2lxOdFjH6WCIOfpywcD4
	Gvd/8OlKKo+Df1GyK8sb43hleE8NnDB3x9VsLcm5LH80MKFyAnUWpypGWbr5zaIzyA54XC1i3BO
	9y5FUP8We7YO22zFNVnKyYkffmGjar8wcsavZcJqsllasgdAxTlndxg==
X-Received: by 2002:a05:600c:3147:b0:414:6460:a249 with SMTP id h7-20020a05600c314700b004146460a249mr3156058wmo.4.1711017102362;
        Thu, 21 Mar 2024 03:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESPfYwj5iH+DOxNWZXZW3pKfza1SJa5ciczEx2zDnjKImCW11Up480LLm0BwgvJfi9pL7AWQ==
X-Received: by 2002:a05:600c:3147:b0:414:6460:a249 with SMTP id h7-20020a05600c314700b004146460a249mr3156036wmo.4.1711017101976;
        Thu, 21 Mar 2024 03:31:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b004146bdce3fesm5056095wmr.4.2024.03.21.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:31:41 -0700 (PDT)
Message-ID: <e5e430e6c6fd079847cb7547b96c2cab70906abb.camel@redhat.com>
Subject: Re: Regarding UDP-Lite deprecation and removal
From: Paolo Abeni <pabeni@redhat.com>
To: Lynne <dev@lynne.ee>, Florian Westphal <fw@strlen.de>
Cc: Netdev <netdev@vger.kernel.org>, Kuniyu <kuniyu@amazon.com>, 
	Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
Date: Thu, 21 Mar 2024 11:31:40 +0100
In-Reply-To: <NtHhf_6--3-9@lynne.ee>
References: <Nt8pHPQ--B-9@lynne.ee> <ZfhLUb_b_szay3GG@strlen.de>
	 <NtHhf_6--3-9@lynne.ee>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-18 at 18:58 +0100, Lynne wrote:
> Mar 18, 2024, 14:18 by fw@strlen.de:
>=20
> > Lynne <dev@lynne.ee> wrote:
> >=20
> > > UDP-Lite was scheduled to be removed in 2025 in commit
> > > be28c14ac8bbe1ff due to a lack of real-world users, and
> > > a long-outstanding security bug being left undiscovered.
> > >=20
> > > I would like to open a discussion to perhaps either avoid this,
> > > or delay it, conditionally.
> > >=20
> >=20
> > Is there any evidence UDP-Lite works in practice?
> >=20
> > I am not aware of any HW that will peek into L3/L4 payload to figure ou=
t
> > that the 'udplite' payload should be passed up even though it has bad c=
sum.
> >=20
> > So, AFAIU L2 FCS/CRC essentially renders entire 'partial csum' premise =
moot,
> > stack will never receive udplite frames that are damaged.
> >=20
> > Did things change?
> >=20
>=20
> I do somehow get CRC errors past the Ethernet layer on consumer rtl cards=
,
> by default, with no ethtool changes, so maybe things did change.
>=20
> I haven't sacrificed a good cable yet to get a definitive proof.
> The cargo-culted way to be sure is to enable rx-all.

I did not consider the mac-level csum - thanks Florian for bringing
that up.

Yes, you can disable FCS checking on the local host - for some NIC at
least - and AFAIK that is the only way to receive csum corrupted
packets.=C2=A0Delivery packets with bad FCS without F_RXALL set would be a
bug.

And you need to set F_RXALL on all the intermediate hops.

All in all, the use-case looks very thin at best.

In any case, to  step-in to maintain a specific protocol you should
start first contributing. I *guess* a reasonable good start would be
implementing UDP-lite selftests.

Cheers,

Paolo



