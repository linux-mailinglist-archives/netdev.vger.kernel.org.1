Return-Path: <netdev+bounces-164113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F72A2CA3D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F46188BFFE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAF19993B;
	Fri,  7 Feb 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUduQRFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC55193429;
	Fri,  7 Feb 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949711; cv=none; b=U1sPfmjhNrbFh3iJOLwo77gaIWuG7z7/6+mFGnyADOLPjah8BBhOaOgIP3Rs+oQl+ceIRlqyzinzDFnj9hN8yTCAiolQxFBrFbxt6QI63qd9wSgwdCAkAMf0Kj31/jn2G4f/uJ87J8WoN886eRRpqzMvq9iBTFhfN8Qft7o43Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949711; c=relaxed/simple;
	bh=M42hvVtmSFE2OaWKBP+bq+dNVUHH0MTpDkyCkpJ4Rtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivhvgCNyBO83PWIrrbad2SwfCdGyhpNETQCnoUJ3DOLH39FlZ2WOttgpIAUmqZ4qprTzn8SEXeSKggcfS40hLPVw541XUV3ztZy0RXRi3Suewu2l7q5LsHZHlQEuQWaZIApr5FCbuOhJC4ns2sBFCUSea9MUcRe671hoQW1L2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUduQRFR; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308a559bdf7so8363581fa.1;
        Fri, 07 Feb 2025 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949708; x=1739554508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M42hvVtmSFE2OaWKBP+bq+dNVUHH0MTpDkyCkpJ4Rtc=;
        b=kUduQRFRM8B57YB14ilFAxSNgJuBDlj53Lt9MWPBUYTKPtkhJmWk5RMdEnTnd3dpRD
         38lYwDMu7Bji89+nJ3thVJMqeqYVqH3l8BPbKZRtDEAKAKXb/xK4uOvj53V4bXD9wwfp
         i/SN1VjOF+q3NJ0fDV/AUjw/fNxifsG9VnjufgL9PuYWEpHLlZN/RCrDxG5mC5KrtAHz
         ffJd8QE3r924/yr9hrKevqQ1ZVNXtoG3nAytLtSOFyF/PAwraAu3CWJLVwUGpIBTYTDt
         bfQCh4BPe55nSgy3qL3jwJpXqruDi55JlyyephlllrZpxf5fbdONARWwRiiaKYXUzqyy
         Sr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949708; x=1739554508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M42hvVtmSFE2OaWKBP+bq+dNVUHH0MTpDkyCkpJ4Rtc=;
        b=J9hRLW5zsAno/ZXZOPWLGkevUxbmW/A4ka7LmQwxQwlTqH6NRHGsKuU+tQbv4tfLkR
         mCYR7od/5NO2o7gFLbZ5IaLscazANtaHUcCPsBv/wqKOEpQ4L4I9B6Gt5KJirHdwgkVY
         mtFqnGpRR9iiFpW0gj9G4W1UCWzasTVxQZVgPA+yGCJ8m09+7QrzKCrbY8qyNu0tPgrv
         ml8XclgeP4r/Lz1F4rx0a6hPy8+T8iy3u9Fyn5BpK1Sm06SwuXc46QrU5Psu6FKTT5wb
         gkUmHRhvjSm2ejeYR13ZRRgQ9e/uKIt3VObNUltS5La91J67kFvmqHC7h356LvL1Tc1i
         pqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshou023gpUHJ4fuRcPD+YRCls0WLfdz2vMeAu+eq9CANufA/wWW399xvc+aJt1qqwV0MimgY4L2o74FQof8I=@vger.kernel.org, AJvYcCWM/HDVhcWWJm2Y3rHxsyEj6hBMnYFbJmU7G8jnmluq3vWwgWm0AmtYNMCUNE4lbtCnFay/NFn5@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVRNKCFcP9u0MJzmks6mrw3Vz8EWBVnXhauwFDcNr2aK6bcJT
	Im7t3NA9OyLFJRyG8RGkEXYhfPqMUqph12nbwIRHg8FHfOsbQ8jqCCsIguZHXQXWdQ+txZT1O4b
	1Cij2LAXxtj1foUDCW+Ofkqj2ImM=
X-Gm-Gg: ASbGncujib+rC9tarZ/W6cWZ5+OdblggqSpNWoAgbxALNdLOKE2F5+dLIRTfxHOS3ye
	+KZoU+S9PVBCPNigd3bct/oGwgeA+leqYPVzhD8ice0teaUSfRbCxds6NFl9/T2UXur31mep4sg
	==
X-Google-Smtp-Source: AGHT+IECzcF0hnX0qu/PB1nu2MdSqilOgR0bktrAhxPJnIUpljwdkIVuS3UvYRG9FAMvXev7X+NI0t7hNnUcGnQMaQQ=
X-Received: by 2002:a2e:7d1a:0:b0:306:1302:8c7a with SMTP id
 38308e7fff4ca-307e5a8de31mr10814781fa.36.1738949707896; Fri, 07 Feb 2025
 09:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
 <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi> <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
 <CABBYNZ+9D-jSyTsRvzRReHE4enfv6DP=Pr4uZCaLdY3-4D6AHg@mail.gmail.com> <0a132561e1681cd0a9b10934a1cc1f96d29dfb8a.camel@iki.fi>
In-Reply-To: <0a132561e1681cd0a9b10934a1cc1f96d29dfb8a.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Feb 2025 12:34:55 -0500
X-Gm-Features: AWEUYZmMXV2ligWMXfHgbYsVQgy4mDcEnT6FqA77EfdfqtKj0s9SZ2Tz6J3GSko
Message-ID: <CABBYNZ+Sa1y3mvX+GpCtOUDu_0jZ9MNS69xLSHY5ShkfBuNfzA@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Pauli Virtanen <pav@iki.fi>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Feb 6, 2025 at 12:13=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> AFAICS, for synchronization (only) guidance in the specification is
> (Version 6.0 | Vol 6, Part G Page 3709)
>
> """When an HCI ISO Data packet sent by the Host does not contain a
> Time_Stamp or the Time_Stamp value is not based on the Controller's
> clock, the Controller should determine the isochronous event to be used
> to transmit the SDU contained in that packet based on the time of
> arrival of that packet."""
>
> which I'm interpreting that Host should queue synchronized packets for
> different CIS to HCI at the same time. But since this seems
> implementation-defined, I don't really know what Intel firmware is
> expecting the Host to do, so maybe pull on completion works (at least
> until user app misses a wakeup).

Yeah, I think this lack the clarity on how the Controller determine
what packet got the what event, in theory the buffer count acts as the
queue, the queue is then used as jitter meaning there will be some
latency but I think that is sort of unavoidable with the way packets
are transmitted over HCI.

With this in mind I think one of the problems is that when we have
multiple connections we probably need to load balances the usage of
the controller buffers, each connection needs at least 2 buffers since
with just 1 it is possible to miss events due to the transport/bus not
being fast enough to notify number of packets complete event and then
the stack to react in time to send the next packet, so we need to have
at least 1 packet queued ahead of time.

Once we can notify the TX complete we can perhaps use it as a trigger
to send the next packet, instead of trying to do it time based like
bluetoothctl is doing nowadays, which imo is simpler and should result
in a better utilization of the controller buffers.

--=20
Luiz Augusto von Dentz

