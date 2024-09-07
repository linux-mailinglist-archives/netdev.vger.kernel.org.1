Return-Path: <netdev+bounces-126238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FB97034A
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDFA282FA3
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071615F323;
	Sat,  7 Sep 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MiQav0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85863134B1
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728814; cv=none; b=B/vwp3V9dP+nZlia5KQWOhXdyDHg5MmcRCAijaCYPTPQAN++Zg7+opFfY+klPPk++DHO37GQKX1WoiQBSYizuSLDQCPsEgqkLuLlzsv32l47OiC30/wGbCz2B3nYty2DBdZTLt2SiPTM4rv81P8mTZ49S119ubwGfSxzY0q0jZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728814; c=relaxed/simple;
	bh=HPcfkw41zQmCKqhT2VpMjzMr4leuLnJW971WDPwrmh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5uwMNDbVGdwrdO35GNTjlvHs6Iku8FIImuhdeAHowS4mocy2wNZ/2XKXdcCcuqb/Jt7Zl+fsNcJJC5ITaY65lt0HAhoGzS7VH8cC1VVSTxLcwmPp88f6PHS3GLPUUf9/KUlQQE41I9H+cOZjcwUrvcCqYMKeKw++alIMX5Bp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/MiQav0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso3330419a12.3
        for <netdev@vger.kernel.org>; Sat, 07 Sep 2024 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725728811; x=1726333611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpCSh0jY0+KH87F913XWGrunZ4XUHdfHztAJ08yvA2I=;
        b=U/MiQav0ejW6y+YJfBA6BvqsFpyeEo9n5m4/cW9feDxdcUBD06nMA6S3QlisIhdzLK
         4+jkupWmUZgLHx03LXlKmDCLblk8pUxOh/WG2m16OUqVJpzMNBdp9VtN1Zv4Q9loy4vd
         e8DfY0T1c78hL4Mm4JW6TS2VRK5gGxpGjDDRl2der9m7DgJ3InQHP+/821vmcMAZZ3RM
         lLr5KPNImrnKfS9zkoaoCdI31s8ejbR36z2ygDf+RVc7yAbDT3ZYu4YUKtVDLKdGijag
         a7PyWoYpQrw3pPlIqW8e3Qm5pkJ4s+2jtj4wVRgRvx5B0GGPe1eVbw3cNFzfLTGYdgY7
         wvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725728811; x=1726333611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpCSh0jY0+KH87F913XWGrunZ4XUHdfHztAJ08yvA2I=;
        b=JZHLppRifawBek+isbNZYCJLaDPuAMkLzuIfXx5kOAHq3fIBht++1MoPuDx/b9wo/G
         RU6vr0tHESTakcyukNctZsf8gIQrAettARKGu7hs3AXIwITfmTop6TE0Kfql0q3+u69f
         KTlChQ3Qy6UeOPUM82sX2AQEgdzPHMfEnoKTaNHsQjwvRan44+AXHbRLJkLCeBX/oR99
         YjN33tKJ85IoSMjkP59WXPg167BV7gXf+hCyHVsBcZiL8SHwOSeooOrRHb1p6g/xRFuH
         O3qDNNNurvYE+quFAAPfvrw0F/0po5rUUbr/dUZyd6odun5z4dyKtGdCif0k9cSAXkBa
         8ZFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6iEQLSiFESHj7cc1OSf1eRg7eBu1Bi/SgyLNnCdv+2mbEGvPMSP4gpZxUvVayly9M7mnzW48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxalcxIVBSY0/QV9Fu13tK8spbeotwsvcGDwhw4Ei+kscspTKdm
	M6e6JWaLbh80N//wwnY5uMBXfnHMJHThShCiA3X8IdAOJxVvx9uELK5jxg/GsNgPYNdrh8N3bQ9
	NymCEZ3wFRNNSYvCAJOK7LCWGTyc=
X-Google-Smtp-Source: AGHT+IH3Mka82Wszk8CGt1PQBvI0Q9o7z9IhDdMZJlhgIVLulfSvewd5znE6hvwYpePQ3wqoJweiwrXszQxak5V4ecg=
X-Received: by 2002:a05:6402:1d4c:b0:5c0:ad76:f70e with SMTP id
 4fb4d7f45d1cf-5c3dc779d65mr5058671a12.6.1725728810380; Sat, 07 Sep 2024
 10:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906080750.1068983-1-ap420073@gmail.com> <20240906183844.2e8226f3@kernel.org>
In-Reply-To: <20240906183844.2e8226f3@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 8 Sep 2024 02:06:38 +0900
Message-ID: <CAMArcTUiRJHj+u3DMjf+SGXgk57z-uDmXNycsfXku4=MKrngVA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] bnxt_en: implement tcp-data-split ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	michael.chan@broadcom.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 10:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for your review!

> On Fri,  6 Sep 2024 08:07:48 +0000 Taehee Yoo wrote:
> > The approach of this patch is to support the bnxt_en driver setting up
> > enable/disable HDS explicitly, not rely on LRO/GRO, JUMBO.
> > In addition, hds_threshold no longer follows rx-copybreak.
> > By this patch, hds_threshold always be 0.
>
> That may make sense for zero-copy use cases, where you want to make
> sure that all of the data lands in target page pool. But in general
> using the data buffers  may waste quite a bit of memory, and PCIe bus
> bandwidth (two small transfers instead of one medium size).
>
> I think we should add a user-controlled setting in ethtool -g for
> hds-threshold.

Thanks, I understand your concern.
So, I will implement the tcp-data-split-threshold option in the v2 patch.

>
> Also please make sure you describe the level of testing you have done
> in the commit message. I remember discussing this a few years back
> and at that time HDS was tied to GRO for bnxt at the FW level.
> A lot has changed since but please describe what you tested..

Sorry about the lack of describing how I tested this patch.

I'm using BCM57412 and the latest firmware(230.0.157.0/pkg 230.1.116.0).
I tested if the HDS had any dependencies such as TPA (HW-GRO, LRO) or jumbo=
.
When I tested it I checked out skb->data size and skb->data_len size.
And HDS and TPA were worked independently.

HDS disabled + TPA disabled:
It receives normal packets.
`ethtool -S <interface name> | grep tpa` doesn't show an increment of
tpa statistics.

HDS disabled + TPA enabled:
It receives gro packets.
`ethtool -S <interface name> | grep tpa` shows an increment of tpa statisti=
cs.

HDS enabled + TPA disabled:
It receives header-data split packets.
`ethtool -S <interface name> | grep tpa` doesn't show an increment of
tpa statistics.

HDS enabled + TPA enabled:
It receives header-data split gro packets.
`ethtool -S <interface name> | grep tpa` shows an increment of tpa statisti=
cs.

I tested the above cases and they worked expectedly.
But I tested again after your review, I found a bug that sometimes
couldn't reset jumbo_thresh properly.
I will fix that bug too in the v2 patch.

So, the v2 patch will contain the following.
1. fix jumbo_thresh reset logic.
2. add a description of how I tested this patch.
3. implement `ethtool -G <interface name> tcp-data-split-threshold
<value> option.

If you think the above description is still not enough, please let me know!

Thanks a lot!
Taehee Yoo

