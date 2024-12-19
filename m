Return-Path: <netdev+bounces-153485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BE9F832B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4B61886B62
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E081A08C5;
	Thu, 19 Dec 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG8eYT74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BC194C96
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632504; cv=none; b=XLI59OMPgE/7IFUTKcb5rgV90fm5PoV+RoLKpdGMz0ALaB34wuqw0m0dKHNgHNyFcLedEONtpmHt7WPOcJ8ga3nOJIO1ufa9TIW4TeDIdPKQFeSNKmna+mkhCBsRfyhQIEWCUQTWlw4UdGbESQu9OVGKoNBiitJBoIThG79QDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632504; c=relaxed/simple;
	bh=MKQ9Akmx0hzquaxtWdYlUG2tO2Orljz65ta4/WOpN/w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PXYW7HJTbHjEOkXvNNW7tL7ur8lMbeQz5PBfuNj4+G2pAFBV5hiA4kn5TydCiUXlwtJkM6OKiuWgeLArZ0zf8R9QUtsCLUzYrh08yfi6Y2Bp2M9EazoleCWHsUlTko9l+AAbwniEc3IWoqT6FO4B7DjaLELMmSUSJbU4CoVwxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG8eYT74; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dccccd429eso8414406d6.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734632501; x=1735237301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6+E0cNUrBN0QoIStEO6J+NvMYZSnUBwFr7tFR4gc4U=;
        b=HG8eYT748WHVDDQo0fkT70Zqh8+EOqXqCwLNcdHS1S1BIazFyZKIp1U7Nw/OKihkZz
         tKvFK7wDQDO/S5FdvakUcAzl/QTlrtR3Vjh1+3rV8hDE9DK/zOyyq0jY4jc32WcxuIAS
         pngR0P8HcYBiQYFCFGkKpKkqs72WIGGuzkdAv2AAuZS09yarnCpIIxOSSUlMRu69rxWr
         FOA2lnOjP6GjtV/1fRZMQt4yRZ/780uhKfMNil9BcN66WUcqeLvEn+zW6S/1vpkgXeBR
         ZCtaBBHZP1stjOKX3f5ziaU4ZrtjPnjSKfNqQSt1zA125ffbmt6gNhVUj7bI9o/8kmLR
         ur2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632501; x=1735237301;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l6+E0cNUrBN0QoIStEO6J+NvMYZSnUBwFr7tFR4gc4U=;
        b=qfk9bRzcWiAbyWl79ZDJV/7asQvy93sK7lCSKyjqpTvK31wDJ8YwiPSM6wK+2toqJb
         V8WSB7U5SrSifbSOYwx6SgjljECuYw70ul988sY33NpEy+rBOqR+F0w4glVHqyv0AKuo
         6yANSYn42OAHRe1iKkGYbinUWa1QMLO+/QBdm8M3M3Znve7tIDzf3i7A+uTSGdXxNM4w
         KALKPho6+hV+Bhd+ZCtqtqxeX0TIQLbRucwUjOl49brU0otf/2tJZDjr5hlyOFuVrFyT
         /UfZR7b6gWW8dXdv4aSwLyMd1DLDY+eJW4c8Ws5D1caq8X0MwuUxGDs7JdWpxqOTQFMw
         NI+A==
X-Gm-Message-State: AOJu0Ywj/gE5qf0lE/6tf0yFdbfvmeIGdfdllfTTm9NQFDW7So80X50C
	CSpQ9uxFtugBmmzdffzvAnw1AsZKBOj1atQkwYzIx3FDZML8bz5BB0fCUw==
X-Gm-Gg: ASbGncuN+Aa0C+UPVhNgnLseW1oERKWnYJL6uEakzQmTGVngi4X4XTZfJcsXqUhLxx1
	7+ze/1HnUy17FQdj9KEopK6lk0bSEMSHWehNTxyAAnWBJJDNpono9AFgjVTzPirKdHPUIVcKOAE
	oz8HX6/ZWXdqtuMROzUyUgBV9+/Cclyr4cc+0/fdKCZvqgNU9vZ558lNUAVbmokaRJtgm4bZmqG
	gouGKVDTc1kKOxjPBsy/lxttkBIkRI7gEjDAyb5IlJGHWjeAXrqDmVjjP4LhFmcxqIxDTAWX/CH
	G9+jxAtXdiUDCOxSdh5Lh+H3MHL/YwpfgA==
X-Google-Smtp-Source: AGHT+IGa6kjs/bHHfJfocGaab5DrdP00xCMSbRkRpXgcYHb+7/4AkKRzE1eaIwTALMoc4KUOvvJdzA==
X-Received: by 2002:a05:6214:f2e:b0:6d8:a84b:b50d with SMTP id 6a1803df08f44-6dd0923a4bdmr128100796d6.33.1734632501522;
        Thu, 19 Dec 2024 10:21:41 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810ceebsm8947556d6.32.2024.12.19.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:21:40 -0800 (PST)
Date: Thu, 19 Dec 2024 13:21:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67646434a08f1_1e448329496@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241219150330.3159027-1-edumazet@google.com>
References: <20241219150330.3159027-1-edumazet@google.com>
Subject: Re: [PATCH net-next] inetpeer: avoid false sharing in
 inet_peer_xrlim_allow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Under DOS, inet_peer_xrlim_allow() might be called millions
> of times per second from different cpus.
> 
> Make sure to write over peer->rate_tokens and peer->rate_last
> only when really needed.
> 
> Note the inherent races of this function are still there,
> we do not care of precise ICMP rate limiting.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

