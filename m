Return-Path: <netdev+bounces-77435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D70871C43
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2CA285875
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA05F85E;
	Tue,  5 Mar 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPO5bVNh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C45FB88
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635454; cv=none; b=q/xR39CqGJ35Kq8elyKU9cmNJ0/QkC0XF6o46UUEU63H5TL887ezoVRjWE1ZcmmGFP2UEv2lIkDLVBBxPy/MUp2vcUEbfC9fZdT46H8OrgU8LKcevCshuDijvzDCsML2csiDCIc0KU/Es1F03GJ3alfjerCqDHzsB8kU4rUzIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635454; c=relaxed/simple;
	bh=VzJ1/0kBt1TfgOFz76rdhUEpO+Gc8N+NL/tKsznH7Jw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQ69ocuKyX94XmEdmnZF6Z3YdT9+uS2D0ZY5O48Y5x1cA76QdYnUZGXuW/+n/imE18mfD0BSGVYDt7+DF/wNscprkEbrwv2CmARb+fBRCtAdkKs4mclyjS+CxBTc9J/tgeF4AbOuqIlrrpXydFPY8zFGmSfjEgdcpNSz0rQU0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPO5bVNh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VzJ1/0kBt1TfgOFz76rdhUEpO+Gc8N+NL/tKsznH7Jw=;
	b=GPO5bVNhVW8yn1U+UMgpF/7scs98/upo9fEIn4EumpEJH/8iTUYx6+WoPTlb2wJE7CPaO3
	IPBgM5boi16vDedaKvEgJaiZaqSj4Eqila17jYngdPc3QGIZrPdK6qNWB0JHy6vfqa7FNJ
	Z/ZHlcEW5CgF7miVn8ihX7dQIsLEqBU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-wayUTAcIPkuhhz0nyetZOw-1; Tue, 05 Mar 2024 05:44:10 -0500
X-MC-Unique: wayUTAcIPkuhhz0nyetZOw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512dfa1ff28so1023324e87.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 02:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635449; x=1710240249;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzJ1/0kBt1TfgOFz76rdhUEpO+Gc8N+NL/tKsznH7Jw=;
        b=Xnj44xi1XjH40tcbe9/ROL9xPLmRGnlxpdTAG1/6Kjt6EbXiKfsJB/Se5LdZUA9F0Y
         2siGL9rBcsaDUaIuTIMgYb1TO3JwWr8JHborEPF8JaK9hWdGSe2t4OAllcMFqf0Ni/CM
         wF39vAueKkHKRVQH0an3jd/LTAz0AT3/OB0EpAVxJhqQThV10LP2gXkzXVxk/rBkRVV0
         TG5HanmF+QAJEceoaZ9cDRcfQz1lIRHNHEbfouO2QImzqfQLGjkRnhXvEJ3Us+u0721C
         OCAPp7RPT8K+pZb6+LF/YauLBCsWCXaAJnLF+Wj1TSoLzXJbe2ON9tuLRSw9llHRtePO
         j82w==
X-Gm-Message-State: AOJu0YyHgGMoZ3xj5J3bB4l/Ggg2du88VU8CdvBfR+TSEoftZgXv0OC1
	fc7qEz0mMpqdm0EkdScJweUsgNYhyolstwOhfnFBIgLPNy9JLs7XzIlrOWjlbB2n4DqksLCPNOS
	NsSj/F1yPEZ+Vs5NDShcGgfjDT5HCLxdn62GWzAyU2YGgeDPq3e13Uw==
X-Received: by 2002:a2e:8906:0:b0:2d2:af88:894a with SMTP id d6-20020a2e8906000000b002d2af88894amr6935557lji.1.1709635449282;
        Tue, 05 Mar 2024 02:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsnArzyvPBupUmbEAQrLyC53xjDYEaFU5OJD1ILPWWw2IvTqrhO6PoWLbeN9s7lyeAxaKSiQ==
X-Received: by 2002:a2e:8906:0:b0:2d2:af88:894a with SMTP id d6-20020a2e8906000000b002d2af88894amr6935544lji.1.1709635448889;
        Tue, 05 Mar 2024 02:44:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ae4b45b3sm20960292wmq.30.2024.03.05.02.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:44:08 -0800 (PST)
Message-ID: <ae886b7975751a2c148fa4addce26c456678c735.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Date: Tue, 05 Mar 2024 11:44:06 +0100
In-Reply-To: <20240305103530.FEVh-64E@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
	 <20240228121000.526645-3-bigeasy@linutronix.de>
	 <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
	 <20240305103530.FEVh-64E@linutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:35 +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-05 11:08:35 [+0100], Paolo Abeni wrote:
> >=20
> > Does not apply cleanly after commit 1200097fa8f0d, please rebase and
> > repost. Note that we are pretty close to the net-next PR, this is at
> > risk for this cycle.
>=20
> will do.
>=20
> > Side note: is not 110% clear to me why the admin should want to enable
> > the threaded backlog for the non RT case. I read that the main
> > difference would be some small perf regression, could you clarify?
>=20
> I am not aware of a perf regression.

I probably inferred too much from the udp lookback case.

> Jakub was worried about a possible regression with this and while asking
> nobody came up with an actual use case where this is used. So it is as
> he suggested, optional for everyone but forced-enabled for RT where it
> is required.
> I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
> the results look good. If anything it looked a bit better with this on
> the 50Gbe NICs but since those NICs have RSS=E2=80=A6
>=20
> I have this default off so that nobody complains and yet has to
> possibility to test and see if it leads to a problem. If not, we could
> enable it by default and after a few cycles and then remove the IPI code
> a few cycles later with absent complains.

I think this late in the cycle is better to keep backlog threads off by
default.

Thanks,

Paolo


