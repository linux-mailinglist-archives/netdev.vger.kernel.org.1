Return-Path: <netdev+bounces-233525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEDC14EBB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1814622D22
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D98334366;
	Tue, 28 Oct 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl7Suk0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAD334690
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658378; cv=none; b=shk5oteO/8tTnQudKfTTOSoiefpH++fGN1TkQQOTy0iV9WsBOiZVTtXtcQbNzZ/aXJB5y5s1MRw6fC4LKN3xLznm/gso388NOfVBwJlU9OGIdSQzUKYk6OvYqCRowc4TEwdPkBAXtDleEYZfk+5hxH4TWKA0UY+3xGEslYpiNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658378; c=relaxed/simple;
	bh=ew04NiQrGcH4etcxyEEAqVpzUFRTolcfu0lhK6arMX0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fQRzqWshJ9dDAOXdPzRUnYIG6Gwu4kVmSbIAhgPEbRfNPPYJvAioSqYKl04EYAfEwPx52fGyH2abeXWNPAAhPUYHMDEgFB9rH2K8HYYZtmGzLKaBjDg3wy7yUjrccu3rsZ4PaXYmJ0FbEen+GuueWW+9uwXL5kjcuXmvdXRX+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl7Suk0o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso21251395e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761658375; x=1762263175; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVMycP0wkgHyNXa+x1Z8cB6hgKt0fEPWvjXVXJxiDjY=;
        b=Tl7Suk0o7oY2dPFHXRAXFGXtlZXy68/0rW3lWLWu4YOAPokF/pYx/Cs6so2pyD0gkr
         H6qGhdMa/DRX4CeoaXuuveD3MBLakv597pQ+McN9+NsiJ81aKtraYhYHzcQKVeL0snuB
         xmr1bsRNvUeSTDax0dB3NnNN1Ahqg/YZbulmEzAI0+AnVn26oT84QQrxWNUiPHf44zvO
         skygIgc758iCMqOGiGpiyM2HE9UARsy35i5TZeEdO9mCC1CvY/KQEdkHeSrz4RRyowbf
         umUnHhq8oay/m6jsBfhfw9Z/wGwF/sG6/1RSdiX+J9TSvoN+hZnecEeJmqy3tJy0/A1u
         U94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658375; x=1762263175;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVMycP0wkgHyNXa+x1Z8cB6hgKt0fEPWvjXVXJxiDjY=;
        b=v57qrw6i9mQZQWwXi+YPyeIDDbLjGQP8cgOkaw/pzYRbQD+QUCCJvEQ8Y827lxnxsT
         kTP+SNOgoxAzu38D85wDqw1aRS33+Xkqh6pOMeRBzrnrE8kvehcLNBct3T9G5a13VKoI
         MyBG6hfSzasC/mUahqAF82+bSxCkJxrINGRES9UduzatRV8adkhoqIMqdyXnpHaiJBU9
         RA6BgAfAY2Bz2QkGNx3zRIoRevLlNqtfy0WZuOi1cupF7rsomT+waXLY5/kgYOeW2O3n
         1G7Snzrg/zfZ4rwNZnvyng8HH7UMwA0gMgYAh8SVBxQpwi8+I1xyl3rjVZjDImlxbmB4
         xuNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ae67jDJbRON70HJWK/inKrEzwKUnKkY2eVnS0p78oqi3p/cKCaYuCt9JQByWtOTA3ajEcOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgh13beIYb54esVqQOKfVvtDgJS2jOA/padEAp3QXi5xjrUXYG
	Q4z6NM3bdTFpk3OgUKWafffwayjKudaHxJf9kCqjJ8VJSgXlrw436wBF
X-Gm-Gg: ASbGncsJepayWqWDzOmLkC7RXmuvdSvlsFECZK8KUakvRvUdOuWGMuJ0MMvBpQWR7HY
	iK0IaOYVHMy4PUL6hbbTQyY2GeFq+AYmfZb4gRXQcglDkF8pQ535xsIhv7UAYqsSs3kDT7p9LnM
	HHA4fWHtFF0dxGrNJy3A4CuQzI90WmUMKS8hIDeSLyBiHg9UZOzDEJaJmb6t0wjDYPG+Y7WN5mk
	2hqI+Y6dsVzarPBq3PJ2Al7IVH/8wtaha44WGXqVD4OILaj3wwrzImspVq6XNpcsDIgKGHATyOi
	7YtHKmJqGfh+WuH0BfYUL8qx1OO1O9mpDgYzfF5zzopC0PFMyr2RY7mrWM2Q+OF3SFiKcZUnT8h
	4GBcyFRdlx7Z7C+zXtR/Kur5npZe+jjjb+OG/49p39wZoA1F1MHihtnWhQaJiH6ciytIerCUvfc
	Z1arOBSKZMBE+N
X-Google-Smtp-Source: AGHT+IG/GxfVBL74uG27E5a9IkSpfv8HBOZy0FrpVA2mqeaMFegFxoi6+G6ZUSizscPhF+QAajd5MQ==
X-Received: by 2002:a05:600c:3108:b0:46e:4f25:aace with SMTP id 5b1f17b1804b1-47717def6e9mr32367295e9.6.1761658374691;
        Tue, 28 Oct 2025 06:32:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a938:2bbc:5022:a559])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd494d5csm200191865e9.9.2025.10.28.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:32:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  ast@fiberby.net
Subject: Re: [PATCH net-next v2 2/2] tools: ynl: rework the string
 representation of NlError
In-Reply-To: <20251027192958.2058340-2-kuba@kernel.org>
Date: Tue, 28 Oct 2025 10:51:20 +0000
Message-ID: <m21pmnqoyf.fsf@gmail.com>
References: <20251027192958.2058340-1-kuba@kernel.org>
	<20251027192958.2058340-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> In early days of YNL development dumping the NlMsg on errors
> was quite useful, as the library itself could have been buggy.
> These days increasingly the NlMsg is just taking up screen space
> and means nothing to a typical user. Try to format the errors
> more in line with how YNL C formats its errors strings.
>
> Before:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument
>   nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'miss-type': 'header'}
>
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: Invalid argument
>   nl_len = 88 (72) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'msg': 'requested channel count exceeds maximum', 'bad-attr': '.tx-count'}
>
> After:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument {'miss-type': 'header'}
>
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: requested channel count exceeds maximum: Invalid argument {'bad-attr': '.tx-count'}
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

