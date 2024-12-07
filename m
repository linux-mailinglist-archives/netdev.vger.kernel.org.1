Return-Path: <netdev+bounces-149861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6759E7DA0
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460C01886DA7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 00:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABE4C7C;
	Sat,  7 Dec 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY+yRgC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009E17591
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733532560; cv=none; b=GUkUcDxvs8oauJM9Vtrec23ZTozqyS/ojl5oJMSM56ZDbXf2f6qxQz3FpHQnD4KmF/+74whTkPnsS7gukJOdnzZ6vm0pIhwQ2S3zL9+M0YPXW+yEpDjPwkrdEEHeYhaQP/hECvNOZN+kJxBNgDmH3twtF/kugNC8dfdaZQZjBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733532560; c=relaxed/simple;
	bh=BvEACG1yhqDi3KOhWejuezXkc0KgaZnygSlKP06JFA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArtHzOOH4rc7CPTrKnZscS87TkG152/IjXnTQI2RRccukDL8P+3qLHyo6u/+qFCA+XijO/9a1Ic7DM/rxZZMNMsMuMztWsXAj3BcPNNTXfmm2uOZejJkn1LZI7dLvpI+IFdZ3GMhj+ZWgtDxYpBkHd15kZNL5YJDrHojR7j/qGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY+yRgC3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef9b8b4f13so28353127b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733532558; x=1734137358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWkXAS5/d4qY6CPjX+Xs+FfdLRwyQuZ1F6xa14Fxx68=;
        b=XY+yRgC3/VicAX2obcO9HvbHGug1T82fIzj1BOv4+/Kb97UEqd5mha44btowSxFDOk
         ltjRr3pCQP4hWaG5gTMrytNsGgwI7KR5JX87Amun/7Xi3yUSrst4nk7Kgor9Gxrk7MSA
         yM7VTxNIhGYPSbIfOFhJULJcSLkvOEcuyk0nscAmjdoN8+RpZFF/fmYF259UupLeYZuq
         B3iNSusTJfcMYmh7x3gnYKibQI0f+k5nQG/pFp9QRa/RSzRz71qWr2A9jcJvoTi9vV/p
         LWJf8NVeFnc/SLT39YcLFk/xz+h/SU4ASuwBwbWpacM0Rx2cI/NdzvyU2yUfrHgwVYUX
         ryTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733532558; x=1734137358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWkXAS5/d4qY6CPjX+Xs+FfdLRwyQuZ1F6xa14Fxx68=;
        b=eZqadH3s2HBnq9H2J8j6wgtGRsZaYxS+Ci5HI/RpBlS+Llh2ZVSZj4YvQcxXd/wJmG
         aQs9BWXD4/4lvfvZSaGVguL0RF4vQTyj/clfue9KFRVCrnOZlFtq00IWacddMlWdNWJS
         rmlQq58ucoIZ/kqPZ6bYy5Fy7Epp5ec13xzkpS9n5/yqaOz8kbk04kpa4wC2/G/7ErnV
         SkodDXvnROUeagFoYoHD69bD264OBVsiVBJaQ5kNqt9/cqafdE3/FpBAtcD7arCGMJ6m
         g+3XqrXDYPaLKJ0B8J+VXdolxVyyF9ds7Hqgs+r7flo08Ofmh5PvhKDJ6K18nqFvyRU3
         3Drw==
X-Forwarded-Encrypted: i=1; AJvYcCUSBnEKM4jUORwH2ZBSAUINZa4my9wFeUoE0SFXxPN2SxlvcRVul1CqPV0A3GrvS+U2D48s8wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcRNc3tisD1IJdpztlWpA5jtiHtxG6pbSLqObil2TS63ycoA6
	A54u9bMP4UgWAOHrB/9JSyXQh1IZhFobx5eQM0/wO0C+gbrVuwNywaf0MgSquXRCxiz5hyqSI23
	eYot6Rkhw7y26PlardfhpFQVT2FE=
X-Gm-Gg: ASbGncsyvAHH0pnobsaw0EM+Mnp00rbN9ZB6asucUBO2rzPfDFbAHNd6cSlz7+W5EV7
	azFgocwGDCDwV+78sWUErghydWECX+fdyAYrvTkxHE72j
X-Google-Smtp-Source: AGHT+IGVAvyFGjlrwDwStyvFoYw/4H+pukPwC1OtZNc7tT/A+6Fi1IMsvs94Nqj0jVa4kd0fb+st7CZiayaSoKlv160=
X-Received: by 2002:a05:690c:74c4:b0:6ee:7339:ab42 with SMTP id
 00721157ae682-6efe3bfaefdmr60755937b3.14.1733532558306; Fri, 06 Dec 2024
 16:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031211413.2219686-1-rosenp@gmail.com> <d97614cb-1798-46d2-a3b8-88fa100d9765@intel.com>
 <94ab7f28-c74b-49c5-920c-a3a881de0b86@intel.com>
In-Reply-To: <94ab7f28-c74b-49c5-920c-a3a881de0b86@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Dec 2024 16:49:07 -0800
Message-ID: <CAKxU2N9_HJKPB-jcaT=jqJfZ_KVUj_Y1PC_ZH=8=n+So1MdN3w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCHv3 net-next iwl-next] net: intel: use
 ethtool string helpers
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:10=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 11/5/24 06:47, Przemek Kitszel wrote:
> > On 10/31/24 22:14, Rosen Penev wrote:
> >> The latter is the preferred way to copy ethtool strings.
> >>
> >> Avoids manually incrementing the pointer. Cleans up the code quite wel=
l.
> >>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> ---
> >>   v3: change custom get_strings to u8** to make sure pointer increment=
s
> >>   get propagated.
> >
> > I'm sorry for misleading you here, or perhaps not being clear enough.
> >
> > Let me restate: I'm fine with double pointer, but single pointer is als=
o
> > fine, no need to change if not used.
> >
> > And my biggest corncern is that you change big chunks of the code for n=
o
> > reason, please either drop those changes/those drivers, or adjust to
> > have only minimal changes.
> >
> > please fine this complain embedded in the code inline for ice, igb, igc=
,
> > and ixgbe
>
> I would be happy to accept your changes trimmed to the drivers I didn't
> complained about, I find that part a valuable contribution from you
Resent with removed variable renames. Hopefully this gets merged.
>
> PS. No need to CC XDP/BFP list/people for such changes
> [removed those]
>
> >
> >>   v2: add iwl-next tag. use inline int in for loops.
> >>   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
> >>   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++---
> >>   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
> >>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
> >>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 43 +++++++++++------=
--
> >>   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++-------
> >>   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
> >>   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 ++++++++--------
> >>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 +++++++-------
> >>   drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 ++++++----------
> >>   10 files changed, 118 insertions(+), 114 deletions(-)

