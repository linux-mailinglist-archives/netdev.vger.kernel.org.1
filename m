Return-Path: <netdev+bounces-238497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A7DC59CEF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4371B34D6D4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315931B80A;
	Thu, 13 Nov 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apJt380X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEE31AF3E
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062838; cv=none; b=oimnS3vnU8zD88NA7w/RQZDQYib009tDSTRvAcRpXeWbmvwwpGLephNU1EOxUg76nZBu9axHoQg/eX4MWg/MXqbSlTmayGEFObugiVD4btDun25wFz/MpdtoJCjzRoS4EhLymHnDemP9mRzRhHqf6T9gb682YRryx3y9PSwkdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062838; c=relaxed/simple;
	bh=8D9ndGRNEkl1RqTloTob3duuw/bnmw/Zkg69UnKPhKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCuvByUKX9j5X/IhHZwWyJggnrfAeDTGqgpwSBvB6r5eG9D1+oAkxb93dQd+Tbx4a5skviRuavD1McrRtyRYqO/1Tq6bwts8ej5CFIDKiAo+bLu3Swu38adfdm98viymQ8+nFEeaYlbvlP/oH/yqNtqxbY6fHE7e2wIp6cULISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apJt380X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632cc932so5907045e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763062832; x=1763667632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7/U/QcS+GCOoTMvpa+RqVAEgG1WX6woJ+60ecohtLo=;
        b=apJt380Xs+H7FeopVNA9UhPu8Rg+lQUkg2rDojqg72WN6Rf4XDrhLVZX++C38ptiL0
         9fywEj1xRF42GnDMXZx/EngLCRIOv6Un4TDSUTiF1EH/+rJB+dZNaCYTz9Cti44aeiK4
         RgaoKz4Fnzobkh9+b5A9Ahgvc4wElDriccgEJQQmoS5Zh62fbuKe9a5Xd8bXqW6gYbyH
         XcudTVP3V2dgjtd7+JMUBwRXgL2ykqp8krXYwbv/6n3bS8dZAU+B6u5O8aYTN6w/lxir
         lFXaOYgZ8zprPG4p4dEyMRaNi0IcuxBxY7I19KrcXq9/liVdYCPeKMhThrP1tCvC6dse
         BmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763062832; x=1763667632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7/U/QcS+GCOoTMvpa+RqVAEgG1WX6woJ+60ecohtLo=;
        b=a/RlrvUoiUCkuHXydzyamJr/WjKibt8V53ppS9Ea9M5TYZr00VjLbD0Sz1mPX36xoj
         UKR485SJnEEfLFY8xi7/DSagRREhEBJGP2fU9z4um/qh0n0WFTV03Ch/7kyQXZfL+1iR
         Ix4ry8yf7JhaOZJvEfjPC5TYAL8b+l6PRwHQ29ImZ8Pih720rrhlMoRgXVTFci8XjTUA
         WjUKqtKP+BFKq8MC1QWPIPTUfrer7Pp5eYB1cKKao8riVXyI0cx6ZKD3DdM77u3QzZ11
         swqW6EoMy67PtYr/o6XFEIpjo+ggabV/X69DpP/fDGIN79/WJgYf/NQTJUOLP3WhVPoD
         M+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXoY9itCa4+8ZV5t+bKJ1GNCfuqgg1qbMO+cwcA66LPbmy8bj08NtcL4NsAFRmHw+w6vLbsWqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Tz1BN8igNydcpdIaIt8zem/f3cdFmCfDu+WxcgykXiDtZQmR
	M7zo4YT0FpB1/Ixr59Opg3PB6wSVATvP/eKOcXqdWoDsYmbXjVKxM6dt
X-Gm-Gg: ASbGncsoKwpzYZmP1zJ1khgBp39MdGcUEKe+HlQYKdzZFBkfFhnyNeLXSh5WRK4qnTI
	GE6K+XDA+8oh904CTgFRLraQqXOgXLq7VH4r7adpe/JFMlNWylSzYpc9C4p2f5xjKlr9R4YI4MG
	/0UkgPaQbKyUNEqWeM5weIJU6S6nD/a1I03Iz3jfS/usggRpRvH7kSsHPtrVO4qmLt2LXyqv9lY
	w3rNmKbMq/h3BnzWcNSAnsyAu3crB5HtzUY3asVZQD9eUAvyxuwhHwCFoDy3FDWZmd6aIitZnMu
	F6PboSAtmDXFD/DL+JmUpzKkeE2ymoJxXRiflsM28LRn4FlXCQHT4nh8AUNfxD6taGyOHr9GZZ/
	o4D6+OcgDC0UetHQaTwd3iV8oe8cwn5QCnCHXPh5A0tjprC60iCv0n+XYm/lPU3IZqKd3NB8tko
	t+6Smo0hAKl9ihDo3YnFi+Wx6rXb4JOqRmHG/qPcJ1rCWmcbdJSeKi
X-Google-Smtp-Source: AGHT+IENcCGkJ1HSrwt2e6IXzxZefrC/yqGwehFDalfk59L9dLVxWyncqxmuN4tp8L7WKYVEr6E1qw==
X-Received: by 2002:a05:600c:4f93:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4778fea6decmr7634155e9.28.1763062831746;
        Thu, 13 Nov 2025 11:40:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c88c068sm50044105e9.9.2025.11.13.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:40:31 -0800 (PST)
Date: Thu, 13 Nov 2025 19:40:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Mitchell
 <scott_mitchell@apple.com>
Subject: Re: [PATCH v2] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
Message-ID: <20251113194029.5d4cf9d7@pumpkin>
In-Reply-To: <CANn89iJAH0-6FiK-wnA=WUS8ddyQ-q2e7vfK=7-Yrqgi_HrXAQ@mail.gmail.com>
References: <20251113092606.91406-1-scott_mitchell@apple.com>
	<CANn89iJAH0-6FiK-wnA=WUS8ddyQ-q2e7vfK=7-Yrqgi_HrXAQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 02:25:24 -0800
Eric Dumazet <edumazet@google.com> wrote:

> On Thu, Nov 13, 2025 at 1:26=E2=80=AFAM Scott Mitchell <scott.k.mitch1@gm=
ail.com> wrote:
....
> I do not think this is an efficient hash function.
>=20
> queue->id_sequence is monotonically increasing (controlled by the
> kernel : __nfqnl_enqueue_packet(), not user space).

If id_sequence is allocated by the kernel, is there any requirement
that the values be sequential rather than just unique?

If they don't need to be sequential then the kernel can pick an 'id' value
such that 'id & mask' is unique for all 'live' id values.
Then the hash becomes 'perfect' and degenerates into a simple array lookup.
Just needs a bit of housekeeping...

	David

