Return-Path: <netdev+bounces-161336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D4A20B8D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F99818847BF
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996281A83E8;
	Tue, 28 Jan 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqcbrljH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E92199FAB
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072263; cv=none; b=mdn9IdxLRCvKeVvKWHYhyyg8veUHZNoV53GWpHupyCQW/2iUinQQEe8cNF34X0W+pT6XkYYlyKrQCWE+WAja2Ose5kixeMdSPdK7ZCnGPC5sNoTXDp61hAnGZkFbYN2LDYQTYAguB1RcnNLcK1aKwylB1hlehlpO7gBRYA/2EOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072263; c=relaxed/simple;
	bh=xJOwPXqhh/teSt0MCPqNXYRZqfUhJl+ceW+bTZQjATM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3i9maP3M2Z0BwvkSSSdy/trON85Oe5xV7a0BS1TldOBV8WEDz2m/uUUcsjjMxjBxN/cWVLnlv/qIsxk3hfmgVWkMOIwwE0HPPaFpFBzkRuufw88awNckb/MgfNT9HzlKT8sUEbKGWJC3XVn6ISbr6S2DO0pRmeb8CFfBibn1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OqcbrljH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso12224249a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738072260; x=1738677060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJOwPXqhh/teSt0MCPqNXYRZqfUhJl+ceW+bTZQjATM=;
        b=OqcbrljHq0gVYNWnGRSfKoJRDu3Q5zddJX3yGtJGg76ix8KTjkpxEwHABmdBLz6UE8
         hcoVbndiboBInGpMGcT7OY3Ev8M0WccMCSCrWI3UmDNlXS0HdrUYDLzNjN2Ddp0ysagc
         hLsmcTeKtOG+94x6pSipPC3//vHcqU5tzK9t7o0ynMFLxi1G6Ipbqr/RaI1DypUZTJ6T
         1N4GNnRbtzjiG09uTmsn5Lm98UPhm9d5AfSC9eaSjNzz8E/bcRmgeznmE9b1/TdtfW0I
         qlMiLJ/t/dpXgzwI7m7SiCJujx9Wn8ZLDgPhaImVTMW5yCTka6EL51aCDogqk4cpoPDR
         I11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738072260; x=1738677060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJOwPXqhh/teSt0MCPqNXYRZqfUhJl+ceW+bTZQjATM=;
        b=tHow+I6+84xqcb8SvyPu4GcnOd0jyJx4S+H86CObA6POWkl08/t5mRoD4tzcQ4Dynk
         I38Bjc6g6NvZCIESBJD485g4Q5q2nJ71CPdi0CcXkO4gfq1pyKJ0I1QeojWppAZ5PFfN
         M4jpB4L6sfEzgDFsHLND2AUG5vMSEPG7aWkgFeZa05soC3uJYyFDT0yR79QTsMbJTwqq
         QARzkpi1gt/WmOloqHxwExYlGrhHPfUz1SfXuKH4mPq+7yB+0lqq3EdXbeC84Gtqn+sy
         4srYmL3fKRB8U4QxOtreRm4rmNqQgEvVsBNSnXWjim4iSkv7fXtWwHCsxb/HIxVqVeDl
         DLfA==
X-Gm-Message-State: AOJu0YxsS0TZOMrgeDoBdnlD2qyBA+gOWTKNrupL5VW2BafcqzmcRHzj
	fjk14uIwqJkiehwsfiLsPugBq3RY4o3hKh1rluoQSDxzjq1Ms6/rQjiMDBxeE9yW43n0btAjmcm
	MjRD+PXy8jvyW17ut5OZ+RU+Up3u1V633fUmkLCpJFpQHGv+tqGEL
X-Gm-Gg: ASbGncuS1e8PHktE1S3C2vmTEoj1Nx4NT8HiyS9P/xB/lIatkiF/tnuAGi9Ba7rU0rf
	Uqtq/AG7V8/iaTEjIp0XfRv+AyvwGK/x6thu7gBeqPdotY9fFzYPYcFkEAVs3zvS6kqci6Jw+
X-Google-Smtp-Source: AGHT+IFEnTg9R/qann/lOPelXehoFTGTatIeMCkCtVrEwnDcdtyqpvfAkonWG+nAVh/MnSIWhJGjE48Lvu9aiHqzw14=
X-Received: by 2002:a05:6402:4306:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5db7d2fe766mr46104157a12.17.1738072260094; Tue, 28 Jan 2025
 05:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128103821.29745-1-nicolas.bouchinet@clip-os.org>
In-Reply-To: <20250128103821.29745-1-nicolas.bouchinet@clip-os.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 14:50:48 +0100
X-Gm-Features: AWEUYZnj0wLkPbZkLPZaDf0_hDXXhoPkhATX-_CrgJINqcwh6bwfWAV-22rK7tI
Message-ID: <CANn89iJ5CMe+gYpEKJFWu6hBVWNZt9VFCc7ANu3_gk6_88zh=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net: sysctl: Bound check gc_thresh sysctls
To: nicolas.bouchinet@clip-os.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 11:39=E2=80=AFAM <nicolas.bouchinet@clip-os.org> wr=
ote:
>
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> ipv4, ipv6 and xfrm6 gc_thresh sysctls were authorized to be written any
> negative values, which would be stored in an unsigned int backing data
> (the gc_thresh variable in the dst_ops struct) since the proc_handler
> was proc_dointvec.
>
> It seems to be used to disables garbage collection of
> `net/ipv4/route/gc_thresh` since commit: 4ff3885262d0 ("ipv4: Delete
> routing cache."). gc_thresh variable being set to `~0`.

Simply reflecting this sysctl was kept to avoid user scripts to fail.

Kernel ignores its value.

>
> To clarify the sysctl interface, the proc_handler has thus been updated
> to proc_dointvec_minmax and writings have between limited between
> SYSCTL_NEG_ONE and SYSCTL_INT_MAX.
>
> With this patch applied, sysctl writes outside the defined in the bound
> will thus lead to a write error :
>
> ```
> echo "-2" > /proc/sys/net/ipv4/route/gc_thresh
> bash: echo: write error: Invalid argument
> ```
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

gc_thresh is "unsigned int"

Why would we allow setting it to 0xFFFFFFFF but not 0xCF012345 ?

Your patch seems not needed to me.

