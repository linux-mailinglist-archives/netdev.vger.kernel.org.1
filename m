Return-Path: <netdev+bounces-222564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A613AB54D4E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D831897A6E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A4329F16;
	Fri, 12 Sep 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCDjMeL9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B684309DB5
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678938; cv=none; b=EEt6SF5zOmlnDCkhYBNTG3YAK8pP6L99mXe3Pr+XaKSpVLXpjG6Y5o31IdCZNARgXGCFH6xf94i5Hc/fclcoZTJxwQ9aPQAddd87cEA4FrAqyn19Q5gAwbV9NYoHRivHM8ZNO7GxiMgD+HUF9thbNI9s9OINqS4ASfCsiuOduoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678938; c=relaxed/simple;
	bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=J/gqtqKldVaGTm/rTuqyGtlnK6B+qhdD2420VMwEeqqB3PJpgM2hK33tpFcitYF7IlfKYisHUsdc9+KxXTqFN0SkeO98pxfFWyWtLQUhWClLH2lsc18+wGrfFwuTVXiFqCsKr5RE/3ZBro542J6GpX2FEnRkgDKRdZZekGb+ZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCDjMeL9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so852874f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678934; x=1758283734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
        b=RCDjMeL9i8K1JbbO2eI/BdU5hA2tdYuXIlaaxoOspmTMWYZnJa7t+8jcLYJZVCP3Sk
         3WLtjih0uq1RbNCV42meTejOoR5e2F0s2cREUK63BadUSiCQgrKF0uI207d0e9hZPBmv
         82JdHECXqdAXSVkdl0eF7xhW52irQwXJ1JH8Ravin82p1DnnIJ11EGL3Cm7y9D3VjcTX
         zacxVL8HZtnX7TevBCv8eA8W95BSJwfCDwmUZQ9ZYgfSP54r2p2pDxc3PHuSr/7OtRrC
         fLjR4XL46dUsCr+2L/jh4laGAft7PfPEhcMqBL6Vsra+3+wAlY23QIO1Xoc1AbAzYznz
         XqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678934; x=1758283734;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2XBnZVyAQMrhhSI/DaBzgxF6FwG3l7nrVJBzdS3kY0=;
        b=PkAbTxZO+4xVbtbmxO6SsBZhiA8Rw15rrVUnVf0P8qiUYV/PMtU3rnZGYgD5tbyrik
         uZ1+sehmiKDmOcjdluaYzeSVyCyxTGvPqGbX9sFDvQQqtKWzGazPBhDd/h8fMVC4bRJa
         fxPI3HoilA6U4oLG/tgVGFO5tcK+uAlfJGQUrcvVFmfChMsGzA+jmbRUsi4r2PYDMicY
         EiRB8Uuib78VhQfNjtVyByMGPAALQwAwaqrKRg3NN26Tmv87HU3cggTo15UnUDubyUW5
         4OVSdM2AycA9PxMcBM5j6rEM+I1++6AXyioanXRQ0ntL8yaRmHP/OuTldC4zoXRb/arU
         mN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV9yy1dYzdQe+2iCfToBw4c6d/z8PTFsdUetYwPLPcbkkV+1LiZYOG3/Dm0zUsLUpqYG1vkYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHtQKRrSo8TFKMp/wNjfXzXZjdXeig+cnQMvABs4VWjhWcdfo
	yXsgAHWBWOokMjLo11AnpV8+7XJHPJIgK2oq28hJ+LXnfiN/bGQiz0KQ
X-Gm-Gg: ASbGncsQy7iHvdZfa8SJq3h6Pm04zc/qWgmqM1wra+1bI2ycxB6KjBX6GVw/iJJK2EM
	ML8JWb7sDSM8z1jNNAj+dfLq68/7umRV31tS1BChFdt07qeOQ/R9WA9+AyJbxQEYTnOFaLYLSNB
	01TkiVfKT/imq5eNZgOAO8ESq7CHlDcFmn2x2OFFndlGdBN8e1pKUXRyxwMT3BOhByekWOvXOQE
	DnUosnlfEQwhfADhUFaLafW4YA+3+ctKlDNGLakrnq6lChkzfh/f3WK2IRZ0H5lNSZUFvtj1vgV
	qnh3JcBeZAfv+kSMWQvn1hgM/OXc7nC2Rguf+hxbMZeqgdXJ6Raqal6eIhTjdZFkOInDCGnq12w
	+SXr4ifKrQL3ISr26elbKhVOfxVwgTATUwQ==
X-Google-Smtp-Source: AGHT+IFHvsX4+WM6Fj66Yc3KV7zMbPnHeT1OHPDmR/usCdny9EBxn21UZKnW27EJ5m4ay8CYAoEFMg==
X-Received: by 2002:a05:6000:18a6:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3e765594133mr2411503f8f.3.1757678933645;
        Fri, 12 Sep 2025 05:08:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157d68esm32967665e9.6.2025.09.12.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/13] tools: ynl-gen: rename TypeArrayNest
 to TypeIndexedArray
In-Reply-To: <20250911200508.79341-10-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:00:54 +0100
Message-ID: <m2wm63ubgp.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-10-ast@fiberby.net>
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

> Since TypeArrayNest can now be used with many other sub-types
> than nest, then rename it to TypeIndexedArray, to reduce
> confusion.
>
> This patch continues the rename, that was started in commit
> aa6485d813ad ("ynl: rename array-nest to indexed-array"),
> when the YNL type was renamed.
>
> In order to get rid of all references to the old naming,
> within ynl, then renaming some variables in _multi_parse().
>
> This is a trivial patch with no behavioural changes intended.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

