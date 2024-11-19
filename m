Return-Path: <netdev+bounces-146264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5ED9D28A3
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9D7B23019
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1881CDFDB;
	Tue, 19 Nov 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zj3Ttou1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F51CC89E
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028080; cv=none; b=duptVfKWNmJbF1jVtQxtak9tBF23WrvMUfiNrvQlB2twIFRCgBxmGk+Y3JoUp+R7Adv2JpyJjlRnxdX5SIUCegzku1DDX1isKc0fnrnk5mm5DydReS5EdEODPqizhbHPF7/tBv1+WQrnvYRrICDEih570XuKu3JNHtRhK2UsM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028080; c=relaxed/simple;
	bh=ZYOYx3kDqNaAc2RhK2jsSET3mmqRKcim56l/2dY34II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkHN3CfOgil3N2zKmPBjvERnYPN5FjnlT6NYgoJeNeFD63uW/gyNyHu761YrojOJHZarhBhFLZYmuMdXmuiXboMIteVGj2aIuvIHPCIH//fnbjPLnH1ZPGLYl/lEstmMeYiWw9DdHbk0wiCsY2UBJHFW+5f2mk+bA07bsC/lRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zj3Ttou1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so6191697a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732028076; x=1732632876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/wH3bmuYSOHHOwLUU69Mw4Cu3NRrbUkwVayPdHDog=;
        b=zj3Ttou1e0A/F9tA+HjVuie8ZMN6ZuTkwORd2yue1dwsz3D4r1VndstQXW1kQExtQ7
         V/v+dqqv2KDtS6TWiTLTl84xJ/ti2MeSU7N9yy7LOF7yjmvYvkVIrvAseFtiwbE9FS2X
         69XX8PmE4nyzjM/pOunb2A7kiSPP4WrTQfRYlNdUJSnWLxCJ3UKYQ+8jg1KrcF4kqsvL
         cU3aN3SoKcX2BYYT9H9As6PaxZHMT3NKs1jTSVCZH8pNhTkrn0Iib6z09WszpgSCqjw4
         v1T9naPluP6jJ0SfKzV0LRp/Ub8MdBhGH5TKc6tXPyaZIt3PIBOP87kJ7XNTXLA8Fkz2
         ELrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028076; x=1732632876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc/wH3bmuYSOHHOwLUU69Mw4Cu3NRrbUkwVayPdHDog=;
        b=jKmwskR/VwlZlrK++36dVB7z4nlMa9bld1HWn/UkXh/zlSNtm5h52K4TymJ82t8BOY
         6khcsvqhWnGg8V5y3Ob/E4P39EZg4wE1prmiioEiViJm4+b2t3wmOh0FQLjysb4qRaNI
         NS9vLWtj1vNxtjhXhx3+I1rw0GvkWr+7j7ePGip37bcmtLzbTCJAgCPjkVZgF51oFpb0
         LvShb5fZlqnWPE43xLZf7qp23CxDiOurAX/yUOFzXZs5asoTSSSL+8CqKML8utz+kb3x
         +G5gXD2omWmvcCe0K7EVTzLMIUl7Q7Cs9O1x8i0RmhMioUksJWZ0BdvvxXVWluiibVFK
         KWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVoQ48sCHELVwSFtT9st7FK5MJVZlBhyySBm6KD6ZDueAQKtt5nZyntoDHPLj6GTDLrly5Vue4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh067yT+4dWv9txK6s7r1pE+Ms1Gc4rLPZJdf+Z9AURCCXGY16
	mpf2MNcZ3aByBly/4gFefBg+MruURcP2pe4jPQmIw+JIxfCgUbJZnTl9NQz8g/03F+mvqlAoVHy
	X
X-Google-Smtp-Source: AGHT+IF+LJ5BopLAkVAcIutoot8+6i9QFPEx4ARS5ISXbmjPVOnvFRnknfI+GEufF8+im92V5q1nrw==
X-Received: by 2002:a05:6000:4619:b0:382:5036:d1f2 with SMTP id ffacd0b85a97d-3825036d5fbmr1690367f8f.54.1732027591447;
        Tue, 19 Nov 2024 06:46:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823390c818sm10993503f8f.28.2024.11.19.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:46:30 -0800 (PST)
Date: Tue, 19 Nov 2024 15:46:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, donald.hunter@gmail.com
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <ZzykxEIYZPjjRbVy@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
 <20241117205046.736499-4-tariqt@nvidia.com>
 <Zzr84MDdA5S3TadZ@nanopsycho.orion>
 <b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
 <Zzxa13xPBZGxRC01@nanopsycho.orion>
 <20241119063313.5bc46276@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119063313.5bc46276@kernel.org>

Tue, Nov 19, 2024 at 03:33:13PM CET, kuba@kernel.org wrote:
>On Tue, 19 Nov 2024 10:31:03 +0100 Jiri Pirko wrote:
>> >It seems that type: indexed-array with sub-type: u32 would be the correct
>> >approach. However, I noticed that this support appears to be missing in the
>> >ynl-gen-c.py script in this series:
>> >https://lore.kernel.org/all/20240404063114.1221532-3-liuhangbin@gmail.com/.
>> >If this is indeed the case, how should I specify the min and max values for
>> >the u32 entries in the indexed-array?  
>> 
>> Not sure. Perhaps Jakub/Donald would know. Ccing.
>
>I haven't read full context, but all "nested" arrays are discouraged.
>Use:
>	multi-attr: true
>and repeat the entries without wrapping them into another attr.

But we need to use the array index. It looks a bit odd to me to depent
on the index in multi-attr in general. It is not guaranteed other
atrributes don't get in the middle. Ordering should be maintained, that
is ok.

How about to have a nest that contain just one multi-attr attribute?

