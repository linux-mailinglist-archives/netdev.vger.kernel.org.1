Return-Path: <netdev+bounces-195689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D2AD1EC5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971393AAADB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD1258CD7;
	Mon,  9 Jun 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYBzzxPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E219D880
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475591; cv=none; b=CBrwPuoB2Ky5BsG/7DOeybgWOXS/05PMnMZpJbmTwptLLKO/awtj2mjw1jUQhMU37x+FQfe20c2lw/qXqVsOBRrWyvyV8TNWQ8VPSkhVLXw/W41918G6FZwFGThReWcTid4FWPxMHdFl3KzlAW31U4jjCzzxBcB/f71G9TiW5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475591; c=relaxed/simple;
	bh=uiK+cfy3D8Kd3n763ZoT9eEd50qJYfRs0GYCPsBEGVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNkcwu9gwy4FuuTXNo2jyN0+kQ2XNUwA6GeTvEQjk7iN7nJhm6CE5AlOI1cvjNT6IUSgfDzY0zGNXf5o5uPjJrmnOdHnooUCa9/vV3VmZpD4ygzf2vnKDoGC+Ufqr85RszKBG7oTwUuAyU0kKojlIYC+54uKz6peTcdXDmkdLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYBzzxPE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a585dc5f4aso59273711cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749475589; x=1750080389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiK+cfy3D8Kd3n763ZoT9eEd50qJYfRs0GYCPsBEGVQ=;
        b=kYBzzxPEa8L0hiElaJAl8xMrOPg7ilg6YLYiKKov5L3fDLneTGJXvB1JmrKDoY6r7U
         6JfbgJ01THPiOFReB6hoFLhJ6uNqwS08mngQlmcVgpIiHMt7IvKrQfOIRQCZSeKTrvNO
         +HncdxIXo/IttDhvNppNadVqHf8E08Zk8+p6+JwvS2Zm1U5ipJndims+bzhVis/UpCmH
         Ba4/amtFnOMlMNg0sFSqBcDAyH7ou+fcTVhw0NM5qLQggNElrQUA4koEm3WhNdzfvGdY
         qR8g51wE+b6dcvccR+4FRTOhuNCYuD1N5zKdm2YLihG4RVTj1dMQGE7GP5lPFgWdozQV
         2J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749475589; x=1750080389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiK+cfy3D8Kd3n763ZoT9eEd50qJYfRs0GYCPsBEGVQ=;
        b=k/LhpQ9EV5UXUkQzM9gcfNIoaU0zQf/MXZfd2APrzeSvtBgQHSPqj/RGPf7PAFtcZw
         mdibpG1VzElalNTDcVsQjvMQoN9fp2jG6cMYvnLcL/ApLW6Hr8nzFqamkjCYOzqBRUge
         D8k0lsA8WbZQ3q6QfsFbRmRyXaTMMxCK+b4zBscj90DhfXYk9JhdSw+/okqGxg6elaw3
         HonuJGvq8Os00l8krqR80HTZ4/s66rgE5gLskkMENNWKT7x7Ae/9CmGutEFGbL+NjDzk
         PebP68zdtSrlRp+ofTxfyo6E1H9vM9XN1+DJY5uSNsPtDsegGG/dCcCAY3QU9Wzszz5E
         hM8w==
X-Forwarded-Encrypted: i=1; AJvYcCVCkRYNPOUVN3H8S6OYuA4Bsu8bgJP9jty6+Ti5m8wmLa3GSdMRtOcPqCbl44N14mN2+HvAwIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjBKa5VmxJ7qTdwUSOufUWzg8oaNHlkACCyyefVVtnR6r+s1T
	Pgcq+0dn1PmmJ69CIQbnLb5D8DEy3RaYmgVi5GHmeY2Xvrg78LSWQYaiELxJXp5O9ZzLRhLjJhH
	wEc6j17cCt5+3YCOYj7bkPhb93Swx6X+Pg1b3g8hE
X-Gm-Gg: ASbGnctWFcTy5fLGb3cQYZea9nMybsrcSO1rskj1TFfSqY52lSwwtLACagkzEHmYpMb
	4666m/I8jBUxoP37aEU/ptLx+QYycHf7flGoKt5NzNjYMPiE+AeB05YigwnBCuoUsuxAGD7Eriq
	A38/YnJU9vwLLKnxtcBU/W3kYgcv0K4lUXp/LyOTHUmQIhAlvcf+Jwi/VbfLB0PzTmn9Ads4o+i
	0GH
X-Google-Smtp-Source: AGHT+IGtXvdqCHXyyVABJTx35Nphdd44zVmAhGNNS9PKZCXKGrwn0fuUYy+ap1HxQQY+2Xk3XIITmoPT0YNZXO6b1Dg=
X-Received: by 2002:a05:622a:5a97:b0:477:4224:9607 with SMTP id
 d75a77b69052e-4a5b9a26dc7mr214881771cf.12.1749475588422; Mon, 09 Jun 2025
 06:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
In-Reply-To: <20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Jun 2025 06:26:17 -0700
X-Gm-Features: AX0GCFv7nRZn9OyKVR4Ey_BdouuCYOKYJbcuN_H0LDK4VeL_nw0pbLQEP2oQilY
Message-ID: <CANn89iJd5FZiOyaHEDrESsZ8h+N7ngfkCNnTRNULxV+xM+qMQg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "mctp: no longer rely on net->dev_index_head[]"
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Sasha Levin <sashal@kernel.org>, Matt Johnston <matt@codeconstruct.com.au>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, 
	Peter Yin <peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:12=E2=80=AFPM Jeremy Kerr <jk@codeconstruct.com.au=
> wrote:
>
> This reverts commit 2d45eeb7d5d7019b623d513be813123cd048c059 from the
> 6.6 stable tree.
>
> 2d45eeb7d5d7 is the 6.6.y backport of mainline 2d20773aec14.
>
> The switch to for_each_netdev_dump() was predicated on a change in
> semantics for the netdev iterator, introduced by f22b4b55edb5 ("net:
> make for_each_netdev_dump() a little more bug-proof"). Without that
> prior change, we incorrectly repeat the last iteration indefinitely.
>
> 2d45eeb was pulled in to stable as context for acab78ae12c7 ("net: mctp:
> Don't access ifa_index when missing"), but we're fine without it here,
> with a small tweak to the variable declarations as updated patch
> context.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> The 6.6.y branch is the only stable release that has the conversion to
> for_each_netdev_dump() but not the prereq fix to for_each_netdev_dump().

I would rather make sure f22b4b55edb5 ("net: make
for_each_netdev_dump() a little more bug-proof")
is backported to kernels using for_each_netdev_dump()

