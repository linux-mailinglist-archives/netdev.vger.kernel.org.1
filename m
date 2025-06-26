Return-Path: <netdev+bounces-201627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18780AEA1D4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7D47B4EC6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484022EB5BD;
	Thu, 26 Jun 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IU8bZUSf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1242EB5AB
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949712; cv=none; b=rrM+3o4pNIc/52ElDgx3vQIFxuVJPG2Zdz6hAUEOB19v0KYLIbBKsmgtg4lirnOxHTZmEMhxBCf9ijlHInHCG35f1HnExLQU1A1KMvKguQIK32DQMwgfMOoSQsODOAHsDAMygpCeHv/qYGrPvmpKjtKy4gqJ9SteqmuB+iFseDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949712; c=relaxed/simple;
	bh=QyL9KBuGWA+vXhFPU4nLSbuDcJqmwM5Iq0c46HrtwVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfwLGBHMy808p2N8UVMB5SaIR+peYCcrtc7nJtLcApRuS+exLhNsRkZNm/ilJFlJ5CMibaw56q1lgIyPooOlKI/r2HPj33iRHLnUxTt4T9jWo+hbeBQtDcj7sJrsMQc8etnsT7yl8lKuxbWVq+ubWa6WsPqUuGAhKFrXCZJI1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IU8bZUSf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a589b7dd5fso21381561cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949708; x=1751554508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyL9KBuGWA+vXhFPU4nLSbuDcJqmwM5Iq0c46HrtwVI=;
        b=IU8bZUSfWL+sDGz3Xa5IyhGaw1dYe5E3otspboZ9k6qhw8QZhTE2ycLgX+zAbEq/yS
         TJI8bEOANUf2qCeyl322r0B36VZu0SeB2LyyBpjvis2vxYC+affEWP855bq7OpVbHZzS
         JvZpMafvPOR4PLFalXza4BmhclL0i8ZfTazKR4whnFcV/d8tmNFV9kikjR79tQAvJA+g
         H6BB0CceVG5Psvb1doTebNHCuSrGLwRXvk1aK+aUbq9+5kNMwvXfJwwVYQlS+Ms73yKB
         6y4XgRbKlem/iyNMVSMxI7Afc98j/MoueAN3fJkR5+bYT4ciZO+2F2MIw2yrEaoD4mPv
         avVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949708; x=1751554508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyL9KBuGWA+vXhFPU4nLSbuDcJqmwM5Iq0c46HrtwVI=;
        b=pijuvU8sPYFFgwvZnH7nYnqySmwdLRAmIlflL0aVeczzU/ulz4gNEKX2Wa8rOJPvjg
         nGzUk6N/i4reaeT3IxyUBO+a53tEt68DAgvF18LRQeOBhUoBSaXnbWfD1gMkNDxuTFgV
         K/iihMORhiE133NuziDuk2gbUITCIgishrxhTR95Z/Jmiwc5EUhdvVNVuKIqBfNL8788
         fh2k/cCB9bROxU5nMvdF3kpQJL1sx7YQhINxGWapZ5k4ygLNuEf65hbLWIerRZ1ZsZtE
         7KGPbO0CiipBoEGtWtkORxBRardteFbiXU67aBZToSjZUxutnbZK1/Uyp1V1C6frWIP0
         dDsw==
X-Forwarded-Encrypted: i=1; AJvYcCUvDCf73a5uTTcU0RAqctzj5RbQ2C/UbQzAWWM+9v/1/7eCThTIy5l5k6aE1URbU1muq3TcFuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVq2yGFsarDVNd3hcwlRPvaiEvc+dapFvlxVv6cWq4+3FBKSm
	128/PkVewDAf/rqH15OMiioqLClD9HUGvNwxsvKb0j6Mu2/jinjiHr8q1zGRUntNf4syQ4T/+ZN
	jfqGyQ7nzSVH5A3ckdBugUfb3UJt/bpgfEVGE7QAF
X-Gm-Gg: ASbGncuNqa1VuxwcljGlLdA6bP4bBVfnQy2XZcvUWPxrT6VFexuxcuYiqTzn+vKcY6k
	ZnCImK+8OyVEl8dJ5C0d9imZELrAXQQMtu4BYa1R0HJ5yp/+nr5uM6StHeyNdJhL8Vis+v370TE
	6UXPgYVjw5aJXWOuVl3Y23m1NW+G3zrbLDQtR2pbOOhe6x1Twd4IQEYA==
X-Google-Smtp-Source: AGHT+IHt3qpZmxrroDGai1QaIgnozNfaqFh6+HR3i1r9niW+3zoFCMbFOXTflAJsnw0iCe2WENslaV6mrwaLDpv9kgQ=
X-Received: by 2002:ac8:5787:0:b0:4a7:7ffc:ac95 with SMTP id
 d75a77b69052e-4a7c0848147mr120955741cf.40.1750949708225; Thu, 26 Jun 2025
 07:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-16-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-16-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:54:56 -0700
X-Gm-Features: Ac12FXwtg_tGrObw8lQ6_ab9Sta7v-M2k02FZJJFu7XjCSP0xly9QXxhRobFcw4
Message-ID: <CANn89i+QqV+D1AHzZKgGX_-v0-Ug=bphB_vpnct9vRdWZ58V+g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 15/15] ipv6: Remove setsockopt_needs_rtnl().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> We no longer need to hold RTNL for IPv6 socket options.
>
> Let's remove setsockopt_needs_rtnl().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

