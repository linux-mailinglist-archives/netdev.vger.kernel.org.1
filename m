Return-Path: <netdev+bounces-222938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D8B57207
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F27B4E1713
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268972D663F;
	Mon, 15 Sep 2025 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AlhJ2HZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C532D739B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922711; cv=none; b=e+UrOLCWvomekhZL31XseiSk6WI9coo+6kCCyvKtOBWFtyuulxX4taBTYxnvfpZwJ3b/HhAVPfoejUKEeJi24UPB42wtFkaW0NAPd3ucXYPceyPL4F8pVQUR56KxTSRNjs6PB4cJ0dBwoidtk6J/BrfQ1YB1V8wxWNJ3WVbLZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922711; c=relaxed/simple;
	bh=TIUykqSVlqjMNwtVv4K7W+Ru6Hg2RdZqkUzbnXeg9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW5MidG0+Agqs9nVN28g9otMKescRf+Tf4LSpUQI95Nr2cBI+Aiinvmv6ttRn+yqAFd9T897vJt4hdEUZfrVFTkJbn1u4MfnB631Zfc6fvHcVIRJTTISrtpPsFyMmrQ9BsBybARU12rDYyvpvP1tntx5pMittpztsJ+Gp6CckTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AlhJ2HZs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e1b2dba00so1179067a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757922708; x=1758527508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIUykqSVlqjMNwtVv4K7W+Ru6Hg2RdZqkUzbnXeg9IY=;
        b=AlhJ2HZssR5Wkvx9yMFOvsz4/LacoYr/QOEZqulUeIbUA4UpX02oymylMSrO2aNV/x
         yR5/45HvOARJqxP5pmyCzNBZD4i7JWvXmY4HrvTdJb+CbCci2M/20KiixgfuS9vnj7Jp
         a04Ss3oFif41KBMT9CGCUmoiefNi3m3rFks5uBqC5dprYM0WNjWWDniJNQ1uGYHTyYm/
         9rqkJufxsB64gT7kxZsuCvfCrrYBEUj6nvRYQ8ydJYG6KNhjF8GeCD/wNToYlDe/Uux6
         lSR/A+XPE79wcXs7Z6BR+W16l2IEpLulOUg8lTsTElxKEkZqbvXICBodZLQDaHn+RjL7
         rivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922708; x=1758527508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIUykqSVlqjMNwtVv4K7W+Ru6Hg2RdZqkUzbnXeg9IY=;
        b=XIVxj6XWZcTp5tzBUoJry1CNJSWrnN7mqmDAyFzY4vlP1wT9uV6Mg0UNs7zR/pOGKb
         n061JP1slMwPco6MIdRpZLpKn3prmZ/0lGyp/7Nv65yZLbtfIuETcQ0A6TywJSpAVsuE
         qCRMa/DOmu2qF656O3NUaL8MtHnEYqr44PWgoVMZtTk1BH3gWcm92awNfWxH79B0wq4X
         rPHJgLXq5XwXDIZdA/ctw78rbWPpfyn8yap6b+Aqf3pBmci/lfhJaTQ20vT8MONJmOL7
         Rpc1zTxBb/idmq9IKCwh1nn3VkRHz47tYSYOgnJn96KeV2q2RY+sgspkLqQzyzhV+M8d
         J2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ql74p+6EAMLV4u9c9m6SLNKIoQry4uRRJK7SRQLhaVuh+Bp1eZcInHlPgR1YS/SpwCBRW7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjd6/FSE4rcgI2PQHtzplqALOxKSb+uq8YevcqN3vL524ID47J
	FoaI23wp/EfFO8ZQr5V+VUrWyX+mnYPVTLX/HWNrJE9aB30U4HJM0U/QfoF9jspnTSmDY9+eWNh
	BzwFK8AvGI08MP2BDUdYSZLGm5F2e9QYd/YlhG11/
X-Gm-Gg: ASbGncsA+UZVdRczdF0y56ZMlG52KKFVLKU20Zh5M/u/h1aQgovfteY+pZk/cwwfyOc
	6mJCFOdayhIRQIHpau8O3LSF48865W2+Zun8P+wRKYyr1F2/F1EDPQmzFRpnD5SZZzEOAhBr0xY
	MtSI3+tQsI3LGrSL+zpjSvtDNPIQ+WA0z6xt28b5T3dmHGAA1DBpRhC8nV0allW3I1WFNI4DlPG
	aB4Wb+7ugdZqyxy/2Ec7EP9jZ3sLYJPFsHppIeUjJOQqYCRE3ifkLRiYtk=
X-Google-Smtp-Source: AGHT+IESdl3p2ny4HFv4v32UYdjhTPEJJJzNYt1DsDb5yMYZ2iBKM4++dZKr9nKUBLCeAUCqu58vWOwnvloutkugsrc=
X-Received: by 2002:a17:90a:e18d:b0:32b:bc2c:fa1e with SMTP id
 98e67ed59e1d1-32de4fb9f20mr10699452a91.36.1757922708313; Mon, 15 Sep 2025
 00:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com> <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com>
In-Reply-To: <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Sep 2025 03:51:36 -0400
X-Gm-Features: Ac12FXyDIzC8gC5c3ATbcTZlcOBV-j65w-3laXB3hp_jRdl9ovVz1d5K-jasy3U
Message-ID: <CAM0EoMmA1j=q0XtNB_Xax2eVuyAKtnrkkZuXAm3O34asqGNk0g@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: David Ahern <dsahern@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, netdev@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:50=E2=80=AFPM David Ahern <dsahern@gmail.com> wro=
te:
>
> On 9/9/25 9:32 PM, Jamal Hadi Salim wrote:
> >
> > Please run tdc tests. David/Stephen - can we please make this a
> > requirement for iproute2 tc related changes?
>
> I will try to remember to run tdc tests for tc patches. Without an
> automated setup, there will be misses over time.
>
> >
> > Jay, your patches fail at least one test because you changed the unit o=
utputs.
> > Either we fix the tdc test or you make your changes backward compatible=
.
> > In the future also cc kernel tc maintainers (I only saw this because
> > someone pointed it to me).
> > Overall the changes look fine.
>
> Sent a patch to add a tc entry to iproute2 maintainers file.
>
> You say the change looks fine but at least one test fails meaning
> changes are requested?

Pending the kernel patch being applied...

Acked-by: Jamal Hadi Salim

cheers,
jamal

