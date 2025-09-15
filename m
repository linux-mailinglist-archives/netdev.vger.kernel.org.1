Return-Path: <netdev+bounces-223193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0FEB58366
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5262066A8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69562BDC1B;
	Mon, 15 Sep 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="r6eqYM12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B04284693
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956812; cv=none; b=RYnvHgNMxx2mXaeDIppgMvugiKGgAQPoEuWEigYySMSiec4/yiIVz0ly/89yXJpm+FXvjB1FrVxqD9IBtyENZAxP2Op/SyD1quBh1sPo4d+lj6KSdbemERp6TGqwGxcwbWby+iVLnsAkfcPN3s8FYruNPNxjKbLKjdHH1LwXSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956812; c=relaxed/simple;
	bh=G4znxugC/FowswiBtAMoXMPhg+vbd4ASnDLc+un2i5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVJWIAnHtgHZcCT+tXdW/ptZ56hJaUhd6AcAjb8lZ9nJmHVsbYJWreZlFa2hvkzSQ9j7AJrAhIOzz7dHKYEEbF9t8d/YXrZP+fwK7UkIAGb6gvrcelFN3mHIShDL0WO1vJFWfNlzDY/XpIEPCeW4+N/ngRizYg9MBgwuFywtHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=r6eqYM12; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8275237837fso239630885a.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757956810; x=1758561610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lthPFhmNx7yrv76MFBk85pDuMkP8XIzC0V5pGkohlsc=;
        b=r6eqYM12xZi5MpQykSW9kccY81j7MB442jmlaWKd2EK/S+Nglma15bZ6i9GL73h3iX
         r9/BIYx0adlljWj4RF4dk4YeEcYIH/JF1/FBFNTjQwQWbeVMXCbP1H13h9B5ZmkTV7+R
         4uXu5aBdYMpVjvtrAjhlIvHPqhFQb5tJqwBWsc+JZjP1ZKFk3Z55jYiXsrRIcYUySr/B
         PC1jyWIvbBJ6aSPx6vZMSJ4xEV/jP10/POF0E/I5AM+8nOGb3G5wGX2gqvUWwjBO4gS9
         W4HwDZVKES8g3KtSJa/9ElBHV6d+gSIPMz9ugp2NLGI3Zilp2NjRGvyEWmCSeatceTyi
         h6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956810; x=1758561610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lthPFhmNx7yrv76MFBk85pDuMkP8XIzC0V5pGkohlsc=;
        b=r2/oBeUp69eNcdmJtSu5O+6LJC1sSM6B2IMpXLfNXudefWHn1MnwAH3kcaImBX7X2Y
         i+fxz1NeiAETR6T/arWU1SlvR4/sC5+BGCu2RRugJns2m/m06BKNoYMRoTNorAFPw9Uo
         SdJkWAyjgYWrNEPWEs5DkGCcoAAKyJg/nZ7+LAlXN6EvJ1k0GPijWACouYMNdYEhbSg4
         6BqBguK6bRFwsxyLHhb6IjNfLvYJvr48/sQqQZr8lern9+9aL3DD84pttEQLa4k+1E/F
         h1NIZluDI/cKpVC5AG6hPZIk9BclAD3N+KTAnjwZNxLL4YBpKmQihAyLSL8yQGTwjAKU
         YNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVeLfIRV5UB+fuHgx/OQh2MgDhBwOcPac7KgQKESshUaKSdDGx8s8zmC5KvcZbly1aYg/cMImQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPUgDt3CPfZeydcL0N86ScxnmEbBUbrGLxtstyry6SyHnaZJ8
	pVJ9CmXr5tCZsp/b5mqAtZqsd0A+ltlCBfz7POZeFt7on8sk7qTfip+OHd5HvEmtPI3Ln9JIfa9
	6qRHF
X-Gm-Gg: ASbGncvc27dCKRG3BpLod4oXxFy3RxhvkvTS5WMtQgmnrOdNvsEjxxEtP3Ha6tDGWCc
	Od02BOJ7DVYD3CE3xcA2Y1fFS/KHzRdvwRnO0SPtSy07YinH3LYRAarWBzppGRQlci/pIfKDnZK
	yL2d6hENpggkKMUKkjAyuXpFbjBMoow29n4R5RLWVB9Coa5+8Wanuioqr9qO7ykMHYkK7aURat4
	2sNqtlq/Y3zmKRkztw1Iak8a1RrWkl+23vrJiiLpGNtiEdOgKgpfJIAH7w9LGClsiybU72bDeLx
	fN773XOVNRuEOmTm64hhhPP9j76Q02zheJ0OYwQTe0kXoP2IeIPOI5hQ1FPwuNNI0aiTBRI50ax
	Bn9D1mAJ77FecWxKFnUth/UA0ENVDd74F6yPIEenGyMPT/6tpo2DLOgGli+Ha2qBYY/RR9QlvOT
	o=
X-Google-Smtp-Source: AGHT+IH4CexXUwftFXBN7HvWKj0rW781hhuD7vTKKVResShjoXH5y/ZWh+eoVLE2YO5wPJWyEcOl/w==
X-Received: by 2002:a05:620a:1a89:b0:80c:a9c2:d0c6 with SMTP id af79cd13be357-824013d6fd5mr1553496485a.84.1757956809922;
        Mon, 15 Sep 2025 10:20:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8278dbd0732sm465119085a.48.2025.09.15.10.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:20:09 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:20:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alasdair McWilliam <alasdair@mcwilliam.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] rtnetlink: add needed_{head,tail}room attributes
Message-ID: <20250915102005.2ddf29d7@hermes.local>
In-Reply-To: <e742f9e0-671d-4058-99af-c3e38b73ec0d@iogearbox.net>
References: <20250915163217.368435-1-alasdair@mcwilliam.dev>
	<e742f9e0-671d-4058-99af-c3e38b73ec0d@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 18:49:55 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Hi Alasdair,
> 
> On 9/15/25 6:32 PM, Alasdair McWilliam wrote:
> > Various network interface types make use of needed_{head,tail}room values
> > to efficiently reserve buffer space for additional encapsulation headers,
> > such as VXLAN, Geneve, IPSec, etc. However, it is not currently possible
> > to query these values in a generic way.
> > 
> > Introduce ability to query the needed_{head,tail}room values of a network
> > device via rtnetlink, such that applications that may wish to use these
> > values can do so.
> > 
> > Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>

Why is this info needed in user space?
How would an application use this?
Seems like a hardware specific optimization that should be hidden in driver.

