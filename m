Return-Path: <netdev+bounces-245485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A0CCF005
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9943C304D4BD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F282E7BA3;
	Fri, 19 Dec 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtNRol41";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/FXJW5a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55382E7622
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133374; cv=none; b=c8pSdy61dKTUschZuOy2taRY32pQ3z369m+5fsPmozSix3z74N1A3CYf2d2y+mI321Kblz5FXwurJ0xWefgk1iHSQpxPqj/U6bPvP5Eg8sAMDRJ4sEoY5PuOyshSV+aMJvJ45hHkEkw4+WjRZ0btwGJVQFZY3OnaN6yHTAfr6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133374; c=relaxed/simple;
	bh=qKWYtO27fwL0p8IqkjSKZDsrlmITXI5UnxS7VwAJNcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuXwxwkL9plDi2tQLdZFS9DIjI1H06IgCuivTVz7vwDxTNmcW516MH2Jw9DR0D24/BGvR7VzozxRvY9hAamStJ1lb2VALVYNNeereZ05ymAImR9nP2XTAdU1DkxPq8xbxbe4H/a8DEKTywaa3ibg9U+hTX73d8QRUYIsa/fHheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtNRol41; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/FXJW5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766133371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+LmCkBXQxPt5UczUJca5pzBLU0REycXjRM9Aiz4KZU=;
	b=XtNRol41j/9vBe1SW0W8kXpVsWQznIh/f8vhEbDfyyQCi0zOtSaZS04ov6H0O6nt0ysSNC
	12kWDGIzLqz3EGTuv4+WTKwEkoAVzk7dtgwNZ/P0DetlD/+7iOXsGbaNag6tGHqc2fWmOy
	1uzvesx5SxjApa4xqNR7nDJpbuK+cqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-whAVJVLXOt6WOB3d5UOEoQ-1; Fri, 19 Dec 2025 03:36:09 -0500
X-MC-Unique: whAVJVLXOt6WOB3d5UOEoQ-1
X-Mimecast-MFC-AGG-ID: whAVJVLXOt6WOB3d5UOEoQ_1766133369
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so723601f8f.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766133368; x=1766738168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+LmCkBXQxPt5UczUJca5pzBLU0REycXjRM9Aiz4KZU=;
        b=D/FXJW5aZ/bPJzOnM0ZSuuNPStu5rURqTDMEpjkhTSQnFLUcL98Wg8myAe2mYpPuFX
         c2v9aq7OVuA6ZeLTQKGIlnpOziNZpV3N2thNDe5gaODn0+EndHoZqs64rNpysaWEneSd
         Whbq9oMbTRHI+Dxx3i9j1p1ivIJBXyAEJxjMvSL+G4aHU4NA/dCjpRrce9F/49ew/UDo
         UoDhyEtM+vrUw9XPynNNgeLDyD/DrKSL3w87UwvehYitXAz081ehrp4va71U6pRwuOn4
         BxmMTPOLu5iV6WfMN7m6bvzlFIAL0JJ/frGyp73xUV/aRcGfW5pITh2u4G3YyfaihFKm
         ADJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766133368; x=1766738168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+LmCkBXQxPt5UczUJca5pzBLU0REycXjRM9Aiz4KZU=;
        b=VsrLQuS0rPuqX8hwCcF+D3v6z+oytRny3q0Gq2ESA9kLQvbRjd1bCrxIv98tIkvzwB
         jnbR7elLGmso1Eo9TQnVi2pvnPk+tLfpoybraXHZC5We1Qr2FHF5GS5d5S/Ir716KmNH
         A4qWLVz7DSit0I37s6QjH7gH+2rVmmW/8nHMdWQ6Bisypw8zgrbtuNhC9ZSBK4bv5XDI
         jie5ow8iXv40l1/AyWh2yJxf6UMfHVMk3f9BwaLuIR6rwIKrTNS5iHE0dK30vo4wmk3W
         ZThZXQoCg0S9fcJTK3KAQMSNw8O6/xerQDX2EBQPorAY28PALwzcPH5Gs7ApqQf0qCG2
         eRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0/rUoihusKtp2/m8KX8H1rM4v7EaaKGSO9LT07wBS7OS6TiO+IIet9cpqc9qsZfhv6Dv0/Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Qt6FCwBpGdiCIXAVMrhHny5Sa6ayFK1uULXVKqebPX+L5W9x
	IFoxRogOS6a1sYVhXOC10uGLyQwfGAk7Ecm9OJ+3djaVrbhWbRfuVPeLSJcjE+g/aSwdPTIGPAH
	0puUWTaU5wanxxqxeNzuOj9Udo2VVujRR9wgYXwjN41G6EATxAsfW0pnH7g==
