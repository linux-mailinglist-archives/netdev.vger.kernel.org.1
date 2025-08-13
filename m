Return-Path: <netdev+bounces-213124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2FB23CE1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8828916D13E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202D2C0F84;
	Wed, 13 Aug 2025 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYMqUeM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2622C0F79
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043259; cv=none; b=KY3KzN+Ozbb3MtAVx9hQ35vAN+qTSMzIxzkNfLbGP/VqTu1m5Jq4bS2Tth/YhkpAb7kNF3NIlqEywaLKesI3KbJ8AfPY6qtoq6Ok7lp4F0EoGZ+1LV65CJFp4452h2IkL+YMYbMndBMWro3GatVvz+QuhNk8RcMIbZ24Y1mZCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043259; c=relaxed/simple;
	bh=c571YZCYD0tMh1R84Fc6KCAm4PXr2MBZWoUZ/PGDYMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLrO/xWZ9u2Kc07w9ZRzJ4fOcNxIBbzDYxG52g69VZ+Vx93BndLgcyrGO7DveksWKQR0qor+sKEqTcxT6X8s8FCSiZMuP4PtiFGe0K341rCobFjW00OW1szKNQd4upVvzMoqUE7UQ7IKOnsD7Y+ILVATPpInH6aCRUS5owJYL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYMqUeM4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so4411e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755043255; x=1755648055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c571YZCYD0tMh1R84Fc6KCAm4PXr2MBZWoUZ/PGDYMA=;
        b=VYMqUeM4u8GFCjuZXsWGLgB/UWTQMNF0y7z2EwTBjMy3Dy9yWSMmT4JR61r7XM+kkV
         Y+H3GQKoSioAjDoAaSP3z+1r5QFAsoqC4ppe59UqdyfIOccBLpcGfLfwA8VnuSovcKod
         ItO9BDS/ZdeNezDo7HJHgrPqyXF8hB5AlLRTGlMxbdGyoL/gSHXFq0P+/6iqjh1bAhmy
         nvVpJ4hZXN5fWxWlqN+MujtfLUl2msWOwz+WW3Rb7vYA1CNScmWizrtktZphfAbAPtHz
         VInJb2RDe7vi5NWr9ju7vfEIStfWkgI+bh3lWlQFlhPrniyOc/kpEZlAE2f2VpyTxZ+J
         GU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755043255; x=1755648055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c571YZCYD0tMh1R84Fc6KCAm4PXr2MBZWoUZ/PGDYMA=;
        b=kCHCjwYaSOwskk0jvB2y5FcbTEwHVCKi5ar/zcL2D6ZVXLN5s6aglmMr+sy5tm4f0j
         ZkH1Q5e29lEkgzvwFl5UQ6R1MRWtE2N/dwRYqorYL1m6X1OxdErmh9/1TNeCIh8CN406
         p5bitaa21HCCQmSrvJy/41x+zHxij2S/QvaYgCWKULxIWrExmLf6XsDIawVWLQ10MFXJ
         MJiPzdbTR5gAw2RQZyq9WhtZnGB6iRya8OEkGDYGu0VEOirfe2R9ljKGjNnN1YYaL1sN
         EHPP/py3H5C/dj4p9ihqNZu/WESReK1QdDJjc2QojL5lOExKEm32j2vDeR1tZYG/DwzD
         0GQQ==
X-Gm-Message-State: AOJu0YztyBlKWy4ky12GLqLELlHf4kRWbQVqmLxqbJKaf8yUxbG3AxoQ
	ePjk0KpisWB3in5tNZvNLa1wEEmgbo8pzherdvftzSNcO5tAEQjm7ef3WIfh94zkY6RniueJwWJ
	Rku73dOROVjq5l5n3NKE6veOnd8lO3WWLm34vgah/
X-Gm-Gg: ASbGncsHgzv6Td2SW7YTXz77p1gV4OQP6Qa3Q0YyJP/DR8yRMaINmHG032YlEb00KOv
	eeheHAy1EHsoTt8eKNw64PJhJBHsC8wjQxgUrknc9Y2EjNl0n14zMjG89RxKK5mU8cc0xhrg2jj
	LyL3ec8CdztEtSre8lXlY6ZXD1XN1H3j+wUJv0sfEv+A23QeTD5RspGav8brx8YtpsNXe+NgRTV
	XqI8WEcGOPdtWaXyDGn4vWJhDd5b6e93zVfApgdyeNLds0=
X-Google-Smtp-Source: AGHT+IGXkfz9aPIiA3YKyKNqa236eKuq+daa3eMwUbwUlonMNAkXBvIvnfyM64NaHLZxZhAizunGRNYOfE++EYw4y38=
X-Received: by 2002:ac2:494c:0:b0:557:e3bc:4950 with SMTP id
 2adb3069b0e04-55ce126a661mr51122e87.7.1755043254700; Tue, 12 Aug 2025
 17:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <7a23accc86f478bd1d4c35340211b87ecebfc445.1754929026.git.asml.silence@gmail.com>
In-Reply-To: <7a23accc86f478bd1d4c35340211b87ecebfc445.1754929026.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 17:00:42 -0700
X-Gm-Features: Ac12FXyRVcL-LVlPu7dSMsPFJUbMlAGpCDYWIOkrl2hSy-TDE06PBWrwHf56Di4
Message-ID: <CAHS8izM_m1Fe9VRexeSRF37DEqZizDjVdmahCeF-BarrF6cBeA@mail.gmail.com>
Subject: Re: [RFC net-next v1 3/6] net: page_pool: remove page_pool_set_dma_addr()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	sdf@fomichev.me, dw@davidwei.uk, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Byungchul Park <byungchul@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> page_pool_set_dma_addr() is not used, kill it.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

