Return-Path: <netdev+bounces-195315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C35ACF815
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280FD3AA634
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368027C879;
	Thu,  5 Jun 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tt4jdPqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58B27C864
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152093; cv=none; b=G3jxtvw2W8S4AxqON7TLFdm/Mp7lkS6DvVFNgUWcPzBG9iQDP6g0BthwMuMyOEPTyV55KftSMRV7P9gQlyuK9qsN27U8HjW4Hm/FLlE0c2KBPRKXUDXeBuObdzMBYI48QiJXJd+isGilghF4FnkD8VYRKG2IipDES/ekxcFzvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152093; c=relaxed/simple;
	bh=7PG/uj6iX1rDrX3gn8miV3IakCmWHipcoXHozd9kqcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHT29mRS2ReWXVbp6HWSb1f6/k1eyT/d3d8bsF7YwIAg01GwcFtNkhhpIb4XT3z09bhZSVbB39ypbOQKcyDm4X5ShKEfE6/P/RtHZDM5N+6rxri+G/mTmoQm5+aDjqy84mLyvSoRNNzS1XGfvw5EyS4kYgBHT+Ga1o43sO5ZTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tt4jdPqm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e389599fso50115ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749152091; x=1749756891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PG/uj6iX1rDrX3gn8miV3IakCmWHipcoXHozd9kqcU=;
        b=Tt4jdPqmZ6JqWqbh3JIza4eCUhASXygYvp6A0zs3M9YxY9OUKWwddg9pxO5EccfRxk
         cHQtKGLNErTkzs72VTYMRLRtJYIgoVGVdcpjgFTTQdUsxfmKeM6QisRgRaI3n0nlS58n
         p8Nb7fbR0kJ5+9JCERA7rXEGlYba9aK4u+EAxQ9BzwXfU69VUvFzTGnhzlvuZQgofBGY
         AKNBHcUPQWmuy+cs2LAcHmvtaE+WOOS8va4w9+hUcEWeJ5rJjk+Guue8Itf9r2wQTRLu
         zjqB/02pZv8XK6U5KnkZD3wmHXF1BGDyq+y+ovZRVLj27YWCPpRxElBfFN7xTzsOeI1X
         T7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749152091; x=1749756891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PG/uj6iX1rDrX3gn8miV3IakCmWHipcoXHozd9kqcU=;
        b=apzU3l5o7gFwdI6/mecYgMOE3VhBx+9Eun814dcJ5zMX9SKDwNZQmvqfFUsO4/VwJc
         /gFsVDyS3sTzJWk5NSLfapd0x/XAw1RadCadDSalfGTeD+TIsCFfKd6059y/xuW/jAsL
         P2fQhxT5LX+MN5Vs+AJH07eThHkX3wCWYbTlWhTirDPBrFx5OtvTUDJYghYkXS9dsgie
         d5tyl62b+nM9rv3AtsNstgOSIw7Yu8QTro7zxe3SBl4/Bj0srKkXjZFqxkClfELXJfsD
         tSQU+PZBxDWWc/A17ioRqpSSBV14HJDMpIGPjPO8NqOthLa7YfwC9JYmgK/8CPU9ABKy
         AlQA==
X-Forwarded-Encrypted: i=1; AJvYcCXKv86tm8WskJ/jIjul5YugT8hw0FKSvsvsy5gBfqI4p3Mjh5MZoFIty8/VNHZTTmx32hFsZE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPqRKse3ikEeRW5OoKLl8TMCAeS/C/UCLd+aMdgNuZ+ZKHDzB
	Vb/OPwu3CDUdXiWgYW0pgR8sca+ehjIa+xg1gGhAhlCsc+05+ffGRzc+xmF68E0E3Ne1LqjBrEv
	k9Qv6uD0QpsMtxnJr5Tp0ia+bfCysqRNZVWy966VQ
X-Gm-Gg: ASbGnctdYBUBIN7zrqCfpzXMRwfdsdLwxVLojZYE77yJJ3aJEvqVhp8TBstietySVpy
	re7ySzU2uqEb6s7jR+sRoDozubSQG6qIDMY+H14qWbtmroPeqg/wrZVepSzR1a5TeL4BI6rKmQU
	KaGnJcPv2IifT8mVXBzF7dnjHKu3klsGEOGEqmJIVNtfPr
X-Google-Smtp-Source: AGHT+IEcBAmcCW7znXUciL7hmQbcQeJyCG9JAAlVkwhKBled24X/+cQ59jEx7pv6dRjISm9NfeEn30rvErYKF5iZoUU=
X-Received: by 2002:a17:902:d2d1:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-23602114453mr554555ad.0.1749152090848; Thu, 05 Jun 2025
 12:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-2-byungchul@sk.com>
In-Reply-To: <20250604025246.61616-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:34:38 -0700
X-Gm-Features: AX0GCFuVFZhT5tvS9UCBRC0N3KvmN43VcGDXR14SnL2gwhMd2wGVYx4daVW9aIw
Message-ID: <CAHS8izNDmQRNADggyTNsfQHFBnfacK9=sGvC5wx_KvfqwAXZ_g@mail.gmail.com>
Subject: Re: [RFC v4 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:53=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

But, if you want this merged via net-next, follow the netdev rules:
https://docs.kernel.org/process/maintainer-netdev.html

In particular, the series needs to target the net-next tree via the
[PATCH net-next ...] prefix. And net-next is currently closed, so
resend once it reopens as non-RFC.

--=20
Thanks,
Mina

