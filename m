Return-Path: <netdev+bounces-195063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC3ACDB64
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062603A36D4
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6C28D83D;
	Wed,  4 Jun 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCI0RtYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA528CF5E
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030555; cv=none; b=qnWoFRYRyBSkgM1131gP1cbgx1D9xuPdppS3/GXfz/jJsX6UFL2pajT/beAe00RwTiuiJkWkEBQDp1HAnjRK05OCw/eUiECFIk9yqdQ60mw9732vneFu5uDdEE1rxtRT5GES6nXwbM1p2kiTPrK3ba4IQ4Oljg6ajpf3mDiaboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030555; c=relaxed/simple;
	bh=0oYWr2w1sH3GTmD1mBRVA3ufMqKu8oKUJzomrcdrnhQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Up4f9mUrOEtyAAlu6tqnTS1AbIre1t4wiuJV+0RMdQoMrRd2h5KV+8LZvqG0pGhyMRiE9MYyi3Lnvb68ld+ldjc3th4/gWVNQ6Z82qoWI/iXGa6xhVUOtsuvMYqxl9aWM/wyZw8b9Y5sDzGZ6JvA81q9rn1JM/z+rfQaO95qFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCI0RtYI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso60187485e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749030552; x=1749635352; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYEcamhMFwsgWMoLazQ4SImjKGUGp73/lvYYgzNA9G8=;
        b=JCI0RtYIBpxRq+OpaedxpjUY+mFyWJ/jVidjh2LeBe5z0/z+bd8kMEG1YaQoQTKVAb
         ec7/H76meR0VmYvcLBI1BgOsT9o8nGH9ankhdSYiBcUI3UbNBryCea4uNwvMVHAM827L
         ScwOckPSX6avxZ2V5GVt3FK87ClWDPCXzCgy4ROLC59zoob5dwVvi22unbZlsxwE/wlu
         EOZHFP8yKPDHzrdDjdb6TnlLyOO5vmg3+9OwnkGUN+LYT6WEud32eyRK9ERZ8TdlwuLB
         5kzbpqy4u4B84fzpKQVwoRbiCOy8arQ8VUC5I7/0M7yQTLdcUlY1bG9rHmlutWDjAF8D
         w8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030552; x=1749635352;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYEcamhMFwsgWMoLazQ4SImjKGUGp73/lvYYgzNA9G8=;
        b=YUc3jcI7QGKj39kn1azkoncYsT0sNtdEkbJpezea9PpwKwtDgDyZ9Bb+nNScXIYThO
         o7Bi3XTTrhiwpYqAhFDKiv1pxYF69a7mBT7yidyNKgFVmasco/p1yuKQlpGmyR09Tl6Y
         aCCdMWAiMkZbbFeOgbNerAOBP0REWmGNqhzpsyF7LSAzcORByZog8VSNFPImD5PkqrbW
         2jhRg1qivNZu8FzPGrHmFXUDE9wWARZ5ODOrWM29pS+hHNjpgSLkoqZv/v+R6GLwcQOH
         0dG0RR0u0+iYZn7dTd61/IizukpuGPiG7DWdtWeiPWw6u3Zttdk3XXeVIjrvJhSEG4at
         WAVQ==
X-Gm-Message-State: AOJu0YxA6eQbyARVWc0WztUWzrrJEPcMMAEQ0MXDSn7fYO/eGwTGLdUD
	ykEeHIMGq4PRv+HRooot+i1jV+v04tuaWUCh3jlMReqCnOg6pt/I6XYe4C+GrA==
X-Gm-Gg: ASbGncsCODlZx2ruxmvWJ2lFvGAgMMzxI6fcMdJi6rH+MVdJ8kC3jR9VOmXLBMwTgjE
	H0a/XbEOcgF3kKVzFqfbUDWych/T4gYLaaN/u6PgXvAd2wLzM562DOKjScnyMBK7WZuadInXYg2
	eScsbSbvZg5fvi62bryv1jSeXxdUiI4diUvPVOT9zFXJSb1uL7jUNdzUi+7M0H7ts+XujklQ/b7
	pKKFA1r5doWSIkigcHCKlRNbP2OYWOjKwAdbWowBtIv2d9I0jz6xGn+h0I4HtKZsyzE6vqEAx6l
	E8PqYTMa2FsDgOw7yjIS8OPW8v3SjT01ZAMABxcG+J1Zadi1fEk6Ps56T0R67qHTKoPuua+h7EE
	=
X-Google-Smtp-Source: AGHT+IG7soY52mh+fNcB5EAfiFFOvOmK0++I5ME5+aW4xEqstILthgrRtZf3bWvQZxMzJOMQxHE5Yg==
X-Received: by 2002:a05:600c:19c6:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-451f0b0d5cdmr13445515e9.21.1749030551504;
        Wed, 04 Jun 2025 02:49:11 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3176:4b1c:8227:69ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1b0a4sm193810785e9.0.2025.06.04.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:49:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
In-Reply-To: <20250603120639.3587f469@kernel.org>
Date: Wed, 04 Jun 2025 10:41:14 +0100
Message-ID: <m2ldq7vo79.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Hi!
>
> It's merge window time so I have a bit of time to catch up on random
> things. I added shellcheck, yamllint and pylint:
> https://github.com/linux-netdev/nipa/commit/c0fe53ae533d19c19d2e00955403fb57c3679084
> https://github.com/linux-netdev/nipa/commit/255ee0295a096ee7096bebd9d640388acc590da0
> https://github.com/linux-netdev/nipa/commit/54e060c9094e33bffe356b5d3e25853e22235d49
> to the netdev patchwork checks.
>
> They will likely be pretty noisy so please take them with a grain of
> salt (pretty much like checkpatch). Using the NIPA scripts from the
> commits above could be useful to find the delta of new warnings, since
> there will be quite a few existing ones.
>
> I suspect as we get more experience we will find the warning types to
> disable, and we will drive the number of existing errors down to make
> checking for new ones less of a pain. As I said, for now please don't
> take these checks failing at face value.

This is a possible config for yamllint:

extends: default
rules:
  document-start: disable
  brackets:
    max-spaces-inside: 1
  comments:
    min-spaces-from-content: 1
  line-length:
    max: 96

