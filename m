Return-Path: <netdev+bounces-164847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CFA2F5E1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA18168132
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F56255E46;
	Mon, 10 Feb 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Y/JIWh+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6E25B66E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209839; cv=none; b=QkXh1mJ7T300E2Hq7ZzniK2xqN6WmsLYDBzEpKgZp3f8/7SViDze5Hrzz5b44xtb6EMdt4i7SA4Qtafu/Y/DCb9e4EORVYrFfEMQ5hz8c/02epusz2U+kHSYfxcfZoIzjM2y3B/qbXQsfBQaQvAO4sf2eJxoL5IndWPXsqwHfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209839; c=relaxed/simple;
	bh=5itngRyI3QLkc3iUAXbbXE3l84sxybC0VJY8BsapT6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dago/ADC1SdA9fwRffMy/Tkkp1HhqxAzbsSM0EkrlPsM2QIhOTmhsoMq5lqjOruuTfjBdwFZrLP1hjzKJNPBPbQI/6rkeV5kQ4afMaJiHKmz51rMsEZx8rWMlTaAFqo7pfjfceDQJOuEAjUa4FtQf+TdXABwi8tsABsv3Eq6bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Y/JIWh+N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f49837d36so52079525ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739209836; x=1739814636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCO3aIRcq5bPxRXLWL+/UKDcQnItmXbvQb/S10a8uSI=;
        b=Y/JIWh+NTFsGFS8sJ0F23YHaZC+GWW5HJj3+TEOHzKo/XyBEUqur76CkwGKb7CAHKz
         Nw2S/XsPt36cjhZJfAOBnm/W3rtepRc67H4yH95yNl6BVVy60Yrr05Dv0xv7yoUsATXf
         XkkvnqQT+rogwFP6lAXwXGWmCA+eNirQQcYVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209836; x=1739814636;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCO3aIRcq5bPxRXLWL+/UKDcQnItmXbvQb/S10a8uSI=;
        b=P1JFMSLbxV0IzHZn5Pxu+1fd6rL6wELuAB0gb0U+oGGr85GSHNOsbJEkcvYi5OjY5B
         om9ixT5n/GBafiBknQkYhwBvwzNGTgfeOSKhEGa4NfK9CK9RKsNw1rTqnXsOuHkTPSFL
         r4qoNj7rxvjp8NZfjUP1Epdu0C4QkU88DL6IivCMr6fjejB6qNP4X/TBm9QPDUO8CDJn
         XxN4t1Ws9X0MH44FeYp+1M1lfAPkNI+KeD1/Yn4f6c/C8eRsoAj27BD0kXtTOo03703b
         DZt7zbMXrM9TDQCPoFawtyQnBfd5UlKSz9iqZ8STCo+S4K7jY0lHNj9dE3Foy7pmQVdu
         ApKw==
X-Forwarded-Encrypted: i=1; AJvYcCVzXHckDmP6r9xzMMR6IpqnlQXAl4BTI4SCc92gX//6wqWNbzelG123grSyxy8WsR7+03hokgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp/qnMC6dcfi+fBQxgq9jHkWS46JObLhpGMlpl4fN3YWLmfl1
	FJvFfm5roJeIRK9zpxzTNvwdeLWbTVIh2KSB6XEhSOL5JPOBTpSf6HAuyVdHKg0=
X-Gm-Gg: ASbGncvZ8P0oVGNJNZLj2LJKVabH+aKz/Bx3TqHUb5JCE0kNXhG2Sr6Y97QOMcok3o9
	NriQAkqo+C4ZLx+pE3vpmu42YleOn2bwVIVzpzvKbrdXDp/y7XjpvEgda555N1WVigGWdmsiHu2
	jtBgOeM8FEajd0NoDSqYENyHRiIV6Tis4dTSuK0LsUbjloUFTvBLN0a0Swgguggru4bWoYwRp3W
	HVssk0D48fo2CMk/sLZsc5clKZpt8jHDcER5gcP2Kd1lgAgpt4+del+cRIQcir5JKq4jb8fkWb6
	ADW9Lvn24orBmZdPecZ1qrQFLYVnOLgxiBdFCjGFQlDyTv5CJyc+0r83TA==
X-Google-Smtp-Source: AGHT+IESIWs0nDg5kAqiOuNPxZ9VJShu5naJndD6KAbqxfopHAr2qsG48oAN4aHnkGyTLNqhk6vhKg==
X-Received: by 2002:a17:902:f78d:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-21f68ae57dcmr162636775ad.39.1739209836373;
        Mon, 10 Feb 2025 09:50:36 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36897faesm81159455ad.213.2025.02.10.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:50:35 -0800 (PST)
Date: Mon, 10 Feb 2025 09:50:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <Z6o8aeG_GqxtwXV9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Purva Yeshi <purvayeshi550@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210075006.9126-1-purvayeshi550@gmail.com>

On Mon, Feb 10, 2025 at 01:20:06PM +0530, Purva Yeshi wrote:
> Fix issue detected by smatch tool:
> An "undefined 'other'" error occur in __releases() annotation.
> 
> Fix an undefined 'other' error in unix_wait_for_peer() caused by  
> __releases(&unix_sk(other)->lock) being placed before 'other' is in  
> scope. Since AF_UNIX does not use Sparse annotations, remove it to fix  
> the issue.  
> 
> Eliminate the error without affecting functionality.  
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/lkml/20250209184355.16257-1-purvayeshi550@gmail.com/
> V2 - Remove __releases() annotation as AF_UNIX does not use Sparse annotations.
>  net/unix/af_unix.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

