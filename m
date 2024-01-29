Return-Path: <netdev+bounces-66651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C642484014C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68297B22CAB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5054FA2;
	Mon, 29 Jan 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lzkUOkI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBE54BF7
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520087; cv=none; b=o3VuUWaFKZwwq7ZMOCsbtadMa2Au+Gu4dDXjYp0S6AnkvrQq3w1QxFTZTAEU7hdRaIMjjTJq6piZoa8XY9wX4KtX34wcnpxmKx8+MINhwKnh8zyLv3WVTz1gN7YnUt0qqnbYawuRiQm8Xc8wGoNeluXxandy43O/Faf/QaoxlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520087; c=relaxed/simple;
	bh=2wjNbV7klGZn+cgj4LYLLvwYAyZSfwOMZmXBO6exB5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byza4OYzsE2gemoyAyy1PVqQSBlYP4S4dNGYkwOMTlceY6R5JV2hAQ21/VhURCwTj8SjQXnVIl1tU7T88s3Sp/dKgaQrmawRW5QgqKzV0h1BG3ZIToFxtwTnU0ShKb0t7F7XPRGPXhYSfXUY+XdhEq+47VoAwfkz413oW67dYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lzkUOkI5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so4631435e9.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706520084; x=1707124884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96cmwipeg0gkLics9mVD1KcMJe0+Fi1RU4sBfgvMJAU=;
        b=lzkUOkI5uL6ZWf+Ex7Pmlo/W6nScpplrXfg4lgp0+G6HLcWqoMZ2b6+fGG+3GU6wfV
         /sV5hkce9AUKAr12JqHkwT9TnlxWlXq9WydMomX3TB9B3RUY70myxWW5e/tpFyCEUUFh
         hA6AFXpOTRDZPXnzEkzjs8M6HylzTHCUkii81ye5qzDDZy+G9cpyaApYVIJmd4w6BRso
         6j7o0hZoJZo9HKfGuJhEs6KW2JlGkzOEbuRD7XPo/3120zyhFbOjyzd7VQ/UqgYWYhUZ
         PC02obCR9GpJZ4y22XoEva2o1yUmICMPSRq2lPbW8VGDizVgWj7NpHdeRvvpf2eRHu2N
         8yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520084; x=1707124884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96cmwipeg0gkLics9mVD1KcMJe0+Fi1RU4sBfgvMJAU=;
        b=N50u4jFjAD2LvsHgwCtGGM45NeEyqAm+Nbr5nOW/VqNX9lrXwGY6E8qHM4NaMl4tAj
         Mocekd5QNaSr5eZWS5T50d3UdyMRrlVdGaItJmRZcC3MnyG3Vocld9G/ueSm7tfYDsiR
         UGqEZX1gyf4nxIRbLVt7+RJepFmVlDcdRz7EdMXpFp6AU0URuOinfnpLFgMuJz8OJull
         R9uHcziBaENa5uGALviTGMTxBL69gZZ/e+9L6xJ7nL4pXFRtHbwEhCnl0GfMWzWWhZ+l
         e5z6y40diUal/pDpvQ2IaTsIdG1ZiVbSdpe0X33vIFnKNsyujwJeb8VRKNhpe1ds7pKl
         hJRQ==
X-Gm-Message-State: AOJu0YxBlR0ob/iEv0I22L33yTMt0G4ihnJpn9wYakg3UoHOF8BMyAno
	UVyKposrFYK9/pVFQIOMvOx53Emr1E12tFr172hwd2//y+UMGHJ2Triyjx+XatU=
X-Google-Smtp-Source: AGHT+IHbwmBdo0rKS9EgkMoRd2pXGS0fTM3EgfRbh9i3UdzVu+V14UMFbJ+KqKjxXWZ5EdydTLyhzA==
X-Received: by 2002:a05:6000:1972:b0:337:b315:5643 with SMTP id da18-20020a056000197200b00337b3155643mr3577592wrb.6.1706520083883;
        Mon, 29 Jan 2024 01:21:23 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d59c8000000b0033af2a91b47sm1075732wry.70.2024.01.29.01.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:21:23 -0800 (PST)
Date: Mon, 29 Jan 2024 10:21:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 04/15] net/mlx5: SD, Implement basic query and
 instantiation
Message-ID: <ZbduEnFa8ULWxDt_@nanopsycho>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-5-saeed@kernel.org>
 <ZZfyx2ZFEjELQ7ZD@nanopsycho>
 <0a4ebbe2-93d5-490f-ae97-9b64bdfeeb45@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4ebbe2-93d5-490f-ae97-9b64bdfeeb45@gmail.com>

Thu, Jan 25, 2024 at 08:34:25AM CET, ttoukan.linux@gmail.com wrote:
>
>
>On 05/01/2024 14:15, Jiri Pirko wrote:
>> Thu, Dec 21, 2023 at 01:57:10AM CET, saeed@kernel.org wrote:
>> > From: Tariq Toukan <tariqt@nvidia.com>
>> 
>> [...]
>> 
>> > +static int sd_init(struct mlx5_core_dev *dev)
>> 
>> Could you maintain "mlx5_" prefix here and in the rest of the patches?
>> 
>> 
>
>Hi Jiri,
>
>We do not necessarily maintain this prefix for non-exposed static functions.

Yet, it is very common all over mlx5 driver. It is much more common than
no prefix. Why this is exception?


>
>> > +{
>> 
>> [...]

