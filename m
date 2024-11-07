Return-Path: <netdev+bounces-143068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B949C10AB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A30FB24B25
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C221B438;
	Thu,  7 Nov 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0ElyClm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383821B420
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013425; cv=none; b=A2kmGKFYts+nlxcu6AG1lIYB6eItnqDEX28ZOCWdcu2Dy1ss0/SfV7RTd7dHcDC8fii99tOHqsitLsL7l9mO99nUvXAMQ/5QWoyongTFYs6YHfQdzTTkG/MvrqvFUqCRvXCacws/fHl89ySvuIMtZX/Me2I6hGd8tcxYSRvxybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013425; c=relaxed/simple;
	bh=Ipz5bALsN/MIsblwdy7t5XX40kUUu8f2PO2Qy5od7Ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGUInYin1sCLNnU5WCJLJNH/g1XCJV/NtbGIu7igUNT1YQY6DZCkJCaY/13IsgjYzkvu6VN0WI2VJ10pmGK4wzi4ta4s+kQ7x612mFlauD7KO4RSQumgRG84KeyHLQvF1gplmkmJekpTFK7qu2Kuq1oDnF4mFB+E9VOIWo1kDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0ElyClm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaa08a6fdbso24389717b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731013423; x=1731618223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bV4qNgv2ysT4G5mWwtsIUu7x27Hvq/nn+qp34bHS8cc=;
        b=t0ElyClmh1BBQcMQmLuULTsI/99CxXMQh6pHqo8gqdBApCqQk5zvoVrw+U8+VrAc50
         fd5YedoSXZMBC2SMWrU0h26TjAAr/HgEtVGNMnCbwXEcafuoOQViyKiktscz0ivCtyMN
         q1tJYSp6nAO3exbUDUV6hDlLsuhlNgwLeB4oGyRciD6lXggWWl2uX5pyKU1VEXxDFlYT
         +aHLdeVC7ogQFB9jfRUsx/pLv2T8R0evqNN0pdUz5W0JFxOBy9utZQP2NHrOyYrXKsSS
         pKCMFdvde/Pux7Gqmn9a6pdcCBVH2KV9fQq1tPe6CqpFLk4GYDuai+sO35ltXA6rB7wa
         SSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013423; x=1731618223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV4qNgv2ysT4G5mWwtsIUu7x27Hvq/nn+qp34bHS8cc=;
        b=r/0ERusuj91MQTbodD/e8quhil46ZLA+NQiFSE6RcOl4LlA3sf44OdQ3BXqxw+Wn+s
         u53pZ0+YdEfNVlfv4JEJ563Lk9AkYSjCeyqnQDMYpaJb5yhBeOT+AxNBoRNsYDZfOTwh
         T2XkgHift1lEsWUs/sVdVBNdKfL9UKA+kdgCkq513ToChM6ghAl+KQNqmTDufz2dx8vK
         mm8HXpXqndNJ8kucHcqL5j5G5dQONMkbYTlyev0na95hw+oGuYpP/ltsGchRhnYmwud7
         6haq6KM2wfR2rljDh6IUDKjvUCXsRN4Ccvkpak9F92YMEEL5kTxS7HvWwYtVeibYQjJZ
         3VaA==
X-Gm-Message-State: AOJu0Yy8KrUMmYfISO6SWGO3rxwMQlVhKgdmATLwZHPIFSwslanXlkYs
	4c37w3xl2uPOrP7pguUwiJ7grr5czoaByysr03vuw1pxYRK1CWX6sMXCdvbjk1PNUf7t11Mvk1o
	18vRPYokMyVHw6HsDbFwKR79rnjrW+2akWyJrPiRpWGa+quF4VbPIOmseMSrYPFaPdTgJ93rOH7
	911gQKqWSU6GcYyPRs7tz84D9AuIvd544yT7mDYt37NY+3QRJLu4hWt95fjoM=
X-Google-Smtp-Source: AGHT+IETrU+0A00hHxfHIfVFgSG2d0BZXXwBrEStRbQNBitfarxBIyneJZkPxpSo9OfqjUnUZYEjH0Jc/5cpQqJbFg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:610d:b0:6a9:3d52:79e9 with
 SMTP id 00721157ae682-6eaddf8de42mr8117b3.4.1731013422380; Thu, 07 Nov 2024
 13:03:42 -0800 (PST)
Date: Thu,  7 Nov 2024 21:03:31 +0000
In-Reply-To: <20241107210331.3044434-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107210331.3044434-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107210331.3044434-2-almasrymina@google.com>
Subject: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in documentation
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Mina Almasry <almasrymina@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Yi Lai <yi1.lai@linux.intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

Document new behavior when the number of frags passed is too big.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 Documentation/networking/devmem.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a55bf21f671c..d95363645331 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -225,6 +225,15 @@ The user must ensure the tokens are returned to the kernel in a timely manner.
 Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
 and will lead to packet drops.
 
+The user must pass no more than 128 tokens, with no more than 1024 total frags
+among the token->token_count across all the tokens. If the user provides more
+than 1024 frags, the kernel will free up to 1024 frags and return early.
+
+The kernel returns the number of actual frags freed. The number of frags freed
+can be less than the tokens provided by the user in case of:
+
+(a) an internal kernel leak bug.
+(b) the user passed more than 1024 frags.
 
 Implementation & Caveats
 ========================
-- 
2.47.0.277.g8800431eea-goog


