Return-Path: <netdev+bounces-64529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41D8359D0
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE091C225F7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEFC1C32;
	Mon, 22 Jan 2024 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbvxDzCA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB017FF
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894839; cv=none; b=BMuJqLrR+lxKOtOkH07DvdvcXBYLIo6VEREM9RhLxpoiO1xo7E5QGT3Yn/sn2/kU61lH8OytlDLskjs/RUADpmZHeO5AJGBlGhUAHhJ6lghD7YAGD/ge9+SlAszfkBI6H/0yLMM0/g2yu+r53KuHC6DxJnSPvTyhKwClE8/I56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894839; c=relaxed/simple;
	bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc5yCgudFs61ycYNigolc2Smfk214Zxa9VgjcfbFlSJnzlI0fRa/CdtHLPki7GvSdDdstmaKFmir0iCtM2w+9Sa+tyIIiGQfQQw7io1aitAzm9qAuzUyRK0Z8TJaoVBfYs4ZK4TOHBoLH3Tr1PoOFBgb/8xbFZN7XU+SyyrkOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbvxDzCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705894836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
	b=JbvxDzCAixqsIUD4jLQvuhjkvRLj3oliwYalR2G0q99vwoxYf1ibtS9ZOwhjm+L5ld4vhn
	5EdbbvcI6U384H3pqTe6pK0mvrvaC1jRMfTgh2ZG5ghsp6YVeYT7EuxNsXtiBTj/D9O4OO
	CfiefRh8TtWv1JmAaND/J7sIH7ekD9c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-9e-dkgmPNnm0PpOTywnxxA-1; Sun, 21 Jan 2024 22:40:33 -0500
X-MC-Unique: 9e-dkgmPNnm0PpOTywnxxA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-598e2d7e22bso2927782eaf.3
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 19:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705894832; x=1706499632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
        b=i5P7YDeytIN25Zzzm/Fw3wgfleuTvmJ+DDnJeF1aFXXImlCrHENAHzoeMeDjYDLW6U
         kZ6mQQ8ATOzDjA29ZvVvjrgD1+0jE2hSk6WE8t3IZQDnhcdW6pyqPQAKvzmhNpSqvBmT
         xTPWNMgxwOztx3e7kH0pp9Mbj2fhsLgw78/wl9QLe0Lix/vPSlvwGF4u0PApCEisssV4
         ogXdT51cbXmVT9YYa6X+pQ6C5E3eS302wtcsnuHScXRohQ5AZ9QjyzUhMKPLfsTIMYFb
         GDz99AYl0UbSHjgavtH2Eh4+sENwd/NlnhkncZ7W5eKjookiyf4Lb1YjuffU5DJnB8ia
         rn0Q==
X-Gm-Message-State: AOJu0YyiJkzdyRa/0tzsvTDcdC+of6IyByoyUbokBc9KOMwUpzGFC+2r
	mx2URR2LU0X3dAsUDqJ+hhJY/dTPIS2LnsngszUX5FAsqzxlT/dk5nP6DT0NvxIE0M4Z1s9egRn
	+b+neUoH6LQgLscgtZEMMFbnbROe+6LshaQXnFR0/6VJV4veYt3C4ShnQpNLkcEhHZcnGXiMuzw
	wbVyFpsv5tkNeUXARB2dk/gbVmHwbL
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id s23-20020a0563586f9700b001762c3dfb35mr1884390rwn.20.1705894832472;
        Sun, 21 Jan 2024 19:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZwgJAgYtgwjCdGBZzqy4GvY5dlcCZYqs27qJEKxnCUiDP59Wuh5b80C7v3TyVv1+hCDI8N2QN6k3z+Lu18GI=
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id
 s23-20020a0563586f9700b001762c3dfb35mr1884382rwn.20.1705894831978; Sun, 21
 Jan 2024 19:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:40:20 +0800
Message-ID: <CACGkMEuSGmH7ywQY9OeWE1FPdV6cgs15fqrddRtOsO8bW2nx+g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tun: fix missing dropped counter in tun_xdp_act
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:22=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.co=
m> wrote:
>
> The commit 8ae1aff0b331 ("tuntap: split out XDP logic") includes
> dropped counter for XDP_DROP, XDP_ABORTED, and invalid XDP actions.
> Unfortunately, that commit missed the dropped counter when error
> occurs during XDP_TX and XDP_REDIRECT actions. This patch fixes
> this issue.
>
> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


