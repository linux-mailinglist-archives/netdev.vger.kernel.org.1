Return-Path: <netdev+bounces-223969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6BB7D18A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61B67A535C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2128314E;
	Wed, 17 Sep 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REFQ9J/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402612248B0
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106830; cv=none; b=dGXnDDl7QnAzYADU7wGUYAd1KXd+DPdGgP8feOQOTPhFvBsMK78ZNkvoI3Fwk5UNSdycrQ58IMP1v3JRsp7vRaVovmRlMTwgWsqwyTPxK15l+shQs9yQGI03XUjm5EMuPSRqXDIlxEPz8Q/dGd68Q++/gxfXTfUjD/AlcRkAPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106830; c=relaxed/simple;
	bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMmyaofm4x+y7rF6LT9hruzp9A/Akf2Y7GwyW0D28YYeWQYK6FYejT0yeMzX6PV0QujxwsTP5uQHwhPcnpuvg5G1mSjgKGxFYgg5MQei6lIZn/wCbdw/9FTArWmVoQ0ZAXY00MSeN2ZeEcNdQvzkljg7K78gGYlFCJdGGh2WfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REFQ9J/t; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ea473582bcaso911215276.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758106828; x=1758711628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
        b=REFQ9J/ti1q0ctWu3QtcK7nHBvfNDnbSJ+rRT+BI9KKorSnWIlqEUZDSjs+5RDWa2Z
         cZYIHVUFJ+bwb8/unvb26fwaUd88qkypbmWBMXx0FgJGP1dd5eLXiMIRj1iv1Od4uhpg
         l5HtUUGHK8N4AE1t1oiWN3FZP3e4495ZSLO+sMDe+l6eSZ40NqQyUbUd9LQW1B+YghkD
         mrxJ6JaJApqHXgjgRu5uVXwPkXkaJwDWJgR+glyVmWw/1GNkglW8vMI66u5n3kieplQP
         dzywh88U3RCkmspLuFyXcJx/MW0dFVtUi8mcNffjrHdbBnNo0SbagevI57sc3w0y2lJR
         ZSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106828; x=1758711628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
        b=ZBRoRZW9mA0BmjkLtk47UBHMgKPyDqU6pZLgT4LOH28nj4L/6aDV9bCdz60ZH/u1a9
         LlNUECoBpOZ1F4hytnxy8AH1wULecED/++X8D/hbWGyQmd4cEG90nF+gEbH70Dl4eWMg
         ZOwBjrKb34lfIlTflYPfUL3eqF7jB6M3Z+WwzgoAZheVA2x4s9btA3a79/NxAUj87uk2
         rJ1cvkuKR9QEKwWNFi5jO+0PzOHboDBspustTkX5/E3RRJL3dbEPmc8xmQccvkZ4ud4x
         vqpEUxKbH0aL67D3NRWkbCJrq91tKo61JWnLf0u+WcbJx4sLRhw9nKWI3u/XzFOYDzyr
         IQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSa/5Zcjv2n1PGU0qc2zgzq15NGR9Rj/Sq/BOIceuk8KgWQgDzmcOHjkflifwYWyr09rE+x/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/J6lksCDulC7R4oTvgVqU7sX/A0HlMrbS+KTweO88iFuMCck
	A8gpL0aYeTN/qhhEjHr0w2oFmc+m77XLoN1eNq3+KkVhM6Qzs5iinKMnWx4C0tdO8RINYb9q0/h
	1d8HgjCRYI4elDFme701mlp9MBE8hXMo=
X-Gm-Gg: ASbGncsf55N9PJCp6PCW94CLGaUMSzpvmkDxwewoamn9nVEF4JYyygE+5TSP7/+QHa7
	OXn54ZbT1lUdXK4whwY6yh3X+c2qBQy8wfYh1qvdrAiePbCq8QOHn4eJ1fTzMKVllfw8UaCx3Qs
	H5eh7Uhgia25GnedoIWOxJGoqTSLLmeKZQY7HuskSp/r+3Xvy3D5u8sgF8Amw7m7Fy/Z/GBDD5g
	P3U+uWoh2/6RbwPKmpKT147+/ocQxw2dXdlumqCGBiy0fl2ANg=
X-Google-Smtp-Source: AGHT+IGfnuwSEGf3ha0nSdQ2bBtn723dyi/fioLa2ryAVJS390NdpOSQEFlC22tsMhWb9EgeYLp9ZMfDh/dzPGnq+7Q=
X-Received: by 2002:a05:690e:159c:20b0:62a:c4a6:bfea with SMTP id
 956f58d0204a3-633b126d5edmr1034403d50.17.1758106828070; Wed, 17 Sep 2025
 04:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095928.1532113-1-dqfext@gmail.com> <20250915181015.67588ec2@kernel.org>
 <CALW65jYgDYxXfWFmwYBjXfNtqWqZ7VDWPYsbzAH_EzcRtyn0DQ@mail.gmail.com> <20250916075721.273ea979@kernel.org>
In-Reply-To: <20250916075721.273ea979@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 17 Sep 2025 19:00:16 +0800
X-Gm-Features: AS18NWB_hpDqfpIABkrd-Pvpolw7w2H4ujFI3yYvFt7f0E3V1zdjLMakXthxI2E
Message-ID: <CALW65jZaDtchy1FFttNH9jMo--YSoZMsb8=HE72i=ZdnNP-akw@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: enable TX scatter-gather
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 16 Sep 2025 10:57:49 +0800 Qingfang Deng wrote:
> > Can I modify dev->features directly under the spin lock (without
> > .ndo_fix_features) ?
>
> Hm, I'm not aware of a reason not to. You definitely need to hold
> rtnl_lock, and call netdev_update_features() after.

Will the modification race against __netdev_update_features(), where
dev->features is assigned a new value?

