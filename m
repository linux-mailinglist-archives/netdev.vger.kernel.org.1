Return-Path: <netdev+bounces-234491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01323C219F6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834F41AA25EE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378836CA90;
	Thu, 30 Oct 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LWcmn5EG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34236CA80
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847071; cv=none; b=OvR35EJ+rUGzzRabueyGh6c40bl5Jxpl3FYS5TMk5bVpk4l3g4HBBacR7Uw9KZLMU6KvGbPKl0jPPsycdGNvOGhtrxV8VYri2zLPr3Aw+uYCEtH818joGtHfNPzOnoIsNGhnYgZwScj7QyF/jHD4vnD+/vnmJ5rbOohd9dn20BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847071; c=relaxed/simple;
	bh=IW22uea8/KAlKg5cRa+wG6k1lKrnIVXiMtydHysWUd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck3FQcXnFFDHyXTbJ1ZlHZyDbaNklvcarmpZoT/UUfYg6EduX1Reo8PC4ZhTvP7doZI2swyuFKoDY1rGsSfpZx4QPcWJQtOS+Py1et21zOrdmiCksWAJAMTRcCqT6Qz0HRkQ2klztHY4cLnde65iShDjEDMysVbjXyt3K3AaX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LWcmn5EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912C1C4CEF1
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LWcmn5EG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1761847068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2H0PpQjDWHMkJmyxV5TLlWq9KKSjqqnbP4MvuPcJ/Q=;
	b=LWcmn5EGXm930fUDwoiM1sOw0MUVPWfEnn7aULl+1ZtznZfQ2CqWfGW6HMJx0gsOKdt372
	mm/+K8s8ipekg5mc42dAUIXJtkQwF3XqV+IY4VQcqL06GF8ILGxKi81x/KDen7Vnvqp3L6
	4j1JqYNx4J7AHbWVNSQmVX/ze73vgbo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 73b48681 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Thu, 30 Oct 2025 17:57:48 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3c9975a3d6eso527926fac.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:57:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywl0aI6KJDm4r3ndQ8GudEmBrz7iv1E4ZOV53zuI+S6dRhV1Cup
	cFwB4cMmlxvcBz4BnkbrSbBUzYVdZBiYtnBzKy/RbflPNJQscCw9hNREhIWCV3Vu6xDdTv4pBS+
	YQCmt2B4+pl/+4hh0FkzOhQcJLSOOxE4=
X-Google-Smtp-Source: AGHT+IHtgJsed/7P84RKFjGZ5mvrCABKn9vY0NV4QFQEy9DUtJZHaS2vVgl5bNeZPw+foREZ86PeECODJf9jigWHHeI=
X-Received: by 2002:a05:6870:d361:b0:3c9:43b9:f30e with SMTP id
 586e51a60fabf-3dace29b802mr220347fac.24.1761847067954; Thu, 30 Oct 2025
 10:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030104828.4192906-1-mlichvar@redhat.com>
In-Reply-To: <20251030104828.4192906-1-mlichvar@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 30 Oct 2025 18:57:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9rG1r5fJfubpcyK99g7G9YvnELq5+iW-+ms-Jb9dwPk+g@mail.gmail.com>
X-Gm-Features: AWmQ_bkmTcv7m9w0feoifZBsBj59MlIJMMDl44XMV-YgfwMdK8cxQTUF1budhtc
Message-ID: <CAHmME9rG1r5fJfubpcyK99g7G9YvnELq5+iW-+ms-Jb9dwPk+g@mail.gmail.com>
Subject: Re: [PATCH net-next] wireguard: queuing: preserve napi_id on decapsulation
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miroslav,

On Thu, Oct 30, 2025 at 11:48=E2=80=AFAM Miroslav Lichvar <mlichvar@redhat.=
com> wrote:
>
> The socket timestamping option SOF_TIMESTAMPING_OPT_PKTINFO needs the
> skb napi_id in order to provide the index of the device that captured
> the receive hardware timestamp. However, wireguard resets most of the
> skb headers, including the napi_id, which prevents the timestamping
> option from working as expected and applications that rely on it (e.g.
> chrony) from using the captured timestamps.
>
> Preserve the napi_id in wg_reset_packet() on decapsulation in order to
> make the timestamping option useful with wireguard tunnels and enable
> highly-accurate synchronization.

Thanks for the patch. Note below:

> +#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> +               skb->napi_id =3D napi_id;
> +#endif

Seems incorrect. Although the union where napi_id is defined has that
define here:

#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
       union {
               unsigned int    napi_id;
               unsigned int    sender_cpu;
       };
#endif

The skb_napi_id() has the narrower condition here:

static inline unsigned int skb_napi_id(const struct sk_buff *skb)
{
#ifdef CONFIG_NET_RX_BUSY_POLL
       return skb->napi_id;
#else
       return 0;
#endif
}

So I think all we care about is CONFIG_NET_RX_BUSY_POLL.

Also,

> +       } else {

Why only do this in the !encapsulating case? Are get_timestamp() and
put_ts_pktinfo() only called when !encapsulating? What about
skb_get_tx_timestamp()? I've never looked closely at these APIs, so I
don't know. Seems like it'd be good to check into it for real.

Jason

