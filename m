Return-Path: <netdev+bounces-214871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700EB2B972
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B330B1BA5730
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC2267B01;
	Tue, 19 Aug 2025 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xbk92i5A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6A2673AF
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585055; cv=none; b=CHlG+wE02KPHGhMAcSBHh12Ny+P4vnfVN81iwqNPmynxdcHEiKqUIf8fT/3XFZ9mGS3ZVVm+2zpEWtxQcyHoIJZu04xeOLB1pCD8c3zC5VssXJYTc8qVOajjcCz+gJ7S3iG+6ZEyaXs0HIgSQXsky/nlCZ1OKWPUvT5mFEAXf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585055; c=relaxed/simple;
	bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qn8RVY6i6iJchINOE4ZYarIiDooZVJtm8urxWbuv5kyu3kwU7xbanhYNxdPynbmRT34uerM0FgT55SbByQsuaeDf6XitgWzmbfRFLwmB21ULFF8wvXlXFaY3R2dbDkjXapsBz9oubs5RdslZ4wR8HSU7O27ns05tNZ5KOL1eGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xbk92i5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755585053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
	b=Xbk92i5ASqaCpl1SBGlt6WVhcnpJWwRRGd4fcW1mn5HRJ2Owhc9825gWhgQxIQay6588i2
	1YO3SeUIi97NkGJYvFZpPmA8HNXW9RYBM18Xbk4OaOeqMciqPSSVOnaeXSKs9JxFwejrWC
	KpSOIfFYCi0tnJ5n9BSmQtPQIXcAoY0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ssLusTOYOn-at78OzbKbOw-1; Tue, 19 Aug 2025 02:30:51 -0400
X-MC-Unique: ssLusTOYOn-at78OzbKbOw-1
X-Mimecast-MFC-AGG-ID: ssLusTOYOn-at78OzbKbOw_1755585051
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-61bd4dcbadeso253790eaf.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585051; x=1756189851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BGkXAg/cYyaOt9ZXSqAWIYIeP5RwAQroBA7qi3xxK8=;
        b=A6q3XHqvm1iRFXO58iBSx0lROCs5iL4QCd1nTmtUjQOnhThH1R7//zu1uUs45dHRPK
         br814kUKV2jh4GGO5ESKsknETe2AT5x++sCqp4eKamOTrelDW3dOEVX2hDq2KNxMd0mC
         TJ4usHEGKGUDPOX4/Ghd3o11iwIrSelgvG7CTyjMZxiAhlbB5ZSND3nBaXulYt8eyGk/
         O5oY4c1FDuXcxtf2w6uwQAyDISuo1EYbAuGS/fSlVF0VyDcqCkPoHBg62OjYdT7O6dRi
         WK7as27yPkuwsdLfyTXXm1Q0Lkn8TUXOr7DYyuBvJ2WBJs6voh2KvSfJQlMNxnBKMrFr
         eQrw==
X-Forwarded-Encrypted: i=1; AJvYcCV81RwYdiwodvKqv0QSN2ce4RVNx+2c3QpnABng5lxaOeP7pamULyd0ipO/nKVWMTgFxP4bMHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IL75FFogu+UbpNopncA+3z4zwW/uh9BPU4BIMtVELiV/QXty
	aWIO6QCyIAx40UDYhysl7GQkeXDk9wJG0iXjPAftgRalj95SwbgDGjsQh+9nKeActHZarpJZy/P
	qGvehw5yZmE12NQCfF9t+0z9lm2+mJFlDpqer8U5dWg+F05LAd9DAyocWk1hMDg/55/3GjeH8wf
	eNX/yUuOrUU43I5r99hOyvC9f7icCREF0S
X-Gm-Gg: ASbGncu/SfRMJEwldOFOK6iTPnOUuj7SY/+NViX+BsZho16L8P7YeOPM5rr3GdAty2g
	RSchor3/f1Ieqi5vEyzFsINotuqrABLr9J2VuTHvzgAGLXuxoy7/zwiQk2CibiBPv9spiyfcKP2
	uM2vvJ/Gsmk9M7jg/OhaGI
X-Received: by 2002:a05:6820:1e8b:b0:619:b57d:6673 with SMTP id 006d021491bc7-61d919e9f83mr444124eaf.2.1755585050888;
        Mon, 18 Aug 2025 23:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2NruEB0PpTboIZlO1R+deeNOAfR6szAOH8EjGkxNqMd5bxJ1wqDFHy3nGmYHV3yaIaLn+9Z6/t+ostF1mqZI=
X-Received: by 2002:a05:6820:1e8b:b0:619:b57d:6673 with SMTP id
 006d021491bc7-61d919e9f83mr444109eaf.2.1755585050578; Mon, 18 Aug 2025
 23:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818153903.189079-1-mschmidt@redhat.com> <aKNU1YnfNbXYhUyj@opensource>
In-Reply-To: <aKNU1YnfNbXYhUyj@opensource>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 19 Aug 2025 08:30:38 +0200
X-Gm-Features: Ac12FXzQ5_CEpGP7NZNYa6OiUyYr-nwrNxzE9x55g1guU5BoPDYablJy0CT5lZc
Message-ID: <CADEbmW1ayx8dKUmE=ueYTVwBme=m1E9WGOmpcv1MCquZ1yBgHQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix
 error path
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:05=E2=80=AFAM Subbaraya Sundeep <sbhatta@marvell.=
com> wrote:
> Hi Michal,
> On 2025-08-18 at 15:39:03, Michal Schmidt (mschmidt@redhat.com) wrote:
> > Use the same dev_id for free_irq() as for request_irq().
> >
> > I tested this with inserting code to fail intentionally.
> >
> Nice. Looks like changing this in i40e_vsi_request_irq_msix was missed
> during 493fb30011b3. Just a question isn't this not throwing any
> compilation warning all these days?

No warnings, because the type of the dev_id parameter is a void pointer.
Michal


