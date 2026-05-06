Return-Path: <netdev+bounces-284781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJL2EQ0V+2lLWQMAu9opvQ
	(envelope-from <netdev+bounces-284781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3204D9370
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 892D7300D366
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E07401A23;
	Wed,  6 May 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2FUcgwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3657393DF5
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062596; cv=pass; b=XAW8icY6ZpLOFjI8/ijPJ6VvyhXnh4YlK4dbuzAkdmr/7Wuyk2dWivRKQZKhKV4v76b67g9hW4DXIQQFuSKA0GunSmgl8cSFSohE7LFJ2ZiIjlMg0MrRPt+rJ99pEyVhhDNWIwGefh5CkMClbvSlPzI8n88fikvLsGdL+o89VMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062596; c=relaxed/simple;
	bh=SNkH8OtaRLVGXASvNUN4E6u3qaiwAnN6tTC9hWYsGa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf+0NM7ung8ssQqJb4taQZJ7ylpYk9Ac7jUzzQ6h+QYIeO7ga4WnpV1tPPrp8S52Fvd8nmku++XbNTYtRLqE2CoXEQ9gUDH77WLuRdXqxM+y5rhPg9P6w3f9ka5uCFlNtagic2uMVmyQxSrlDrLkKUkXU/eJe1AY5cJ3LmTXYJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2FUcgwd; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506251815a3so51182861cf.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778062590; cv=none;
        d=google.com; s=arc-20240605;
        b=Uk+O3BjX3DpvG5H6p8Ifae1OgKU+I24itzei8nKy0iNbQLTqBRkROx0kXz/WuUCOP3
         DlQ14mgKRC99X88d5oyJBa64VnGWU9E52Tpmd8UWFTx6QMv0BvrohiBYSq0IviMC8eee
         80Wh213e5OldG+Kn7XEbG5TQ7pObVRQjXNKvys6HP6bcXVEKXZqS9n8Hx16BY9bihnTu
         327mj6UWw+Zug01C0NH9iH4/VAFRdFAqc2LDuh1V6lj7qRiwHF+cg4IKRWSbldHUJhhE
         99M892PDI4drVi13UCcEnQT2XkFk4cHDWVxP+OHjPZT+NvmYbzRfW4zZ6cW2p8bColen
         0cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SNkH8OtaRLVGXASvNUN4E6u3qaiwAnN6tTC9hWYsGa8=;
        fh=V1HG3CwUYQ2vuQqefECO8hjyP0WT6eKgPgQ5SrzBFn0=;
        b=Zk/xmbO7NmWRY5PJVvkdQ2GQrOvBg0OLkg3MOx7Wvz3U4m1j/46cDXZpJfFW+LQTLr
         3ZBytlhQ7SkqU6QDZ/ebuXMEsMOak3W9wYCC4MTPiXwqaqcJ9iEq6TBlfkY4JvGM/msc
         opx2yp14QKdkDEqW9Wms14vIbHsiKO9HJuh1JoD8b7CT/d3dCftVRPr8ahrM7VjdsbPT
         nDQLc/n6aMbthWx66//UNueHaYOF736n1AqiT95ioRt29eKrd0E9yTRf1DCZuCDhogKO
         Rbnqu9pPtOTrkI1TnLVibF0o6a/W+HpTc4r1odouKm5b6ljgZfIhPDQVPTysVST+lo1E
         /zvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778062590; x=1778667390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNkH8OtaRLVGXASvNUN4E6u3qaiwAnN6tTC9hWYsGa8=;
        b=T2FUcgwdwP/8cbWq07b8LO/fhAhH8/K3t2fHLmIlF2/Cj7O0QNS3QTFj+bUKIwZ6C1
         y2VPlpD1gSKFOFb8QpADIe1wUThNTuaJ3NNLuYcozh5bjvHxCS8cqRaGjjTQuwj/8UwW
         W3J05vrq0e0dN2ziBsGly61qa6YCZLySDqm6tmXBxJpzkp/i6wL0LiAxly6lxybGd5jR
         vD6DG8B38EjmZQuasL7XdAancRo5zmbL8qqzwIkIvq4EjENCmu5QP44IBf4GqZXDVl87
         YazvP/FDvO+ny9oLX/pblFmT7cj594C0l+v4Ckr9pSlMJ3FF2AVivSJwYc7U7glKNDTq
         JT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062590; x=1778667390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNkH8OtaRLVGXASvNUN4E6u3qaiwAnN6tTC9hWYsGa8=;
        b=nm3xYttU5KAIxajBN4tKaVcQZ1Gd+0Ml1Iu7nU74tOiwzZoN0C7IzCXv0mLYMixh32
         El7dK3jzwTeiLQVAP1nbZCNS2d+PgTxhUCMMY7H0hY7Ypv0uM3SMBLwS4xJ8qGKdSk2Y
         UedZFgNzSVbaq2VxnOo4/jFJ/b98gISnVUPXIMK4+zOLbsEzw+nrR4g17YN3bcF8J1oJ
         6ZHIcPagvinC4zNDfBSydFqf9d89RM1QFXuDuHKt5wTmwqCL/o43BjhxiRItER/JmzCx
         pl34aY3f3WIXb/ELAHWu2GGE6zyh0ZsC/1ihLraDq63sLErRrbQDPoFTL3DOpM7meOR+
         M/Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8N4WXqDh2/ls29v0Cb80dP66A02PVMqRh9mS8ebeAL19h1hv1vwqHRGbdO7FighPf6/ZJMsfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsPbqPh78lYGuvtU1z/9bIsEgvewbbEi0NETAUjpuzHkXAxlE
	+0DLmTfdHmqzFpvTjKW4cFcWn2pAIJJJ5flDaSMEJ8spEfRpzu1A79DatK89oC2oJfNacSd1qve
	jefL9VEQ/E5WNnOQjdiM3nDEkIZbmYV0aF6aVCKUk
X-Gm-Gg: AeBDiesAYVIMxQkI0iuJe87fau7bM855qcWnFPt4m1jY0Tpz2a+x/HBS/7E/0yOnYmw
	h91snhQfAKnqKzdcHXIDdumH4jAI9vhBeD1LSMpH3dv9h1JZTwrFYFTEKvz8oV/AiKQNCkz1wMr
	oFH0kpiNsNUjGA/Hzh0QxEKpMN/bOInvxPvR68/5py4V8ZwSjQZQMmaWGHcf3j5IhiCInqBxT1e
	FCqwrQI9cBkb+aegaLJqQwWHO6i9264pwb7j8FPx9DsY/KAFArEJYcnRLI9iYGTTqF3cn83v8U3
	OY/Or1U4tiqUZZpJajZSi/Gh7fADrl0je70OHcTpeBKjqNAla1Il1vq4ZLlzadcug8D2o69tbXD
	K14BwnfDI5yuWmI8RUhzKXhtM/mWM598cku49QRE23wYJO7GFsg==
X-Received: by 2002:ac8:7f85:0:b0:509:127d:ee06 with SMTP id
 d75a77b69052e-514621efd89mr36894551cf.58.1778062589358; Wed, 06 May 2026
 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506070443.1699879-1-kuniyu@google.com>
In-Reply-To: <20260506070443.1699879-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 03:16:17 -0700
X-Gm-Features: AVHnY4IEtgSfBytYiIiTv7sBPb-kxbo4THDjNeczxK_ImkA5AiZB9pCXjwyR5Yg
Message-ID: <CANn89iJrxfLJ83D4bsfXE5pf-NtAog8ERK8cQB6hfOt1re=qdQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix dst leak in tcp_v6_connect().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0E3204D9370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284781-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, May 6, 2026 at 12:04=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> If a socket is bound to a wildcard address, tcp_v[46]_connect()
> updates it with a non-wildcard address based on the route lookup.
>
> After bhash2 was introduced in the cited commit, we must call
> inet_bhash2_update_saddr() to update the bhash2 entry as well.
>
> If inet_bhash2_update_saddr() fails, we must release the refcount
> for dst by ip_route_connect() or ip6_dst_lookup_flow().
>
> While tcp_v4_connect() calls ip_rt_put() in the error path,
> tcp_v6_connect() does not call dst_release().
>
> Let's call dst_release() when inet_bhash2_update_saddr() fails
> in tcp_v6_connect().
>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

