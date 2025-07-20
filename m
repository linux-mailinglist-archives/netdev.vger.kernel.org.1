Return-Path: <netdev+bounces-208463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66725B0B940
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 01:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799FB177631
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04001EE019;
	Sun, 20 Jul 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="HtzYOxvi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C018F40
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054489; cv=none; b=V4wGZxHNQOGMjUUAWNWXKkRV0dXUS5QEvYJyOCfnQMhEWG3lkJtcfZem+Et/IMBro75v4vsnlYebq7b70s/G1d4eUgQ6IPlejIquh96exrMG6ge6ndKU7Mj0JlrHmz9srLlZ24z+23vu8YN1zZyW+1fv8DpMnBWqbeEro9JoH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054489; c=relaxed/simple;
	bh=NI+8Eq4VSliHky/97RpUFj10olRS0U40xtcVuNx/xxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPU2MUcwFkeP2zxH6zdyFPpMV90zxXXcPFLvqiSSQLj0binnvjKn6tLqJaLuC0nhid8lz8nROogVbj2NzMxKdH+YrertNgG3SFCE4qNDLpMIh8dCyTgNHFSY5qXIac0E2HqNFlrcBf/J15hmGjE31rR3+fo6Ukv2suCPgAAHWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=HtzYOxvi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350b1b9129so25179975ad.0
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1753054487; x=1753659287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcPHC4qI6byWzbb9o0WBjUc93hSd0obXTbOb6mbjz1M=;
        b=HtzYOxviS0l+o4JaZuJirQjwYllf4c2wQW9JMk2Pz9xiaZt/BLfu8rVVGQIsXzF8Ca
         dti2cvhfEMNfnmwSYBhUs527gv7XPQhQ9/8TGHhaAkwUOuxD30K6OURzHltu8IfCvZNY
         oO10/44orFcpZ/Aj/7N+tH9pYrRffJr2yQm+X0gHhUQyI5bEbBv753av1zAVg8e60+Cb
         xxlr9VROXWwq3f8gXLxNVHF4RZNdCKc5i5wkP6km/GYQmD9moQNxoQ+JBWd23p6I1Tkz
         RH1vUKIjk2UqYy4UzbvgNQIslx3srHmpp8dVQWyC6V5k6kr4GeoC721VA9x10MEjYXN6
         pCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753054487; x=1753659287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcPHC4qI6byWzbb9o0WBjUc93hSd0obXTbOb6mbjz1M=;
        b=Dqy6IUA7gzngnslzMI6h/TJ2sYSEE9YB+fOBlhOFMVN1sxLzilvtRezsg8TL51hWCI
         SAcKz0ShSrYxwGp+y7/lY8Q0Pao6U+0FaqCBHbMw79rFkrq10r9uweI1/Yk0L5N1N1bE
         uNwz//UtcpAh029lvbiqZJof9UvOlVXsmPgLAim8RtkkSghcP0lSC9zrnVadDb9weZJa
         uF5ACYTc881HypI3isI0uirPoCCOsbbRmmPoe74LxDKOh4H7fdosw68b+zBQKFYQdeRK
         VMXixbwvZQ+oTIqfKO+khs4P1mgBaAMCDWZdKqqaX1P6qhubbUZFH5res9+qoFt7pPtI
         bULQ==
X-Gm-Message-State: AOJu0YyBPlZPxLvlkRPRMqXFM26EZrIAs6Z4KHIBC+QfNmOs0cFmQBMI
	SNOB2vG98iqZ7HSdK9mZ+fvrL2vcMLhXCwKXCqK9QL6BkoxfVQUIURPi9ev3mmfO4Q==
X-Gm-Gg: ASbGncv9qpIat0tHCukfrYkHm8Yu0mSTfDRO+jYPND8xvT2IXDt9SzXOUcvkif8jaCv
	/QcZqd5sLCnbIvqAaUP7+iIsmKQ3lmoV7QcYNMd3EXH8xTu23kC/wvxBIvwC+7e+JEXqIpxBbYm
	AYiJhcp8TmlRoBlc+76ocMpPy+a6H7yqkOgYKkMEkUmD/VBWpiSknwcQRXhKxDZQd0RTvPWLx+T
	uPf39GZ8gKHgjqU1FhnbnPub6/ZgXf6E9JiUmWNsJEQfzws8GtJvlwYVnkIDiN8oWg7op0NCVq9
	xRbqOyqygpUR16CNkAzKgz8RaDdRemXcksCfTz8EExfPBeEw+Y61fOMnREB44bIlDD2gKaRZUSw
	j3wqvab9jMjL/SyDxD8vqk04nYd+HHOaCkyteY8zOT1s=
X-Google-Smtp-Source: AGHT+IGnY2n5r+87wwh+diAw6MEDPDp2L9ZVx3jiXiguCPHPEkPuCYIVa1RWwl21HajbqUJCvt0FDw==
X-Received: by 2002:a17:902:ea01:b0:235:2403:77c7 with SMTP id d9443c01a7336-23e2576e462mr206184985ad.37.1753054487233;
        Sun, 20 Jul 2025 16:34:47 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d5asm46380775ad.15.2025.07.20.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 16:34:46 -0700 (PDT)
Date: Sun, 20 Jul 2025 16:34:44 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, will@willsroot.io,
	stephen@networkplumber.org
Subject: Re: [Patch v4 net 2/6] net_sched: Check the return value of
 qfq_choose_next_agg()
Message-ID: <aH19FKJmOfHHbdYo@xps>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
 <20250719220341.1615951-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719220341.1615951-3-xiyou.wangcong@gmail.com>

On Sat, Jul 19, 2025 at 03:03:37PM -0700, Cong Wang wrote:
> qfq_choose_next_agg() could return NULL so its return value should be
> properly checked unless NULL is acceptable.
> 
> There are two cases we need to deal with:
> 
> 1) q->in_serv_agg, which is okay with NULL since it is either checked or
>    just compared with other pointer without dereferencing. In fact, it
>    is even intentionally set to NULL in one of the cases.
> 
> 2) in_serv_agg, which is a temporary local variable, which is not okay
>    with NULL, since it is dereferenced immediately, hence must be checked.
> 
> This fix corrects one of the 2nd cases, and leaving the 1st case as they are.
> 
> Although this bug is triggered with the netem duplicate change, the root
> cause is still within qfq qdisc.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Cc: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  net/sched/sch_qfq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index f0eb70353744..f328a58c7b98 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1147,6 +1147,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 * choose the new aggregate to serve.
>  		 */
>  		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
> +		if (!in_serv_agg)
> +			return NULL;
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
>  	}
>  	if (!skb)
> -- 
> 2.34.1
>
Reviewed-by: Xiang Mei <xmei5@asu.edu>

Thanks for the explanations and fix. The fix makes sense to me.

