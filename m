Return-Path: <netdev+bounces-80325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221FC87E5B7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32EB2827A8
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE422D627;
	Mon, 18 Mar 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aT6znPyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBE2D044
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753957; cv=none; b=tjJeGTwoHSXw7/vjQu+Or+hFuoM2dh8rqx52QT5tDZ9kO7Y4tQjxcxCqBlgJ5gzbA0xGhSbGUIW4A/C7pqW3VrPpZWA4pUTTlfpVmiDFVfivIfQb1DFcmg6ag+h3IWRHopEESpVToDhEjDceVg/w9MgMk/PNXo8s7vFhv5b5n/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753957; c=relaxed/simple;
	bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3UvtjBGqw6GeXvDZbMeGtQyq67U8au4nPdpyTMnBe/CfszotIvJPLmKaoBhJ3sl1vuaTIJsNvFtE9C2qFt+DweXX7orDZ9Ux8KacaHNqW8CdE5jvJyiI4gY4kq5JEnoBKCQXPLWa1i7/dxJdqxuZWSTT9dFDhm6RHdq12Ujh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aT6znPyw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so2201879f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710753953; x=1711358753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
        b=aT6znPywi018D1glJqK/30q2e2xOFfu9dA5wrsZMju/zuzKH5FedzamUWzusnHwRW6
         5zH+99mA1GPtTbVjWVkHOR8Jlrg7v54X/JYa1krfWOJQg0USN7seE1thB8nUChXwt3EQ
         9YJCJwZhrZ084CYttNpyJq4FQoIlz34SA0DXKkU1gTfHEgZxV6gS0wOdzVeKiZWFZBzq
         VsoYDd56uvFr/WRMcD7gMB6syhNo79XBBRgfLTv5jGqt5WE4JZ2GPsBHG0iu+sBEjXCK
         xgQ/MJFAC5H1O3hIFzANo81s+rOGn4COGwal5GnNeWG0lizhPd38rARo6wn2rInTacLD
         powg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753953; x=1711358753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEOm0EiFBqFYUj8BdCzuvUG8K0L0U3LAU+dVKRjw4k8=;
        b=DVDfiBTNZhiCK5S6Yi5Vw0d+Bnh21RAq0BvrIVu9nuPNVdycIW0UdjR6zRFDbJGUEG
         1W6JVAxeH9IBW+bdcCV2iUmPlJaQ9dGvomdGQoXY/ixGk7c7z5US3zD16LK/Sksl7F9F
         1HAZ7zLG7AQJH9FY2okqtFmA7NdBJP4+tc+aMgWOwV78Ve7wdh/N6lACANsylHB7LWfc
         wvcnCYkoE+SdOKAO0lJtV9zF/ayXeDmMmOg6/FTx+JNPGBfY6c3cdFeUaYXdb4RoeouP
         sVTSBlPKRdTgwn5/XUQxgE1Md7BWnuU8xZZgxka4nenCtykwYON3bUaYM18zWgIAH1vl
         98bA==
X-Forwarded-Encrypted: i=1; AJvYcCWc8sImF1AcCt9exTk80rUA1o3NfbxD7hYu+EF7CBx9x2qLJKb2RdBrhMAHpPZ+YsqSqoKJ8aK+Dm4xz4MEBtw+OukvK90x
X-Gm-Message-State: AOJu0YyopR3C2/ftsexdu/JsbRfYjp10ImeWK1WTj+cuP+ix5xARDgYd
	jmP2JvZ4BS00/M9quDz0v4neeYjJoS7B+eEPJE56MCYjwpJILvxh3ohJO8xw0mQ=
X-Google-Smtp-Source: AGHT+IH4VruI12d01sMu0QUhvz+bFlGKzrMX1TpGt3UETCdTqTB1BJVof+0IldCD67i/nPgANjkeRw==
X-Received: by 2002:adf:e582:0:b0:33e:c2a5:15c3 with SMTP id l2-20020adfe582000000b0033ec2a515c3mr8423129wrm.41.1710753953291;
        Mon, 18 Mar 2024 02:25:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f10-20020adffcca000000b0033d640c8942sm9355029wrs.10.2024.03.18.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:25:52 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:25:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Message-ID: <ZfgIneq04KwBPWqV@nanopsycho>
References: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>

Sat, Mar 16, 2024 at 11:16:10AM CET, christophe.jaillet@wanadoo.fr wrote:
>UTILITY_NAME_LENGTH is 16. So better use the former when defining the
>'utility_name' array. This makes the intent clearer when it is used around
>line 260.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This is net-next material, yet net-next is closed.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

pw-bot: defer

