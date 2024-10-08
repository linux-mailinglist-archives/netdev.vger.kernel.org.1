Return-Path: <netdev+bounces-133353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4624995B9B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4DB2141D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E32178FF;
	Tue,  8 Oct 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gnshrd0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE71E0B8C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429902; cv=none; b=tHKNNtlVE3NsKjcMw4YukeuUwoI8DfZmwipjWvPZYzf3p6fD5omFiIjjN6zwAyADdUpalHCIant86X/w95+efdyipzVOnYgX0JhE7XiIinaWDGe5did5c2IHmaiOuoAt8zIe1oar4e+RRmR+eVJloX8coLXFMamDlYMS/fV3wsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429902; c=relaxed/simple;
	bh=4zRoGe2JJ8/4US/mlK2Mlni9sJqG3odIX+vMxUIOgzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmH6ok0lfzxomdwZE9uKNY6m52oZafhtync4M8FFoI+5Vs/MpmCKw9Mkwj31q1WgMDj9aCzPEfT/+zQOXmNzDooGGkV3VYXMB8QY7NudXcOn/R3O0IqgAQgkZsM2n48LQHyMdr2AD12G74II4MiywTv52sdVqDdav2oNFm16gHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gnshrd0h; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2facaa16826so53341791fa.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728429899; x=1729034699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zRoGe2JJ8/4US/mlK2Mlni9sJqG3odIX+vMxUIOgzI=;
        b=Gnshrd0hS3NnM/jz9j2KD9GfJTuIFEcJjNsO2VMIGAwMuv2Gf4DaonkZTlzCVtahp1
         /MV6oT9qcRBEM6l1P4rsHReW4IoB1ziwai6xfTZvPbFbL2JvOwRY0kLWkjevDl42Kk6N
         ZpSoYLQ6SWueE2m/WLF09Ame+QXr424041m6Sf3kAvERnrko4AIEBCDeyf/OW1NbRawa
         2G7c7SCG8FdFLYTCuyz8fU+0Kq38a2DdXiGVuZoxmE8HmNep3EfZm8VPL5/8BI8mFfy4
         50RYR8UuBWwdohEnbnMnhxQzXkfFQItQVPHrzVwSVdsocgnGRb+eDPIrYUqF5v1z34S4
         fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429899; x=1729034699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zRoGe2JJ8/4US/mlK2Mlni9sJqG3odIX+vMxUIOgzI=;
        b=BwmQYJopmZ0AGr3ywieFiH5yjrdorTXjCHtLN/fSRGC9lll3NC3OfFQq985nXveqF5
         oQxs8ojbqbkEW31sAzsJiTNNMyMdUltCUAn13zx8kO3JGmBsrBnTo02zcNxyafjlPTeA
         gHpUBFXWLluZBDJPVuvxFZvVzKNvYdApE8qStnNNgLbwgOITZCF8toReWzJFP+t+NSkJ
         m1yrWVkUKM0RKbgbQqlX9qp/Qf/JeJ6rFTfrsw/pL8D1kmvqJ45oEL9KWcpn4vlI8k7i
         NMUVwO2YE4XW13eVoKAxYQcUOwHskzherHKXEQWuD7HLSXUa6tLX4zSLS4T4ITOwrsTo
         mgsg==
X-Gm-Message-State: AOJu0Yz9XqYfxLeCN720CkhdBpysHhQ7VGx+mafn8xVbTteVnjN6MYkB
	wbMD388SCjzoTFBF4zEC69dc8NuRR4REerx9K/Xhu2L7s6v1OUXwUv5llkc+z2JU5+HnQ4RYGia
	EjKoFQjMbkTSe2JqO1oc++Wne6Q==
X-Google-Smtp-Source: AGHT+IGUvqXgeVQ2KenYResePQEVvO6NDzLv+c0inziuFnlOF0wwRjc/+uwFPRDkL1fMETLV7BclRo9BA6N88kkWSyk=
X-Received: by 2002:a05:651c:2126:b0:2ef:296d:1dd5 with SMTP id
 38308e7fff4ca-2fb18615fa2mr4485451fa.0.1728429898756; Tue, 08 Oct 2024
 16:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALk3=6u+PTcc2xhCx3YgWrx3_SzazpXTk1ndDmik+AOi==oq9Q@mail.gmail.com>
 <608e4396-69b2-4a04-9229-e6bff8de1fc3@redhat.com>
In-Reply-To: <608e4396-69b2-4a04-9229-e6bff8de1fc3@redhat.com>
From: Budimir Markovic <markovicbudimir@gmail.com>
Date: Wed, 9 Oct 2024 01:24:47 +0200
Message-ID: <CALk3=6v7kFoBv3wTwYasH7-G39tLjATEn1mqnJVVaBy0b3LYKw@mail.gmail.com>
Subject: Re: Use-after-free from netem/hfsc interaction
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> If I read correctly, that could happen only via netem peek, right?

Yes

> what about constraining the fix into the netem peek callback?

I'm not sure what a good way to do this is.

One solution is to try to detect when peek is being called from an enqueue
function. My patch attempted to do that, but I've realized it is possible t=
o
bypass it by calling qdisc_enqueue() from a netem parent during netem_deque=
ue()
(Eric also pointed out that qdisc_is_running() should not be called from a
qdisc).

Another option would be to move qdisc_enqueue() from netem_dequeue() to
netem_enqueue(), but then there needs to be an alternate way to keep track =
of
each packet's delay.

