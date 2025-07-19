Return-Path: <netdev+bounces-208357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F4B0B1D7
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2A4188FFEE
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31521D3C0;
	Sat, 19 Jul 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGpgoMkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B11FF7D7
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958071; cv=none; b=sbOGVtsvwlLnuRnW0Y9QqUoouixFsFM5H2BkwyNFI+kIbQykHNrNAy8xPaJuDucfPIv/0FNjeRWhzbhwNL333rHi7Nnm9DbdkMEhZvsSODWlgh+WfuwF8PKDkUDAQy05o90ljZjkQyGDCaXkBQMzJkfxt48DeBKS3BsCyaDdDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958071; c=relaxed/simple;
	bh=ZqBSMniEcaFXChwYMzdUsMBPNlZ1Idmp4wPb7MOhB8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfNmqpIRZrAs3pdmtGPrhKFRWNh53fpJj7zX6+xHeEjNZps6KYV4bpnsGiWrcFmDhUnp6eMnejQPzhX4aRX+lhNED456iaNww/TjnzZNe3DOPfbRpczsxqHU157Y4Wp4eq2sobRaE6QZrAQXVaYu9SAMdcc5j47cXU/gKLkYME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGpgoMkq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso3017177a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752958069; x=1753562869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=uGpgoMkqFHFJsYvCYRYmb0J2FoMqIJH041sPllra/8oV+9xiib3ATfrr8d4bNty/UQ
         Q6w6DFHJOZmNYzJeLdknv5V3CNFtr9JwJSXRVyyqNV+3FZcyS/reByFitG1Adh1+SeKa
         jwf1DsLWNYrzZs5uAY9156URhYqjrjDxE8Py3Cp4qzw25h++C9kNv4oeDFV6k7MDnVJ3
         2ZwoRCBsjVnLjpnJvoZPsAOFfzUX3gEXxUQIUkwSfvWZXws2quSPNp5z57YpddKmX7FJ
         txoUigYN8QayDA84/+8aAQ5i3xgCj/w0aoIP2jrVybPChCW1oS5QhBZke3U+DNtF1Oen
         RHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958069; x=1753562869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX28BVJ93qamSCefMG+iWdnBnQuAtUdA3vDpxETj3g0=;
        b=c3uxLuLNId9jwfQkV6vh2u1spZyMIuSn8+CwuXCuH8u/4OR7p/w4Aw4grZWu4Au4Dx
         9iPt6CVx72vUYj35hhKaYFXMoaTxTRNCIxdBIi4B93E/58rEl/DOgxfHrCiN9UY+38Fx
         qBqzoWj/0VGhYVFwvH5VpXbB8huNSw2zIa+Krh7enc4gPgIkT0dmsJ1v2Dcgr69ATvPR
         OTjkbV0ZWZlBk5lB9Dv52q20ko/c9/2Dol2cUKJ4gmfY4EdkJrPiYuiE5wQ+4+XY5ecH
         7PEdCOv81IHZvVN2k1/cpYAFjBjIplyuwmh599L6kUDw/R7TACmQaoTwpC+z4mMHuWdj
         hmqA==
X-Forwarded-Encrypted: i=1; AJvYcCV9brwGUqVtJ2G0C/lY+IPB+yhBhYzF9fRT3aZ/g9VxbgZBFjEaW+ycTk7S5Sl4sKBrV29uNaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sqwQHKwRKsijuEmwwiY200wRA1TDX3R+Z1iEJDYxjOCy9VCP
	sCKVaUd57KLGWQyIEbUc7PcKhMGi0bivqFzhrP0Z4xUgV2s0IGLCufcr5H8gaClSQf3I9cEE2lF
	B0VovwMCEqMr1D3mCGuHeX9i4zVdCWhUX3XDtoTuX
X-Gm-Gg: ASbGncvWU7bR6K9sIX4IHUWMxbux2g/QOymIy3JkL8MjFwsehTjnZse5ytQVWm4ucLQ
	rQ9pizKlfHQd9QM7u9UwBwvpO79vwoB+Qqqx2JsHVoir1f3btld/olEIl/SvRYyCd5rXLgCa72+
	ZVFPlS+AxFi/SeDDZX/b/bB8105dGhb4qMPkF34cOxmBOIdtd8nsnEUqKfiJA9SHVSEzkzHvtDy
	BC18wz2YZniLdFXSC+x3gjAjDLapB4jOXyRnrH65cwOLVMxMl4=
X-Google-Smtp-Source: AGHT+IFsBJFrAVwoybcbClhbtkk6+q8fn0XpsL29CyxbYcZsn01RsMz0QJdas5oeFENVsTV7mWK0xrlHVrkZaylEWb4=
X-Received: by 2002:a17:90b:3f0c:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31c9f44e087mr26700843a91.33.1752958069394; Sat, 19 Jul 2025
 13:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com> <20250718163723.4390bd7d@kernel.org>
In-Reply-To: <20250718163723.4390bd7d@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 19 Jul 2025 13:47:37 -0700
X-Gm-Features: Ac12FXy6EAOOfaaxCqmoRw0ddlTwqZX2GFu92iR5XeK54Otp2RZbW_v44V-SJDg
Message-ID: <CAAVpQUC_sH2UDdf0e5c=iPFU5EcaB7YeN=__2j6w_h6_pe8m_g@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, haiyangz@microsoft.com, kys@microsoft.com, 
	wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Jul 2025 13:20:14 -0700 Haiyang Zhang wrote:
> > The loop in default_device_exit_net() won't be able to properly detect =
the
> > head then stop, and will hit NULL pointer, when a driver, like hv_netvs=
c,
> > automatically moves the slave device together with the master device.
> >
> > To fix this, add a helper function to return the first migratable netde=
v
> > correctly, no matter one or two devices were removed from this net's li=
st
> > in the last iteration.
>
> FTR I think that what the driver is trying to do is way too hacky, and
> it should be fixed instead. But I defer to Kuniyuki for the final word,
> maybe this change is useful for other reasons..

I agree that it should be fixed on the driver side.  I don't
think of a good reason for the change.

