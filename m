Return-Path: <netdev+bounces-218758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C949B3E519
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE413A871F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FA1C84CB;
	Mon,  1 Sep 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaaVvFJN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE684039;
	Mon,  1 Sep 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733541; cv=none; b=ppOjvAtVhwiVpIQ+M66NTKmZax9TEDDtz0jS9zSb+NlH2j/zcyNSiKkLBZKJdeYLlMYYK3xpPL9EA0m2joaWfwAPbr3zttphH+yG+gtE78sp7JrJOr680an/NCIIImXmFKDwGSNRS44qWxwD8kqnM+EHPbGz1lRQeeonU2/LRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733541; c=relaxed/simple;
	bh=dIuYSDRH0rrAjqku6BMJyJKVrYj+J2ppc/T5xlhcC6M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HSUKhfiPz3rh49vfeTdYp3D00Rcw4fPXQVvQrqmqNxdQcI0eEWK0EkMWyd4dxpbt3sYCbH2yEMdx5d6auMuJ9yaUkoIiiJ4dx6jYJlo/uh0kLBmpYmtK4TBI/6ISKK5LwHmVhs98A0cJgECp6i/00YazWUa8R6hCDciVCSagR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaaVvFJN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f777836c94so391697085a.2;
        Mon, 01 Sep 2025 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733538; x=1757338338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs0k67j0oMEJLadP5St/TVYqWewj62pdAK/dtRo7zyI=;
        b=IaaVvFJNoM2e0Fm8Y/Ofzhab5AQLNd0JkbSjVa3lQSZ3SN+/FFicYvMAjBm6OSdRv3
         RplbIOOLg0GWZe3XcW1FO4Fm0SbFUfzC0px/+2BDOFgxLdaYEVk+lT8ktrGXpMq/3+o+
         gwDZ15u3oWjm0CEQcosDt4bX2CWejI4ylvR0mbsgnZkIbzs1NghQpKTCLN7NI1RrLj++
         ify+mBWneztbvOHNRvtajX002EYOndMSHV40lyC64tLW/dVYTdxfXXwfWOzEfhWPoli5
         3nM5wY5jmn9nXTo3KpeEHfVchKobjpFIJQ44RaRIeQgECdX9R6sY3gEGf9tzfLhBxkr7
         eSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733538; x=1757338338;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gs0k67j0oMEJLadP5St/TVYqWewj62pdAK/dtRo7zyI=;
        b=kxuRLpyrTeSmFjmJDJdAT5clHfWXkBmr2Fs5xK0+HqkCAhr02slOOq6g0qrCr0y9Y3
         srjxdP5pzb4pTvcjKvZ5BUqJTc9YsX1MXrB7N/hNBaiK/9O5zVvxLeQBDXoqxy5WpF8I
         aVyx3dQh3IiTOjFa7JcAcFDGTVER6gyfv2iX6w9eBc2Iln/HNx0jvJ3Ynf0TjH/HLHLO
         p439/t15LvB2jNEJT99jp8/FmrkdoOkDM5uilwiuWuwLu3Hs7pzzAncFEie13YVJFC+q
         ej32Qk3AeH1sGWTrXsmTih1OJyYL6SOZiXMxwKsZ7JkzkkJbdfG3xRu5ywyoGlqjBgPI
         JTKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPnvgnR8Zw3E0O+BPoT335HUR9Zi5FZ8k4JNOREKgZyKDpMC0oJfyr6yBquYpnCxt1tRvlFLuW@vger.kernel.org, AJvYcCWKfFfPDuBfwhxpRm1FuvhuaHgvK857H4VUlJCeHXEN76Td+NSDgzbg0GFKWRO6SoUFcekcDQJ4gUyXiO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9IbBJJG15PY73aTLz1ygk1g3UOQD4pLcET5LFPTolRAeapCf
	OIwQ0p8VSiQnEGgFStWpcbzcfs0AZRttutZj8c8SnIgpPojXuyBuczhu
X-Gm-Gg: ASbGncveP+13g42zRL1l8ExVmsLB4dcrmMksd4Sx6+q9SFea7dp4urBL6QFpNgx70tq
	5kQ5sSpdKeHahIstNYVVfXQqdxoNOBcarTk4qqCYIqinOcWRk1peqGclxdfC79jrrpDhSXab4AV
	ma2zfK5WNIm98r2sQopKQ/7nOIYe6avW1UCWAJGOM9mTSW5yuWp4BM+HNYlAPX8Yii6AYjnV0KP
	g5jOYFv52ZhcPjqIT45c2Lu1UL102NxyGBNhhrvpR/ypLMrl0IU7vxDrlrP3Bar/CqMvZMBB6uS
	GNcvHjSuXe+BPKCLqiV7yhS9IAqXUKQlY7IYVuWiklZaWx8XvwV+o9phrCzTslGTXUp28e0EPNJ
	KfZA1kXnEyyxxq2R+n8YRXDLBZkBjK6omeslahu6oEB7rIrtLjbp0ep0qqbUTYcKvVrlaTzXqf1
	MXZ8m87xFsEMWa
X-Google-Smtp-Source: AGHT+IH3XgEF6WSniy8n1VfNtddSK7rYtC+DCtrf5JZxE3JkOl2PsQ9lMirIavyvCf1CVEdSTUT5Yw==
X-Received: by 2002:a05:620a:199b:b0:7fe:6673:9796 with SMTP id af79cd13be357-7ff26eaac9bmr845481185a.9.1756733538327;
        Mon, 01 Sep 2025 06:32:18 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7fc15c829b0sm648517985a.59.2025.09.01.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:32:17 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:32:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: mysteryli <m13940358460@163.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Eric Biggers <ebiggers@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mystery Li <929916200@qq.com>, 
 Mystery Li <m13940358460@163.com>
Message-ID: <willemdebruijn.kernel.1137e554f806b@gmail.com>
In-Reply-To: <20250901060635.735038-1-m13940358460@163.com>
References: <20250901060635.735038-1-m13940358460@163.com>
Subject: Re: [PATCH v4] net/core: Replace offensive comment in skbuff.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

mysteryli wrote:
> From: Mystery Li <929916200@qq.com>
> 
> The original comment contained profanity to express the frustration of
> dealing with a complex and resource-constrained code path. While the
> sentiment is understandable, the language is unprofessional and
> unnecessary.
> Replace it with a more neutral and descriptive comment that maintains
> the original technical context and conveys the difficulty of the
> situation without the use of offensive language.
> Indeed, I do not believe this will offend any particular individual or group.
> Nonetheless, it is advisable to revise any commit that appears overly emotional or rude.
> 
> Signed-off-by: "Mystery Li" <m13940358460@163.com>

You ignored the main feedback to patch v1 about invalid signed-off.

And for some reason sent the same patch again as v2 and v4.

In general old comments are left as is, even those that would perhaps
be written differently today.

