Return-Path: <netdev+bounces-246993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB115CF3427
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DFF302780F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9495330B07;
	Mon,  5 Jan 2026 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX38Z7ZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2333066B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612451; cv=none; b=utvn6wylc/fh8ET7m0aAUJn1p9wfSaqo9dVpIKkqN7SN5OC0UuM2ZO+pdxEfjfv4krV/OVlP7gsMfpCmyxsXv6wAFHIrqPUavMeOaWd+XpCWmbVvdWpVdGkQIE8vMv+ZiLTTBeQc5A3wxj0Q6JVwhAbv6Z/4DRAbJRkx/VijAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612451; c=relaxed/simple;
	bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QLq5g7xkREnSr377YFU8YHI6JQWH7vDcKEglek8qKPlCFi+6mflRLh+beCFtCGW24wt6cCytM470jrOTzU06kb3WrLZ/K1anZoYklmeZV6GpoSabrVfKl+Wc8VabXZBJJjzIQYLlmea7Wl52IR0aSAJ7rZykSuhHxfY0Q9LnIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX38Z7ZH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so151314195e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612445; x=1768217245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=JX38Z7ZH/NnTL71H7a8zo7MKz5e0acojk+lgeO8jolJfy6Yb+ctLFLSyGefgbfaKGO
         +srkdhB6qcW8kLgn2gn79nDuwgSCEfmwUc9LH8szf2kRF4aC2E6CWPr+5Q/JUUMZoJoy
         vCFUxzRWlSj/kl1bKFKO8qC6IPWXjEDf4+hn9KrpxRRxMiUhZrl8CQOZq+q3kSpksB27
         2TtpT5dtBm+TaBLX+FgdeVQlG7fflxA4pLa9WpbDvWXOLK2e2PCkYPfJHSE2qNw5Dl+f
         t0/RdGh5wKolWy35CavLNHBgzb4UEgTmVq7x9QmGRb2wYIwt8sBsVOUCwnS/jse2aAtS
         JuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612445; x=1768217245;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=H8yGAZExomKa1IIYfv1uKB+EuNHfO/BsLzSt01RTPx3QbyN0SjTyejHJ2T2y9CHLsy
         tWvS6VyCOULHNKeqSvU+xT6wKbnfBhz3abyPks0nmw7RE1jhrA97IGgbU/pPeYC0/vlo
         RgOLO8emWXYb+7ufXswB4zipbH1h3jrj2RJw8Cbg5QJr7wneCuRfRUbCj965uSSUeKXF
         BZ7v7Wx7OkW0ft+gf3dUWjbH3o2Ed/v/OPQ8jqq8oLgC+WPKJhNu3qTJdHgYDZ5YgdUt
         9loCL7d9k7kh6kB5WDvc9CLFxriIouuDuh9kDeWI3+XbyHagl1A/pKrBe4y4KZyRpm7S
         Xsxw==
X-Forwarded-Encrypted: i=1; AJvYcCUe0KT3MvxN4Nbdd4n5tcSJf5Ef3WK8PtJDoEBLRIDZxpPIzq10m98nJxzkuGs/yI/7rBOT2m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdb98AcDc+ZBgMTiPaJ/HnvigyZUIRCxpQpONv1E1gNxzFJH4m
	vpkgDiQ+b5IovHMEhMnU8l6AQ55DEO9YhP5x+IKz8ZTzmvjcqIJ/Sagr
X-Gm-Gg: AY/fxX4Pe3YUSQFqfpaL+9g5EhGno2ph02OqMlMRNIAWNAw4QMGjxg5ktzeC3Vs5l4k
	QRdT0OzhCCtTcTFp5qrM64RDwr0buEwjAOmshiE6TNINmASVleRNh6d9VKzi54aFJv2/g+0Hf77
	6BBXfpJDkKHAtO/0kxO+uv8TtF2icfJR3/skFOeMMjguuef6O0DQMp3gEN3dkm2FbDfoosWJahR
	LhkGXoRmus4olEp8uGEA78HCGissUMSwYW9UHMATUE+khEsYvTcomYlDHAElNlvojGmTxMXIoYH
	G/4/LR7gD8DsfEtHX2zq/eNfTqjBujgis/8YKn9RytEZYiIuVgnTXAV+Zx2hNlyMbSGWQfzgDBY
	LqwH/2yf9lY6ilpXMlMHymgjIygtWMjDCcP1em+5KbxWc/PdqPOQzK4t170YAE5qvIfPMFXph/7
	4JqUFk6YLxiZGA930A/xMZ5XY=
X-Google-Smtp-Source: AGHT+IGOCrgB98HD0HT6c/uYvFFDqNubQBnKHB+ahKF1w3E0yy3UKIW2NECF/jANW1a6fJaReu1d9w==
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d19549f5dmr616467065e9.10.1767612444714;
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm89865134f8f.16.2026.01.05.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 3/4] PM: EM: Change cpus' type from string to
 u64 array in the EM YNL spec
In-Reply-To: <20251225040104.982704-4-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:37 +0000
Message-ID: <m27btwi9x2.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-4-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> Previously, the cpus attribute was a string format which was a "%*pb"
> stringification of a bitmap. That is not very consumable for a UAPI,
> so let=E2=80=99s change it to an u64 array of CPU ids.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

