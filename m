Return-Path: <netdev+bounces-104359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA190C3ED
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BE32813FA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19076A8CF;
	Tue, 18 Jun 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR3GCyJe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75B4D8DC;
	Tue, 18 Jun 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693272; cv=none; b=TCAhn/o4GEWAMada/5cjxp244Z1VbVVz6VTyaftcucCoTNvhLRycgXSV5JQ63rSJEKGOgZpl1oZrpnYpCpsPJ+jb8dxBJGV5dGQ7KLx44sgbEm/tbbiqmrYkEBCWS6ADg/xUtsHRU0EzlZLDnXtdWadWbCdnPzQu3B7qXKqgLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693272; c=relaxed/simple;
	bh=PM+mWy06h9/Uw7jEvdyJMsz+j9sC9p1M6A4RbMMCuGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJIOC4qJ1OCtZMy9wM3scSY+ff1gLxOSeZEzV+giSIrf4/RZz0MDYDT3G58HniaOkS0WK1HnxsZDDaxGd32y59YYN+j0agfg7q1a6Je/l8i10aSZYaIMycT9yTqsOkH95+ZQw6apAKDvjlxTJd4x0Gtc0oTuKbofMSMggjGrysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR3GCyJe; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627efad69b4so48867297b3.3;
        Mon, 17 Jun 2024 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718693270; x=1719298070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM+mWy06h9/Uw7jEvdyJMsz+j9sC9p1M6A4RbMMCuGY=;
        b=FR3GCyJe5Yn4eIWOpRr1t/O8d9oOgje2jW14YRm1vFHgjVJqNqTEgcVMVCYBdOsup9
         CzAy65pLdz9UYb8fpELHW5eZawojKjweHXSbZ4EEPBKQh0Bkaf+QV4SJ6MVnpyfvj89G
         iCSzBlndVGtpynBcPJGgrwQfCSC1uG9HiScGYBSZrym8Oa9CRQhJvtYSeISNYdYi/aiw
         NnDmlndDQ3m7mvbZgeMAVd4E4Gy7KA4HkBogBzK6uGrgkw1+2+boafhhE+z1aaq9UxG4
         /OZk+qJcpIp26S3Iuh2s1kujbP7pOJcak77ZdbpXDzhXGMTfeg2sF9huFDiT7LFhtpoI
         WIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693270; x=1719298070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM+mWy06h9/Uw7jEvdyJMsz+j9sC9p1M6A4RbMMCuGY=;
        b=PcRVkrHDG4gTR1o1tG5Tsj6p7HFgeCZAXM733byWKQXp4PGibtRA/uGxXvLulA8wB+
         wDyp+xPhN1hdhl0G0RZhyB4YXcqTV24tJgVAtO5dSkIAVXinUVtR85hiQLmcj25b6ml6
         4X5StGraCviLL7Qso89qHmG+5M2mdifeqgMAHjw4hzOoCzMoMK9h/V/N5OxBNHNlb62R
         qLfIF+Bh/Uf8w/sCfdAlbzkQ65RfxMKc/zhHUi0wYED3eeiJGgqDPiZRASdMHvcEvZEZ
         dUGRGqonTYHRfCBpEPI1MefGM7F0crcmlRg11vsgGiyoivfH6SuRPHP795JWvbpkzedm
         OoFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtysknfIlHUJ1V6IqXe6j83tvS31MZLjTYd9oG2KMssuYi/7YAmKocI+qOx2DlXz541ygmYy0yD5laMlRsAJrpfM1spsyukGIA9spAwS/Xbo04pNfwL2g3ooAEr2htsVlPkc9V
X-Gm-Message-State: AOJu0YwKQqyd7mEstl2cTG5HBRsXpom2bd16eIR7Z6SXMArJhojmBFDn
	kbPtjJCPe6fDpJLifihaaDCfxdPoLEZ/yOZKUWFXuxw6FOigTDhlzt4ssdxrAsyJ3h/Al9KTXhB
	PT99VE9QgIkDoEJy1W9/imDoKDtJvyhUZJuU=
X-Google-Smtp-Source: AGHT+IGL30rIET/M5LzgDltzRx6XXB6YgqW9oZuMa6bA/c6W37Gi2k9nXkoUak9FdwwM4W4azUvhMGBjs2MXgz8++ks=
X-Received: by 2002:a81:7cd5:0:b0:632:b827:a1ba with SMTP id
 00721157ae682-6333082fb6bmr91760287b3.7.1718693270316; Mon, 17 Jun 2024
 23:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613073441.781919-1-dqfext@gmail.com> <20240613170522.0961c781@kernel.org>
In-Reply-To: <20240613170522.0961c781@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 18 Jun 2024 14:47:31 +0800
Message-ID: <CALW65jay2+n_FhREhikVWoUEMQ2mytbrmQ9UzhjtCEv1gmtvQA@mail.gmail.com>
Subject: Re: [PATCH net-next] etherdevice: Optimize is_broadcast_ether_addr
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joe Perches <joe@perches.com>, Qingfang Deng <qingfang.deng@siflower.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Jun 14, 2024 at 8:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Can you provide more context on why it's beneficial. I mean, there's a
> lot of code in the kernel one could micro-optimize...
>
> Show us the assembly, cycle counts, where it's used on fast paths...

is_broadcast_ether_addr is used in bridge forwarding fast paths
(br_dev_xmit, br_multicast_flood, br_handle_frame_finish), and often
in combination with is_multicast_ether_addr.
Since commit d54385ce68cd ("etherdev: Process is_multicast_ether_addr
at same size as other operations"), is_multicast_ether_addr already
does a 32-bit load. We can avoid duplicate loads by applying the same
approach to is_broadcast_ether_addr and save a few instructions.
Tested with x86_64, aarch64 and RISC-V compilers.

> --
> pw-bot: cr

