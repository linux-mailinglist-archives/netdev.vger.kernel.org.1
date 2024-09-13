Return-Path: <netdev+bounces-128019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3C9777A0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A18B2402C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A581B653C;
	Fri, 13 Sep 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH6tcAyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801E1B12EC
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199804; cv=none; b=aQr1a+i6HKfhG+iwmkIJ/qAJoau+JRVD1HxXpQUtw81nHz9D1QVv3gm38yLzFMBcE+Et7aVTbpLdPA3bCGwKamropNHuxy4sMeIra7MtTwxnWhcktqAVfh604rmK0cajXgi5oEXeKl+8YW/JA4fjDOEeC216gLbyb0sjgWwOC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199804; c=relaxed/simple;
	bh=A4lORGDJykMfJEoecQjXlm20PYTQ/4n6Cqy/ls27JLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kn6L3qQHPdhVo5FiTOB9sV+x/UcSW8cHCbFVXSzeO9cbmtP43aIh7jWhINiRJ2zUXzrXi3pE5ynoEo2dLOxba0CSbx9W9WcfwpjYgRftjUUoOXDhlib/hJFC23qVxWzmKNipoQLWbRiklQZGv3DsRgRjCMaDbu51rEtyxzONSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH6tcAyW; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39f54079599so5312335ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726199802; x=1726804602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lORGDJykMfJEoecQjXlm20PYTQ/4n6Cqy/ls27JLs=;
        b=OH6tcAyWY/palogoa4S+VFDSX8y569z0zNzPrSL5p39DbsTalzl053zjLT2iHXYAdS
         Hs0JmT/PSLobyeSDRidn3tMzTkSSrYjdLDVPS+W+bB1FpwTR/ohJoRk9q/lwW/9MpEzG
         E0mP0+FgFpLIjudOcJQnL5zm0uoxsIBkxmb8fcq3WrftBAYi2MsDNeJqJ7GjmLFpwXHS
         Ns3bqX2ap7RIib70Vw1/xbysYl9gV4/Km8VtEPF+lkzE2KalGD3daNajH81RlcZy+I7j
         t3m8NRqNKef1ZurhmVHfTCfYMv83T+eCIZ8BLpFIuhgAYuKjlHNhEJGnwv3VXPYke+Al
         9LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726199802; x=1726804602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4lORGDJykMfJEoecQjXlm20PYTQ/4n6Cqy/ls27JLs=;
        b=bDW+s1NU6HBOgqBWnYes5dpWfck0/8FSUx4asgwQ82T4w7sXUEX+whHehc9Ed2p6W6
         R8MuYtuurC92WKE3q/rX1xG3GN1htRuzvfYAlp0e8I5MMK0SVSIe3mMX3YcsFzFJj/Pj
         V2oBqKyfHGlfn1e3qZEICt4w/+HCYBFvdE7sYbfEwTWnkdnIKGIWmjYxv6vdEPgHFfhp
         YmXuPSTXZoh+v+ihFVnEHJeNhjnkErC+/pI9Uyw9ogt7zzrt95YZCcKmsSeWGpho5mXB
         dVYPh2NpmMZpLp8p4oFJXjWCERBysM/2NlDzN7YTn3j2MMq/nxlMwffRckIMNG35A/VO
         fWTA==
X-Forwarded-Encrypted: i=1; AJvYcCX/52zLgap8KdDhoS2G0FwOpNGbGgg9yUe0IJpGygiVKPFm0LwvI5x2IFXFPBSFPSAHf/m+6UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIduyjr6BcyzMyIcyZZOoXfmRBX+ZzCaqB9DYn0WxMR1wcA5Yd
	CGndJA5+hGDp2O+VK70Uowi8NJFT0zjLvvgZd5l2Uj79mBFhxhVYb0H4YtN1QRJK75T9Z1OfOti
	KuIdYLNLVXEGDy8O/vuaAumF32tI=
X-Google-Smtp-Source: AGHT+IHL6VFNY/bSes8t9b5Je8fpEdVBIcneZQhV1MEoScUAR5jgNRdVQD0Ht2ebSTQnOva2Pq71RG/Cm2oAPwBPm7A=
X-Received: by 2002:a05:6e02:1cab:b0:39b:35d8:dc37 with SMTP id
 e9e14a558f8ab-3a08464e389mr38054905ab.13.1726199802255; Thu, 12 Sep 2024
 20:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911091333.1870071-1-vadfed@meta.com> <20240911091333.1870071-3-vadfed@meta.com>
In-Reply-To: <20240911091333.1870071-3-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Sep 2024 11:56:06 +0800
Message-ID: <CAL+tcoA51aPZQM=d6haXPKoRHeR255MM5WWKEOuZsbr4UVB5jQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:13=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> The last type of sockets which supports SOF_TIMESTAMPING_OPT_ID is RAW
> sockets. To add new option this patch converts all callers (direct and
> indirect) of _sock_tx_timestamp to provide sockcm_cookie instead of
> tsflags. And while here fix __sock_tx_timestamp to receive tsflags as
> __u32 instead of __u16.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

