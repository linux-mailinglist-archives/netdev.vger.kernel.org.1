Return-Path: <netdev+bounces-63325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC8F82C4E2
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D21285B4A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187851757F;
	Fri, 12 Jan 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8PFK7fa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AF17C93
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705081425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xZfYaYNuXZvjXk1hONaj1SV+qBfniBkapddOB+HTwJk=;
	b=W8PFK7faHSpcVtQGN71ZP6i9m/fUF75MIm6c1gRSB8rDVLuUZ9pRgTmBnrNBYoRUyuvhzX
	k6e8BtE4pfnh00v1kq/ka4CLTS2MJioQCFNd9p/zt8ukvmD7K8Evj1dl+YttrD48SLqZf6
	AE4fL9qmmNTCh/bBXXaql4Cm4eky5d0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-aqdbbXwOMmuysFJQrpg34A-1; Fri, 12 Jan 2024 12:43:43 -0500
X-MC-Unique: aqdbbXwOMmuysFJQrpg34A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5585fbfb229so391216a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 09:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705081422; x=1705686222;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZfYaYNuXZvjXk1hONaj1SV+qBfniBkapddOB+HTwJk=;
        b=Yx0IX3u0wkVoUqsiPxSJJ/Te7+pdtefKp3UXhzGsgymnb5YYgOmJRcD894io60u1FD
         6aBcCze3Z9SglEtNM+z+xL1xfF8draj/8Cbua3Cbw+v11LtuFHCLdCuQQitsgasp2XZc
         QklV18CAn4Mc3V+20L/5YHGar2ur9vxA9hTH8wdQstwVjIkPFaeRvM7wUHaUDT3R2IHc
         M0uFI85GjzmIRnE/BzxZk5kl2SHiSluSNZ9Ux9JYctwXzUGxoZ/KZBwcLb8AwWI7qf0Q
         t9DRinf5X+SoIwGDq8eCdvkh8y+tkzlAMSOTvE3xDrmFSKcskXlk+4LHWyZ/8Z8IgoWo
         IQDA==
X-Gm-Message-State: AOJu0YwqA3Pj/DV2qHK695ITjGxtGvIauMqZ0Tof7xwAv9HOFBC7t3en
	T9fT4AyTYqj2fP4Bfs6fLOktSrBM0ysq7Ne/0P1fk/nJrMqBSAUCf0ms1o4KyIcXCBsPV077Bo7
	W64uGcn+WXjAVUS6BYRWbFkjb
X-Received: by 2002:a05:6402:30b8:b0:558:daa7:394c with SMTP id df24-20020a05640230b800b00558daa7394cmr1188104edb.1.1705081422736;
        Fri, 12 Jan 2024 09:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLx/R1iNlXpbEEsAWhNdq3DoDqYih9kQB1/OctY6ifu/CB1ltmtj7rKUbVELHdLKgX0oCM8g==
X-Received: by 2002:a05:6402:30b8:b0:558:daa7:394c with SMTP id df24-20020a05640230b800b00558daa7394cmr1188095edb.1.1705081422469;
        Fri, 12 Jan 2024 09:43:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-119.dyn.eolo.it. [146.241.242.119])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d899000000b005532a337d51sm2018378edq.44.2024.01.12.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 09:43:42 -0800 (PST)
Message-ID: <a463d0f1a50f51b6ffebc3762c922c56dc6bf46f.camel@redhat.com>
Subject: Re: [PATCH net 0/5] mptcp: better validation of MPTCPOPT_MP_JOIN
 option
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Geliang Tang <geliang.tang@linux.dev>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org,  eric.dumazet@gmail.com
Date: Fri, 12 Jan 2024 18:43:40 +0100
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
References: <20240111194917.4044654-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 19:49 +0000, Eric Dumazet wrote:
> Based on a syzbot report (see 4th patch in the series).
>=20
> We need to be more explicit about which one of the
> following flag is set by mptcp_parse_option():
>=20
> - OPTION_MPTCP_MPJ_SYN
> - OPTION_MPTCP_MPJ_SYNACK
> - OPTION_MPTCP_MPJ_ACK
>=20
> Then select the appropriate values instead of OPTIONS_MPTCP_MPJ
>=20
> Paolo suggested to do the same for OPTIONS_MPTCP_MPC (5th patch)
>=20
> Eric Dumazet (5):
>   mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
>   mptcp: strict validation before using mp_opt->hmac
>   mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
>   mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
>   mptcp: refine opt_mp_capable determination
>=20
>  net/mptcp/options.c |  6 +++---
>  net/mptcp/subflow.c | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 11 deletions(-)

The patches LGTM, thanks Eric!

I gave a spin into the mptcp self-tests and pktdrill and both suite are
happy.

Acked-by: Paolo Abeni <pabeni@redhat.com>


