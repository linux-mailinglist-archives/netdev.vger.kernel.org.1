Return-Path: <netdev+bounces-164874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CABA2F86F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BF83A37F6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027C11ACED2;
	Mon, 10 Feb 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PX024xPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025518D63E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215222; cv=none; b=b9BWfauHxk/QWCD/XYLKX2WfIgU6ZrrcMuNI6pdXAbmGVW44vseOyoidFvA36eam/7Eg7yzRHsAXGquRU3E0Hls27ncIW6bbtUJe4ROiXooH7gNnXGqlkDihgatxvxvWIXgyk6tjrTc12a+FrXds7dODu585qPfdXUBxOxCFoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215222; c=relaxed/simple;
	bh=txuwCg9+EtMdaj7gcA8svScMH7UOQ2m8Vzg1iX4Ctlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O38rpR+00rCEG/IA1FqhrG40weWYU+AWxVqH63xm9r6Oru/PgtTjZx49tSN6YqT4xIhrg9wJERS/nrEK37sPgZHAngWj+ZOs++SMBYZeLO0577ZStbn6XY2NomQyC+acnlQFqxrARzN3KfGZM1frf7U4nvQ3XY0l3vlj0971Ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PX024xPf; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=txuwCg9+EtMdaj7gcA8svScMH7UOQ2m8Vzg1iX4Ctlk=; t=1739215221; x=1740079221; 
	b=PX024xPfHIaeiFHYLilyrvVpeuIIkhDRibU2xAs/zeQ6stWHFWUWDgT5z7MbhseLy/FnpBL/N8t
	U38e6dE58fZt9/FSL5Mi0WtM+XOhYakZd7Jv/YDCi6yJmA/3qcjZfqisq5zXf75AbSqA8uxpD/Tf3
	tpaMdnRu8OVcL4tPNzKT7dLNY1aPhOygxFg0JCRi0I1RG4KTj5/9O07d4yUpYSFzr5A8mV/2oTc+J
	RK/mq02Kqw9PJ+/uwvktXXoA5NJh1+7vf9Sf2pybJCq6Ix+QaFwf9KjDC9bkWwtjfQHZQkTFnkvBM
	KDIdT96XcuQLgPMaeLYalZSYvgMrExqCzsfw==;
Received: from mail-oa1-f41.google.com ([209.85.160.41]:51493)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1thZKI-0005BS-3q
	for netdev@vger.kernel.org; Mon, 10 Feb 2025 11:20:14 -0800
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b86cf023b9so542641fac.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:14 -0800 (PST)
X-Gm-Message-State: AOJu0YwHU3QhhFImZxJsjp+cPCAkYCYTkHS0Ag+Ko2DZBBxIn2ipXHew
	aTCSbCaHLzoHWqh4krzwNy3f6lTIOIvbWK6VriVp6vbgQm+v85GcYfdYStx1o+fcNAGZ5W3TTep
	DREt0dgD+d4McECVwPyABTfzFR50=
X-Google-Smtp-Source: AGHT+IH+JYCQalGb/Vf9+P+qs16Bwy4zksqLBvKGLWarzxXwo+pCSXh6AlR+JOnquzj3/XOQOlRKZPt8AvyHOtCvmUY=
X-Received: by 2002:a05:6870:a68a:b0:296:c3cf:39ed with SMTP id
 586e51a60fabf-2b83ef3a4a1mr9428058fac.38.1739215213537; Mon, 10 Feb 2025
 11:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <637049f6-f490-445b-8493-218b68d438a3@redhat.com>
In-Reply-To: <637049f6-f490-445b-8493-218b68d438a3@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 10 Feb 2025 11:19:36 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxHZ=uA1F5Sxd1VofoadUve+iaA3BS+C0_qHY=0yBLR8w@mail.gmail.com>
X-Gm-Features: AWEUYZkQjL5SIzn-EVsKfhJOfoRheOEThV1KwCjh-6DyciddAnD3w1y5qsOnNE4
Message-ID: <CAGXJAmxHZ=uA1F5Sxd1VofoadUve+iaA3BS+C0_qHY=0yBLR8w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] Begin upstreaming Homa transport protocol
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 764eb63bb4c91aa8ddbf2de6f9e489d2

On Fri, Jan 24, 2025 at 12:55=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> I haven't completed reviewing the current iteration yet, but with the
> amount of code inspected at this point, the series looks quite far from
> a mergeable status.
>
> Before the next iteration, I strongly advice to review (and possibly
> rethink) completely the locking schema, especially the RCU usage, to
> implement rcvbuf and sendbuf accounting (and possibly even memory
> accounting), to reorganize the code for better reviewability (the code
> in each patch should refer/use only the code current and previous
> patches), to use more the existing kernel API and constructs and to test
> the code with all the kernel/configs/debug.config knobs enabled.
>
> Unless a patch is new or completely rewritten from scratch, it would be
> helpful to add per patch changelog, after the SoB tag and a '---' separat=
or.

I should be able to take care of all these things in the next revision.

-John-

