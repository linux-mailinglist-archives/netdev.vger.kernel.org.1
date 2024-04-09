Return-Path: <netdev+bounces-86208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45789DFE4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E23282210
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E941137937;
	Tue,  9 Apr 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea7iwEIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D78135A6C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678397; cv=none; b=rNbyAzx8wJgBEYgoFuf4BEJMxP0XhPFq6zzLIY2gMK/AFkfhxZJJi7UWv/Lf1n5mgjwo6nd0iVDlwV8VqSxHmftsnu3s3x70Y+5ZMGZ7Y4Q2MVdVU5drek/QWC+UotGCun99pxzkfkrPhOYApPTiGCv77PjAacjGhs7Msydf9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678397; c=relaxed/simple;
	bh=R/UKSJmmZmpmPfrid0VP/uklt14bKRE2DJxN9wKrclk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB/f0IKrOJVWyalUsnZpGab2dQmziDCVgAe7lANKNuI5bfCcj7zr6SwvyVOiuNgSM+VD0XzMtvAmLujtda5UBfmdCF66XV0EdZFqOf0T0TwqlpziBchjLjmM219GjSmXEtD47jioteJqNBlQ7rZB8zA6RErs0nuNChB1o1Uw6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ea7iwEIb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so14039a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712678394; x=1713283194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/UKSJmmZmpmPfrid0VP/uklt14bKRE2DJxN9wKrclk=;
        b=Ea7iwEIbB1his7GskUl+II/tP0hPaqEqDan+qBPgVjb/0hv/xayCEoQtx7vDRTKQxP
         9Uo2PSDvXHyZbErf4jSxRWcN2Xzo3I/Rkzkilb1L74PLt7X4QspIKS00n/HMzmxVlP0l
         D8Q1IKvJZq5IfqbBj1shIveOlvdzPCvHCYejMknJRz5ym4UEuKrdzxQAvjrVzDIH78Bp
         2gwCNCCUwGhKgArr8MwdmMjtAyWfWxnQksB7YHaamaMJva0XC8lCk6LkO6BMFfKA8Dil
         qcHzH0281DUL6oOX8CbIdSBGapRIWk8HbvPKPneE3jhi39YXr5ll71nYm0tfxVGp7mBs
         BXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678394; x=1713283194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/UKSJmmZmpmPfrid0VP/uklt14bKRE2DJxN9wKrclk=;
        b=hywQI4DUh137YUphbfECWtCjZemusyeejsN96ixnVGkaPdPxse+l26HIke5HSxY31S
         5+i2mZQ25yqqdHh5pVpTwI4R6g1jobekXoYpyy2PxzxBohlNkm9VREQOVjLrFXjiV+IP
         h9yk1vtR+elJiqvmFXN/R0CWpUmEAUEW4PTy8xi6VsFin8oJ3Pxqpfv9ynRDoUwfRtjO
         nc+KYz6S+OTR/wvR65SrBYmali3mBURtLs2CIhpGey8dWdqUMRtdAp3KSWoecvWfFEYe
         9K+rnlxDqPs3ovq4NKFmfdHHTZZIBJQy+OF1UvZyA3SFckzyc4DoWiLEo6C4Lc/9XeiU
         K8SA==
X-Gm-Message-State: AOJu0YzdtDCMPoPUIEFHgl5UoX7VbcPt+8emVDuzbPB1lKOLB2I6bNXs
	9ATCJS/Vumz8ru/xJrENLTn7cHhN+4KzQMmm84R/EDQMZ67g2jw2nNTU+lYZfovGTYALvKDA17z
	27+XBHm444FF2pBOpK92WnJg6zzTy7Wt40bsH
X-Google-Smtp-Source: AGHT+IFm9aPzYO7/xwO7KoweJXTiMzSSKxU3eUsnKdjN0yDeR2ckVA0sVXcOxiBT9dPEy12p4xYjGgZjvF413NgdTb0=
X-Received: by 2002:aa7:c906:0:b0:56e:5681:ff3e with SMTP id
 b6-20020aa7c906000000b0056e5681ff3emr219681edt.2.1712678393837; Tue, 09 Apr
 2024 08:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409152805.913891-1-jmaloy@redhat.com>
In-Reply-To: <20240409152805.913891-1-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 17:59:39 +0200
Message-ID: <CANn89iKSO=P0Vr03ZaXn35-At+SRRvT=b3YrAuW7J5VR0hiFpQ@mail.gmail.com>
Subject: Re: [net-next v4] tcp: add support for SO_PEEK_OFF socket option
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 5:28=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When reading received messages from a socket with MSG_PEEK, we may want
> to read the contents with an offset, like we can do with pread/preadv()
> when reading files. Currently, it is not possible to do that.
>
> In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
> in a similar way it is done for Unix Domain sockets.
>
> In the iperf3 log examples shown below, we can observe a throughput
> improvement of 15-20 % in the direction host->namespace when using the
> protocol splicer 'pasta' (https://passt.top).
> This is a consistent result.
>
> pasta(1) and passt(1) implement user-mode networking for network
> namespaces (containers) and virtual machines by means of a translation
> layer between Layer-2 network interface and native Layer-4 sockets
> (TCP, UDP, ICMP/ICMPv6 echo).
>
> Received, pending TCP data to the container/guest is kept in kernel
> buffers until acknowledged, so the tool routinely needs to fetch new
> data from socket, skipping data that was already sent.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

