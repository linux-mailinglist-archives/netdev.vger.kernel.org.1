Return-Path: <netdev+bounces-201030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B3AE7E7D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324C116EFCE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121111EA7EC;
	Wed, 25 Jun 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPUm4XC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0A285C80
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845965; cv=none; b=us8IAMMvddZ+tqap6T4TtzQ8r/okQNAFiohJDfgRU8KUGVuiQw5JnRryYUiVW6cz9ukItcWl+rQBYk8OhaRa5ek+JQwoyDEwaK94w9IaqNrDtm+cSRUbNBQjAEvM9kX4hPuYLL4i4KFWl4+1pocD8FdfwZUjGNQUpC1G4OMTER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845965; c=relaxed/simple;
	bh=6pxpzEhoX1gG8wkYXpVyBC/pQqljz7bnRoUTWPWz1yk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RvIxDjYDW+R9SkxlI86xOnEmVOrE265WtDSBZVQ47eiyBrltTvxgjs/AdME7cwxulN7tTurtXozS4Fwmtm9nuodey+oll1uzj8wNrODlpMvjGQJ1rkI8lfQXgFW9tZF+1bOpVBSqfqTMJmaCAe22mPOWL/uwpuUREqfgvWLhccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvPUm4XC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4332178f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845962; x=1751450762; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6pxpzEhoX1gG8wkYXpVyBC/pQqljz7bnRoUTWPWz1yk=;
        b=JvPUm4XC7aSyRbZ5BILhfVKVCeDUU4G2VjHYsKZE36qDomVFQL/5n6SlfeRWO5g85+
         pfM5p6SPHoCKAidqQ6+jmFlRBQ8kq1EHfnte+K3oxgpJJLdG1Db/jHxwjciTMU6FUTv/
         ftFq8slHsFONFz7ivqNEgLg5r0PhUMSizvgUbV8gD0EcxcBSwSchQngx1phCDJkqiF6R
         PWhCGD0yBdx5luuGH5/sQoXns1lyHOiytQNrkVgXqrPJpKw6S3jD/DTnEZFs/kQHFs81
         kM4Jw1v6KPE3nDL/likyrMkUHnB9XORsGyzOIjhYedwe0ejmkDkEbdeoSuiJ++LHVt+p
         MBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845962; x=1751450762;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pxpzEhoX1gG8wkYXpVyBC/pQqljz7bnRoUTWPWz1yk=;
        b=mN8f5X5p/zcZLpaJxrkR9lBvUdJf7YdRmkDXs54+HQnUtff6AAysq+kIo9GwtfHJ9w
         uUlIS5wZ0C7AHJlD6FmV6OqFEmQQR8/KIeO0B1sa1/pQj0HJYGUAV2gTPptrBG+YFGjx
         cfBdZzClToetvtWkDjP3BiFe1/AAJ2Uc6iEVp65gHCgoKBk/JGk76RqQyi2SAMLY5uWu
         R1JX4MJ/1SYHfI5XLwc1TqA22ijSMZUVUi60abtly7qc36t28Y5cGv7uQ9UNOHXhdNM3
         lLJ1ONOTjBW6Znr9vsNs6MvkrEhQxe7xrXmYNZqvz7g2KMzGrUIzCHLTrN2lfc82mlAi
         8tig==
X-Forwarded-Encrypted: i=1; AJvYcCV5MRucIDO5HJM5mfw9MNrgCRCbVnwTkC+S0dCwF8ialVwb7j3nUZWPn0e+/mQZOLtjdqR4PwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUu4KhjUh1F6NT6cjDKl1nlZXM8iqlRGF9mVwT0dIqo0kmU8n8
	gL5lHDst5jp66abC3QmrCXRXW7C636esl+r+y/uq8jthRv5DK79DewUT
X-Gm-Gg: ASbGncuN5Ys8g98sb2S/rqgVgsZHmUWILHVj4R+P/v6bsRpQThfVXBOZvpBdtNBGXAW
	imVfhLEInXQ6u6L2K/pwEu5MN57BQ1UjMf+/tKPbLeomQCl6+NyGBzGJLY5/RKDm6tXx8qV8ETY
	2kD4r4IkWSRzpJh4V8zPDkVIkpI3hI4OLGQ7xttbLeOqh7lFJKa1r6CsJ8UoRvVvAUb4mzeNz0I
	Wpl9UHHhk3HIsQSGYxJZsK/uvNp4H/5/keNeCp4IxNH7DNM12CaWjA+6iESCFB+zGmZv98oVb+g
	8HPKKJXy3QI5e7o7PlUa+qSkUc1y7dAxEYaPO7vG3kgjbcdtRMrIKyHNR9/OtFbO8YOdb0WEgMw
	=
X-Google-Smtp-Source: AGHT+IEUaLy5pK1cTkHNMbxIKXTeDKggE1dnKPaQ0oX6nj0qSWycDNW8Uj6dR/9VTyU66k0RCmNCbw==
X-Received: by 2002:a05:6000:40c8:b0:3a6:e6c3:6d95 with SMTP id ffacd0b85a97d-3a6ed64aa66mr1810816f8f.41.1750845961494;
        Wed, 25 Jun 2025 03:06:01 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8109728sm4128821f8f.82.2025.06.25.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  maxime.chevallier@bootlin.com,  sdf@fomichev.me,  jdamato@fastly.com,
  ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 7/8] doc: ethtool: mark ETHTOOL_GRXFHINDIR
 as reimplemented
In-Reply-To: <20250623231720.3124717-8-kuba@kernel.org>
Date: Wed, 25 Jun 2025 09:55:50 +0100
Message-ID: <m2wm90ci95.fsf@gmail.com>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The ETHTOOL_GRXFHINDIR reimplementation has been completed around
> a year ago. We have been tweaking it so a bit hard to point
> to a single commit that completed it, but all the fields available
> in IOCTL are reported via Netlink.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

