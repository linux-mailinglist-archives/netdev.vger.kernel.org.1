Return-Path: <netdev+bounces-245982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9222CDC57C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5B713009067
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB5B30EF66;
	Wed, 24 Dec 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHk0gwKU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rWi8zJs/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BB23D7CA
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766582307; cv=none; b=fzOB8ktXWG5lPyDkvzaSbz7ywXgmrQ/IIfMNwxYQNugMxTupMIbMsrivUE/2kf9lDPogwRlSU1eMUQlFpX1RYUHDNuzz/Iim3mGccPBeIC23sXaR4as5yn9KO+mVB8Y5PqOwwBJtme/I4wLaDkkJEQvISzZRV7EnzdNYIZTI8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766582307; c=relaxed/simple;
	bh=Z1vwCpy3xpWeWvKjBKC069x7b13vg9BDJ+FjLOjAjPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njstrGyoCTpIpPKzaNIDtDPh+SuXg8nUNnt/sB009Zo1iq1Rfdzoc2JoV47GCb8FSxZVTipOKDlt3LGcZaKYazE9Lp+wa6EEE/AkTJAiGNKMZ9TLuEG6uhMzlOQDMLOam+5glgkfcJlfdTk0N8s9bZFxwkNaM5fuQSkmoao+ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHk0gwKU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rWi8zJs/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766582303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnyVa0gL9PqRyxoGgad9ZgIf7TrhLDmrnLDL5gmFISs=;
	b=gHk0gwKUC4+MKK9ny/Fz/hPjg9snSdywOoSsDIGKQyXJII8lFdp1Pm5vKCm5JOxRL4FMfL
	m+jjYe9CQZ9leLuBK3hrJdLLRieGMLAbRRHidw1ykJhoT0dxT3aSYEzTKuSKRUYpt4PcDA
	cyI8p5+yjjL5mQkbSi0lRL61dft7ofQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-jEQ-Y-GqO1SZksMuOPY9Pw-1; Wed, 24 Dec 2025 08:18:21 -0500
X-MC-Unique: jEQ-Y-GqO1SZksMuOPY9Pw-1
X-Mimecast-MFC-AGG-ID: jEQ-Y-GqO1SZksMuOPY9Pw_1766582301
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso81946445e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766582300; x=1767187100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnyVa0gL9PqRyxoGgad9ZgIf7TrhLDmrnLDL5gmFISs=;
        b=rWi8zJs/stENPkTwFR5cuv8ZF5kDJpVB37mXM86ZyFmJ0Ri8qE87MoqIm3IRLYvpZ6
         uGzwz1XH+6wW+LK4PqK60uEN1Qdnn037FfyYwErehbKdxnaSl6X9uonwPQXEZl+w6BuV
         3NKzdxuyTFvO2Yr/0fi4Du7qHEyJhVZWSGtFSzwRQiN37JyPXy31cidXqO3+co7wrUVJ
         SX4H7Uch3T9Nen3lBW0vaSXuKTzvxPSdLAap+FD+J8AjaGc2+AzlqS5DgHGp1rrXxE4I
         aY0Um2QLwyfWMmAUVqjTUganSRV5pJjQEkXncdY+RDyFK9MttjTe9TSxnotX9KbRWJYA
         CftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766582300; x=1767187100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnyVa0gL9PqRyxoGgad9ZgIf7TrhLDmrnLDL5gmFISs=;
        b=BJugihBEv2njZkyDU3PaT4FPnB93Qa12epNfquyrHHi2Z6VIz+hjlnvch1+qjhCkJu
         bHNvpTnVN3/URApdFr9P/ZVsB+tGabOg3Y5BhlqDo0dAm7XimV1cJN5w7/fyU55q7fLe
         g9D35kM3KK9mKuiw5C0cmNXWlNyYdut47PSw2Xn45r4SpZsDUhROEwZNpkWf7JOCeED9
         JnE3gwl0CQzZ2mEcEu1SR/qnp+fkcd7q06W94AOdhBmLF3T8h9kDO3tWEgQPNiAk2r4s
         4uaklab3jgD2sRh1UlT02oeU/RtLkfy/xqqBdohRZF6tmlS2uNT2JL4zDJvng15kyfDg
         Amhg==
X-Gm-Message-State: AOJu0YwUgt0nZig5kxba2ow5meHyfMe/PAMUX7OHF2ZL5sUoFhKTdJjR
	cYX2UPNrWmrJ0UXaCCtyBx1YCAvOLBcfhB1FtzXm6kWz//lsx0Y0BbFhsxsmQfQj3rzb6rH49NJ
	K+01tOrmT1iV1MkLpwLtouF71UUko/ZDVeJ20bggQGhvCsGa9m0APo4QxZA==
X-Gm-Gg: AY/fxX5sZ/Uu96XvB+nZU1tc4I4JbUCZaFKaQ1uwAXBU9f6yYxxz/H5YkRP5VCStifo
	OYewl+SLp1BMkjeZgrtY+ye93RvKYxiUb4Q+PQuyOQBE2wN4bEw7DnjI5OH2erRJBg4rjWIbiFx
	0QDGdNTej8abgNxrMZSSJCDlYShNS2FATKJpywo/beRIiP9+EEOf8Eap7IBnRkaC6TY+lxh/PIB
	1nIhDFd6F02EC05Qf8GCUjLYUxps4UwsdOlf5mxS+FdZDwhBWdvtzS/EiBqPJwstFjCAPh2n3k0
	8U+7vtUss4ECuyxpGyScm/+mtFVg7aYo1471al58KcRpREmPQzUJvfESxV3nXqn/e6jikeoGiuV
	iSZ0PPJtu5nzXeew=
X-Received: by 2002:a05:600c:1f84:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d34de4cb7mr63019745e9.10.1766582300584;
        Wed, 24 Dec 2025 05:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/SlkuvhiTEvzYbTpBDDuJpHJEzzSjm3eiNJ/Fe6ZgvJBNGCeEN2QpRSXh5vQwgRwhpvCKLg==
X-Received: by 2002:a05:600c:1f84:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d34de4cb7mr63019525e9.10.1766582300181;
        Wed, 24 Dec 2025 05:18:20 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm34326729f8f.35.2025.12.24.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:18:19 -0800 (PST)
Date: Wed, 24 Dec 2025 14:18:17 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
Message-ID: <aUvn7yVoSPG_FIiD@leonardi-redhat>
References: <20251223162210.43976-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251223162210.43976-1-sgarzare@redhat.com>

On Tue, Dec 23, 2025 at 05:22:10PM +0100, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>If the last test fails, the other side still completes correctly,
>which could lead to false positives.
>
>Let's add a final barrier that ensures that the last test has finished
>correctly on both sides, but also that the two sides agree on the
>number of tests to be performed.
>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/util.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index d843643ced6b..9430ef5b8bc3 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
>
> 		printf("ok\n");
> 	}
>+
>+	printf("All tests have been executed. Waiting other peer...");
>+	fflush(stdout);
>+
>+	/*
>+	 * Final full barrier, to ensure that all tests have been run and
>+	 * that even the last one has been successful on both sides.
>+	 */
>+	control_writeln("COMPLETED");
>+	control_expectln("COMPLETED");
>+
>+	printf("ok\n");
> }
>
> void list_tests(const struct test_case *test_cases)
>-- 
>2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


