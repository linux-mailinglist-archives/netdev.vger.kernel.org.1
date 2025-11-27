Return-Path: <netdev+bounces-242341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58AC8F73A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8FC3A46A4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41259313266;
	Thu, 27 Nov 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHQhDZQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A32C08BC
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259835; cv=none; b=NUCkgY06ATzCVq83+fbb47/QYq+2x5jdAJu3k3icg0dAmIRxr5eKDrTHABCVTc2r0meUxMeekz0Qd+dnEW3/RPTDAXDJiXFKNJg28IGo9zxh3KpgXOJDzOC6mzZnLHh59m4Dxe0zP8tMP7rZwKSVD5gyDAeSTvQO/djO5S25x/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259835; c=relaxed/simple;
	bh=a5an8ozGWSOjBJSkQdjpAKQ1idZvnmXJvho+XCALpC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwgcHFY064GncD+7Hroo121Ukb1AOQxfLG6zW8+aF8BMNdkxw+Y9Wbu4pAQktQ9bxdKoeKEzITeCwfzsKFlLIvM+P1GfxybR8OrwhEuZ2WYccEwiAEgMS5ql5dNEH1pZ/p3LAjOKPg4xFLyNAHcsgGUY65vdtxASblX/mllD+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHQhDZQz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee2014c228so8255041cf.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764259832; x=1764864632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5an8ozGWSOjBJSkQdjpAKQ1idZvnmXJvho+XCALpC0=;
        b=uHQhDZQz7ARXb+G6hEwOAPRkbiMEV7rXhnNHKyZ7tr9gMBEnbJtHuio4pVwgrMIAPk
         y7QQvgtcgp+f/Alp8BuOEy+Vtc1RUOsCAm66uYky7HCO1xVXqsUiAPa+O6CtGT8mGCC9
         RuDV/cQSt7bHLHi1XTKHiWb4JO7cFzK9G4l382/j2sjUJrnQTkwYGtujyqKK+D0g42jL
         YgaoWbx6MAsRTOzPms2ZbtdetWArvQywZkviruK6jEvj8g8zL4RsoT0p7Gnv8+jt4wL8
         NxrdV1V+yiRKUi2ot63CoUxATlW7il4t+LVUXGS677y1y3CWH1lqJDKAq+ABIGiYWwF/
         cJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259832; x=1764864632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5an8ozGWSOjBJSkQdjpAKQ1idZvnmXJvho+XCALpC0=;
        b=XCq74dCpnZ6U5ajpqHRAOlDitidsMDEuYPHA22/ntW3KgTZRitNfhYwdCJaQRHyywe
         8El3om9xtrrCC1AsepsR8d4cG6sZFc8m9Isd1iqA7OQXJuF/FppkWiiZpf0nzaAm8yXe
         wHWgiQxx4TMPT8dUFpbvyOETScBJphB4Qf1bLLqPpFo76U/ORtSy/mxMDAFYD6UVA4HJ
         lMNUGdTVDtgzF0j6QzJiC8TYJDYADXc3LiCtom3QdePpoya1dTS2T6JrQRkaD3uiwP2S
         LzCSVgm63h2OIy+3mARRRFIsYuo1iMX7fqRW/cep3TXoc+MwS8/qtLaGS7YBv66dLdnQ
         eMVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7LFg2bJjeB4qTU1oP5PSuas2yRjgPq984YCsHFvzzCsE1rTR5Dvxin3vIoiGAL4F/WkZSsvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlMd7GJ2qHr6QIARXI1Jmd6EsgsWSxeL5cl2DrnyxLmQJTP8m
	3aPr0Kp1Q4J6tFe8ZhGnwVpg9xEziAVRieFWW4mhlYWu7dRIXdA/8079pWj2EXmsIQ5hujFY4z3
	3G8I4leRWaElQOGsQSd7Licn0PICDQuHWy50xpswb
X-Gm-Gg: ASbGncsSRlnebKZWmRy2GVAMDMmibXepK6eMcHch20lV88k6lanTBJ7xv7D99IgIyu9
	yNbBYbgRxysA3xMQKKKj6lzvUITyiZrTZiYPqQsqM//pVNlyhq3Fy3CGbI5DCzLc9h19Ycz1fan
	/KcwSbKzx1FeVaMj7VqXhYQei+AUbWzDcoOFp6Ch7FJ47ND5YaIrwcd6ltCOXH2EFT7vLxm8daL
	Q0B+tvB+L80mJQZAiaQhWZTI1vSpYqP2pUPD5lNYpB5IKCzXUrScwYOCvjYWlYK7pQ9YZM=
X-Google-Smtp-Source: AGHT+IHraxA6Atl7391lemmLh3uYxBLpmj1BhaKoxRTZmVQWMkrI/+JCS6nS33o+ypOkVXfLz63S3+26lDKL0IfmDRw=
X-Received: by 2002:ac8:570e:0:b0:4ee:146f:2503 with SMTP id
 d75a77b69052e-4efbd90da52mr157445021cf.3.1764259832066; Thu, 27 Nov 2025
 08:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127014311.2145827-1-kuba@kernel.org>
In-Reply-To: <20251127014311.2145827-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Nov 2025 08:10:19 -0800
X-Gm-Features: AWmQ_bnf-7rfIA7nx4QQdDR68Y7bkyyG8AFUEl2huKREhGOyVbTVMDRpAzbINis
Message-ID: <CANn89i+MBWPK5xrxht4Ot-i6pP-OfNtStG8_nMXvjRzf-Vhukg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: restore napi_consume_skb()'s NULL-handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> added a skb->cpu check to napi_consume_skb(), before the point where
> napi_consume_skb() validated skb is not NULL.
>
> Add an explicit check to the early exit condition.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

