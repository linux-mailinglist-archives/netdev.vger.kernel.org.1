Return-Path: <netdev+bounces-213875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82530B2730C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0230D1B60EF2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31040286D45;
	Thu, 14 Aug 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RioOxjhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129C219E0;
	Thu, 14 Aug 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214590; cv=none; b=M5k1gPt9n8L61Lf+M06OErIb2IuVyRA+WQU5uTVAAQCJq1l/JelZcoUAgkQi3vGLkRx8LG+VZ8ojwZUIyj5VtslqBB+z/elr8GysclZUOXanKuNgeo0kYFyw5R0h91rrWE48NrI5jQCEkdx3vP3cmPoAh3qKZzhu53ZbmnjCerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214590; c=relaxed/simple;
	bh=kK6ZEm1RSJCBAi84RtcMdeeitXg2ze3JBegyaSQdo2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/QN3Qwkr5OqYREvgD8mqKzYBIPIgj5c/zvQqffrTBbIGv3rUp1EOk+wNBoyfoRskt/C0PnzGcAnSjOvG5kVFKAZHDc1SukoqCcf4G5TSr/B80xigRU8ZavaqjVoZKUEsjxUSKq2y8+Mcocy31KndTe7uh4uZnNE/aRa5/pe0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RioOxjhD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso1451885b3a.2;
        Thu, 14 Aug 2025 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755214587; x=1755819387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBhUpKmG10vWBPNlDuVBEwiiCMX7PxhQ5fzj9BX00hw=;
        b=RioOxjhD/s5WZT2PO9zQ+qEj3K2ooV+XchybgckvnKlWYdyiSaYI2+oIDkCSkKE/mW
         9DeeJ2fJ9bdqKCuPuA4FEJMbVWHe//ZOk4cyf1Osgz5QaXs+OP+IoNEgkrnVL/yhaQev
         9QxF6f4pwUXNL8NFDjfcJokAFOZ9l9uaBcl5otf/IE/dbIUxOR5lqhegGiwvDJoAWdxw
         LYkobnZvv/MULqSe8t16777KrWIjnlkBtD5hqsMC1MrHy4LYZniWe8DP65nuB2Wjc+0M
         Qq01PTp3SNpw4mrW7AG3M2ZrmoUAno/lA3chrsGw5YaWvTTX6Hk4GGjZhdetuV+SDvrH
         atjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755214587; x=1755819387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBhUpKmG10vWBPNlDuVBEwiiCMX7PxhQ5fzj9BX00hw=;
        b=qEY1PfrPjoUXYxbs3LERQ6Ko32l9ET67vQ/cjS5Pz6KbHJ7Dzqq246MC/0sF5/fjx4
         /xRcBKpZtGavp9MnNBfZ/+yhuAKNrgDGGQhCbPOTJTzwb8zLa70E4Fr05Qs5Dc0ar+dS
         QyuzIpQjshyFvBpswPagNlGVxcHvfoJjtqRpP48Q/6INF1z03LARbEI3l5PL9o/Qg0Nz
         8Ow9vbH7fSldAP2TQXrv6J/YH3I73NhhKn+Ea19edVyN0Ii7ykkyxr7XqtnLr2QzHeL2
         95gYzVFYH2pwEDOsk4yX2pxiaJDsPmsByaPiitMZ9zPv7lg5KDfsbnsYBrwPxOXMbxdI
         cYcA==
X-Forwarded-Encrypted: i=1; AJvYcCUkWo+vbipllFprgBRZO5ocM4xssPKZQQ4IWVK7h2KWCQ2fcC0zOu81RFfr495jVbZt7EKbHOI6@vger.kernel.org, AJvYcCX7j7VJq/XDJLNqm8JkdL++6o2NxtpELVE5vvxz6xgCX90Su8Ao5moUSy2hdLtzH0OpkN0bPKqbhLmxlVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJC6MCab32kmgyK9uDFEE4F0YrLRU9kVHpijZeTz45drYIQCn
	u8bn64tKtqbkiBPRPoSBH2u3P+JxQid0lGtaVZ1zMycdtjzLAFo9Fhc=
