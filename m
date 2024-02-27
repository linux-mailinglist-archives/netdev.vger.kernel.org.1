Return-Path: <netdev+bounces-75408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B4869CD1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18CF1F24295
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802B2208CE;
	Tue, 27 Feb 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Xbtebt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8601DFD6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052783; cv=none; b=rZGW8MtzWsBGDv/yby2fGi0NetaAwrNiUbTOfAZz45Eb5VNRhQ+NW8qvZ5t4D8FOwaWHAewlzOK1G9vU6ugK77qYjLkb2bOCHayZG421hYNlwaMMmXA+9912HF5FU6Vq5ijkQD7lXY/XvchP7oMX8wYo2zg+ilXHjJCU7D34EgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052783; c=relaxed/simple;
	bh=ts+Y1Vab2BNJLfRVMrmtA2nak/JCU/sSWKIUg48WLx8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YV/cigv/GwNzpAt5qX9jtFu9iqn1r5xDm8auAx6B6mona4mPMnraZmX7Yhd7Gz4rD2N3TOUs/KkjxQ9nQSjQXZoOt4sEje5i/AG14X7jPhr6+OsJivzFdTHHEUbgR2LTwsX//su2UJ6YxStQZm8mywmuAyf9I0ph/88tw6Z7uBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Xbtebt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ae087378so6085075e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052780; x=1709657580; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuLX3trz0ucQDZWvgyrRidRJi2akiYUxUx7APFQqLC0=;
        b=R6XbtebtpkaqS/oW8JJ8vuUGsU7IgJM24DYEFesy9WGbmCH7oO+ov5R9ov2Gx69sE2
         9tAp6nBOvCzJKhZcKpnuEuGu1z5jenE54Z8e6/+lQgYanCcWT4IHUJF+IZHEclzbvts4
         wJY74ZWUU/RPR9qjfSdT/Hi7x0LvayRJlhYyBQtQ+NGGp/RYFws0l1zA+Ap9e0ROCO6j
         h+WZ9AneI+fnQpKMLLY74JtpGx/9IDbiKs5vtKuXm+x6zLUDWmmeAEoGWOgXbXahK/BC
         N3StAhsU2s6mx6GGfvQc09a9GFYN6FdwPRuQUYV4FRvaySVON94jU/QaDCG4kQjus7eX
         9DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052780; x=1709657580;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuLX3trz0ucQDZWvgyrRidRJi2akiYUxUx7APFQqLC0=;
        b=IGlZX+9SMuY5wcsQAfnCtBmmUhtHht3JF0ooWvufUIhbLzGIm+xjyjcKsYIIubZgIK
         nleluQTdJHvTU8aoJtyUty/lRU5dsNFF3VrHg5xIvvI1VFckCX1XNVOPwYFtavDrfPqU
         mbjYmxC9me8QmukZYDA/BaMEJLYQpDkjnTlnYUnBApSwlsD7sjYHbUFwLiAJg71AlOnZ
         flAZiGx/2MJrVA/BueUjydRLcIzA+sD3tLMhUxQoxEl25K26UqbzMp+Q0XAsvN7cN4C0
         HaqgjfUB6phfeGFidabFCgMVbbScxHU951F/6SGMj59aZqlI1kp1sqRGd0XWuYh4/rHI
         Q/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKM0jN4gJl7lBnSx/rh9bEUTyI3aKhL26QqaWK8VGjtoX6cm4UGhZOW1gBJU+S5f+QInu++ldSivYX2Gn9zqaZJ3P1mkV
X-Gm-Message-State: AOJu0YyzJf5kkUUTrg/mFQk/OCHBWEW/wCenKUgPQ1qro9BTSwwxvRPX
	bx53HYyjO3c/CeWlHfJhnuui5IV7bAuFjfTx9bMpbJEqPA87XM8x
X-Google-Smtp-Source: AGHT+IFEiTyz2v7Pe7dPNrHM1BpajVYLHrP2PWByRiCIGc1pt2NsU387A/e2bXv38IBlyPJYTlGiCQ==
X-Received: by 2002:a05:6000:dc7:b0:33d:f475:edb2 with SMTP id dw7-20020a0560000dc700b0033df475edb2mr1283534wrb.13.1709052779945;
        Tue, 27 Feb 2024 08:52:59 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id a7-20020a056000188700b0033d926bf7b5sm12114587wri.76.2024.02.27.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:52:59 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  sdf@google.com,
  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
In-Reply-To: <20240227075605.18ec70b8@kernel.org> (Jakub Kicinski's message of
	"Tue, 27 Feb 2024 07:56:05 -0800")
Date: Tue, 27 Feb 2024 16:29:15 +0000
Message-ID: <m24jdtna5g.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
	<20240223083440.0793cd46@kernel.org> <m27ciroaur.fsf@gmail.com>
	<20240226100020.2aa27e8f@kernel.org> <m2ttlumbax.fsf@gmail.com>
	<20240227075605.18ec70b8@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Feb 2024 10:49:42 +0000 Donald Hunter wrote:
>> > +static inline bool
>> > +__ynl_attr_put_overflow(struct nlmsghdr *nlh, size_t size)
>> > +{
>> > +	bool o;
>> > +
>> > +	/* We stash buffer length on nlmsg_pid. */
>> > +	o = nlh->nlmsg_len + NLA_HDRLEN + NLMSG_ALIGN(size) > nlh->nlmsg_pid;  
>> 
>> The comment confused me here. How about "We compare against stashed buffer
>> length in nlmsg_pid".
>
> The comment should give context, rather than describe the code so how
> about:
>
> 	/* ynl_msg_start() stashed buffer length in nlmsg_pid. */

LGTM.

>> > +	if (o)
>> > +		nlh->nlmsg_pid = YNL_MSG_OVERFLOW;  
>> 
>> It took me a moment to realise that this behaves like a very short
>> buffer length for subsequent calls to __ynl_attr_put_overflow(). Is it
>> worth extending the comment in ynl_msg_start() to say "buffer length or
>> overflow status"?
>
> Added:
> 		/* YNL_MSG_OVERFLOW is < NLMSG_HDRLEN, all subsequent checks
> 		 * are guaranteed to fail.
> 		 */
> SG?

Perfect.

>> > +	return o;
>> > +}
>> > +
>> >  static inline struct nlattr *
>> >  ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
>> >  {
>> >  	struct nlattr *attr;
>> >  
>> > +	if (__ynl_attr_put_overflow(nlh, 0))
>> > +		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;  
>> 
>> Is the idea here to return a struct nlattr * that is safe to use?
>> Shouldn't we zero the values in the buffer first?
>
> The only thing that the attr is used for is to call ynl_attr_nest_end().
> so I think zero init won't make any difference.

I guess it is fine for generated code.

