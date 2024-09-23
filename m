Return-Path: <netdev+bounces-129347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F339997EF7A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0797B21943
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCC19F111;
	Mon, 23 Sep 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENJOEqtD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1E13D625
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109980; cv=none; b=nQLvYLOEx61nXe29Or4eAk04bun97bfueCAvmy5v7YzPPEsyaQ0xBwIZg8a77OSxS/quqQPiiZHGHEBPre1jmKPR2ezCgrSOJCV++kKG7r8NCfCJYa3IjuhFKE5X7SxdZ17WIiZohF3UPsR+ZQ67ZJmk74rhe5WMmLmdjxa/gZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109980; c=relaxed/simple;
	bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7L9zxCg16Kz0J0Fy6fMu1Mze5lmKe8chwB8QYOhztWta4gaHY9zPteP08Y9fG58pZ/V1e4YdJ5OuHHvQnTUFgbh1h9cWERJeNbnqTN/8F2TMsjgXw4cJ4lA5fo+Uh//OxWm2v8p40V3img67cZfl7L0M4/n+H8j8ZK8WoMZLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENJOEqtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727109978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
	b=ENJOEqtDPCGf2YgNTdeP3qQqPiojAcTC6rZ/xMFtvmqabW5TzTfWGnKGaVn9D/0WOF1mGC
	DneOcrZjpZpx9UC9JhX8N+/VoqY5lO3NkbrdQatShHIFIEd4JswRBxiDvj3P0ynYEqvXiC
	SiI2PXzg2O84e7pE28kTBanL7HmPdEg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-4DpetEDLM4WSvsdEazUc4w-1; Mon, 23 Sep 2024 12:46:15 -0400
X-MC-Unique: 4DpetEDLM4WSvsdEazUc4w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f74d4423d2so39084571fa.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109974; x=1727714774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
        b=XoXAGUN2sNTBkiZ8rjWTkwQEhSftBkw590Do5qtWEp44GX9KkZWLRI1hug5IWoPOfq
         q1R3hRFd/7CAj1N86P6Zh6aNnEg7oK9T4YKXGjK0cvz0OwY1yT3vxjOzMzGTLwi7D7t+
         z5gxptXgs9YQOYDQgCTH4WGnu/aitysLsxym5rsHfrYrOmb9x4RYn+sJ1m9sNQJcdPNl
         EWj8K5SoKh7dZVINtLPYddIcNqgS/3VIIVLBMo3wtt9wcF0+VlJ4qLojDf9rE0Ds+Za+
         1hrLhoSJtIZKx/lfLnI7VbIVktqBCNgY5TLjh1VL0Aurd3Ht/Q/DRyKFtDH6F14Jhdux
         wH4w==
X-Forwarded-Encrypted: i=1; AJvYcCVRHXxGN7nQEJpufzz0kypJOP9nfQRX9Ebrc7uCjlMOIAfJbQ44d0xh4thXVrOBpGNGcjBo5NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpZNJn+wMe/huUN++j96867sbnbBXwqupGLupCS6kNLxBQuKv
	ApRX9iI5ciud+8a/FFU+WWhaWijV9fc+zh8Ngwmkvmh9Aqa0fZM3tMTWyarLUkIMhMotGqZKYTv
	8SAhPx7oNw67WR/6hq1edpvBHTAtRSWawYAYONN9VfAGtWVDDcWyPwh1wKLyROwKs4hOhFjnJp8
	ME53NWA5XYMK/SGzG//uwlVPW6MjNg
X-Received: by 2002:a2e:824e:0:b0:2f6:6029:c63e with SMTP id 38308e7fff4ca-2f7cc375a2dmr47198691fa.23.1727109974363;
        Mon, 23 Sep 2024 09:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6qm7m3hWwtODGuDM1oa5WQCLNv0Y3IKoTB111Cx49PEhbpDmWp9BFnvuAJKnx3CHurDhFPWigvS/XiFS0BxM=
X-Received: by 2002:a2e:824e:0:b0:2f6:6029:c63e with SMTP id
 38308e7fff4ca-2f7cc375a2dmr47198471fa.23.1727109973965; Mon, 23 Sep 2024
 09:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920185918.616302-1-wander@redhat.com> <20240920185918.616302-3-wander@redhat.com>
 <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de> <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
In-Reply-To: <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 23 Sep 2024 13:46:03 -0300
Message-ID: <CAAq0SUkeVkiit383065nhfCibn-CG701uvaM6UHpWu9RaZE83g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:04=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 9/21/24 14:52, Paul Menzel wrote:
> > Dear Wander,
> >
> >
> > Thank you for your patch.
> >
> > Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
> >> tx_queue_lock and stats_lock are declared and initialized, but never
> >> used. Remove them.
> >>
> >> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >
> > It=E2=80=99d be great if you added a Fixes: tag.
>
> Alternatively you could split this series into two, and send this patch
> to iwl-next tree, without the fixes tag. For me this patch is just
> a cleanup, not a fix.
>
> >
>

Should I send a new version of the patches separately?

> [...]
>
> >
> > With that addressed:
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> >
> > Kind regards,
> >
> > Paul
>


