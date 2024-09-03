Return-Path: <netdev+bounces-124745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE796ABEF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E9928810B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315F1D88D5;
	Tue,  3 Sep 2024 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlLrHN9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD11D2230
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401634; cv=none; b=eVxsWgqPBpJzgpeLIWOcTH6lthGXLfU1tegaG1Q9i4oM0OEEj5b3HD9HVJSXkEQKn0uP82lEC7l06zsDzf93uzZOCVZm/i8MBsal4Z1UghW+NUKXcs/ol+qfq/iHZJUWeOiqlF/j4+kBj9bCEXkGj1dVWz1mtSD5uPUbqUx9Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401634; c=relaxed/simple;
	bh=aVSWkowLF4TEuCU+fOWC1lTXqD65oM8q7Yy7s9tZxZo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RQ/vbeTY6oPtRFE9DfgNwhe/VwWz8r0LEAfu7V96hPOBEJrnA05VAlS1a9dwxOtRe67nsZiAPLACKX/aHstmKHcvgBeH83Pq9DC8k63dzS7N9bGKb5w3WL/vJp6fxicQK6WKZtY1ZoiBaZsingY+Q6x9K5mhUZPS7/KPii41974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlLrHN9t; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-456768fb0a6so33634031cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401631; x=1726006431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duT0hdK0mar1OYTlTu8x5OErwvQkPN5xNdmt1sEqgK0=;
        b=AlLrHN9tYC2Vl0cBlkLiHtgt8bMQHop0HxVcQg777oDDhymgizmXgmb8p5Gkun9Tmj
         G9I6afcus5SSsp/ohCqEa7A5e2S6ulIfv+/Cea/frSG7iO4kY0VAHZ7DH4Suhp+7DaYZ
         xW4pndZHcFwtS07wVfx6eoZB0Qy/IOjDvkD1bDZQFeqbLIr89AQWfMlRLZo6CHCeWcna
         rOeDWywite9mg7DOYG39bRTJQ4WqBjO34K+gvyjzTjctLYmX9bZxWd7VyVqMFSGI5ooE
         iQEnq4f/uYrEd/Z5HBeeNFg1Czk9ByTqNvQZh9Httas/+OC0lnfZFIkV/P0fsU1e0OqB
         UoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401631; x=1726006431;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=duT0hdK0mar1OYTlTu8x5OErwvQkPN5xNdmt1sEqgK0=;
        b=fLH7SjGHizXM/iT+/pu10uuAKbPdQ5piEtQGx/9yAL5f/qdv0NM0+xysZJjkKiNb6l
         08vfUyZIEMw+bhiKKYuYAnqf1f0HtfspfJWQkXDHTm/4OCq9G6trfemCHERz8/1P1oE5
         hlbLo8q1oFdee+hAVMa+M6FNA6J3BcQcLuGv9PKlTmPp2Uf4zpWCv+7ZTkpB3Zl4iiSM
         Paha8IU3fH8K+ctuoYVHX8EK5OFEqtQiahRwxHhjCZ2lCyf745Ua0X2iQVK6MrpY2YiJ
         3obozbSFm+XSGzlJLxk6k/WJfXbaBwfTywQrSAG6siyj9qMV9JObCLkt+NqfeWtAkmFD
         QCTw==
X-Forwarded-Encrypted: i=1; AJvYcCXzAvjV5SC7lQPgUOZT5ttE+26ARfwwTf4941KZMroEpbvFeEnl55MOxZm2WY+1zBnp5v3MHyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoMUkER3pkbm1YzBSmoFb49S+Qam7QnoYXljclp3Dd4GxmrhY
	ZDFtCbgfLpKx5qjXZbEyY3JKyg3Ff4tfP1kOi7g33piENrNOX9ys
X-Google-Smtp-Source: AGHT+IEXX4llWnX+IvHrScTJqJ0um8ooHAB3BXgeJRVcS39DMyNlHuj8KNYuqXuDyfSIvd/mhY5irg==
X-Received: by 2002:a05:622a:5a16:b0:454:f3d6:39c with SMTP id d75a77b69052e-457e2d28c83mr58155471cf.7.1725401631350;
        Tue, 03 Sep 2024 15:13:51 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82744sm53343341cf.12.2024.09.03.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:13:50 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:13:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240903121940.6390b958@kernel.org>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com>
 <20240903121940.6390b958@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> > +	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > +	    val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > +		return -EINVAL;
> 
> 
> > -		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
> > +		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > +		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > +		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)))
> >  			has_timestamping = true;
> >  		else
> >  			tss->ts[0] = (struct timespec64) {0};
> >  	}
> 
> >  	memset(&tss, 0, sizeof(tss));
> >  	tsflags = READ_ONCE(sk->sk_tsflags);
> > -	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > +	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > +	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > +	     skb_is_err_queue(skb) ||
> > +	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &&
> 
> Willem, do you prefer to keep the:
> 
> 	tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> 	!(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> 
> conditions?IIUC we prevent both from being set at once. So 
> 
> 	!(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> 
> is sufficient (and, subjectively, more intuitive).

Good point. Yes, let's definitely simplify.

> Question #2 -- why are we only doing this for SW stamps?
> HW stamps for TCP are also all or nothing.

Fair. Else we'll inevitably add a
SOF_TIMESTAMPING_OPT_RX_HARDWARE_FILTER at some point.

There probably is no real use to filter one, but not the other.

So SOF_TIMESTAMPING_OPT_RX_FILTER then, and also apply
to the branch below:

        if (shhwtstamps &&
            (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
            !skb_is_swtx_tstamp(skb, false_tstamp)) {

and same for tcp_recv_timestamp.

