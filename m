Return-Path: <netdev+bounces-178488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE94A772CC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429123AC1B0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCA17B4FF;
	Tue,  1 Apr 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdQVRcnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB59B71
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475262; cv=none; b=VbSc/Qmgi8ZMaehjp77nwGLNOtewCwF+OtXIFWZjJEaEVd13QxHKFk63RSZtAmpEODGbcz3JrF6gVNDXarXiDjfbJ7p9I6WI9Grapv7tdvuilea30Qwz+kNxOv12DQsafc5MhFEbe09dPP7PKj2Y6bsT1rnXMbF2jH1hJDUmQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475262; c=relaxed/simple;
	bh=HdXfNuTZkgTwCACzv6xHc1xPpcsDMOgDDK7vm0HV9Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmsGXA+wqkoJOTTjuUH/XGnoLUuNoAR9IrFZ/OjCdeVQiF6gGQHL9umZALByvGmp6WYVR1xBxLn5QEVIfxPTarLYrP8E3iv1C4cCkBkA8HXgdH/6ETrbfK3NkF0O978vmKdJap9ppBMPOob2yLFWA/1BwiZvwl5qZVLMJvtsqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdQVRcnN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5edf7f94f9bso2a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743475259; x=1744080059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr2GSx7hAQ6tUkzKUMrxzmBdPAmy59a807goxNkQqdw=;
        b=LdQVRcnNYfP5y82y7rZ/2p3RkJNsfE3Q8oNPV+uNT5gpinP4ZtY15AznrGNsHTD3bq
         Y53QOZpZ4P/HpPzZfKBd2mW5GrVfdhlkS61CF8asbN6n/tKzLFv5lL8hbGAm/CFn95Pm
         uWULy5g5D2aczFH1mTLelAglkBGw7ImRWeFR/yG+FWYldwGoGp8Vsi6b3GgTrTHFzALV
         +qYxNI3CA7x5wUgpuHh3rtsvlpdDpeIjZzlbwsMP0mkIion97Lu8XcHZm3xTbMOCTnmz
         cus94vxlvseFIB0Mj8jzO3hvoK/Ak2r9wm6dKGGuQfNPMvPXqEPCLa58qfAEtN0ALGrm
         oCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743475259; x=1744080059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr2GSx7hAQ6tUkzKUMrxzmBdPAmy59a807goxNkQqdw=;
        b=c9cAoaZshYzXuP7RdzGc3UQWad6PI6UEVRTR3ix1cFgcaSlFD6DiK1Aa2E+XPbA9wM
         FtmYSokXA90K7fMXf1HH8dr2QPy4/vkwfUUBvE4GfK+QdeAzHcbMi+VunH63c9dixZRR
         7DVZtpF5n2g5WTH1bDof5x3w7fg3ANc556nfNrnUpbiAGKbHeJ6tCjvaganStQFMtMPM
         6WsJoapdGXcHJ9xL3yNrPMkQ3Gthl5vzUvzX9ABKR1HGpJOvmS5/77KY0yuWavIy45O1
         /V2HUGcuc3eHbQPar1yrPHTzFLrrfuq9aAElHci43wQVfGrNQ2agdOAJGqc2UJUsrimb
         fUOA==
X-Forwarded-Encrypted: i=1; AJvYcCUqB/YtkUOs6JCUyF8RUUjCNF7lvN8w3N/HRCVFPT+TFvGyIHGvWIMeWIc4bLDhKrV0gpC/lIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfO4BbhQM0kCy+Kg4I5lA+rCxlwfNoxmPVHPLkFEXPKt3yteZ
	p7c1lnWDJ3DRDpCNmnMtP9cEu14u24zSL2DNKpBuwjBRw5kfNF0TeacSxdlntcjELMXMRilBmoi
	VYEjuw9Xmr8veN9jk94Yt1Co6SbHkvLakX17z
X-Gm-Gg: ASbGnctRWFctqQEt565IgZY9khgoWa0olSFwyAlqbepEsocx+Su3rnPRPFD6Vfft+Ry
	aNg7yHsxj8DPkN2BTpfmGHsPJyp9MZrZIMJ4qCEf5LjC6aGU4VVfz2s99TCQNsZ8c0OAuJu/bwK
	AjJqjzMp3NzgqkQZ0q/Uc/wwtRpD5HOzsbNCYuIk8eQ8pnKe/Oeass2zgsW6Q=
X-Google-Smtp-Source: AGHT+IFaL39lbB1pPY8S4hIsKgTALKcc3df9gXhGAHkv3FQIaJ5PQN3IEV0nKAfTcX3GJyGwBmz577cGO9IpIwYKaF4=
X-Received: by 2002:a05:6402:2b92:b0:5eb:1706:a93d with SMTP id
 4fb4d7f45d1cf-5f0422a389cmr283a12.0.1743475258038; Mon, 31 Mar 2025 19:40:58
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401012939.2116915-1-kuba@kernel.org>
In-Reply-To: <20250401012939.2116915-1-kuba@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 1 Apr 2025 11:40:20 +0900
X-Gm-Features: ATxdqUGHdgH93EekD9UVihlqbSbtm_rutUjzI3VLA0Vm9EYQd8qq-x9Y8Hk4L_A
Message-ID: <CADXeF1H6-LdbZOsEdSnp+3k8xG-K4dqg2Pk58cDmpHBeCkdUSQ@mail.gmail.com>
Subject: Re: [PATCH net] netlink: specs: fix schema of rt_addr
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yuyang Huang <yuyanghuang@google.com>


On Tue, Apr 1, 2025 at 10:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The spec is mis-formatted, schema validation says:
>
>   Failed validating 'type' in schema['properties']['operations']['propert=
ies']['list']['items']['properties']['dump']['properties']['request']['prop=
erties']['value']:
>     {'minimum': 0, 'type': 'integer'}
>
>   On instance['operations']['list'][3]['dump']['request']['value']:
>     '58 - ifa-family'
>
> The ifa-family clearly wants to be part of an attribute list.
>
> Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: yuyanghuang@google.com
> CC: jacob.e.keller@intel.com
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/net=
link/specs/rt_addr.yaml
> index 5dd5469044c7..3bc9b6f9087e 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -187,6 +187,7 @@ protonum: 0
>        dump:
>          request:
>            value: 58
> +          attributes:
>              - ifa-family
>          reply:
>            value: 58
> --
> 2.49.0
>

