Return-Path: <netdev+bounces-79069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AD877BBC
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFBC280E87
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE0FC17;
	Mon, 11 Mar 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JMbRbLrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6E125B2
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146092; cv=none; b=cBpMH9KfP685y/eiCdAOP8nh3xatw8mS44r3ilDB0ZOYIwYuYHeZtAfCbIinlRO4Wt3ME6/iwnbrRupV/xoRA/oA/2JAyjSndXjSW1uGTnnaAjQ9fhfuLIe5RH1Q20a+xzGVKRLiKvfwofy+l8bVcA+rEgKGFhfk1okPJdIQx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146092; c=relaxed/simple;
	bh=+56gnhOdDa4MQPCjidHl1cW82GKxo3fwPSRhJ+vmIqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDhrxU5uBTN7jtM64PH3vLRp49MaR3OYBAQQ4MNVN4toLTkOsHmxVRTeEJx+5BoGQb9o2EMwZQOly7N9dc4vuLAI22vygIop9rtKBu9A9De1/Hh7Vlj9i4dlbWhfRmW9DF6Jfv7UASgFvb7QF4GJ94FT0jWbxCROP3ZndEXtoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JMbRbLrb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so4076956a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710146088; x=1710750888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SqomN9d4ARgKDPw+9BbVo7j9KTW4k1shjSc7RkylIg=;
        b=JMbRbLrbfrYQSoSFaUWx2AbkwjPB7WA/1S1nx/SPfvQAquTpmk4SsijFSahgS5EhlL
         xb7qB1XlHvdHLWrHCUYRTo4QRu7OqOJT4giz6qYeJB8kgQIkCr2tWvT2dNq7+YdzcWsY
         aoq4uWIxe2B0WC5XhKCHtGDGTJe6gUHbovE2wsVhpimlJzUGRbjsw53R5qHdzNQ34SRx
         q7ltnys9hMZzqH3CpNXHrCV1/stO9paRQrVIgLgRbIZPipJC06EKKHG0f0SYwlOFKx+b
         e2RMmcS4hif54VWH+dxMyVQn8tiwsekQXOm5hyfxjwIsTJgD1r0E5u8QXLueKkgbqn+Q
         vr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710146088; x=1710750888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SqomN9d4ARgKDPw+9BbVo7j9KTW4k1shjSc7RkylIg=;
        b=awRhk9l2PPz7gzI1PS8Bj7ftqAWUweVwjt9V9h56aPG1maLrYGZZeAqMnk6Od1dUwX
         yMy5Ey6W3rrpVRFW8qa6qoepIUoQlUwvkbWqyeGC1AcyT2vIZ/vbq9182zO04AnyQL6q
         IBqxHyIBvntH+sECNZMfmscYtx9kNZ6l+LRd3HxvC9NGwpyIyZIqC4CFhsc01sJ3UQBH
         XUApGkwO1ucTeYIyDY0V72lUDTnbBwAwJMTRzm/4Q44tcswH9oSJzYpqwhNON6IHCqbD
         lUlSFKsbT6Mn+F7oJwTOEBk907KLwZuQ9yFjtVx6HANPS/IjQw2gubZbjYuXe0AT7BBm
         MxBA==
X-Gm-Message-State: AOJu0YxEUMZjHeFCsPA0QYOX2jdLQxj0bUUbqVzzMngb1xc0lBiuAQEl
	YMJ8esih4UyL7m0ATa4Qnc4O0wP9dZnJ33+ropI8284bIa4bVhJhejnVZ+A4fw8=
X-Google-Smtp-Source: AGHT+IHoXBZOeHptJIugrRS6bfBShGdhWG3XML2ZWQfwg5e/+GUeuuJ5xoqyK/oLpPIIzZ/sayjrPg==
X-Received: by 2002:a50:c05d:0:b0:565:98c5:6c38 with SMTP id u29-20020a50c05d000000b0056598c56c38mr4201082edd.7.1710146088124;
        Mon, 11 Mar 2024 01:34:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402149400b00568229390f2sm2715785edv.70.2024.03.11.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:34:47 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:34:44 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com
Subject: Re: [PATCH net] devlink: Fix length of eswitch inline-mode
Message-ID: <Ze7CJDNDicurMYGS@nanopsycho>
References: <20240310164547.35219-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310164547.35219-1-witu@nvidia.com>

Sun, Mar 10, 2024 at 05:45:47PM CET, witu@nvidia.com wrote:
>Set eswitch inline-mode to be u8, not u16. Otherwise, errors below
>
>$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>  inline-mode network
>    Error: Attribute failed policy validation.
>    kernel answers: Numerical result out of rang
>    netlink: 'devlink': attribute type 26 has an invalid length.
>
>Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")

Oops. I wonder if I messed anything else.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!


>Signed-off-by: William Tu <witu@nvidia.com>
>---
>Or we can fix the iproute2 to use u16?

Nope, this is UAPI.

