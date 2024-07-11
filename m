Return-Path: <netdev+bounces-110721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000E92DEC3
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F8D1F21A1F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F0DDB3;
	Thu, 11 Jul 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnnz+Qx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F3653
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667581; cv=none; b=JaEdwNEpY5BHptyzbDyyYROQxvrUUuO7djcGuHauVpXeybGC/4ChrV/lqCyy2CdzztoOQ0kTu3N9idN6gI5HH6Y+8u3jGNLh4YNNpIfgzY9q9GIrwMF4C+WxywGTdTziXdg4Y0UtYRP6ZAk+JUYh6iuJ+cQkrMsZ+/I2s/MwY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667581; c=relaxed/simple;
	bh=416KgnB8DMphKze0aQTiT0a4UOK2lGoTwak0LIqDqpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8LOfPMw+xO8hEDvmCUVdDQ60DgvV7B+WAarDIXKZaxViNEiiErN7gs1yho+PcAmy0jFhZmeZTMPjBjIMjHZ1Jk4a6eD1ssazA9w+B8/D9W18lEdJwkQiHIo2KAvfJu/vzOhF7FftBwruOtvCZIWYejC6k3PXr9jPdyxkegU/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnnz+Qx1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70360eeb7d2so224985a34.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720667578; x=1721272378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrsTob5CGjGSCw540mvJiUeShTIsg2AyqVTmCnWHehs=;
        b=Cnnz+Qx1cbZhtjhJQAh5+LAbvDlbg7vu6RZVvr1fDxnSO9MYIUX8uKpNzrTyZcMHeC
         7vm/fdhF0cRWSY10idmkIrD9LV/8rKbRSxon842LbueYayS8gaoEzHYhkXtme4+Cq1jh
         k3y005enGox4O3W4Wj/m1uebidSqK9l7DODMDK5Gj6l860sL8G5YjAE9Gw8tfTfE6ZmQ
         zPfsDPzglWpldsgmWOaGTZIAvBu74UntOQbZj1fxpm8KTKy53Tz1PTD6EqszgKyddvIB
         2BPFQhwsYy/OK5n9P7UcSeVDGeHb4RNnA+Ux37hRUmT0zIVp/tHJ7My42mPw7rLzuS8l
         Mtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720667578; x=1721272378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrsTob5CGjGSCw540mvJiUeShTIsg2AyqVTmCnWHehs=;
        b=srA2+L3OXaLKgEL//oj6/lcsWh42+0jFv3cM/afBRgQutul2etqAQIxIYVWL1TfW60
         u7xaIEfZGMB2SBNvfDqN2eYdChyfIYDakd9i+suvXd8ASAhhRywBEGWrLK9g6b6Rr+Vb
         Gj22gvagi4c+CfPQJ1BZ67R9bIlY6fFUKU1yVfQ0CkB7/b8FyViZc2s/ZQtZriC7kR46
         mMn7/EjTawYgue/3Os/4rMU1NtLt+4ijMln+kAHm+08R/F8crk096qbY13hPBqEIO5U4
         Q75Kr9rF0U8FxKjbImV1WZAat2GDKoJ+75f0kgc2LRtK3DmoN2STF+92xHnYNugQEYBq
         UWDw==
X-Forwarded-Encrypted: i=1; AJvYcCXUEVSZuptCW22KKZJDGNzEBih18orA1nppRsQcWbP824Ip9RYos99Cj0SUlLcsg26r5O7fqoRjka8BTclrFivqgC8xmowV
X-Gm-Message-State: AOJu0Yy8Vgdz6szEZNfE+Ak1n0+kLiH56AN/oBB70ncEQAd5koO3lxm9
	B6YLXly0QNCQLi+5o/EwScmS2+yDfQlNJ4V4lzp3bvn+0dv+I5D6
X-Google-Smtp-Source: AGHT+IEQHTBl6S5Yf7hxeCl148aZEZ7clcrd5HIN8krKkazT1Qu4y86VQk3wbXxrA9PIQk/mHus3qA==
X-Received: by 2002:a05:6830:e81:b0:703:64c6:305b with SMTP id 46e09a7af769-703759faebdmr7956141a34.2.1720667578689;
        Wed, 10 Jul 2024 20:12:58 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7820:f0c0:437c:edbf:e0cc:6fa0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b1789sm4694147b3a.175.2024.07.10.20.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:12:57 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:12:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zo9NtDv8ULtbaJ_k@Laptop-X1>
References: <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
 <Zn6Ily5OnRnQvcNo@Laptop-X1>
 <1518279.1719617777@famine>
 <ZoOzge5Xn42QtG91@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoOzge5Xn42QtG91@Laptop-X1>

On Tue, Jul 02, 2024 at 04:00:06PM +0800, Hangbin Liu wrote:
> > 	Looking at the current notifications in bonding, I wonder if it
> > would be sufficient to add the desired information to what
> > bond_lower_state_changed() sends, rather than trying to shoehorn in
> > another rtnl_trylock() gizmo.
> 
> I'm not sure if the LACP state count for lower state. What do you think of
> my previous draft patch[1] that replied to you.
> 
> [1] https://lore.kernel.org/netdev/Zn0iI3SPdRkmfnS1@Laptop-X1/

Hi Jay,

Any comments?

Thanks
Hangbin

