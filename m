Return-Path: <netdev+bounces-187817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12CAA9C07
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F5B17D248
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED6266B4B;
	Mon,  5 May 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGJ//V5b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8926E158
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471303; cv=none; b=nkGBkZMg5H8WRDDm86foWZfM7AvlRH3BMSercy94bO13h/waUufR8dcfl6ww/f0fTl2kFN+EokmjuUiMqgae6GWPgBydDRQVOA39Tj50lU+mzdXhgVsG1UdJR2FfCYn5DBT3xFLeQF7SLTr57ce7RBH1Srx+lwvDFbPobb/dpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471303; c=relaxed/simple;
	bh=R5F9NqaxR5XbxfQ/diedPP8STe39zCzQseoAXXOQ+74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJyBvfciYa3Tb5F7+xvNv2RMpHg2IGsGYlXRCobT6DEfFqmb59bJFzyaCm0+5as6fVSqlZanZlREHWKzvLMvQkA6RWvAV1sFEmazsRTLd5cZZ4tx4+8VQYCOKkDEP7UVihFMwbxxjgSA/3nhxA+sxZxoOjVwpJpu15FeGd3UBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGJ//V5b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e09f57ed4so44870405ad.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746471301; x=1747076101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=txCrSyIQVZ2E4MFqA55/D/rx40+DY1GbdWm4aGzs95Y=;
        b=kGJ//V5bKyuHFcjoGoS892oQh7UnjttfIYI9FlgTd5qQF9hnadroKt+CN9PlWjR+Fn
         czMW3TorPDBbNzP8g7tyKOhAJoA7OPxlYx/z1eNK5vBS10VCScW6IHqys5CachrzvnFq
         oOPky4CLQIeK6u4PxbBv/GuX65bzM8M/iGxaA9NF2ACtms6asQLU19tpupKWdfGAP8UT
         TUSiiOGqElZloe9pj9HkT0G6OGOkOLR7XcM/8yfhWjdTr994NxgdGpEOr2eGi54KrlCY
         Jco5mvPhYfNCQkTLZEjMGv1LfcQuElnLy3hvRiB2JUYdJZFIjnUJx56BF6U/IlUaNWQm
         lJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746471301; x=1747076101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txCrSyIQVZ2E4MFqA55/D/rx40+DY1GbdWm4aGzs95Y=;
        b=HG/tSaAbSVqXtFC3acdH2Zgjcd1L8Bwj6ykOMTtYmfUQ2ko92J12R7NOi622FiZJm/
         zMZ3Nhm5K720LvrTJG1/vmIEkZOaOdBlwYtEUIOvVDMJu8sCG9LghNARzY1ln388/XVg
         9VZruppcTSmKS8aMt1E8bx5IiiUwGEuN0byPbb6+d/ecjxz6jBOoYn8uHfNPfgQCng3E
         87OB16e1iCd3Jc0nh5BOyyaeLeOkNSQE3WD8P6U8aDHFmEaZ0us3MfooB/HS0hI2xNxy
         mcrIWrEohJWX6A9NOVA8ZvS9yo5Nvytk0i0xcpTKH5bmijpX7XJgzoxljmawG2V/r0yM
         xEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz1qILbKBLZlJcNFnHspWHjArH44ujvlY9xFGO/TIjMBs+i9H+W/3itXg1NGK81ycGUAEOmOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmpuHAGxxny49XgqHKVVTYJ9GeosZ3isaYkN6hqHtC36KNUTG
	Sxu3XC1GEToZ0zFlORN0vOVi5T5chB+Z9ruw27smMD3S5thVSOSAHk06
X-Gm-Gg: ASbGnctuF5RbZIUwrz5XR/8q2KwrEp5w2QSBWwukHceRslyA358ybHRGqVG++I/GFqw
	Q63c9FExyy0nj0wXw8ACa/hhy1KKoB9g9IBCZQqRNsB29ejKewLrGI9fQXWbNiLF16WdKDDifCY
	NTeX5m89qY5o4WAXCK6w30aYYWqXhiyNp3jAQNiQZ5sf+VNrn2KoUkJ6IYvvipPAdDxioofPFZi
	9f8JS3Ydn1hyg6xBRc3DbYexjmYRFtWnQYvnc4EWjUyxlECIDBZ+7lyrPHrZbj8E8Vu7CyeA9dx
	I9jqk6G7d3DMq/51ia4RUtF2FgjKR3dL9rYMBn0QyZXA4EZIMT9MuPtcZye2QOIgIPlubEfwBrc
	=
X-Google-Smtp-Source: AGHT+IF/O1MvffQJmKw7LEsAshPbUZNiQvZnfXgLTSK4oZPG6B1apypfjRav5PACBP0Srw9lI9Iuqg==
X-Received: by 2002:a17:902:f60b:b0:223:5187:a886 with SMTP id d9443c01a7336-22e327eb5b9mr7466145ad.22.1746471300827;
        Mon, 05 May 2025 11:55:00 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1521fae5sm58736065ad.132.2025.05.05.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:55:00 -0700 (PDT)
Date: Mon, 5 May 2025 11:54:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"saeed@kernel.org" <saeed@kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Message-ID: <aBkJg0W-QhIJiMfp@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-5-sdf@fomichev.me>
 <eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
 <aBjUFyaiZ9UHpvze@mini-arch>
 <a834c663507a78acaf1f0b3145cf38c74fe3de09.camel@nvidia.com>
 <20250505113514.6f369217@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505113514.6f369217@kernel.org>

On 05/05, Jakub Kicinski wrote:
> On Mon, 5 May 2025 15:12:39 +0000 Cosmin Ratiu wrote:
> > On Mon, 2025-05-05 at 08:07 -0700, Stanislav Fomichev wrote:
> > > On 05/05, Cosmin Ratiu wrote:  
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index d1a8cad0c99c..134ceddf7fa5 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -12020,9 +12020,9 @@ void
> > > > unregister_netdevice_many_notify(struct
> > > > list_head *head,
> > > >                 struct sk_buff *skb = NULL;
> > > >  
> > > >                 /* Shutdown queueing discipline. */
> > > > +               netdev_lock_ops(dev);
> > > >                 dev_shutdown(dev);
> > > >                 dev_tcx_uninstall(dev);  
> > > 
> > > There is a synchronize_net hidden inside of dev_tcx_uninstall, so
> > > let's ops-lock only dev_shutdown here? Other than that, don't see
> > > anything wrong. Can you send this separately and target net tree?  
> 
> Avoiding synchronize_net() under the instance lock as an optimization? 
> We're under rtnl_lock here, probably a premature optimization?
> But no strong preference..

Good point, yes, let's not over complicate and just move the lock_ops
up as Cosmin originally suggested.

> BTW isn't the naming scheme now that dev_* takes the lock? So we should
> probably add netif_ versions or rename these existing calls?

Can I follow up on these separately? I was thinking about sending
a bulk rename once we are closer to shipping 6.15. We have a lot of
cases where dev_ is inconsistent.

