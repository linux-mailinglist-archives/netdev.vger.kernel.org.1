Return-Path: <netdev+bounces-68591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB084751B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E132F1C22552
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E31474C6;
	Fri,  2 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaqUYCGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EFC2D7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892071; cv=none; b=bogJSbHOm274ontwK8sOKpvysaMYM8CzKrinECQd4/VuZQ8TPGckfYIgkGoQSKjOJnh+L8QiStFhtalniJdC/1vOhz0vTGcAZ4ItNj8p6TpER0BTJpEquMGpXHYyAdL/CH/IJ/vqg6uLthRDeyzAph2NOPOsEOFRcPVng4Er4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892071; c=relaxed/simple;
	bh=WpKtZ9QduT5Xjc1NFegAnt1T+eUqnc5LkyBex0C+S78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9x4c8/jwoGIXNQ9GFPyysxAjHf7E5Lrncl10ny9ffccbKVi4KH1x5NA/93s2aQEkn+EI9pOlJdkjtDxpp/qS66NcaGmKmzYQmXUK1OYeBmST5XAleuBTh/B0Ei70a/QnMz8RKI+QAFcE/h2EQNKz1NxDNWenffT/yruVC/Ra2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaqUYCGx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56003a3ee09so7233a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706892064; x=1707496864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpKtZ9QduT5Xjc1NFegAnt1T+eUqnc5LkyBex0C+S78=;
        b=DaqUYCGxzEycHW4reI97x17NNOeJu4ggI3rOu1jROAT7mDGc3KuHbA696Uys5sTXox
         2rAwPT+pV64xw24NxuaYg5zZPw+h3PtaNk0YdFH9YPiwFrg0+yEaz0MWoMmg0IucinHv
         WkdDxsjb21OPM5WkNn/qZWNqmexerj4auy5usqph7oiIAECSHSyi7naGFzvTO8SzNiBE
         S+/FgW4L0FVY5WcqHq15MSFTCp7Tavit9Q3zm6XqO9Tzzm9JcPm56f/11otPem3lB8+2
         YbtekpEmu2/Iy2wlmOANVXj30NjGCdoqYIcFG3dD2w0SSKOIycpg9VKJK6gE7TiH2h3G
         035Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892064; x=1707496864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpKtZ9QduT5Xjc1NFegAnt1T+eUqnc5LkyBex0C+S78=;
        b=u9w89E7ZqTsaXr6mhz+P0XTSUJSke8j+PMLArL4eA2r4vwUhhrHb8gPSoNB3ecgqK1
         HalQRu1zOmNA0wOAGwCwYGHmR0HJ/hv9zgT18wxri5jkZg5RZefvG5dFxgGflPIr235Y
         iDgm2VH/lJtgZBD3NN68rwyvJ+sq4oY8m8lkZz7iZmizJyCb/kaGRVrA+0Spkt35O6Bi
         eVTUrrnhIJ36zmbu9CN4KPIb9QrRlSDRBhl+veTHe+XCjErvZEabD/maHK4++9BkLKe7
         yNAseZ9nIxxZgeYkBQVtHPHzVTYuoAkVa4Ihn2Inljr6sErKzWtRP3c4tRcGjeYJqr6g
         xLVw==
X-Gm-Message-State: AOJu0YwWIG6DXr8adrZ4XA6S8uBgala3uizN1m2TGML7GO7tx2jYX5lG
	0CbrkVxAbuxtzUpTNq73fFvm9aBgANPr0k/G9jDUlVb1cD+F3TvlohLnV3RVabFQ7mKkFew14yY
	6ymSjUEUaOvLPAjrWzBMHADBjhjCq9Ey+Guyq
X-Google-Smtp-Source: AGHT+IHFvqk/DPFjz4/dCzlc2C0RinJaGR40G1yG/+gBIt/s1BNF1c/qUaBl4yuYqIcYxQ0vaBF30u4luErkISLkFjw=
X-Received: by 2002:a50:9ea6:0:b0:55f:88de:bb03 with SMTP id
 a35-20020a509ea6000000b0055f88debb03mr36586edf.4.1706892063320; Fri, 02 Feb
 2024 08:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202163746.2489150-1-bigeasy@linutronix.de>
In-Reply-To: <20240202163746.2489150-1-bigeasy@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 17:40:49 +0100
Message-ID: <CANn89i+Hygyq1104Ks3KT-ARNWvdQsKAG1Yg9Ug4nx+Y40SXsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dst: Make dst_destroy() static and return void.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:37=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Since commit 52df157f17e56 ("xfrm: take refcnt of dst when creating
> struct xfrm_dst bundle") dst_destroy() returns only NULL and no caller
> cares about the return value.
> There are no in in-tree users of dst_destroy() outside of the file.
>
> Make dst_destroy() static and return void.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This seems legit, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

