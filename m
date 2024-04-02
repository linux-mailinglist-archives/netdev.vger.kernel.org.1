Return-Path: <netdev+bounces-83985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B288952DC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C972813DD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF075813;
	Tue,  2 Apr 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VttDxjfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF01762DC
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060596; cv=none; b=HEp4pmPN7k7Fi08jfhaG4L76uT6pL2TBm6BARnAJTjethb33HHS5j7+fr+e7L15HdD7oPYWL5t8KSc+MnxZet3ZqEJib8NMZtQJOik8IYPSIU/OyvMmFjITqF6FzKPYwTrBlc6Nbb9EDe4il+j+vfuej+yc9Uq9gkA7XqZMApMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060596; c=relaxed/simple;
	bh=m+iVKK/Gn7Dbs1xAwl2/1C+EPqf05FOE3P5b1MNf0/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFXhQAnd/1fNVFFXRLjojxJChCkU4QdhhR/vv10q+mW0986e4pZXRUPeTvY8temGUMnOk8uYLimFmBiWG1wOEEH4wJ0Navjrmv3Rd18vgZFMnKHrsgFQLLl7Y0f/Hce7ysOVe23X7S8j92sx3dsMbw9kqJ07Nt8usOXCtAc+CVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VttDxjfa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33edbc5932bso3697020f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712060592; x=1712665392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+iVKK/Gn7Dbs1xAwl2/1C+EPqf05FOE3P5b1MNf0/4=;
        b=VttDxjfaLXA/VDleV5dI4gcWNxXxQjGvTT8PKdjL6Bnag4pL9y6GfOz57i+dmaG5+P
         R12KszxOP/cem1WwDh7ldrQziIffLPi68IpnnOulHHMh9ihoYZyt33Alds+hsD+fhdVg
         eeuR0+z7hz17+7y6/+lcMZQ9tOgcCPo0A5Dc7Ytb3+nfG1f2Rvr519TmSruprVg/5swq
         /mIOIEdnMSdPviIp4AWBtLW2h6eW0SzcUcKClGk316ILJBCauToesnlbKrAS4luWtfHu
         x1rwcbu0aV+r40Wtlq1xxm0Pq4D4s1hchN3geOXLE4r9E54GUePnepj1tMj+36nX5+iz
         44ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060592; x=1712665392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+iVKK/Gn7Dbs1xAwl2/1C+EPqf05FOE3P5b1MNf0/4=;
        b=BuESWG2wiXB/9Te+mb7JUXWr9an+5B73jsaUVt5RxUUhC3ABg5DPPCAwyIUWDAkUeo
         /fT0/+QxWJBIf1tkNp2PuX9P7eP1UkEgMmqXqZfH/pa4Iz4jDFiiYIYk6448KEC1hI15
         rMZn9lc5uzAoNoObgbjXgXjETdb4k6odQrIs6li17DR1g5oG8TYY/vmHX1Dc8xyBdzRw
         ZKyq5m3mgssCa2z+qpvsmgYgn0DUFKpUmd7cGcQ1u7tUU+3vx5+CArbgua56ptWsdQ6v
         OsPEL+UG0auM+onrC74mhNCMMsHk9Cgn7+TT9MAfBGS6dhWydy8loN5K6jn7YpApeqeT
         Jsvw==
X-Gm-Message-State: AOJu0YylQbfM1KfwlXVowP3BqdkrmJikKr2dT1EYaypvBFAIYeDxZ2pc
	khiPK2ZKhifQuYhFAGpJ1qieViwRQIFUclsv8dsXkymjTWkyLbrmx47wu4Mtmn4=
X-Google-Smtp-Source: AGHT+IGtZ2be8EMKquXjKqX3j3lwPH4nMF5ryKJC9+2CEnLKpKxgprEhrt64hmhDSUjE8ztgvW+TuA==
X-Received: by 2002:a05:6000:1568:b0:343:3a51:ad65 with SMTP id 8-20020a056000156800b003433a51ad65mr8517853wrz.38.1712060592413;
        Tue, 02 Apr 2024 05:23:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b00341cfa5f16fsm571114wrv.30.2024.04.02.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:23:11 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:23:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net v1] dpll: indent DPLL option type by a tab
Message-ID: <Zgv4qydVbt5fKCFW@nanopsycho>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
 <20240401031004.1159713-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401031004.1159713-3-liuhangbin@gmail.com>

Mon, Apr 01, 2024 at 05:10:02AM CEST, liuhangbin@gmail.com wrote:
>Similar with commit 08d323234d10 ("net: fou: rename the source for linking"),
>We'll need to link two objects together to form the team module.
>This means the source can't be called team, the build system expects
>team.o to be the combined object.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

