Return-Path: <netdev+bounces-188502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F456AAD1C6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B342503E31
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37342747F;
	Wed,  7 May 2025 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN0MLvNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778F4B1E74;
	Wed,  7 May 2025 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576103; cv=none; b=OkShyc/XT48LFHnk+Uju4+ysxTc/pBE+CuEs7FXGVG3yQudVbv9JEGHHrESh2eMwda58ETrVd7vYgH/6v8E9CFKtuhP2SLFmqXEmoyuIZ7co6Evh21HDE4xnUwrjbWdFaBTzwwbFHz6pk5vQBEwGZO5lFtyFdfAAGje4f9PvPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576103; c=relaxed/simple;
	bh=gWqh/3eR0Rjlj8qYWl6zZx1DublCF+mdPydqJDW86MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXBTXwjRILUCH9Dbws7DDbtpEa92ewcj8q2eJfp3R48LUyUKqKqlnnHo/Qiv2iEM7KIFcev3A0Qp9rZMz2defPvGfwip4KhCpuhYvUEKfrQ5p0lmmsnfFYcVahCB6DuauEYPOdgAxwl/yDd3QMShQDryrz9yuIyLG9D7n5CDewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN0MLvNn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769bbc21b0so77249991cf.2;
        Tue, 06 May 2025 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746576100; x=1747180900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50DIT5+hNwT/Ht34c4tLDN9hBXSig91HYoFKkiJZ53o=;
        b=EN0MLvNnup7FRYRTAjE7BUPqIALfe2g0zCeofX+GdjgHzSQqKvtKlATEDQrYWmst2n
         SL/UV//n9k8SvDr6CijdSnWsoheMbkI5uMKMiMNCZFVIE7JPu7rhwa1QQuRgzmGIsGbL
         wvsD27gIwNWUcB7k+RSwXQ2Ya2iCE+1LQAFu6EvSQbDdVtkOEyfAHZnMb+QxHBiFKC6a
         VUIglTiukZPjKltfhb3b6WNIXI1CL6e+efOlhB4piOZSWMX34+ZZF601fd/zIZRIBhVN
         By3HhoKINRNDyrjXmIOyi1lnZIbDQHnvuEhkUuB3JDWOH8FeJ6wXLFoLmJ3XsXwxn3g6
         ofFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576100; x=1747180900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50DIT5+hNwT/Ht34c4tLDN9hBXSig91HYoFKkiJZ53o=;
        b=qgoFT4R0/gbAqVgIBbk1HfLcWabOMTIob3cibZQrTMqDTYXx7/BdP7QJpll5owfSdi
         TeE8tO3fzNWTsmJ6Zvcb98YgsUqNUqHnUhgJIjG5r3/c0pQrNsDiPKVgGk/VigoSMCzH
         MOxkYiHmxDQg1vAhIgSoov87FPDKJTfxA0PRRQOuqQMpm2cpQZchXaffSxp0T3xXVLm9
         Foi3OJOdvCUV9JIueOEuAWaMqdTJ/+BEOM8USZsXwRrt0PzeAAIIx9Nywj6Fpy5JwBpE
         XC35DXr1m0zgrgq3QGidX7qZpf1qPV9G9bH+3SDXfh3MfBi+Nxfal9OUaKpGoe/pw7WV
         OeAA==
X-Forwarded-Encrypted: i=1; AJvYcCU1A5hqgRKUs0a1oImKJQyESWu4LQstRsJ1Z3dfutu8BbNovaUJcJFdPtvCeJIDYdHDt3aslEDI8NxRBTvo@vger.kernel.org, AJvYcCWN8APO8GOfnj5LykHbtye0xQQa80NH8wOOc4+fjyjJwHl80P9HuO1WsB5wXm6fZBbWSS2nWgZf@vger.kernel.org, AJvYcCX4pkOmM1keyA9tcWzXbxQtxYOP6CDu37lVbqSFOc3fhyopkdg9VS+mvqFytGi44k0V3SLRkSltIG6K@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrVnOYorb0ssNYcL1ER7l0jkVz78WpOJVU8Hf+mvjtngi6xE4
	4ERmCx0vOumejtOwX1eC/6tYbP/7WfYSTf6ktgQqg/OQ194g+Phc
X-Gm-Gg: ASbGncuC7fPnyFkiB/9wI3Q0Z3X1nDgQC6SFyt+ml06s1y/vnXtqPmFZNV/hpY4/KRJ
	iDAgdOHzJo79fVsTkp9q8rCjNrtYjkBOCN1MiRIj/0ajdbCvelgzYUfpUYYiTews6FDFGF3+vP1
	dfZIeKOkpAqdNs6lK17Kqvz88SIpqhvRLnpWMV3w9nAr4Q3634j+u2qmfOSBzOcsa3DZAu0loUD
	sm7C4D+l9AvaujogU3af+lHlwmJg3kR5JDgiHia+gN9c4aW/6Uko7wD/jptUJ0tOwSV60+IiWlE
	7bAMxEx4865y1Tsg
X-Google-Smtp-Source: AGHT+IF5dVIBqWmzWpTLbIydXWtnN76qIrVDzEiJt6opxAhjmE5bMg0jxsUxOxC5DB8owt6CtfkUJg==
X-Received: by 2002:ac8:5889:0:b0:477:1edc:2367 with SMTP id d75a77b69052e-4922795df0fmr21138941cf.37.1746576100154;
        Tue, 06 May 2025 17:01:40 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49221843474sm4647191cf.48.2025.05.06.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:01:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] clk: sophgo: add SG2044 clock controller support
Date: Wed,  7 May 2025 08:01:11 +0800
Message-ID: <174657601728.224270.14258815179551738984.b4-ty@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>
References: <20250418020325.421257-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Apr 2025 10:03:19 +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v4:
> 1. patch 1,3: Applied Krzysztof's tag.
> 2. patch 1: fix header path in description.
> 3. patch 4: drop duplicated module alias.
> 4. patch 5: make sg2044_clk_desc_data const.
> 
> [...]

Applied to sophgo-clk-for-6.16-rc1, thanks!

[5/5] clk: sophgo: Add clock controller support for SG2044 SoC
      https://github.com/sophgo/linux/commit/41b08610dd262dc4a5e1eff993b2d21eab8b8ba3

Thanks,
Inochi


