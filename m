Return-Path: <netdev+bounces-106622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996AD917054
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD47F1C2363B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8E17A931;
	Tue, 25 Jun 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx6cvJsf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E22176ADA
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340385; cv=none; b=ccwDKzlliU1F36UV8vka3sxWhUUTFTi57rgSPPdBPwwK/SyTrYJHulJCG9eemUX3wmguqK5xeO1JlxpLtdCQ9PIeR0O/TI8JUmYj4eaD3bVP5fxKel932yp8FLR8REPC8h+70i2s1wo4wxXnxzlulnPCyv4b2VsuXoenrjH0I3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340385; c=relaxed/simple;
	bh=4Ad8N9uab9l+LoLS0UE9cq2Gdmy+iPrKIoMAbpPxp2k=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeSLgfFvCcaqRtWf1rGwIfKp7k2GWrjUVHHy1rVuWi1DDeOgrztgyAMRYku315KRDzs403IWA9e/4hiPlPk3zCKf+e4l5eupcQVPuT1KLXJCE3o1K+uKp6CjebU2wogMHVvOaKYwU9J40nJWvPHaUZBbZP3gpJGSmZEHRDC6CQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx6cvJsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719340382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8wFcnOIW6tFeAYT/3mDDMjyRUaYB/izXbbbY0HfQIQ=;
	b=Lx6cvJsfGUf0Ju2ua2gFbBvKm7SCNjKnbXMG6GSAPU03iPIohfxSXIKt2fCvP+bFE4z8qA
	kPrv0FI77rOjWKjpz78jzGcjplBrCcZgm9aKQE0xw4q9E+PcpsHTSW4G2aB7dSb/BtSPSD
	U4708wRqkcjK/6UP67lerSssHPaoJ7E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-VF3iMdtbNfq2BbERe-_9Uw-1; Tue, 25 Jun 2024 14:33:01 -0400
X-MC-Unique: VF3iMdtbNfq2BbERe-_9Uw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ae4c8c30baso76239666d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340380; x=1719945180;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8wFcnOIW6tFeAYT/3mDDMjyRUaYB/izXbbbY0HfQIQ=;
        b=Yi4GqQ+0FyYn1IfPk9f97E4DJJtNjeAxIt3SJ57cRQ3mDIDj6m5W54nG6u4SRIxc2i
         V4zk5lyl6uHqdfLKJBcsgMaBUD4ZQHPZmIIslNmmix4mjeUkAk39PriGiq30KXUXypE4
         K4CPV3tb6RN0HoFO3vS4U2jWnvkSER1bFPI197AuIGJY1rGXyL9ol/kzqqfWwJ35QjYS
         1Y3y6yIqqNR6O63kXL6Pf8WZ9XEYOPXDx0Zpz3mvERVHpCPQJP5Q3Q4EX6g2ShteRcZo
         aEhnKjezUrFCcuVCTYbWJmB5v5HP75U+YjN0raBYd1uRS6FwbCtBzHBqAzgXRevw4jW/
         z0GA==
X-Gm-Message-State: AOJu0YwHXugT9V5aJOgr/j9xV6/0ARiwYgHMBUGG+Usr/deqfqQqXuN9
	94Xufa5v7qnrvbH1RDtVLc0D/N0vVJOEGlSL+Hkcuh/+XMXGJ5sTt5/KpJU8i9u5ZLgJ8+aU07S
	vmXVJ0NWlIESkTAMKOZZd9tRdV2WCVUXsh48NZmqKVodT5XLyKjN8T7rF9x2pKx3Jf95/x06YcO
	+X7Z5WVCKqQKQ4vQzOSJAyz0fdt3Un
X-Received: by 2002:a05:6214:20e2:b0:6a0:c903:7226 with SMTP id 6a1803df08f44-6b5409dfce5mr115022006d6.34.1719340380532;
        Tue, 25 Jun 2024 11:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwfGaPXUa87XOWHSBHXlzwjzqYtLVv1PpXuLiyIDn5haTRgZBxULpCbMbu+rq4ZxJhhnKRXE59lKpgxzZJPdI=
X-Received: by 2002:a05:6214:20e2:b0:6a0:c903:7226 with SMTP id
 6a1803df08f44-6b5409dfce5mr115021766d6.34.1719340380237; Tue, 25 Jun 2024
 11:33:00 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 18:32:59 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com> <20240621101113.2185308-5-amorenoz@redhat.com>
 <7f6aa18e38ff3c161805b19780c6265d05b4a235.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f6aa18e38ff3c161805b19780c6265d05b4a235.camel@redhat.com>
Date: Tue, 25 Jun 2024 18:32:59 +0000
Message-ID: <CAG=2xmPoZkWTzFk9G9OU1gntc67qNhoabUYEaoffvRkPVi8smQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/10] net: psample: allow using rate as probability
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Yotam Gigi <yotam.gi@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 25, 2024 at 01:17:19PM GMT, Paolo Abeni wrote:
> On Fri, 2024-06-21 at 12:10 +0200, Adrian Moreno wrote:
> > diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/tc_act/tc_sample.h
> > index fee1bcc20793..7ee0735e7b38 100644
> > --- a/include/uapi/linux/tc_act/tc_sample.h
> > +++ b/include/uapi/linux/tc_act/tc_sample.h
> > @@ -18,6 +18,7 @@ enum {
> >  	TCA_SAMPLE_TRUNC_SIZE,
> >  	TCA_SAMPLE_PSAMPLE_GROUP,
> >  	TCA_SAMPLE_PAD,
> > +	TCA_SAMPLE_PROBABILITY,
> >  	__TCA_SAMPLE_MAX
> >  };
> >  #define TCA_SAMPLE_MAX (__TCA_SAMPLE_MAX - 1)
>
> I believe Ilya's comment on v3 is correct, this chunk looks unrelated
> and unneeded. I guess you can drop it? Or am I missing something?
>

Thanks both for spotting it. I'll send v5 without it.

> Thanks,
>
> Paolo
>


