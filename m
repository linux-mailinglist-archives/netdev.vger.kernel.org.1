Return-Path: <netdev+bounces-222089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCDB53008
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80F5188564E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E74318152;
	Thu, 11 Sep 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+zX5U1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD3313E07
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589657; cv=none; b=OGOaxr30hJtzcOzhojh5mWUgygA3FwqstyLA8AR24O0o1y9/x4bCr4ID/ER7qvi9qr0ZtLpP8tgCSdeiw1pVGCSMNtnbHhkkfZbe7khCDr6NEOEhSkSXgHWKZBY60KdG4oOWtgk3ssNacPGusvgOeJ/WUKHtHQQbXbgdi8NAtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589657; c=relaxed/simple;
	bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=E7E++DecfiFVny1xm+DOmwhqZwMnCKawFXyETamQqTSXlBF7l3N3FUGdUp0FoSqcpiXgWvYFJ3zrkWRPQZ7CrkY+KQbH4/RBgKclWz9YNyFhxaB++kSq5qQykUaGbynai+jJX9MG6vsdvLpkxOHmqEPLznMVY/MCEfN5hNxzL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+zX5U1K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de6490e74so5902065e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757589654; x=1758194454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
        b=K+zX5U1KngGe5lvACq36N3zgKcZflCr4oGrB+gZ5pTqB724h6gz3VPw7pdV4OydC9D
         ThJMSMAea3XLc0S+Hrr02mcltGV7koW9VzzxIrF0gfiWuRUjWx6XvcNY2Yfqp4d960Ka
         Vofe1gnMkKYwNV+NgYzVxw3WIEXfUTG5QuVuG3ARDKbRaExVZJH+lGP08qnX2wrwHxB6
         fbyxEtBNpskotvt97g8Jwh5vUA6gQFDLsXze7vwaKEJLnZ4nGUVtp2i8i0pZWCCuA7t2
         SSEs4niG3s0Rrzddzsk3a7iLAqcz/n9l+8KbfODf9NX6bvDNd7WylP0LHPqL9epP73+P
         k8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589654; x=1758194454;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy8valPOq+5TQChc2jB5gUQh6GVTf0ilWXpF+hPVga0=;
        b=sDSrcBzh9Gn1sNYfiuPe8/BS+JDAvKHQyPdjaoP0vVMpC7H/P00k6LcPNXJZ0yyAfi
         jJ5P8as03qDvlj59J9J6RaFKWDZqQBxLvbRLzQTTbEVFFoWCE/M8H7JhpDVkZQYfCIG1
         Jl3o9yL49C10A1K7NG5J31w8KuOilu9WPiFo6mBBRxtmm3Zv12+8rSx6pUXz9vaZl8KJ
         PL11RPV8f1TARGXcoG4r5lbYNYe/wQROm8V3aKHdtqoIzJfJEXBE1rQnG8KQzI+ssZTb
         +X5NVUd7AypdNUAWY8iHTeZPrFY4taYNFGHk3jjAhbWWJiJSb/YMr6HRRtDrKMamlw9d
         IAhg==
X-Forwarded-Encrypted: i=1; AJvYcCVgSRrueczW0axYyQ/2iSM6Lsz/KcqAy7IyGOTZtS2cwuxmMkaBh3aNA+vbnKI1hwG1pUiIdCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6P/lKkIW60OrHZdn5BoJz9wB3U8HkWahHJo9WfqjwtMNm5tl
	6Bu3ifBbFfAwRLfsOMDoTzVKsR4+r/A0OmMg96w1gLq1EZ6mcrZNzqks
X-Gm-Gg: ASbGncuY/AHSy+qzzMis6D15H9vTWZhYP0qZ50cPeQaaxU9NCxoHwR7v/X3aTiZv4j0
	BgEHIaa4NdqRfTaRi8gitk8FZ08hFYwyqTppvoVRE4p1LwZiAYqr7DC2UMtrsTfc/qRGe5bfWAT
	NRliBIoQ7oM+LNrmp4aXBu5C4/YmvJLKUZfksio3bKcFP+89pwvjOygDbCnaLpgwuoJAOEnw7Dh
	jQppbtiJbXcV4bQS92rDewFRpVIX3VbVWbdHoRkmNFZl3is118l9QqcJ/SeC5rlu0zB5+Es6Uwo
	/vMbnPrY1Fr6eIG3PIjb+9fZAV1CN9wGhfQYJm4L1/MFureVSGFNorV25kawLmwc+bTx4D3pB5a
	i7oLAp6YWrTzQ3t9LAwpGPda/1BMu9XqRmrYKLapBGT4uVOqss7OAGGQNYZCW
X-Google-Smtp-Source: AGHT+IHPRyXDCKOm7qQhOay8cSvONkh1hTjaOIcriGGovjXk8SONeiWwYo/6tBJ9G+d2GC5W46uqTA==
X-Received: by 2002:a05:600c:1390:b0:45d:da7c:b36 with SMTP id 5b1f17b1804b1-45ddded7614mr164680975e9.19.1757589653499;
        Thu, 11 Sep 2025 04:20:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ee8sm20447335e9.18.2025.09.11.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:20:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  Sabrina Dubroca
 <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/12] tools: ynl-gen: add
 CodeWriter.p_lines() helper
In-Reply-To: <20250910230841.384545-6-ast@fiberby.net>
Date: Thu, 11 Sep 2025 11:47:10 +0100
Message-ID: <m2qzwduuz5.fsf@gmail.com>
References: <20250910230841.384545-1-ast@fiberby.net>
	<20250910230841.384545-6-ast@fiberby.net>
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

> Add a helper for writing an array of lines, and convert
> all the existing loops doing that, to use the new helper.
>
> This is a trivial patch with no behavioural changes intended,
> there are no changes to the generated code.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

