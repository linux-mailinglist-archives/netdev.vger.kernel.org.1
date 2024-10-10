Return-Path: <netdev+bounces-134042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C871997B4F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E65F2855B4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90E18E75A;
	Thu, 10 Oct 2024 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NO7cDbc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACF3D966
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531241; cv=none; b=M30hqDtNg/V9d+7qtF0zOwWtAmLCMEUuBUgYvj9B8YhTrNfvE8JCFlfqdHBWpFxaBOa05eNmqNqH6A83XZCeT1wCoCeD3mu81gxNcD+fok/elC/9weIM319doJR4ckHd0otJkrl/AqWCERUfz2/3u5ga5lmBX0K9ng3TSf6Ohh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531241; c=relaxed/simple;
	bh=3kJFtqQWUiZUmvN6Y4KD5O3ocIB0m2Pt2+zMvmx0alk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxzrYx5Y93JNo+UzRgQWokhCjLtcW/1Ip+ONKohxDLd1e25Z/1Z7ormBIB+IthYxaCmQPclnupke8/FLoHoeBw7II2dfJef1pFDbMraqqdBvg7ZYncjGflDYV8st0JChlCWEtHDZ8I7XKB7zGXO6uAQek6ytwfPxmDxBld/ixUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NO7cDbc9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso515749a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728531239; x=1729136039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWFxNU/FeUdT0GBiYhZc8T5bQh3XONMLHFG4+l6ZYEI=;
        b=NO7cDbc9BiglLs1htkDfU/yEQAubXi/II9DqvRwowMBKoLi332I3yOI92tvwyrITi3
         +XcSKV8xkjZzAj62W9PSEMUXF4Md/wo9VRu4ctdDWBKNwR1Svm1FxPictVua4qaezfsQ
         pXdl1TTNIFD9IiD0pD0YcbQA4PcVUy4e/g9UZelHyxWIYKK/cb/UyC3th6A6Jkj/mZVo
         EI+9TtId2Q1wfH5gjTK+k3FghcqZs84awyiArFoeuSCct4dxCFjMc78MHCVlQS+7Hkm+
         V5HTX9jQgBImD7u2Jo7I9DDnqoCIpHlwVzwJ6JfLySlwY4ZU0ighfdTVtAA5LHJUXJBq
         5zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531239; x=1729136039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWFxNU/FeUdT0GBiYhZc8T5bQh3XONMLHFG4+l6ZYEI=;
        b=arEq1pxvX6Mstt19I1ZLfZHex0GV9hV9nGk3I8gOs6PCOqjw3LgTlSr4YaaXPNCkIz
         JVfnYoa3bIivyesMP37YEpJCRAaIzL7f6qYqUOZ7wvJhddOI2OSWH5Mu5B4bTmnnsDuR
         wYqaZx+0jjdksHNlHSdS7nE3eQPsCLYTsTNLVPEVtl+dM0VUfLMIkbiEHS7aFWHj2Xxr
         yUBtsBs6fIbjoO38QFpQ2xx7ykp5s4tzalhrnOCW/IumHrPNAGETq7fHb6gfL6oM9N/O
         rEmNNGPZYWadMviYssm//Pse8hF5SlU8y50W8Qb2LkCQ7WoTudy8IPZUfOnph6+0FGpO
         KzMA==
X-Forwarded-Encrypted: i=1; AJvYcCXwdz913mt+GTmyJjlkUBO8PlzTiPN2KaKWI0zc/j3huY2O7MG3PneYXfcwEVfw3kgq6b9KPqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMv//MM6d1Hw6xCw5QikwFIeA5WkBgkO4iEq6A/5g70HryNIWJ
	3U7cecjiBTG0mFTfRya8p81Ds0e7tQRYLEW7P8pHYSuX89Ks0i+CRI9M5zsZysVklfUABRAm8Bo
	zJCrKti0WdaMOfF1/7CtKhnFp9Ios71NR5VCT
X-Google-Smtp-Source: AGHT+IEznbKEERh0SL2h+T1TArUQf+UnGOvISyDli0dFraUbEcCEYhU7GhtxOVg8uZv6jk7uU69dqi/O7iT6+nqzf8g=
X-Received: by 2002:a05:6402:2484:b0:5c4:1320:e5a3 with SMTP id
 4fb4d7f45d1cf-5c91d5b192dmr4402655a12.16.1728531238503; Wed, 09 Oct 2024
 20:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009150504.2871093-1-edumazet@google.com> <20241009195833.716cfc93@kernel.org>
In-Reply-To: <20241009195833.716cfc93@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 05:33:45 +0200
Message-ID: <CANn89iJ44yAG57HY-vuxqv+JaayDzGK6oKqrGvpWLZe8ru-awg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sysctl_tcp_l3mdev_accept to netns_ipv4_read_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Wei Wang <weiwan@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  9 Oct 2024 15:05:04 +0000 Eric Dumazet wrote:
> >  .../networking/net_cachelines/netns_ipv4_sysctl.rst          | 2 +-
>
> This will need a respin, I applied the formatting changes from Donald.

Thanks Jakub, I will respin.

