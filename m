Return-Path: <netdev+bounces-119381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60369555B1
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BA71F226F4
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11730823DD;
	Sat, 17 Aug 2024 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKE2zxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BAA23;
	Sat, 17 Aug 2024 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874624; cv=none; b=r7AOa2f9yUBmd0IBssoL2U8wTEFllE8AEVosdf/RZSAqET2dXr3uV/d1Jw5Fddi93nm9NoyHuUw2NBCplOzQVghNh6IAU2nTFsSS344vTDR1C4XNrdmRjgigRieATVLygtQdTG5z197lA5K08fTCcNDQk5gxti5rHD0/9cgARLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874624; c=relaxed/simple;
	bh=n5RoqCHz8Fs7MxHDbbIHIszOtloFIBq5gvNnAjrd1mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaNxzsV7mV0v2SSwYrasaLO+B6o6QTO/3m8J2LDpnpjVNLYvPI36mxT/2yy0b76zpYVKpdwwqkFmEbOAlejPYnz2U1V21Dd6Lx7e/ePnaBWwWbXIC/F9bES9rU/EzjcQD4GzfIgCFbHMXo0KPkYxfIfi6IXP3+Pps8C8pRi2OeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktKE2zxp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b45d23a2daso5100307b3.3;
        Fri, 16 Aug 2024 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723874621; x=1724479421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5RoqCHz8Fs7MxHDbbIHIszOtloFIBq5gvNnAjrd1mA=;
        b=ktKE2zxptceEh9Cb2/GiJDJsKMlP3KrLvdkcbWqN/NhnFtF1Gmucl2Hoko17QjsJ7O
         f/T8KNaTWWPQaGNRE9QT+GXQqkUqUM7dzHv7a9chk7iMVnRvZtbZwXaGaQggi0fIDCy3
         g5OGzYvKaZbPU6rIFcHwYNfvDVlruuYuFhnZreoGckSMv7aNoopqQNv+kKIShwbjWA4G
         lBDpms0/oZpAqPoGD3C40tG2XbRiHjb96atTDAtVgok6H6H4k2B9OjpG3gCNvliy7uOb
         JGpPanfQMMA7z7n5j4axOz10uvgYBQC06k63b8cKinxsMbx7xBre8d70RzmdlyYnzCPh
         Qlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723874621; x=1724479421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5RoqCHz8Fs7MxHDbbIHIszOtloFIBq5gvNnAjrd1mA=;
        b=NxuS5ux7hqgPrrm+WJgXkru6k8lWAi2WlHWD9Te74wwrGwbUshCOz7MI/jVZCzft7t
         0ZdnlnjEYVA055nDNLXp0OfvwIdpEFyJFsdkRZEy22zHO3/1o1KuzQ8ZuYZGbw5Z1iSi
         E+YkBmhy38jfKVq08jVrWJQdUV9pgdTvR3lSB3/ZfEQe+/kwGhvRhuYcLfDvI1PEAgg2
         KAf/PUgA99KqJ3EVRxODkjEnByFbQJfRGGIiSMbkCvsOxTU+FphbFVgD8/3MTX9J8Fw4
         Td1d2YhJcqhxLi0+X2ndhbhIwhN9JcAqT2uGhFZQHKQvKYgn0vNXQHJ3ghtFnwGw0sYI
         ItSA==
X-Forwarded-Encrypted: i=1; AJvYcCULgt8rdFHrs6LaD9XUf8SHS9/xe29gJH9cXnDazgDDrLtvI8mns7tRG0WNK8UsXdVHWJYvTiKF5xUoo3PN89gsmb4BKnN7If2WCngjjAl1Mg1vWfjqcL2rS1WpVA1jV2lSuyrB
X-Gm-Message-State: AOJu0Yxa71Qa7RqQ7Qt4p5Tkib27zPbMwnMmOcTr16rk2hTwmWkewIsv
	/DuAmLfOYjtPG8aNoYQF39yzPES+u4dlg5WKjxlfZFL7FuCabzEMJNTi5SXU+OMbfFOvLKEaaXM
	SQ/+zeFt8P4hqT7yHRQ7zI0pbm8g=
X-Google-Smtp-Source: AGHT+IEFyr9BosvZSf4z5mKNw/9nsaZ7kO1DgNlrSsOrwUpHub5eMmziNC/pLFKsDEGgooI0Y5V5eBK/Qj1DN796K3s=
X-Received: by 2002:a05:690c:388:b0:64b:52e8:4ae3 with SMTP id
 00721157ae682-6b1b9b5adfcmr62799457b3.3.1723874621320; Fri, 16 Aug 2024
 23:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816103822.2091922-1-bbhushan2@marvell.com> <20240816190349.22632130@kernel.org>
In-Reply-To: <20240816190349.22632130@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Sat, 17 Aug 2024 11:33:29 +0530
Message-ID: <CAAeCc_=C96vKw+Nta-62iQjc-yz-ZJdXvy3WtSByrOb8_A5Fog@mail.gmail.com>
Subject: Re: [net PATCH] octeontx2-af: Fix CPT AF register offset calculation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 7:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 16 Aug 2024 16:08:22 +0530 Bharat Bhushan wrote:
> > Subject: [net PATCH] octeontx2-af: Fix CPT AF register offset calculati=
on
>
> There should be a v2 or repost marking in the subject tag,
> and a link to previous version under the ---
>
> So that everyone can easily check that you ignored my question
> and haven't even applied the spelling fixes I suggested.

My mistake, somehow missed your email.
Will address your comment and send the v2 version.

Thanks
-Bharat

> --
> pw-bot: cr

