Return-Path: <netdev+bounces-79401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CA879066
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA63285425
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664EB77F26;
	Tue, 12 Mar 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKlIAMlH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E977A03
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234647; cv=none; b=tZuI+UcTtFxobvn8KIUWnzvuUT7SMQJKbRTITFu8LKFCLfffqHtjJquHBDPQFn5l0C57POFoHhtDijgKr5cIArv5Dq0wjqRo4gv5wBZZDCb6woW2h3qRelSxDU5sJQqyYHcq0/wEX3bI15ctjs+mA/WMtMsO1R9PrnV6XCXu88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234647; c=relaxed/simple;
	bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5Z8+limeWhXrLdMDQYBFKlTZTpff4dBt2n73BZn3EWHrxLxEuadAVL3p/Dlqo2UmKHDDHHpuuRjyCZoCTbO2XVXyZViymVjNKwc73o/+T4k/ghuF56two79vtEXRU5JLx8JPTN5eBzxRSFVBoaPrz7n1F4IzFBkZyalKBclyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKlIAMlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710234644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
	b=hKlIAMlHxuzxIHfmwmIpxl30GJRScSHcvHEqTPgR5+OTT+0Z9ZNqAZLdP8eE7PrB+lv6sT
	IFI4zTGD2mYgFegtkQ6Wcpn9zLCgghkts2sOi3cgoNtiIz0S+XZXiFuaGIZxclsg/k2iDk
	4GLghQJWppskKU5zyFFRBt3l5JJCImE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Buml7EiCMd-4SrH2cnsnzA-1; Tue, 12 Mar 2024 05:10:42 -0400
X-MC-Unique: Buml7EiCMd-4SrH2cnsnzA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso303842866b.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 02:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234641; x=1710839441;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
        b=c0LBoMyI/hvJxWoJS1CJMrIV9JZjcVC+7CZv4x2BrkxMVQLFnPECdmdtS1DPg7bLhR
         DCMvroUWlDmp14u/TlXsDY5OEpHBoY3Lls2eMCtvchO8BGs4Hkv41WNP6q7XRc+SLf+p
         HCHBx/FliWBrsmlvUci9CDJJi6H00js6Rp6BSy5RYHOQQe/ZC42EXYjQVSpIuneA3p+i
         T4EJYX01UvCPelnNQBq4t7/7A2IbenWFww87Xyr9O85tqUFJ+qNCAmrfg3wvu2QEK/cO
         2RetuZPU/gifz+yUJsZcIP/cOsK4yJrADZHA5SKdI0swB5pc77YreSgHeEe6pGwXWZ8d
         YZdw==
X-Forwarded-Encrypted: i=1; AJvYcCVyhJSo5E8GHGKjJl4RKVg8j46ABXt3Yt+lYapenV+2Nly0lBtyV276aKSfOqyqH63aDnByEaLmfOMDs5mnnS2sQkpNsU4m
X-Gm-Message-State: AOJu0YykzPX5IkdS0MgVQJr8WdlvEYGna0l/f7ONxe5wBqe6zVcbPWQq
	URuG838Ts6pw6G9wEsnFpNqMPhGzcRSezIPgaFa/e05+bolgb8LCgpCEVf6GUZVVW9+VyRbJXd5
	N48BmP2PEposGqnF3aHgOuIz00FxCpAWOBX02n8DmsR6kZUYjWsf8tg==
X-Received: by 2002:a17:906:d206:b0:a45:f271:38cc with SMTP id w6-20020a170906d20600b00a45f27138ccmr5282602ejz.43.1710234641723;
        Tue, 12 Mar 2024 02:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4maF56cAVVp3+GQAq6WH2ZI2cZeje5dJfkzEzjFvOejm3qAJ68TvKD0FXaOV+xbAibJG/GQ==
X-Received: by 2002:a17:906:d206:b0:a45:f271:38cc with SMTP id w6-20020a170906d20600b00a45f27138ccmr5282590ejz.43.1710234641379;
        Tue, 12 Mar 2024 02:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2067599ejb.126.2024.03.12.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:10:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 98575112FB6F; Tue, 12 Mar 2024 10:10:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: [PATCH] net: veth: do not manipulate GRO when using XDP
In-Reply-To: <20240311124015.38106-1-ignat@cloudflare.com>
References: <20240311124015.38106-1-ignat@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 12 Mar 2024 10:10:40 +0100
Message-ID: <87zfv3q0hb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ignat Korchagin <ignat@cloudflare.com> writes:

> Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried =
to fix
> the fact that GRO was not possible without XDP, because veth did not use =
NAPI
> without XDP. However, it also introduced the behaviour that GRO is always
> enabled, when XDP is enabled.
>
> While it might be desired for most cases, it is confusing for the user at=
 best
> as the GRO flag sudddenly changes, when an XDP program is attached. It al=
so
> introduces some complexities in state management as was partially address=
ed in
> commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when do=
wn").
>
> But the biggest problem is that it is not possible to disable GRO at all,=
 when
> an XDP program is attached, which might be needed for some use cases.
>
> Fix this by not touching the GRO flag on XDP enable/disable as the code a=
lready
> supports switching to NAPI if either GRO or XDP is requested.

Sounds reasonable

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


