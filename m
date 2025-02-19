Return-Path: <netdev+bounces-167606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AAA3B079
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 05:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665113A5F98
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B775A1A9B3B;
	Wed, 19 Feb 2025 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybsi3Xdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055219AD89
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739940730; cv=none; b=Ra7wXnFwdI5JfeLaMIbBt2U5bc/cVM49e5jEVqZpLPrC0ZneYiRdW4B12MwyxzubGVIKsmg2/A5QOQhqFSMoG5PYM95pEd8usIHspx/KUDN6MdxkyrpxWYU3XlT3iwS7lv3ApNaF9XDndXB2yAgtA7Q41D/Oma1JcrvLDt+iQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739940730; c=relaxed/simple;
	bh=Eq8vrlHUvpa6xLS1UTmuIhHRGE9Sb+sj5ugc/1TLFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN4zFixRs3BttFyQLJy9pgJORT58YlX2A2VDZ9iNopTAupHTe0BtYE0CX0S+vgntoR8QCdw2cMouIXk7wvgrhUbl67hStZc1+8LJWxIkxoJBWEDE4I2FPEendbu4K/jKsZG3VWsbraV790MOEDN9fwqjX15CFJF6JG/5InrCbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybsi3Xdc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22101839807so84249625ad.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739940728; x=1740545528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uP01YW9QyrVfA6nA4TT3TTuy5DgnGuk9+pXeMXTVxI=;
        b=Ybsi3Xdc9iqd9rTId9k+oZ4Lvm3h2+VM5hhMA7m52m99P7XwV57lov4ILR42HvsBfL
         4aUmQCXfrjARkq3eavnWMnC12QwAf323Av7Y4WZjYyNdQMBDuvvWCWhLZee+p3Z8gAis
         x2BJ7nwEgFkmtwGsWqtad5kCCYCi7YfE79kykit6oiaK79g/QG4wNR1wJiGQC0bcWV2/
         SRqwTxRHoXx1u6i4RWnfiduoD1oq4imuYoooYZ2cE9enBUP1i32ftNg3GF/oCtdaAKEU
         N4SnWDNec9/UZU452+E9uZcI0Mmds+SOrWVO67lx+LOE9AHxuI6x/+GBSNnBrPu1R5zY
         pjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739940728; x=1740545528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uP01YW9QyrVfA6nA4TT3TTuy5DgnGuk9+pXeMXTVxI=;
        b=sNWrxoU1VZ5ubjlw1JlKydd4C3EEQn3fyrdybayLFvZcFqWcaFOcEwnR8SaUSoaBOI
         TbLLLTsKETfZ0XISbz4L0RXiBC2a/Qm3VaxPva1RVOjNWT5Hs8bUild1cHdY0Pd0UA+Y
         2D02LjpLdsERbBMdYBiVoFdww9wF9oxAKpcrSuONIpCtZXLvL3FvZnOVQpoHPd3Cpe1W
         c1/8JuxwhO8TSNGgjvcE2p2jRp4UEggKsDlVr8xzCM7CDFWJCXoOSiIgAq/tYNfCW8Q5
         7viVtq7Bw/XjbZ8QeTQXnG3alv+garzkzvK80ejQmEbFARhfhV2CrbNCd+JZAY6STeKZ
         nnZg==
X-Forwarded-Encrypted: i=1; AJvYcCWsZvjH4NWIkQ3+HUEB/2rNWuDREjAn5XqMQLJ1d1cEQOx2i6OWMi9OYHYvn1k4WYmiJAdQF84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBxL8MnD3F0lxAiS95YXTnqjsSk3/rzPXwQuWT8N6+kVkXX44
	DDXwonexRjvkwpuHpuZSHMNrNhwP/i+NsYOj30e1qdHhgQ2h1Ondv4fk
X-Gm-Gg: ASbGncvMdWu3uahI6JAFnwd0RyI8WAxb1lvTpoU6jyAgw6u2HfkE7Q2Bo0Q6LrD/FH3
	P7xorf0O86IEee4bn2re8csgy8GGK//7UkLiW7k+vdZlGCKbekuCjlYXMsn8DQ98pqRQyVaAlt7
	Iz9cPp/XiF+gWSewGxBrrZB2sAkTFU3E7n1lCa5pbcJIoD4BXti/pytnwL7sQxb2JCRxQmy5olr
	lRjyMBU6PYLePG9LWGDLWgQxrt8Mkw24tfr9f2+t8lPLVKZu6p1h16n7vSx7MGFOYugHPEoq5DL
	tcLS5u0UqP72OJo=
X-Google-Smtp-Source: AGHT+IE5mykw8Wd9V8WwwiUMRTyYvPj05o2rSCCH/YwOgYMJWjhM7oem7dyr/ngyE5q6Y9TftTq77A==
X-Received: by 2002:a17:902:d2ce:b0:220:e792:8456 with SMTP id d9443c01a7336-2217055eaeemr38252165ad.11.1739940728485;
        Tue, 18 Feb 2025 20:52:08 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545df28sm96407225ad.153.2025.02.18.20.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:52:08 -0800 (PST)
Date: Tue, 18 Feb 2025 20:52:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 11/12] docs: net: document new locking reality
Message-ID: <Z7Vjd7Xx1wplacKC@mini-arch>
References: <20250218020948.160643-1-sdf@fomichev.me>
 <20250218020948.160643-12-sdf@fomichev.me>
 <20250218185323.70f61e4f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218185323.70f61e4f@kernel.org>

On 02/18, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 18:09:47 -0800 Stanislav Fomichev wrote:
> > +RTNL and netdev instance lock
> > +=============================
> > +
> > +Historically, all networking control operations were protected by a single
> > +global lock known as RTNL. There is an ongoing effort to replace this global
> 
> I think RTNL stands for RouTeNetLink. RTNL -> rtnl_lock here?

SG. Will do s/RTNL/rtnl_lock/ in a bunch of other (new) places.

> > +lock with separate locks for each network namespace. The netdev instance lock
> > +represents another step towards making the locking mechanism more granular.
> 
> Reads a bit like the per-netns and instance locks are related.
> Maybe rephrase as:
> 
>   lock with separate locks for each network namespace. Additionally, properties
>   of individual netdev are increasingly protected by per-netdev locks.

Sure.
 
> > +For device drivers that implement shaping or queue management APIs, all control
> > +operations will be performed under the netdev instance lock. Currently, this
> > +instance lock is acquired within the context of RTNL. In the future, there will
> > +be an option for individual drivers to opt out of using RTNL and instead
> > +perform their control operations directly under the netdev instance lock.
> > +
> > +Devices drivers are encouraged to rely on the instance lock where possible.

