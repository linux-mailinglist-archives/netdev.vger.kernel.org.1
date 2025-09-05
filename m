Return-Path: <netdev+bounces-220297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA53B45558
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FD5A0CCF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50C3148C4;
	Fri,  5 Sep 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkW6ldm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B430DED3;
	Fri,  5 Sep 2025 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069642; cv=none; b=Hbzp4n2YTVkd1U9pxGMdKBbLx46SOEuThXtiUKyXu2v1efncn0pq3qR1yps3lCjS3PQiQdNT0b7HChUcIxV9rD4Vjxi4/SQag790tZTFR8FiJv7OYJ+NnRM93WT8Fr64DttekCiubcG7ToEIHrJE62a5dXv8dnZUBoIzCqUWrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069642; c=relaxed/simple;
	bh=qe6k7HrKevPOy+Fuc/eg6BRsGGYgcRijxn+OCI6UvLg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fCqyXqQj3okc9/s7EKyLncyBzkjE0qqeTnggLtlv8FJq79Zn/ssDDkv9LOn48kt4iWciYAKMgeC18qLaDBCubznEq1tK0jLDkii3XFaTeNc7m7YpzcVJ8RCp2t6BvZD1BXYElhdej5RFzKWXlD3dwdtseRo3XU2+HWclBKrgQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkW6ldm2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so5114865e9.0;
        Fri, 05 Sep 2025 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069639; x=1757674439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qe6k7HrKevPOy+Fuc/eg6BRsGGYgcRijxn+OCI6UvLg=;
        b=JkW6ldm2V2HbwhNyugyKjZ7NpA9+q55nYj5twR6gIrOW+OihQCXzFpwTG8Whokoe2R
         mSfVY3KnjoGDLHd/ARFmfyZtx8Kt2Oq+VTPoo5OL8PJNu63ADSOA5mAkY8wKx+eWZVYM
         K+cbdZQm1o7wRJ7FHuBxWS0mqwCwLY9UvcIrAjqTiFkcv24WPnN8VXzSp8p51sbrOd2X
         ZlXlNaxDUCCMmcK5Q3r+1qVBEnbg7L8MSLIzFHQ95pTr0WVgY3DqdW0mKeGs9uiy282N
         hB92tBwVdsp5ks3TAA4Tr5mvw8BQ9Za8DW8e3q7jPAnTnIZoqrQCYOkaRxfeeL9+FEj/
         cMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069639; x=1757674439;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qe6k7HrKevPOy+Fuc/eg6BRsGGYgcRijxn+OCI6UvLg=;
        b=DOAE97rUs9b0X2yzN+ys3qAqoR3GdVH2zITqy2ZcqvqCdXMpL6NQzIsMGyh2pNQwXQ
         Ss0gak5Qf6Q0dBrcez1hl2SvmGYeh9B+53T0VZY+VMg6IJSc5Fb0NOl6H9Rx1iX1gBpy
         Kzu3wwEn5YtZ48OVZ0QHZCDtbVgs+jX7PPc6MoqSesR/+eA+aVb08HuMbI+oApGd3IQB
         0HnVFV+EsPP8DCAzMsnfoEzqy6OXZA05mgtMA4xKijojy4VBYDwwAIvmNixQzrttWoPQ
         kEP/t+AItfC7js26o4B4qT8s5s9ztaOrtOAZJYBkWCIJcYQhBgi2YwIIlsggAis/841X
         0cpA==
X-Forwarded-Encrypted: i=1; AJvYcCX7XoVQnsmiY6x+Yjk//NE08N+G4G3dsYu8Nc4Pd7w9s4sYAvGes6K26s/QXFAZYIR2ubS2aAJdklFMaNQ=@vger.kernel.org, AJvYcCXSPXnbezrNyC1rcygT/ig6gMcd6XbapP29K3Rx10BfO0cpGCWTAaeG5b8qXZwNIO11pufHA/l4@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6tAhkGBInPBtMFYre8YBKXB5Xhbj1xjVsMJYQrEs633w2GjT
	8Ag8YQuCaYsgVKS9iG6bzYpnmE3Y9LeeShV0hdKx2NqjruWmepd3KEBm3MFoTjxM
X-Gm-Gg: ASbGncvvku5YbYhn68JgnF52O2rZEB3+j98KwG9805n0fwexhbcBBBvWXSfrnEUo3gO
	mdYUPHOGdl4JMLbaWBp0zPYN40VqF8PoLCKKynbt2MARQS1fSg/TQ/uOE6VjALCjZtEp32cLB5U
	KJ7hyxr1vwJdHQl7QOgmiqNxFO1RR8kK5HWdKD2YAaskkC9sojBF5nPbC9FdwG3PeghtMG1DPMY
	ASFQajquTnu9X0Wlpko0mtjAcVl5fsGMn35czDiVF/J0ug7Z3ipXYUYJiE/BfC8e7Cv4726siyY
	vFwmxUZs9o5wQNWNLsdJEXYMYTT2y59ARufyYf3CUDu5cEf5PmN4+Y+O75h+PaSE7W/VqkE+kw4
	MoniRNy8H4IxSjJjm5wVNilaapVynHYqGLdtKWu9E4neFjQ==
X-Google-Smtp-Source: AGHT+IFwZemLia3fBC9WTFtYFzzmZ2EYNkHjIJg3nuIvaX8gzaby28MJzWDoGnTtZqxxFj9K0r8Bmg==
X-Received: by 2002:a05:600c:4695:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-45dd5b3c3bfmr25763005e9.8.1757069638998;
        Fri, 05 Sep 2025 03:53:58 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d1007c0dc8sm29503005f8f.53.2025.09.05.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:53:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/11] tools: ynl-gen: add sub-type check
In-Reply-To: <20250904220156.1006541-3-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:37:37 +0100
Message-ID: <m27bydyyku.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-3-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Add a check to verify that the sub-type is "nest", and throw an
> exception if no policy could be generated, as a guard to prevent
> against generating a bad policy.
>
> This is a trivial patch with no behavioural changes intended.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

