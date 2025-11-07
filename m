Return-Path: <netdev+bounces-236670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9CC3EDC1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284FF3B0A17
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1630F800;
	Fri,  7 Nov 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMTV+leH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCE30E0F5
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502462; cv=none; b=sxq5cHOrtCfU3vZbmhLr6OPwU9gfk3H/iwb73HItQqWkt6z5CFogtxWdCsX14iV7agpPcWGJWsH4byCdGy+xS7fAvV9VvbWY39Tuf4FuNBEGsnG8E+7VUCHvIlaqTX+1QzpIaQEuxefTpgsQPKRYvvWNcGNfzNUdnU5q6fKLktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502462; c=relaxed/simple;
	bh=veR/cAm8Ilj4Kxe6dRnZ0XO/VbVZAnhHxEpGLSvMtV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7ebxg2ZF1lkG901QahY99j8HE4OVu6RkL2/pJGB07oPk+gzkhGd0H5Nsf3wgIQRL7Sf4dyFQ0PtIz14q1pdqruCwkhuMYqRUPxWXN8Ltai465Bbxck5sdGi/J84iPfwmu2M6euEzYGdq6rsEVKMLNI1Dp+Rai8DpXtSmr2XgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMTV+leH; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f976ef4bdso434668d50.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762502460; x=1763107260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veR/cAm8Ilj4Kxe6dRnZ0XO/VbVZAnhHxEpGLSvMtV4=;
        b=UMTV+leHob+OXl7sFDwwxdfOPQ5JMzv9T+1cveWW1hVx5XtAWpXKPY/Z5rUVKjPnQA
         u5j4HXCMnbHZ+f/DyTSb4KAsR6kYdZznkAPI9+WCAUK6z5FPlTbTH8fSVsySO0VzSkpL
         ZmVD57F7/a1VsV8C7yqKXLINLPWpBdKFoFErtYlUvyJFFinvVsq14M68wifFl4I+PCtm
         zCrLcma1C8T8vOtC37QDJ4rrkSkml3nyUPU3CVctcLa+LZU1/MhfaqicGP8LVj+5xTT3
         gCGFACc9lYoF/iTwMLrN9lz7UsI4iJPPgMUEQgzIkOl1R1QvsEO3Dt1zT30jPDiO8sQ0
         nWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502460; x=1763107260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veR/cAm8Ilj4Kxe6dRnZ0XO/VbVZAnhHxEpGLSvMtV4=;
        b=vBSAloSApwAGrTcFNY0YDCigWTGHeZBxHDEyDrhc7wecgwXi/j4k14UbyngIUkywc0
         jrlDa8Hy4omkLCljMs1mDHio2ayeR2S1LyGSt9zmsMBEGsMd5OGxrAa1fhsy2qS7UYTe
         jo7UO5BKitasfu2MRqgzYETSRR09l0JhHxgZtu6J5HuobymYM0UX8W8EEgVCM0W1nfnm
         pczTDrIkWW4s3uLJV2sH+ivbl0u07aphvRbrWtbrhfhgrqhRvo70+DYRV73O2QuzE72D
         pNtl6zWXV4n00t1/AJz1Mt5qsuRbDychz86pWQ5rFscSeHqVKkdeJTeAqD1ZkyQpTvJC
         S2tg==
X-Forwarded-Encrypted: i=1; AJvYcCVSz8lCJeXJ7sSWS0ec+bfmfElZxkwzDI9Mb75fuii6Vdnf6r7DrncdronaDfID/K38Dh4nN8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7nxyi0SrNVZO6zdl6cXa99gvdD5gSZ28kFWvH61wuSGoL3w+
	UsUAHWNuzEf+z/p/dOSbnqtBH16ovDj2Dy72KtgXe0nUkSOFWzQOF07Nei7Gxe5S22Rt25Y7o7w
	0y2G3GNjEOX8RQVrapbTI6bNjYD92oW7X5McaK24T
X-Gm-Gg: ASbGncuPiLE0WH7+NvqxswUTow4kSujiAzO10flhbDz9kPI/Wn08V8Fv9wLANef9htw
	TeG0huXiTYNVzDVkmWUXbvFgHyJpiJpSoNMCSrH+mrDVNT25h7LldjclOKmcuhd0BfFW0U4Zir2
	9FxaOjy6ojJ4W8XU5PAJmwj3WeHmhPilUqdVRdz6vZU4VuuG+OF+sAkE/7ftELPMvBeGrYEEt8s
	v0KwJGbMEN8+3kVTOdUIkzuMagVmLvh2z8uK+ODxSuNV8dHh+xFTgoNxRPH6Uq27sL2gFrTLofI
	oqqtzHU=
X-Google-Smtp-Source: AGHT+IHr85spVAlR97UA+ReNxKh2hEyQw6ZXPxNyrC6SYT/nwHeElKYe3UDiSOtD18g9TlwmpoJlObkPwsMRYvN8JRQ=
X-Received: by 2002:a05:690e:42d8:b0:63f:bd67:7c50 with SMTP id
 956f58d0204a3-640c42a98a5mr1403871d50.44.1762502459496; Fri, 07 Nov 2025
 00:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com> <20251106003357.273403-2-kuniyu@google.com>
In-Reply-To: <20251106003357.273403-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 00:00:47 -0800
X-Gm-Features: AWmQ_bm7sjjFJJDdTQjzyC1omjDhx9dWMe6I2OQrEQT0YlPkhfjIl1nSlWH9whc
Message-ID: <CANn89i+O2rHbuchhN2EPoPscbgxNJzrYmf=-5M0BpAUXOeCAQg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/6] tcp: Call tcp_syn_ack_timeout() directly.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Since DCCP has been removed, we do not need to use
> request_sock_ops.syn_ack_timeout().
>
> Let's call tcp_syn_ack_timeout() directly.
>
> Now other function pointers of request_sock_ops are
> protocol-dependent.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

