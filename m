Return-Path: <netdev+bounces-146285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6794D9D2997
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B56B2AC29
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C61CC89A;
	Tue, 19 Nov 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j0NVwEar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C71CF5E9
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029172; cv=none; b=oW0t8m8JrPJPB84rsKazUT7tNzizviftQSIjFRnOc/xut2qwsyYZe5moi95bfdZSugcmEVCDzMin1RUUhhsrb86QbgvktlahWaEf2zTgm4dXhTXPokQGemdi7tvxqqDzZUOkKqkHG3pvrBDWpVfyjqHjpeqZNIxrmVkJ4XgxuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029172; c=relaxed/simple;
	bh=na11rZZxbjaWWHHHvqe7qQmgWk4VpY4seLp9B30OY0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiFkhY5QXARsHGIbVF/c8Yeft7wYkETbGeyoi1V7yJkfMU8plfSNE9qparH0Dtf0IXxOixfF6uH7O44mPtteIZqj2CKybBuQQNjSpKt7RYJ70Wy1fPJ1UiAE8xbz3oIX/A20sDigDCJ39mS6daJkH23lPsXvscy/HWJbINt9Hyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=j0NVwEar; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso9647075e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732029168; x=1732633968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9emVvMlIQyUe97EHGi47adssysazKApKvK3J5heDDH0=;
        b=j0NVwEar2aM1gTZSMdCHMoTfZzA0ivsvPpd0665aN8+ZwZnjo0iG5VArDjwQGfILMP
         7+n75Pngh+uWT0nd0pmZuZohjirRlEPL/xqtLkpcMG4M7q1XE3sm14h8Vh8tl8e1k7wO
         DMA9V54N4IlfFAFFTTztaz5AWhfoBT6YpqRIZ2fqeII3fbt1yimrv0dXRBPJP1mnTAc8
         M4atZifyumYzR1oCvFUwBdaXAABwsN8lcdN/U3gKF/Y9d1q/sK+h1fvRXBSq1G66F4t+
         s/dplg2s+5uW8x9o03S7j6QlsvCJgHAJlQf6+8RqCEzk5g4U3gqjdE5bw3ieBRepEYAk
         nxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029168; x=1732633968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9emVvMlIQyUe97EHGi47adssysazKApKvK3J5heDDH0=;
        b=m9ruNhLnXK5TrjbpdXbYMhUvE/F3oZo/Dx1Kcw/I4Tzc9H2u4mTIZWKn8WpKL0Bf1w
         ZZD0S/CU6UuGYjWq18b1tjBuq+YaANQCW3EA3/o/Xo/Hu/gOs++wxxkdpW1p4c2ANWRf
         SlrfW9bd2UTtTBVirbby6WKKPqwHBje7Tzuda1lrDE+1DA2mn2VndYIHyiZjoziyMwMx
         PxcAkCGw3bF6vh7bBeAeVMgAnRb8HkGHydQBbmb8bIRz2mao51E+RlaseuBew0NWrxRN
         M28J5IwdFA4VFd7OTG1YJhHwPcKJGQ0cKz+4RlWLGqjzZcGP6PxZrKQ6grmAaMWS5fLj
         icQA==
X-Forwarded-Encrypted: i=1; AJvYcCXzJMqNzga2fod2nyvbN/Xg6D8zhcZlZWafGaWjqigk/oGZcyuntMZ6JEUEYPou8V+e1TFj8xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpfZd7Xgc/g2Go44Ydy3lrANCDyMp4dAdE0B6gJXD0cBNgTtw
	G9fL7dk2NKmTQZueEXERJhtkCQefOChhP+heFKiT3Dn6azlpWMihRT7oL/LUITk=
X-Google-Smtp-Source: AGHT+IEmx4f7AlU+sb5maEbNkOSgm62MCm+NueI5hUbIOcQ1tGczbv/AsM4N3gPa1fU77IsXFs0RnQ==
X-Received: by 2002:a05:600c:1c98:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-432df78a858mr121999375e9.21.1732029167717;
        Tue, 19 Nov 2024 07:12:47 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab807d4sm195476435e9.21.2024.11.19.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:12:47 -0800 (PST)
Date: Tue, 19 Nov 2024 16:12:44 +0100
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
Message-ID: <Zzyq7BEoaJHk4uy8@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
 <20241117205046.736499-4-tariqt@nvidia.com>
 <Zzr84MDdA5S3TadZ@nanopsycho.orion>
 <b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
 <Zzxa13xPBZGxRC01@nanopsycho.orion>
 <20241119063313.5bc46276@kernel.org>
 <ZzykxEIYZPjjRbVy@nanopsycho.orion>
 <20241119065118.24936744@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119065118.24936744@kernel.org>

Tue, Nov 19, 2024 at 03:51:18PM CET, kuba@kernel.org wrote:
>On Tue, 19 Nov 2024 15:46:28 +0100 Jiri Pirko wrote:
>> >> Not sure. Perhaps Jakub/Donald would know. Ccing.  
>> >
>> >I haven't read full context, but all "nested" arrays are discouraged.
>> >Use:
>> >	multi-attr: true
>> >and repeat the entries without wrapping them into another attr.  
>> 
>> But we need to use the array index. It looks a bit odd to me to depent
>> on the index in multi-attr in general. It is not guaranteed other
>> atrributes don't get in the middle. Ordering should be maintained, that
>> is ok.
>> 
>> How about to have a nest that contain just one multi-attr attribute?
>
>You can make the entry a nest and put the index inside, if it is 
>significant.

Okay, sounds fine to me.

