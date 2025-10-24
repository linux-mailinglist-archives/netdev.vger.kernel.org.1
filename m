Return-Path: <netdev+bounces-232530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E1C06457
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65774E136B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55B315D3C;
	Fri, 24 Oct 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rA/xKWXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D562DD5EF
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309244; cv=none; b=He0289BrZGYvfl9K4UHPEdTi2uoiuoKiHp1jlp+2pvICVXsn7zFn5i/nY5G/Bnu0SLm7cCET0yZUup5lFpe8sIyIUg33AR+4yGbpoz75noBcMUSdX2T27RES94SeuqnckF+v4ttLF5PrIh8wM9ZuaVVFPyhoerzpnCH72pMeJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309244; c=relaxed/simple;
	bh=EbljtvjF2yao3HtbfBt9tU/PRjhMRtsx1WLRywsS2p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrvih1Uw/JkgEpPpzMGq4BmONYVFBAtsTFo5/KVp7ya8jMvdq3VTgxhukmrHuohuyRbOQ+j76vqhaIp9JxgaO66R3/JkU7z8qDjxjnSfkA3I5HtYw0Yh8HaK0Vr7RB5ZCt4c1kwj9o/5jNL8H0BVcOdlHY+1nWoJxj3BNIHo0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rA/xKWXe; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-781421f5be6so22783197b3.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761309241; x=1761914041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ww+Sf6Zad31I+q2xI2rPMkY6AtTsh2Gk7ESx80POzw=;
        b=rA/xKWXeUMS9s760hgiIY6ajngYiOUbthOECfFfS+SQnpLlnP9G+wXBjNlaDbULxBi
         Q7EMeEOhD0flkH8RemPrJbLqtuJT/KVyRDVl6Ew7bI0sh5kZ7orUjFF+1I3rqR39a5B5
         Y3ayOf3nrsuMpdz14CHU+VxIihn/zdSFl75N7An3Lxm2D9j5NAOaRW3fs3ZbjQ2JphsX
         TGkw3xI8guZk8Y6qgmvyfVaDJgwRzC+/zI1UDhmkx62DX+04hKYwsWqkMhN0Vxrzfy/U
         wvvPav92ezLC5dxMV3h513VAQ8IJOfyJ45XIT5pww9FZl3hMM/WxlDuEPLsjcnZPlm69
         ENqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309241; x=1761914041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ww+Sf6Zad31I+q2xI2rPMkY6AtTsh2Gk7ESx80POzw=;
        b=BaiEsYoIiJxSKSZG+xfBaAwc3IGGKGIE8Ld5FiC7NrBFepnjPsMZ7vEY5CwfF4qZqO
         p57QHNnxTuszje0jgWUj5HlGruWV8BSqKsGd4nHmu8prlLY2LyF2Eh6NLmR+os8F+6z2
         +zQasM1U75BvDSpW8fIOwhyBwt5Zr3OPEDKGqnOoRX9mkTOEntIRGB5Sk2ZV+s26r136
         RROttsu4vbcs5O3rJ9DQ9Gz/Za6vrk9711GjvXSobkO8UiZWGbfVEegCsiN87RWriqbw
         hTaD7q0hpO0JqMCeR+KVDtST4O/0NgEy3TE+K4xqkN+Ifs7xxz9j7wtj3afzM4Fy6qj5
         HbnA==
X-Forwarded-Encrypted: i=1; AJvYcCVElB6L+nZ9mw0KB49YdjH/ZkeVL25Vu925t4pSOxzVTsv+xuMaOAjHEtQCZ+AIq3aINxbLOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2F5las+wEJllTyVODYNZStQ9Ti6Quyj4gx1kOJqp9c5Uk0s7
	3MB5MPduPOIycbhpSju8pquhrTiJKmLRzkmVQOoYBuMtQ5rAnQgSF/CX+uL0jD0gDiHUffcwADY
	M+pmOPo1n8MjeGfLU8PM98uoWKgALmjsdsxF5MQf8
X-Gm-Gg: ASbGncv+cb7Xou4m3/1Tc5ve8NZJI+YBymHKuKoquka8TzG69mDo2+HUMjuAhFSTmAd
	u58NXzVwpnVsLqhbzNbXlApMVCoUHFaWLXTb63aNTfautL3Df5n0ZQQE5YzPDbO8yczmuSyJzfl
	m/FwoQz0zTdr+4LqPVlSFGIeZpbaExD6w9r/1lmlntbh9Mc5iTX9WbAK6mhBxC2zVLZkGUY5T9Z
	UpVqIsDWWzgPMZTTfEKvhbJGh56POEk+RUut3iy6EWf7YQfEVQopO6Cm0KddqqNGo1Xpw==
X-Google-Smtp-Source: AGHT+IH6faZH+je2EtgyA8ASqeu/+dFhcPQHGgEYDJCRjjyFrrkdzmGJWFcCy30MHwkoH8+aVIRIkQKr63REYMSkPjY=
X-Received: by 2002:a53:d015:0:b0:63e:27e7:c792 with SMTP id
 956f58d0204a3-63f434eeea3mr1438683d50.24.1761309241265; Fri, 24 Oct 2025
 05:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-3-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 05:33:50 -0700
X-Gm-Features: AS18NWAzWxWCkg3sJjTn_7aGa2cI5wC6VEfiwzlQjp4L_4P2rt4x6Lad8XCdpuc
Message-ID: <CANn89iJSoijSbzagUEptz=qp9p+WDgZR-Uf8099j7ahaqce+nA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/5] neighbour: Annotate access to neigh_parms fields.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> NEIGH_VAR() is read locklessly in the fast path, and IPv6 ndisc uses
> NEIGH_VAR_SET() locklessly.
>
> The next patch will convert neightbl_dump_info() to RCU.
>
> Let's annotate accesses to neigh_param with READ_ONCE() and WRITE_ONCE().
>
> Note that ndisc_ifinfo_sysctl_change() uses &NEIGH_VAR() and we cannot
> use '&' with READ_ONCE(), so NEIGH_VAR_PTR() is introduced.
>
> Note also that NEIGH_VAR_INIT() does not need WRITE_ONCE() as it is befor=
e
> parms is published.  Also, the only user hippi_neigh_setup_dev() is no
> longer called since commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS"=
),
> which looks wrong, but probably no one uses HIPPI and RoadRunner.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