X-Gm-Gg: AY/fxX6lHzCymQp0EFn7SilLKSm2Q12GbnBTwCRULm5A7bPRGVIwi4zkOPTQlMxYTER
	PP4hQELHO2YrCnsP4W/JuAK+29DQloIfq1/EVhsEMd/tdhFNICy8zzjl9WnsBtz5GNRcmmpvISF
	taZ8WE75aGQR+S4CN+EY8e4cdQrEIrwQxCWZY/owyZ758PZ67nJ56AZ69FdWICbjCK5c//a2kgo
	rE3z30vLLWPM26iLODw0lulNSnSoxfUjwtL3IFDdN7oY4jzFvq/9xpvfvWN54HKyfv/dWIr0Iqy
	WbTtwqVXrWvyqUj1dFltlYcA3sGmtwjPkmP10p6LP1dGRAHY64LqF+XoqToVDI0c+T4rFxTLPqG
	Vs8JAX9Eo+SoJ
X-Received: by 2002:a05:6000:2dc7:b0:430:ff0c:35fb with SMTP id ffacd0b85a97d-4324e50d03dmr2253766f8f.52.1766133368601;
        Fri, 19 Dec 2025 00:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3l8/M854CUIc4WbARUlk70ybgHB4cIqV/KpJESEJq+gaApuA+bwZRYihnBg/38edOiqLxEQ==
X-Received: by 2002:a05:6000:2dc7:b0:430:ff0c:35fb with SMTP id ffacd0b85a97d-4324e50d03dmr2253739f8f.52.1766133368200;
        Fri, 19 Dec 2025 00:36:08 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2ce09sm3638010f8f.19.2025.12.19.00.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:36:07 -0800 (PST)
Message-ID: <cdee0c7e-9029-4b6c-8f7d-62c565bd6e90@redhat.com>
Date: Fri, 19 Dec 2025 09:36:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.19-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218174841.265968-1-pabeni@redhat.com>
 <dbb8af8e-7330-4130-a62e-e05f490f19be@redhat.com>
 <CAHk-=whWLgrQjmVJk1bR14-7p9sc1wr1YvzsB=pxMTvxuhHDQw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHk-=whWLgrQjmVJk1bR14-7p9sc1wr1YvzsB=pxMTvxuhHDQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 9:04 PM, Linus Torvalds wrote:
> On Fri, 19 Dec 2025 at 05:56, Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> I have a question WRT the next PR (for rc3). The usual schedule is quite
>> unfortunate (25 is the important day here) and I'll be able to process a
>> limited number of patches in between. I'm wondering if postponing such
>> net PR to Tue 30 would be ok for you?
> 
> Oh, absolutely. Please don't think our rules are so black-and-white
> that a few days around xmas would ever be a problem.
> 
> I'm planning on doing an rc8 for this release anyway, just because I
> expect people to lose at least a week due to the whole holiday season.
> 
> The only really hard rule for the kernel is the "no regression" one.
> Any other rules we should be flexible about - they may need an
> explanation, but they shouldn't be seen as some kind of "set in stone"
> thing.
> 
> And "it's the holidays, we're all busy with real life" is a perfectly
> good explanation.

Thank you! I'll send the PR on Tue 30. Likely it will be smaller than
usual, but it should include some relevant stuff.

Cheer,

Paolo


