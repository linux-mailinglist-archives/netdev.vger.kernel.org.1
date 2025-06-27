Return-Path: <netdev+bounces-202056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283FAEC217
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9048D4A0CDA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B297289E3D;
	Fri, 27 Jun 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+qS5JzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E122CBF9
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059999; cv=none; b=dlwxkeGJ8Sd652fyhtYG8a3+zOvJ62R53j7DABi5WUey7agGOj+55+bcyCwo7Ghg4sHnlzWPXteRFw3MnFIgEb99keO63OSfHLYo1kZHjgj79dPDq4FdmSsrzdq7JfuwIvXxX3qjMooBvTxMCcQ+ZJmyxJCLe+mmb2rW09dw2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059999; c=relaxed/simple;
	bh=qAEd92OIIt0r4lXEG3F0TTNrm/754v1eLpsxa6G3KcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkpeUio0HeC2OVFXCosxxUk9eMcGNvh8n5Myn01US6p5ZUCKIxQre06PoO5LZ4etcdMLTyy0nZZqImsyQDIcPuWSkrNUhMisdtCU8k0UykFgQvjo24lIMVME+CKi4jzK45cxhZyDIGNWk4OhNSQiYdUECeLMuAwLbtG/7SRC4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+qS5JzJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2280823a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751059994; x=1751664794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAEd92OIIt0r4lXEG3F0TTNrm/754v1eLpsxa6G3KcA=;
        b=h+qS5JzJPrHlEDQV1UN5ivVSsvnaSvpq6OmyTzlCnueePHV5j1zB+BTDDYqQPd1MhZ
         5Fi9tu9eI37LI7gdWyhMUW8rMJCoQ0ohlhKTh9iZVyoczXY2JIvRH3qhb0AjHk6DKpzp
         yE1OetTyypjfMReS4O0xsxufLS9Eh9jme4cvhzdIV88uBaqwa+NLEpvyqq/6c6xl0+Oc
         xA1d6W0GiVFqU45Vw2rQcn2ZMHLfm4DIPwBpWabw0Yd3LlIab7UGlFhkhiLQR6uOcJhz
         OLL8Dg8nV316u7VdHt35khnUEGpcVckmYli8UVUPXgxEPb67rZYg9r9a6DdxTdGOG4Ox
         ZnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751059994; x=1751664794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAEd92OIIt0r4lXEG3F0TTNrm/754v1eLpsxa6G3KcA=;
        b=iZ0eMYtj853SU4QpeUqIhVcrtoRLbsrvpigu972t371tD38aZNIloSwzON4TMEmbZQ
         z6gd4qAaex9OgRhc5hO8zem5MxTCpazznQ0UQkLYu8gYHGOYLVkrSIzEMwoyINhKmLYz
         YcPa7kOt2YOzpL1c101gN/p31SKyQychiqxXBM5TJPeJ/I4G23cwXVlEe5qnbGgPksqV
         m2ZhYg1M1E23XUOjJjPIgEIBnqj9447CQQ+Rxjh7hIv9sqWbDgN6NP7nXXTMhj6KIcxg
         3Ys0VfZg8AEi5CAb5zP+udX37DItRqWKATy1nq/u54WXXu1yl8eQCVyV85CiYBCypsKs
         0lmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzYiMHlCyPL0ln2LFo6sh+yTR8e3BlMtww+UWYy0NTTkfTNTkIvq9Whe1DY6vPvmdDjhJx8sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXccSK2LlniPnlGgXhWqi1tf8HqERylV2BL22OsVXnpoqMb4ME
	NFloB/d5esxLMsPRWkH4k1yXhbdPb8FmWSmAPZA3MhLMYDJNWfljz/D7N4W/nzH1v2i1DoWwYhu
	EeBVjTUlphduuRyX2h5R0aM14XZIPaKGzdoL5PB/g
X-Gm-Gg: ASbGncuv1FK/DkPYPbOV4gE0qurvNIuqRRCbtzJsUUnzTjqTv2gspRN+zcK5paTDc47
	cI+pvgUYcHG2hYIeC6PTPkxcBOZfj5aYervRnvf4L6Fipe+2gTc3/NFpqIXfNo7QBd7Fs6yBKTG
	2B1aiPVM5VKmE+4jpXWmK5KRUtSzIwxdx1UvELe/umCrFnsOUFwZ9HRx6zx/oDV/JfXfkIUFU59
	AQz
X-Google-Smtp-Source: AGHT+IF+qif54hJwwLgY5xWyZ6D+fsjsSIap87n8Z4Xt94NCjv3qeZ35zf5N2zhghHbTSsEqkY3t5cjGTK9zP0vKlKM=
X-Received: by 2002:a17:90b:4a10:b0:313:f6fa:5bc6 with SMTP id
 98e67ed59e1d1-318c92e0f67mr6623699a91.20.1751059993785; Fri, 27 Jun 2025
 14:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com> <20250626153017.2156274-2-edumazet@google.com>
In-Reply-To: <20250626153017.2156274-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:33:01 -0700
X-Gm-Features: Ac12FXz2INjQe6KAKUnWu3Ssy7V2pb-5FIJ8wssozBucss5T2_YYDzEa9YCcmXM
Message-ID: <CAAVpQUBUwa8cRG_PqHFp6e-BQKt22GT-nE0von3h0iqu8=__Aw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: remove rtx_syn_ack field
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Now inet_rtx_syn_ack() is only used by TCP, it can directly
> call tcp_rtx_synack() instead of using an indirect call
> to req->rsk_ops->rtx_syn_ack().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

