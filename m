Return-Path: <netdev+bounces-237893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF35C51489
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE54213FE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD92FDC38;
	Wed, 12 Nov 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAAe2lRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C612FD7A8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938023; cv=none; b=Vg6AECt2FLrpX2JB9O9dbZzB4Xk/E9Y/wWn0dgBFjyOky5QwU8BMxkze9Vb1g//z3C2/b5ecLPAp3T/WdVGPmaNZ8wWvWi/yITyn3rhrfOz+yhq+tbz1pERHXfxI1NryBRVhvhfLOTilwz7BaSh9IMMJ+ggIaqgNIu0RsUbdr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938023; c=relaxed/simple;
	bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdAfdZM/oNZAYJxQiUWlAKapSyp/EsIWQnv+8RsaAlWFTVvMUT29we3A4jy6bpFbXBvOnU0PllVSTQ0lFOTENOHPys83EsX8+LKUiUtdzanY/L+z23cJEi3SCGdiygVH21/n/W9JW8m+T9K+0qSMqFZDueju44D+kbjgfBhUKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAAe2lRk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eddceccb89so5166101cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762938020; x=1763542820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=AAAe2lRkFqxOg2bTtykVWUzUmNzwc7iUqQq62/g3bpVBJE2xcTNhFzoyethPS4vLO3
         fC5X0Eo/h2+cmwYmdCtpBiQPcxHX7ByNwGfCKKaV5o3VgLGRPVJARtNoTwLPynLHk9Ol
         CAjx00vQyqu5cLkvx3C3nRYJjh1/4TFysAj0xm3l0qffTlqfpo66EMvKUwUSTW5KAEFS
         HOMxGyae3ZvwNoxdfEokjDVWsII2Dhukf79z7Ix8uiEvFiMu0evg/iwngrj5jD/6LbF7
         n4oLYEuSSeImF3scQI/EUs2G9j4HBptgKyTl92+rwbXvNKGqTTAuzH0Gmmjs/Xb+kTln
         nC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938020; x=1763542820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/Krp1Ed64Q4lcPqqFr5goeJ3YqOL6srgIYEriymza4=;
        b=NhA6YDxF/D95Szr2Rnw4kRm5FNURukd5XO9Loqw6nGNda2Lnlf8nIigaXwxFl50gB1
         GMWI40ItnuGI6jig0m5pXnLo0yYfC48etVESISO7ElwKYN2xxcfWRCrHAo/+YD3A1aV8
         ewtXeQ+R39L55AlTzyw4saUzd4VBFLlnHdtUguHcPpUOKim+c/NJQCDxChnO2T/ZTARc
         LhMJNcDeB60yFmGs+OI5GK+a6ZlSXVnFGBaj1Xwl7JSBbWx4rMwlpFTXXQGeS3BfstKL
         PR+q+BqyJ2oltyd7khL+0i+3CRuEtplky9AlrOVJiC+58GuUBYgEDBQqhBH/JebsCtM7
         U4Og==
X-Forwarded-Encrypted: i=1; AJvYcCVfXikitQcGHbnpk5MKnlvqKB+ER3ZCzOqv59RGFwKaMXNAGpOd/7hNfI/sMEqk3DXfjWl4ZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcoq+adE8Kh3XMpG5DkBf/WiBvUL1PVfY2VNdoPaJNVN7CNNji
	ZJBtHAueKfhYD29x2V293g2Zsj2AIrX4mS/e8TNxFJorULJx4HebYCvO0IDAyzcZbnOY2VZ3nma
	Nweq1PSB9SyNAJf2cvNnMA6PD9CrL3ip2VyPwGazk
X-Gm-Gg: ASbGncuzMYVBzWarzhGxrYyZAOXMxMm4o9lrVBKf+7sGbV4j7ClmV7LHNI1DCOLjnKG
	RKdRIQv1xacitHBtCymXCQfQWeQditkQdgHxk7lhgQKKzjQ57vaGgzKJEEjRVPSSrpCAp1jlYsi
	W+sd8wd9vucYGZd2J+K8+MDl03q+cFLJ0hwdFzC3Zb5rRfczBYF74jXSTM/1Ibri5M0eXAqu0pX
	mW2GR69YSAiwOCqv3YcvW4pSiX02nAB6M810bUncjA9KWm5Ol/7infHkdIbiTUNxqe9APqw1zNJ
	Ef5Rdak=
X-Google-Smtp-Source: AGHT+IEzCQ3YNHW4UtVKvqkX2yjhSogviPzmTzb9PXWyqz3RlNdC+8kFSE+KOjdjnU93CyVP7UU5sqx6RahkBBvzCq0=
X-Received: by 2002:a05:622a:d0:b0:4ed:b8d6:e0e8 with SMTP id
 d75a77b69052e-4eddbc9aab1mr30299041cf.22.1762938018726; Wed, 12 Nov 2025
 01:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111064328.24440-1-nashuiliang@gmail.com> <aRQ3NYERGcHJ4rZP@shredder>
In-Reply-To: <aRQ3NYERGcHJ4rZP@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 01:00:07 -0800
X-Gm-Features: AWmQ_blEvxDrUtRwU9ZZmEwZxbCjv9hVvyWPhviWRL9cCYxauIr8WxQDUJlUNqg
Message-ID: <CANn89iKjuRZjeLbZ9v0TcCUEqah3pQbq0-tBPJveavwK=G1ziw@mail.gmail.com>
Subject: Re: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:28=E2=80=AFPM Ido Schimmel <idosch@idosch.org> w=
rote:
>
> On Tue, Nov 11, 2025 at 02:43:24PM +0800, Chuang Wang wrote:
> > The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> > update_or_create_fnhe(), which lead to fnhe_remove_oldest() being calle=
d
> > to delete entries exceeding FNHE_RECLAIM_DEPTH+random.
...
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

