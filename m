Return-Path: <netdev+bounces-65374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FA83A406
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3681F25234
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0D17551;
	Wed, 24 Jan 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQWgoUXp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48431754C
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084543; cv=none; b=t49IDyNTeVPW6jzT86n9ROyVWgs+rk9UeLRCJnKJfnTxHJSvvOmwSmY69Q4IJYLNONtX6HfCxJrZ0kFhvwSQDlXyqt5kZGkyk86CxzOXWcQSsT8v10WNBDIpxYcySw+2/7KDV0B+b6bk3Daucwm6PPxoqQQKrhah3v6VASmBPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084543; c=relaxed/simple;
	bh=1++CWb0Kfrw/kPdXXXs6ioFPvV4pB9fEe/UJmK3kOJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvGEij3M3/LUxaHBkbGZEEzWFBeAyeq0RY5Caj3XBGTl3OtLuc93AO6bgmcmumsDzX5JJ0E1bjEYQgARDvK0wllIBvWIrakjiGhPdmPCICPQmma5xm5dH0Rb00MFvBK3jswGjdSeEDuT/HceuU170YXCLs7/SJ9aqVwX7aPnO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQWgoUXp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706084540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1++CWb0Kfrw/kPdXXXs6ioFPvV4pB9fEe/UJmK3kOJA=;
	b=HQWgoUXpttQRRlM4unUTOp+4zhvq3ZMTd6s+yuxS1IdJ0s6YrxWKmgI0/Wv55gBxK/CBrM
	MrXPoo3XsAXYj8W5NONp7KQhu+oxWtiamCjHRJi+nU20ASGp07uG9KvFXNz9Vg06kLTH3g
	loST05FpyJIQrUCuCxk4+j1iDuzQ8Kc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-XCcGLFWVOGiJef-GCmGu0w-1; Wed, 24 Jan 2024 03:22:18 -0500
X-MC-Unique: XCcGLFWVOGiJef-GCmGu0w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40eb6c599fbso4196565e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 00:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084537; x=1706689337;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1++CWb0Kfrw/kPdXXXs6ioFPvV4pB9fEe/UJmK3kOJA=;
        b=if/leCKd6X0+m7VYXP4n9Fu+kLgDa+i/LwvapVatzHSrRhHMfgEYcRF6XSJltgeKkI
         2WtFKCCvIWT1AcKrbSShj3vv5CCO3NZC6tNguHcAAuxtDRqCU8BhACDDGcgy2xzrI85p
         oh1uqlzFvIt5ymQjI3LkRdJ6rGfIZfeoAp4Dd7VbfHI8u6J/WWzb0el8rXBhoId+FuhE
         uQtbJfr/Wz3cVpj3QNXQf+fxhkE4o/KLt/+4uuIfws8MAz5xqRx4vr7HOG/mUdHtN66k
         l22Oi8xdVKH7gJ/PtUDFyR02VAoWwRpJvRiSbVjaci7ntfF09j/m9/sdW5juKbYku9tx
         9FmQ==
X-Gm-Message-State: AOJu0Yw6L0mi4eTcZr4iYjV/+cweqEg+Us96rmVgudowXTekXAg+jo+1
	tjMNirItWAgDuQmvic2XrH7dfp3x0KdJtV4dyJucJNz2ixkP3GiBdujYxKFq4GQ9JtA5qCA1oyr
	XwO42QX1Out+w5APk0qn/eynpMEUhgx2UwMcqzeRdiUq+TRdJ3oa/Gw==
X-Received: by 2002:a05:600c:5109:b0:40e:4cae:a407 with SMTP id o9-20020a05600c510900b0040e4caea407mr1036218wms.1.1706084537461;
        Wed, 24 Jan 2024 00:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0N8JoXGYcKd2hFa5MMRpGKfUUa1TRg1GCmCSSxeO9ezDgN8YvNSCWRAj7MXinT3pQ/0nN0w==
X-Received: by 2002:a05:600c:5109:b0:40e:4cae:a407 with SMTP id o9-20020a05600c510900b0040e4caea407mr1036203wms.1.1706084537151;
        Wed, 24 Jan 2024 00:22:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm44766967wmq.6.2024.01.24.00.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:22:16 -0800 (PST)
Message-ID: <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
Subject: Re: [ANN] net-next is OPEN
From: Paolo Abeni <pabeni@redhat.com>
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
	 <netdev-driver-reviewers@vger.kernel.org>
Date: Wed, 24 Jan 2024 09:22:15 +0100
In-Reply-To: <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	 <Za98C_rCH8iO_yaK@Laptop-X1> <20240123072010.7be8fb83@kernel.org>
	 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	 <20240123133925.4b8babdc@kernel.org>
	 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
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

On Tue, 2024-01-23 at 22:20 -0700, David Ahern wrote:
[...]
> the script needs lot more than 45
> seconds. This does the trick, but not sure how to bump the timeout for a
> specific test.

You can set a test-group-specific timeout touching the 'settings' file
in the relevant directory. Note that for 'net' self-tests the timeout
is currently 3600 seconds (for each test).

AFAIK there is no way to set a single-test-specific timeout, without
running that specific test individually:

make install TARGETS=3Dnet
./kselftest_install/run_kselftest.sh -o <timeout in sec> -t net:fcnal-test.=
sh

Cheers,

Paolo


