Return-Path: <netdev+bounces-87764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6D8A47CB
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E5F28391E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 06:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DF5672;
	Mon, 15 Apr 2024 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ty0ZYcFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998C1F614
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161311; cv=none; b=k3wHW1uQtocH3I2iubjpb/8rDZCisYbF1f1SZVnHqI9Bary6T6uFvHA1dox29925hXM+RZI+zdPiyTgWb+AZhK+DEwEq7o/6HZVOTbPFBUDIO2cT+mD5oJ5OkwW2E6j/qES5FSJWhDmL86jg75iq8zE7BzVUs41syooGwJDjHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161311; c=relaxed/simple;
	bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQEKpcV/n/CtYHiYyQqThDisYWLZhMMF24UkUAntUA7Gpmvu95ZtzU0IrivkFcJdqDZ5uH3LzVMCnm80TMH4i7nDt0Bce/MZKWFtUYVh6mN4LUIsiv017SUPWBQg2YsrQFu8Kz7qCdcBleRe44+824HuKp+yTR9cp+ZXkuUXpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ty0ZYcFK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so9044a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713161308; x=1713766108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
        b=ty0ZYcFKVu229Bkm8lx8lPlYlAfWH7kbODam5GwXEu4auuFwz1aPJ2SKImhWqzlxba
         Pb/9OXACJjNPJU5xqvfLsR4k23qAvOwzpTYCybq1fcSdIK58lBZs21yCKk0+JvsWQGF8
         CYb6W2oJHZL0MjO1+B8zrsTV7LGeV1/3LCPVX1NOzjn9Nb6csp2sLzjdbNipwJI2SFzo
         QjiW5MCmYNGofQLqD6gba+JrWa1Xj0ObSIa6ARB62cLwLF36+dxuU+f2RpI9eXOImzro
         qYDSDbC+gyAIBTL1A4MhX/tBbo9UHgmWxsM7Qu2N3npXRKePIXUACG7wFyxJjSl/8dbC
         OOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713161308; x=1713766108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
        b=XTmia0b6YJAi6MdtjpOcqYkgNzw6gXT9t518K1IZUXlKokxvF1Lo2WuZ+P9Ng/ixzj
         wMPBvapRIvcylzUQ3bwAp6lNt8rt4mLNTosDtZ+BbHsd/ex/MdPZY9Mb8ZDaCGtq067p
         exqo+rdGN3cKLCPoI3AYX4lxS82xVI6PBh5G1CowEEC+U5PPd1/WaDh4iSQRLjN/+uiY
         9fDAUEnclVFQLQ4Ytmm6JwI7eG5DCoHphE7GcI/qXRQ+ADqAab5VktYHYYf/fE1QV8Fu
         pLM+hwcoYLDQHlpKFJDHvaTixZIXcqemRuxpisMlQgGU+2uSEUZkFtm/ArNEv7OEIpxm
         aENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzCeCOXojGGtyubaooR4Y353rrTvZU1wGUoF6mBmUFmJTo5sdf6l1nAOmZWPsmc9aryDEjhSr+2LYu2PnhZWAUWOMwiLsv
X-Gm-Message-State: AOJu0YxFEOa+0RTFlwo9GDjcBLLJ5xbxmifLbFqHaLFVtARjSr/Ze5m8
	aJzwE4JqCZNnZblI3zaIYqGMEQ0jVtLMX6HM5F75eaEt4XdY8ld7GIl/CZT3IXy9EBeYsLCXW8S
	sao/N1kaERxmgEoVm64rBK7cvv6/pjESd9kF7
X-Google-Smtp-Source: AGHT+IGkKQ4N0s3PGi6BIB8WtJWu2/RvtunZs1E8+AV4HgGQK/X0CNWjK8z99EceRmHAgAj1bJOUFAbAysAoWg64+Ns=
X-Received: by 2002:a05:6402:34cd:b0:570:2bbc:77c6 with SMTP id
 w13-20020a05640234cd00b005702bbc77c6mr54200edc.3.1713161307799; Sun, 14 Apr
 2024 23:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415020247.2207781-1-lei.chen@smartx.com>
In-Reply-To: <20240415020247.2207781-1-lei.chen@smartx.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 08:08:16 +0200
Message-ID: <CANn89i+PMxOks+ZvHendXovZ_CHFJcUyqT1GLpSk=2bwS4SjGw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] tun: limit printing rate when illegal packet
 received by tun dev
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:03=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wrot=
e:
>
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
>
> net_ratelimit mechanism can be used to limit the dumping rate.
>
> Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

