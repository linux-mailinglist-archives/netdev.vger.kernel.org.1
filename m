Return-Path: <netdev+bounces-87530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57A8A36AA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617D01F25A0F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE451509A5;
	Fri, 12 Apr 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFO3sae4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B814EC4E
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951996; cv=none; b=IdxP1zrnmtcKtlcDiodjgQkD6NkE/3GxdFg42Wg6bF4HsqF2/KmTb8bWXlRK/P4dlj5wOMPszYk3l4sVbC6RejT/ClBRoDZVo1HpvBABTsXBhli10CGwfBpBt5dzRWW0R68TGWl2QpAiXMfB3pjLQ/Sc0J7TxqdXF2NaMO85lZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951996; c=relaxed/simple;
	bh=36OsBtzi8touilTyPMVCVeWyHaAC35RPhFw91LknUmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfIK2faAwLoU8jcYZ88Uo8EE0kewo4nUYozqk5ojIDqQmk3YOnvx6UlAZr94eRsWLtFw5yiQ6yco7H83VS5oQtDi0+WJeT+b1OmZ5O9Fj5J/DaOuf9FSC1fTuD7o75vasV4hOl9ayFbeVjFF1DJORXrqWPft/U3ZUCvIrCOFgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFO3sae4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6962950c6bfso9205156d6.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712951994; x=1713556794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPQz4q6QEnMsxEgXrxtOlOJIEb7W/IfVxZZ4u95+bqo=;
        b=YFO3sae4HNlgkYsTfIyaRrIatrclSzO4FQLhdyiQO4+wICgoVNpzS1VqSsZZynBOIL
         F04xY8YNmW8bsRtEee9u6ElYlb1vGmat2/CwMfwufEykfitqe6fc9opX6Wn/NsYv/K++
         x2WGV5HQAdQHiVGi1hvoccV8LKYBB+2fI0vh1MKK3vdT/9rTuh0h0kOw+Y8KsmHF1UaH
         1OrKxstmrq/URumxrpEAzroFANst5Rd/4UdeUtIP6PtJw4Ire9be85ctps/y+tMLafyz
         pnZMrAN884DhjpS8npBvrWJyxg/Dx0zavKUsNj2t6zpSQ8Y4gJ904//t7GeJxhe2jI2p
         OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951994; x=1713556794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPQz4q6QEnMsxEgXrxtOlOJIEb7W/IfVxZZ4u95+bqo=;
        b=k6SSpGxE6S/ZPmpJiBKIDh2vU3L8kbThm5FqUePNXQraNCC+FlwyFaFOEUkRdGYbvY
         iNzXAvjZZFQwNEct4aTG36aR+L3LXXfEJO4OLNSpQ0DgSEQ6zmrygu/WzNtvSjDMakqB
         Q3CSQ46IMJTnuXF8HthcpL0tehQ1umXBldvQNF/I4Ad0rl11hCJm1e3Z28jBFMuVsugP
         hnkbbBAqTS7CYWimoJJ6BnIVjvhFCljABBgOwgkaw4AMVSoh9TELAQAyAKAeOEo35mBT
         /D6Dhph0dkU0/tL72t6YycXelB6n9n1m5hc5woRncoHlffROxsWxbryA9yv/axcf272D
         D9Xg==
X-Gm-Message-State: AOJu0YyRsuUvGA3QnXn7/7I9n29xJgs1WCZknD8GWAT0dA87TJBmVEMH
	OfxCGshmrgXrDIB6+vTJgRPRjH0A2683yIXdfbLgSfGMACSs5OCF1JISxAsYIDUhl/h5F8W3MYa
	Mc+fKR+sDFf4Kw4idH7BuVtvZjEfA81FZQwji
X-Google-Smtp-Source: AGHT+IGeK6dgxqFFgjk4xeptvd+7a1JVOXy1GhRKD0oaMUJXxGZcYPZIaApdK65tlnPduDc4wy1hnWEc/ndpj12FbN4=
X-Received: by 2002:a05:6214:2a1:b0:69b:1f8d:300b with SMTP id
 m1-20020a05621402a100b0069b1f8d300bmr4083789qvv.30.1712951994075; Fri, 12 Apr
 2024 12:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412053245.3328123-1-jfraker@google.com> <661953c285139_38e2532941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <661953c285139_38e2532941f@willemb.c.googlers.com.notmuch>
From: John Fraker <jfraker@google.com>
Date: Fri, 12 Apr 2024 12:59:42 -0700
Message-ID: <CAGH0z2Hp_tXb1dBUDDbWn8J4VG4E9COBkYdWT3HB2NAHB4tXVA@mail.gmail.com>
Subject: Re: [PATCH net-next 12] gve: Correctly report software timestamping capabilities
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shailend Chand <shailend@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jeroen de Borst <jeroendb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:31=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> John Fraker wrote:
> > gve has supported software timestamp generation since its inception,
> > but has not advertised that support via ethtool. This patch correctly
> > advertises that support.
> >
> > Signed-off-by: John Fraker <jfraker@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thank you

> > ---
> > v2: Used ethtool_op_get_ts_info instead of our own implementation, as
> >     suggested by Jakub
>
> FYI: the subject says "net-next 12", not "net-next v2"
>
Sorry about that!

I made two rookie mistakes haha. Sending the patch late at night, and
not re-doing my test email after editing.

