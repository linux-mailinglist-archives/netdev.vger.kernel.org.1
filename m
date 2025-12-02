Return-Path: <netdev+bounces-243219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDBC9BBF2
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF8864E180E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092A1FC0EA;
	Tue,  2 Dec 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnwioI+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF441DF74F
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685133; cv=none; b=dgahnw9vYawg/fHf43ow1Hlp1rTrSKc7KNwB0yTgIt/PN84HIIxxZUkSgPT0L2yYmFrH7OLrW/e5rPK9IMZc6RdT1TRda9stW5jkHQTQORqO7HnF1N9BCPii3e1L9UuS3yBFbKJ3P2D7OD3a9wTusRCGggVAXQBwOE36/ZPCqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685133; c=relaxed/simple;
	bh=oZkdykvJtHXWigOXU8GpVM5RcFKAy2Fn60LRXWVBZDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cy5GJBXSDcxf2N2MfkqZgWu/e97TabEvqc7KanJANzTkwl+UTv9u7Xxx+Wim9KAwxYElh4MoUffc0Ey1j7I1zkCvQVJeO9OHSpvA902qvbkNJv/CJZNaLj0L0p7PPS3xW7q7iRgqyFnZw9fZLuYpfNePTVxKt/HYdO5f5olWooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnwioI+m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298287a26c3so65529425ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685132; x=1765289932; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oZkdykvJtHXWigOXU8GpVM5RcFKAy2Fn60LRXWVBZDw=;
        b=VnwioI+m3KpJIRXOhyeu8kHtXQ8DCRfaSMIcy/AJc1QSS5kwYhxKLuxwNtEKIAU7DZ
         l0ybGHFmE857N5gU8iOaGIFnSC0NB9syOBwO24e5Anyc9WuJoGSj8NJA3riWtEqQRm4C
         J0ACOdgzc0jnWc5iIkhYiDqj0cDogAYafaGCxXjlT+hB1eIq4KKOMcr5SXddUurOwqbT
         zpF1T+QCNB0e61lrmyk8qFOLG+a82XBjLOC+2Dbmz8JKB7eTs+VkX/tdZKvZVuS5uPAm
         7CYVWDbuERPwSzzFRlVNfosaycQHJZc1kmvQFJ/teO4I+nJkoSmIRQR5So8aTrmfS+kv
         iHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685132; x=1765289932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZkdykvJtHXWigOXU8GpVM5RcFKAy2Fn60LRXWVBZDw=;
        b=JO/Av/ajsfWSGVsAAvnE+uFWA/vxnBWsRg5wqIcCmTs9Otc8HT6gaLnwH+wVg06ZlS
         kIXNhZaVJ6IqtWwIBQ1XEVQnVYG+oAlQIN6aJToYDnoRD9DofSpjeFOZ+7gy9Yg+pm5I
         5XdiaDaX+Zdhd5wdSQCvia7V2D3wLvxyYixp8qX0uwTPLdgzUc5LL+A6qa29xD8KzrIv
         luKVJKDJcwF73Z7J3SWJNk97VRJdFTyGh3shub3pUUEdlSvz7zhbq86JFsk3YGUgXux2
         vDniFJKL3PPQP30JLDqT9jympikj4KwZRmbisW122Z9uwpmZeu1qSP62elw+Gg++arQZ
         +pbg==
X-Forwarded-Encrypted: i=1; AJvYcCVdW73BTucqJidbDVvgGwpe1gCaTZwNsJowswi/M/pP0vDx6qeRLLfTJQX3zq9FOpq1raI9P7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBPpr7qghl/w7DKUkjFEdy22rkMESl8rygRRemaYd90mkL+nX
	gN44M/UMqIWtLw1iNTvsq1j/onwxyW4xKfsH/TxdHWGv+L6552UV1gbN
X-Gm-Gg: ASbGncvpajDb87pi5TCTnPueiAL/XLMI5D+k+qiTfJi112hsGHHepqOOepdyk561hwO
	tVY77Kkk4hsFBnP/kqNQ1+1+XvuxYMAScwZZEiqS4eBVQCTtooNUPSaOJJb7aiqm0po6XWrP01X
	02Ru838prtD5hWHYQEEE0+VEcfniv7fgWjGQIHmEe8oLZDgf/yvIQZpYdHVePy38J4tcjvpO+Yj
	4gRZDbrOaECyC7bFYjD5uYzVbaz2bTdnTMuUf1i5jf2XSQMfl7Ry9+6MZ8ohg/XJ5BBVHCHl8t/
	blOOKptqUS1QcXmpliovh7gSH7Sf7xaa2rjwqLNiNybUb3cCLpLylpxUy2IyrOCVl+ekNI/aE/d
	ScyROD/GuJbTfMOGsc/CGNXG+zBICV5M531Byk7Ot3GgqkAbfC9oaQofBCioFEANNRelxbwifJQ
	02kxXhHBR1H9c5
X-Google-Smtp-Source: AGHT+IEXVjMF/gLtu0SpMkt//7+TIhu+AKR4+RCT2p7BygOrI2of0LrhuPfsmy4VQRAuo+vTWYeMvg==
X-Received: by 2002:a17:902:f60f:b0:295:5864:8009 with SMTP id d9443c01a7336-29b6bf5c885mr447803385ad.44.1764685131733;
        Tue, 02 Dec 2025 06:18:51 -0800 (PST)
Received: from [192.168.1.4] ([106.215.171.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde2350sm15354312a12.9.2025.12.02.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:18:51 -0800 (PST)
Message-ID: <ec570c6f8c041f60f1de0b002e61e5a2971633c5.camel@gmail.com>
Subject: Re: [RFT net-next PATCH RESEND 0/2] ethernet: intel: fix freeing
 uninitialized pointers with __free
From: ally heev <allyheev@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Dan
 Carpenter	 <dan.carpenter@linaro.org>
Date: Wed, 03 Dec 2025 01:17:13 +0530
In-Reply-To: <81053279-f2da-420c-b7a1-9a81615cd7ca@intel.com>
References: 
	<20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
	 <81053279-f2da-420c-b7a1-9a81615cd7ca@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 13:40 -0800, Tony Nguyen wrote:
>=20
> On 11/23/2025 11:40 PM, Ally Heev wrote:
> > Uninitialized pointers with `__free` attribute can cause undefined
> > behavior as the memory assigned randomly to the pointer is freed
> > automatically when the pointer goes out of scope.
> >=20
> > We could just fix it by initializing the pointer to NULL, but, as usage=
 of
> > cleanup attributes is discouraged in net [1], trying to achieve cleanup
> > using goto
>=20
> These two drivers already have multiple other usages of this. All the=20
> other instances initialize to NULL; I'd prefer to see this do the same=
=20
> over changing this single instance.
>=20

Other usages are slightly complicated to be refactored and might need
good testing. Do you want me to do it in a different series?


Regards,
Ally

