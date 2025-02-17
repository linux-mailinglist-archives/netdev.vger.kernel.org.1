Return-Path: <netdev+bounces-167075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46211A38B45
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B27416BDE9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88769235BF3;
	Mon, 17 Feb 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzLfUJPw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61C235BEE
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816909; cv=none; b=a4l8yPMHw6TpHSluArG1d4jQJV7brebc567dWOTSsaRQkv8e3NxxONZUzDvenE8blCbAtOxT+7wTxrnut8AneLspgB7oyfCU7UKWW+Ms3AH64gl8BjpdZRKihpzNwGHIuEadfH7ifulw/dvkfsLHjY1T32vu8Z0MxgsU9S7y6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816909; c=relaxed/simple;
	bh=hCY876bzfHPrz+2xaMfuRfH/o45M88VIOZfakkcRy5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpdEjv7tqUhKEaclHX4kU4dS/SmotwHBmR4MNjI5ynrz1SelD5eQP6Kwa7HZldl7G7zHDhlBWaghQjjMpA54yrDhId3dWssj6xr3fbAXhR8Dvdnc3yvNHKsJPZl9atZzGQXnXao3XcIan2QPzEOZZpjKKWk3J+iSOFJLf4Vf+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzLfUJPw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbb12bea54so84628966b.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739816906; x=1740421706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+l+0lQBsKNzTpGm0qORCGiSDs//13l2fOSSxE+r8mw=;
        b=qzLfUJPwcPB8DkidsERq+oMOmlW+KcywG2pPHuXqpYynBsPDoF9LFhMTV6Xmwlt86y
         aN9zj2psQSl8RfCIUMXTifF3LmtJATSwxljcf/S7soK08wPkQsa1d0gxN+L94115jsN/
         HzkWZYQc6XcPmhKorMm6oSKE0EO+YXwOAKwg2HCYAEgHkfCvkLLGSOm5Byj9TBiEWiuh
         Nuta+15VUCd9zzWwLNvaFOk65rg3aScMijEi43ctmv4RL5AZubN+ULW9IIw6fQ6DVbG1
         sgG2sBcKJOfl8CfFl9y/W250ybIkOGN3J1JZcCNMDowDk1/nOaaQtHfuxk1lVRFR2Z/g
         D5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816906; x=1740421706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+l+0lQBsKNzTpGm0qORCGiSDs//13l2fOSSxE+r8mw=;
        b=uxf5sdGBx+PzZV+ZZly58EeZe11lh+n4YHLhKnYjuyJ0803/dO9ZC7i/wgHMwmYIDA
         qfLz2P04h1F4VUj40GY/gRBPAXFeDb8YtlzynhPJN06wK9BGPDyaj+1c6SM6T7OlX9ie
         7Aqk+Mqm0wqA9/GtBEj2RtokKWpndnaV8xX76eFtfOWUnjhVGXyuvVvxa7jFQ1Llg0RQ
         /8B4DKsmvjZhI1wAHavsgClHb7khtYad0/axhDfSR8VCnMLLNF6fwnoNgCV3jhFRk4Lj
         rmIOuwbW+lpUSDXSgp+xCGT5GuBhnYU6B7+jEw8LSdqthNOYOqeyIYmFR44DiGqKdaTv
         FoOw==
X-Gm-Message-State: AOJu0YwVZZSbfGWFUM96RYkAhpie2YsuLthtwBHEWZnooClVEwNVPpcN
	WPWlhHJhC9ff9JU6eIzfTjQUIriu7SbzHrXYIixF8rhOv5qsPe7uFemJnS1Eq5O8KX9sL2HzfOz
	eQsqapIKGzXx+gni0BDrEhaqek3/xB72zETQM
X-Gm-Gg: ASbGncsfGUQC//i/p3RZ7B/zAG97d9wGFEzz7DlNmlpaDYH/LUtKRdWCq9AT6f52r31
	sPvIs9OnQdjd+WcjmgPeDZjdSxNQPwA5hT6bk/IpDmxKw05lJxwqOqJk8JhOExRRAFrFFk0nT+L
	3LFdlOXTF3yc2VGuuvfXjUweaWHBI8qA==
X-Google-Smtp-Source: AGHT+IFjjgLMTvGHSCRWiwCYLddKG3v8fu3sqA5dCvDVOitjnq/kSTuDzxQRaYiuzB4Hayx3/fyBm1HmRPPrqarBzzI=
X-Received: by 2002:a17:907:7f27:b0:ab7:f096:61d8 with SMTP id
 a640c23a62f3a-abb70bfc808mr1220784666b.29.1739816905780; Mon, 17 Feb 2025
 10:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
In-Reply-To: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 19:28:14 +0100
X-Gm-Features: AWEUYZl-8xmVnot7cSihwj5mrrH3uVZP9wHKcdzkuxM7ag-b5A1qdgu8u59YhW8
Message-ID: <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:54=E2=80=AFPM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> Add validation checks for hardware address length in
> __hw_addr_insert() to prevent problems with invalid lengths.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  net/core/dev_addr_lists.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index 90716bd73..b6b906b2a 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -21,6 +21,9 @@
>  static int __hw_addr_insert(struct netdev_hw_addr_list *list,
>       struct netdev_hw_addr *new, int addr_len)
>  {
> + if (!list || !new || addr_len <=3D 0 || addr_len > MAX_ADDR_LEN)
> + return -EINVAL;
> +

We do not put code before variable declarations.

Also, why @list would be NULL, or @new being NULL ?
This does not match the changelog.

>   struct rb_node **ins_point =3D &list->tree.rb_node, *parent =3D NULL;
>   struct netdev_hw_addr *ha;
>

Any syzbot report to share with us ?

Also, a Fixes: tag would be needed.

