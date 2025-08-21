Return-Path: <netdev+bounces-215615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36250B2F8FC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2D175B8F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F3311C18;
	Thu, 21 Aug 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL/rqBGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7B315779;
	Thu, 21 Aug 2025 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780647; cv=none; b=IUwMhjf7FAchHgjxRKqRqsol4lDPeSHOaBAAeQfxHqTfKnE+HHqLtM/Ok/rM+v/6ZqOafmRQ+WO20cpYGtGbjyTnbLaLgcI5T6CSUKnIKf56MJy8rJEt1qkjfBP7lo3eLsE5SwpSsBNd2+Jur8TO5MLFnHzEd18v4S7hd06c+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780647; c=relaxed/simple;
	bh=iM45yIansOQAMUNjn0bUabduD2UfVw8nzX3XVGOkjdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7DSTraoQUuVirI8smNP//BdJD11nDWgJjvDEnfVGXruSciiA8bu30rTvMK4L92onEt6MSfqZ5T+WeQEumQF3lenriixmW39JLgBQOS5kOCHd5a7F/lOhEK/HUpN9U7Vek87KX4GYVYQOSEmExVEb6Zak74LIKXSPC8bzZGRyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL/rqBGn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70d93f5799bso1277256d6.1;
        Thu, 21 Aug 2025 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780644; x=1756385444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxU/c9QtdpeT6vjzYdNg7d6fasiYd8WLob216PwFuUw=;
        b=mL/rqBGnzkdE0Ia05RypHfyf1L7lh7afPiYX4WcTIoBO4AQpAXrUwux/ixovPXREsW
         hWmT2ZWgvGAm946wD8iV7/ZJod3dwoQIEepx7hpBybNc2yKy7znul7LoVTOqbpDqznUU
         N1pJ/m7g2z4p3Wij4vD9KUzKrXmTfAQM1QJI8ZOZJwe5tf0muC7Giix7UpbbyWNChMY3
         E6AxerAcGUQHOvTprwX9FhgrGLk++7EHGndZi93uWXGhCOQgndNF+N6bSwlEdyfPL3nn
         fZtHI93pfK3PuIljWRJ85+fMO9y1+IJD4J3OorGAyAoAyYG2AnHQz2a47fGXRyNvrtmo
         oLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780644; x=1756385444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxU/c9QtdpeT6vjzYdNg7d6fasiYd8WLob216PwFuUw=;
        b=l2gvq9dr4Jh5XlpVaWd+gxrbR4SSpHrBifG2YQFAmMozfZrNKGH3JgCDNm/UVkXAeV
         IVfdpQPR2kshhkq2zjWZdqqe6fYPJlq2AONtAo2rGr+Abn4dOOlWSyi7eA4asT+0f0WH
         PkfqDfLL0esq831Ln/kD8KELJ2daQnQDx7aEtJzCDa1SqaRXuTreftx/jLx8JT3/49c6
         G4YMgDrF+rz2G4eugtgGSzCFSVOxbHs9ZpyUhKuKbKYjwL1Dtv50ekTZBkdeV2QRmtMF
         qf16tIsqRZTwW8NnfE53MRqg5kasT6PKyDNynBUcEdEkFqMmmg6pV0hpO1YfGH82Y/Ij
         dGeg==
X-Forwarded-Encrypted: i=1; AJvYcCU1jnCqTEZ1yxEL8OiqpEA317SDceuw1SU9F9mjNNSQjKPRx0E8bxboFgiqGdChl9QK+MN3QvtA@vger.kernel.org, AJvYcCVndG9akLohI1OQKO+PojnnAxUmwf9OzrofWs6eA3UFFYDzicihFxmWrPO80rP0zYlYC9MN911XVAXY@vger.kernel.org, AJvYcCWhdh4ER1O3BRmJSBPrrjX36DRnQRrGH1e2vXWtcs5No332Qt2V4iXSAuh73h0W02C1rC4dO7PwnEvJCgGX@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+waUTRaJvfvuNQkeBI6fZRW2am0RdJR4PDBCqQheDqshDFUk
	7QaJ8+1aEBy1BgL3STG+fOYXLD4TzWIiM/+QpHCjWX/RNX//6CZueyiI
X-Gm-Gg: ASbGncswlB61M73r0GQkE+a4yp7E3s0/fFzf2b8utF7PrWBL6z0sTjXDne4jocpm2xr
	JIKILc7zj5dhd7JHmHskLBqP8PmynMAWj7gVRJs1msadS5TMMxWzgGlcBMUqVRvrf4mJjPpVRAG
	r6N5yIqM5NJYn0cnhf5xLKEl7C+8ZLOSU0G4mWvH0AbY4mF+Lb6th69Jj8kwGB9iSkAwViJZoD6
	jaIsc+BqOaUzAIqjWTswRLsJjlM4fkX1NUMDhdU15q/+rTPa4Rb+rUOS3qgaeU3etGArYVEX7jh
	y3U+9oeZYRYaCVJ2Chva4L02YHhzNB1cv5lLo/AGFceZncPwNrri/fCJrJMBRi55gRQCpF58br/
	vGkjAhGsuvg3YkjdndFk1AhbdL/Zto0AVXx6eRkULyQmhKxvNG5RSglNTCQ==
X-Google-Smtp-Source: AGHT+IGbZanLkhWctvc/z0MtnIxZdEvoJJZIiEwfGt+Ut7mMdNAmEieP2/DGUu6J7Q5lwzwUveSegg==
X-Received: by 2002:a05:6214:478e:b0:70d:9527:e45a with SMTP id 6a1803df08f44-70d9527e62emr1519806d6.16.1755780644519;
        Thu, 21 Aug 2025 05:50:44 -0700 (PDT)
Received: from glsmbp.wifi.local.cmu.edu (cmu-device2.nat.cmu.net. [128.2.149.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70d905e19a9sm5318436d6.19.2025.08.21.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:50:43 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:50:41 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: net: Drop vim style annotation
Message-ID: <aKcWIZ2zMKuOeW6M@glsmbp.wifi.local.cmu.edu>
References: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
 <20250821083038.46274-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821083038.46274-4-krzysztof.kozlowski@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, Aug 21, 2025 at 10:30:40AM +0200, Krzysztof Kozlowski wrote:
> Bindings files should not carry markings of editor setup, so drop vim
> style annotation.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

> ---
>  Documentation/devicetree/bindings/net/litex,liteeth.yaml        | 2 --
>  .../devicetree/bindings/net/microchip,sparx5-switch.yaml        | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/litex,liteeth.yaml b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> index bbb71556ec9e..200b198b0d9b 100644
> --- a/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> +++ b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
> @@ -95,5 +95,3 @@ examples:
>          };
>      };
>  ...
> -
> -#  vim: set ts=2 sw=2 sts=2 tw=80 et cc=80 ft=yaml :
> diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> index a73fc5036905..082982c59a55 100644
> --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> @@ -245,4 +245,3 @@ examples:
>      };
>  
>  ...
> -#  vim: set ts=2 sw=2 sts=2 tw=80 et cc=80 ft=yaml :
> -- 
> 2.48.1
> 

