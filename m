Return-Path: <netdev+bounces-70946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC2D851289
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB911C20A85
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5738DE3;
	Mon, 12 Feb 2024 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZw/WB0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654639860
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738406; cv=none; b=Ja1BSUiewvV0ZGrA1lXuacSKCzn3yynWHVHpGZz0TI3ZIDX0fgpniRYvbSv6styKkrI9eCDbCgj22iEbw7mrHqxBKKUOBYtpMDabn21W9Tls/7qUvqLPiCNUD9iKqNCOuSeZcE1r/7jtKo0FkY+GAFbwZpM2zjKb3zlRbEVbS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738406; c=relaxed/simple;
	bh=YZI0iWYIs4Bh/cvrE2Q1viIQKQR4G93YPr/aYKc/beU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXwDkZ/I4k9gEE4ecI9Birjrou5V9fbG/0BpOo7GPuPvOY2O/MWH2a+eHtTXM+md8Y6KrT3ltsE3clYAtKSrv8JTtXdgDK/TkgvDq+Fu0hOfjMIUmIySkGgFvWeWLB2PRR7yxNoUm+zy1FwVa2gnC4A6LnSDySzxM5OG7fa9KVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZw/WB0/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a38392b9917so386858466b.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707738403; x=1708343203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6igGhHE0Wmh8X+D47XGNFybq2+vq3ZSP8U8DuXuJZOc=;
        b=aZw/WB0/rh0e1jYG5gy0a2HmuzCKO3EK1talVplqzjknYMuL3EdsWRD7Jmk0/ES/Hf
         bL4ygnnT1ujZgSmJzEDOruLqWv1iyXaSKzlLGrkIzk/1S13N0vHCnxx1WPtqPoSt55V4
         VkhXvjKOwp/XA4QEOuP72f3HE25CFp9x3sf2LKkt6/wcXMwHaejLnY3zXD0Uz0faoyvk
         fJBOuUo8Krx6E4pkBVjmtJ5O1yoggZpi7tTWwl6KIfHQ8BEmwHEaRmeycgtNIS4epEYE
         0q/WFexvdi3ZKDDmHkjrPlvBl2wCKv8nPqHVdkDe7K4YwluP4Egi7X4ho+Fw97iMLoW4
         AOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738403; x=1708343203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6igGhHE0Wmh8X+D47XGNFybq2+vq3ZSP8U8DuXuJZOc=;
        b=Y4MVADxgrK3Yy3/2ESh2YPqiBhabTjUl5oTqfBICZNxEosv+0G34TMVFyLI286LVdI
         4peXxNvTCrjzy9IQQPIlUmpHP/YuLJDSvxi2zsM/JXzTz3IhPZGJcXtXPIHbndsnQYsW
         aNLM5XNVkUTcThHHAqNEsOd/VrAsP4tUlb42WLWKk3UY1X5VhGEVePDRCVEdLJ5jCZQq
         E7eOysV7fFLJtlma44akS0zJfUFKlhDUSrniddYWGT1r5Yeps76vw1tbbC3UYfWHO3Fx
         ISbKyr7hCGtUSIoN005dEfI7TscnXjlxGOjdpyEEe2abCK3uhC41U80KXPKiIpXBD/dx
         0U9w==
X-Gm-Message-State: AOJu0YzWOTtWvv8udYpkDuWdSJwRJZViov8YOploNfyPJVRGnJFyVnXd
	HusAMOXWyc60qx2Z3rhZSfwpyXrK2xz8W+lo5nVSY7i/7Xth3ZixF7CETQibcHk=
X-Google-Smtp-Source: AGHT+IHGzo4sHaLedr+44j8i0CpRIflOiERJvsFJv4QUFXqbEUpmTMuFNNAQAEL0ft1qo1x2nqwMSg==
X-Received: by 2002:a17:906:a40b:b0:a3c:31d0:592b with SMTP id l11-20020a170906a40b00b00a3c31d0592bmr4115764ejz.11.1707738403323;
        Mon, 12 Feb 2024 03:46:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1ckIQODXy+qKYxw91D/0Nx4qkO/v4gxJqN9uP1xnHXUoSiusk11lug9xaJyWdt/mqkOPekkvZPBErqzVwRCEJsQjD9+v/HfMqbVrPsCrC/CYN42P9n0KmGWPIdTlJJgSyQxruf7wlq7wj7lEIunhIxHFnW+na1rEmQZc8+iuoAAWByK2G0JDQ2qgbIr42Bp2fzfZaOTAQZYKJMpA/mLZ+yyOAmah5Rix0vzgPhurFy8XIDvV7sHcu0LjmtZcKzOY3oGROSu2m0nn7IvXpnZro1MDfPihpF0088Ov1IvJbnqH+SDpJyAEwO/oPeYp6JRHLPtFLrXDtw/CW2dt4OBv0pnwxJ9fgavqXYmTk2qVEwg0yO6VVlYMcjEUFH1Jykd920n7vIOebWrqfpRAMU+CLW5XX1j7zNC12CMUvUOlyXkNAQD212GVvyZCLkp8NGPENopOgMsvXubTVR18prMUOjts8Fz51kVEQdw4msB7Pcd8gY6kIeX3TSW5gLy+S
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709067f9100b00a3c89e226f7sm123069ejr.181.2024.02.12.03.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:46:42 -0800 (PST)
Message-ID: <2341b472-4a3b-49a2-af5a-9cc94fe977aa@linaro.org>
Date: Mon, 12 Feb 2024 12:46:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] arm64: dts: qcom: qrb2210-rb1: add firmware-name
 qualifier to WiFi node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
 <20240130-wcn3990-firmware-path-v1-3-826b93202964@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130-wcn3990-firmware-path-v1-3-826b93202964@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 17:38, Dmitry Baryshkov wrote:
> Add firmware-name property to the WiFi device tree node to specify
> board-specific lookup directory.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

