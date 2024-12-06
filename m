Return-Path: <netdev+bounces-149583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7679E6546
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DD4188570F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAA19415E;
	Fri,  6 Dec 2024 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms6W7Nt1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CDC8FE
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458044; cv=none; b=svwHRWAQdfqLY6HPER4DMTbi/6uEXeLlkUWjbA8AetKJPxbF11vGbM38DOYRo8EJvyt8y+cii3tjVRDeUeZs+K3s85xGtTzINprNVA1l8adm3bHS06Xwd1dpUeJPEBL/aaZYzzLUOTaUz8PWf4IW50GSFzuobru7YdQ1IOK5Kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458044; c=relaxed/simple;
	bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFVxwVwKxbSM+RCWAMLDmZBXMs2fBrgx9RLEQPxK6yzXQLwqk1RUbElnzh9VW7SB1r6X2P3QVC7WU55duC3bMQt5bmq7+YumWeS6FlyZapzZ6GhPKMDASsRPGdybCE+KhuHhMVqwMXN2wU4GIUXEptgKGy56vm9N4AdR4pgYtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ms6W7Nt1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-466ab386254so81461cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458041; x=1734062841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=ms6W7Nt1Q1vlBgN16gSsKtMcq0emGF+BAiCn9qzdJsSQ5olN2tl0KhqGW1UlYLtOVU
         RH87GhLhqX/08quaAuhQACOai7SbI+/qY7mnKBZH0NRDLS75ZgpXg5MB4v96R6CTe7Sd
         1j4HQw9L+C72cbNRX5WHwFc5vm1ZrTLQQ0pIm2M67TWiyNj9p0UvlgZFsuuK54brP/9a
         j5p+7iftxC3HC4nG2CikY+B2gr8p+mZFhLYrftL+rP2NLM175ifDR2ym97lD9QJPqZry
         A4UX3iD2zBOouvJTkKKrwxZY8me+GKMuSLKBkVeMNFrVXycFVo+XpCZ/z2YM7Sk8qBqo
         LqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458041; x=1734062841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=l4vx18yGXgNjGsky99ERDhm4JEgiD117nPy5A3MLwfOr7DSLtKvCU8kigBw8EJRjss
         MCixaowb7wHb7UA82vaYL6rz2SDOZVMzltSQ+5OLi3dgv0DjVy2GoySoqgcA5OkL2F7U
         qjcMWRx+w0kZSFiL2j/A/UVvjECbZbeT3Vf/cAV3h5Lk4H4LpSkb+EMKe5BhRSMtqqgD
         9dl21VBEVjrK+pKkNHPUiPVdHZn7zGEpyeAz534lb0GXFAQzmuo0DT53zffJdSQzhj5j
         f+eHG4LobavvCC8P9/6ClMmo1EWANzEhlE04Bmr00NOyZJ18ybnVX+ZC4HcbELqxAf0f
         8suA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1HAJsEpAmzj6JaG8BiENYuDo9K8xwDfiGeQlNthmT1choFesMGwqJ4WrnrnvexQvQ3r3Kto=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWDADjVF/aJuHRrkNQQonnYVvIHLvVTnJ48E690SKSmWsfx/4
	PhV1v9ilqDzxe+H0TX4wfBBisiLrs5JBfo0400a0aJAAm/sUaeaVs8KwH6KeRda9/fXLaoK+WCO
	12mxRmityVgVGtBSH336k4ryZBd4Dkpd7RtUC
X-Gm-Gg: ASbGncv1E4gvGmYe/USkUwz3mcJcm/fNfa0TWnAbBRERGsj26g9HL92/BK+52znjpBL
	ZKT/bV3v0pv9Yh+7/uqmEDyqg5DAjGGs=
X-Google-Smtp-Source: AGHT+IFhNufgJHHhaY4RGILgttSTB6KCwdR4rnZG6VizGxTFxIQRMw1S9EFuvWf4IcRYE183tm/6FiRSsYge13kTuAU=
X-Received: by 2002:a05:622a:4d0e:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4673567465amr2080011cf.20.1733458040480; Thu, 05 Dec 2024
 20:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com> <20241203173733.3181246-9-aleksander.lobakin@intel.com>
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Dec 2024 20:07:08 -0800
Message-ID: <CAHS8izNV7u_opjXvf+WE__qDDxbUiGorodOeihS2EOxjoc2J-g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/10] page_pool: make page_pool_put_page_bulk()
 handle array of netmems
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:43=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thank you very much. There are a handful of page_pool APIs that don't
yet have netmem replacements/equivalents. Thanks for taking up this
one as you look into XDP.

Reviewed-by: Mina Almasry <almasrymina@google.com>

