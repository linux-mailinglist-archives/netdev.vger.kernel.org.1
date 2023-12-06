Return-Path: <netdev+bounces-54670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F231807C7C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDACB20F77
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADF2FE0D;
	Wed,  6 Dec 2023 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWJHqiwm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AA122
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 15:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701906170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
	b=ZWJHqiwmIM3l/8iKwUPHH3TdJXdnPKTZv58w4uHWX5bhH5dj1+H7hj9M2fkjxrQt3or5M4
	mqmF2BFa1ui7qXJszLZtHzUhyP1aazLRFilzSqQrlaVxvka5MNiIP1zH8MZ9uXX6AQYWNx
	hxLZak7eNnB//tnF62sK9W49HRqQf5E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-01Nf6w80MJqiurroJl3w9Q-1; Wed, 06 Dec 2023 18:42:48 -0500
X-MC-Unique: 01Nf6w80MJqiurroJl3w9Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54c504e5fd0so174366a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 15:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906167; x=1702510967;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
        b=YGOa/VxRpgPyLGxVbLAogVN+6s8HhA2UYOX1uwkSGADU2PhZrqYMVvNEZJwuZiVkIn
         tEstxNISq7ZSVjewyjT7sT8X9zsFusp4L+yE4bpnOza4x1z+SWZPIjwqs5Y8VLdvzn3m
         3AywAL012hyoMOR7+V3FSg3UYQBm868Kd518VinaTE8jOq3wzBgIdxxbKEfRK9sigO50
         /wPCkKS3WiBQYTzxrt044v1FdwvJReNbPzQj0Isq6zdXD8B8znG1J+vBXK4Khz6acrSo
         YtL7xl0BVrBdge5o9CA2M437UAPw8OYupMuEDUBmXebKtfMnMAguShVvK+w1el+T3MQS
         FN/Q==
X-Gm-Message-State: AOJu0Ywbke5BIEseSvfJPhclsZbFtxXcxX8yn8b8fuzuR9y6QIG4fCWF
	5HlnMlf9AblY3rh9M8W+sM70v9VoLfAxJaOfUjt+gzzlV5n+F+iivNmOZLOMUA5VqGj7xdeZvgC
	J9rtaNXcP3QzSw/pV
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226992edd.29.1701906167713;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7vRlA+d/H97Tnlmdjl2ipDcurwnvVNGgVnqnqh+mn1wCaJMNyLFxRFkKmPIdyJdpL930WWw==
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226972edd.29.1701906167447;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a509515000000b0054db440489fsm80993eda.60.2023.12.06.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:42:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2CC53FAA7F4; Thu,  7 Dec 2023 00:42:46 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek
 <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
In-Reply-To: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
 <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
 <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
 <20231206142857.38403344@hermes.local>
 <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Dec 2023 00:42:46 +0100
Message-ID: <87sf4elwy1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
>> It is not clear to me what this patchset is trying to fix.
>> Autoloading happens now, but it does depend on the name not alias.
>
> There are some more details in the thread of v1 [1] [2].
> Does it clarify?

Yes, but this should be explained clearly in the commit message
(including the reason why this is useful, in the follow-up to [1]).

-Toke


