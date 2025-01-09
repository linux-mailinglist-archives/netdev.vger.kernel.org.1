Return-Path: <netdev+bounces-156667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22DA07520
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3982D3A56C9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0F216604;
	Thu,  9 Jan 2025 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2lsS6Hv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA321A23B0
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423637; cv=none; b=sXtnI2kGFJoNMU+xZQiQFGLflHR2FfM2vXgCYrjZRwrTVlNMr5Y3cHraL8h5sUuT7J0E8hq58CT5Lb5FxQAMu2Mi2xW+UrWNLydXfoVOmyD9hvi3GSkOILuTIisMDJsLfeXd8UABVhKuDFhdkblpBYIjNuRFPdWQ8AKVBgN0ZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423637; c=relaxed/simple;
	bh=XUfj3fVbpSIjRRx2madI3r/vn7KWuvdVJhCbGlLUX0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmyBRm/5iA2bp5Xa9vf7mrew+w3mj5ts84AwTxw+RmeOnXvc6S5hw3I6jczWmQKL7za0QgjIBoG5M5KJ+gYCkXf7hy9Oma6ahaE54WyNSjyv0plDprpSF8EDJyXNBhcR3NxJpVicjFizAjP91n91K6xanMTmpQ/rk+hdvG2mdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2lsS6Hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736423634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbTr0JHqJgL7USp+buQE9idSIL+0zMicCZPuKxhvFY4=;
	b=L2lsS6HvQY4W3aQgf8Z5dhtCv+w+mM/Du3VuxGQN3zjezY1SrqGMPCcVV6+/r7Euiz5moe
	WpcvHzsmV8tPDopW/4i3JazcvAGwaqPbJEEv0AOhUq9i1tGecTjsZuK20A/qYejQnqe8Ox
	mDqvKKvM/1wwZAfAsBeZN9biWwy+PjU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-p7ZoCH1NMOqUd42DHf8zeA-1; Thu, 09 Jan 2025 06:53:53 -0500
X-MC-Unique: p7ZoCH1NMOqUd42DHf8zeA-1
X-Mimecast-MFC-AGG-ID: p7ZoCH1NMOqUd42DHf8zeA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385ed79291eso927323f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 03:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736423632; x=1737028432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbTr0JHqJgL7USp+buQE9idSIL+0zMicCZPuKxhvFY4=;
        b=YOhyGc5wD1/4tj5+IpR90NCdibOp+vV9AnNNze2jZ0OUUmmSFArQ3ESmrCcTle75iq
         82w9KUn9HM35JElCSO7z0JrMGMj1aTL5JdWjUla46RlJth2mAAwjZ2f93c0/nc/B8TAs
         u//qySnh2tjjglMBPyoO5NXT6QMWeBYWvh62kiKrSNarAVR6Sp7znGaZbBFIf6ZEAFpc
         OxTF7DDi0KcGpoWmL44NnAYPoWUZr8BfVGcFcHf5h/mfJ0P6O8k+tvefSlVjFb7vmcmE
         P3nyDWtHII+NTlDvSrL48JXTYAp65m2Infz6/hpnw5jcYqTNQr0SKSjEbQz2ZNanV/uL
         i5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWQckFtQBHe31uTQMU/2uO5F5xADr5dtFQ1363+sdTSJm1NT581CcYyxItH9JbsaQEzYZvFNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0ThrIotxzzInV3U+cmsZWZAjpQluwxzfOhjoXjNyk/1I7Oxo
	PJRs7xLO60YB4216iXICWPZyTpVQeP+SZj38SqKPBSKCwaBd2cPO1MPlpYZqkuSJ92dC8jm9ugH
	dSbuCyOKU2KkWK7TEbXW5C/0OrfjfkT8IBx35EgjayDz3NBzXL4LQWg==
X-Gm-Gg: ASbGncvabXueaa0/pJDo41Ph6k8wJ2Y7nqJVQ+D/VewEpvox2fBYK1EqZb5kyYozJ/m
	atCjPMf7IZtDnwydhm57i66jkngEbMp0hIEMGqwt1J+Brfwdb69KJF21DAa2+C6ZPd5iomkHMcN
	2AyKNxaObxBwIwdOWYRAlI91s3NMSAhuETuyt7/3MkmCrn35LeuL85mrBcvGOzr5rKvZRtlz0qj
	a4Ey5NryFPn34M2XaG3sF6ZuMQZMByJ+af2pDyKWS4fchNJKSzx17ktfA8jwe8T9X3cTCyc/fsd
	CzN5ZxG9
X-Received: by 2002:a5d:64e8:0:b0:385:df17:2148 with SMTP id ffacd0b85a97d-38a8b0f2ffamr2591474f8f.20.1736423632215;
        Thu, 09 Jan 2025 03:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/MWzcidSDW/hdfBGu3TW36XgQRH8D73vpvcmlZjXx68iDBrEZB3uCj1SLB392NNo1m/2CfA==
X-Received: by 2002:a5d:64e8:0:b0:385:df17:2148 with SMTP id ffacd0b85a97d-38a8b0f2ffamr2591458f8f.20.1736423631903;
        Thu, 09 Jan 2025 03:53:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03f62sm18396585e9.22.2025.01.09.03.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 03:53:51 -0800 (PST)
Message-ID: <00d56d29-3b01-4343-8a58-0d6b31c78fa6@redhat.com>
Date: Thu, 9 Jan 2025 12:53:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v3] netlink: add IPv6 anycast join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250107114355.1766086-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107114355.1766086-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/25 12:43 PM, Yuyang Huang wrote:
> This change introduces a mechanism for notifying userspace
> applications about changes to IPv6 anycast addresses via netlink. It
> includes:
> 
> * Addition and deletion of IPv6 anycast addresses are reported using
>   RTM_NEWANYCAST and RTM_DELANYCAST.
> * A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
>   notifications.
> 
> This enables user space applications(e.g. ip monitor) to efficiently
> track anycast addresses through netlink messages, improving metrics
> collection and system monitoring. It also unlocks the potential for
> advanced anycast management in user space, such as hardware offload
> control and fine grained network control.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Please note that you could have retained the Eric gave on v2.

No need for further changes here, but please follow-up with some
self-tests triggering the new code path.

Thanks,

Paolo


