Return-Path: <netdev+bounces-131998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696C9901CF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5896D1C22FD7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C262146D65;
	Fri,  4 Oct 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLPgW739"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617713DDD3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040133; cv=none; b=Lxd+/1MLwmk4+kWi2sSlTtcXeRQWx6hwcp41qnG69UpAS1cFx8mlyWgXV7E/5zdwgq+W7SIVW0w9FMxasqrZbeRYlKfCGWwHTdep+ZFMO015ySBa7sA9ipoFjmtLw/BqVAcS5yR41jgR+iSCPB/L7y4tj3DKGMdpjFfACrK4oWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040133; c=relaxed/simple;
	bh=JfzaofLeg0Z7jH426saUkiANGwmK4xHZB95BBf5zv9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ezng0dnuPAhLcOaDPP+leSJRcA5pxTMq8G+NDLtjXVebyCESLPdfS/MiPLAv8sBrMUnQKYL4dQRf/Z+w5+0qOUyXRMwSmrfWkv509Q6Z8L6+Z8J1MtlSm+ofiIvcjGBJjp0aTtOgEmtiTTf+oHcRT6P5A5REFLAPfqX+DNmIFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLPgW739; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facf40737eso24239521fa.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728040129; x=1728644929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px6X2wDPQNot6BioyC42QH9FHSRynDW1LpSR8VRsf3I=;
        b=xLPgW739VcyY4LVFJ4wOLzOfsjCSqtXRK+uPrmJOeFOLF0AKYu8GYopB2Z15sscwyY
         8/XnCFJNo7CPVWYZeNB/ER812gQks2J3Bud7xYPIQy/iHY6Z7Bv5co5A9U+VAF6FiUn8
         J7yhKBZlK5uhBQgtxditFisdm12Mfv0AYC49jfz6CRG1+jt4pvW7uzdrNXImpsXxnaVN
         sMRoAeyPTolEp/03SCspBjhh0bpN4DEto9QkPmItB6h9NSfj+kOg+5UMUVjNBVND/8nV
         mqRjJ/rH9T4ItCiH+JwIjXltarZDWOiGfdk4l7WfN9d3E41dz85XvCSjMUqd8I9MxF82
         nLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040129; x=1728644929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px6X2wDPQNot6BioyC42QH9FHSRynDW1LpSR8VRsf3I=;
        b=wkOobvojNoFNbyhtlk7NaQGv8g0nyKs4RpjFqDN+AYEofW8J9dafXnxfomhTJn8Ua/
         BQbWbDhvDVuj6HPEN415TWVnVYZURXjcRJPMZJ0riXXigEbL6ksKAF2F8WizFMsE8WXk
         ircSuvVKJkPW2rIAlP7dbZph6jJ/OE0oK1NV2oX+rAzhLyZp9Izjn8OqwkAZEDP/nrYf
         U0dY7JhovfwHKosgXD9ZqPFcVIzzEbInJgjwQqm25uCx3JCFl0CJqa1KI6MQecl9U+Dl
         i4dZ6xXfG6uTqm3iE0a2Nr0392SaTtj+U1dm4rHCoRk68aPE6nY6NiE6Pdwh439xZSfw
         539w==
X-Forwarded-Encrypted: i=1; AJvYcCXoPXqRl3TlUKrMyLRIiTwilcsRQ1c4vWXr1Fc6D+oTnLrE7ERC9ga/q95AuDmPxS3xJEDXZbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5JS57klc7UYx8hYdc2t97yV70zcZ5lFHtWqplp/rLLgxKgxC1
	+g7cZFCnI2IaFqfowbWZcHvDbAI+CvxUHGTmRUR9cuo9SsHMJuBKk+V0zs3ILZVk6Rfxr9E+u9d
	JTEpI3WwPrwO3A5Tl5F5jTJ8ucwuLQDPza5sV
X-Google-Smtp-Source: AGHT+IFn8chzEkYn77PnpAkdOC4zdt7OrQ1gaANsK9wffFdu81jSCyPYcn5J0r0NUkWugt4l61TaJ7em/wyjix+Cjwo=
X-Received: by 2002:a2e:a375:0:b0:2f7:52c5:b75 with SMTP id
 38308e7fff4ca-2faf3c535dfmr9600641fa.15.1728040129153; Fri, 04 Oct 2024
 04:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151240.49813-1-kuniyu@amazon.com> <20241002151240.49813-3-kuniyu@amazon.com>
In-Reply-To: <20241002151240.49813-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 13:08:36 +0200
Message-ID: <CANn89iJXYQCLqziHaPQvYG-b68oY4520t8ENYe=8fkUJu3DK8A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:13=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> The goal is to break RTNL down into per-netns mutex.
>
> This patch adds per-netns mutex and its helper functions, rtnl_net_lock()
> and rtnl_net_unlock().
>
> rtnl_net_lock() acquires the global RTNL and per-netns RTNL mutex, and
> rtnl_net_unlock() releases them.
>
> We will replace 800+ rtnl_lock() with rtnl_net_lock() and finally removes
> rtnl_lock() in rtnl_net_lock().
>
> When we need to nest per-netns RTNL mutex, we will use __rtnl_net_lock(),
> and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:
>
>   1. init_net is first
>   2. netns address ascending order
>
> Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
> with LOCKDEP so that we can carefully add the extra mutex without slowing
> down RTNL operations during conversion.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

