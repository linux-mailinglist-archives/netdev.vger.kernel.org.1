Return-Path: <netdev+bounces-224592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110DB867AF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF091C26A95
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658712D5A01;
	Thu, 18 Sep 2025 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfElS2L0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896A2DBF5B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221152; cv=none; b=lrdMVIDa/RkiHyuRvifpX7vF9ebc++SRC+PVEHrjKYF/rMXZiXW9qY369YmvPhdMxafSbqsTGQh3fzcf6CdtSAHumGDWWnx+ny1pONn5ic4lgEfWpqUmNg1mKr2hmv0Ugma759Yl/apmcJEKGMuoLDjeOsyEjVuQ3BbHOzRQXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221152; c=relaxed/simple;
	bh=YI7Uqx7meTCkqCYaLXONKI0i7WdIxubBbuYPpWW3+mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbXWUO8zrufatbppULtnO02xGp7VS9Jgs16ALUqRBsVCucX/y7raO4TTRZf5OUqHMu2vWJ2d2SF4V8CyEouR9ljBzmUoid2LYvrdcY3Ak+ofBV2f4P/uyITrs2Ot72go4KAKcgD4Dn11ib/Nw2R/XbrcE+xuDwXzemi8p44/xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfElS2L0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5241e51764so959472a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758221149; x=1758825949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI7Uqx7meTCkqCYaLXONKI0i7WdIxubBbuYPpWW3+mI=;
        b=VfElS2L07xR06NVUgazFOD3NOFQfqAXnz9eUJSmYMhHzFJZxgYSOfqDpsyheYe9ZME
         Xxons/J++AjtdZgQX29f1yvLVaUijN6voQT7e1M/I3DzIB2viuTdtg4+4qFESnAEn4BS
         x4SK9hSvZZ5JpsNy+xY3SPixgHBWzB90jXqT/Gd4NTNSaE4qe27xta94uD7AyFjbA5zp
         OYKLleoFIJjeqH85+ivmrqtyAwA3pIwNRfFKAMxrpnk+l/dvbirkurDHBZdBfKHfiFxZ
         12riEaYIseajfDQJrZq8HDQknGAsZoID8gDC2voB8bd0o49t2ZrAybCmNk4KaP+za1jR
         6Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221149; x=1758825949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI7Uqx7meTCkqCYaLXONKI0i7WdIxubBbuYPpWW3+mI=;
        b=M2k1X8isGkPN+XpMZqXU0VXWB9/GuidBI/vmUEgqEUfIwYwWmtPDP6P1l5Wf5PGgE0
         wNJcJC3BBIiJjp7f1VgjrMuP37bgGFRiuCVVyOf6FjXS0wxsLwl/BQcMUolf3Jo4SILz
         reY8xO/PTcQyUW+ZLr3Q/HPAQfDNGTgcGuI5X7vKkn9X37Q+n/hw9jOUN8bs0yzzAsCf
         qTBcnSyY7eu5UAs8dQNBKjXTGetZ2SqPFdOkdW/pQHTib2gyTCi/4WcfQInUZ9yAv47v
         JUe3c+adlKUDsbz4S/FIvl//90sRBqZjNF/npbqfWSEic+H0MHOovjOgfLpeMoFudrR1
         CkRg==
X-Forwarded-Encrypted: i=1; AJvYcCVrMhyejY+Bl3Lo2OGBkxP8MYlfX5XJYTP46HCeD3KKvSW3Uxb4ERn5UhPSzTW0KpsxSIHo3hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiOabzX7IaXSOAwEPjG51vt8UanJCwU2YUNHeW1GE8q8kScbv
	D13zJ727CktdH61inofEepELFpkpj/HcIZWXErTboFW13SDjMRLoJzhmGdBLg0icZJN7HS4X2bC
	LVs2g87AMwyZqzaqgdVOHqP8J5khEh/1GDB4phbx/
X-Gm-Gg: ASbGncuthggQHAsUq+ZEfM5RekY8cquPeBXDepoMwTUgDIZmsX/4ZomlhUCgrbNZc0Y
	VEcTy66F5OuthMLVx+wP8bgwWlEDpwHJRv9nfAc+BmWUft5OLZ+Zv7qlAXGnesGWhICtL5DYzzl
	Gg+iawIy0JFMIHuzI/Fbccx8Fwh0mZWwP4HNofjUSIRCvkGf86vltfRhbfJM3Sed/ZTtM5G717l
	MzWl5pXkFIRxS447V68ov6C+7g4YsCBmP00wm+b2g4pVZm1iPUnaMc5HhxSHqJ8kw==
X-Google-Smtp-Source: AGHT+IHxMBlUR2EBI1X3I1S+oHOhIOZq75AgV5G3zyF3+fn9Opx7Mwk4ouNtkrldZ9BbGhbK2HhcPiLNVh7gswfr1q0=
X-Received: by 2002:a17:903:94e:b0:269:9ae5:26af with SMTP id
 d9443c01a7336-269ba43a000mr7287875ad.13.1758221148917; Thu, 18 Sep 2025
 11:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918115238.237475-1-edumazet@google.com>
In-Reply-To: <20250918115238.237475-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 11:45:37 -0700
X-Gm-Features: AS18NWDfbxgS1C3QsbtuXCHEor_CtZXis9_t0ieSEMDk14_QgCrziMKgxlo2LUI
Message-ID: <CAAVpQUB1g3e29OZP7gzHY=siBqKAxUDJjnbFcywnj7ssGjAhkw@mail.gmail.com>
Subject: Re: [PATCH net-next] psp: do not use sk_dst_get() in psp_dev_get_for_sock()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use __sk_dst_get() and dst_dev_rcu(), because dst->dev could
> be changed under us.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

