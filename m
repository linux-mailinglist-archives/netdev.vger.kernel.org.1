Return-Path: <netdev+bounces-190888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF82AB92D9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296F9A01854
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8503F286424;
	Thu, 15 May 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hUCF4aV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D81A2396
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352306; cv=none; b=VXVUNRIbwn/44WIEDsz49eUyT4tAam+y2QVD6gNxpgy970+0HiSU6bhaO7KE00fRYfMo+UzOpH/enHZ+BzyOUd9RbAFZzvWU55xb3rrLCvrON3IsPzCKEhkTUKli5xzqt7CckpZxMeqTVM6WF9OL10A+R6QpNV0wDULMn5pnDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352306; c=relaxed/simple;
	bh=sDoZnVVwmjfJ1zTso7SNNiQVWymvr6AfPd1tbt9Mveg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsuqKH2vvzLNB3d4vOw+teBd87kVS0QjjE8uNcchs7HHLGeWpOS3ZGEe8TxvzpNgGT3PA/9K9EnNSgJuiQ5T8ODrTDdCCVTQxhaA1OIpcCwSVvYF9NbuzZXFjsPiwq0BoFozY+wyJKBdiYptHUrYXcIejWJwxnpg4xpEQMTdxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hUCF4aV3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-327fa3cece6so14988481fa.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747352303; x=1747957103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDoZnVVwmjfJ1zTso7SNNiQVWymvr6AfPd1tbt9Mveg=;
        b=hUCF4aV3YRP1a6VsFTylnDxDqhgx1vhnj7nzQpMRBu+RS0iEouVLw+0Rc/HcKT33Je
         YM392jBuCIdnQoVBZR+eJlkHax14FKfue1Z+fv/iHB7IP2ef2RWN3dxwD0Z3NkzDh1fe
         NeHO+XDGIGe8A3rI0ZYb5KqHTtERW8DIPZMsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747352303; x=1747957103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDoZnVVwmjfJ1zTso7SNNiQVWymvr6AfPd1tbt9Mveg=;
        b=iVOrRWeEzsHLkbMfApxjRxbEsC0TCkH022tWufE8tWDBxdOx21CEY62fHsOys6Pj0t
         kDjUNet3jT+SYBRtHEXzmn/YrLFx0pWJz4HURtq5Lacec2xkg9A3Ya3fi5PHm4KFlxgs
         yEcYEbL9M0n/KD2R8tCMf4QfUAx7LhX1zS9UMhWVFYRwO7+6xT9AbHixIjA1eYsIoK9Q
         Rb3gsLGlGMc4y9yjS/tRs801DoNvgxnwNpgHNQ03VFW9c50s3c3TcAYeshoSDn6Mkx77
         7hHIcAjh8CcZvWz004576BS1GFDRgF+97Vn77Ghu9gUuhfu9qEgL72gw31VQVC3h8ldG
         8/qA==
X-Forwarded-Encrypted: i=1; AJvYcCWO/XIEYrbln9Nc6TM6FeByIXccFpiI7aBTVj7S08WTPfm33SuH5CuZ251tIXkiLgUyUhzHakk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrm9dVJKqg1DJ/y3UQGIeuf7z1yUC2r1z+iD6PiIuIbiIA0d2
	NBgjWbKnHRJCBoCIBN/5udyu/xq5Hwo3ImvuHNiNUd8DQt5JnQBo4iQZSta0IP/3oCOMb2Xzpto
	Ft/hjT4MVHCwIJkYN3ob13WFt+XZklu4UKMEoPz6+
X-Gm-Gg: ASbGncuzWsjL0s9n4bxQ59n+YL7/L9pvdFEH4oNqKOXKgnQG8B00Tc506kwwTH/8hut
	NSKiY1FYiPb8hEnS87F8qou2THOP01A8v5i25FuwWJ01FWrSwUmsvIWgMnk3JSTXeMgl81ZV0Hc
	itO2HoWeDJmq4KBkbcmH6zGl8pPTeSrnQOxA==
X-Google-Smtp-Source: AGHT+IFCE+3RTB1vC1GAd0I+DdlUsdvxlENWxVNeYEBBdvtM6MWTnZEm9qDAWQw/oIMA9y+u8pGsJeckbb6GUI1ABG0=
X-Received: by 2002:a05:651c:324b:b0:30b:acad:d5ce with SMTP id
 38308e7fff4ca-3280772ee74mr4859821fa.21.1747352302585; Thu, 15 May 2025
 16:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
 <20250515070250.7c277988@kernel.org> <CAP1Q3XQcPnjOYRb+G7hSDE6=GH=Yzat_oLM3PMREp-DWgfmT6w@mail.gmail.com>
 <20250515142551.1fee0440@kernel.org>
In-Reply-To: <20250515142551.1fee0440@kernel.org>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Thu, 15 May 2025 16:38:05 -0700
X-Gm-Features: AX0GCFvfz5jvedR3utgr23lCgKouQogx2vMwPIGGcBXJXkJAh4ITTsjdDpnmy1k
Message-ID: <CAP1Q3XT-2uD87bm-Ch7Oj49=0NBba6vdcwp7dAf51FfmwJhUew@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Guolin Yang <guolin.yang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Not sure if the stack itself cares, but drivers look at those
> fields for TSO. I see a call to skb_inner_transport_offset()
> in vmxnet3_parse_hdr(). One thing to try would be to configure
> the machine for forwarding so that the packet comes via LRO
> and leaves via TSO.

I see. Yes, drivers do check for it. Sure, let me update the patch to not s=
et
encapsulation.

Thanks,
Ronak

