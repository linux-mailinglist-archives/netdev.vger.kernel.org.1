Return-Path: <netdev+bounces-122848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA4962C74
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCC1C241E9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850B1A2572;
	Wed, 28 Aug 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="rVtZB0B2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3C1A2560
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859229; cv=none; b=VfTRQvgGMkrb+NxY44RXO8POm+MvPDaiSWFqUS3zsWmogVQhGtxWKR3FYUwrnUnXmDBwMS87OAlWNloHmte8Fy9QiYVKoSyES9gU98XrF5Z9SCZQ1wCoat9ribj5d63JoodlyarmyStbjGyyZ2OOkjotC5bV1k6IqKQY1dWykMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859229; c=relaxed/simple;
	bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpOU9DBqiBZeJjRzF5znWRB64c5Iygt2Dl9DOLIKd/YBhKPsIChktb8dv0p5l06TQxWgcTr/IX4yk3alaJwNsHxrEmETPWr0OpH2zX8vKETIXvWVVApVmqdZkNKBSn+SPSwQu75m7C/BIfePm8htVDiiE7irne4mG5PJl+TNcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=rVtZB0B2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fea44f725so6868111cf.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724859226; x=1725464026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
        b=rVtZB0B2Y4b/Imf5ajdAai6Q+36XQaF5pa6QGNqrArwjA4ZBnm+LdtuoB3EMZEAFU9
         hR8J/nVzircY75CRXfd/SGluXRxBTPhzLkVuuTU1Sx/149Mjkfaj35YasmywQK/kgLi0
         kExpoWXg/dtmpilKZormrg9gDzQaD3TZo+Oycp10sWPBNOBtF9YRfs+7VXeVYDJ2XsNs
         NrwW8KZok0Efwl/e2shI5AiR8bGlRIXMyZv0m933KRnhJgFSzxikFFHxUy/PicaYiZpk
         xaLGgKvNYfMVmHGl06FrY5AlDQrs1HR+uHVK9j1wzX19KnriWRp4eCH99Q18szLSYvHo
         9KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859226; x=1725464026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
        b=bWGs8P1xMqPvmNVBacy5SEIHn7mlcBJc56LXsDakI7zzHmj3Oi1fPWcuw1UnjjCapk
         mZqvZlXFNXSgpp8L6XXA99KignyQNzFtQCfsHPkEMDHFDAYHaEIpX/SKTDWu/RDVyDFQ
         f2Bp61qA3ljL8GrXn+dvu+GAT9L+NYgs8Ug8KwrB8A2v76F3B2zgF5Bt7+gbLSV03LrN
         5WSpyOJ84j9yfyAVbJlE3mPh7O7yzJHBhICO4QPInq5CxdbVx7akI4CHCp5KXpR68/t9
         uYPY1m2SwRIoq1ucNDHCoRkTzB3eeR2C5P+tuHedwkh9xGyEnpvZ/S0vX6NmmwOglcu2
         C5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXdqqDpD30+VLLBv69ZL+WINrPXPwT8Sj5/yQVN0fsvrixxvJI9bsXAoGtPKjmlwZgKH/Wyhvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWukGPiG4SfDn17q/zelYtDxlX29/wTNFOWEljq5rAZuF7Gmk
	lSEhOMEH/sLG3cbACFlNcvnohCB1K1JIFBm1LB1wUHdg1NKdStVBVH31aryjJrodd1b2+sffm+1
	mm6VaZ3a0+iOU3I5Kaf1Tg0rBhJ0i0lUACvXYkA==
X-Google-Smtp-Source: AGHT+IGuHbA+BH18lwQy43vBRDD5DrkY4oXBSXZ5klly3Olcm3w+RGVVcoWnqupt+RXR6gfSH1ha0PF3aVb1yC+miYo=
X-Received: by 2002:ac8:6312:0:b0:44f:eddd:3e13 with SMTP id
 d75a77b69052e-4566e680d2dmr35509551cf.30.1724859225414; Wed, 28 Aug 2024
 08:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <20240826143546.77669b47@kernel.org> <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
 <20240827065938.6b6d3767@kernel.org> <CAO6EAnUPrLZzDzm6KJDaej=S4La_z01RHX2WZa3R1wTjPc09RQ@mail.gmail.com>
 <Zs9BSOnKVdnsXcRf@gmail.com>
In-Reply-To: <Zs9BSOnKVdnsXcRf@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 11:33:34 -0400
Message-ID: <CAO6EAnXRdPMq=a9HWWxXJfc+10U1Ts1dvoAacKbNRRhrru8rcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,


On Wed, Aug 28, 2024 at 11:25=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Maksym,
>
> On Wed, Aug 28, 2024 at 11:03:09AM -0400, Maksym Kutsevol wrote:
>
> > > Stats as an array are quite hard to read / understand
>
> > I agree with that.
> > I couldn't find examples of multiple values exported as stats from
> > configfs. Only from sysfs,
> > e.g. https://www.kernel.org/doc/Documentation/block/stat.txt, which
> > describes a whitespace
> > separated file with stats.
> >
> > I want to lean on the opinion of someone more experienced in kernel
> > dev on how to proceed here.
> > - as is
> > - whitespace separated like blockdev stats
> > - multiple files and stop talking about it? :)
>
> Do we really need both stats/numbers here? Would it be easier if we just =
have
> a "dropped_packet" counter that count packets that netconsole dropped
> for one reason or another?
>
> I don't see statistics for lack of memory in regular netdev interfaces.
> We probably don't need it for netconsole.
I like this idea! I'll send a V2 with only one attribute.
Thanks, Breno!

