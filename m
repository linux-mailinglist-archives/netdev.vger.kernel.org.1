Return-Path: <netdev+bounces-191277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A810ABA859
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F44A200B1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C0155C83;
	Sat, 17 May 2025 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtMZHUiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3844B1E40;
	Sat, 17 May 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747457319; cv=none; b=YvBb29sutlxsRdyoNIaIicI790ZKtgcNh4W6BB5VmhnLRA4bBlwiUUMs+VeoZcHoPzXstYCHerSRO1vKFihOw32DF1BqMjzJucNd0GX2ipCn76HLhtwY5CBeNH6/EeDI8tRIdOQvL3UoihV2oBGuEjpdALKvbP7AmAOuKfRH64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747457319; c=relaxed/simple;
	bh=FRAy3vM1G9xP5NvQ2svLToOXIKK2wD6lRR9UnvgEWn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw9Gc2PWCbC6x3mKagTxioCDJ0KM7+Nhv7CDeG5XfDS1+NbktyC66VrjASu4ywxMrohGKpj+gChEtDxd85LIRgs0wWmmCiK464j7ZA3MKEGec2s4kZ4vaWTnVfLVCkIrL1Z/sDGBKeR2dBcZraqAXVH7SgUBTQd49y9Z9lQveJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtMZHUiw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2923874b3a.2;
        Fri, 16 May 2025 21:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747457317; x=1748062117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XbfjZMbtwkVDDrz6+FiZiiIXx66Iu4wAcmYxqSSjfKQ=;
        b=OtMZHUiw0K3lBUhsDJ/6VUlB1BeWAHJlZFBlXrG6T0NMAOeecYZ4GWOcUpmO/ggOMN
         uhAZI7nZGfiKSD4upSc2AmqU1dP53LSeGokR5pqPrzOd2+lt74OYHaB0T6NDUpt+EElg
         c6ctpsJxKh+yNT+vtfqUZZIJL2gY/rMF8Pd92N+xG1AF1IMqGBl1xrD5u81Qh96KOC7u
         h3gqARJ2IizKR+hb+7DXkvaT/v0rBSIecMt6cOIclHaE+WC6vUDw19PJIpVlbXgkzfG7
         k6qWAZ/bLc2v927s1p0/FPsGy577pNdETipAhnA2bgo4qta4hv/GqbqhSffasuCuuBrR
         0UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747457317; x=1748062117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbfjZMbtwkVDDrz6+FiZiiIXx66Iu4wAcmYxqSSjfKQ=;
        b=qe+yiJE/FjUn2bPM6FlaGTPcAf3JOiYKvf3W8PrL8f9L0NoGLxIl4zm7jk1q7mop8V
         Rpch5llCv0kk1NRjGEwV2NBR/FaP5RzjLk9o47PnRw8yD+mUlyNYfqi29716Ae/Tc0Kr
         isA77hML732AlcZKoR6c32LDWlOBy1w60x+Xh8jk/v13iY6j7vd/rYbXYAYUP0CIGr3Y
         frAs/HkjVuplDPNzaSnYIg2VuJBr81wDvBlEbnWgt8TPp4xojEPzWdPU0LuM4V8k10jC
         apw/+I4ab9FXYtjnzxv6RZ/ABFSRkAcx3fhzD3xdxF5hUv9f7+vz9GTItMDpOy9cs1g1
         qU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv57C6M0X3F/p6j3UydyMjgtGEfnMAIT9dPHGobFMnkonfPGaHVayvjEFutARw426eqnWPfOChqVC/juE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy293cBwoEv+aS7Ku7PZrn6cZJrge9ODPT5X6AIGS5ffe21vOkC
	qAgdVT4DtDyAfhcqj4cYhLdek+vSWP5DTtr4ajBhC1+6ISd1JUWfwAc=
X-Gm-Gg: ASbGncu4TdNz7JwVThVWEDFjZiLsAf80AnX8ROgDb/Gvg0X+R5MYS3+K4Z/yFv0Rd79
	g4mcbNcMLDMq5ROjc8HLLjtjbh6D2ECIK+/RJPhWeJaCds5AkzxlB6yGZ9Z585LElHLMV1S/CIM
	jw2qmoB2RwL/gDK7P1StTGS3QIpmjnay6XsyGpRajBRnuftY9fP2L5XrjfG2m8FqUkEd4VCRLzw
	MuZ8AoOIJuzXd1sRW7eOhl5mUGJd+uOaBkPlPWSy+qMq9i5XR+GZhX5j1XxoM2AjyCOuHpEEJG/
	L9G0PoNJEAdjoV5Tzdj3cE0Jea3mlsoZnV4D39xMt3WPZK2xZnSmVHjvHi60BKGdAxCTLsAoW0k
	FhS1/ZZ+pMxun
X-Google-Smtp-Source: AGHT+IEazJPB/VfK/9SMna/1tt8qCElQV3gG2ZmGn8Asv1SBJdierHJZ/E8v6MPBPrK0mleK43K0gg==
X-Received: by 2002:a05:6a00:2790:b0:740:5927:bb8b with SMTP id d2e1a72fcca58-742a961837amr7359582b3a.0.1747457317282;
        Fri, 16 May 2025 21:48:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a96de111sm2358997b3a.3.2025.05.16.21.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 21:48:36 -0700 (PDT)
Date: Fri, 16 May 2025 21:48:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sagi@grimberg.me, willemb@google.com, asml.silence@gmail.com,
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
Message-ID: <aCgVJB74lYb1zwFo@mini-arch>
References: <20250516225441.527020-1-stfomichev@gmail.com>
 <CAHS8izNJQFGFjVr42VVh2zHJ+PxfUYCupEdHka2dd0no_b=GHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNJQFGFjVr42VVh2zHJ+PxfUYCupEdHka2dd0no_b=GHA@mail.gmail.com>

On 05/16, Mina Almasry wrote:
> On Fri, May 16, 2025 at 3:54 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> > iovs becomes ITER_IOVEC. Instead of adjusting the check to include
> > ITER_UBUF, drop the check completely. The callers are guaranteed
> > to happen from system call side and we don't need to pay runtime
> > cost to verify it.
> >
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> 
> Looks good to me, but can we please bundle this with the fix for
> ITER_UBUF, and if possible get some test coverage in ncdevmem?

Yeah, let's see where we arrive at wrt iter_iov_len with Al.
Will repost with a selftest change.. Thanks!

---
pw-bot: cr

