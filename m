Return-Path: <netdev+bounces-83041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E78907EA
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723381F262E3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFA131BB7;
	Thu, 28 Mar 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw0Azdvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3512F391
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649107; cv=none; b=LzizOuJeyzUTIkcP6Yiul538NLz6uTVqAOg2BgQIN5RVlSJpYUqfLiCslQ4l9rm+Q3JoS06L2VVhCc6sUtsSllJQ9SKXp+9GBtjcsj8/02G6+tfvy4CWDzsxuzxHFm3IAtdjeELVqA2poO9bTfbiQMLcKN5BJtrvAH85l/a7TmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649107; c=relaxed/simple;
	bh=nuK04bZ5oslOthMQ4lVLof11GO1EGLvX/wxmyW7M/nQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LB40fpB/yt4GXdGrQY892JoV08EPQnhj6mmZeZZma6qqotp9zNSMk7jFD1PpRSesfPfkZ/4gy56x46SmeK2MMjWPimbykBRFNMvXWviPXVifW5oxiA2QYaQJ8niLTDj84sV1eqsDv35anG964VWXxmr8S5bE26FwDfCemPxKAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw0Azdvr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-788598094c4so55506785a.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711649105; x=1712253905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxRjqNnvdF7ZPp1g7/U1YFRgJVDUpSznFhQFeF1O+XU=;
        b=Jw0AzdvrvB6+6HYLbqnTwGV54RTV8KWlJFMVwjdJRM+x7U5owEEDOPZaQ6Iie1L/5L
         aiK82pAAH4647kJPH6RxDhT56IM/unpZxh3fGa7BYF4O31sFx6P1iKvyDS8ilswgj7Hi
         a2QWQtrouAnvWx2B4m8M9ugcX+pa2u+LPk+V5iBhtQBOvAiV6TR7FPfMh0AOeU9kXZhv
         lBlIoQgDGA9YiJMyZvpcDCtfXrINHXVJ9+C5T5zORmyy848gHf5qw2Wz463ADkSau/oY
         2PQ1qebh9+JdXHwPQxj8oqh3XteUYE+Q6O4KQVghU9A9ASn/Dc2XSnJ4gIBkLE1QML4I
         LcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711649105; x=1712253905;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxRjqNnvdF7ZPp1g7/U1YFRgJVDUpSznFhQFeF1O+XU=;
        b=GWzxLb9E6EOi5oLh2uzt+q/S37YAblgJ7FrKRceC4f/efoZ42nOxcrVDtwkhSxlfup
         TDkO+Xtn3pgyEfG4jJANuxERhlmuM+wZ//TqKSrFTV9swxPxIG6Q9n+8eSpexN4Uo0L9
         MTMWz37LvWvpJNPwNPXsqZ7jkBwb2UYj5c32aiOjYa6DKbxMDxIpyZsvYhtimsd2JIm8
         qn+SSbyYZf3eSHMLiJbSOL3Xd/eGpNGpu35/tPDpxYW1GSCNUeXH7vACRM5eu11ZApEr
         tqdHbolvcbo7osOXQkw6w6S6wLk0sUPvmJl9racg3f+aGvJ2X4KY5J3FIS6ANphAa2+S
         gKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIsooApJXnng7PheNQcGmVUjtBK50p9Ij2+XbnXCslyfgLfVuTHOJkqJi83kqpU7dgCp3SRMagnTN4/4EYNRR0rPEbdYu/
X-Gm-Message-State: AOJu0Yx9s8GzNdaBVD7mz1cuN5K2ijVJRbEG5WoHqGp4rnFlND3R/ucA
	JccaJWaTO0zjd430uHGWZfOYkA27ef8bk9sHhZxLsCFjNwwvUQrQ
X-Google-Smtp-Source: AGHT+IHRZ8ehx5tbBHZ7XueHCsvGB/XRtKcpqItWBinz4D8FWa6Bm1IqlU4WImxsER9KbGMJYjyKiQ==
X-Received: by 2002:ad4:4a0b:0:b0:696:52f7:d856 with SMTP id m11-20020ad44a0b000000b0069652f7d856mr3028481qvz.23.1711649105252;
        Thu, 28 Mar 2024 11:05:05 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id u10-20020ad45aaa000000b00696a47179a1sm844388qvg.14.2024.03.28.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 11:05:04 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:05:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <6605b15094f38_2b8cd6294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZgSzhZBJSUyme1Lk@tpad>
References: <ZgSzhZBJSUyme1Lk@tpad>
Subject: Re: [PATCH net-next -v6] net: enable timestamp static key if CPU
 isolation is configured
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
> SOF_TIMESTAMPING_RX_SOFTWARE will cause a static key to be enabled/disabled.
> This in turn causes undesired IPIs to isolated CPUs.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

