Return-Path: <netdev+bounces-224063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA1B80595
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5044D17D6E9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B5337EB2;
	Wed, 17 Sep 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5x0Tx0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB8EAD7
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121165; cv=none; b=tCWzIM7vDJu1uObNNnPtTxLpArnjM6rW++i2/0DVHdshKQnqVztVd3SqwKN0lUSM89w5BZ2hiycRcDlIEPPd0rR18Y21lUPPavgL0KiQxWEmMPIhwUe/ZtXsuIElqRFTkDO5kN8XCjyBZ74UM0lGVtYoUtCVSKln+j8111kmA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121165; c=relaxed/simple;
	bh=4m5+b205t5+ytd/+2S10DBNWhVSMjXPhFu4Ml7p03ZY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jVxkeOk/6f3muS5z48KJuVlYBrqq/Wn3/KE8nPVUc+u/40Ne+rMM35iz9KkR40pLt3V79wmwGRnIbkXtso2f6Y04qJqxMUUADe8TojZXLpQdJYNR5PS7nGR3Pm26JaUEfPbmo5pIyM+s5/XIdHZ7KZp+mHJOGgLP4v6YIdJ9/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5x0Tx0d; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78f15d5846dso6640126d6.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121163; x=1758725963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqoXffUZLC5Mp7UpQRtT2WjM1NNBAqFwxlxYdiVr0sw=;
        b=C5x0Tx0dcd4tIEIUr/EmohVmuffIf+8Juqk3eUTh+TQPMK0UjLSdWy/HDz+GmamFX1
         6EbaEO8KKqj9TAeVKFp5gBth2Zui6XwPBK5KO2gfDup4glNnKgyzDP+0Jda7RI7YcfbT
         L4h/Pc3KRa/ho953BiXWyilDFa5lZcDIP7N7dC+QCpqLWDRdGckclU0iOl1RASReQp11
         gtHEd71NHJeleMHaa5r2FJMzodoFpTSrCxk/v1WUYA+Tdz6FbAsviHH/yi8Gf2ohJk4L
         6QYvg6HEoH+y0KlhQYr4s26bm2D0krRA3sdUBdKN+KdR8JuysIFnAH/3CT0ry0zhjKkr
         9Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121163; x=1758725963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jqoXffUZLC5Mp7UpQRtT2WjM1NNBAqFwxlxYdiVr0sw=;
        b=cmr6YyvdD6W3I22osZt+hRAayZuI4+jrTYjjq4kVw+ioihdFhA42cfNDy5iep7sUi+
         AJ2lM6/lor0/Y2s5YHjVhpEKfJ7Pe4DK7ByjrFXV/AgNUz/PYTIWVNRfyXLO0BKcRJx7
         gPrgQgTESCQshcQigWCOsvgkPGQOLo8ymE/QPnehVc1kQacgk2k0ohbvXYZLjf4E18TB
         mCLdRs5ql20nc9Bs6eIJmuGfCw55jAB73XtYVJ+qbrSOCKBZuWDB4OX2GozKZp06eCZt
         Dy3F/mRF6sL6E3S/3WS7wEi9BqqlFAwZvTUtJ33Ie6YRk0xVsZqdqBuKD1XsFDdkRxpn
         kU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfe3nfqHoRzKM60Ftw+Rj7F4Lj+H7GZHJALJWA4eaT6aW3NgvRQcnnVNi6sFh83cqzOxigAYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxbMQwnPzlnN3ELQ8yrgZ+pb0Y+aXPVP3cRxRYp3JKAdIT69q
	h5Rl7I6xXzm/3hxfWc/ZQBxMgh8U6/UgjhnJNN+/EFQJVA02H15v4750
X-Gm-Gg: ASbGncscStsBe0JbJvzXiwrZvFwAHab8PMLYwKGYgC3DrY0T7+lzoz0qv6tcU9rlHb7
	H5jBm+5bNzB5ZLt2R0ZclOVwh5WSZLLpWkAGBvDxlQo+nG3Yym/lltVTfIzZuNs52qGzXf1l91d
	kN1RThK48yuM9LEydOhQHfD5VuTrMOHTi6w/6wjg/U03RKm1lKVclk3k3A4PcsI3fQuIvWu9d/6
	/eeHL/iEZIKv2yjHQIs1HVoFwalL6M8lbufK/d6aPslq2AZV01jHzXOVT7qNMYd9MckwBjF5Ki5
	K9eZKzp6/KcTI9rBluGgnpn/Fe5JG5TrN8UNpV6+0+z2OoQZV6BA2W3r/59jyRaI/hPUnjADnMf
	WS6F39HCuLPAa2VcL9kcGEhNykcsTHVhOKjqRhnxqq1xY3JdCZ1F/EPSEUsNxd/03bk6YIlre0C
	jW+Q==
X-Google-Smtp-Source: AGHT+IGpbEBTu0RA3/EOCk+A4cqUVNVi5gTKlR1I4B13cOLnMeIPEBTCl+XJ1uVvEdBn6LWJJHNFKg==
X-Received: by 2002:a05:6214:410a:b0:70d:fd26:f22e with SMTP id 6a1803df08f44-78eccb0b368mr29783616d6.15.1758121162818;
        Wed, 17 Sep 2025 07:59:22 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763b450860asm112932546d6.12.2025.09.17.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:59:22 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:59:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.3ae4a5017999e@gmail.com>
In-Reply-To: <20250916160951.541279-4-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-4-edumazet@google.com>
Subject: Re: [PATCH net-next 03/10] ipv6: np->rxpmtu race annotation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add READ_ONCE() annotations because np->rxpmtu can be changed
> while udpv6_recvmsg() and rawv6_recvmsg() read it.
> 
> Since this is a very rarely used feature, and that udpv6_recvmsg()
> and rawv6_recvmsg() read np->rxopt anyway, change the test order
> so that np->rxpmtu does not need to be in a hot cache line.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

