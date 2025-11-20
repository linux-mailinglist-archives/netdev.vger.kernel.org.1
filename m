Return-Path: <netdev+bounces-240421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FBC74ADA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6134BA63
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A332C92D;
	Thu, 20 Nov 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1KgjbmiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE02BF000
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650361; cv=none; b=M2WSGhNSvGRjxC1IuJUQpjDvxoGSZZHfxO4CtQHTyFmPzTxv4fbSJ2ohagqyEMcW6fdB+IrIlCkD6WWzUhsg/3q/d6EscxNstlTxddZNEvxsxMKRlPWz1sSulcWNMIktDxv+83op+DOTaAjwAj4kgLEieOkg1ZYR9KdyewRuwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650361; c=relaxed/simple;
	bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXFdBvsLadDgc8e0KqlARcwpTj7dcRV2emPewBvppTCK7rWJY8NZ+QsdXWaoFoGni7ASRFAT3uUqpbcEAhExJ2yxgcaw5Ot5PwvqPYi2kL8oCQv40cTBLVYTiWhGRsdq8A2yTmP4gPgJ2kHgyLz5CWeGnAYlNEaSNq1NEVmRLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1KgjbmiQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b73875aa527so158295166b.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650358; x=1764255158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
        b=1KgjbmiQcA2RVz54IvXXlSdGGsuG++U7UX4hfHSFB4tLAKJpux6kPxygEldzuHAZkq
         wdoXebLApjfbrZ+2yY2brZByqzAdbURTMN5OaBc6uVa9cnhwXNHvXB/6mvg4585jXWdo
         68uGnDjlfRdY2UK8IguwYer+G2pbFtwRfye2PlZ1YIAqq6xWLlt16XlrSBvRrnLMZpNR
         x9tHhhmEBnj8LPysGf/Ct+Hxxl3JThedC7OTgE2wLqEnKL2vLxLEMUi1aOtGqRoNqVS8
         gU8ZAR33ebFCTMg+LTGgZTi1D1aV+l7Knc4MDkGddR8GQ3RuRiPAoRbBd2R1CVEAFBx0
         yNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650358; x=1764255158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
        b=sSE6v8E/+hX1suCyYR/1BZ3qNPxENp6vbx1XxPc1FgmiDGu9dggm+FIu3r+aT5VkEr
         NlEOPliRlSO+sXK7f4JOa5VqrHhRhKrfu1dJyzbUEPodRxKGW2aGctxVE7jvZqIg8Ehd
         8j0VaGgbQvi5FuKOkMFh3FyVWzkKhK5VWR40/5O12AEbCh3VdvKaulQbrE1hD1ZCi0i2
         6NshoNJ+ox2h7ZT5lwHpqz9Bx4XxbodJV1K/beamJ5a4IaEpVLtco5TPVE/nbCLDrPbA
         wpYQQm8cs3lhRxSBiL/9pl05uqEJ6cqYk68BkNmuB55V0s4MfdR8Fng5qaX+nOIMXmQI
         ppLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXC5pPKD9/TeUitVYWy3j0nuzAjsQirvLwN8G4XaOyzCoSme6JRPGCOjn/pQeflbrupJl7sG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwwHeTkaPQBDtUYRCzAnPKD9Y2zErpOIjJIWB15YHP4nZDcyW
	lr6kMLpWjZ/NZ8w4elQkBPfEr77tyxrnqB1y0FbvsbIPrP5Ne8GHSz/5yaGrBRMea0I=
X-Gm-Gg: ASbGncswDa1oBIo96k9NuAFIaEcCc6psUS0lR2SFqoEPSAhiCyZBkN2iUTiL1RJK8rb
	VybwQsxV5oPuaCgYrfhSYw2Mcve98qT9m0Q2pZdY+Es12bvPiWSejy4c28cFihsTjebUIXzq6uP
	bQpqi+Vuo5vd7NugEExe2YTGt4Tb+8Il+fKlGIcVasWXizacFv6hacPqu9HsneyRon9c8mYXat8
	/xDYUhzZkCChlyTgemEEMqdGly9P0vso/NvTHqicV8oqDXOZdHUdZWZy0fmQPl2HW/Pvf9t370f
	CQjw36bIhkHyTS33eaaPynY3aqEAdeJKRt9ISt/wSrxETMPs/CcnIXlBOXNE4frOJy+MHKUHMOE
	m+Fybb+pma2d7hpIG2QG1/tAc1jyfYHWs0h3MPWiDfZfh6OWJCpm1XRstE768QqJJHer1gC1dnC
	UinPGiSoHjEH7/GzWK970=
X-Google-Smtp-Source: AGHT+IHij78wIttXL5qrzeJ5Fr4uMDiSvsvUdH/MMYd2AuxlJUx0L+zs8iuv/NdnITfidNIJsVOY8Q==
X-Received: by 2002:a17:906:478b:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b76552b9f32mr307984766b.24.1763650357685;
        Thu, 20 Nov 2025 06:52:37 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363c56a4sm2255897a12.15.2025.11.20.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:37 -0800 (PST)
Date: Thu, 20 Nov 2025 15:52:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 03/14] devlink: Add helpers to lock nested-in
 instances
Message-ID: <hj37vfeodmmjpfrfa6vnwm3rwp7an4fzt7bvi4fwyusjzgbtrm@fc6j4szuodq6>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-4-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:15PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Upcoming code will need to obtain a reference to locked nested-in
>devlink instances. Add helpers to lock, obtain an already locked
>reference and unlock/unref the nested-in instance.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

