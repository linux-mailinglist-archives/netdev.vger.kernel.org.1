Return-Path: <netdev+bounces-229475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C14BDCC67
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99B344F85E2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D16313276;
	Wed, 15 Oct 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSD+44Bj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6003128D9
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510659; cv=none; b=oLfIcyHTt1fiwcsU1ef3e4D31nniqDSsMeGLRVr3GkSYEfvCXa7gdWphwiLk3lmGK8s8I4Ls+6dc5HnVTg8+ZPX6hT+2V/CvigaesqowzSklDARCi9DgGXDgMqGMdsoqxsVyc8FX7OUQNh6R8VxxuWl6z90b8ocmrC2xoWkRs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510659; c=relaxed/simple;
	bh=5vozDEb0LYycMaeMPVwxAxC/Y3/90+e5ay47FO2hKKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqVClL+WP26ykUdTUWQg5U71qIgvWQef9uNIl4dRrQoiUdZGpkuAp327LTgqZX10qLCCBY2eOK6oA8GbE7P007kD+07xlIWFlKwo28guX5YQ/bIZz1oWQQylB9Aib4MjpMhcIlLkJUobT5+neKJAM2kkDIrfplPsGLmimoOoqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSD+44Bj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88e32ad012cso54323085a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760510656; x=1761115456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vozDEb0LYycMaeMPVwxAxC/Y3/90+e5ay47FO2hKKQ=;
        b=MSD+44BjNg2HTDIvjKtNcgaI3DYRsInSo17I7I8kGBjsmqz+obXMh7Gvm5E5xYHjdC
         aow426pH8aaJSngqFl0i0w5G7xUyo4Yl8cnoRhdswus0o9AyY/spGp09sqi2I8d5dNu4
         RkXeL2WSb8iWtL4RJyk+IsM7r20ZL3N+Mfno77r/Dj+ThhYecT5KTq6d6OWWeIJIVBVO
         rkJIdLrGgZpfxQm+Z0nmycQDfysTIZ17e1xzLNbQMeAI2OC2zsB6qEGXkI6EQXXF2T3y
         gWjzkvHzPdkfwdKBeLv3q0u8wvMQnSGVhwM29sS/VVgK/nAGFYz5It54nT1PPWQa42Yp
         Hwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510656; x=1761115456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vozDEb0LYycMaeMPVwxAxC/Y3/90+e5ay47FO2hKKQ=;
        b=kGY6uW3qZRPJCKmjHTRZQaFo6onEaroNk9Uj0wtWZukKqnS+GcOe0kJsvkcynWjgSt
         PuMkslUiQmGA1l0pxyKpRkXBHbeOMf17b7va3JGH+8tvj5E0FNCTd/0zp4AZXQz3SwUr
         ljmXUq6UGm1w4O7+903Vumv84rRNmVB8aIhUrMfhpZG2iCwGnm9K++fis5a8R4G9pat1
         1cKIcaBPZhHLEv16PiWLWy/a7fgT3PA5/doueXchq8oBxRffxMZo0x86GV+FnAh6fpr8
         daoBQ5jemwqAnDWvPhfM6aZc0xFYdfhMUveHYz9Bq0z1MoTF+VAKSUwMyiEjlTb14sc7
         spNw==
X-Forwarded-Encrypted: i=1; AJvYcCUao/J4XBsf/pkc6anM0R4LHuJex24xrpMfKPWS57c2lBcx4yBjAMqZuZ8GttqKy1IOKms9t6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfQw8YxMrMWsTSTvJ1DRKqsB7daqSb47RUTRNJhu4EGVJtzOC
	A9uYYr8LdiopSmfH0oZTKhTVs+FyCTHOfHFbi3ZeObIfnVAfBGmpBOcCD4NyYzo6ReEMk8sk0kH
	t6QOkJJs/xqVX73FeOIe5l45q5UH20NIiJJ9WNiJY
X-Gm-Gg: ASbGncu4wNmxzEANnB3m5Pcv3m5lLDVe6ngNY8qlM7iXhD94GiNsZgy3JvKdQWGVYQp
	WWBfwgmi7iI6P/zBtbZ3lemu4bc2sO1+Dnd+c9nkcam4l6/cm6tFZQGbQXUROVnWCnN1/8KypYX
	4YFVeHUmg6wzmqUX1+Hgp9jO5lLUnZrxLVmwQB1n6awGcI/8qipTBSmyf87kq95KBZyqZTwWUPv
	GbypLmyx7jAktYZEqiHKWlxeY12g+LR4g==
X-Google-Smtp-Source: AGHT+IECy59A890wq3a2KaQniANJoAlkp9kyZDXlqKYOC5DftviYiCqQF5O0BTKZ8orKrKjBg8QJmeUrfmmUWZ2jftg=
X-Received: by 2002:a05:622a:2c06:b0:4d9:f384:769f with SMTP id
 d75a77b69052e-4e6eacccf16mr275159231cf.12.1760510655891; Tue, 14 Oct 2025
 23:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014140605.2982703-1-edumazet@google.com> <9e7530fc-c546-4420-9ca7-0e3d0a7b63e5@linux.dev>
In-Reply-To: <9e7530fc-c546-4420-9ca7-0e3d0a7b63e5@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 23:44:04 -0700
X-Gm-Features: AS18NWAQbjB_FhT4juVSkx59GqdVtyxs-9ikOEVUEl-VAnRFJ4mGMux_5FwuByI
Message-ID: <CANn89i+_1Y_ARBnZO0H-DvSrT0N6+YcUy+S6Xi4Lw0VXgaSrRA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove obsolete WARN_ON(refcount_read(&sk->sk_refcnt)
 == 1)
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:04=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.=
dev> wrote:
>
>
> =E5=9C=A8 2025/10/14 22:06, Eric Dumazet =E5=86=99=E9=81=93:
> > sk->sk_refcnt has been converted to refcount_t in 2017.
> >
> > __sock_put(sk) being refcount_dec(&sk->sk_refcnt), it will complain
> > loudly if the current refcnt is 1 (or less) in a non racy way.
> >
> > We can remove four WARN_ON() in favor of the generic refcount_dec()
> > check.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>
> Dear Eric,
>
> Following your line of thought, I found there's also a point in btrfs tha=
t
> needs modification.
>
> Would you like to modify it together? Though it has nothing to do with
> socket, or shall I modify it separately later?

I removed stuff around sk_refcnt only.

If you want, please send a patch to the appropriate lists and maintainers.

