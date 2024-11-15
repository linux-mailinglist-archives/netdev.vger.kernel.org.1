Return-Path: <netdev+bounces-145497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D69CFACC
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC971F22529
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489A19258E;
	Fri, 15 Nov 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESlDSHG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE117346D;
	Fri, 15 Nov 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711833; cv=none; b=iWpTc56pEq9RA5n1cIxO03VE3venp/pCFLTTAmoS1F6TNBv06AAMcT/c1bY+5kO35nEX94f4faBnU3j3bgKpk//FQBPkWFWqLskT0wKuYco1P7RUvFVcSC7M8rN3nU7qlNzAkTOWka25MrSgMeHSpLJ9Wds0HpiuR7EmGHo64yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711833; c=relaxed/simple;
	bh=mKauW6I9W5hXQp9GKKv7JxGvn5sX2MlqE+6rp+gg28k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo/pHNlpe3pPBxNu6IEBnoNAUD9ni1D9+FvfYjQkKXR4iLc4GuiVzHn/QML4ge69JlOFyqPmnAV3KX6jh5F5LUZ6efUDJjoDci5X+13zJDkQHzgWLsm3B8e/kl9PkCHpsItbbG/N63aqOoAxyodNuUkajc1u5vrza1XIicmqdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESlDSHG7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso25467525ad.2;
        Fri, 15 Nov 2024 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731711831; x=1732316631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3OW4gCL3xqbXKByl6ZGthQm542cJqRb+Ure72guVWk=;
        b=ESlDSHG7PQo6ERJYovsatHIlL50lga4XO13YU6d1SgPXIIpqFYlPaWFuXnQpPKF7nZ
         dCreq3rLy5qdYfiWQYT5hsDgK2mxXADZzRmUzN8MVH/pCUktHJAWOO0hpJsI1Mm5ZzdR
         /erpyZHFVyeVrhc9XJ6Dg7crcR30yWrhtEfRVBmMgd7oX9X+D0iiP0dB1gmntkeg62Ow
         EERqdUbj264S7R23+2KvbCLIxsxZ1/gnf93Om9PObaqY4ofVbj/TMRLKN0UQZYU8+ZS1
         sC6+WThaABZahJP3xk9iTYVXpQ1JMNyHphscezxe4a0DGupb08CQ22YlHc9hEEEU2F3l
         xocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711831; x=1732316631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3OW4gCL3xqbXKByl6ZGthQm542cJqRb+Ure72guVWk=;
        b=LJ6RDCdJVqn2uKAwvS3HPw+eZNo4mCACJyaLjV4P6orrArBrdW9wEWiss0/uoarWiV
         5nWHY8ZEvvy6mQp1OQl+MkQ/h7498c686Xlyv/Br3jZbF2ydIZ+g7od0ietZyiiIT9Zg
         NcX2ief34ZTMuBdUBHhmzCAw+RrKOW9DYAkrkshTZhOASG1G/954uVpO8AEtWWz+wu0R
         Jx0mFP6N2KDlStuW4C3KKHoUxpLu2QVh2uMPPchJ79Zu4cnyfomShLbrZ65OO3xd5iL9
         0nP0PX+CHdDuDdE/9MstbstRnoUd5g7C/7UZ90ljO2Ez6hqYbmkD6AI9TqHquNM+1nbk
         LxUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8fqvBF+RIlN1UByi3a3DMoNlMc8rocD5c+TYuYxF/tsN0MfZoV4OlIzEqB0r3D7zkZz5qWUxSFBSv0vf1@vger.kernel.org, AJvYcCW2uKuFWbJgwGsyxEulC0F4CGeivYadMEbr2PlBChxJCGRNu51gKGMBAYI6pCGSdO2xjZLlJNPm@vger.kernel.org, AJvYcCWQwAVEQLL2o+IGfTFiH8rm8ld50wKacdSgbFlymtUXh1EuBvfIDxIhXzcBUy4HsxReYX7kx7yCB4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCyBqy0NHGPAPoxBotB8n3+ygzBrhqSXW4HrmvwjgzihIEfN/
	GeXj/mQri4bGlPOicpEkQ3t1ZvlsU557oSgsDtGHY/J9mICD4/g=
X-Google-Smtp-Source: AGHT+IHHQQkW59lk9OH1q6uJpBQ5U6EHIqckyzQ1f/8CnHrnQQqeRO7peGgHstXcdZf+ez63hO6u1g==
X-Received: by 2002:a17:902:c944:b0:211:9316:da12 with SMTP id d9443c01a7336-211d0d73f7amr66041385ad.22.1731711831335;
        Fri, 15 Nov 2024 15:03:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0ab1sm1911535b3a.97.2024.11.15.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:03:50 -0800 (PST)
Date: Fri, 15 Nov 2024 15:03:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 7/8] ethtool: remove the comments that are
 not gonna be generated
Message-ID: <ZzfTVtxjgXR-L8my@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
 <20241115193646.1340825-8-sdf@fomichev.me>
 <20241115134023.6b451c18@kernel.org>
 <ZzfDIjiVxUbHsIUg@mini-arch>
 <20241115143759.4915be82@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115143759.4915be82@kernel.org>

On 11/15, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 13:54:42 -0800 Stanislav Fomichev wrote:
> > > These comments could be useful to cross reference with the IEEE spec.
> > > Can we add them as doc: ?  
> > 
> > Absolutely, I did port these (and the rest of the comments that I removed)
> > over as doc: (see patch 4).
> 
> Ah, I was looking for them re-appearing in patch 8. All good then.

AFAICT, only enum docs are rendered. We don't have support for the rest.
I can try to follow up separately..

