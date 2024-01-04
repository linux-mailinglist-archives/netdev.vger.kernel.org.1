Return-Path: <netdev+bounces-61663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875282488C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A07B1C2268B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5028E3B;
	Thu,  4 Jan 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9PehNeE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CC28E21
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so102215166b.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704395080; x=1704999880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=S9PehNeEr+4blxt6e8NKLyPCSA2MX+RY9rcAoM3px4mPQPOO+kRd3glFZgMH+UW4r7
         MZ9qeyyNPJiGMZHOYIR/4hJ/a7FeOvgqlL0xGVzFT9nNcQCiezvfZfYVNzLd/fLUqawB
         Pap8dX9qdHLkAx09xHOOuRMXM5t3EdOsWhD7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395080; x=1704999880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=dn/S1Ut9eHYuFr6t1dbpVbB1s3S5fJ3iYUYIOIcpU9YEL3gJfB2CXGkyO76W7+n88N
         Fqaw1TxP5+g+0SkMKqS7dVHk9STvyI40WUIGR9XZVZFu4puvlbyBRuj5DOdSZYBHvbov
         j0qgmYkxw3Jch1v8xLUnDnnF/apK16BNlgTNv2Goo3G2MxSJLthWB/fbana7OLzBfNxN
         UhXsIbdiYq58e3lfpEqH0r8HdLsfsxu0sYG2UuPriXbHYG19TmK0d+tSKAvutZBxkTOp
         DeetEz1GAnx3wmabBdvFiFXZqPInYFPNNtyjOKaZebDv8LzmZyf9ZCTgZxWC64e8pNWd
         /AqA==
X-Gm-Message-State: AOJu0YwV2P6LWGzsJI4LPitQr+wl2yAEFKlk/yErDfPi0uTGPt6ryrCV
	g4fiTGOYsiegRemLNUf/y1w1P49Y3vqcZwa97/IaDnso7cYsyjdK
X-Google-Smtp-Source: AGHT+IFYshYqpkK9FEe1HEwA4X8Hv2VTg/ZuoMAtZjH5VEotNrIjH1KBqzzmWTsmp2gN+l9mUziOGA==
X-Received: by 2002:a17:906:f197:b0:a26:d22f:daca with SMTP id gs23-20020a170906f19700b00a26d22fdacamr369571ejb.192.1704395080766;
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ie17-20020a170906df1100b00a26ac1363c8sm13422837ejc.94.2024.01.04.11.04.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1069164a12.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 11:04:40 -0800 (PST)
X-Received: by 2002:a17:906:18:b0:a28:f456:42a2 with SMTP id
 24-20020a170906001800b00a28f45642a2mr318777eja.44.1704395079598; Thu, 04 Jan
 2024 11:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-14-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-14-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 4 Jan 2024 11:04:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/29] libbpf: add BPF token support to
 bpf_map_create() API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add ability to provide token_fd for BPF_MAP_CREATE command through
> bpf_map_create() API.

I'll try to look through the series later, but this email was marked
as spam for me.

And it seems to be due to all your emails failing DMARC, even though
the others came through:

       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

there's no DKIM signature at all, looks like you never went through
the kernel.org smtp servers.

             Linus

