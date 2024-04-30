Return-Path: <netdev+bounces-92395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735B8B6DF3
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC741F21B9B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58309127E02;
	Tue, 30 Apr 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2teIgUaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532E127B5C
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468448; cv=none; b=igVLi/OuJQk60okoZJ+nH7hjrJYcDUYCRF7szbdp184k5MarXWzjHN1aWyHhj8J78G2C3dVVBpU0nkRAzTA2tBQgUsiIeyZPT+6y4q5+IvzrMuf9AgUYyr+Y/Ci+LNT9EJNgd9EatalP95vCbTzZ8Hw+z+tBrF2fuzKavzXkM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468448; c=relaxed/simple;
	bh=N2lzBVw2lr4WtDfNk0drsMeoSUV0wZKH/OApeCDEZEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyuaGPu0fcxqquoeuadDfY8TVyljttlts4Uvwf1EGaqym6TjPHL9SWYVTjKYukm2oqySzfUjvksmDLJyATh2ka6HKBdqAI63MVUlySV5/BGwazbm5TorGAxfznflptXISFuVfBvUGl6k7oC6nmXWOaUF+hxHKUZaoSKw5DYuwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2teIgUaC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so8349a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714468445; x=1715073245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FocbPKzD5HrZmpyHRzBTHqmJFc95qxxL8tR7XKXCiZo=;
        b=2teIgUaCjNtrIe2DGr/mG0VQCp2gWKUPBlNVI/T2KS5d+/6WpGpNkoeeg+8nP9HJxz
         01dkq9Wr7ybXdrMZkgPRVmsH1nGTMMPQsPQhQn4BE4bLiGSj+GA0e9QYphRwwukY2xfB
         VkVpt1EuBLE+p+yqWbU+3FY2ii8tt9kdH8zoFCi+Iaiqoy2KPHtL/5R94Nnd/jwZzkQV
         JvCXDIMqMBB8+3wi8T1IGItC6Uvu+0+eMK0aeLHINHUdS5sVBtpahORLIgNYxEfrKyyv
         8TH0S5ea3sHCp1n7K2LFFFxmhkY0uaxtXiPY4CYV2b/mhzpL07fZsQlVTIMnXdbgCiP0
         DeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468445; x=1715073245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocbPKzD5HrZmpyHRzBTHqmJFc95qxxL8tR7XKXCiZo=;
        b=RiFXz6RXNYd7wbHfaV9xKSzPikdJwBkLVOqX7ODNJ6eSo200zLegsUacAwyfsyv8Go
         gKJskMPniKetJBSs53FqC2NAKg3EAl7XBA1oA4+ukZECC+f7cBT7tMrbfgLFi79trTIU
         SlUqDyNHCejXGp6QVHjiErTJyFQqB2+Msx4/Oh8eZM2l3q4XIrxIz8IlAsWDZk4L//sE
         MluB5O8RFZbxf0AXCxEmTyzAXNIWPIxe1GykFdDN2aVa9POUAMz3zJusQo2Btdz63Svw
         fRHX79578ZgxverRpJ5amR+gzHneNwkh6jhObd7Pua/0eD81olSctP+HT5KfH5teK+R8
         UkTQ==
X-Gm-Message-State: AOJu0Yx/mN5oi/2V6FthMfi0U+dzRVRFR/i1HWgZB0oyh8mK3cS68Fnu
	M37Iu5hLyt8nsIjGHXx00//VEC1v6sfpTdPNga3DRfo185UBa5rQ6D5i/08q0PJ4zQpheNGRO+0
	F9+tB3e3Rs8wHCPHuUBOj7vdlP5BY32bZSswA
X-Google-Smtp-Source: AGHT+IE0MmwvoQwDMVde6mJ6aQ3qnBpZkXo/WiXpRO4AMVuasRYNpja9Eigd+6zLeAZkiK1BfniwQZaUoeKknwEi8Is=
X-Received: by 2002:aa7:d1cf:0:b0:572:336b:31b7 with SMTP id
 g15-20020aa7d1cf000000b00572336b31b7mr147399edp.2.1714468444533; Tue, 30 Apr
 2024 02:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430084253.3272177-1-cascardo@igalia.com>
In-Reply-To: <20240430084253.3272177-1-cascardo@igalia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 11:13:51 +0200
Message-ID: <CANn89iJpp7AA=bb_BnYFskWVjf61hd1AgPmU-4ZGOUZQhsYgJA@mail.gmail.com>
Subject: Re: [PATCH] net: fix out-of-bounds access in ops_init
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:43=E2=80=AFAM Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> net_alloc_generic is called by net_alloc, which is called without any
> locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. =
It
> is read twice, first to allocate an array, then to set s.len, which is
> later used to limit the bounds of the array access.
>
> It is possible that the array is allocated and another thread is
> registering a new pernet ops, increments max_gen_ptrs, which is then used
> to set s.len with a larger than allocated length for the variable array.
>
> Fix it by delaying the allocation to setup_net, which is always called
> under pernet_ops_rwsem, and is called right after net_alloc.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Good catch !

Could you provide a Fixes: tag ?

Have you considered reading max_gen_ptrs once in net_alloc_generic() ?
This would make the patch a little less complicated.

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 2f5190aa2f15cec2e934ebee9c502fb426cf0d7d..dc198ce7e6aeabd8831be32f0a3=
b5bd1d0a77315
100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -70,11 +70,12 @@ DEFINE_COOKIE(net_cookie);
 static struct net_generic *net_alloc_generic(void)
 {
        struct net_generic *ng;
-       unsigned int generic_size =3D offsetof(struct net_generic,
ptr[max_gen_ptrs]);
+       /* Paired with WRITE_ONCE() in register_pernet_operations() */
+       unsigned int max =3D READ_ONCE(max_gen_ptrs);

-       ng =3D kzalloc(generic_size, GFP_KERNEL);
+       ng =3D kzalloc(offsetof(struct net_generic, ptr[max]), GFP_KERNEL);
        if (ng)
-               ng->s.len =3D max_gen_ptrs;
+               ng->s.len =3D max;

        return ng;
 }
@@ -1308,7 +1309,9 @@ static int register_pernet_operations(struct
list_head *list,
                if (error < 0)
                        return error;
                *ops->id =3D error;
-               max_gen_ptrs =3D max(max_gen_ptrs, *ops->id + 1);
+               /* Paired with READ_ONCE() in net_alloc_generic() */
+               WRITE_ONCE(max_gen_ptrs,
+                          max(max_gen_ptrs, *ops->id + 1));
        }
        error =3D __register_pernet_operations(list, ops);
        if (error) {

