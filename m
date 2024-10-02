Return-Path: <netdev+bounces-131265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23D98DEC1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774D7B2CC62
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1C1D0B97;
	Wed,  2 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lp9vZmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C451D0794
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882110; cv=none; b=DrkobGXUm3WMzTLYJy2qeMm8DCRq1ncmRdGkERkl3qIFqIpN31k0O6nHXyOoL+QsupDf1gGp5tA5Z/csYR3UjdCsm8uwFhGs+7JXhh00xUCpLZQVqQywEqEQweP3ttwFy/JK+gJgwqy0Iu0QyB/JlfwiY1Lo242ls3VELlH2QbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882110; c=relaxed/simple;
	bh=OEvrNVy46G6/eqrNq6fN1NMT9wkg5opYu3E2meA8b1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4aup7WqBxdrXi/3vVMCmhSsmhcY+TUoTnGAOWpXH8TqKnr9Rh6lh3W/oETwIIp5h9CxB7Inssk9hX569zK4iz8Vlk7xkVdp/55Tgqa8iSj8Vm2ibv+b4jUTuk6t16vEqRqtx9D5nypbzy09WPuUpQ5uPlB78BopkqTN4z+zT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lp9vZmY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso7052397a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727882107; x=1728486907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIurTb5GhpyWeWBdycKmcz9x8kH7Dbkipb/q5TbZNlw=;
        b=1lp9vZmYu00BOXMebqKow2gxdw38Ogki3FxowuSHkBv8J/UzXbP7qAQWcAWjPloaED
         xF/DseEM6IXu61wRTCF7bnaSCz11VyXSr8H4DMWonhG779HbP0FSH6vavti2mUG6Pxef
         c2MuGjUcrVc4TXXM+oXxu8aJnRBb7tgA2bTG1tiGAWxkjd3uEr8LCAAodQubvQHMn1+4
         CRNw7aqfgBoVH9GRBuAx6curmudqQ44rlw6jO165RmzbynlFLdmjG0/pkiavWO0c8l3K
         8tzja1lynZBrp7nTkJYXZ7Y9VgpBxBn/AfaAVvWadCJ7HBNgVB7/aHY21hXRwsmloxhJ
         XNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882107; x=1728486907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIurTb5GhpyWeWBdycKmcz9x8kH7Dbkipb/q5TbZNlw=;
        b=Tof4LWVfwQO7odBYLHdbKP+2OUbyLzBTy6SSfypJV11AfPfaB2mnkyW3cdvAr7nliC
         3DDvqnZYtcFDY5p6PE2wffjv5vcLJ7Uhe9ZnwsHLLQyI6Te3QOEXUXom0mlb3GpiruQz
         Qcw2WV3GxV5ttkA3TCodGJ1XOoOAzpWp6rGZEjQ5csOXRBYRNEqkPBmZ6+7TOr9+rdex
         HjQn2Kgk4ktFlr87drfgs3mxFGL5t2+QTEyqYQQs4teq8MsCdkE1ORLoAspWp5ZO35ga
         p4tfBs76Qi1XvcHPFvNo09+fdaF5r4HJtwm9HJC2zLW4D7Od2T8INUX5ADmxpdc3KBD/
         XzWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBHactdmYQHIgMyp7SzbzsC8ZL7UBrcY6OPgWy+MVSLqPNPEljCH7s0iYg9+l7dSdpSTCq3PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkH252TTfKMU3Pef7C5JhfV5aiX3xZbjnscbrfgFDRKegJGMf
	IsN+cqpFKATol1jYPPNomKzljKggm3CaNki4jOLiEM1IWSgPSd6gZloOBXULJZyUexRWapA8+cr
	xeVUm2KML+2ngdjKaLq3igWy9pSYkN1+JvLjn
X-Google-Smtp-Source: AGHT+IHu44jvoKPlM8QqU+Ttrle7GqW6vFyJEP0YQ88mnB/4CjJl/fLYswQ+H+4wasfxW1+w3YVGpX9VLkwOtsCvnh4=
X-Received: by 2002:a05:6402:42c9:b0:5c8:8381:c054 with SMTP id
 4fb4d7f45d1cf-5c8b192c7demr2809970a12.10.1727882106919; Wed, 02 Oct 2024
 08:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151240.49813-1-kuniyu@amazon.com> <20241002151240.49813-2-kuniyu@amazon.com>
In-Reply-To: <20241002151240.49813-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 17:14:53 +0200
Message-ID: <CANn89iKNrU-q9_0cGSdk8nz0GH22CXckBE0cwyNy_-Ta8Gxasw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/4] Revert "rtnetlink: add guard for RTNL"
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:13=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> This reverts commit 464eb03c4a7cfb32cb3324249193cf6bb5b35152.
>
> Once we have a per-netns RTNL, we won't use guard(rtnl).
>
> Also, there's no users for now.
>
>   $ grep -rnI "guard(rtnl" || true
>   $
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4=
UAeQQJ9AREty0iw@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

