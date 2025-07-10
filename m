Return-Path: <netdev+bounces-205891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B07B00B49
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EC33BD60F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0132F4317;
	Thu, 10 Jul 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT+Gzrgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E41E8333
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171930; cv=none; b=MDUDdaokSFVOsZdHw5/9QCvlo0bjowwCTEh3GL5sgmqDF7EjrFsb9iGrkkWquuWjDIKhfx7Ij9ypNeG6V/TvgJfW5cN4qL027DgGRJAZ8LrCiMTQDQ1dOmIpCeZJDqXjxTSms61eph4GW9i6YzMEZX7+6QacU6UXinEq/pdQIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171930; c=relaxed/simple;
	bh=lzOg863td9wmwIzdOW1a8mSXM5R7uBGHNR/Wq8C+XKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS9VJ3+mdpHEqaXbToB90hMl8X6Z+ZNrz0+YUZWr71zIeg2aNNJSltvKoBN6D13OP8ELPnEI2hqw6FiJYSf26iRO/tGOmbEHRpEYcC/K/Ka9Yw10mLRIpa0WkLZKrtGb5aMRqDq8oH+qXp5JVBHw1hLVkFBKBbhbC3SHG5YIrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qT+Gzrgf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso1977a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171927; x=1752776727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=qT+GzrgfFbv7TNCyvI1nwQhemlew7h2QPaGYd69Kqi499zFAgpcsA9L6Ql8C2UR+2b
         z67/WVydCFIO9AGIyO1OsXS/QNtLnHPNtzbW4xhg/W7vGQqQ0v819gJlOeguSiYqoazk
         yMTfvUrnnPivCdLvSRZcCBY1l6MvszfzuWVhO4rcMWA7DWJFMF0dFW5zKB2ae7KxMgpZ
         fQsioD+YvOSbxnDPApSnChHOEQ7WgMczdqaCs+9KmDuuYoiQI34SRzh8O3sJQLGt4fOc
         +b1hMmPhnAM2GtRhbfsEDW1nlV0Dlnerr9J/1xLuLVglKv5j2qYJvI6pA9uC1oWpWxyH
         6ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171927; x=1752776727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=ke9FiBhtK4H5aiwpefSPpeeZJnop0y2UnHB/uLxDwNymCFJwGbVrlULfFmVoJolzDV
         YdFJQahjqLUl56e9gJG8HURTLeSSMSTyZDrV58QJknLgDeaL03XKuqq8FO5/lFqO7X+o
         G/QEOYy6GZWT6kRFwTTBDozpwcQ2GFzX6TJHaYYBh1aCIFqDiDifCZCEV95nwEvoLaeD
         tuXpR87Dy/Qs4G98eKXyKsqtwhtPTybyJ7ZpPC5boxB9Pv1/fCnhG57eXoxXfhUXrrPf
         6h9b8NjUfI6tZz214Ikmsq1E2fictDIkzqUkDidPS3ZTdvI6KUkzqraZXGunlFFF4XAP
         9RaA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLAqcLZnj8Licgbqs7ZxNU4sXjgBgkKb90/PZr2OVnR42k382G4RoJ4wqC0R9dzNiN2NLqyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6jWID80pq5YqfprUHqkQqgBJtnyRU82To0xMLk/vEt0fJX5j
	AlVJmpC875QRlA6/hM36jvZm0x7OwlWm3zH5wOwMXUWFtnpr2AfuNwJupdmfiotL201EgBIcY0z
	KmAcUoU/ypzvDez0rdBKahP7WCNQIC/FyggCtjH4v
X-Gm-Gg: ASbGncunWQCmPOp56YnMUqWBlsMnA9cGnD2/xkU9nFM3a8Q9cuuG6VIIK0vwXWabFOt
	1oHh1VmSSuOKHD4toaQu354S9KTYhJwy9lkkm30T8bhkVviwvprKx/arlCjRT2ztP+l7GM/Qtzd
	z6FcWGiBWwmZTRcz+BZeUX7bnwayrch+34vBqtDMTwsYIF8blDPK4m5NCxgvFaQV31V9cCDaQ=
X-Google-Smtp-Source: AGHT+IFYbu4F77iXBeAnMl5OLLUNqSyy6NKKa5nSrUrX3MSMLO1UBBwllp1ZZ2m2gbUJ8CJrAGBesZolk6+61YYGeCs=
X-Received: by 2002:a05:6402:30a6:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-611e66aa77bmr9269a12.0.1752171927040; Thu, 10 Jul 2025 11:25:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-5-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:25:12 -0700
X-Gm-Features: Ac12FXxKh5TJZHgIcSqvUZXVnJGYFBLJKrIZOv19NnRAZsweNKYOtzi0atTHg_c
Message-ID: <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page
 to access ->pp in __netmem_get_pp()
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, __netmem_get_pp() still accesses ->pp via struct page.  So
> change it to use struct netmem_desc instead, since ->pp no longer will
> be available in struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 11e9de45efcb..283b4a997fbc 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return __netmem_to_nmdesc(netmem)->pp;
>  }
>

__netmem_to_nmdesc should introduced with this patch.

But also, I wonder why not modify all the callsites of
__netmem_to_page to the new __netmem_to_nmdesc and delete the
__nemem_to_page helper?


--=20
Thanks,
Mina

