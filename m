Return-Path: <netdev+bounces-229059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E2BD79BB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBA5188F499
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8221257A;
	Tue, 14 Oct 2025 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kkcg2o6Z"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C526B762
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424392; cv=none; b=mZAzY1VtK5AJcnafNj1wO4CIh/cjSJndf01zOi/sDNyP5fC2GbP6k9OSml+dfpyxcKre6b5MQxlzf5gVyfOJ3OTgJ4dMMQA8nAuS2+GEMXJ5nNb9EtmgrkIGrMB0qiXkQmbLI1XmFjN2idOk1bNhnFKcWFDaU9FeD9mv2E63ySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424392; c=relaxed/simple;
	bh=WnqBjoO/c8kpir762CHmptczqk/RZGzkCtze8PMZiSU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DAnCDTihNmaKy3IZ1JcOqs+uCep+WG4y2fz405Af7kU0iQcNGvecatsjToC15563VG9zAuBs02mfXzf0qwok+otfb6jEtoGmQgJaG6UfOPiNvFqIb9EqEHjoEC2oNCD2gDYatWT7Wf6GKQ8HU8HKoYGYDSdF6fCBa91ZJotL2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kkcg2o6Z; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760424388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwtwhr6vXyO8fkt9oCIztDEsy2metbRRMvZzbSM3eyU=;
	b=Kkcg2o6ZLfxDRtnU0EFF45E4PXHuQLzeNT0BxpfhK2gkMMHgHjpAXUUrxME5suh1vsLfng
	wr/IjkVh7rFdC3ovO6wLZAJwDulfXt24JJRG0eA8kHMUEVsxe0f/PeyY9ifc+Vxw08+UAr
	nW9i4oc+VT/vsaCqqZz8Ns9FhKirwrM=
Date: Tue, 14 Oct 2025 06:46:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a0130e21731e7b4c85a313a823f70cedbc9a1495@linux.dev>
TLS-Required: No
Subject: Re: [RESEND PATCH net-next v7 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
To: xuanqiang.luo@linux.dev, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, "Xuanqiang Luo"
 <luoxuanqiang@kylinos.cn>
In-Reply-To: <20251014022703.1387794-4-xuanqiang.luo@linux.dev>
References: <20251014022703.1387794-1-xuanqiang.luo@linux.dev>
 <20251014022703.1387794-4-xuanqiang.luo@linux.dev>
X-Migadu-Flow: FLOW_OUT

October 14, 2025 at 10:27, xuanqiang.luo@linux.dev mailto:xuanqiang.luo@l=
inux.dev  wrote:


>=20
>=20From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
>=20Since ehash lookups are lockless, if another CPU is converting sk to =
tw
> concurrently, fetching the newly inserted tw with tw->tw_refcnt =3D=3D =
0 cause
> lookup failure.
>=20
>=20The call trace map is drawn as follows:
>  CPU 0 CPU 1
>  ----- -----
>  inet_twsk_hashdance_schedule()
>  spin_lock()
>  inet_twsk_add_node_rcu(tw, ...)
> __inet_lookup_established()
> (find tw, failure due to tw_refcnt =3D 0)
>  __sk_nulls_del_node_init_rcu(sk)
>  refcount_set(&tw->tw_refcnt, 3)
>  spin_unlock()
>=20
>=20By replacing sk with tw atomically via hlist_nulls_replace_init_rcu()=
 after
> setting tw_refcnt, we ensure that tw is either fully initialized or not
> visible to other CPUs, eliminating the race.
>=20
>=20It's worth noting that we held lock_sock() before the replacement, so
> there's no need to check if sk is hashed. Thanks to Kuniyuki Iwashima!
>=20
>=20Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU =
/ hlist_nulls")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

