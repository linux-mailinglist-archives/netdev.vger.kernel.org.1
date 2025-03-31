Return-Path: <netdev+bounces-178373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA90A76C81
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDD3A4C6E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43787215779;
	Mon, 31 Mar 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai5xtqrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF911E0E13
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441850; cv=none; b=JaSsO5xWV+/Q7uPqHkhT8x63JQSYYUd9goPwIpf0sNCcuEsQVuRFQ4atbW3M0ne4CCo2BFYlP4uQHksHXQrFlL1yjeG7yCDWzKS7rSAS7hn3AWkL8mxzy4EynOiG0XR4wUNhnfE+KnEUj+8XMWntfC9gO+C4tEWq8Xq7GHnWVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441850; c=relaxed/simple;
	bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re9HmpqCUD8ycOStCSkYc9qkJzP9r8XwRLBbIMOY0aEhGsB8YjcSI70CRgG2t7ApeuHsrx0T2QxvNMdvwqAYnNpwbZFD9bmpH1Lnt4VcWG4coUPQLaobDadSGL+R3ahoCgolyjQBVBjW9TSJSSNmDFXl24Gryyb9fcHAwY8nZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai5xtqrp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so758a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743441847; x=1744046647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
        b=Ai5xtqrpvoO4SlNfx07jgUjeRE2mj1HyLpD+MEvYZPvyR2G12700iCpH3TkhszqO/r
         aB2Xeb7tXEWprPBuxV2AoCiukGMxxkhsnraf1ZSeItQcu+MfJbLyz92HqwbTONe/cZvJ
         3h0++YNrJqm5Vo15vr9W2ihKzFLrISAvvkcBRajnOwzG8harVRzG+f1i2mdcjQjOEh71
         aa2yI7pWrVeMaUUztdchneA3Uq3eAgbHmJ3H402QBTGwhAQ1/g40Ni1JXy3nA77nyt7f
         Luu0TvUSlqzhLPFRsyBRmRN0VsiZTqijLbnDX0LELLcjkr/uNkiwSmVFaoOtsDWdeeCx
         8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441847; x=1744046647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
        b=CWkkl98Joqtp6MVTHdEiwV2s6qI9vmoHeaot8yPr31ER54lcUwVQtJrgorSE21i1U/
         RRtj+pAfxl6xtgpgZFfeqYDKO+3pkn9GiQSPDfoc4giGp8N04+OBIldceAAeGxynoGlg
         ICe+R7IyLyIke97DP4T1xaUt+XDyvMzoS1plsWTL9avgqc59CWKCB0HPjXTphBiO0ms9
         Zq+F4Cw9auQc+nBC9zySJQPXgKN5BHjvdB4GpEwnut31pVlSwE6HR9c39b1xsyz8jET2
         UUAZ359nQkb7nLMhvck+ip0J4gyBbGC3NRWHuSK3zmbtqZLh7DeLFKEloKmd/MWKK0PE
         S/vQ==
X-Gm-Message-State: AOJu0Yzyx1tv4Nd5WDybr+EHorVmAXzuotIIToAw/unH4HfpJiM+Np2L
	/7S+mhraeC2U8ANF2WYFeNd30BstXcF39BcnleSOzAOsmOgLd1WbBO4W25JpT7WUwI+uB/kZ1i/
	njIBbIhK7T1534IOHwrfCJnJe8F6V1/G0IBCu
X-Gm-Gg: ASbGncvlUoPW/xe+eUO8m6GfA0N04WmPcPVPwP1AoH1WVLTO3vRA5Z5EPW+vh6Ddsrt
	QFvMFBcb7UBPvcVm9ZE4d8SEOI1WmmcsfdmMNlyS+8vS8cl0GzA9Tnq1h36dDeoy+Xi4onEZNHm
	q6i/a0hycI9kbhGe7u1w8lHvccWVk8X6BXGk2I4yiKTfh39O/5CFsrEKAq
X-Google-Smtp-Source: AGHT+IFjTI59BaJajEc5ccgjAXvUPEzUCirJRo23YH1ZZLukyXLcwiUrYC4BjQgy532ChoCjsesclV1MU2XmTpa0yIo=
X-Received: by 2002:a50:d502:0:b0:5e0:eaa6:a2b0 with SMTP id
 4fb4d7f45d1cf-5ee0fece9c5mr175711a12.5.1743441846677; Mon, 31 Mar 2025
 10:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com> <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
In-Reply-To: <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 31 Mar 2025 10:23:54 -0700
X-Gm-Features: AQ5f1Jru1XjUqIvO75Y0EPqiJXWlRp-Yb00PrXQaO1TDe3j-jYrtYqDwh-0Nv3Y
Message-ID: <CADKFtnT+c2XY96NCTCf7qpptq3PKNrkedQt68+-gvD9LK-tBVQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

> It is a very corner case.
>
> I guess it can with GFP_ATOMIC. I just didn't think it was needed considering
> the key of the hash is addresses+ports. If we have many socks collided on the
> same addresses+ports bucket, that would be a better hashtable problem to solve
> first.

I see, thanks for explaining.

> We can also consider if the same sk batch array can be reused to store cookies
> during stop(). If the array can reuse, it would be nice but not a blocker imo.

> In term of slowness, the worst will be all the previous stored cookies cannot be
> found in the updated bucket? Not sure how often a socket is gone and how often
> there is a very large bucket (as mentioned at the hashtable's key earlier), so
> should not be an issue for iteration use case? I guess it may need some rough
> PoC code to judge if it is feasible.

I like the idea of reusing the sk batch array. Maybe create a union
batch_item containing struct sock * and __u64. I'll explore this
direction a bit and see if I can come up with a small PoC. Lots of
array scanning could be slow, but since changes to a bucket should be
rare, one optimization could be to only compare to the saved socket
cookies if the bucket has changed since it was last seen. I think
saving and checking the head, tail, and size of the bucket's linked
list should be sufficient for this?

-Jordan

