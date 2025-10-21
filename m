Return-Path: <netdev+bounces-231125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2ABF57E5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81C91890982
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573732AAD1;
	Tue, 21 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noEdxz1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D34328B67
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038766; cv=none; b=IKSd/70ugZOxHzJJwXB57aIK2Br9msPWUJjF32+gB7Mbo7q+Nwd3xht2xFhgueMc3kTCn4N/tkxzPPtRKaJRAK0sGpMQoL5bp2J8L6dlYJSuCl4qJgBRl7JetSHC1isGXqKHfiUFIlOa1jeBssbA3uPxv8ZPS2zbzr3vuEX+1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038766; c=relaxed/simple;
	bh=VFQphnGkoktZvUzEwKwCJ8sXqt24rjb9W6hVqumfQyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMoYER18stEv5NvFVSBIZ0ddxWnAH5IM3+xafdcxQdS4I8OsXOc/XY6OjsQDlFDioOLVgELPRLHaKTpcE3hwtM3Pv1cxJPwiCP3wL25B0QAbltqX6WsEuijeJOKa/tyrlnE7APv93R1xZ1DBnn4NQ900mM6XGdiV/n5PmbZ4Q2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noEdxz1c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b303f7469so42559625e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038762; x=1761643562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=noEdxz1cmxgyCrbf3Wd6MWCQBkpKNuZl7HVtYdP3Y3ADUEPOGo/W4mv8fGrl1kwgzs
         bF2CQSmwtzufVKYln5FMiHBQMBapwLx1+DDrJjaSyhC7Kez+WAI6iP4j2YvQmOllZmU7
         1IvELMEK2Tcic7sajjCEp6mIlkYRnpjSUfJw24joMxXOVfhjeQZu1xiKCOm7cbzzUCLT
         Mq/ls385ZSNy6/l/+Km18SBrMO777cinIWNAwFhtu9Z461iVlI1N6PHW7+JRQHINlgHc
         3lpHy4tO7TTbHoShpmcBV2JXIe3ziQxhzpoWB+kqiDPbyrNEdbu3gLjbXLYHYIQ3FtDO
         O2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038762; x=1761643562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOpWrFnzvrU8dTkKh9SzfT0djhjWURZWY8moqWPz71I=;
        b=xBjoAzjPz2Z25K54xvpxKAR7OzGjWfGfp7hnc+VOZFOxAARu3oSVMoOqvv+y9GqKt0
         MJwOxAwD+7zVdiuitPN3P0vhKi7PLzu75JKZ5cG3GOxXxOM7S4JqLPsKkVaIgUuRpndj
         0AIcqwdqvPJn+ILPgaN4kngWbm00tGFPkkU4J0n9xJaIPmYl7T6h+6AK3hCxyb/YxSYt
         ow+amRQ4eKX8TmrJMqOVu3p5hzuU9rsKzFPfpivZ3uOnQCns1I7jBgb61i9l7ac2IRmm
         gHg+eYVRl9RTtjlSj34CCK75dmEWX1Z3pJE9B67w/x4KtQqRxQuvxP1/a64FzQrHLl5I
         /5bw==
X-Forwarded-Encrypted: i=1; AJvYcCX7MGch8uZwjFxorCBtRozzS/h+dU+OGTthqVHYxrgjmLVekU1BE/jt2wBL/plfUmbbz1BdGvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYZNgpZFfOrc54cyiSTUHvfaoTpZng0k1Z8PdUYU7/CyL2BCX
	z1vk2h/ftuMinM2O4hJ6iPhStttVvPL5PU0EsOQzvDRLb7+YgzXAXjq5
X-Gm-Gg: ASbGnctgYmjzV/OxiXFRHQKjORo1j3ytJj3ML1ihGQfAqy+eP79CjHL3YD+WtmiSWyG
	sAFfy4OBghzBExiR4H0j/ftXwozLA+8iu9ZpFR9pRQ6DgFsjN+dumF3ufHfC+ZNdR5aGju3U1hh
	D8GkG9TY4yR7ePGRdSs1h53FKvRxe2SGRXpt78Dy1Q+v0ON6XOQedkTI186KawwgBC1CnAIp8Mm
	IaEyaR2rag8UHxoRFn7d8HG6tpPFqVmGzkn1UurcTVXgV8UoQsBX71y0at1AMSC1ap70LfM9atR
	z4RWM02jTnoWlZyKKx8PBLRv8n5oK9Iax80nOCNaDCpHIuUJrbib3x/KIw3RhewAp/nEQyf7POG
	6c8fZ7GQO+EyverEnACyiy+sxWZRI2XRVyzzrzQ8XmFspfb3GFBeGWufJOWuiYNFlTW1eT7aezg
	IgN6kPEbQVm5xofAqpVIyml9DgkL+T6dUkh7BAdmPWaUmsqa378norccIVEtfhp1I=
X-Google-Smtp-Source: AGHT+IHG9qJps3XQWPNYA4OPAfHFr1juDXQi4VNXIDoZlFbccTY3/HGAyaSBPRBTf6Mk1q4iNuNdsg==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-47117931c89mr109559365e9.41.1761038762110;
        Tue, 21 Oct 2025 02:26:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm19195113f8f.3.2025.10.21.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:26:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:26:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251021102600.2838d216@pumpkin>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 14:26:30 -0700
Kees Cook <kees@kernel.org> wrote:

> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

One on the historic Unix implementations split the 'sa_family'
field into two single byte fields - the second one containing the length.
That might work - although care would be needed not to pass a length
back to userspace.

NetBSD certainly forbid declaring variables of type 'sockaddr storage',
the kernel could only use pointers to it.
These days that might be enforcable by the compiler.

	David

