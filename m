Return-Path: <netdev+bounces-221614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3022B5135C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967EF3B4913
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA27314A78;
	Wed, 10 Sep 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YygIbnNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1782571D8;
	Wed, 10 Sep 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498342; cv=none; b=uocB1AxjnvXMc4Bm/oD9jSPpQnkz4wgweEZaQTn/Rsctk6WrHeJoEKz35Gzd0rMgu0GmqFF4H3g470BvOuuvPYc0j/eAOJr4xnOjlCaxLkOKtIST7TNzJMCkljZWpkITHBRJXcw+pIuu/1gwRnwyWacEPk1TCfffrhzCEZlh+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498342; c=relaxed/simple;
	bh=BCXjFIv5eUOEWTgnUI3HxkUvkh3QdFBmS5Rfy5izgT8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Q/Z6WmjyD+w5uc3SSnc+VFhev2Tbf7vQU0lP0Da0/XfulclGMZMBLXw58SbKesRXuNx08fI4w9UiVQRaXY7K59V7v81FmXA4NNDTdaa+31msoidLaHw95U2Xn0njLp8Zskh90Bo8OIINSZ0rozSsERkX4exxkMfKnqsc7fu7z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YygIbnNF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3db9641b725so6549886f8f.2;
        Wed, 10 Sep 2025 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757498339; x=1758103139; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcj8LHmCHhhzaPZqNxD2R+CK+UNale4qQvJ5EcHfdLQ=;
        b=YygIbnNFmug24FErkWblhqTHNHIaFW8M3plnP94wPu4Auo4T5lrlhQ4j7v19AmZEyH
         N7+P/xfFkhxf1JxtrgX3Sx83icojpu0A8ndeaxOMFHKHeo31Bxkw32vmV2Cv8TQwubpV
         do43EKLXdE9HSaxacIUJV+xPYk1MYBoXXjLkLnh9hFxmU2cbBrtWPfNvS6yppeDDOOep
         dLoivbxjs1zTRk1yR5YGzIyVYdTwk2uYtCM3aRBFEmYlbTlrgoA8A1YsuEf0QB0rKcpG
         kQGUG+Q/9Cr4/m67oTLwD/DNO2GV4Ydt6rqNq319WtIn9mlqx1Qo/akKq0JPC9TXf069
         YOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757498339; x=1758103139;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcj8LHmCHhhzaPZqNxD2R+CK+UNale4qQvJ5EcHfdLQ=;
        b=YhtkzNc2PchHRUCMrssY/Yqt4Snayn5uMzpFEUnz15C1KS3B0r5Mji36uSkLvtzM08
         fFLdq4nhzTeXN45cJWSWk29wUdm4VAjA7il3VOCkv/kc3k8QvglqovVbyqrU2Xk9Nqzr
         +kRO3MnW8+MI0aCLOnZGGRexlz4Wehnt/obkrgYWwp2IOxs0Yerii+3OzTNTPz20J3qa
         ntWfYxkQ8prigiEfe9k4bRe24lhFHN5mW3+BB91UJpWFBt34KWfToiOIxsALmBla2R8B
         dATfzmKpxUXqfeVa4j/3Fwzvef2cOWL9BXBxJzs0k6a0HzYEg0gCMgJhG9tlSIgIrq6p
         S1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVfWBNcwfWTR/KNoPYnLcEJAG1qe5+92RXz1a5qs2ZC72iq6adKs+yRYLS3UZGSBeoQZeHWcnc@vger.kernel.org, AJvYcCVTaq8unD0H99zcfEdbK+FqvNDcp3bfKEHzeiTRv7YkHRiFloui4KjDddzSbkRhpLzvrI7TjRzKY9UpRAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyML7lTurmJCqlE8114KWt4xP0SIFRBY4HoqZpYNI1l+9+nr4V7
	1AOp+ouv8saEwOZ36olRae6F2XcxNb0OfXfWHptzaLbUa33K+cBwTmBC2ET6d2QRELg=
X-Gm-Gg: ASbGncsr7PR3Yr6JFCO2f257gV2lXnIM46BPvm5iZvqQ9WrhdbEDRkJxLGeUSa7E3yt
	HyMyS4y+uh7Pl7vMKHKYym/tfaYmXRW8eKV5MGZJ/ppCIbcT3tFxhjEOKfEauK36WMnAzIh2+VP
	yg5ggHBx9baMNgSFjZdnzS6zYq51pdZIx0UpKg8/gE8ljT9B4e93cZX1U9FtcP1l9FxCOop1eEp
	xph8iGSmgKxN61JE2eJ20rzrX2BfgXTOe3o35wAIvvWQjX3JLeDw8AjJ/uJYFLC19/ldHJ7utDB
	vXcB0xJKNutWNmwmb7qn5XiKZttWqwaoxOmOzEXHfckLWx9JTa7C5SIZ9RaNU1ewGGrug8dUp0w
	l0m/j9XvyD8OauY0lEMH1zK5K58shRCvWweFdAmq7Fv7l
X-Google-Smtp-Source: AGHT+IG1OsKW3uGvrvidR1V/OAfvfZahPy53s3qyGN1V32wVeDsT3Sd+YD+xtJm/ziSYOMAV7t2fTw==
X-Received: by 2002:a5d:5847:0:b0:3e3:921b:65a2 with SMTP id ffacd0b85a97d-3e643556501mr9986581f8f.50.1757498338540;
        Wed, 10 Sep 2025 02:58:58 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca2aesm6390950f8f.26.2025.09.10.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:58:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] tools: ynl: fix errors reported by Ruff
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
Date: Wed, 10 Sep 2025 09:53:11 +0100
Message-ID: <m2wm66y9hk.fsf@gmail.com>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> When looking at the YNL code to add a new feature, my text editor
> automatically executed 'ruff check', and found out at least one
> interesting error: one variable was used while not being defined.
>
> I then decided to fix this error, and all the other ones reported by
> Ruff. After this series, 'ruff check' reports no more errors with
> version 0.12.12.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (8):
>       tools: ynl: fix undefined variable name
>       tools: ynl: avoid bare except
>       tools: ynl: remove assigned but never used variable
>       tools: ynl: remove f-string without any placeholders
>       tools: ynl: remove unused imports
>       tools: ynl: remove unnecessary semicolons
>       tools: ynl: use 'cond is None'
>       tools: ynl: check for membership with 'not in'

The series looks good to me, thanks for the fixes.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

