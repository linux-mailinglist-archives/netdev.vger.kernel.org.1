Return-Path: <netdev+bounces-101303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E58FE15E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984D91C247E6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0713AA5E;
	Thu,  6 Jun 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFlmEHOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CA7347A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663528; cv=none; b=qaVkkeZ1KCdVKEh4UYK4rIEJdxOj3Xp1uONUkZ9CYJlfb9wHa4yANNBz+qwjkO+rgXXAOO2jo662TLAxR6Q05JsVGkyjNOXGpiteAcx7Qxv11ulg0R9Iz2vSRXFaqcn6GGE5K+LTk3WfxWqKGXZuzIL4bO0ZfAJMtFCkr9bYQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663528; c=relaxed/simple;
	bh=KQW9JtQlekmnXbieobjmU0ltBqQKghgkYqKnFqj9Qlg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=A9cgeNk7NcgJ6Q05D6+uu/rxf5ctZ31Fz8LkxUgtWu3Xs8pQnrMUnlyVQ67mC/Iy7bWfTNFCqxE1AgJjEXKxYg+v3PKNMEYBp0DNgDwY6ceqKTBtRrQ1hpzRDkVD94UsI33+sou/Xo7nWjaIDb3oTuDFTbot+8GA9P5g6o7Rh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFlmEHOw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a696cde86a4so64237466b.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663525; x=1718268325; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQW9JtQlekmnXbieobjmU0ltBqQKghgkYqKnFqj9Qlg=;
        b=GFlmEHOwjvnRrAH/jtc6HlAcdMqAJAJz8T6oH90mmS6ano6NM7fvd81FvB/nuQKGbU
         dE5IFy8W6TkDr3sUrBpMEtDLcWQZ/a4fTgYBSwarNQc67Vs4plnQ3hWfYriKV4MJhLdc
         iN9VoSazBAsmi6w7NuBdBN85foY4ajTeruXAk+NCuf8wVGXxFMks45H5Y6CBFR1I7ls9
         8SGOAiHN36L+2J+ryzAlzQstSa5rLs+gNwkCEanrVoMcfJKXHtar/Hzyotb8Za8d/Iov
         kFHyJi0biFikRWyl+mypO6TPfxpNrRx5NPVPg9Swgk5Zd+glgKdcIc8VxadIJictHZAw
         zn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663525; x=1718268325;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQW9JtQlekmnXbieobjmU0ltBqQKghgkYqKnFqj9Qlg=;
        b=gJJFsBBIx6Mc05nHRCfuNH5yiq0y98XaETkGFR9FO3FG3QFfT1J5vLLXZTeCINhWIO
         aYG2NSzui4Mp1cHe7A9VcqkvopPq/FNviOlwGbEc06AIkazQWFJqodg90UkxPCoDvI8b
         Fz7sz0BhcRbzthfWSJzoREJR2hcfQzV379B96ZwGtbmn0LTonOH9umw3swVvhtfwygEx
         19CXbLnqAKO5I+gsYolT1ppu2C7f3SRKZPIyEIAxpK4kle1IcjDvIGuqEjQvb7ZhIZ2n
         kqzgdFCLZJ/24wEiHk69/Wg8q/AO5cFfFpeYBiz+sAwjDQgmpfME6szVIw3El7weIG80
         iZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVwm9YY3fgaQK8sxY10kRq+093EIjIeo4ZAlrOJyTIuKhMnfmigzXK+yy96j/dcpmooY4HvBo/Tjyy5itkhIMB86+YQ+5qh
X-Gm-Message-State: AOJu0Yw3XqHdEe+rW9VRqj53LiQtJN6cR7wtgfjBJEI6IEs/G1YtGQ62
	rNwiOToRldLxKEEMHkItZFyXHsWwBhWQavPas6vv3Tg+bwA2FkGx
X-Google-Smtp-Source: AGHT+IESYv4P/Y8laCPDoWbjyUVlU74IqKnVqPL2GzqUV/ZmCeVcZ3QiCyz7ZaykqdG6C+EiaiEq0w==
X-Received: by 2002:a17:907:c909:b0:a68:8784:e0d1 with SMTP id a640c23a62f3a-a699fcdf86emr262386466b.48.1717663525366;
        Thu, 06 Jun 2024 01:45:25 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e839:f9f4:6f15:88bc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c8bfesm64888166b.56.2024.06.06.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:45:24 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  Dan Melnic <dmm@meta.com>,  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: make user space policies const
In-Reply-To: <20240605171644.1638533-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 5 Jun 2024 10:16:44 -0700")
Date: Thu, 06 Jun 2024 09:44:59 +0100
Message-ID: <m2jzj2mpdg.fsf@gmail.com>
References: <20240605171644.1638533-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Dan, who's working on C++ YNL, pointed out that the C code
> does not make policies const. Sprinkle some 'const's around.
>
> Reported-by: Dan Melnic <dmm@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

