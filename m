Return-Path: <netdev+bounces-189246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3AAB1519
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5849B1899CAB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9E294A03;
	Fri,  9 May 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxJHN5Cd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A509294A1E
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796977; cv=none; b=JODT/q+79Xm4T84rFKtNK+ADsuEvRfzc0MqyW2r+9HfYCk3/Mk4nVEoT9EBiJQ+dk9+V7g13qc2rj9vZz6+l9g5ZHfYh6BRr0t0RXnNkBmu+QNN8lGAwN/qkOLj2WduZGQuXC0+UrQ93J+O40kradLd+GkQrphVymxVcJ9wf+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796977; c=relaxed/simple;
	bh=Jqua5wBb6u8opl4DfhpF8wtxQUv7n3btRcbGe+3EmUM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jnClRp+pUP6JyNbyaQeoEgA0KEoorPHqB6zy0G5DeDheSX59ls0ntPtZuwb2Wc5bvjvL+8Qeg1lXNXlfoBdNIo9TlxlGkCmNiCiG2O69XR+IZrQNmA+kauam20JYUVmRXGFqc6ShJOSA1KnGSl3VhNoTDyKe/1NL1jEiwu9ZIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxJHN5Cd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47686580529so25885291cf.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746796974; x=1747401774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUZP0RFWcvqcYymU0Mxq5VI0y3pwjw/JUMrv8IOQZ5U=;
        b=BxJHN5CdqADc0OAt8LVLLfV+oTHGN6Ut3WltqHD01cbxIdCz7zAMtEv2lNw0Srhpe1
         CPOEVEMXMzNhQSPHU2I3Mida1aDHQd+uOwEb91fRI3QokyKRFWxowWzqhvnr8ikZ5VAa
         DhKgOW1J4tBHlSFAWYVuLE2WuF322ukddKNnSIHUMqnPmK4SOV6l2BaZfH/fU4Xza8os
         sZz6nPJDNsfhgguTTuvWQ0KOmdJxkszarOXbGzswgMmmOpzy3fXa2F/zmUEbEUUd+w9w
         ZiFrrJiRONX6wQ3Ojps79jQyaOUKOD4+2Hcd+YSpGnhV0yl7W/fxBA9XV9sCNBwTDpn8
         fFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796974; x=1747401774;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUZP0RFWcvqcYymU0Mxq5VI0y3pwjw/JUMrv8IOQZ5U=;
        b=UWR+9eub77MFZX5LktQAxwBfMcfagvjkMLY4T11L9MFBqnOjAfTz7bJma6YfOFsHb4
         CiOoQDNLVxOqB0B8lJjF2WfVpBvUAnw5G1C6fnBjcsXmTkp1GheEp74deHsZ1FVA0bjX
         OZABk28SM4jJcGqw5rCzr8WUl2VHSSCjYnI6XCFKHHUylXFihe2E2kJyUnQQCQgsCylr
         rrgg953GtQ18He0rsMq9gf/+gTbSTq/qPjO1uQKGfpoG28tc7PIDuoYV6LGw/y1gd7EG
         qLYEvz3YG9PMKbwQvfmmvvBzwNPdOPboL8HX0bFllRN5zfbBVbA9VJ9+rFHlKT5HngnD
         RRCw==
X-Forwarded-Encrypted: i=1; AJvYcCXztfGYCPGhS/z9H1juKeaRidryauG5vJ5Nvu03i4W8WHzUplytoRuYWBRQnt55GaQqbDu5MvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw46LTQvXneq/mbY9iUARfUAXrCVkIEK2YtwGF/RXRFJ51fVX0
	mKrmdvKgLV6jlnGUG/JEyXqfEKjfXwL2IYBtoBPR5Gx+HO5z+ElY
X-Gm-Gg: ASbGncuVoQR0mZYkLQOWzqdA03sor6nqTk8WcH8om05ipuJvN+3Nubb+ymaEmBbSXS1
	QeICAektcSckquqWQYHHLjFT9S/VzGq0vrWv3MxHmCS4yPNl814OePAltOXhlds6UerJmeb9O0p
	fAspL6X3kamG1S3JiJYJ37EfQqmYdAefvryuUf+KXhP7jBadDfVYWn/QjBhh3b179B+Kxn+0Jvz
	ob1xadEG8v7KPIGfNtDIvkhnONynxx6rI+x5XY7MKaXe9FZl+pTzNF6g2zM+02/xV9VtfI055vv
	UU2sgldwm7azhTSuN1IDzcwdIM2NfmcEdqDsWdcz2pX1k9t3TauOG5JN0G7q+xSjbFZN+x0rOz6
	JULS/s5JqCPAlfPwAE58E
X-Google-Smtp-Source: AGHT+IGxbWsS1epORct2c6lQrwEMJD69ZnjSa+IjNQL3Op2yrKOuY+EYtEmjR7RQ7dnowdIZK9Gieg==
X-Received: by 2002:ad4:5aa5:0:b0:6f4:cbcf:5d46 with SMTP id 6a1803df08f44-6f6e47c345bmr51474076d6.20.1746796974323;
        Fri, 09 May 2025 06:22:54 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e39f4689sm13560016d6.28.2025.05.09.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:22:53 -0700 (PDT)
Date: Fri, 09 May 2025 09:22:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 sgoutham@marvell.com, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Cc: linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <681e01ad26187_2b1da22945c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250508034433.14408-1-kerneljasonxing@gmail.com>
References: <20250508034433.14408-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2] net: thunder: make tx software timestamp
 independent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> skb_tx_timestamp() is used for tx software timestamp enabled by
> SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is used for
> SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
> timestamps in two dimensions, it's not appropriate to group these two
> together in the if-statement.
> 
> This patch completes three things:
> 1. make the software one standalone. Users are able to set both
> timestamps together with SOF_TIMESTAMPING_OPT_TX_SWHW flag.
> 2. make the software one generated after the hardware timestamp logic to
> avoid generating sw and hw timestamps at one time without
> SOF_TIMESTAMPING_OPT_TX_SWHW being set.
> 3. move the software timestamp call as close to the door bell.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

