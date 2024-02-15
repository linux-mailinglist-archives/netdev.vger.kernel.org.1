Return-Path: <netdev+bounces-72011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5948562B8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38370B23446
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44E12BEA7;
	Thu, 15 Feb 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tpSBuAoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13112AAE4
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998930; cv=none; b=EXMYE73udERsSXijIpRxDo16foR463N4Hjt9fM9sdwTH/0Y31+zcC01PslwjaONtCCGsWODy3OhCsSKYDobzzESfgkHVD4rBBR8anGtTXwdYvX+j9RgADILhCD2RM8HPbU6/a7rY3qztU1M98XhUjrXslWJfzJtbn6jhjvE5jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998930; c=relaxed/simple;
	bh=2R+2SYI+vDxPHDhMyo/AhefkTHa62dvSGCCw3EsDWiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvHlnq9jNe6Z0lQyAxOuVUlaX2hVbIKUGSq1XE8YBNT5yiAvd5xDnDZDHRYJlCupbNnBPJQtdBz8JKuKA9zcx0maYAowvngPx75aUsVqFSyltu3wd1F1cGiHwQG5VN5o3DBRGd9McN/NS4bM5900Nu0t179cakV3IdrywTzbbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tpSBuAoa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-339289fead2so439298f8f.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707998927; x=1708603727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BASPsZRieoQj9jYTUskhFfUS6hYoPGwKU3/AwR9xS+w=;
        b=tpSBuAoaCppegz3MUOQInY33MjMUga28yQcmBtj0wgMjuKx6C54AUnYscOI2MSRzLu
         clnB4IOA4X1t7m1Z71knnBIwyIjrkZgn/r8C3Kbpr0lVf4VPXgee8HFKKm5usiB9RV9d
         /6Fwp8RCTcIoAJTHjmVh/GtqEUuR62X7UNQCUp8AsNDYnnQSDLBeEpEpdwNFkK2bFBpZ
         8X7ONyvhlwFOcbDpsTUJS/AGLjotLymSDUOFGRwT4dpgWngnO+SoZKooloE5ZF17uzV6
         GsGIhs0U69huG9gSJzHUergMd9ao3g+uLBI696lBJu4RAnCmf5f8OSLSEYq1xAZKUBwo
         S7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998927; x=1708603727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BASPsZRieoQj9jYTUskhFfUS6hYoPGwKU3/AwR9xS+w=;
        b=beZ6R/G2tYVadgZ3QyUcAnV0+sHMpDgalCxQeGF6UUNA2JG712ZRmEYFGxM6wMojJp
         22+bogASmPbVOpekVMf+Z4Xvm6uqCX2p6JoOKuzqeUpwCKIxkiUSaBser+fTJtP3+8YY
         AQ8jNkJk5hA9xwsdqHdr8CHpMOb8bK7dVtmWnulyzErptW/muO88nOWeXlTdt96P5BUZ
         yQOQIq3TMnuFCAqeq6xGEoXv1wNAPjfoGJ2XSXahguVchXmVY1jTg2VCE3DNIfHMaWet
         otaVrFpw+/Cuo3cHztK3ornW5vvGx2VTlsbub8UZLDXlCWDBG9rF0rSapcFbjqZMDfPT
         qhQg==
X-Forwarded-Encrypted: i=1; AJvYcCUDSe/JgdxGxG5fQQXZ1R30XMQZhWwtBuZ3Ax9s2pauU0WXRvDJmNTx79kiERY2VQWi6tHRf3PyFjCIuQwL8F7TDcuo7g+B
X-Gm-Message-State: AOJu0Yxh+xKBYKFQVXYgeoX3rJgxo071fibxM85WDYTn48rjol+FIIT5
	claEJumAVF3cZPo0m2dQDo6iGsTan/VLA+TV8otXPkPxJnE4zWpbWE5uQJNz7fw=
X-Google-Smtp-Source: AGHT+IGDOXaVHge1pDULeXoNelmKSM5rpkJ5GMZV50wGfG+qBDJR7lHWGWA/AhhqA7QP5Hi+iNfZHw==
X-Received: by 2002:adf:f28d:0:b0:33d:1153:f428 with SMTP id k13-20020adff28d000000b0033d1153f428mr239073wro.17.1707998926687;
        Thu, 15 Feb 2024 04:08:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b0033cf5094fcesm1626405wrv.36.2024.02.15.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:08:46 -0800 (PST)
Date: Thu, 15 Feb 2024 13:08:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zc3-ynqAEaVvGua-@nanopsycho>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
 <Zc22mMN2ovCadgRY@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc22mMN2ovCadgRY@infradead.org>

Thu, Feb 15, 2024 at 08:00:40AM CET, hch@infradead.org wrote:
>On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:

[...]


>> > I think all maintainers can and should voice the
>> > opinions, be those technical or political, but trying to block a useful
>> > feature without lots of precedence because it is vaguely related to the
>> > subsystem is not helpful. 
>> 
>> Not sure what you mean by "without lots of precedence" but you can ask
>
>Should have been with.  Just about every subsystem with complex devices
>has this kind of direct interface for observability and co in at least
>some drivers.

What about configuration? How do you ensure the direct FW/HW access
is used only for observability/debug purposes. I mean, if you can't,
I think it is incorrect to name it that way, isn't it?

