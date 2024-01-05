Return-Path: <netdev+bounces-62108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53783825BF1
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C4D1C23A9E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDA224EF;
	Fri,  5 Jan 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dX0o205j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BB22060
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28e6392281so221066266b.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704487576; x=1705092376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=dX0o205jUNd1IonIZDf8AdRd8RejmwYO/tlDBLBeePCX2Z9hKK8bm/mc9y9U+P3osb
         IMj8eEiH40f+THYm2ure6bJ1DvTsgAOO1VEc66I1IfIJ94mMktEzJBDt1d85VjpHOqN8
         TXjHmlW5BFIGFfX6GvOQh7XUY4MguC22tEMkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487576; x=1705092376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Pygpvzohi6FI3UgDRHQW6kLMNkjc+UGce0GSe977c=;
        b=AQl1ZeeWkGPF0JeQQ8IjE+J+20QQiRgLSkjy466lvkElnaNRMB/7ez5BIDHzWqADK8
         x2WoZxRDOwSsMyIAPtDNZaf3VV/a7vpofJOt8+XjSwPqFa17dD5Aa4guGWWSmG7dobux
         rma6knI30LaTwSt0YvaHFQUOni9WCZx3h2yO2idm/j3aWxNbYSEbzN+PVRk7payrterC
         1dnXNRkTSQcZ5Dmtm65cb3FRZXvk9KRa5bLUIsOrK4sOPMvzA5g88E8lDLvHmpNYNdYI
         Q/MPoQCwCxXOQjfULgutiNRha6BhikwxWt8gL/XvN/Yl/KyyAsY1fqzun1wmpBG8lRGV
         7Adw==
X-Gm-Message-State: AOJu0YwiPCNjtIpbUgnVTRBszG+4kcH1iMHUEvwd7i5AEpX+iKlDgm9n
	NjLiLhZPImpXsK8QKAafSOJtKhHfCycc6TKgPqsXKrINusgLb1zZ
X-Google-Smtp-Source: AGHT+IH3bQ62WW85bpI1VkF9US+Sr8cSloZK/czwa3hoabwTdWujXFSRC8E8tbexOfvg+VduW9Onnw==
X-Received: by 2002:a17:907:11c9:b0:a28:d2d9:41d7 with SMTP id va9-20020a17090711c900b00a28d2d941d7mr1396862ejb.112.1704487576784;
        Fri, 05 Jan 2024 12:46:16 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id sd15-20020a170906ce2f00b00a26af2e4d58sm1245834ejb.1.2024.01.05.12.46.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:46:15 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so2229380a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 12:46:14 -0800 (PST)
X-Received: by 2002:a17:906:74c1:b0:a28:fab0:9004 with SMTP id
 z1-20020a17090674c100b00a28fab09004mr943524ejl.86.1704487574561; Fri, 05 Jan
 2024 12:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com> <ZZhncYtRDp/pI+Aa@casper.infradead.org>
In-Reply-To: <ZZhncYtRDp/pI+Aa@casper.infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:45:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Message-ID: <CAHk-=wi_DdgW73uVCRHsNNm6-J0+JZOas92ybNsCoEfcWac3xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 12:32, Matthew Wilcox <willy@infradead.org> wrote:
>
> I can't tell from the description whether there are going to be a lot of
> these.  If there are, it might make sense to create a slab cache for
> them rather than get them from the general-purpose kmalloc caches.

I suspect it's a "count on the fingers of your hand" thing, and having
a slab cache would be more overhead than you'd ever win.

           Linus

