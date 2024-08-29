Return-Path: <netdev+bounces-123082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA5963A03
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7AB1C21CF8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15512E1D9;
	Thu, 29 Aug 2024 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OapxtYh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04234D8C8;
	Thu, 29 Aug 2024 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910459; cv=none; b=vFmunOmIqsCwu81w/qh/htjTR8HUPcVhr29990WFrN6mOCHJNiAT7+k5rav/vm1ycZicW1lI7mx8fBBh8f4MqwRrGIdHaUz6Q0c3AGP29BqFoO+Lrz+iB25x63W7v0NpV/xPGoVfkRs5cWJIZpxlYoKCRgRPcIwWLOubJwFc1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910459; c=relaxed/simple;
	bh=/bCoNRI9t52KQOOhztNKjSY6YE5Pak0awBtXeJI6ods=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+Gftf86rW0TkSvXztJBxDBxVP7JnuPibxl2AWI/+D7cSgdvg9jcr2+pm+PT43OzJt8+wnLK1MoZqOul5QUb3u6E/5UYxCxQVbl/2PY06Oj+kG/eFdjCTXHiAilW/GlaDq9FbCkuxyitCoHboyW0twQoRInv3wjOvkzffNpaBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OapxtYh0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b6b9867faaso2773507b3.2;
        Wed, 28 Aug 2024 22:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724910457; x=1725515257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bCoNRI9t52KQOOhztNKjSY6YE5Pak0awBtXeJI6ods=;
        b=OapxtYh0zGUI10l9+G+21crwwsfHGgQgMwbBH5d3Ym1r2aaF0D/Rh1Eo3THYZSeVQS
         hTou221gj1U/H4+0nU7amgOV1XxHjNtNS73oxtFbMF6cPBMJDDorlzBb5m/wUVrgGlpa
         FxYN5Y+NnwSOI8ZqxpxY8YRSZuP0FBbdeljUNQxJvhnJZZCftNS7V/kqXdocJpiGAvLx
         5ZKDHsCTsLCZsx8XYjmMHW4n012Y6xWg5ru1zM14gli1v8mzPQfJMfBFlVC7SyBGrc9W
         F1c8e5cYB2c9iASkBOVRoTLttgrB6spm0gNv9Iw4LX/+tdiXbE8nNNDpd/k039swLIfY
         qgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724910457; x=1725515257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bCoNRI9t52KQOOhztNKjSY6YE5Pak0awBtXeJI6ods=;
        b=F0gVs30CcNybl4TZwBQ9nGrMMYz5nrav1bU6ZGpUf1jLUrnOrGPK/OyIvtpAj8zViR
         whOYbAev4HPMd0IuS+8sgmOhOvC92uQI9dLH6rTNJwZ4LhQb36QzC8RLl8xcXe79Xgwr
         KgBe0MOw092B3NIfrrldvUdItYYHUADsLEnYm+90A3attlIwY+XuSqqrR1J1Zh1baBKK
         2RLU1XMAcbK8q/bAkw8HRfnllO3m9kMypt5BmM0GqE4Gcp/+qCqT+m51NqhyGrsrGdQo
         7+7TmpCBy1Q2qjykYeP/xXtQZJjil/dll7MPzoxYIV4mrqrdXC0PkfCaMr0li3p1Era8
         yfkg==
X-Forwarded-Encrypted: i=1; AJvYcCUSOiko6JUeR+VGZSLwVzQla8dA5js2zifEFi6ERyKz30Jodlo0Z4U1Qw4jMums2ernp9HHgYP+@vger.kernel.org, AJvYcCVxSr/vhAfuMn5csrBn0W4G/Bc9nySmZ/TF5rJ+PA2N2z1LepyH4GN4I8Pijzp/VuqAbXKi9TtOkLxPe2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds/l8tKg+sjLY5k48fn5tzjJkKZNNt3nWYrGaGx2FbywFDfhg
	JmCWGAcGsNfkcTwvY4/yVxsyhGq0Wg1T+0/YuOPuv4ewCrVHZvDrwFZEtQudwqs6FihDxf0jotZ
	/fvCSeYtTX4wnU3Fy5msP4BIFuYA=
X-Google-Smtp-Source: AGHT+IEc098aorGwO4QWwt1UMh8VAOPJSSeaNC4DdjXeeAWRp3Ho4GMeXtg/ighYPdCLw+sS2Ov+iqNJWITzBZHC2eA=
X-Received: by 2002:a05:690c:7009:b0:64a:956b:c063 with SMTP id
 00721157ae682-6d27804bc4emr19135997b3.39.1724910456523; Wed, 28 Aug 2024
 22:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
 <20240827133210.1418411-2-bbhushan2@marvell.com> <20240828182140.18e386c3@kernel.org>
In-Reply-To: <20240828182140.18e386c3@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Thu, 29 Aug 2024 11:17:25 +0530
Message-ID: <CAAeCc_=3vXvRgo1wxzHwSY6LJS-vUzeShSdJKLotYSuHBi-Vzw@mail.gmail.com>
Subject: Re: [net-next PATCH v7 1/8] octeontx2-pf: map skb data as device writeable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 27 Aug 2024 19:02:03 +0530 Bharat Bhushan wrote:
> > Crypto hardware need write permission for in-place encrypt
> > or decrypt operation on skb-data to support IPsec crypto
> > offload. That patch uses skb_unshare to make sdk data writeable
>
> sdk -> skb ? :(
Will fix in next version

>
> > for ipsec crypto offload and map skb fragment memory as
> > device read-write.
>
> Does the crypto engine always override the data with ciphertext?

yes,

> How did you test this prior to adding skb_unshare()?
> Could you share some performance data with this change?

testing using flood ping and iperf with multiple instance,
I do not see any drop in performance numbers

Thanks
-Bharat

