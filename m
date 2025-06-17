Return-Path: <netdev+bounces-198590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A7FADCC74
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CA18841F4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18EF2E2677;
	Tue, 17 Jun 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AInaSgjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499762F2C68;
	Tue, 17 Jun 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165219; cv=none; b=JgWmk9bIuH+zHlZxm5zEfpVJNvXduW3VXKHcFXJZjo/3vfG+lm5izuC+hy3mZMoHU7lepImVPuIGIh+b6SbgnfOAti/uq9WTsSiTZSgWzBTx/uj8jU+jdPByxI4AtjL1Gjsic5ged8r3oHQLILV9oiWye7Up+RlUW+yKek1oPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165219; c=relaxed/simple;
	bh=BGmA/bVMJ9ftGI7TvxXUi+QwAR8gKmoQYzQ5tMnoBp4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CslEoazknIuTB3tqyK0rUTv8b/LJ0N3JkBgCFAr0jvkEqCyfBvueTKXRJn2rtKGQx348LH/rbvmVSyz9AQJMbvvxYA9pyIi4cJoUesRUdJNhdS2wJQQ91SWSeTZrSAS+fNy+FM6bmDbfXf1rEQpfPoII2mzR9r2GGwQBtGus31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AInaSgjq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47263105e9.1;
        Tue, 17 Jun 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165215; x=1750770015; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGmA/bVMJ9ftGI7TvxXUi+QwAR8gKmoQYzQ5tMnoBp4=;
        b=AInaSgjq+q4hll4PvDY8q5uC5IM0M2xpubCZrF5nPMl5A+ktc3rDq2vUIav1VhZEwa
         3VWj7k7G93KZNhY7lf7VroYSxW9MGY3jO73Ih3uC2KLlQq8rx3FWNPaVEfpKbSguYlrZ
         ar76qTXZtJOEWVOPwN5Ze+40F5AmgktlDz9a3HtvX5drH9I+/J7+mfNk9B3/h6ciilaG
         27Vu7qhVllG7o7YfKHXn3/M4GUa1hiC2vIBl5mIHKCQa0h2zQnx3Zq5tZLXdBJKPrw5w
         pxuiHub6c4tTNyuBifgigeFufVqe+C7Ioy93xuRT3BaEIOu3Ns7odvYgu9WFDepwFXiz
         uNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165215; x=1750770015;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGmA/bVMJ9ftGI7TvxXUi+QwAR8gKmoQYzQ5tMnoBp4=;
        b=DOAW95/nmTOvtngFA3MIioxvh6RDCMlOj5/0Zt9K1JgskyEmv9vwzV6+zMZ+r8Mn3J
         1Y60BkygNBa0fcmXRRxZxAxYN7N4ZmhJJ9MjdRjbp9PDzPlZj8aH9IHiJHaJHOxtrgO6
         5xwsEERdxF81v2lZa804dRLz2LJcu0lQiosbRB+myseZeafzKekBKvYflYrb9Rip3wHe
         XcMMqSFAcItssr34IhcAxFBkth1HHrI4Ir2cSzZeJn4vipdjNl117QzDZt0jI8JWbXUg
         1+qUrFgx0epsIYteopqx4mWbOF77vlskSYQg08A6eF0v5ajeNQZAZsK74XzaVSWX/6JY
         SqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbtdg77InrO2pm/C1/kZ9bnrvWz1BWmoaeJVYNXWjy6wkicglkK9cUjfzzm8bB7qW+wUxMmsYFxPDClV4=@vger.kernel.org, AJvYcCWIrdsv7LnSdpbMWIHBLtPnvKUe3koSgcK8AZ8avitWKl9Xm39EZws3zO4cr6HmfAZFO4UW+Ttw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7bGNP3PkeiMLyfr6UdiEdMWuDW/TAVsiTsL6ti8Au3Y4l9aC
	X0WfIfEPkpdZf7aTFxApylM/wQEczgc/THQo2l03IXrfqxrk+mqjAmLI
X-Gm-Gg: ASbGncuSIzaa5apkf92UJTFj6HdDjWize2pUReioVuwZx2K2rP8LsA+SDqnbwEwF7fZ
	WRJVIiZNvqDkHZCj2fg94qB2S9prvGvd2Ww6Ko1ACiMl07fURShGEnFh3A8vl4L9gwpQRi/JqwI
	yAg4blSBIMSMsRZYnEgj+bFB+uHZIib4QeI34Ls3GAhv5JKcGLb+okPr9Gdc8aeqabZyvslI3Cm
	Hj81JRQMvxPC8xGsMj4k8RnDBgJzU9PIZC9jAB/HQZSRHRz9RS90aE6L/j3y0xDSERniUv7IPcN
	Ou1m9QH/0hS0U/lwf804Bu1vbu4cNEboAhc7Kj/MjAJ9Js9mAK5+FhfoDXtLt70eA166ak+9q7w
	COscTsPrkVg==
X-Google-Smtp-Source: AGHT+IFdwscoFtKDmQDDxuggxEnGBwA789Okb1t+Dl/aRVj/6eU4eWq9IO95AQuPjQQagJ63A6hoHg==
X-Received: by 2002:a05:600c:1c12:b0:44b:1f5b:8c85 with SMTP id 5b1f17b1804b1-4533caf5e9fmr139557665e9.13.1750165215199;
        Tue, 17 Jun 2025 06:00:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e169d90sm178458845e9.32.2025.06.17.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:14 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 12/15] docs: uapi: netlink: update netlink specs link
In-Reply-To: <33f4626404cc92ee3f3aab481a8d163e9b4a0f6c.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 13:46:16 +0100
Message-ID: <m2tt4eilif.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<33f4626404cc92ee3f3aab481a8d163e9b4a0f6c.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> With the recent parser_yaml extension, and the removal of the
> auto-generated ReST source files, the location of netlink
> specs changed.
>
> Update uAPI accordingly.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

nit: seems like this could be part of patch 11

Either way,

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

