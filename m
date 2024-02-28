Return-Path: <netdev+bounces-75696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297F86AEF0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D731F2231B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E33BBE3;
	Wed, 28 Feb 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QHS61vcU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B83BBC6
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122607; cv=none; b=MHznvWvvZUBk8ikij+5vFo7vkjT4UZeNNyEmi3Uq7GiFxeEArfD/6HH2K023dcxu6FMMO8JtcxZuZz9SPoC5FN5qZ4bNtaT4dXYHyOlTF34T/U+49d4TBu3XawXFRHNnzVnLbXnYMB8DC4BEhJW5NNuW5EatWXkoeUnnlatsBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122607; c=relaxed/simple;
	bh=ldvpcSU35Jz8322hCmCPRQeBN5Om3WvOv278ShMhodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3iLNRgPzEGzBJIodOOPXQtqdkqtU8Wily/482kdPhqMuabMGSCUj71eWZmobGBjHTg6rfo+5qmahSvtbD45nTvzFLcGKahFD2XoUqgCz6lY65GV7xl4EOnP5MrtNa1fnmxak9nzwzPzfB++82kQs1PLsloa+jpiM3F9pWc30ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QHS61vcU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26fa294e56so905309366b.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709122602; x=1709727402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=QHS61vcUkC8hfyvP6v0Sq/ZIz2ET0IuZgWvTZ2rSB/iahiViBGhYrfYudweAek6+vw
         QWdsvTka4JKvlLQZZzok2mIApKElamkpZdtOJbkTcZNyptJl0SFejMtOCmiHvCAPab9/
         AcW1EIP7F1Hrj5Cces/gs0JykGXoqP1Mnw7wihye/b9wUOhVtFmh8UK2TcKsDVcI9L9A
         VmeWW3WdVixDqZ2LBUFqkRp16AGvECtm9I8Mppg+l+KEz9YsIsw5Exbq1GeCAsuq0gGc
         DLBdxqqTar5wYjzo+9jTFpzY0ZwbhQ19gd+aEIDTvlHHTiZCaeM8Z+Wk5vxghuwd8bgQ
         E+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122602; x=1709727402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=C0cQ4rKQybAdFUceMJlEpPDwpOJoi7YoipPmZhBSx1pgjsQO6j0RrEIxrH6mX9JESb
         tvbhvVAfP2dZpG66L6BySpcs5uJINUgmvC+QyYMnUvJ7BqZ5GtN/mGc7S+hmN3UdyVTt
         aMbVpCUNxRWJPrG66cTJGW10WfqR+8s9BGSYQiR6Y/eGcTvqqcthnx/0z5YoS1raiE1j
         fVapyXhFhj+OrI23NRix1s6Mq3qYcxAtcWcadfPJzw3G8HhvTAn0d7Bf4+bQIpPEiKWX
         4lxGrfyKNhv7qd6xejAQdCTRc1rMu42Pdk3/aQ99vYJRIDF+Aw1j34sHe6Axl2agAooF
         oQTw==
X-Forwarded-Encrypted: i=1; AJvYcCWGRzsaQMmSno/KDo/1DeS7XlGXHiT/Gf23YpuRyT77nUwURcAbySPzRKZqEM2bodLRlYd5u0+EDYMhv87UHhlxgZdD5PdQ
X-Gm-Message-State: AOJu0YxOvqb6epzBgArVwFqdiPSxJXP7r9kjg1jHVDTWacRNtGumRkI/
	2BYTF1QOjVP3AAfpmTwcTwAbc4ytaNs8UgmhV1Mls1kv9r6qdDtzaEBn8xWG0x0=
X-Google-Smtp-Source: AGHT+IFe1CsGF2APUDiVY14PUctNwIaAU5Ml4MK3iHilwHYud1qRv7qvb0fStxtDtgtYfeA8cfHqyw==
X-Received: by 2002:a17:906:796:b0:a3f:5c5c:33ac with SMTP id l22-20020a170906079600b00a3f5c5c33acmr9860351ejc.62.1709122601794;
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906374e00b00a431488d8efsm1773598ejc.160.2024.02.28.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Date: Wed, 28 Feb 2024 13:16:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8kJgaOdJwe6BzC@nanopsycho>
References: <20240228082416.416882-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228082416.416882-1-pvkumar5749404@gmail.com>

Wed, Feb 28, 2024 at 09:24:16AM CET, pvkumar5749404@gmail.com wrote:
>Changes :
>	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
>	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
>
>Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

