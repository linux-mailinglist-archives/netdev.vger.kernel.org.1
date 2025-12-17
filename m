Return-Path: <netdev+bounces-245255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B068CC9CE6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0724B302D29C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB40224B0E;
	Wed, 17 Dec 2025 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VYTSy/0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6C3A1E8B
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014363; cv=none; b=HmE4DU9e5ltncNfurXdlwYURJmwTTlRRXkCAv2UOd7dfncgziUZA3RTo6Ox0o+H0UD+lBhIWYEzK/9ldOPguEQshAETl5GsBdODQJ4TS3+T/trHOIx9G964glA2JXG4F7ov0txKpMw4AYW+CMsNUspHzoqzO4yTwOFMuDts/noE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014363; c=relaxed/simple;
	bh=+/C4hoxD1x3bV8ag5bQifbyver39c2PjN3c4XorgrB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shid094nzHi34nanJA/VGDAZfiTrCG9ELuQhH9KS2WyOzPaSqP/qt0tK/GsJ1zNVZB1NTXSbO9iT1x5ylrN+lvmdPUN7pJiuhGAUHGI2jbrTBUzfabQoWwboowCbNOIWcltLB8IFZ70LRPrsXzK1JEHhQEKnk7I8CPFGVPUhyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VYTSy/0j; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b735487129fso6613166b.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766014360; x=1766619160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGmfZWtGiWhAo19vEcCHDk44jmJ9wrevbJo4smHkUY4=;
        b=VYTSy/0j51lwoIftC//n9Amc2hb922BLwo1moLu+vqzg3r2QTjYCZl+s5FCUCZYFAX
         LQgLLacd3nfGHw+yU8fDKW32VYuqoNMNzhhow/GOEbPLrziuJJRz3+Hmmz3BeUIkE/fo
         gqVfKKOjfhThXeEad8vDK1wg8HyLPFJe7SrkwXn4WHfS0lQMAX+uIeC3JJaL3m3jV1Lc
         F18zhp8ApOvxL1uOI5grNC6bCRQKlpX3RCMX3LyHMRtoHzhck52BxZJ/T1r025CcCCde
         CqFTsjZf2tgzspIISqVIzpsJid0uM5bvqFBzy8mhVlWPJsBAsQHXpVOxI9/fyibGTqmW
         hg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766014360; x=1766619160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGmfZWtGiWhAo19vEcCHDk44jmJ9wrevbJo4smHkUY4=;
        b=S0ZR5iZQw2DRQD0WOywEES8LEV5E3mj6HbM0Fe6CPOrSpJK8znZrjNsJfDs1cufrZR
         i89dzkmC1wD66AWqd+R+7S51of1Bx4YFKyHF4dPh6yRqT0c/5jK6T08VzlY+Md3ZT6dq
         qwzGERVwKyHmu3Ma4zzxMwGY4l1TV51GZHZUdwZwJwkcpv3Djq865b7U7nPOAwBdnoX3
         vhucjj6fui11R0gCg5cC+nTN1LIHIKbUeMjjZdcbs1CyZRDdL1WuVNz6ewgy2Lu+dyb2
         eNuDEICZgtRKOufyaKhrk9JWJYR6A+i0cKoGLs+uIEX/SDGg5aJZZ9IUb9MgmOR0V8vj
         QiFA==
X-Gm-Message-State: AOJu0Yw0XB8kDOM7GXF9Er+KeYq2HOMYqEEEPAJ3/X4NlNZdAJTh77W2
	J7OJiEk/IMueLjcZuMe+w9bvqn0ICnrPOWUQzcT4H5F9BATksUhqbFUKnT2hJwSAo7+Oka0pvmS
	mCxwkWCyHjjXCMWn8K5aZsfc8zRRHYzo7wGW3QGrtSw==
X-Gm-Gg: AY/fxX4tVz9g3pAs2ueUBZ2zy/I53L1y7mfd/MPtRqDDRszNBPx70BArtNSAu461Res
	twcG32KNnXlciJx80OTzApBQJwLZ6l8+t3cJMwHoEh/hTplJVUNLv21YgUoUBMe5+RR9cQit4z+
	4AbSAa8oD1cL09+gqzDuNasQF6eokgET63eKrBpDInOtqxxf//bxOTq0tV/UfgJK69jg4CoIH6A
	I4qo2faXpv1zn7mMrYX6YRiH5jZImHG/wP7fNls5lrHoLCNwW2uevoMgOezh6u5elPomLEGKJVI
	/va2Nwq0jkCu1ZIz25laNmY=
X-Google-Smtp-Source: AGHT+IEV1niauf0Ycz+BUXcGEgs34RfV3dC9r/Q0Mw83iNvRaubmEzXu46/+wtzsicdv8EpfrBLYILi1/KaXLiJOvSc=
X-Received: by 2002:a17:907:bb49:b0:b7f:eb45:f572 with SMTP id
 a640c23a62f3a-b7feb45f993mr792039366b.55.1766014360079; Wed, 17 Dec 2025
 15:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dddf6b9b-74f0-42cc-bf1d-5fc8b8d4df8b@cloudflare.com> <3d40d617-a31b-4a7a-86af-66d2c938c114@intel.com>
In-Reply-To: <3d40d617-a31b-4a7a-86af-66d2c938c114@intel.com>
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Date: Wed, 17 Dec 2025 15:32:29 -0800
X-Gm-Features: AQt7F2r-FyoapkFVpROlMMGnZJT0UTwq9mPD4TQ_bH6HjPV6AEV8vpI1p6T3bBQ
Message-ID: <CAB1XECX2wzCqJVPBfxPeP_eddjNw1HwUjEj868EHzY=HR=iqqw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] BUG: ice: E830 fails RSS table adjustment with
 ethtool -X
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 3:14=E2=80=AFPM Greenwalt, Paul
<paul.greenwalt@intel.com> wrote:
> On 12/5/2025 11:37 AM, Jesse Brandeburg wrote:
> > Filed at:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D220839
> >
> > Kernel: stable-6.12.58
> > NIC: E830 100G dual port
> >
> > When trying to adjust RSS table # of queues on E830 with
> >
> > ethtool -X eth0 equal 8
> >
> > we see this error in logs
> >
> >    [ 6112.110022] [ T303140] ice 0000:c1:00.1: Failed to configure RSS
> > hash for VSI 8, error -5
> >     [ 6112.528002] [ T303170] ice 0000:c1:00.0: Failed to configure RSS
> > hash for VSI 6, error -5
> >
> > This command works fine on E810 nics with the same driver.
> >
>
> Hi Jesse,
>
> I have reproduced the issue and I'm looking into.

Great, thanks Paul

Let me know if you need anything from my end.

