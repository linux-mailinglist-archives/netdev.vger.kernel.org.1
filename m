Return-Path: <netdev+bounces-127940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC197726E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38718B22489
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918381BE860;
	Thu, 12 Sep 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYaTIce1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25982188001;
	Thu, 12 Sep 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170355; cv=none; b=lC6EKDKzx4QPviQIJpVm0Vih/hcVXMiumyQXHBs6JKdVIoBoe5yG7Zx/KEU5ZvRBBvztH2F/vzHZw7Wp+j+MAOBhuZTw+GIjcUsWpWudX0gG34QUu2Hm4G6B68p6U8vKkgOVn60Hiz8eKuul+8neO3SWEWMstpMjHQ/hQDN+0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170355; c=relaxed/simple;
	bh=/R0pXirOzwJZmGKJOLgCddS1t8nplUTSfuiwa5CVbS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aerut20Tt+Z7tct+5TCUBIenr9aAttBUmw8X/3f/zSqKlTJRcPDVMmNE50865mGKFa5txEQ31KK+LJIALxeuXSMC3uFmIUXWuL5lb3MCgASH+D8s8Go2+74pvDcP7lMYiOJgveVmgUR0jIBhgAYvgH3QFAHO1UFowMjqT1eK0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYaTIce1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718f28f77f4so1261296b3a.1;
        Thu, 12 Sep 2024 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726170353; x=1726775153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uSdO8RSbMs44j1H6G+dzfYRIDRqi5dt9sRxSxgubzu4=;
        b=nYaTIce1fSYZ34/NkzM98KCt1GWFS+UN4sGozuCdOPBk8g+tHEwg33vUxCyuTcS3N1
         0ceUYqCjKkXK1yS9PRRxcUzYdrqOhhkAFPCthD324JS+w2h0OAudbS9ss0O6iXWSx4UY
         PhZaTYYltj2zsCVpKjtFWOerkEi6RqlEz0ouwXokHzzSV5yMoIAmTg829Ese1si3WDQT
         5IB8DnQv5oe2RV7MDApzwL8N16I858THBFE4SL9lWT842/5+K5RcwiqsoP2fK9K9u86h
         OGmrEO4LOfMAMfKqaM1FxuyjRRlLtjqC1HXQ0b89DCw+5Nterr/acQ8vdmbttOTQbzTN
         rO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726170353; x=1726775153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSdO8RSbMs44j1H6G+dzfYRIDRqi5dt9sRxSxgubzu4=;
        b=PEdvsSnBCNiPSfn/7hXOQIgUxppG3I/+mgfOFfRXAYs3vB4nq8f0I9PTqGOihgWryE
         WiXQaTj1YjCwAfZFzcrtEen32jRHoqdBzpwl01H77mjFyn+SnLYrpJRHCr8PGl+aNKOD
         HmM+/ZU6AAdOnRaYbRfRTY7fFRNNMjeivL0VxKfUlzVCwSAxAYJp38bwzJ3xkm9VkY0B
         bdAs9ZTKv6eha8+LgIsO++ptHpa0RKZLDk6awKVEm0Na99i0lIurhD98TmNwzIX9Rj8l
         3P+DRsLBwhI1KGcD+8vIC3/C/uDB8bQK1hNiDVHxp910EfN0pqSF9ozIYqyFv541CFC6
         Gxvg==
X-Forwarded-Encrypted: i=1; AJvYcCVr/3n/MlxFJRm+69rBC/j4I7hN9RoKZQXgTy1h99JIoFKT6k68TEgiE1FzM9tJ4kaywI8WK/buvPGseeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhseqQnDRVPZCioQjoLo/c3nP9RalLe57mmgIP0Z0hR/FrIU6k
	ReTUqYt+2wbj0NEqtLDKxwDaRHh1si0DIyArqSIytPRgmtx7PGJZoSYD51/I9Aw6z44Raefk1RJ
	X2ZaYUw6bt6tTj02YLDp4uvRCI9E=
X-Google-Smtp-Source: AGHT+IHKH6rubc5bszysFyN/+dOoARVsJ2z8te8iybKycrCFJobGOy5Etl6v/DFKqtfrQv2HGaoZAXDrVKFJhQH6/js=
X-Received: by 2002:a05:6a00:2e11:b0:710:bd4b:8b96 with SMTP id
 d2e1a72fcca58-719262077e3mr6264905b3a.28.1726170353359; Thu, 12 Sep 2024
 12:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
 <CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com> <20240912083746.34a7cd3b@kernel.org>
In-Reply-To: <20240912083746.34a7cd3b@kernel.org>
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Thu, 12 Sep 2024 21:45:17 +0200
Message-ID: <CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
Subject: Re: igc: Network failure, reboot required: igc: Failed to read reg 0xc030!
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Would you be able to decode the stack trace? It may be helpful
> to figure out which line of code this is:
>
>  igc_update_stats+0x8a/0x6d0 [igc
> 22e0a697bfd5a86bd5c20d279bfffd
> 131de6bb32]

Of course. Just tell me what to do.

- Jesper

On Thu, 12 Sept 2024 at 17:37, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 12 Sep 2024 15:03:14 +0200 Jesper Juhl wrote:
> > It just happened again.
> > Same error message, but different stacktrace:
>
> Hm, I wonder if it's power management related or the device just goes
> sideways for other reasons. The crashes are in accessing statistics
> and the relevant function doesn't resume the device. But then again,
> it could just be that stats reading is the most common control path
> operation.
>
> Hopefully the Intel team can help.
>
> Would you be able to decode the stack trace? It may be helpful
> to figure out which line of code this is:
>
>   igc_update_stats+0x8a/0x6d0 [igc
> 22e0a697bfd5a86bd5c20d279bfffd131de6bb32]

