Return-Path: <netdev+bounces-211854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC3B1BE7B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48F318A461E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA891B78F3;
	Wed,  6 Aug 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UplxV76y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2B19E992
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445297; cv=none; b=AQqGdT5osrI3fKUqCKTo82PybMQRp5SMWYDBM1Hr894/TYHqxeUXc9WgytWeYYp60iAaTO1y0uJH/1rwh7rI+Y1YcAzGUPGKwCHkBoFUEFiZEOG4WbR/Hgt5hDlDbA39jNIjLlpxbJ90EGJddp6re+E8cmIRNzy/TxaSiuOS3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445297; c=relaxed/simple;
	bh=kQQnVC0izYvjXyrwC7oXu9KciKX+b5K//bAiSMoT01Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A33aQaJhU11PvPsOWZMWMkri8UsGX9uawqs5EIsHuegaRDpU5BborhvL2Czx4gyhAMozIO0dAtlmS83ld68Dy3KhkPTcHBqU5prDDHmA8ldDfMXpsIxjhfo7fUtICjsoBJio0oHfHtkffunpGgvd69hecprGIXBtzO1LpMWrHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UplxV76y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af93bcaf678so600827866b.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754445294; x=1755050094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=UplxV76yN2gbq+P3s54S4t31K4nY8zSj9LjyaUmLUWVWVNH4Hfm/KF77NfrfAYbCSS
         pJGfwX9fgHDt9/Ul+XNWdPyJolSCvqozRrfyY3Lj8QHtgTjFo3i2Rfx5qfrItH43NhAD
         x3Ee0ULrYl7pIUlVOD33r1j/1OClaAPb/20YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445294; x=1755050094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=ukJcI07PWbP8DrhSqj9u/+Ce2Qbcl3KVLSU+KujqQVN9tJQ3ZufT4Tf90Hhv+2soa9
         ocmRkFJ4n+J6RIGSIa5Lh2qSh610jOtmY5pYGqVQ6zBBEpUHQDkbVoEGU4aw0N7Hq+wF
         bTAgG0B+uAEIHooetTGxBxBp7uhEZJlOyThbMYk/l6Qo4sL5z1v55IbL06uj5jJUed+H
         erk5ntzj/UAVI4CaouoajMisTTGqU8i6KKonT7/l87b0YYlS0eVY0xKpJ/RTv4isSf60
         81YIgqAuYQOZXUc17BAX4HFOQfZtiCOtRuHEYltPoUWjp30tXsv9ppV7i0z9q5RVqwHI
         bnuA==
X-Forwarded-Encrypted: i=1; AJvYcCVrNW1XFNoQ76PI30Ydp+TYsgp8oKDW5ULw273PpfdnFsvEKmTF+fzz0++/s9kyyOhNw7EQsO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLFV3aL+t3LJ5iMJUhKKn4nW8FOxjJGWvUyhTxMx2+BQ6JRo7
	bF/SVy4GMb8HQ3cYvdmKop6Ci9SoRsO8QyucKXfBpZBe6FRQQ9pBhCxIg9JgVTyXgMXUi3fPR+A
	/FuDyJ78zPQ==
X-Gm-Gg: ASbGncsx0Dc31hiNOn5zXiVJoQo/dSS7W/amoXYaZMvW9MDpxrrzdJiBrp8Zl+U0cJL
	kuZL4hYgszOOPl+oqAe1cf3xOZoHA7bGjTNywxRBPj3UcAgAQ3IWpSaPP61Er/4zUT0togjilas
	aVlEYBTD2xQTFa8v5lpmf5opQ6WWoQRjaFPEFKqngfH7pw2zcCmAbtXzkg4Wznou8nZx+Qg3J4z
	zD9iM5oEe0ASfDEA0+vyKdw+bv3T2OUykqG9O7OJNgtfetrL4yZB8JYG445P0kCITzRdHEo8qIx
	dpyoEejmFf+7wUiS9++LYfJnHE4dVr9NWKtjrFwlV9Iu7LCl9iZVECTxbb6zE+/6gRJ6JrXBlau
	aeyYleEZXbeO4Kt3QYWjWsu+OkUEMFo13AYqFcCkNJqT/NfsJGw770Ei+6fA2LQaBvU/DXqlR
X-Google-Smtp-Source: AGHT+IEZhI1xNgDfeS16Lw8SGIuwuPXU1+Zjwj7ESXcRWCjR+QiCpRITIV4BZVQZy0XMKeDpr78lPQ==
X-Received: by 2002:a17:907:d1d:b0:ae3:bf5f:ca20 with SMTP id a640c23a62f3a-af990117824mr91887366b.8.1754445294218;
        Tue, 05 Aug 2025 18:54:54 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af985e63730sm172715866b.67.2025.08.05.18.54.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso9623941a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5Z6WCUd/saITYVl4DFSqsDMcGs5JIkhFJksJwu9GjWudbR3L9H5WAHwZEMldgV0fprOkiKiA=@vger.kernel.org
X-Received: by 2002:aa7:d64b:0:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-617960b2169mr747725a12.1.1754445292221; Tue, 05 Aug 2025
 18:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com> <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:54:36 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
X-Gm-Features: Ac12FXyVcowt5QK4YaVtsfApiqsjcc5RnE4u3G8HT-dXMHsAGYoNHxft3oIBLvY
Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 04:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yeah, the attached patch also fixes the problem for me and makes
> more sense to me.

Ok, crossed emails because I was reading things in odd orders and
going back to bed trying to get over jetlag.

Anyway, I've applied Ammar's v3 that ended up the same patch that I also tested,

              Linus

