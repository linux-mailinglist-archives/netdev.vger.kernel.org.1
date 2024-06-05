Return-Path: <netdev+bounces-100868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6718FC587
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D57E282D8B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC621C181;
	Wed,  5 Jun 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9S9macV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7A19049E
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575011; cv=none; b=Zzr+kie4GtmEcpHg+LcDSQ5tEKVbi4p5HlBWNvUStq7FHGPhlgghicufmWJfWHsciYhgKZRLjZMPFSZesdpJ2TQLZKQ/acK7L4BrbV7pfywr7iY8B41RopCyxef9WQsQm0u4ENZ/eiaBNbOzfTYxMj4V1aUwM75m2DJVEKh3etQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575011; c=relaxed/simple;
	bh=3T174Dceoicm7kUCD/y7XPY3dib15KsmGy0OqrQEOVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMNOiSnItWe7Bc2dgiyCA9eHWFUOtBQHWZrpJ1gWC7vg6Wj1DfNSw1g4aaA66HJs9jt7HKV0YkPEVK8ZhPIEK5Nl1QvTWe9KdYF+erQEEps+ENzFVJ8CMAGDZWtrV3LXexNFJaFA9Ohez2sKHP2qa8abt5bD+yivDEvZJC0IcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9S9macV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so9659a12.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717575007; x=1718179807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T174Dceoicm7kUCD/y7XPY3dib15KsmGy0OqrQEOVQ=;
        b=W9S9macVhIq3FZ5k7yka9nNM8QU5bW6GhWY47E1tPYGVMf2Ar6V6kxPlV6pIypg1jr
         MrAUhTsFVXy9hzd4aeuhhkch3EojkOPz3eq2UoIZfJF641sXNXGpOnfChmLnjGBiZe2g
         2nv/P47yCuk24TrMCIA84Boo0DuNAJ3ovqtj1E7JlsDOp9+QFxTazGYPokkyqXDMDwk1
         Ly5wcgu7kDOrItm1I9rxG+4cWkU/yQUANT7NdeXCdvpQWfnyfo/+Rrhly4vGkHEwrCvr
         26Y8Sy28WEH82eg3Cmzsaa9DpQdF/zz64Cyv0SgeoLtb93Ds8S1ir6XhonSi/Ex43mZO
         n3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575007; x=1718179807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T174Dceoicm7kUCD/y7XPY3dib15KsmGy0OqrQEOVQ=;
        b=qWAoMt/QGqzaKW4WpbPQGjaowud43hWiA25sv2NdrQANete8uwK2dcu4WktnpzaB5N
         /vHh6OYHvfRz+E96BZRyKH7AZv7x36a+5a5SRWy5dIjjIjS73w6QamFKkNQ6qWVMfLDT
         60OOefl828Fb975YI9obbRcTvfbiZzePrFXZKaIU3bcz9oEpscysgk7G8C8kHicYmyGa
         BLoP4ABcUborWOhxvnzGyh8JDLS6QdixlOwq4KoiJUF4HIY16znIX0ZrwkUwUCRcsAgm
         lBOSHyLMXBVURS/jBuw2cQvZDnNPHJe0zXLVkKCMeJHyhUYAVFFVXhxu+vxn2wrMzQwc
         jDPw==
X-Forwarded-Encrypted: i=1; AJvYcCWIXS0sjlan4VOnvPmlyeag81fq3cjqWfzuDZAZ5UZZpCqeAo1OcFQHXxs2i/CZCeLVeQF1PZbe4lFn7W/TVX4sEg4aU+E9
X-Gm-Message-State: AOJu0YzwJVdfpDX8Po6lhVGExVKGZE+fjA4nFq4isqiavxDRbxgE4i0z
	O/y/M/TCWPgDus9DLMkgcFmuvziMLFaDgZrW5V1RAVbuJTcF3q5RmHfSVOZvohW89wcYl+Ph9WZ
	7muc+mi3ihkrYcKXa0XL8OA/GlnNbSotCeTmx
X-Google-Smtp-Source: AGHT+IFHJQQ7/NDVyqJbqUGkdoduFW8ZFDMW1u4Nz+gk70EjEJGUIexCHfm07OGdLX5eLDSaEBU5m9EO+DfzPVRzJpg=
X-Received: by 2002:a05:6402:31a3:b0:57a:1937:e28b with SMTP id
 4fb4d7f45d1cf-57a94fb3c0dmr89289a12.1.1717575006236; Wed, 05 Jun 2024
 01:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-5-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-5-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 10:09:52 +0200
Message-ID: <CANn89iJtAPYb_N8J_uvKDV_C=rJ8MzzEuhaiRvFs32giW-30EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] net/tcp: Remove tcp_hash_fail()
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Now there are tracepoints, that cover all functionality of
> tcp_hash_fail(), but also wire up missing places
> They are also faster, can be disabled and provide filtering.
>
> This potentially may create a regression if a userspace depends on dmesg
> logs. Fingers crossed, let's see if anyone complains in reality.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

