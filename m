Return-Path: <netdev+bounces-64391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2E832D00
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400CCB21CB5
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522354F89;
	Fri, 19 Jan 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ9u796t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD954BE3
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681094; cv=none; b=TuBSzU5Mq7QKWsSt790ai9VlUo25qr8bnTr26Y/bfSWZ9ySdDmROAZoXQGPCOFvYTdCjPhiBacWzxnETch/rh6vK3RvJ05H720piOO/eVnbZVkGA7Enleh2zA+j4r/P7Yw8vRMeKLgXmPO37AC0ejV5r770AdxbyA/kOo2rzIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681094; c=relaxed/simple;
	bh=C9QGTzczMs0ZduhzQhqoUDnZo9iEYV0Le/qZXe6cIVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er62U8Oar2Opf/kfSXdbBTegRKWTAXFUezgULWm5v8QQZUkJ8aYMLb19/XL67otZ0njCeWT0QHChFZquDRfJpbtvK7gO8NWTFkL66Y+6rDFHaYCu9XcO+oHTYeTa0p0EFMu1RGxIueCfU/P7ztaPGgK3HgM7aJsU1hJuGF5J/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ9u796t; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dddf7ea893so476640a34.1
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705681091; x=1706285891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNdkj0T9bEWQLU8G6RM9G7hAMdwVMRgRu9QVy6YKZR4=;
        b=QQ9u796tXeW/sYLTHkixeYH8iSGwen6LUPOzeC2N/xwgpBMpHDOPIgm0wcn3Dvnwrg
         6NivdNE2TJFajWkf0pmQnmPqDea1rOT4c4z66/33QWXOxgrDcJz+R+LI5ey+PHlRLqIa
         eThUd4XHIb7f48cvQ6RQvr/CprQju6oyGAIYSMYYVOXIHmgHNqzGBh7XsNdwdUdZAeB/
         vO9Ejrvils4C9U/Uie/Otnjb5zdFU310TVhTtH7hw/f5quYG3gXKFDNgc0qBM6a1rKvB
         sjTIoG0mfx+3m9S8rxwu2KKOHMr8UlazOs1TQiZMflWi9pCvxD8KRF6ncq6RBh6mxzVb
         HFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705681091; x=1706285891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNdkj0T9bEWQLU8G6RM9G7hAMdwVMRgRu9QVy6YKZR4=;
        b=cNNwiVrYxodr8UaJcynzfeKszB86pQpG8u8OhxbcuNBxG1NcakFt4cJHpM+RiCsDyB
         xCKxjMO1bbxR/JelFaHawjGSng3ZnPpZZ1LAVz1+0WZTe/qmKEPFge+N5umsbJq9HgjR
         QfqPLr2hXCQqE3PNaXUx/t264UV8jZKYm39SjuppC/yrjnB7SFidF/1F3UFRbkw/6pHl
         fqBYK1NB4kCANj2+mG2SjjiAxF6LoXC3UxE37rqJiuGRVnHxgrB+WXpf/6MwmvHwldhx
         5zGTVREPYbCYHdYrBQF+BVt1/1PnjGO/P1YTW04PCUosoUXxdI4YP17CUsTZ1rLDEgVi
         JsCA==
X-Gm-Message-State: AOJu0YyUmhPE31hobtFtg2N+2CtQoJyeLlaJxgLW5k8EUmMEzaC9XGI4
	J03kYomoP5FV4x8G9njj3IcuFadwa7tth17U/NRmlz2GC+7HXzhNlgwl/qlTnQMNx12uQ2tU+IT
	WvMt1YX4Z2Bnr3IJsv9q/BCQiY9Y=
X-Google-Smtp-Source: AGHT+IGQYfEUaGQIEU/co5HZoi3f+GLeouY8D0fkWy+bTbmi3uSEf4+jY/vhO2RT3D6YsVcj8OlgsDJpPrLyeR7Xtm8=
X-Received: by 2002:a9d:6d8b:0:b0:6e0:c496:891f with SMTP id
 x11-20020a9d6d8b000000b006e0c496891fmr57911otp.6.1705681091642; Fri, 19 Jan
 2024 08:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119005859.3274782-1-kuba@kernel.org>
In-Reply-To: <20240119005859.3274782-1-kuba@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 19 Jan 2024 11:18:00 -0500
Message-ID: <CADvbK_fgjFKuDDF+ZjTd4cgnF7jZqUbG7zdzZwMr1zwFaS8DxQ@mail.gmail.com>
Subject: Re: [PATCH net] net: fix removing a namespace with conflicting altnames
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>, 
	daniel@iogearbox.net, jiri@resnulli.us, johannes.berg@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Mark reports a BUG() when a net namespace is removed.
>
>     kernel BUG at net/core/dev.c:11520!
>
> Physical interfaces moved outside of init_net get "refunded"
> to init_net when that namespace disappears. The main interface
> name may get overwritten in the process if it would have
> conflicted. We need to also discard all conflicting altnames.
> Recent fixes addressed ensuring that altnames get moved
> with the main interface, which surfaced this problem.
>
> Reported-by: =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=
=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com>
> Link: https://lore.kernel.org/all/CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTv=
cGp=3DSAEavtDg@mail.gmail.com/
> Fixes: 7663d522099e ("net: check for altname conflicts when changing netd=
ev's netns")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Xin Long <lucien.xin@gmail.com>

