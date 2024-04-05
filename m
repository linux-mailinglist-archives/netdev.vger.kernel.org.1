Return-Path: <netdev+bounces-85280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D289A068
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A45B23CC9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A816F29E;
	Fri,  5 Apr 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu/+JHap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C216EC01
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329149; cv=none; b=kkn2tCluWSx8dtMGVS2qnzvT0rVJ31PtiNi3cV7kEGmlp+6Feq2ssy6Rj5/INXBZHhyWPMu0gdRtGFGmFOc3gEKrvq0XgWNsTdSYTUHuOwNV5jv85VlQEG+RrDbYCety7xRmIViBEeZnY3Zx4fBLIy0dFpDjvkJZousizqiM7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329149; c=relaxed/simple;
	bh=558r0/RWdScnehoL3vUdfaZMP3H/vv16SPrmGs/l9TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgBF7x7FBUip3ftCFNhYqJIboVu1nPtKjLGCrg6M+8BTrl+nMYcF7JDf72ePuG9oFpN9AMuu88oCaRk2/AB+8J3g34v2ZRyJA1aoRdioLNl+44a3xEalMsfCckhxFgycYJjogwEuCmTM1TDKl2GLyqiS+3iZ79RyPtSlyB4HHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu/+JHap; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso155322866b.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329146; x=1712933946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=558r0/RWdScnehoL3vUdfaZMP3H/vv16SPrmGs/l9TY=;
        b=Gu/+JHapNTMHlbM8FN3A3U0w+8yfdFjKio4XCstusurn+Cnf69qPW4fe/ff24+tadD
         BYo4sZB1IfgO1l+xZBQTJk3Cz5kW6/HBEQ+D76ZZzoNe1Iw2V56ZkU/LpANEEk7xKd+d
         DNRVnnfneeCl96zFUBiKqElahGQQtHkwOt5rwCQCesc2rI2xjEWzUJShvK3w+o7Xd1fY
         HkZ+P/+ANN13t3Pj+nT1ZxIEJ3nw/tdvbRCcypo7pqjBNgPhMYHJcucVX67aiLMZzrJW
         7yqx46Nw6pNrslXmmdeL8ogIyAn/tyYcq69c6ontWNArD+OZ6rvJ6ByFXy5Zj5m75XFK
         Gajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329146; x=1712933946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=558r0/RWdScnehoL3vUdfaZMP3H/vv16SPrmGs/l9TY=;
        b=dt/Qj8FQh3tZCCAn53sYzqsdDHgMSKHoePVjFQ1H529+vt7oWupvVeZKIPLdcI440h
         smNwzDhXYYsS8WstQGxoDge6nrNgSHGMPtG/bfeOScM3YG82oPVgeBGjvagCSwJ6/eaq
         F6RlLWvucsYCqZt8Y3NO0mgiqMsbPSIvrcRjGzKagArLdxGS3eN4Pxdi3U/soRY89FIX
         I1+m7gohH39HmYixsMdvCNKhUBzxtwYwBHeAJzr2RxY2D06LQutq6DrQOZxmylKu2csd
         MmH2yud2QX/XcKA4QTL+2wAwHbuww85VdSaCzDzo4psgZ4yOeJBWRKthwkNkz6NiWScn
         77LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+jLt9AgKbbbG2CZ3bSkbOgjGQxPUhJ0GVLvgxHQAvB46iJa7YQwTa8HqTEuXV4E++aijHE+JuWag+aFwNrChj7pc+kKlb
X-Gm-Message-State: AOJu0Yz1Cm8dwk4ddE8MZsF5EtqQahlZZJqSB/NdjePQ2AOpPDr+LWgP
	QvUGNSphQLYptx79E7j5sPpch4yynhwQh6oyfUhqSCEPI4rsxG1KDIU73FWpYWBV2lZfReotX2N
	oucSLn/pcCSOYYCCQQXMS8dHYPRQ=
X-Google-Smtp-Source: AGHT+IGjRrFBl5hEj7e2d0rLbwJ6uTgFZOUystnn0fgxrbYLXDEfHSMfxs8/nYrviV6Sepl1ZVBqIkVlycVAtkTuGW0=
X-Received: by 2002:a17:906:fcab:b0:a51:8a78:d2ff with SMTP id
 qw11-20020a170906fcab00b00a518a78d2ffmr1137786ejb.34.1712329146442; Fri, 05
 Apr 2024 07:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404114231.2195171-1-edumazet@google.com>
In-Reply-To: <20240404114231.2195171-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 22:58:29 +0800
Message-ID: <CAL+tcoBDLBnBFPbS_nbF4S_dNUC355KRFKawtfkvRsJwXvJzXA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tp->window_clamp can be read locklessly, add READ_ONCE()
> and WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