X-Gm-Gg: ASbGncvXKFc/IubSpdKimyH3qEQVwhJHHXdZuLQ3Pxk6qENYzaMXecjoNKreknayJaf
	GoZQTnlET5/Ki1RmY/5V0b4YjUAl+1q57URHdpGRlm7l0ELOu224iUda415OlGv/zGiIUZOG6E+
	HwnYMFk9/l6WjWUdBat4xB9LkYUr0l3BbNTOP2toeo0E5f71V+3Wc8veRwFePq1L7sYeNh3PPC8
	fZpGqlRfVQ9s77wuhEZyKmXuBkqVIKLi7NAyYht00I3EvpFD6OVWw1KxrGe08bOoulfqZggerIN
	5hcdHJx6T4NBUS8/sw9g7L5aHVvgKnnTx2z+jvJsYRrbbI1rGzTRtMicPLTaw8Gg2bw2F9SCG6t
	DNbqVzy/cC1ciehEVzei5R9TpCpfae6Fu9we95TeJ0sXbJJpls3k68e8BiUQ=
X-Google-Smtp-Source: AGHT+IFH9n3TcE1FNBWOJ+fMepWGFMieEmlfs2ZyJarhZ06HoNYf8zje39WcVDob+qUMN9xtjf0osw==
X-Received: by 2002:a17:902:e5cd:b0:243:43a:fa20 with SMTP id d9443c01a7336-2446d73b896mr538925ad.24.1755214586943;
        Thu, 14 Aug 2025 16:36:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3233119263bsm2984644a91.33.2025.08.14.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 16:36:26 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:36:25 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, horms@kernel.org, jstancek@redhat.com,
	jacob.e.keller@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
Message-ID: <aJ5y-WWCZAlJ9QUy@mini-arch>
References: <20250814164413.1258893-1-sdf@fomichev.me>
 <20250814152707.6d16c342@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814152707.6d16c342@kernel.org>

On 08/14, Jakub Kicinski wrote:
> On Thu, 14 Aug 2025 09:44:13 -0700 Stanislav Fomichev wrote:
> > Compiling ynl.c in a C++ code base requires invoking C compiler and
> > using extern "C" for the headers. To make it easier, we can add
> > small changes to the ynl.c file to make it palatable to the native
> > C++ compiler. The changes are:
> > - avoid using void* pointer arithmetic, use char* instead
> > - avoid implicit void* type casts, add c-style explicit casts
> > - avoid implicit int->enum type casts, add c-style explicit casts
> > - avoid anonymous structs (for type casts)
> > - namespacify cpp version, this should let us compile both ynl.c
> >   as c and ynl.c as cpp in the same binary (YNL_CPP can be used
> >   to enable/disable namespacing)
> > 
> > Also add test_cpp rule to make sure ynl.c won't break C++ in the future.
> 
> As I mentioned in person, ynl-cpp is a separate thing, and you'd all
> benefit from making it more C++ than going the other way and massaging
> YNL C.
> 
> With that said, commenting below on the few that I think would be okay.

Ok, and the rest (typecasts mostly and the namespace) - you're not supper
happy about? I can drop that test_cpp if that helps :-)

> > @@ -224,7 +228,7 @@ static inline void *ynl_attr_data_end(const struct nlattr *attr)
> >  
> >  #define ynl_attr_for_each_payload(start, len, attr)			\
> >  	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
> > -	     (attr) = ynl_attr_next(start + len, attr))
> > +	     (attr) = ynl_attr_next((char *)start + len, attr))
> 
> okay
> 
> > @@ -149,7 +153,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
> >  		return n;
> >  	}
> >  
> > -	data_len = end - start;
> > +	data_len = (char *)end - (char *)start;
> 
> can we make the arguments char * instead of the casts?

Let me try. That might require to char-ify helpers like ynl_nlmsg_data_offset
and ynl_nlmsg_end_addr.

