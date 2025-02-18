Return-Path: <netdev+bounces-167359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217EA39E71
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF587A1DC0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34D269D08;
	Tue, 18 Feb 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTboO4dl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91B2417E6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888102; cv=none; b=LbAXu0bpso0LF5WfFy2fysjHysonOMHQaeyIi2YhEUIz4dcNiUre1y+IDpkjdD21VPRYT76wVTU8hm3ZaZgrpXAJmRryAntESMRA9KTQss3uY/Q2y5+KB7BYjAmhwJqn/Dr2aWZ4dsmyx8dLMpmBn0ui7PmyCLIOG4MgfoWX43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888102; c=relaxed/simple;
	bh=p8xXLBvIDMk1WwncpnvUBDq4dnNlRb8PfLWqdoBja08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PImTlGlsJwwmu46y6ZhiMs6Aglre13JCP+xk2ddQDNiAsNbn9yHtJ2e/2PSPqviee7WJn2+ihaCjztOXGUX7y/aCAB47MlmynikujBeCxZ3PaS/sgQBjwAHM0XMxEKxDqtkTa6DtMyCcnSWIRZPQNSWxeKKABFqd0LK5FCvDQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTboO4dl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f1dd5b80so430841cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739888100; x=1740492900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyNB5Rb9k2bacI7hUobJrk06eCRRlLMsBkMeJQRCKV4=;
        b=YTboO4dlgDQ4pGcwkNz63k9s4Cg250UrrnBc0Y1xaGD7Xihlt/YPfSbIll0zVfczIR
         3BLj4l/NoACbvynRNbuqHxVFUIMz8e38k552dWyxBnOy9wTPP75Pm98IYh05PP8SASpK
         sfZ5jy/aJfB2Zb0ynEwFJ49juzPLwoY3n8N9uZs/ZlaMcTBYG1cz1RcUeqGaCIDUN9dx
         w0SLvdIKwutKF5wuAI57/NNF9GGiPiZZ8wSM0l5Jg5cihmAtNwrRSiVeh5AI/8MYmjZW
         heLc3wcHauF88mrl6OX8oHz4Aq2iUFPNYcloNcqEWVDUAoKNB3eS7GLV41fhGkDZ8Kdv
         JDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888100; x=1740492900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyNB5Rb9k2bacI7hUobJrk06eCRRlLMsBkMeJQRCKV4=;
        b=TPyWEmcJUuujmlzV23TzmQ1gYlugnf9ka2brO7hkgIA/3bIQlztSxGrH+/fFEjtyb0
         sM8M1oMnt4IVmYkAMXfs+lab6Pl96KVdt8El//A+C0L3BbIQLmBgej7AYNrr9S7gpjSO
         BQu9ZFS3GbTfhqMIgK9sdZi6CWuUp7f4Ck0FBV+N6JpCperutRRQHtsXXyZw/LggJ8WQ
         A9EBY2lA/DwfrvWSruZRqbcNqwyu/AFV9gcum1+NIVv8BU03+p8G71n0v8Ou9GcCTqm3
         IeJeS4QzYkawL9mGXY9l2pIoIOw6ojqeN11658oBrPp2cwJ/cdSwDMRNcDCB844q96mn
         yVVw==
X-Forwarded-Encrypted: i=1; AJvYcCUO3olXOa9LeO8lERunhEwKpNR8vTi0DiBoQT1NQNomZXs6OBYR0MmLXq5gUzZzPm5wbMb6g6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxme72MfjuARpqo2B7hLRFN8sPH+a90F00PmCjhWTeE6S0F8PyQ
	VQPuD3FRtJh7UvSSudgsyQfYUlxvWe5co6RwTNzylMAVDzU8GH2pkQ1fQ7MuzDQif2gkRU2lApf
	84SyQUKK6RRo2w3IZUrJZyEYoaTfZNjzRBrI/
X-Gm-Gg: ASbGnctkA9+HaYxOJlYgWUGFOxw9xyaL3BdUW1Isc5DRjA9R1PCvWjLG7f1QnJQi7bp
	2wHcSGmICKpMivQvYEFpeeJ48iMA/WOv+2178ryw/TkFgOheLtDxBcf51xB1Wzi1qTCkYK65R7x
	HmPh5ZliL+xpKAufbHGMeILZSDZ9Fs1A==
X-Google-Smtp-Source: AGHT+IEzDwdPDCudjH2I/zheSxnv0Lkd67jFQ482X1N0wKqqAoDM5BxML+hX6PyaAsKx+L9u/YK2O/8pmD6ekOi59o8=
X-Received: by 2002:a05:622a:148c:b0:466:a11c:cad2 with SMTP id
 d75a77b69052e-471de09a9cdmr10287431cf.7.1739888099547; Tue, 18 Feb 2025
 06:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217232905.3162187-1-kuba@kernel.org>
In-Reply-To: <20250217232905.3162187-1-kuba@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 18 Feb 2025 09:14:43 -0500
X-Gm-Features: AWEUYZn78Nl4rrkGfoHIxYm3crlqLtH3-iIb3JVn3XVSdhcCcYFQtH2xEnxx914
Message-ID: <CADVnQyna=PzFHCrJjfUsiwBn8gYg6oFxPyHhcv4UAzaCgbobsQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: adjust rcvq_space after updating scaling ratio
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, kuniyu@amazon.com, 
	hli@netflix.com, quic_stranche@quicinc.com, quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Since commit under Fixes we set the window clamp in accordance
> to newly measured rcvbuf scaling_ratio. If the scaling_ratio
> decreased significantly we may put ourselves in a situation
> where windows become smaller than rcvq_space, preventing
> tcp_rcv_space_adjust() from increasing rcvbuf.
>
> The significant decrease of scaling_ratio is far more likely
> since commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio")=
,
> which increased the "default" scaling ratio from ~30% to 50%.
>
> Hitting the bad condition depends a lot on TCP tuning, and
> drivers at play. One of Meta's workloads hits it reliably
> under following conditions:
>  - default rcvbuf of 125k
>  - sender MTU 1500, receiver MTU 5000
>  - driver settles on scaling_ratio of 78 for the config above.
> Initial rcvq_space gets calculated as TCP_INIT_CWND * tp->advmss
> (10 * 5k =3D 50k). Once we find out the true scaling ratio and
> MSS we clamp the windows to 38k. Triggering the condition also
> depends on the message sequence of this workload. I can't repro
> the problem with simple iperf or TCP_RR-style tests.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Jakub!

neal

