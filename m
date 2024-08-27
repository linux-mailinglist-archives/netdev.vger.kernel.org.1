Return-Path: <netdev+bounces-122091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BA95FDF4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357EF1C2114C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8211FA4;
	Tue, 27 Aug 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmJAvgxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD8802
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717990; cv=none; b=d0Em8D7jBkHpir7egQ0T3f2icKrlFZ6skOv+lk2gNE4C8JRFcmFz90NWfP6kyVPVJKL20jq9K0DAb5MNg6TzsWIE+G9La8Z2xmmOHBQnR0IogCMbd95MLTNO8pjOsc0Uk4Xc2Fmrt5FIRhjCYYQNQhlkRskDws3VU8cbYjuk3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717990; c=relaxed/simple;
	bh=R3l53Wr2ptzK4XnLlaF4OI27wx0/ZdTKdpB1cm1H3qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSAlB24ojcYfQ7wTMdHARP/BFizqt7jBEi6dgZ/YC8Y89GTqKLGoBRX+87H4Az+YFTyZv0g0VhjuiLT0zHp1YYD7/ArScP/Pm93Vuwgmu2pfrNij5lKPcEnN3vTw3mq0wsjBFnCV+c5c3qbijB5htZmVnIAj7TAidMBv669Nu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmJAvgxv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d2ac2a9d9so16382445ab.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724717988; x=1725322788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3l53Wr2ptzK4XnLlaF4OI27wx0/ZdTKdpB1cm1H3qc=;
        b=EmJAvgxv0dAva4ScVy69o8t4hnOGkNrCfSi/nEhFsPYGurH1bTao+rUe6Rc4hDLqe2
         yvp0iWuH4/GISx7vyjlh2rfZXgbX66K1Ijbp1SkM8kEsHIBZyvLP74EnbAog5g4dppZk
         pQWsUjm3BVo27b/mLcaqaQ1xzXGXR+LTGUTBBt95I8loYJqnUwWrcv2Z2ro0Rjg5YCWi
         JN9Dd1oVST2D2xkZunHB7zwKdyInQ8+JX9EjC6028Th65sZg7m/vA9unuK6IddSGwE8D
         LMFYmoTuqfSahsOCbpRWRdQjN/CjmqAk8rs+gg1hJw3/T7XkSSxwZmGXnytwZwJkmbY5
         n8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717988; x=1725322788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3l53Wr2ptzK4XnLlaF4OI27wx0/ZdTKdpB1cm1H3qc=;
        b=snTwkNbrZWKx7GPowDzpgQk2L0d1udo5tEFQKEgMproUELejtDDonTVg/aSkcBaLqR
         3ZbnIOZc1r/Xq477Y2066s9r0TYsMGiyZrd8vJmPxU8AMk4HsAg2DK/6Ezu98ODwUrWQ
         vatf8u/Jfiq8gYf+UPCSgGBi3WaGxpU3jguvZLfrA8yxLSaKEffQH4fsaqMwVHbX4wQt
         fAa+TBZR65r9tW1k3r+MSBD91/M1MozknTwrXVrRqoxxzEU6tLvYLnLd9mEW/toUGUkf
         RIfGj+MkFzbn1a1m8tR42TA4yGmeuGgXZcrhwRCEZBlnBF+kYsqP/09NNE/jNr23cxHW
         5kmA==
X-Gm-Message-State: AOJu0YwMZsZ8HNpay6gnNeIy7fV4PH+gAU+0897BKpG5cLClp1TzmUzN
	qB20vXlxoiFIRg3fTyGzTQQC6ZI+aM7zCxPzQNAdqxUjOqOdqyS3bZrKJCl5OrfDZIrTL7WEbTP
	mOxzmM4EJP8qU1Nps2xgz0CU9iiI=
X-Google-Smtp-Source: AGHT+IF796SWI2z6PeMnzvlHp1WhY/Dcyx3JuLIZyWyBGUbhWLQPtCCZEOBK99dTRBqbq46iAVoBN5kGS0JXanDpoI4=
X-Received: by 2002:a05:6e02:144e:b0:39d:4c8a:36f9 with SMTP id
 e9e14a558f8ab-39e63e11d58mr17297595ab.9.1724717987976; Mon, 26 Aug 2024
 17:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826194932.420992-1-jmaloy@redhat.com> <20240826194932.420992-3-jmaloy@redhat.com>
In-Reply-To: <20240826194932.420992-3-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 08:19:12 +0800
Message-ID: <CAL+tcoA-Zc7Jh8rDh=X6ygaZiynUrZkUS=CUsd6C2ghZT3LMEQ@mail.gmail.com>
Subject: Re: [net-next, v2 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:50=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> We add a selftest to check that the new feature added in
> commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> works correctly.
>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

