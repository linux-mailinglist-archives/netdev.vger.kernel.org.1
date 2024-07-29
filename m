Return-Path: <netdev+bounces-113719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0693FA6F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6528349D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1F15A851;
	Mon, 29 Jul 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+83wU8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6BECC
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269815; cv=none; b=bU5DqTDU4m2zGW4Iim+wTbh3+u3GgfRa8fGTMVsyfE4wlV7jXocsr2WJ6oZs0GBjsLURtmrFi8Em60DlPmBixulFgmZFFGWbpAmrMrbamI3fB80RCoTzxT13ZZSVrPjG3TjBefOa8NmPEzJb6kkb4VS+Tv/1G8bmSkW8ex/Wo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269815; c=relaxed/simple;
	bh=OSGM1xBCD66UUrMLn9+OOwU4hgH7G3pMjd7jwNX1ogc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp6oAlBX8nhMTUGDL5Xu3ebYvZ1xJocpSl2epNTXaWk1olxMAhv/Pf7w4bld1Nc9C0DMEa/BUatVU7bNn8DVI+Azt0f/CwwsNBY841+i/zTseJT9NvafmjUCjF9sYzx1OVbN7l2+3w0/P1/81kA9W2myG05wEskMMHDgNzsfRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+83wU8+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso15273a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722269812; x=1722874612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSGM1xBCD66UUrMLn9+OOwU4hgH7G3pMjd7jwNX1ogc=;
        b=k+83wU8+qFs8skJNAD62ZTbSKiZP4L2wlKxViHbhBbMDXeM2/SYqMyVkxisow8H+F2
         NFjxTpuq75OTKsy8Sh+zrtv7X44i/LTKSVDGeQ8JYm4tiXuy8DpwUg8cix43GSlz7u+T
         ker+JmrKJTIxaIU6O8HYr2r9dsI0ErvtebiCLqq233Z/sav5w1M6UZAU7BvYcH8aUtld
         bqGhleCSTjNgCrOTGeWe3+2S+PJY30WB0HxenaWMWh/G2vWNGZzbtS9lsYdcR0hv2lvM
         A7t45xjxgDtsIgM2hyC8Rwqw29QQI+W3WvfAPmGSn1PbIoDUvooqFlYHvNcsf8Xps8L0
         zJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269812; x=1722874612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSGM1xBCD66UUrMLn9+OOwU4hgH7G3pMjd7jwNX1ogc=;
        b=VekPtVsxstvSLMZVfgy8W3c+C6NnftpWCvI6IaNW05GEd8p69XIfh4FZtujUOoXcN5
         t9GcQ6Mff9l/SVCL5EKYd1/GEF0gVu8jg/cdVKxT3QZ62wkrxa7GnlQCElNcL1mrOzpg
         rKkOw0/9GcN21mLP67jXQbVILOdIuJUNy3ieHHQSqTZjVG+NokwlJ7+sniRTxyoLbyRw
         08Q8TRgPuAST+BfrkJTTL8sYx9HeauZCOUaIUjsF0oWXRDcXgC4TWppBltflSw8PtwqH
         H0enrPFe0/ej631NuBbcRkftcaFR5qpk3wt2SMR1jU6O4XTOUuBx2wq7Z3ZEdTOtLIiz
         VEZA==
X-Forwarded-Encrypted: i=1; AJvYcCXSwDgJWi46hIwuV+HyHjs30GKcL9ybe32sWaklOOuthIk3epF8PZofEI4q84N5i5yFlFZVYs6j0CxnssdSmaKMj+NytFfi
X-Gm-Message-State: AOJu0Yy/1ks5vRX/YNhBjLn+/C18LvdslqnKt4r1i1PKGYK6iWtmN5qS
	C+yLX5h3UAzu3W8j0mw4yOafx25rOqi1uf0XX+xd6DvD5oaZZC4H20k4FjEyp3tQIyDXRdBwBl0
	Nc/TkWXZR+fdEIjHGamlpju728QJHYBB8DNB5
X-Google-Smtp-Source: AGHT+IG2X8zaN58lDic8+mdMNObENu3J8Uo/SH02nH5FPCa0hyEedPlLr5r3/W2ma8BszNQTsj9DzTfDbfRz6xExwwY=
X-Received: by 2002:a05:6402:1ec3:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5b408424d03mr24245a12.0.1722269811460; Mon, 29 Jul 2024
 09:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095554.28296-1-xiaolinkui@126.com> <20240729155719.73646-1-kuniyu@amazon.com>
In-Reply-To: <20240729155719.73646-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 18:16:39 +0200
Message-ID: <CANn89iLF9HEaPhMJn1U7zU-ewCOMVv2Azsu4cGPXr5h0a0WRFQ@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: xiaolinkui@126.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiaolinkui@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: xiaolinkui@126.com
> Date: Mon, 29 Jul 2024 17:55:54 +0800
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >
> > Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
> > in connect()") allocates even ports for connect() first while leaving
> > odd ports for bind() and this works well in busy servers.
> >
> > But this strategy causes severe performance degradation in busy clients=
.
> > when a client has used more than half of the local ports setted in
> > proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
> > to a server again, the connect time increases rapidly since it will
> > traverse all the even ports though they are exhausted.
> >
> > So this path provides another strategy by introducing a system option:
> > local_port_allocation. If it is a busy client, users should set it to 1
> > to use sequential allocation while it should be set to 0 in other
> > situations. Its default value is 0.
> >
> > In commit 207184853dbd ("tcp/dccp: change source port selection at
> > connect() time"), tell users that they can access all odd and even port=
s
> > by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
> > socket application.
>
> The application should be changed, or probably you can put your applicati=
on
> into a cgroup and hook connect() to call bpf_setsockopt() and silently
> enable IP_LOCAL_PORT_RANGE.

LD_PRELOAD can also be used for non eBPF users.

