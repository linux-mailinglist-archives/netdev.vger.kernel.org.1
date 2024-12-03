Return-Path: <netdev+bounces-148340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560A9E12E8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF910282FC3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6D14A09A;
	Tue,  3 Dec 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAGleOW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856C13F43A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203920; cv=none; b=cZzOmH7q7y+Rtgm6v/FIvgIYr5bjJ6lf8FfySBLhlN9fG/46BEaTpksiK+CfuvUThiw6WQRTHTuNucmWH9+BPEc+iSsoTWRCBmY+vvmEw1vR3hHx87LgmzIYJ7khWOhzE7O2eGkA0PAIW71wRfS+q4fVLzLZw7zZd0sxokHAnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203920; c=relaxed/simple;
	bh=dAPDu76P35V5u9Eiz1an+9CbjeRrhpO1QBmWrL4w1A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMGZzhS+53W+KkifG0EwknPhFouCAMbsXsiBIiGH9Ky69G85bWRMtPffyWzE0GhFzalaIHjK8rDeZpRMKF7qQElF2NR9//t/PetQfsfr0a3ajl1BacjmaGec7ScdY1Icu3oM6jy+vNkJihhiOnvzJ+/PK2hEdzsbRkwvOiU/pIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAGleOW6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385dfb168cbso2379157f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 21:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733203917; x=1733808717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAPDu76P35V5u9Eiz1an+9CbjeRrhpO1QBmWrL4w1A4=;
        b=NAGleOW6LsiOrqDQOHxw/dK8QensebaLFGkPlTJhOghaM06BZWZ7m61+l6tob8WBDE
         i6554tO/9QtunOlLYQpsREVX/F3Ae3OgucvDnmw8AOfrbki32HTS0H2CQe26fvh/OGji
         zYOX2qDvox2gTh8hyH3iV9VuwtLeZlsQ0B3lhUU0wfTaeI4MsJUaBleJpZqQKdRF+LnO
         ekCoqYjQlLa6aEeckw1w4cD2+o+3tS5y9ewcN39mviXEG7igv0LSk/7TvXNVNeJdoazj
         ms6YM+4xW56s7+GVQjHaRA/5Ev0RWntTXhzUvLefcg8kFljzbs6SzYcShe0hE5+afdTN
         1Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733203917; x=1733808717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAPDu76P35V5u9Eiz1an+9CbjeRrhpO1QBmWrL4w1A4=;
        b=AY1CrzOuiIlL0zVchra4XuNZUdRp8M/oBpkZ3WUcQqksSuMXccEarj8/wxhIc84W9M
         2oY1RNRcnOk20vqRbEV3EKKs+Zva1skkgFcKBNo/ZfUmKbQBvo4dNzDr10AcPB1cyvgH
         qU29DvTu5Ognfq2QDFcWhT3TSR3KjSuKw+tLRCKqJV3wZakN5xswrZsZxnGoRSZyEQoQ
         iYzR8PvS6MdErBAMUNGksKU07tTAN/loCF8wVeqsuELXwDZwxI59mzhc0GIfkzo3Dpjn
         lWm7amRq06IxRAlVp5A/JzRXmcBbANmUuguyYG02skKhVdp8jxRzUgIIU08oVFNYvCPd
         CBvw==
X-Gm-Message-State: AOJu0YzwhQaO6P3iwQXo4xo16zCSBdk/wQFjPS7VmoNC+uCi3vbSvbcO
	ZeGSSLK45nwF04XQyrmhlUMiRDb+W14ZC5aeVo851ee9o43JlfOVNSjjWrZCwHMM2kX710ZA/O8
	M6UZCy7iIDo3OaFFU2Fr79769ctg=
X-Gm-Gg: ASbGnctXgoxX/el1vUhzLAC4G0r0xVJ3TN0+YkdAPehukx/PeVdUJPN9OePo7sjTcSD
	vZxH+WmjPnKwo3n0+16D0gEX5+IO06Ydl
X-Google-Smtp-Source: AGHT+IH3x8oEor3RZJZAQrj8gCKGf0ZetDa5DJpfh/Qt2RsXz5IlRnn1kQ6zVYoqtfJm3k5QgolUDaBimGMcNdTW+0M=
X-Received: by 2002:a05:6000:1f8c:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-385fd419f39mr943555f8f.40.1733203917256; Mon, 02 Dec 2024
 21:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128212509.34684-1-jesse.vangavere@scioteq.com> <c3a018e5-01f9-4150-817d-ac37ed09a06f@lunn.ch>
In-Reply-To: <c3a018e5-01f9-4150-817d-ac37ed09a06f@lunn.ch>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Tue, 3 Dec 2024 06:31:45 +0100
Message-ID: <CAMdwsN9DSk=ANXoExsyEYiFaLvN5=V4-CJerpotykLZcCHePAA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Make MDIO bus name unique
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Content-Type: text/plain; charset="UTF-8"

Hello Andrew,

Op vr 29 nov 2024 om 15:54 schreef Andrew Lunn <andrew@lunn.ch>:
>
> On Thu, Nov 28, 2024 at 10:25:09PM +0100, Jesse Van Gavere wrote:
> > In configurations with 2 or more DSA clusters it will fail to allocate
> > unique MDIO bus names as only the switch ID is used, fix this by using
> > a combination of the tree ID and switch ID
> >
> > Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
> > ---
> > Changes v2: target net-next, probably an improvement rather than a true bug
>
> net-next is closed at the moment due to the merge window. Please
> repost once it opens.
>
> This change is probably O.K, but we have to be a little bit careful
> with the ABI. This name is visible in /sys/bus and udev events. In
> theory somebody could have scripts which depend on this name. I doubt
> such scripts actually exist, and if somebody reports a regression we
> will need to revert this change, and do something different. You could
> for example look at dst->index and use the two part name when it is
> not zero, one part name when it is zero.
I thought about that too and came to the same conclusion originally
that it's unlikely someone uses it, but you're right that it's better
to be safe than sorry and that sounds like a good workaround to that
potential problem, so I'll adjust that in the next version when the
merge window opens, my apologies for not sending at the correct time,
still getting the hang of contributing.

Best regards,
Jesse

