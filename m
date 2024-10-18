Return-Path: <netdev+bounces-137018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7A9A4083
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE631F26D2E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF71E0DF2;
	Fri, 18 Oct 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQTEJzLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED81FCF56
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259663; cv=none; b=OV8KXBTVt2P5Ct4CHUOB/2rCgcnmrlIiRON53aP6sYhRgGqD2oAE1mBFUOKa/69vmCrgyRsvQ2UcWWl+7PJy20EtsynCU13l6vF8afocKvD1jW+ROKnsi9ELWk/ngvFp0RqxgdTOYx4zH0qJxyQKswTNlX6khyg1msX3XPQFViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259663; c=relaxed/simple;
	bh=CH8bLO+2e2i0MHiUSKL8jAkVCv2afiwX4l7RgYQV/ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCkyuyhyPUs0GrlxwBsyI1aWAd9jSwvkqjXzCgIIdaIXtUwSz+1bIkf5En3cXsIOAg1h7IBUd200dO8MCYEzgcfb8Dq3yD87r8KGGwJCAE80iGjPQJe2j8IrkidBeos5kswsxvnuI1Yfp/pjB2588IHCebVNV91ZbZ0wGVnMuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQTEJzLQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9932aa108cso314151666b.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259658; x=1729864458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH8bLO+2e2i0MHiUSKL8jAkVCv2afiwX4l7RgYQV/ek=;
        b=DQTEJzLQIvTIN+e0Guj1Htk/qA5XId1qzggqOWZMQdd0VNByS+Dqhtt1w3Rw1nArQS
         P3KeUQvvy5iXGEXBbT9ntscEBN9Ep5xwOFVWfF0qCLzz1u+xI4KgiuydcIEcUJ2OXA/E
         S+rSu9yZmFs8GFChv0D+9thXjLyiBatDxf45K6+5U83Q8OWrvVTJ3xPnVnCYIyjJA6rM
         bh3DDq5XMQsjGIpO7XkJiMwhVG7bPHY/KdiIuhKohut7xbwhTI2y8j0wDN7+EjjePZSO
         nHNa6/UxEeNLXe4NZ0yNjgU2BC4dvM0opuK8hznTPhEMEfgBgqWy2OH17KnqFDdKPPDh
         EikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259658; x=1729864458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH8bLO+2e2i0MHiUSKL8jAkVCv2afiwX4l7RgYQV/ek=;
        b=MKXVhLqMpwbvjdVpLOy0SGCqPWrIyaYQUVH4TD4nqlsUJ5+1Hzp31GiK+DA62X80vn
         uISsyhx3x4SmsKbqasuGeanQUVCSn3O+yhrs95jtwi3xDQQr1eO47AHSg1vYvev9tXFP
         Ta27wN6X8naq4rzEpRLK9f06RgTwTqA5TMq3Oz7mO4nsHTvx1tpp23HpynnfaspqJxzS
         +sE3C7bEaKSRk8nK1pCByh7++7DrNw8p4q7T5EYJcj7ejPU+uW7WHwnwm7TP0sMlmAmB
         Bqr2pQvsjgIC0ndc81JSe5C7QfxxybAo5Oifwpn6DzAuNL14DCSV9/qcy5xggh8Z5mTD
         UaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLg0KvblDEqDWvcBUPwtyXICCg6eN+Vp9ZWhu2zG4mKgBceN/9oB33UM5LUIGtsWcOuW8WsQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVi10Spiur8FikjME0o0c4p/7TT/xkvo5FbGtZelg+DW3TZ+r
	807VCYTwKrUG0ZSroJQDZ+eGZr1MbOpvX+6YscUniY0+kYxsva0IBNtDXkJS4JgZhRCyqZeeJua
	2fqI7o7o7+uW7l2V/tISiO73sBhugYp4nnhx7
X-Google-Smtp-Source: AGHT+IGz/mI53W9xi3euXpaC1SKOGczfRMFenNGt7cIsYJCNXEmR9ARDIsFk71Uy6W0pT3mzhqzZVLywBwxMFl6y+eo=
X-Received: by 2002:a17:907:2d86:b0:a99:e745:d47f with SMTP id
 a640c23a62f3a-a9a69a75ab2mr198962666b.21.1729259658009; Fri, 18 Oct 2024
 06:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-8-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:54:07 +0200
Message-ID: <CANn89iKxYXrGM0vTmZT=CpVTNfTvDmCJ8cBi1x9RZ4CsqAuL9A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/11] ipv4: Convert check_lifetime() to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Since commit 1675f385213e ("ipv4: Namespacify IPv4 address GC."),
> check_lifetime() works on a per-netns basis.
>
> Let's use rtnl_net_lock() and rtnl_net_dereference().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

