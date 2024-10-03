Return-Path: <netdev+bounces-131755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AA98F70A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2358C282EB5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788B81A4F23;
	Thu,  3 Oct 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAIYuWtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94951A4F11;
	Thu,  3 Oct 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984033; cv=none; b=ZarPmxJH9YJMJkl2KukGb5V093C0lTKx2mhTE6StlxRs3kZ0edZ/uHkrKfSMY78XbYpZEJYqcZ0exrlAkXRlXHa4s2R7tZgf2mBeJna+zPEg+RWF1SYibnwZJzw1jjVurdB6kWXsyathAz4GUxI+CMLUY979uqXQ31MNfqkKURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984033; c=relaxed/simple;
	bh=uXXiy3CDBHNaH/C3GOZsmW94+Ui2mvqAwft1q99gfGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlS0fUBXl2iJBxGl5CXLVHz4kYc7At1nuxuJ68PDfWuRmyfyQtuPDAr9zyUaRZHn6kelVuD4X3I48hkuupZIbu1/dV7KL/Bkc6b6zC9JoKy6Ry1xa0mWzKCsA2EKFE4j0q6411hN0WgZAIe3ybdIffjajcQQ9mIIdyjjq4HFq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAIYuWtg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e33155fso1761350e87.3;
        Thu, 03 Oct 2024 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727984030; x=1728588830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXXiy3CDBHNaH/C3GOZsmW94+Ui2mvqAwft1q99gfGc=;
        b=NAIYuWtgwOEsdGuFa24+cOQLtD2KfJqThbSiEHUffjru+p0/tGx+xA5eqn1tuk2yw/
         Puvlm7HwBldFT92nG48UCkh1e1uw9qKax7EXMd3+/9kBYLdT7Y96pU3eGPjkAKxnJuDK
         N27IbM6nVXXjfuPDyZYlp2E+qey6X0Ud7MKn4Y4l9YljqrgojAYZfjTZydsGQEP/efhI
         ur/jgVJFsfcMT5kL1H7EisdnQs8DLNDnyiwi9kSXcnDiBvya4R5IcQWjb3w94XXt4ccf
         x62zcbQYO0D+hoTz+Xttlpcofk6CAUxvORMZzCTZPgj6rX5AJ8v58cL4mXQyC6jxk3ml
         u6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984030; x=1728588830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXXiy3CDBHNaH/C3GOZsmW94+Ui2mvqAwft1q99gfGc=;
        b=Qxvv8A1tj9rR3X6m6lzhuZAvjOeE137UmPdw7EYN1dsBKWQNokedULDtqWl3X9EbCz
         0lHWKcnFOUXv5TKkuH3uv0jeCNavPk/zEDSrCP7avj6l+u2Y5OeRtRO5jB9Odfg2b7Fb
         hjrqGKkWU/f5lr0PoFZWYObOIIZ4Nb938r/7NQEHUrCe+zAEFosy3DKXxwQ5Hgry1ISw
         1ZbJ2sZEcOFp/tgnZm6T9VxO55KpXmxEVapQlP+43av8LcD+UuO6O+NQbdFaIb5BcvbC
         Y5XZmGqIZXs8CmGY/L9ECfunMLAe5Ipuk3v+wkgHvRmpq74M4T8xOHL5Ma6Bi/UCPTqT
         Cz2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmPfpAYey1ovnLDaJX0oz8AwF0+L8P86cffbFO5z2SQcBOlO8GLrOtpa+tIvrfN2C0Z2yWq5g2@vger.kernel.org, AJvYcCXV5nOFvr0LscBewFw5vWg7TT7Xw+iEVanjm/BGmrtH/xhqfJp2aNaqiyzKtOkJXPE674F8a7x19IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkV0E/UZyb9jhL+gX9PW/I6LRWqCqcNcrVhurD5wOAXGPJvwat
	ICZH22y1Ntbas4wkyc7EaLpKVH5kspIwRF7599JAzKwSzJ+EdZDoVpJyTn6HMPoi0kaO6edWBnw
	Ky9m9qbdqp4d3LFCTHHNc2C8kbo4=
X-Google-Smtp-Source: AGHT+IHRtmv0ckL7GXfX+oTsUF4M9NlC/p+f0YiVbxvf1ASoSAnVP9w89lUbQubCgzlUBZ5Yob9qA1DwgCTKgp/XrUw=
X-Received: by 2002:a05:6512:138b:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-539ab8780cfmr263404e87.24.1727984029684; Thu, 03 Oct 2024
 12:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-4-ap420073@gmail.com>
 <CAHS8izM1H-wjNUepcmFzWvpUuTZvt89_Oba=KaDpeReuMURvQw@mail.gmail.com>
In-Reply-To: <CAHS8izM1H-wjNUepcmFzWvpUuTZvt89_Oba=KaDpeReuMURvQw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 04:33:38 +0900
Message-ID: <CAMArcTX0sD9T2qhoKEswVp3CNVjOchZyEqypBcjMNtQRHBfk5w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:25=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > The tcp-data-split-thresh option configures the threshold value of
> > the tcp-data-split.
> > If a received packet size is larger than this threshold value, a packet
> > will be split into header and payload.
>
> Why do you need this? devmem TCP will always not work with unsplit
> packets. Seems like you always want to set thresh to 0 to support
> something like devmem TCP.
>
> Why would the user ever want to configure this? I can't think of a
> scenario where the user wouldn't want packets under X bytes to be
> unsplit.

I totally understand what you mean,
Yes, tcp-data-split is zerocopy friendly option but as far as I know,
this option is not only for the zerocopy usecase.
So, If users enable tcp-data-split, they would assume threshold is 0.
But there are already NICs that have been supporting tcp-data-split
enabled by default.
bnxt_en's default value is 256bytes.
If we just assume the tcp-data-split-threshold to 0 for all cases,
it would change the default behavior of bnxt_en driver(maybe other drivers =
too)
for the not zerocopy case.
Jakub pointed out the generic case, not only for zerocopy usecase
in the v1 and I agree with that opinion.
https://lore.kernel.org/netdev/20240906183844.2e8226f3@kernel.org/

