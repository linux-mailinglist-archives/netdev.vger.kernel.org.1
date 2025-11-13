Return-Path: <netdev+bounces-238418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EFC58AE8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF37F3BC571
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2252F6598;
	Thu, 13 Nov 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGY2WRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AD2F6566
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047942; cv=none; b=fn6n7lj2XzQSMXCOgrN/xF3h7bpdvTY5+hsaM/CujgEaSIWL0wXo+CHwT0mWDc3fnjoMYG4pUd6pjfcEcc/yHpY6jW9Tc9utAgFaLdyg/5FxgYsMifOmbNZi/VTkhBWQpa1I8+ykIECe4M1HXsTe+rsYB9Ur7OeBK+HqLM/Ciko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047942; c=relaxed/simple;
	bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIk1viBtShs7pOQpOneoiGCGhWKXz0J4ZJMFV73PuhypMAn/MHZQ9Jfy+d0kmy1JID0PIwO0u21YVs/AFph/TnH4pNrWA76e26/lMfgAq4v7/TbXLBd4aAXqZ+SrzwonLuy+mFATP4MMra//iCLaj/eG1U4lx/4qF7fwOchWZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoGY2WRp; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9374ecdccb4so538229241.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763047940; x=1763652740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
        b=VoGY2WRp5yRxVTVQ32riyXohtSVfxELDM6I+HgSmAshWIggHOjoVQgFogt1jNiU6W+
         yXjIB0XGBlWXqWLQraK7842v/4Nolpx9bMqH+SEb2xObtfG8lOvoilvotJ2b9Jabnp5D
         g/uTmF5UuqlZj8lWdhah+1HBYoxqU4dnS3vkvOOxyfqRIjHvW2ynIZc5CjQnHJdXkOds
         o1MbKETrnKKNgYwik+Az9nfB0DdG2+ysCBJ2uW6wz6EgOgsFPlQiOd6gFbtArQQ9YriH
         UbUX2tk9WKAG09P3q4G7yOpG9Bv3cUDSwLxDg+w4oyWhFeQaA8mwfR2urejJy+0FWETY
         qeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047940; x=1763652740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK/XTH1vs5ogHtDfEDHsy2lCYQYNnOlTeFggXsOVopA=;
        b=UKZY5TVLduYrUyeIg+G0d1S01Shx2kX9Es3dlkl9aoo/wL3nWxJwm7U/z01Vm+qCc6
         8RXbdEwUfDDpFlaFMSjIP7Jr0bB4F2ku8Eg+ZxjJvikK3jrmaKN2Ps9Qq706PNpMMPcp
         9FGmP+kDmWdNtbdscj1sH9k76c8m9EGlxm/6CiBGBD3QryYSp4HGremV1tvLElOthzkF
         93Df2ZDSNz4K28PfJLNy02hX9DZWhOGsi6fh08tg35a8gO51YBH8cpZ4GESvGK/RVH/F
         HtDD6BnZ6eVfUwzcXfR68aPVxeb5eIU85WbVHN6bnoiqkC0n2rEaJyv+yehfoG9xXiE5
         gJrA==
X-Forwarded-Encrypted: i=1; AJvYcCWO5IZ/KmJWXCmsh3rtJ/G1RZXEH3QXKg0NVfZfV9O3X1jBrmie1QhzLwKhU/HXOunJ24HkkQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WgzBfiBf5xATcipZSfhMv9k8crSKZUf2TqhZRgwMQaLU5mma
	4gCIV7vd1T0Ktq/1qJTOrMgz3JmOGvnK6Qc83Dmfg0FE/GAyDYhBMNM8eklnuf0MRlHP2gekign
	bwYbhVlk+86GPR+vIaUAkKf6j3sF1n/A=
X-Gm-Gg: ASbGncuILRqufWZPtuc+CX5yjWL+XbUz/qc0+FE9b/H78k6k33bkjDIqCG/SlynE+f0
	v2U0LPDNb+1rDNeEjaa9vMs5e4sd1l1c5vPA+f6t/4AozwqJOxvqMIAkVOM5K4gNYJt9u3Cl1vp
	L1tWz+0mdw3ATYhQ3xvy4r17GVald2kYx5bjk8LH8VAGNp93TvCTBpgjB7Kcci/Mlm8nQft9WUq
	KcvKTILEXWv9QGCBFTbxgCMuADJ5JNDsb+cYS3MQkBSU/HYZs7FFupQQkyKT9c=
X-Google-Smtp-Source: AGHT+IHjkzaJR98ABGf7JPdxTaIgrD7ydPjrcLBtkfxsqqWMEkSquvfD6fsm6+pA4EMyJmcW5nPIV7Bo8G1boiTHdOs=
X-Received: by 2002:a05:6102:cc8:b0:5db:ce49:5c71 with SMTP id
 ada2fe7eead31-5dfc55b0bbfmr17704137.18.1763047939722; Thu, 13 Nov 2025
 07:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113092606.91406-1-scott_mitchell@apple.com> <aRXM079gVzkawQ-y@strlen.de>
In-Reply-To: <aRXM079gVzkawQ-y@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 07:32:08 -0800
X-Gm-Features: AWmQ_bk4Cs4HA_t-WxTixgm-463gTBOmlX39m7CT2eAG1Up1wBQtX5vxCBOeAL0
Message-ID: <CAFn2buDiAqpdzo=50=QA6zS1TZyFVNHqKdqvoixCuWcGLF=uAw@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Scott Mitchell <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:19=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > Signed-off-by: Scott Mitchell <scott_mitchell@apple.com>
>
> Didn't notice this before, these two should match:
>
> scripts/checkpatch.pl netfilter-nfnetlink_queue-optimize-verdict-lookup-w=
i.patch
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Scott Mitche=
ll <scott.k.mitch1@gmail.com>' !=3D 'Signed-off-by: Scott Mitchell <scott_m=
itchell@apple.com>'

Good catch, will fix in v3 (coming shortly).

