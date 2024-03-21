Return-Path: <netdev+bounces-81091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F209885C2E
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745BC1C22565
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C9128385;
	Thu, 21 Mar 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zCyF18DF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72F86AD8
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035320; cv=none; b=B4SLFrEfbrVlJpCWfl4fOT4KNZnI38stSV+NwqdpmZfS4zackmTTByW+g5+2vKGHuiDwQjul7m7wrNK56BKg4ztCUevtZaSryqXhy1wEbpJpl4p8HIxw9VFyp5RQ3t3zmoQaXsA8VosM/eqq141UPPGy4WMaJwEUf2KRAUoc7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035320; c=relaxed/simple;
	bh=7/Vr7UGZFgfY5hiZbZVagMHjl3VeIKITw0zb4mGRSdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKFEPgVuSZsJPPEyiIciNedfdMcTSNRj5ArZB5CTSrPM+8MvYIWBKPCSBja1ZR7iEKsZ3z5L5d1s07GWLDdX+rSQAO1IxhYB8prl3ClZNWqy/SvYiMHUXY4F6VsT4LN7ALSDzoLNlWwiw3MGl1+w/ebguOJ9XcLbVyelWscjNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zCyF18DF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4707502aafso201837166b.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711035317; x=1711640117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Vr7UGZFgfY5hiZbZVagMHjl3VeIKITw0zb4mGRSdw=;
        b=zCyF18DFXr31m/24zPy4vHD0iVUXK/iO3DFdA+PsRBeOnabwqpwQZrSrqXFNLntlWj
         YdpGS2H4cq0aZtqGlfu0Dwqn0Be7UQ6OfvOAWkYHJqLFGpMfZLiiwtN7oNdOFV52hnxO
         v22ae/TBDNPTQ2Z9nq+MDnhRZxKkKLpSTr5HB4tgq9vmtJ11+Wku1Sn53OjHYtYWmtsD
         D6DFom5lcCNMTPSHD84mhxpVJWDElwzv8nSpNujgS0nt2eDW7BxA+9aTGrYHUQT/kz+e
         qzrAkupnUu/IRQIshLWaZN/nY+4yDnPw2W+oiPPnku4+VrX9Ma673TspLhmb31dKUO+M
         ZTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035317; x=1711640117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/Vr7UGZFgfY5hiZbZVagMHjl3VeIKITw0zb4mGRSdw=;
        b=jqLDgZdVaysm/2rjn5EMa6Y5SkHyfA+UaegryixCO57x3nG20VgeWVN2avJRL5QYXt
         oW1RGwLLzKA4fitHLOc0fkD1cPjh8PZbbUU/QOBl3PLc2GG5PrawdqQ3/tqTbnVB6Fqf
         YnEplOAmpy7W1kSA1LxaWNUM63ZpEmfsLLyZ8/7A/0fv5NTMsgrT8l1e03qtxBoCDjoa
         ujWp27POpcyRby1ftX4YsQvDssD+APWegAqrlGE1rBEEQ49f8c8bbgzGJZLf3IUOxZDj
         6DVqPJJGzC6cBtR+kFVgzDTwHq4z08CD7Ol/vAueZpIty8tbpc7N+EKC+4PnGjMoSCBq
         BSKg==
X-Forwarded-Encrypted: i=1; AJvYcCUnZIwYY/ylHz84+xK624cp66jJvEkipYDUXgkg5+Ux40YBWX9bfEPL4lpxrpWtdLyp5K59Acr6JcDGry5Q4BQYG981aceL
X-Gm-Message-State: AOJu0YzafwBurcq5qJ58TggAx1GdAaGOWUYpI6T/GXCGzt9J4b45YTBO
	6A6NlEvLupIKpK53QvSXNDtQMhEyZDHBgvTRxeGRTBQrMImQpu9VCK9FOyX/AKc=
X-Google-Smtp-Source: AGHT+IFzD7bSzwoych8HcblWm59fVdm+D+wuiZhdHvhn9H6Gbm7/4alQeCSXNlk1PpFwllpAsWO2gw==
X-Received: by 2002:a17:906:590c:b0:a46:a85d:de81 with SMTP id h12-20020a170906590c00b00a46a85dde81mr2754941ejq.12.1711035316755;
        Thu, 21 Mar 2024 08:35:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709067c8100b00a46a04d7dc4sm40922ejo.61.2024.03.21.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:35:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 16:35:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <ZfxTsVPwYbruXJfY@nanopsycho>
References: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>

Thu, Mar 21, 2024 at 03:42:18PM CET, dan.carpenter@linaro.org wrote:
>The "*hw_stats_used" value needs to be set on the success paths to prevent
>an uninitialized variable bug in the caller, nla_put_nh_group_stats().
>
>Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

