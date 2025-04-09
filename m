Return-Path: <netdev+bounces-180786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A73A82820
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51F07B985D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F904266B4A;
	Wed,  9 Apr 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wUab5y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BA25F788
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209399; cv=none; b=kIdE10TU7rayjBuNXFePIUs6F5FKvQDGG1ZwbPCbtSvR4JCtQWvWaoTVgl2PvJs6wn57wGOgkgiEr+zLl0vnu/JRXW4abYkApWF0p3C9pKG/3jGSDWUfVMR9Y75kBlaI0GCd73DGEybaPfcvguuF+UC0hYEoCOOzl+wi4A+P3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209399; c=relaxed/simple;
	bh=AYPTTbdioQdnkul2fxCPLC7Xv5xyNiW3i7gMkzuqcVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+bLzqtn7ER022efHBRJa6NmU0YcbwyRAVSVEbqQspDP3FnX0k2Aqz/rqIvYNQtEngSwRkOlQCvk29Y/qtgobYL5DknTIluPkpIVVMiiLKYIp44aIwB9MSK0KzXStQxoWYdPN+oxTbbM1h5cGe8iEv5WBNWjEQ5z7H+YydccbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wUab5y; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fe83c8cbdbso2338356b6e.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209397; x=1744814197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYkVi3KDPcnSOqNG5tFywJuH3wdjdU6xctITaUzFnw4=;
        b=D0wUab5yj8xI60aCPBI3R3E5w+6TA19lduRf98TLqh05wG9wBS5xs0P85ajfvJMZuq
         ZBnQPqYxgGKnRm8wlmTKPk9lOAKwOmtP1OZEX3idnON2HSe0mK0TwSkkg4NhZd60FOw2
         7+Z5rfsH0k2pN/pxwof+tZT5gFZH9TC0MnjauYyD4YYxyiCmhFcpsnkSPJoQYUr9j9/R
         LUB79u0N1haUVzTiBzjK5H8INYmDFyFmcoPLP4wVnK5H3MrHnae9Qj53AUSHKfYSeeZ4
         yBon621TrvfH/uzsuHkBkNfGhER3aFbkUpPId+tFLnWA7pjnOWTSmg/K9UAd3/HdKk9S
         /IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209397; x=1744814197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYkVi3KDPcnSOqNG5tFywJuH3wdjdU6xctITaUzFnw4=;
        b=Dm2CAboiO/TjevcRJ+Vtyri3tSmjaDfnp1wir5Wa97AFjSgdo78e38E8VDkZKhv+Vx
         XCBSD8VbBV1i9dZBwl/s7IL6hQ6zy1hEE8QlBl3Sq6E4sW1lCdABlOYJCzpO6ZMvdFHe
         KuT010JQwnCwat1r1jqrVp3qFrEnXToLZ4CcARuk4/mmvXH82sSVsiBJJXI07QUGa/RO
         H1TQEwjMrVfnIQzgJAjigWoR5P5Qqkx7Mi6aycAGAwuZk2U4E4sDS6rnO3tdamYiW7jI
         XM6yfMgNy+YLJHVgRN1u9YV5q7Rf2hEg7quz4Zx1uCBVEX9qmUEalYFl79gOTAwuQnXo
         XyLA==
X-Forwarded-Encrypted: i=1; AJvYcCUwmnDq6ALnyLT7r9Oof4mUjZQhxHTaS/ZXxNgIOICpnzwSynof/0NnyiToZn5RVEYmzfeIli8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dfly3VMUxlPJEchx77sLGJDZeBB/1Ob1CKrE3ScYZW5kuIkn
	x5w36TvD367RbWA90EoPCZvfM3RI5YVsVtgKCVyu8wR2EPvISPkINKQlxqbU8KM6qunhVqVIUcB
	0PPSFkOG6K/t+BmA0tOns1sVkbeo=
X-Gm-Gg: ASbGncubKCGGeFIlgatof/QVT4QvX+hEwA4gybuq2m/RwbJtvOSG+hKsv8uosn2jgJV
	3PbEfCB4tvO7cBPWQxMKHyBqwBfNEYYtcyHUToggIlWrqO0FbJR7GysK61f6kYm3IpeppyPipHr
	mW0vlG3D4Nt86ZzQGXi1vUze24CnXnKYYm7yriwB6HJCmwDMTPiTVfljSpr6atRQ==
X-Google-Smtp-Source: AGHT+IFrfszpeAL94wA69AaEatQN+TZcEtGnzZFbrCzT+QWRSF9KOfpcBhmqPOhnMdTAk8TaGzQc3nRsaK6oonAFvmI=
X-Received: by 2002:a05:6808:152b:b0:3f9:8b5b:294c with SMTP id
 5614622812f47-400740c1a73mr1389105b6e.31.1744209397114; Wed, 09 Apr 2025
 07:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409000400.492371-1-kuba@kernel.org> <20250409000400.492371-2-kuba@kernel.org>
 <92cc7b8f-6f9c-4f7a-99f0-5ea4f7e3d288@intel.com> <m25xjd4jkh.fsf@gmail.com> <20250409071549.6e1934ab@kernel.org>
In-Reply-To: <20250409071549.6e1934ab@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 9 Apr 2025 15:36:25 +0100
X-Gm-Features: ATxdqUFD0Ra01BQh6ALVi8HZ91Efg5FoI078jE9X71ugu6FfQse8bNZiPzSyW_I
Message-ID: <CAD4GDZxUtPXpKffzTeEgGP0c3cjPe03xZU3VpssQcHYQsZCpsA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/13] netlink: specs: rename rtnetlink specs in
 accordance with family name
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, yuyanghuang@google.com, sdf@fomichev.me, gnault@redhat.com, 
	nicolas.dichtel@6wind.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 15:15, Jakub Kicinski <kuba@kernel.org> wrote:
>
> IOW I think that either we
> - accept the slight inconsistency with old families using _, or
> - accept the slight annoyance with all languages having to do s/-/_/
>   when looking up family ID, or
> - accept the inconsistency with all name properties in new YAML spec
>   being separated with - and just the family name always using _.
>
> :( I picked the first option, assuming the genl family names don't have
> much of a convention. Admittedly I don't know of any with dashes but
> some of them use capital letters :S
>
> LMK if you think we should pick differently. In my mind picking option
> 1 is prioritizing consistency of the spec language over the consistency
> of user experience. We can alleviate the annoyance of typing --family ..
> with bash completions?

That seems fair to me. FWIW, dashes seem more CLI friendly too. And
you make a good point that existing genl names really are all over the
place.

Donald.

