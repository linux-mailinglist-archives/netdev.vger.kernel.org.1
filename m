Return-Path: <netdev+bounces-77450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A95871CE9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B07280F7B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1D54917;
	Tue,  5 Mar 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXQWLGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F654F86
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636777; cv=none; b=dbXci9dkp/grC6BI3J2r1BtlQV/nJ2FnNZV1B7LfGov8zNMX6l8YNfK+3iXxUUhq4R5pxf1pTFKfv8s3dm/aff+o9IiKa/3yrrb8EDJwW5XyaQxBzkoThmXoOBkK4jEV8wkRCTV8jwDAomWe83RM4DB2Pp8cDQBGDtblAl6j2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636777; c=relaxed/simple;
	bh=x9y2SVcVyagVE1Y8KAG3rSu9SNw7TE+5whyS9ptwyZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=l4rUjqvGdKejjSYBcFxSonnu2CGU2EhK9hpD7VH9afctXVE2lKoV6Rc2kDEtp6swpeK1ManjAH+elVF6oLySRUGsgeINkSs9Zp9I2zSVG8tRpQ2qCIEOAuYkbhbABLskJ0E44AotiIqdZIqzv0+peTunpxCQzNVg4DnLGLcOypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAXQWLGw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5135486cfccso591133e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709636774; x=1710241574; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9y2SVcVyagVE1Y8KAG3rSu9SNw7TE+5whyS9ptwyZY=;
        b=RAXQWLGwIlK/QmlA5w/4flf0Q03YQJG/mJ8Tspzrn5ZkBfD9V3yKeND/sPQbZeAjrA
         0XxqOHEXFjuDsL2+IBNmJt1l0ChB+wQGAGGw3H/0UuKnVpGrp1TeUSa50Ybsqx60eLJJ
         67BXm6FlywStiF5ZuXCY+l6ZCXYeMMdqOThJIXDeX3Crj0KpwYMci8u7li4E8Yo8IxC6
         T5C/MGmBk/2YNX2CgkvxkEhmXN+6OTsuGLjWRcSuVum7O+YmwgLLY2XhyciBEyRUJg2z
         C4UfAeL2g+Z2gYzbRv93IpxW/SQOPIFGlInOi4GREE1nhknxQCDQ/6as1BsxTvhl6wbm
         f2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636774; x=1710241574;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9y2SVcVyagVE1Y8KAG3rSu9SNw7TE+5whyS9ptwyZY=;
        b=U4dqNKV6n0FquuXy7E0quud+o98N7BeFbewsas5o1GOPz6HQfFxA50BO4/0yEkx28U
         u371EO8spj9rQ5UvFUn+i5c5IMWafmt+1sqWzB2ZkV/cKl1enqrhfYFhJDwesrwKsGlD
         7IhOv6Zv4MhbBrfG4Ren7kzxQZMFetWIJoQxU8FSGB/NlzpnfBo4rlGZDVaaCUV8mZiS
         4sgM0E0Vz0cXKOhvl0Us9BgZL3W6rh/kYMG+dOHiCKugyCd7XkZ56vtdWpvriGYWG4OT
         c4v4Jeg4QuhIxskQTqz4py59OfA2NDZ2wwHLAoDZoRV4gGBAyHVdooC9Rn57HxrkRu1P
         IHvA==
X-Forwarded-Encrypted: i=1; AJvYcCWAnIQ4EYIGU2gTmFzv0nWLewXHasBeWGavWRYHz1M3canLs8taDOq7VexXPp/egC3NNzW7L4KH8NIevOJRwrNGojd2gW0r
X-Gm-Message-State: AOJu0YzauiRRTANUlXK/qeszc9BxQ8Sjjl5mqCVR6XC/dqDlU0QWaqJu
	fprskuJ87LdC1nFaHH4dcko4UhPHBM4cxfR7xMl8yft9eEKfUly7qWv9Ys5g
X-Google-Smtp-Source: AGHT+IEH8qohUYrfQcNewN4Rf5LMXSeapX7QTNKRlfiOEa2n3z+PeBIBsRHSkZOSFKyd5cfPOUUwyg==
X-Received: by 2002:a05:6512:23a1:b0:513:54df:9573 with SMTP id c33-20020a05651223a100b0051354df9573mr865040lfv.26.1709636773288;
        Tue, 05 Mar 2024 03:06:13 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:554f:5337:ffae:a8cb])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b00412e293bee9sm6690736wmq.38.2024.03.05.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:06:12 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next v2 2/4] tools: ynl: allow setting recv() size
In-Reply-To: <20240305053310.815877-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 4 Mar 2024 21:33:08 -0800")
Date: Tue, 05 Mar 2024 11:04:50 +0000
Message-ID: <m2edcphrcd.fsf@gmail.com>
References: <20240305053310.815877-1-kuba@kernel.org>
	<20240305053310.815877-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Make the size of the buffer we use for recv() configurable.
> The details of the buffer sizing in netlink are somewhat
> arcane, we could spend a lot of time polishing this API.
> Let's just leave some hopefully helpful comments for now.
> This is a for-developers-only feature, anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

