Return-Path: <netdev+bounces-201584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB7AE9FD3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D608C1898A02
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A447A189F56;
	Thu, 26 Jun 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfvhiB3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6272F1FF8
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946537; cv=none; b=YYfL92vkF1QvToBokanzhF5osAoGIKbG/Jherj5NmsxfsFBimMnpJRsEh+MnYoC+2a0OUOs28s3/dCkoIX+cj6N/6oZbjQBBggmpQgvC0BwGjH4RAKmSWkr7jRqRoPuBB4gwunXGMGRiz0grDHf8BRuOc7HeoIs4z3hZZlOrNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946537; c=relaxed/simple;
	bh=JoNR50DK6Wo4wM49oFqEl8sZDhK2YjLTT76G86HAo0g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NJV358C6KVJ00FwEYerx9yjzDmitRB8D7C9GsWrE6/jKJzlvsabhSeDCoK/uQFtEHtdu7vdaV7AaccsFNOlg35yWuMQhQSe4oUo6Y+YZ+vfikN7agm5n118/AYekhOPSIXOaXLH0fgK2uTLlTSN2E3XhslMbx/5NJSCaNb9O11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfvhiB3w; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f94fe1e40so24147577b3.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946535; x=1751551335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AZURpyJzzr0G7VlvtjdVL9okOAbosXFtv6UlGIagqI=;
        b=YfvhiB3w/GXa0Kpyor148dq+oSmc9JTqWfWoYqQFe4MLsPS1KBTsENRYYfXlyAapZO
         y+PaGowMAHBbaJaVlgvCVdJ5ED+6meHBcZINXoXX3OaFfG+zL2Naejec4HMErJiyRJF1
         G7YP3kKk4y7S9nzx5Uslwz2TP3n0IEE3ld4FWfQacSAqKO2rIKnns4PVJtf78VW10S8y
         L7B3nIcI/okHgghFDklZ2ozeFNnaGwUw1VdQQ1RMpvlLBsH6SZ4S4JKEgbPhsYIlIIc9
         IWyl0qoC2ZSdk+lwJO5AeNpm2L9DGlY+yT4Afu+B0Kaq6V7JTt9sSHyv72usXytwnzIw
         avmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946535; x=1751551335;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0AZURpyJzzr0G7VlvtjdVL9okOAbosXFtv6UlGIagqI=;
        b=WCEvSV//PS7wu8MKhk/jTVfLuwQQKsd3ISlU69rEqqhxcVC6k+/W2yGqLOgsrEFx/W
         HOg6zvSCNiETElugFTR1YLCaHG34oNPB1ZQ1bznqgDW/hl3OMy6l0YlJTenSz/CyNhmH
         IvsznV5e6MW9/1CLwC7cjkZjtzkO0m3D/6hUsQgKXY0KsB6eAVtgXvNGBgVvqwNnsREN
         sSt4H4Yc39MoUCSVSpD2JLJkefQvSb2ZVE4w2/9fFHktYKScDe427/BBtUA5mi4V2AnC
         fxvJ3hYh73R8sSke9jar+NC9TyJLoOjHIPJ0I03qxh3CvglAdxlhFKkrnPWL/ZOipRvd
         Ks7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWya6GFFiXBAj4bd9dmDQ7MzelEzOQMkdM8ygMJYDfgbhJnISra/c1kA+VSJzsSmuAp5dnNfR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mzBMKH2FceteQ+lCqaXCPQqdGqP1HP5ur4wr+r39aiRIaUIh
	Lft9PCt+qA8QNVCpYIT9VBKR5lA8yDBjdSHFBb6aGCdQq0AQ5NVtJ9JQ
