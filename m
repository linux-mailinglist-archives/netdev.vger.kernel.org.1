Return-Path: <netdev+bounces-220296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82EB45556
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380A4585EAF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9830F80F;
	Fri,  5 Sep 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy9w1FB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746582C028F;
	Fri,  5 Sep 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069641; cv=none; b=Arof3vjL6XSqKhDTolr2ZLw85MyOOp4n1hq+tcg0FBVQqiRv8j0VH/mpusTJgxpkL2JsrH+8vbd60IVORrD29+CR5eS9tEfZsA6WTck1zyyqbKmMZANtE1y5sP7D3gbi7R7axgsEgD2/6Z+YB6TNOfsnwhdH3chBsEbmi/k2f2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069641; c=relaxed/simple;
	bh=uxny7a4Kpc0PxVoOzZ5v1bP9RgRIFQsVUH2eLUOmcFM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=czGiGjdl4uWIGHdRu8FJdevhS8msl1cyWG9FtmL2ZuB4lEcY504v+c4g+hDRZfdoFwdhbqxSLHAFqgYT/BhYH0J80sgEhdLIRwRlAmTlH3h12PwDm/m/rK3+BnSG6Z1irlCax/qojAQIhRZGWVlbhG9WHJx0MFYzoyS0YX1WrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy9w1FB/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so7654165e9.3;
        Fri, 05 Sep 2025 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069637; x=1757674437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z41bjByaFM60LnQEd6Oew9k8K6jjJWYfgMsisJ7Td+Y=;
        b=Vy9w1FB/EmAzkhyRp86HljOUPx/1OHt/6aFsvg3IdmGOAmh2cNJBIzWXHw6czhylF+
         jiCqD88IExsg7tkoVE1DFibD8Tz1g0VHWwX2TIDIA2pYbq/RWQH9RY4XDQgnDJDUnPvN
         hFDz00HL/R2enk7ObEwjnxxPQ/itNudcqrrOXzhLFJEU/oIZ4Pf9ALEUrPxJuw2OSN/f
         ZQCckL3oKwgXjjlE3UNKS6jWmWZcGk5hyMoSBpm3gMTu8PK1I7xvHmQ6KzqrA65Kk7BM
         5ry8b3TCZvaRBzXrRiJH8UDqLU76RHNstG1l+fgLRl/LVDvwHiXHjsE5mq0ihtE/ZaDC
         y4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069637; x=1757674437;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z41bjByaFM60LnQEd6Oew9k8K6jjJWYfgMsisJ7Td+Y=;
        b=S6EBYcrmDuJXmz9LfTW1EpHViYZHvqeCqbmT4PbfDakGlZLPsPXSgAzKJu8LJ55vQG
         nRhyZMLAB9Hb4a/5rD9bGm2eWNQtPhiY49IkbHkUSqQJWB2sPdtMPrLGdnjIJ3c9wYKn
         Txajino3AK7CFfGoChFaffLM2ZpmBxpPzuRjSg2vBBcBFNo9MEK7aYpvsJEJ1Mtyu/Yj
         6AcC2p89u16xVvr4J2NJnWKGwBkZmrrZHVmI4rBMR8lIICtrzC4Lyk4OhOw+luPko0nw
         aL4ap5U+IPJkTCzCWUBA5VypoMSoy8WjIUpTMz0jwSC8xi6kO5Q2uNAMcknYrmzOOIIf
         LIZg==
X-Forwarded-Encrypted: i=1; AJvYcCWMfcjbuSwl6VS9grjzIHo/iC4LUqbcyBH0bAV4GqjXgAyshdWucBDkmd3QDfaeWpzFlfsOEwdIe3LJKOI=@vger.kernel.org, AJvYcCWkcBKC6Iv10E8HBl2CpCfVaI4S/gOI9tutGgSqrnv1SrAho0VGfPFrDYu+6EwUBM2EGKUVWjc/@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+rm5k7oZB1vDQfVM43vh/6CY75NyU5aUr7EI47s6wFWLWvwV
	6KqW1AYhbPaAd2NAdad4dYuiwbyBuvw/uMuQjVP//vU8/m0wBbCbMemQPV93qj31
X-Gm-Gg: ASbGncuxS0XPV/FQ5q3G0J0sZsXAJXOiUfio2ODB44EbgEzQrq32QddpqnJs/gEHLW1
	c7rIjuN2/Z1rTX/0L5jAwV12yyNJvcyu+ZPInVGR7vea6KCgGHlEGCyycjwv8JoEdQfcGeI0DJf
	04E7/hPyoGysN2Q/Ip/YheIi0AkMHQU9AW/HNyYVv7ly2ukyr2IZwkADXOxsOC59xIzjVGt2sur
	li7zFCNTGtDB48YbtKL8BsztiX0vLH9xzZpTx4iMs7yTL5bsid4KJu5YV3fvYgU6IRJYKt8p2O6
	VpLmOWV7QlGbopCbcIaCo28oDzBR/BiUMVMpIgYkjZSOFgdkFYeRn4Fz/nTsYE+oBmX4HV22RiM
	Z2Y8XJ03727ZhOSF1C7vtIQS18rfeKKG3CBkbuvANOuyGCg==
X-Google-Smtp-Source: AGHT+IGOY4bwB+izuGnbd5LE84YducDA7sGQmtMlij3Az404K/MZ+AIoA8ONqCveaO1sAzbVbdxh4Q==
X-Received: by 2002:a05:600c:35ca:b0:45c:b5eb:b0bd with SMTP id 5b1f17b1804b1-45cb5ebb156mr92165805e9.8.1757069637272;
        Fri, 05 Sep 2025 03:53:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm51030585e9.17.2025.09.05.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:53:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
In-Reply-To: <20250904220156.1006541-2-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:37:24 +0100
Message-ID: <m2bjnpyyl7.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-2-ast@fiberby.net>
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

> This patch adds support for NLA_POLICY_NESTED_ARRAY() policies.
>
> Example spec (from future wireguard.yaml):
> -
>   name: wgpeer
>   attributes:
>     -
>       name: allowedips
>       type: indexed-array
>       sub-type: nest
>       nested-attributes: wgallowedip
>
> yields NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy).
>
> This doesn't change any currently generated code, as it isn't
> used in any specs currently used for generating code.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

