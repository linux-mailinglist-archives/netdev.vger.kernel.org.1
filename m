Return-Path: <netdev+bounces-83199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E898289153D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772311F2264A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568551CFAD;
	Fri, 29 Mar 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shhQn3kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BF1EB4B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702195; cv=none; b=tctzqwXtEXiAo+S0O0BR9z6gHa0cX5qJ2UQg8zvsNmBExRaN+qbJUNgyZxpF9pp42yu+oGRSOJvu0GlbYtMnQ49hWPpYQN0oumcsPONA0BX+3DdRj7Y7P3fIzJSqn/2W2UYW48sq6o5bRl5jmvAm7V3627Eju5nOkPWhUuFCUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702195; c=relaxed/simple;
	bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhCRbxF/tQTPch+1SQolP21Ygzhzs0vNoPyolqpxXy/es1/zPs2COl/1s3v2engVHB4W5zuMYaOMIq8GD4kiapaZ+ja3QaEn3HM8fCkoMsAASmuhFW2oi0hFPsc44QBpbeD219lpIty1jiXc5zVBUCfsQlB6bWYbpwOuwpm5VrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shhQn3kq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso43805e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711702192; x=1712306992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
        b=shhQn3kqIunEkIRty6KgzC0ZnVH+h0+7aA1fSbTfsjGZEEihVkv5WqNSs5UgBtHtlY
         XGnQOvkTFkM9gtCaEg87d0EwfTrgjRqsIBM9Sr5deJPzkH0YvPU4lp2JIIrzwGHaD+WL
         AEEAllMwVgGHbTtvjjMOUFHxSu6bmFPHbSPlHSxVpi2XFHbPeGvshTXKu/z3PzQeMUVN
         f/zs3waC5jVEV96tTbS7DJSDAo9kNmFLN6CRSQlaBSHPFQV+71g7+1zgV5AiTVl/+aCZ
         MqdDWWJgbP0QZpKEacZTeQgXSsPU47dIy8MBKkzKcCNdmAXu9f1Ute6eq1qCMrxPe9JM
         qgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711702192; x=1712306992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
        b=s+tiA3rMi+vLON8vyTvm7VcLI0laa0+Rd+1P6y8xwKlC3jCPOSig02OBHxgVJte60j
         tjpWnyma6pcRj8v4Ch0EZbihSnPpBBHqu/N4wI1xJFavjzkL7NMoRHbdIf44aLA2GueT
         t0SjpVp2l4qlQ/Ij/hXNXExLGXJVIk5dRuaNXByRBfAUMYJVTm8vBKm76jRXrp1i87mf
         7JJzL0locbu7E5e63FdA1u160peVgt5ospI6We/sC9OjGOSNdxxGpuKskFtcLm0rQn6I
         U802Qmq8FlwB+D9a7ArTNRIERISPfYrlSmG2b49j3DaL6kfwJsyxNmVgFae2HmKK9yqW
         ZZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCURiKHm30iYVAhFzZe3Rl/aA6uvXM2TpwI7YV/KXEOP05XR1EBQGbfQZc9xAKZkhDYfEP8P9ENF26mPaXqIH0QQAwparPyh
X-Gm-Message-State: AOJu0Ywt10oK1TBh4xvuIb9ju1X4DtkHYIMdYT8hCbId0vb6M4iPki7H
	h1hPWahRYj9NPbQ7GmHvEVTlNYLz1mNw3GzHfz9rWrhH8jw8NQlT2nisDO/5MaLIj8lVtklowu3
	/G0bDJ/lakO2teqjoQPyIf6fHIWrbHVSgvwjF
X-Google-Smtp-Source: AGHT+IHYD/9+DvCGCINj0BByAQNTV4lM4E97uy60WOhJb7WslP2bDB1AAT/D0KgrBzt0PXsxBlUXnqcDhBc5WzRch/Y=
X-Received: by 2002:a05:600c:1c99:b0:414:daa3:c192 with SMTP id
 k25-20020a05600c1c9900b00414daa3c192mr150324wms.0.1711702192012; Fri, 29 Mar
 2024 01:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com> <20240329034243.7929-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240329034243.7929-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 09:49:33 +0100
Message-ID: <CANn89i+Z-C1ZDOtd+R4yDwDF_rX2cPDCaJqw8Wi4L_t8ACPCWw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing entry_saddr and entry_daddr parameters in this macro
> for later use can help us record the reverse 4-tuple by analyzing
> the 4-tuple of the incoming skb when receiving.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

