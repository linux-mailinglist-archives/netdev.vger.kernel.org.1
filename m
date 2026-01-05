Return-Path: <netdev+bounces-246981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969ECF3322
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3418B3135402
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09C316900;
	Mon,  5 Jan 2026 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2uNJT5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F83164BE
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611041; cv=none; b=VqdDZ28a2B9LU7kv80P2j33+ZOl8YxObOiq3jhdumNUtJX2SDs/N3lou0Fj7sNom0xxLwuQmS7LYmSFWwlG/dwJLb2l965P4iQPIA3+FqrAJgzoqWbakAyqQd8bWWW4VW0vgZC2Ka3xvcQ1cv/72UOPz8GsEA5ErE3d7BMuyPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611041; c=relaxed/simple;
	bh=eAatKLFvaOZ6CH7onhwEfG1fgSz3Z+wk+EfYxr7p6kk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=fQaOaQLDekSADQhro7YGgI90fkt38KYgGh7b3cU5OJFN/Hh+SZ1Y3Rnn6eezndh5fqpHTVPD1rdGSEFtEaEyZC+9XFMXArxNaQsixJ7Rfm9VWisVPYfw0GjviPATKRrbjD78yEOAAfYLR7nrA7Bh3bka3TuyIenNfAv+5ma20j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2uNJT5D; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c213f7690so10995923a91.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767611039; x=1768215839; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fWhRtNXtcd1Is3mmotGwePX2eEnpzBQr84LcDgc+1w=;
        b=N2uNJT5Djm0ox4jO5GXmUH1mdfQeToXfYPll1p6E25Hq7jQGbr+TFPB7HJPl3Go2TP
         YXLmpVOWHJBNspiccY4RJ9ayfDEUxY3fvsUrmozq0YlTJCo/wv0p8Wam6bHHEe+yUJN+
         NXWaBSUTaKramXncy/+WE1KuMzL5dfaflTKtgwOmo9PzcIdJor9EgA5SdiJpV/oApq5T
         yFAOUwVDNWYWOmZSh5Uipycn8O4wLdHWHUS3a/y0qwaJaqkZEUcaVPB0s6KQjuT3mnV7
         7Lq06aOin258ooXUE8zBMwFVdW5J3xwKnKFlT6mxkfuxoeRLVbFP4ZKkHR9xO6tuYAoW
         6lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767611039; x=1768215839;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fWhRtNXtcd1Is3mmotGwePX2eEnpzBQr84LcDgc+1w=;
        b=cfGj78z0+Mp0GsVr236qMk3XBaD+9gav2biJ3YmQZXI3No/VG1lBeKasR0GowprUFi
         DD54qQ1SX/4VLcaf2TKWMe1ArOBvC4LIHvYIqvyHBW9fN01DhjXZSnnPhI5Bx1p9/VJS
         WyokSXGFetgqU6LKuV45JaLxs7/8LiAgQMmIQ6SjMQZaj/J8fiob65erb9qSzE7sFQhx
         V3DzothbGmmgab8ZK60RTKYvPoaz6p2Z3uCEIyNQJTXBA8jPHk+HFuuM/VM3EtH6Mr9U
         wN3OrHyb4vruxVPmHpBGyDnsLk//CX5NPmgeQfwUXbQKhZiQcsi5L3/Q8k8ValNpTPMm
         43fg==
X-Forwarded-Encrypted: i=1; AJvYcCV3fDKpX49XAN30djIE7oZprkOdXlpSyGtUW2WSm4nAErEkE92NLUHUOT2cukQIambn/rNkcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+6qih0tBa1/OXYFIBKzm3wtbwvNd7sVATqvICMmZHNOdNFmC
	ILD3sk0q3BbnyrIpjNiz6gGz7eCdlOcOz39nZydB7UAX+CS/nzOqED4h
X-Gm-Gg: AY/fxX78qV190h3jVryNm9jNWiMzYT0obRx3RPGPvn8vkG2nUqe5VLJByS14twgkM6p
	Za6hT+YXa9hkqhpZeGAEHpSQoGWvihPrzK8Uu4dQ8qRkrXnocA0gjomJBcuhZuAOHw6KFghRrrX
	iG0PWtYTReejtzrTyjQ3eFQ3GuFuN/S8nfjUS4rtY+lCV+ROwJHsTB0wcC0OwhokM9XQBbiYL3V
	H4AJZxd/KorZo4/80G6DdOljIf8291MyBlfKjvYpn1UIm5rE3BOK/oWNsNLU6H7uk7sLkXm7NVn
	6AsdMBl1HpNpCZUd5clFD76QswKNXbnpy049zH9Dz5OKQiMXcO8po2j9k5frk1qwFwgDWBRqe8o
	pMM1LtwPW86yIkTnir5jc7P3FvGmA09pQd3sRBwxchy/Gl9dAGOpULVUrEuOATPhXSxr4tEbgcC
	YcbzvH
X-Google-Smtp-Source: AGHT+IE7fV91WWdYjfqOPgT7KOKwR96QUk/C5++/A0LvnkncHnRo4ejYQdhXFe4keGY4zqy+ZzPEzg==
X-Received: by 2002:a17:90b:56cc:b0:34a:a1dd:1f2a with SMTP id 98e67ed59e1d1-34e921ad800mr42058121a91.20.1767611039343;
        Mon, 05 Jan 2026 03:03:59 -0800 (PST)
Received: from localhost ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec328sm6065824a91.2.2026.01.05.03.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 03:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jan 2026 20:03:55 +0900
Message-Id: <DFGLTFD0O8CJ.1T5N4IG02PNAR@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Yeounsu Moon" <yyyynoom@gmail.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: replace printk() with
 netdev_info() in rio_probe1()
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260104111849.10790-2-yyyynoom@gmail.com>
 <d5b585f3-eb84-4c72-9bdb-80721eb412a7@lunn.ch>
In-Reply-To: <d5b585f3-eb84-4c72-9bdb-80721eb412a7@lunn.ch>

On Mon Jan 5, 2026 at 7:06 AM KST, Andrew Lunn wrote:
> This looks like a valid transformation, but drivers are not really
> meant to spam the kernel log like this. So i would actually change
> them to netdev_dbg() and add a comment in the commit message.
>
>      Andrew
Thank you for the review.

I'll switch the printk() probe message to netdev_dbg() and add a note in=20
the commit message. I'll send v2.

    Yeounsu Moon

