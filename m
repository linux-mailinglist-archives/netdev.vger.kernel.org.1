Return-Path: <netdev+bounces-173677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66BA5A5C5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95251720B8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000D1DF739;
	Mon, 10 Mar 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xnW/0qk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD3BA3D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641141; cv=none; b=FRQPtuGhfAejKJYflGt+J9h3UKINRQZppu+fHr5WvHwx77W6x7mhNMqtqzVU9GoLM7QQLFSsSLO5a9iKokML/Ll9gLPeSnBrINapY26QGqacIMKkEaDt6mB56kFTN6Ct19ATRTBy2gsvbTWPRkmp0yxPTVvDYOsJ75BwExFOHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641141; c=relaxed/simple;
	bh=cGVJzjMUyp42V+VtQWNlxdnDpgs0niIX/wnlNzuMPjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyKv2iIAGYYI1ws6JnmM9E++bpVkbJc8SgBc4r7w3CWavWaC7o6zFwBk2N6MIeY4aqkrhgvewea1NbCh2wgm7801q4H5uV908MjS3Ur+q7XWtqg05mX4qpkDpsrVdABl8/3mI0yoBOnV8TKYySqCfD+GqgM9OrbDS6+2cS1qd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xnW/0qk5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso6991862a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741641138; x=1742245938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EnPPvg+1LakhZymMmWGLkPqciceMUvrTTKW76YVVfo=;
        b=xnW/0qk5RWnpldeLUm16K0LaKbW+7W9KAJyrx7pxPwvmEFhMO2rxqpSHVZxjKDl3T0
         nHSZvaYVH2WVaAxtN2wzDI4m8hAXgiDtteHDrqMnfSoi/dBoENp9TPHQ5gLSMvyEFflU
         DNXkc5x8SYVT8C+TakjKSfKgHHVKICgXDrM+Fj8hro3sdY4XfdHDiHTDk1GUeUckATT/
         oCx2rC3zLfX5ko0jcoFPt8Hip9NwKBDF0SQYzRbB3dEJwxkbqBEs6JtC2KDz0TAFtKbL
         TJytj0nox394A2Lo4ftpaDbco2EWeMO7z2feuKxNnzWjf/PWKTI7c/Z3ZLec24rLQGIs
         Yi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641138; x=1742245938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EnPPvg+1LakhZymMmWGLkPqciceMUvrTTKW76YVVfo=;
        b=rQQtGNRnKqmVz1M8fdbohmcdZ1eAoxpXX+w/64FOAJBI60hhWIZ1NCMFdlLIuq/SQi
         sotshhKO2nh6Tg7yqJ3fZDQTX/G8uH9SFfjuc+sBO/K2DQ3TUZYCoInRsSALnJv8bnbG
         F5HTIS/2NSqanOj+O45Y0DyxDAse2BD6YryL5/HT8hElZUErk5Tfu7FlNAyWtyIHdzo9
         0CNya/258l+NhHLeWY8LgCNPVuI6obp5DmZcySwvB/Ispb/wxNpkyCLwkfOpr/PeupUW
         C8fmyRxpSAX6S94dFHK7R7zxMQ9GFPrnmxxTWNj7Xo7DWoapBpi1vUhuA7OjUGC/05Ru
         lV5A==
X-Gm-Message-State: AOJu0YzpoiclrixYMabz2MYZMQX4R3spV0iB3fdwQE6TsF4hC2oFfMZw
	94OQrvoBxaohcn9Kh5eUvoU0G4xkLiehA2ykbfCjXghmxPg7CNLFKm2M2Kgltdg=
X-Gm-Gg: ASbGncuQaSgj2gNJFPQVxiE2y3hPbFgnHq8cyhurxEYaohs5LA0Q6r7HO5NLrNlut37
	LUsGhpwdqAorC3BGkudBHHkjaGzBbHRf2u+DAsaEG8fAQsL0Pa9EdqE7rOTvoU2m1goW4LZvjBb
	ty4RmAt8l+eRLjn9Gi+VNP1jCjtCTsNSkmrSN7QNzDaZNfTYkzOY765npe4xY70EEbEUGoPu+Mt
	Hiw5tHffPmTq0QJ6raqsEIKiPrWxUnJAqekkTR1Qj1PV1Y5VqIoFecMKDI2YOyBY0hTaSroCNr3
	W9MdgwQ+IHVK9yuO56cx/M39YVkFID/etMmIJB2kl8FR1G0yQDBPTw01jNDhdfNNoV3RibYVsYm
	ULSqJwJ57V6IQNo7M6oqz7w==
X-Google-Smtp-Source: AGHT+IF00RoooKdbRxt3PiF9kvdGXvg2dD3t3rIQ2teY+1iekVnEQLirOKDxpABl4PJXGi1Pio+IEw==
X-Received: by 2002:a17:90b:2f46:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-300ff0aa1cdmr1539160a91.5.1741641138369;
        Mon, 10 Mar 2025 14:12:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm11645969a91.34.2025.03.10.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:12:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:12:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, Phil Sutter <phil@nwl.cc>, Matteo Croce
 <teknoraver@meta.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
Message-ID: <20250310141216.5cdfd133@hermes.local>
In-Reply-To: <20250310203609.4341-1-technoboy85@gmail.com>
References: <20250310203609.4341-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 21:36:09 +0100
Matteo Croce <technoboy85@gmail.com> wrote:

> From: Matteo Croce <teknoraver@meta.com>
> 
> The majority of Linux terminals are using a dark background.
> iproute2 tries to detect the color theme via the `COLORFGBG` environment
> variable, and defaults to light background if not set.
>

This is not true. The default gnome terminal color palette is not dark.

> Change the default behaviour to dark background, and while at it change
> the current logic which assumes that the color code is a single digit.
> 
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

The code was added to follow the conventions of other Linux packages.
Probably best to do something smarter (like util-linux) or more exactly
follow what systemd or vim are doing.

