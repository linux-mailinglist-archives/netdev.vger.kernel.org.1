Return-Path: <netdev+bounces-194286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E8AC85C2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CE9E3C20
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244B92C18A;
	Fri, 30 May 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T8pa/qxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFFAD5E
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748566262; cv=none; b=NR5DBqjAKt6smrwZW3PkP+63Q8Q+8XTr3W+D1LrFDTz49OOIH30yHxHZvlUWuC/xDu54VW4Q7DU2izzG4oITvkTDyFFwD61uxucTy9eLun8nkX+ZPOfIE3Vp9oqS80pN/IjBupVJPgfABuUUJo7hkcJradl52RQoUkzbaKwBVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748566262; c=relaxed/simple;
	bh=j90FZmy4DEJrDVtS1gLkiRde5vGGcByNWPeqa/Z3bcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=err896yd3VIW2LEsV4en3VBKMBrigAlSOBaP+9Ayswi6bE3k280kgsKtuPoRCqK+dbgQpGW+rCnrnVNWfgG/lWhYtv3YSWODEfSo6emhSZfw32fZ40FMiVAG5dc7Gm2bvIgeU9romWPAiob0JD2kCoUiEWJbL2shNx5kObWhFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T8pa/qxT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so12462101fa.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 17:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748566258; x=1749171058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j90FZmy4DEJrDVtS1gLkiRde5vGGcByNWPeqa/Z3bcI=;
        b=T8pa/qxTV1FUDiglExhT0uccCsYa8Akq17rDEsZ1yVwPYsCO1HFPGnePoX08l1B1Cv
         PY0YDwKiIuktxs/1AXkp/8IXOhljxyJ4SZIb7UJMXdvDWYRvEDDiRfqyY8WfZY3CLRVw
         fXJFIyRgwFHT3PvSOFnGxrohHwCdBOtbv5CfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748566258; x=1749171058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j90FZmy4DEJrDVtS1gLkiRde5vGGcByNWPeqa/Z3bcI=;
        b=fx8bUQggSD487ZP08JBAW6zytC6LMZ/6WZGNPE/E0uOqRpP0ZQ8Rcagfte9fcWR4Gz
         i1wzD8zb54/LRP1NgnpyFLPu+UcK2iT/uigoFu3Ck+iy31NOBMnFgBm+bZP3iknYpJHD
         U1qZhTpWf+kgFel/hOSL24etNsfFaB8+MnF5oPeGzUUPRiib0TEC3lMijeQK5j30iA4s
         Ciq4S/+dBkGamT3Tzc4YMVVdOiQBXb6mVMPVit2v/0Bp5z6qgqlVwrvZa+/moLYoo4WI
         QXorRyLMYhxmodxZYnRdFoLqg6JaFGbj5TTitRNAMDX08C0NHd4iKchY4kYUFl2MefTL
         Hlwg==
X-Forwarded-Encrypted: i=1; AJvYcCUH/sWLBf3J3f2gYgV5SJ5cX5rGuGWGP2x64kjSsVXJVJ2HSQmxvWUgrKRZ4Q4OWJWKeBfpZ9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDb7B2jMsZ+Dy4X8tXzyfY/qK5Awzo8p+cUguA6C1nJc+DPYh
	1QyMWA0+MWrh4YOjY4CaDurjEvpF6hD7DhOlaW4Cv+79lGYShYqKTmayjzivAVV7FWfhilg1wBn
	zTOKVR+goDaaIZsSFN/9fdgmi/DNcLzNOol04BvZE
X-Gm-Gg: ASbGncv+E95+MOOWH8tXPSrWyIk2ueSqTbbAMnS86Q/V/QEPNAGThLpcBdZC3LyMmQU
	4UlGw+UkynVBOxEbSda174bL1MP64EELHi6a71LbrBAjFykVgo+8hDcN8PitP1s7UYBEfqe9kTD
	4SJ7dT+6KMt+Uqpl4k/7SAIzBECQt4VYHoqZ7BV25AD33w
X-Google-Smtp-Source: AGHT+IE2OMsxzwQzeTrwgN2Hez064UFdOpids0WCZHGQIRmxCVKPL8Xl/szjSGwe1gyhi+KhbeBt7vwdg9fn04v1Gmc=
X-Received: by 2002:a05:651c:1477:b0:32a:8614:4623 with SMTP id
 38308e7fff4ca-32a90691f96mr864261fa.16.1748566258461; Thu, 29 May 2025
 17:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
 <20250515070250.7c277988@kernel.org> <71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
 <CAP1Q3XTLbk0XgAJOUSGv03dXfPxcUR=VFt=mXiqP9rjc9yhVrw@mail.gmail.com>
 <CAP1Q3XQcYD3nGdojPWS7K4fczNYsNzv0S0O4P8DJvQtRM9Ef1g@mail.gmail.com> <20250529163354.1d85c025@kernel.org>
In-Reply-To: <20250529163354.1d85c025@kernel.org>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Thu, 29 May 2025 17:50:40 -0700
X-Gm-Features: AX0GCFsRGySz0X3WjPXoBvDLDY3cvim3BsfdsBIzJvAllSe41uk0HX-0g9guY-g
Message-ID: <CAP1Q3XR1j77BBJ3aNm_YKo7gPdR+hdKcDHGNz0CBTuKFccuK5A@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Guolin Yang <guolin.yang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> You put Paolo in the To: field, so I assumed your messages are directed
> to him. I'm not entirely sure what you're proposing, to apply this
> patch as is? Whether your driver supports segmentation or not - it
> should not send mangled skbs into the stack. Maybe send a v2 and
> explain next steps in the commit message, less guessing the better..

Sure, let me send a v2 patch to get this patch applied first and
explain next steps
to get the inner fields fixed in a future patch.


Thanks,
Ronak

