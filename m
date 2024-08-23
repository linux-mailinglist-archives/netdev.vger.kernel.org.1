Return-Path: <netdev+bounces-121256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81595C5DF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965BDB23F72
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBE1369B1;
	Fri, 23 Aug 2024 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYgjOGhB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133982486
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396139; cv=none; b=aDojtIP8fZbjbHwFDAqlxhmW+ek2IrilM7uNiAT/v3Ru1KTMMRmwAwshINXYFfp/uoTqsj/xXHDEJ5YryRItbzWpoQjCDNTTjRGtGvKxZ0+Lc4A8XVqJohUSoyqEDo8IewkN47E7cUYxK1VNCpDqA8WILh9xSvUaf0a4SGUhD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396139; c=relaxed/simple;
	bh=D0VQueHw4ULX6fOt0aSpJWUUY15BKSIWMQJH5m9D+LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6hwJhmahLZ/FY33iR3FNZn4v5TuwDk6/f0pDMHTodwERLtYaxDqWEpg0I0r06AmbzSZtqTOpKDtsgBx9AI+umt8TqdVRPkOC0dlCkLNbmNbSq4cjCWFvO/N8rkRiR2PA1km60twf8B90Ueh6y9hMpr9uFBSDVUsn9oetvGdIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYgjOGhB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868b739cd9so204696066b.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724396136; x=1725000936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BK1f8PAuYi1kpsTYpr7H+howMVtzb1f/JpVsw0UkYc=;
        b=xYgjOGhBDKT2Tyuf1btb+QeHDWmQ43rjOF25/uc+0oA7UL5gWqRVve49fBOQexTbm2
         zP8r3Ffz+fg0yCU1v634JDL4oQHT0OMEHV91SYzNpPtHJmYaVUOZBlgG/3GzCNAHoqWd
         rgGR9Kd2+W2SYny0Gt6AXVQvK9sR8idZTYFREdQyZUAiApZG3HlJuT0Wfa8RUW2RxQVh
         OMynlJvdu+k+XWFIMV3uc9i9AhCK+yptf3sWTHvuppGJy+hvL3wX4KZqlLXSbhvW6+sN
         /QvQqzyll/mccyL/JmzcfIzUgJf2A+72IebbEg4YyHLvbyRMZEoLxTw6sRQ3MlGbo3dM
         gHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396136; x=1725000936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BK1f8PAuYi1kpsTYpr7H+howMVtzb1f/JpVsw0UkYc=;
        b=IASimkEjGew8TPqhqJN+QUHFPy5OUk5ZWJfLob0VmG+6nogLBZOWZz4UEnlKe+hKX3
         Y2hpmv9w0wqzelikTL+JAHLEEkKhBDdL0ibnKCGST3eRzXg4YkXlE831j23n/hXaVo2+
         anPC3lSm7DzCGSng+v0qx4aZiToimlvNjB1Bi+ejsQQ/vY8mm1DP65SsU21WixRT2fVh
         14oKlfKiuf5uoaXaddkYAXUTgh5I5aN8ggAdqdNybqBNWzltl4jklv0x0a4N/ULszhG2
         o01Nz69SmtzL06ijwAdhb6T8TTvF4g4agTGLpelxh0jTj0ElNH27Sbef9SwTIAMJlv3w
         TGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9cwxpzEXKiK+rsME9HAcJmRdXmdbkaUE/sYXnTrfqPNSmsc/MXYrYmz6wSNl/xY/PgywdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhg6mAsrGlXR/oitN3zuIbi1Hjaq1n239LYUuQJYYSopYox9TG
	OyXyBIDxX9C+d+lbsrjYqUl0oYmJUy9qNEMsHaNBtxVzGC9oSjfMvayQWj6BJZykpZP+uZ+JNwc
	0Hu/ryp+rzNGGJ2gClTaVIYgUmMJzTrPkbCwTGWSx2xFxv4cHae8C
X-Google-Smtp-Source: AGHT+IEk4GHskWYM7w/d0tb/U+0C4679DLCirKiJQiJJedT4fy/cjLhb/7gqOBCq6xDajmC608WPSWeQHCnh5HuWu6I=
X-Received: by 2002:a17:907:e8c:b0:a7a:9144:e251 with SMTP id
 a640c23a62f3a-a86a518a383mr96776966b.11.1724396135485; Thu, 22 Aug 2024
 23:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823033444.1257321-1-johunt@akamai.com> <20240823033444.1257321-2-johunt@akamai.com>
In-Reply-To: <20240823033444.1257321-2-johunt@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 08:55:24 +0200
Message-ID: <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>, Neal Cardwell <ncardwell@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:34=E2=80=AFAM Josh Hunt <johunt@akamai.com> wrote=
:
>
> There have been multiple occassions where we have crashed in this path
> because packets_out suggested there were packets on the write or retransm=
it
> queues, but in fact there weren't leading to a NULL skb being dereference=
d.
> While we should fix that root cause we should also just make sure the skb
> is not NULL before dereferencing it. Also add a warn once here to capture
> some information if/when the problem case is hit again.
>
> Signed-off-by: Josh Hunt <johunt@akamai.com>

Hi Josh

We do not want a patch series of one patch, with the stack trace in
the cover letter.
Please send a standalone patch, with all the information in its changelog.

1) Add Neal Cardwell in the CC list.

2) Are you using TCP_REPAIR by any chance ?

3) Please double check your kernel has these fixes.

commit 1f85e6267caca44b30c54711652b0726fadbb131    tcp: do not send
empty skb from tcp_write_xmit()
commit 0c175da7b0378445f5ef53904247cfbfb87e0b78     tcp: prohibit
TCP_REPAIR_OPTIONS if data was already sent


Thanks.

