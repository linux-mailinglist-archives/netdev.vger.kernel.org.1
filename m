Return-Path: <netdev+bounces-80348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4F87E769
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9359C1F219A4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B61E527;
	Mon, 18 Mar 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4WZnhoB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB51FB5
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758177; cv=none; b=aqqp2S5ADXIg+vx1sYaGNeLrMbwVvBFVsM1pgcfSwGZBMQ2v3E872X8lrifRqC1K8b+whQBGz8mfjcyx3ODV5N3akd/fgAOOIxjgNU6cPqMkuzpZrqgogvtBEcE8qZKu6IdrwOVf3/kD2llLmSRulEDMGZMeJnDeQ51UxpKKx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758177; c=relaxed/simple;
	bh=uQDx6mX0dOh6mwyvgnJktKh+/5cF6nk/n1Vd6qVX8WQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRzSMy8kf9SOp7HVxqXm5DMlOnS9Qdl0EqfHmGEVurg5trzK71VkbRJ4eFjvgKG2JFMKVmVrsZaXDuMCkrLnwACtVWaZIrShqUbW/YKEzX33YuAKBxCY1LC7G2zYh1n6diHVckRSmpjX1py4d7cb3sowzHxQ60MnI8OS1H4LCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4WZnhoB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710758174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uQDx6mX0dOh6mwyvgnJktKh+/5cF6nk/n1Vd6qVX8WQ=;
	b=g4WZnhoBifST/CaIDbOKzsIQOXj4OkgMg7kdREP4HC49ZPEj48JLcIbE6pBqsfO0e+krPi
	p6oYb8vXNaLOPOvxX86Wf5GEC3IuK1dW+R6aYGpPxmogfH9GVstlZ72tBf9B5F+DNV2xh0
	pQo3m5SSL5Pg0HHiiNm3eqtW6ir3wI4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-HfRRFyK2Od-_fxojeZcKog-1; Mon, 18 Mar 2024 06:36:12 -0400
X-MC-Unique: HfRRFyK2Od-_fxojeZcKog-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4141087d9b4so1949925e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 03:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758171; x=1711362971;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQDx6mX0dOh6mwyvgnJktKh+/5cF6nk/n1Vd6qVX8WQ=;
        b=hxT/JJN/HrQ/fiOIy7rZixquaN2VeLodOfzt6oxM81cQiFRnDYIMHpa94r96va5DE2
         DDEsFwRYiC2cPnd1YqolYRL6HNJRAIKdjjbo4GDRsLyrY8QK/wyv0JnrsGvBxPKqc42j
         DtYiJtX+ZyK24x6TwM9jQFYs7PUXMWNVQxnFdKTreebCeMaX6mHQTXx0D8UgWbRxRSXH
         nMxjeLbsl8V4FZza59Hr+Y7A0mLU9s4TTiV3jE1hxLxE1m4o6FKKzavXXsVy7wNbO4UA
         d0wBn3nw3Ro5vNPgejh+GdPtCknaAY7cq4dVDxNz1K0xu4n9fTR5HQmxSRa2qv/hkuVE
         2kAw==
X-Forwarded-Encrypted: i=1; AJvYcCWa2+45R3Ead5vE73ib0fGFDG/nO1RShjr1UWSbQA7vzQApFBDgawifm5RKExb/rFlXySbvk9oKzL4pRusg4AuhjB/d6DHX
X-Gm-Message-State: AOJu0Yxqks50sTI2PobVV0ZwJN1NybjoP1+RlyStSAIoUXwPB0XBG0FY
	bKh9t1Le6K6CeES8cOJcwitn1fQMPpbrt0MDsXMpBUjeAAGjo2WqXEUKUCOAS0QZqd0nDNJQ3V7
	6QaM3LWrode6uRb7pUtFx4mjB8uG3UiieA0DkTxHBeQFUX2RyWlZdmw==
X-Received: by 2002:a5d:4252:0:b0:33e:c69e:ce49 with SMTP id s18-20020a5d4252000000b0033ec69ece49mr7864340wrr.1.1710758171713;
        Mon, 18 Mar 2024 03:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYR9IAMwKPwU12jF1WzfXH5akEYxw0TNEf0gNrii19GB8+03f+3H8mcuR1mFPVPrys4piRUA==
X-Received: by 2002:a5d:4252:0:b0:33e:c69e:ce49 with SMTP id s18-20020a5d4252000000b0033ec69ece49mr7864321wrr.1.1710758171391;
        Mon, 18 Mar 2024 03:36:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-202.dyn.eolo.it. [146.241.224.202])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d44c5000000b0033b87c2725csm9464028wrr.104.2024.03.18.03.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:36:10 -0700 (PDT)
Message-ID: <658523650c342e7ffd2fcc136ac950baca6cf565.camel@redhat.com>
Subject: Re: Regarding UDP-Lite deprecation and removal
From: Paolo Abeni <pabeni@redhat.com>
To: Lynne <dev@lynne.ee>, Netdev <netdev@vger.kernel.org>
Cc: Kuniyu <kuniyu@amazon.com>, Willemdebruijn Kernel
	 <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Mar 2024 11:36:09 +0100
In-Reply-To: <Nt8pHPQ--B-9@lynne.ee>
References: <Nt8pHPQ--B-9@lynne.ee>
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

On Sun, 2024-03-17 at 01:34 +0100, Lynne wrote:
> UDP-Lite was scheduled to be removed in 2025 in commit
> be28c14ac8bbe1ff due to a lack of real-world users, and
> a long-outstanding security bug being left undiscovered.
>=20
> I would like to open a discussion to perhaps either avoid this,
> or delay it, conditionally.

I'm not very familiar to the deprecation process, but I guess this kind
of feedback is the sort of thing that could achieve delaying or avoid
the deprecation.

What will help more IMHO is someone stepping in to actually maintain
the protocol. It should not be an high load activity, but a few things
would be required: e.g. writing self-tests and ensuring that 3rd party
changes would not break it. And reviewing patches - but given the
protocol history that would probably be once in a lifetime.

Cheers,

Paolo


