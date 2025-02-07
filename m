Return-Path: <netdev+bounces-164047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B78AA2C70A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C21881ED7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070E1F754E;
	Fri,  7 Feb 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a292tHDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F51EB1B3
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942100; cv=none; b=bbUSc9CrE05lyxvtdoKLNV6nhygjAmMdJG/zcMLimHbWdouIfOg8L/0zMwrYjMNzzxoQHAVamwRFz+qlVP1eYojeQoWzG8+q35wgKlsLd9w8t4UGdkSN6lvSeUmcxaSgnc6MhPZ23TjrFOqDgmoHxBYcUpo409QkUcsoBZW/XQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942100; c=relaxed/simple;
	bh=krlZM7WEVuD1Rck1O8fOMRV2mE41lX6qDmNoAXLHpNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGdTGWb2GIySPbTGBxkAO0rXKdXO+ndF3w8041mlg/1aQ1tbkUtLouys88+MucED1YanrW5zFUlRPGhczJEZgyXXY4ynpLwy/Ckib9+4uiHqhNGCILixy3qh0DfhH7xEwIxdRIGwt2hnjiuXL4r0Jle1GY5cKpj1VYlJD4oZXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a292tHDX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so906558a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942097; x=1739546897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krlZM7WEVuD1Rck1O8fOMRV2mE41lX6qDmNoAXLHpNU=;
        b=a292tHDXqnhsrm6EPVJtp3T2Q8qkC6vNp+RAiAoWuM5Staj8rdEJPo8zRsbFH8B0KQ
         lQASh0uiPV+16Ld2OaHR14tvnM3X26o0GBWgTxFl+r19tlHu/njATRR7RxgTPOLx/bQS
         pyQsbLAWfGwxZQLq3YLaI25Znc+P9GiohiG5rnMc0lrjHiHwItukaWUvU3Ri731KsTFD
         XyGg87jI2nXShDKugMYYGY2SynsZ/RbSWW6D+Q7mGUR8KFJ72aecVoOCP2rvUD5l7sHY
         9N8p6NKtN62IxVXhfi6D5RJiUSIsXVEsID/zUQjKgMxv7oQPLu486zhUtdoGUrDbcI2O
         MhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942097; x=1739546897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krlZM7WEVuD1Rck1O8fOMRV2mE41lX6qDmNoAXLHpNU=;
        b=FXAiC1LR+4IB/fu0cLglMUAF3G3HM6MUPBIcuBi2n28m9TI8dJlVvt27/cBlv3/obE
         +FQnI8zDPzGeCWm3Z9PirzmX+rEqbS7vJnmKY7PABW+11lO2krZ0JkpUuH/TUxbyGOce
         s8GlYc81S+p4ZEgO8sie/IOi0rWvBpfrXXf2Ikm/CmfACKz1P0xZimsyGo7IdoIPuPTs
         lRR22fYcaG+HJPtXksntpAMyrIsK0mfFoa+itlsnhS+jWRao7+9sgE5OBxUn7Ojdnqoo
         WWFmYalTCgsaidgUI3+hZXCN9Xk/EVG9L1P7OazMiCtLC6yrfnrzV6jDGlzjcb9Ug3Ix
         Q6xg==
X-Forwarded-Encrypted: i=1; AJvYcCWR4hLNQqWbxXWP+cC3yC2/o+Tg25hjhzCCLKBq+/TtfU1ODrBBsH1VVQ8a8IhxC1tmcLbiof4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDiorf0kqGIrb6yn84HnYATWSCrQZNyljph8uTuucy/MH4Xca
	Sc8qnjfHz3pGGyCjC6kbc9ALRf4IFV40xAgvOCUSvO+awlVMsOXPlBQqZkmU1PpF55oSFuAq4Y7
	eiDNAqIkkxKpNlvsnulnsNHz1xXl+hM5FJR3R
X-Gm-Gg: ASbGnctxZRHxeaXyBF6/3octb9Q7BqLM/srbqZ6NMaV66tloekKQAvRZdX5uik0qci3
	ERG85TTreKLQDvb2YGZAUGWBYtZBP4a/HCWsIsR+1rXXXUw73SoobOQRs9IPz+zYkZ1WB+Hxq
X-Google-Smtp-Source: AGHT+IE//mumNZfAaLH5hUakbKIL5BA5jChE96AZXcEh4kFSeTENEmFPALARuih/LJ5yjpf3By63/X8zTcAzq1yHpAE=
X-Received: by 2002:a05:6402:2087:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5de44fe9d7cmr3666294a12.2.1738942096810; Fri, 07 Feb 2025
 07:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <20250205163609.3208829-2-aleksander.lobakin@intel.com> <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
 <fe1b0def-89d1-4db3-bf98-7d6c61ff5361@intel.com> <CANn89iJr1R4BGK2Qd+OEgsE7kEPi7X8tgyxjHnYoU7VOU_wgfA@mail.gmail.com>
 <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com> <CANn89iJNq2VC55c-DcA6YC-2EHYZoyov7EUXTHKF2fYy8-wW+w@mail.gmail.com>
 <65176426-3ad0-455f-8afd-f53f48bbecb3@intel.com>
In-Reply-To: <65176426-3ad0-455f-8afd-f53f48bbecb3@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 16:28:05 +0100
X-Gm-Features: AWEUYZka9zi2U3F8lUw5I93K5sPS_lYHG0i2Woj0HFXH1KjADuP5qrbUahONMo8
Message-ID: <CANn89iKSw2QOeOzP8dke0X7cHheKdx=T9aQ7q7d8OemMNN8u7g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:22=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Do you read commit messages or reply just to reply?

OK, it seems there is not much to say.

