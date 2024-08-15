Return-Path: <netdev+bounces-118769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1106952BCC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D851C2172A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569817C214;
	Thu, 15 Aug 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABbpPZRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B91A00DE
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712828; cv=none; b=VBID0PYMtrVYH3le2SAwQMFDnSx5g7VIZ9Vsn8qWZEiExHL/xtmU6MrAx3xaIAKs8GGMtxGCgUfi+HjwKTq0w9Pmmmg9GagbD3Yv9acsVQb/bFYPU9pNNK9NewScvz9Vp6fPtpq04t/7Vc6IOvjCjtNq8VPLis/8n2K2gFcQwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712828; c=relaxed/simple;
	bh=gKYghzI8XPlguzTzjYaQoAp8WbKODgzAPsgN3v43m40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hulp4geFKtMBfYuI/830L9zxlhR414qiaJcciLIE/IT591Y5xKH6lbXUzO2SytZKxepfnL1OHtPSSbRLsoF7ck8BkwW6uw7v2Hmo9BQfThG/6Uu0AUMrEAFk/rJazRLTylwHKFjDRZZCmEb0Wtziz5KQwKV2wuqgLCrESxL/Kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABbpPZRW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1012000a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 02:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723712825; x=1724317625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKYghzI8XPlguzTzjYaQoAp8WbKODgzAPsgN3v43m40=;
        b=ABbpPZRW52jCk+URg5QmSiMl8qyqK0FKBCUwVSsEtWza64w7qBuYjnqBwJ7GHs7bom
         9lewW6pKFlWDf+z0zeZEEQKqK/AkhKNd44tMhd7vJE84dsfm/UaxaAZ7YDQYdcK2dhwW
         pm8uaJo17d3T2fnnTbw0DnlWnhIZZqSxPAWWpi+5Hi5L0J84XEfCQmAGIQJmCVNtt7YC
         sWgBr6t/1U8hX15q8YnGA33XigYuukclcAWFZUIxJXmS++oc93aJSEAwircjUAHmvqse
         CHDvFwV2ht1sFl16Wz0RC0ZkeuBwcNiy/y1wnw4bfK9THz5vaPy+4v3sZSO6M85gbkbS
         x98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712825; x=1724317625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKYghzI8XPlguzTzjYaQoAp8WbKODgzAPsgN3v43m40=;
        b=bFRUtHOBDtANzpHKa8Zci1fN5Avi4g6c+wBTOEM5OnsPB42bCiZskHw1kaNWMtG8e7
         pVo+eSJRL2esFll7eBaxE6q3uXy8WI13kMzQs6sYYfHw/Vf49Hv1HgD+iBjrjWBJ3OiX
         oX4tru8j5Bd+PKYZ99CxybpaCnpOBrXFM20ahr3yiteihe7RasLLrWwt9EFruQUV0HGk
         Ly3vWBnIgNF2R+Soxy+LPPniUj2d+hBJAd/xMauNy8DyBgt7vnnJlGtVWm951IgqYErS
         DvvbthfOOz9zfeRKvPpCo5F+Qg0MFFX3OCTmGTuT4YXj3ypkSYj9enCDdupv11YH/9+H
         P37Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQuyp6UvyMBr5+dRAi/whs1Fum5KNxjYjxdaZmmeq8lceAxlFT41LXYZtEPgvQC45uVZKlbEvRhhlpIPxOXpr+aT1FydxV
X-Gm-Message-State: AOJu0YwPKVyIQhLzqvQ+LvF75W6LYnA5b8S/snoA6Ex81pua2bOvzTcd
	2Ij7AH/pnQj90w+6DRYkXBL8gKyoh8NnMoNEcU41KRsaXZs1Is5fCHH9tJYsaI80Lh+U10UIpXK
	cpkZAnzQeol42AWwysA/m85I6sAg=
X-Google-Smtp-Source: AGHT+IFhYvisV+ZsDCGEKasVDt7Mo6N8WA+POz5bJNHpn8nhcIso4kSnrJReyl4tV/V781+kbTxgfxmN5T5sfJSnDrM=
X-Received: by 2002:a05:6402:2344:b0:5be:c34c:f467 with SMTP id
 4fb4d7f45d1cf-5bec34d09bcmr723410a12.24.1723712824344; Thu, 15 Aug 2024
 02:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
 <20240813181708.5ff6f5de@kernel.org> <CACKFLimwA=P4M8UEW5cKgnCMCRu99d5DBX17O6ERriUkC=NxMA@mail.gmail.com>
 <CAMArcTW2yvEJLr_55G7FDsGtzKjTa2zMndOrAOBCshsW7UUj5A@mail.gmail.com> <CACKFLikxTXW4xg8vz7-NfModfn-ymf=a4pL6BtM8LebOmPsdfw@mail.gmail.com>
In-Reply-To: <CACKFLikxTXW4xg8vz7-NfModfn-ymf=a4pL6BtM8LebOmPsdfw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 15 Aug 2024 18:06:52 +0900
Message-ID: <CAMArcTWnDk4eQLgzNXJ-LtudXugEwrLSFB+T-EByaFAcudOk2A@mail.gmail.com>
Subject: Re: Question about TPA/HDS feature of bnxt_en
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Mina Almasry <almasrymina@google.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:18=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>

Hi Michael

> On Wed, Aug 14, 2024 at 12:51=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> =
wrote:
> >
> > On Wed, Aug 14, 2024 at 11:08=E2=80=AFAM Michael Chan <michael.chan@bro=
adcom.com> wrote:
> > > Yes, the rx_copy_thresh is also the HDS threshold. The default value
> > > is 256, meaning that packet sizes below 256 will not be split. So a
> > > 300-byte packet should be split.
> > >
> > > TPA is related but is separate. There is a min_agg_len that is
> > > currently set to 512 in bnxt_hwrm_vnic_set_tpa(). I think it should
> > > be fine to reduce this value for TPA to work on smaller packets.
> >
> > Thank you so much for confirming the hds_threshold variable.
> > I tested this variable, it worked as I expected.
> > For testing, I kept the rx_copy_threshold and tpa settings unchanged,
> > but modified the hds_threshold variable to 0.
> >
> > BTW, how about separating rx_copy_threshold into rx-copy-break
> > and hds_threshold?
> > If so, we can implement `ethtool --set-tunable eth0 rx-copybreak N`
> > and `ethtool -G eth0 tcp-data-split on`
> >
> Yes, we can do that. I have the rx-copybreak tunable implemented in
> the OOT driver already and can be sent upstream. tcp_data_split can
> also be added. Thanks.

Thanks a lot for sharing that!
Taehee Yoo

