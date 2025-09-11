Return-Path: <netdev+bounces-222334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBAB53E66
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8735C00BC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D22E2DF2;
	Thu, 11 Sep 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TQXmQ0mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E02E2DDD
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627999; cv=none; b=LO253HLH1PmAajPLOXV+jxVbZg1QubhWp7iAu2JOAUoce6umT5YksBaTtlY7rMj9j/55wsNU0UklftKYPsrk8QRy9b+wtbVVzLJGRdxpjouCYOfho0bo3DiyMynw4jAzdCBQPKusSzrkuBQEr+cfEpRkRCaztbXlaRde5xgqWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627999; c=relaxed/simple;
	bh=1i/bSFJPS3rb5WZHFKhK8/2T5hPyRzAgE9ElrMASisc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7GnQBoPE8gA0kL/p4I0AlhKqE0iqfUU6H35ofoWgjl0W4WexhVbNC1NagYZp1MidNPUilU9a4CW/f09v5l+y9Cy8rGqJ6ABrpKIbomtB8DpyGdYNX+S27mXbNBe/+p3OULy7Sp/MAwX+BXxKsBPeM0u8JK6ZhRxkc0EMyDCprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TQXmQ0mz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-80aaf37b0e5so144459385a.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757627996; x=1758232796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKeR5+cTeruy4t5ASGpY5RgikGZdd88OkrN7PAVzq5g=;
        b=TQXmQ0mzK4X6qKC5Tp0T8WdreMUIEnYhHVjEAtIla/1sYWZVCmyCCopwrnsH4Ze4m0
         mZxDgjUx/9wASRpmogiwEgLQ2zPpuYNWV2FrBowa+/MLpXd4l2irmoCj9LJzs46iok3Y
         Y4U7G0idFw7Xko9tSIBfB7t88ep45SGwHWiijOetkP/2iSZuFpkmCokIAk0ZSwajF0gE
         Kf5rHS4+ZlMZp502g+Vwzpb+qYCX6KewEFzlPyvAgdGcKPogeHXzTknUkXrMTOgLVtqb
         KTKtvkc9ru1xbljvU7DHOzn/aNCF7U+897yNv88e153s6hg2gRAiC/Eg7lfnkBlY55fm
         aW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757627996; x=1758232796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKeR5+cTeruy4t5ASGpY5RgikGZdd88OkrN7PAVzq5g=;
        b=ZHr12aO+1wnQUo2EZVIBv9EW8ocsK+Au3G2xIQytC0dJAIp0ElUvL1pL/9CVkSE5PE
         YLttKhVrGGXFHboBJ8TBAx735zY7TBN0a+pgQ0UiLDPuQNhWx7aCqsG1gdTQzE6/FbG4
         11cs3MD8jQUxkg57HDpT+uuL/JoCgCZPFrsjE8baxE2T8UVx8KIJ3p+UXFM65DqKtXsN
         mviCZ4+O/Fhj3l1/2EjLU8pUIXOu5+MuXRHaQNgAH6Qx948l01XCMlTb4na6GbiQyRBU
         YFJK3TrgT3qcY323Gf9m3o+UyAiDrJ7c+0TBGYLzht1hVU2Rn/MhShPM4rWAtFVVo3jo
         47yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV/BGOBZIPaScfHaVBhgYgNdqneIwBCMVhSS98UlaUvrlzrKssj/BrqYgZ1EEKNNxWrJOXWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiu70ckCGsTKMH1+wOqK84G5T+VqrHIOW12pR+7DoucnbyYs7C
	7TdEIldARuyejuxqmLddY2zINXsQ33et9qpz6uACcwsAR+9FBPsgPhCI5+9juq+uWSbypBoD297
	7TR7k
X-Gm-Gg: ASbGncsF9u/EUBY+12nKY2YbpV6WOX30ZJpPJep2MiWGoggfT89iqT1DPoo+nETjaQT
	fNqZ8bNowP5jIcPmVrfOGbQFUN5oheVuMliEZxCNlb09v6lA9m+dLKqKch+RdFqaDTgVyul6MpP
	0I3pxpZCc0fR/OIv5l0hF73gQAL7XbViB9yDgU1wtD+7Eq7gLi6umwbxxu+oA2BIL1I4k1KLsic
	rIJTIWTaCnVmB7NXdcTYV551ONzto6WFqfkMg8EEhDVs1u6Zp0Tqoaz2uVSI5zVK8DFUQghuzpF
	lrk5qBDCqkRDaKvASlSNh9O2thJsCigKfs90z98FmrjxZdgHJasFMsi4a33bIP35lwn4drxCsW0
	31j/uiq92TERCiu5YCBFiuwDgXqp9wm62ybSTuv6r9WPsZO/lIspQw2KRtKlIGPXrOWKHEWC+3E
	DkDOsx4QmTgg==
X-Google-Smtp-Source: AGHT+IGuTJRYgWqacSXXn6XcUEJLhMpbc/YveMsA+Ug+55aI7fdn+aKca4zDurA/rHsyI89cU8Xc2Q==
X-Received: by 2002:a05:620a:a203:b0:800:e534:ea6c with SMTP id af79cd13be357-82400c2387dmr111951885a.77.1757627995947;
        Thu, 11 Sep 2025 14:59:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c8bb8fb5sm166246585a.12.2025.09.11.14.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:59:55 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:59:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import
 script
Message-ID: <20250911145952.4b9db523@hermes.local>
In-Reply-To: <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
	<20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 15:21:42 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add a script to automate importing Linux UAPI headers from kernel source.
> The script handles dependency resolution and creates a commit with proper
> attribution, similar to the ethtool project approach.
> 
> Usage:
>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I will continue to use my script which works off of headers processed
by "make headers_install"




