Return-Path: <netdev+bounces-101752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CFD8FFF51
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412C21F2290D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA615B996;
	Fri,  7 Jun 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oW5E3gVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808644C97
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752259; cv=none; b=bHH1J//p2N7kNp+CsLppKcrk+LlsOUDr46bc3Oo/2kp1URmykpXChM1o0PY63aP/5icW1vb8Htivr+PL67D1DtNbMto9G+BUr0Tbe9QHvlfUUSVKoxvh5q1xe6R+9sLEQvvaBsPSQk55a5Pz38jRVxPAE7/3mje1Si2WFvva6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752259; c=relaxed/simple;
	bh=OMHsezmXHK1T9NJnx8PU7zKzao4dfGW/6bNpaR2FrOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llgRWVNCm5/lysOiL45C8qErOcPREtiPVgR/tjAPcSke2ZhY1LAMQh7j6ed/MxSwYODzwnAT888F3/T4m905HZ2By6g2JC409Mm1bV9Wy/c8vsihJrIz5ojrejEP8FAd1pnLLB2cLbdKVlritWdHsdjkb149iILFlGGOzbcC8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oW5E3gVc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso14878a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717752256; x=1718357056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMHsezmXHK1T9NJnx8PU7zKzao4dfGW/6bNpaR2FrOM=;
        b=oW5E3gVcFVMgVuQcWVbme1lc4HZeTq/myZ3crxMRZQbI0eNHs7cpTIiAWV7axxjVSq
         2ES5GJfY1oVoZyn++xbt02oZYR3cTCIfp6U7mzF03aeCq85rnpwEPN+w6z2pkZ/tsK+W
         CGQp4BZyozHEMWjjorB/Fgo4MVhiRbg4FgudJX3y8kDp8D3w4vg9ilq1gMcmulvcAnoN
         5wP5Ts8JyaGdPOl2+zHp7pETg5t1mgbF8jCSekqE4rnqAFykqr0vakxBC80yCu/HzeXx
         1ji5uHiR1zSyuabSIXr7QA6475qgW3SHSdGDhJNLqHFRmL7q/BQu5X+nMkAKN05CFegq
         b+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752256; x=1718357056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMHsezmXHK1T9NJnx8PU7zKzao4dfGW/6bNpaR2FrOM=;
        b=Vw27+yQivaIOt8lw3Zsuqh68VlsTFyBrYNSV3/fRWv5u5syXK+ZbvseHd35qcUl4VS
         NOnOohZax8bN004rCt+2ZC4wLbIMqeTcvdZ1q5AHQE+t9XAaY3/3JmKgKai7yrg9aK+0
         w5qRHDbpYx52CZQjXX7Igis3KWX4H3gPUxFyFFPSbnF7/RzP0CB449DvFvF0lA6D4wI2
         xIaTYkykthAsqarHPIaubHM15wuRCnERQgKyBUdS4/B/i4Jf39Q2+5TAJS4ZHDyJqIbT
         T01HQxLNJNhhBUdJ1udACPZ/Aaz8LueRr2nm3zh+dLFaiYOZGBvZ/tXLx6SiesHhO9FN
         ihzA==
X-Forwarded-Encrypted: i=1; AJvYcCUWG/LZv4fEdaPsa1wWU3syqmRXz6v9c3674JFbHk5hWA9MKzqbbmuu1gukOcUlZeBydN6CWuFlun4ToC2pz9u/YkPrGfs2
X-Gm-Message-State: AOJu0YwaYOjMs7HWFXjwqRHJcCeCjke910E4tf32k3dfPW+X2yPmx/Aa
	T6Ea+TQFsJ8ufEzixQWBXby2Ds/gH1BAL4wd6FS0mN2Aaizfead086lCRfX70Mmzq4nWtORNPf+
	RuXQFDCaDvhIjQwuEFmsyezRKjGu5E68lYLqs
X-Google-Smtp-Source: AGHT+IHaW2b60THkgdOX3J3B5JdXioWR9Zpah/4D37uNxuI3vd9xOzAf2LYu5jm513AJpOZ/q1bhV1k+hrkaoAW40E8=
X-Received: by 2002:a50:ed0d:0:b0:57a:1a30:f5cf with SMTP id
 4fb4d7f45d1cf-57aa67f8125mr481307a12.0.1717752255364; Fri, 07 Jun 2024
 02:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606192906.1941189-1-kuba@kernel.org> <20240606192906.1941189-2-kuba@kernel.org>
In-Reply-To: <20240606192906.1941189-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 11:24:01 +0200
Message-ID: <CANn89i+eBSoqoZ3oE7oBN5ZLf+7NtcrtcGyhT15icocMav2RYg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: move rtnl_lock handling out of af_netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dsahern@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Now that we have an intermediate layer of code for handling
> rtnl-level netlink dump quirks, we can move the rtnl_lock
> taking there.
>
> For dump handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE we can
> avoid taking rtnl_lock just to generate NLM_DONE, once again.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