X-Gm-Gg: ASbGncupLhIFpzGsINvCk7oCg1lp7t0Y97Q7PRNM/qPGyGaq/INkdQWMivDhqN/kw3S
	EMIixmL92EaeFXrYVGAZrXXlYwlvFTmYy0XQEr2WxctZBNh3YRyrI0yW0UI+cdbf8gR1LFw3UM7
	AFtCFmRL6nkbQd2Ntyl4AgJangCzKxrtq844xuYcWE0M9Rb/uy4nunPnF8YkLtlT3Bu18Uh0ENO
	/Oy5hBTQP3iHx4qKk+o7se5bMS7kplzHz+olfy+K6c9B+XDldVB6NQehDrM8gYUY/pN7PZcH9xF
	2hU+pMOOLOQBTBX+navlKklNI5k42cO1ScNqmVGjnWNHUd38IYtS/1hg5zyHu4TcKd/37kUEt/g
	IvScSbCyjVLhdW3Ax4YJK6Zc0Q9qTDh+xQFoan1wGiQ==
X-Google-Smtp-Source: AGHT+IFxMx+Z5RO3uYQj/HadW4u1VeIC7k7sfjDW/6j5KoRnuiLiVvyzwonENGdyleXr5gS8ukXelw==
X-Received: by 2002:a05:690c:6a0b:b0:70d:fd6f:b151 with SMTP id 00721157ae682-715094f3371mr58321307b3.11.1750946534688;
        Thu, 26 Jun 2025 07:02:14 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c0488asm28297b3.28.2025.06.26.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:02:14 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:02:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685d52e4bd4c4_2dcd9a2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <a6f3efcf-f820-4b0e-8d2b-9b818b58fc2f@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-11-daniel.zahka@gmail.com>
 <685c9236a44fc_2a5da429471@willemb.c.googlers.com.notmuch>
 <a6f3efcf-f820-4b0e-8d2b-9b818b58fc2f@gmail.com>
Subject: Re: [PATCH v2 10/17] psp: track generations of device key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> 
> 
> On 6/25/25 8:20 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote:
> >> From: Jakub Kicinski <kuba@kernel.org>
> >>
> >> There is a (somewhat theoretical in absence of multi-host support)
> >> possibility that another entity will rotate the key and we won't
> >> know. This may lead to accepting packets with matching SPI but
> >> which used different crypto keys than we expected. Maintain and
> >> compare "key generation" per PSP spec.
> > One option is for the device to include a generation id along
> > with the session key and SPI.
> >
> > It already does, as the MSB of the SPI determines which of the two
> > device keys is responsible.
> >
> > But this could be extended to multi-bit.
> 
> The idea behind psd->generation is that the device can give each device 
> key an id, and then on rx, the device will fill out the rx metadata with 
> the id for whatever key was used for decryption. The policy checking 
> code in the tcp layer checks the generation from the rx metadata against 
> the one in the psp_assoc from when the session key was created. In this 
> way, psd->generation is opaque. It would be most intuitive for it to be 
> something like additional MSBs of the spi space, though.

Ack. This is similar to the Google implementation on github.

> >
> > Another option to avoid this issue is for a device to notify the host
> > whenever it rotates the key. This can be due to a multi-host scenario
> > where another host requested a rotation. Or it may be a device
> > initiated rotation as it runs out of 31b SPI.
> >   
> 
> This will need to be supported in any case. I think this is all to deal 
> with any potential races against getting a spi after a rotation and 
> immediately trying to use it to forge a packet targeted towards a socket 
> on the same machine that may now have that same spi from a previous 
> device key. I'm not sure if that is a legitimate concern, but if the 
> device has the ability to provide extra device key generation bits with 
> rx decryption metadata, this just uses that.

Right, the generation and SPI must both be checked before enqueuing
onto a socket.

Technically, the single MSB is sufficient, as it is never possible
for a new SPI for generation X to have match generation X - 1. And
even older generations will no longer be decrypted.
 
> >> Since we're tracking "key generations" more explicitly now,
> >> maintain different lists for associations from different generations.
> >> This way we can catch stale associations (the user space should
> >> listen to rotation notifications and change the keys).
> >>
> >> Drivers can "opt out" of generation tracking by setting
> >> the generation value to 0.
> > Why?
> 
> If the device doesn't support this capability of filling out rx metadata 
> with additional key generation bits beyond the MSB of the spi.



