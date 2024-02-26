Return-Path: <netdev+bounces-74880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD4867127
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFA81C226BB
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABB347A7D;
	Mon, 26 Feb 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4W1otYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1D1CAA7
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942778; cv=none; b=d0MXz9l+IOEihuGdvXbzg1RYBYpjyVrKqktXznHHy/1GX54Mqq+ZmBk3kivwLB0btjLme1rlXUwYVZZ2D7mAK9T26ZJwMnADzkSiwROYqRrGiguNnpr88ibwDu/bmv7qk7SidtTCvt5LQAouY0msYmy9Ulut9uXwOC6I+QAbwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942778; c=relaxed/simple;
	bh=hlAYKp6nvnRSlec7GzRjTJ93LEJqe3CSZkTRlCOpcVE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gRilJFhr72B9jCHjGKQax2y5tci+mzRI9M5dm+C5P7XVCtoJQJQSbktrnFpSN8m6Rp4aPWnBfHj8h06/iLnnyAz45ExvwJMX7MAO4AMiBDspG7Nyv9jVPhNFmLMeVLugJrzlJS+v4Pl+Fold06+RvRnHq0ABmq7XWPBh/vg2ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4W1otYS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e552eff09so297442466b.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708942775; x=1709547575; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlAYKp6nvnRSlec7GzRjTJ93LEJqe3CSZkTRlCOpcVE=;
        b=l4W1otYSKiR+iOTdI870W31XyqzK0ZIhWxIFgFMJns+uT5t+rC37sAZ7LZ1mwWvBC8
         v3t510G9CqYkKtojXCu+8KwxoDl8gNpEikeUloLrUiiJ+ds9YhjD6U14AI2HV6XfyALG
         fXMHgtl5LEXgyQhG+QCJNgoUcKScoIuM3cUGaLiulzRzXH03txVJpkbkGyA6I1W8WXdz
         haReyJDoC2/EUInFiLoz3Qf9EtfTW1TazxNMTuC0r05SfZ5THNG5S4p04F7dUp/oVsNF
         jL4iwpKYWqvk3xzGmxdlUuqWKSHCyBeKn+dYe+bfh1YQ5gjBcvLb9UfchexgVMbiHDtY
         7hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708942775; x=1709547575;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlAYKp6nvnRSlec7GzRjTJ93LEJqe3CSZkTRlCOpcVE=;
        b=Krc9CbdIINAaZ6JU5KopKtBHUVQX2XAiaSrcScU3+BBvJVWKCHlQL8I5DZ/Wm5sdX6
         FmeVfKo9vZJ7NGsSwZ9W5NrerJpqgBD6YPa8aPuEcr6iCVcXctzDN0BBFohkvZ/fe8Hx
         khmtpipO5tfftzVp3SDSuKgQvhvoqSIV1BMmY7aVw8LMVsPZky2Cn/yo3OTx7AMGpMPl
         7zb2JrnoAu/9beAz0YDiWdCa1/6AfAnJ6jiHKyLrsOslGPq9ju0g0vY64UmXPHi9O2KC
         eonxXrextEdYfSxlD+yl0XCIDP7Tcf4i1736LqWBa+LqpIvMwl1Fpw4qaWSZggipKwJQ
         QNFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2394WpeU6wozzrYkyMa4QNKO8B/ieMvQhoaYNnXBlxgLxbxuKHBqNHOYalKQJZoEOXwzfv+c7DT0HeugrH+PywxQZ7kna
X-Gm-Message-State: AOJu0YwTRzk2pr1cxDNNelIDqW3uIiQzgCLB55ZxJOoxEwyZniFGK4RJ
	PmX0LUtRX0VOfM0W1oZNanbNKiwi+91IUwrQb4LI8jMopAUJ3kLw
X-Google-Smtp-Source: AGHT+IEEoJnaQsI4QqJKU32EvlmHafm8UKFUpwZUCLHjmO3Q0IxhxrpWhGlO8OpRh6xeYmjHVCsY1Q==
X-Received: by 2002:a17:906:b7d3:b0:a3d:993e:ad24 with SMTP id fy19-20020a170906b7d300b00a3d993ead24mr3773614ejb.59.1708942774603;
        Mon, 26 Feb 2024 02:19:34 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:ac76:79a7:ef5d:d314])
        by smtp.gmail.com with ESMTPSA id bj3-20020a17090736c300b00a3f5ff7b675sm2289641ejc.23.2024.02.26.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:19:34 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  sdf@google.com,
  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
In-Reply-To: <20240223083440.0793cd46@kernel.org> (Jakub Kicinski's message of
	"Fri, 23 Feb 2024 08:34:40 -0800")
Date: Mon, 26 Feb 2024 09:04:12 +0000
Message-ID: <m27ciroaur.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
	<20240223083440.0793cd46@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 23 Feb 2024 16:26:33 +0000 Donald Hunter wrote:
>> Is the absence of buffer bounds checking intentional, i.e. relying on libasan?
>
> In ynl.c or the generated code?

I'm looking at ynl_attr_nest_start() and ynl_attr_put*() in ynl-priv.h
and there's no checks for buffer overrun. It is admittedly a big
buffer, with rx following tx, but still.

