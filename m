Return-Path: <netdev+bounces-140968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5919B8ED6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C31283037
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05CB168488;
	Fri,  1 Nov 2024 10:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC815B97E
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456090; cv=none; b=L9lMGaVxGKZFd7s2t4xbMn5u5s/VGZ+yms387fiinJI7x5i9NDRuuIryl3xFRv4ZXphZCHTZktKJBg/Bpyi25cSkByTJ5KKkIV4bs7hmIO5c6bDzrvaE2I5SIbKyQUMsuMrd20wRj5ZpEn0vC9kvTLwRWBWHGVi0pbwnok5WwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456090; c=relaxed/simple;
	bh=FxZ6lDE3z1Ekk1oapLEQUiWEX57ejZShoYoIVseC+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqqz7o6ihkBIfGGrh85ryMn4smO4u9jesnwp/QOCg0i2DnFBZOgiUNfccEgBHbk9w1Yt6HjqWcWqmzH9Ci9w6aS6loljWVhNlaH/qzRWENVC/en/w8z9Kcnykw5c+iG3JX6ZYmIQY2pm2lykvMZ4UXagROy+hS8Z5Z6D3bPNGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso265977466b.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 03:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730456087; x=1731060887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w45ANRdUj4mrOui3s3eHA2JSaJRmmApwTgpSsWKFYU=;
        b=S1oD3dxjQ8XIOCr7o/H3Dx3UyvQtTtPjCw7ZF1VumGOQCC/DlWMxpAWP8L8f7gWZHK
         DuHFS7zKKbjKvEwwzvfnMqqZAaxVByoCilszBDIXgElIUiKn7bSv71FSP+GJrFcopk6t
         4pzgE27wcoaloXmJEwm9egGupQZXnU6j+rmw7Z/TezmxhqojNLF/xJnCX7X0FMxck3f3
         nZKPt1lj/3Q8ztiDICVW/qkFUmq+8eVusAltteQyEY/WYLuAKmnRk8e3O4Kd+Sn5wHF9
         xQYu7WIvVIU1NlfHQJ3Asx1jjY9LeKv/eMseTeBdDKWOl5aM7wWz/mFuy+h9SSeOII3V
         QXvw==
X-Forwarded-Encrypted: i=1; AJvYcCVthvJY2YQRX0nYw1QuEW5cXsinH/nxjycjhOe8SplWZ3nWwQf3wu2NN86OXh22i4ITxl++TRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjiQvFT96QEW9lGwSp5CvcdpCiAcRn0d4zSpRhkwKiA0eJspR
	LvVrjGyoVzclFCaxjUC5yO+Q95XCzZ5AxIHE2/rNZtPC0BEo5EWTO3QdN/my
X-Google-Smtp-Source: AGHT+IFdL8eBoNwwX5yIDjVpYUPj1q8CDuRlP6DPXdW0CcmE6KpQBlEmlSEpLAqaMT+ovyK7Mj5H/w==
X-Received: by 2002:a17:907:d23:b0:a99:f833:ca32 with SMTP id a640c23a62f3a-a9e6556fcd0mr310327566b.18.1730456085069;
        Fri, 01 Nov 2024 03:14:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f67sm164795666b.54.2024.11.01.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:14:44 -0700 (PDT)
Date: Fri, 1 Nov 2024 03:14:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: add Simon as an official reviewer
Message-ID: <20241101-silky-goldfish-of-karma-6d80ed@leitao>
References: <20241015153005.2854018-1-kuba@kernel.org>
 <20241016140801.GG2162@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016140801.GG2162@kernel.org>

On Wed, Oct 16, 2024 at 03:08:01PM +0100, Simon Horman wrote:
> On Tue, Oct 15, 2024 at 08:30:05AM -0700, Jakub Kicinski wrote:
> > Simon has been diligently and consistently reviewing networking
> > changes for at least as long as our development statistics
> > go back. Often if not usually topping the list of reviewers.
> > Make his role official.
> > 
> > Acked-by: Eric Dumazet <edumazet@google.com>
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks for the kind words and trusting me with this role.
> I'm happy to help.

I'm thrilled to see this change.

Simon has been instrumental in thoroughly reviewing numerous of my
patches, and his valuable feedback has been so helpful that I've started
to include him on all my netdev patch submissions.

It's great to see this process happening automatically by default
now.

