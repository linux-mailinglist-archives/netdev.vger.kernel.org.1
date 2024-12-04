Return-Path: <netdev+bounces-148834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD009E340C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D98B23AE0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD948189B80;
	Wed,  4 Dec 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfEyJ6mS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A80184
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296932; cv=none; b=on1We0WerEoPNREY6cT4Wd5tHNBd2L0tnCCZXTLrnfoEziVzTfo7Ch+g+opE/8Nnw7ULnk9NljoJTpx3XMKRSpv/oNsxE2+TdfG5Ci2yeyAnwkzDTUK0BXsAkXX6yP0iM31CM96tMh1ZVnl5bNi1mg3k9St5VuO97ONXE8+GPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296932; c=relaxed/simple;
	bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqL0SDvq1KGAlWSaia4lV/V5RDgkzb7lDEan/4B0DAMlTuwbDXYUu0X0a3y1HDSN07p797379yhs49g9931EbEnoOwZ8llHIhDUGJCAl1+2hBJ3Zj7TkgVLmqHmfq/n4ipVp4bb6fReJFyMI5jzv4Ho86pYHIVOR4WMTe1qdDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfEyJ6mS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5500f7a75so988413566b.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733296929; x=1733901729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
        b=YfEyJ6mSnMpcZgTi3LviBmukSlOMQBJ9Oyl8c8tH6NsQfFSHytPgoyiSyDAQHSOb6J
         0l8PuCE6TW6FMGaWLlcwo5xnCCyPgxIFaRdqX3ZUTUQ+GhASXQdgwawGfqetxg9Yed+I
         FAchfJG9mOScwwrvtJyraVRyW/ZZrKxRk4psPM7DGL0riww1XPdNqZBNGV1ZxVUXppTE
         riZ6h6ZIHSBjss8vg4CEiBQST0iWWd0DuSop/LcvhvcKH0WBCKQyacQTQCAqpR9ruWa+
         ueupr5pLvHLc0f1iz1bYupDs6XN2yNNqk4sYFFHE+9wNOWVflGECcSi+6sE89ibA0sv5
         gOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296929; x=1733901729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
        b=ZVKHk9KnF+4V7lAm/i+gU0rmOwuANmQRsJhymdwXo8K41rgul5KrqBtRyKBe5xeAwc
         IKPEAAb0dS8W8+DxOszfRffr0OOJy+lXQ6ms50poxp4+WRxKcXU2YG39NC1m2v0aYq2r
         WzH34vlBgTXpqlBRa9igGGgXTy/gi3tS2FohOK9NBHGRFS0cHLseIkppetE4gRvKO7yG
         r5hVjWxcPsRAlsTXMJ9h7CE9XHZKlMd5y3ktxZ+qIg7WAyn/xBOyFhJHosw2WVdEnY08
         mpYo9b7wbAao7CfNoblJPfBOZnrRP+nnFp02qCb+m9yeoDl810vOIgy7rLIiPyt1qNk/
         dwHg==
X-Forwarded-Encrypted: i=1; AJvYcCWOehr+eHq8lZjJpKCgm/7DNoCgm4Vb+N7UMd1rReLw/lEvb2Jcv+21g2Xz/ER8xd2+Ei2MmCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkI+i9YIEV/t30Ev3VysPR+xT1CQZg7kTkwoK6SXeGzeItp2e
	ArVWhPC0Bo7TAU6xXKB2ZbFtFpJD+3Bpy4m8ZdNK6eqZ2ytPczxicWXBM+CnU6hq+OMioBwHeFc
	1VchzsYwpzcJgy5mi9qBAnJX2RIEZZtvyHmAE
X-Gm-Gg: ASbGnct7+2Osx0wTOQ0t7z7ho7N0ULAL/qAn9Z9C2N/wJ13S0FDNRMk8j8GAXFyN2MG
	xuFAytMZWL92N9j9bQ+VelTlRIIJd4rES
X-Google-Smtp-Source: AGHT+IGpBZTnGtesgrcNut3ToABnK+WsP7f7dWn5y/MoNcxEFWzGR5oaAQN5TfGpP+ylTh82Dl/3tpxaVRPRfDGpbp8=
X-Received: by 2002:a17:907:7758:b0:aa5:3f53:ad53 with SMTP id
 a640c23a62f3a-aa5f7d8d1dfmr405251466b.26.1733296929224; Tue, 03 Dec 2024
 23:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1733279773-32536-1-git-send-email-mengensun@tencent.com>
In-Reply-To: <1733279773-32536-1-git-send-email-mengensun@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:21:58 +0100
Message-ID: <CANn89i+ZtxW1HoiZaA2hB4r4+QBbif=biG6tQ1Fc2jHFPWH8Sw@mail.gmail.com>
Subject: Re: [PATCH] tcp: replace head->tstamp with head->skb_mstamp_ns in tcp_tso_should_defer()
To: mengensun88@gmail.com
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuehongwu@tencent.com, 
	MengEn Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:36=E2=80=AFAM <mengensun88@gmail.com> wrote:
>
> From: MengEn Sun <mengensun@tencent.com>
>
> The tstamp field of sk_buff is intended to implement SO_TIMESTAMP*.
> However, the skb in the RTX queue does not have this field set.
> Using this field in tcp_tso_should_defer() can confuse readers of
> the code.
>
> Therefore, in this function, we replace tstamp with skb_mstamp_ns
> to obtain the timestamp of when a packet is sent.
>

I do not see why this patch would be needed, we have many places in
TCP using skb->tstamp just fine.

Do not be confused by unions, this would be my advice :)

