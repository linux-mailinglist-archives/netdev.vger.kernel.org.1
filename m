Return-Path: <netdev+bounces-239000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEFC61F7E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 01:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459CC4E1B3B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4F15A864;
	Mon, 17 Nov 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2gsXqrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1D1A7264
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340493; cv=none; b=ZWZuePx1aahilV8tvzqk/M95mNrh9glw77FVRBhZ8pr4KYMR0rC3aWbHaWE+8Xc00ms5aRpT06Yke0MMbKSifYi64tzgVdeC8WNJNrvTnNzrciLQu4Xj3T9OXtFqWR1kpQtox1QioCQi8UxcN4D0VC5D4NfLOzcAqG72GZnb/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340493; c=relaxed/simple;
	bh=57f4vbGKeDhzTa+WuxVakMqEfRrCwEmh5HcUizAjlFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk/XhAcpkumPbCvjVuo0aviZrvmK12xUfhFVQcbiDpPNi39o5ktcCtZgaZm/Te9Km1ttjWv9WcMa4RZ9ICPLIAtrYqgsdgEZoQHwUXVREGgJyTs4n5xGBpUUiF3QZYC0J64A4a+ytNLhkfpqPcb5zsjsBmxxf/YIdjwu5R2sjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2gsXqrX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-433791d45f5so37302495ab.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763340491; x=1763945291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57f4vbGKeDhzTa+WuxVakMqEfRrCwEmh5HcUizAjlFI=;
        b=I2gsXqrXrK+9uKUcxEnZg7IHQyj+lH9wNA12KNQ4rsvs4IHnUEFuUx+abFvvHfVumI
         gAvxpeYG11SRWLVmSfvTPxIaVJ0ZsnK+xbrl+bRRRcoOjSvGj1ya0FAM8TKUjh29fk1Y
         xtKo4LBVHYqDJ6Mx9mUsiYT3R34UdZBR9ugVp6QC6w7k6iFPPqYb+yg+mMHey90vDXVC
         44cS38oTVXD6xRShWkGvHf8tS3hxccRbjga3kfJZlT8CkeCzrzNOjccbkCn5PzOuj2Xq
         VsbJXon2KmIaFNhdgQn3c+sKSAyEQGYkC+/esMMuSe9X7LCArSPVlczA9AecU79x/AYH
         pQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763340491; x=1763945291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57f4vbGKeDhzTa+WuxVakMqEfRrCwEmh5HcUizAjlFI=;
        b=q+S+QcQ/Ko7QJlmemKYDzR4V2e/IGgEEH0f4+pws6mHLH2TuFHbQ7JMzp3d2GmFiXw
         5qVuFRhHV1MPWtDoJHAXf9wnF2y7LSmSyurfiMlHKtOqAQ7K3FvRFIDqdRwQROOvOOLl
         9e10mC39loRxY+kJLYCTt19p8t+4m30CTG8ad+3lOKSYAyvffXDCX0wb8nheJcNs0ezb
         5D+jrgf9DNsowZ7d5TOOhxZNChPjxamLcmkVJexviAYF6v6Fcht3dY4mVE2MCiCBdGB6
         wYwW4R+LLQKGvAgoptZvPfOOxxxjnjXeXzuPv9rFzqYnVR5kx+wn7/B2+mYyTel8lWNF
         omBw==
X-Forwarded-Encrypted: i=1; AJvYcCXZJaSiO37HNXM7hG+OBPu/UWI6kSiyEIlkeYg3RUU64Wue9rmVXe2Xx6mrEL1VjJtd/22jgBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEgg4260xASAunGUd9ll0LSVBitV2BXK0VaaMYxeOX8ojsZk8
	0hjRZNrE4OUZdYMjaNjJpKwdMoQO2HnaBnlIkOJGApz6VLOKcKlWiUe2paomRgYwzF9yZ/VqEXW
	K3eTscAkAXlI7pQ7JtfOWHa6boribQDw=
X-Gm-Gg: ASbGncumF77K6JI+9yiUOwHwnIL6bzM4BAOghgCV2doJbeVtBSodAlXcDdIL20flSdU
	vSZ6oSCCjEEIVYxWQipgbDxX2P6Lxtnw307X7KbGxYUIXzyJnft710YZ875e17G6v4m1QNSQkRJ
	VN//mW7W5jgMNFyrayDbLNbCCs1tbQF4Bo3zxlFG4NtvTHNYXW3UP9qnWPSWNSfuZCDqD8lU1o+
	F33MXRfd+lwPJGK/f6Yu1e6jxWWmRAV1Orhr8vXKA2y2O+bSgGGsUtOQKjnSRUxSeM6YxyT93fB
	1Ake
X-Google-Smtp-Source: AGHT+IEbORLEknoVjPgsW0IsZX2a0TJLRd33fiWei3RJkMp+nnCfVvI0tQsyogBSSxMAZWxwPswQcJF0d8iSI1uajrI=
X-Received: by 2002:a05:6e02:1a41:b0:434:6f6a:fb99 with SMTP id
 e9e14a558f8ab-4348c8fe9b3mr144239825ab.21.1763340490700; Sun, 16 Nov 2025
 16:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-2-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 08:47:34 +0800
X-Gm-Features: AWmQ_blUnQ8iENt_WcX0fFK4OfwpvHbF3lS2hHYRDwKtcDXu0ysUT87JFBclHXM
Message-ID: <CAL+tcoD9WXdzG+7GQyy=Lmbfo2oZUC_CL2eUptUP083JZdRdZQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] net: add a new @alloc parameter to napi_skb_cache_get()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We want to be able in the series last patch to get an skb from
> napi_skb_cache from process context, if there is one available.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

