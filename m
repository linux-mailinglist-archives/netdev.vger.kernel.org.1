Return-Path: <netdev+bounces-199605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE118AE0F88
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81235189BAD0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69452221FCE;
	Thu, 19 Jun 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxsjNcKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0F220696
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371591; cv=none; b=gXvPWEUOOLXqi2yCckaRPfk2XezDSYGeaHvif9JNX6uFC/e1NVwf5YbWS9+8obNH/h/dCPX+QhUJrXbuQ1VwlRbRprhGhurx6dnyQZBUPraScW1N4SgU57UCtDUkNEoDpDzongUHZITpNOC4P319JZWuw6BTrFxIOSFCFRfLIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371591; c=relaxed/simple;
	bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV7StC1KG5UZarQEmWKImt/2eqd443zZhB24Ozx6LizWD+c+GpxB5QwTUqjx4my7NYlByWPPyV1zGSEqWe0N8Jxym5cHfbe7YjKR6Mlp90iXo7G8cwQZpb1DRGH2t8ojG8gkXJQJICU5QTYdF+8XmVnpiHP+zFmR/lERqvlVBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxsjNcKl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so165975ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750371589; x=1750976389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
        b=DxsjNcKl51AXRSRLfvtYmNUjfUAYw/9VBR7r+MshkTMmzuQphgo7pzLeU8cLmcEUac
         obPM1ecWgPitNNkAbskbX7ouXh+ct4VvOH57K+fMv+R9sR8s980nlkYI6LVcPld23S0J
         Po55ByiAQ/qFQHSioTFiaqs8HB2JtwzLbfCQH8+NroDx91Cm3MwpbWlnfHqbhR59gjvY
         staNRyNhkm98LQpdkJ6kJ784K94aNva7GEGFxYOSYX0AueAUmJmfiB+iHFt9M0SJsBOM
         uozh5NGafx+aWvw/BHxWt5MVV18PXy45GDptDXgnFw8IHi4s2oy2HzSe7WpQJCteftCe
         HGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750371589; x=1750976389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
        b=mwmM5STCnk9PIbfMQvuXQEN/3DNzOvL1hEF96COBmpwMHWS2/EzBDkeWqtXAA1CtqR
         OBlutcX0kih6e77SksLv+zkhK66rV6MEkNKwELsis1iheoIIxl/SZjqf/vd127L5O2Xb
         LxSywKpk4Ctb745hloAcMj0FZHLOz6g3PHYf4BKct41/jOIaZLybvBCQqOTaXDJtNJEC
         uAyS6jOslgOEdHVRRzXiixjJMIqMYsoNBdQfqh0HorP5n1H+VRgzPupuqmIJJqeWdZiP
         wPvgLEZlg7RMeNN5p+g7oUhaW5vRHJ2Erxw96T+zB36bCQ+pfhA3LMZ7dcawp6cYqJJt
         52TA==
X-Forwarded-Encrypted: i=1; AJvYcCVed4QjfqTSNQaNrIXHlXmgnVZZO68G+ijr+p4Pfv93VcMjgf0YxUYHMulMV/CEZbrRwQjWvKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5D0jwdo2K3Dz2Q54VW7Lwn2VrfrQ2MYTU16DsUoeAu4Kjfc/s
	cHJ7xczQrT43XuOC7JfpS86zhmuvcwrMDVqf7LzHo7CQKvUyAB44IB+SnXl9j289fyJHIGsbtmx
	zpxKyUGeqUyMe10Fwe7YsyMLH4p3+0XDRw2lvA1BY
X-Gm-Gg: ASbGncsi0Z0OxR0JBJYvGh8xhCgL8ENFp7y5IyifU1+j1X5LyL9Cp9tm6SAwE/lzBHe
	vGBm7NWq1eene36xDTGQ6fO5yMViRDHEVAqv8phw/qo1p3kOnY9Zfwepad/Ut3J8Puxk8X8LsWJ
	3bsA2mjkGfqI754AddrGW/IBFk2CvdvAPMAZBNu2AuH9+8
X-Google-Smtp-Source: AGHT+IEIuigoQw9BiLSxf1qtBH8TQCN6oIl0OunjJBmsKS0D6b25SrS5tvIo5+EfAZz5fwtG0XZyMihlM2iaVGUlOzY=
X-Received: by 2002:a17:903:19cf:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-237ce047dccmr3307715ad.25.1750371588876; Thu, 19 Jun 2025
 15:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616141441.1243044-1-mbloch@nvidia.com> <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch> <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
 <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com> <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
In-Reply-To: <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 15:19:35 -0700
X-Gm-Features: AX0GCFvxm9EEgLCdwq7qt68RwaSnO_IWyvBob_0iL-n-QjvMmTutgFl2WipSVW8
Message-ID: <CAHS8izNQ+eRH3L-npJXDO7cCYo82jPL0jROBnYXu2U7Kko65Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mark Bloch <mbloch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
> > You have to test ncdevmem tx on a platform with iommu enabled. Only in
> > this case the netmem_dma_unmap_page_attrs() may cause a problem, and
> > even then it's not a sure thing. It depends on the type of iommu and
> > type of dmabuf i think.
> >
> Is it worth adding a WARN_ON_ONCE(netmem_is_net_iov())
> in netmem_dma_unmap_page_attrs() after addr check to catch these kinds
> of misuse?
>

I would say it's worth it, but it's the same challenge you point to in
your reply: netmem_dma_unmap_page_attrs currently doesn't take in a
netmem, and it may be a big refactor not worth it if it's callers also
don't have a reference to the netmem readily available to pass it.

--=20
Thanks,
Mina

