Return-Path: <netdev+bounces-186508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C94A9F7D4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72753A8FBF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452E293B42;
	Mon, 28 Apr 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgZt/YWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACF2918FC
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863158; cv=none; b=cPDNRELJVIR0GbIAKenahf+DZ2UqfxY9dkS5bBsiYtkIIBO5vtjADU4FJv8ynWCES/CgiStriAvHNlVxnfGBnqJm8TK0HzDzyMQD5E+u+U1yWnyd8rWRpRrOixeqfkA5arYh2xPW1FjibNrqeOZYvIy1wFnD0iFGwmofCq1QE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863158; c=relaxed/simple;
	bh=8XQloBjNW6kGOgUTHllRnQ3Os2H8JGYzqA69hBV1oAU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qWh/+qmgZ8reHSKSdmyJ++TemoufM4+pvv/x+w6eaOKtVgRzgT+Blo+L8ZVnkk63NO16+tbDnU5PQP7Qc2COUiPTooQnlY6ZEikYVCFCuJqsXoFEA9u7s1oakRv256FTi2babEESQEaLOmQo/40zp2z9ytnZ6boyO7cD45GoCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgZt/YWm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5e39d1db2so310901885a.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745863155; x=1746467955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koV/ztuR6fY0sdOFLJ9tMsuoo3OBjAbkAzcAPSgS3+o=;
        b=bgZt/YWmUrdBYPONHy0DSuZ73k/9/skHVEFI33I8NswCX0jGqBlTObVOeRWHWZ99Yx
         uQ2+RAiiqnLD+lKfrx5P19Xt3kI8lthx0bdkTDi/1DXy9V5cCuL4ESL7dHk8yL113ELk
         SMu+tTB7elbfVSiCH7K6yqflPlFAAyd9uHa/k5Jj7LESVdn+MAQzFAUKvKQAUzZXPufi
         TqzRl9xI58W985BZ8P/Zm9AWF8sJLTWZKM50f88L0x29OanXYu3XOh2G2Z67P+bue3Rl
         nodVt2DUT448Q0ajgVy5WgE+BWnOBi2HRrdkaSgyxJeJQsfiBDoIzDwom43/f+IgTYnH
         kaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863155; x=1746467955;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=koV/ztuR6fY0sdOFLJ9tMsuoo3OBjAbkAzcAPSgS3+o=;
        b=Ce5DFGLRNKDDntaaVL0jx8OqeU41Fm57J9la+2VRIGxt/L0S/Rb2CVx6aZWOXk8781
         r/QlEQp2oPP/kgjtbops1L2o++0zIw6BXb+Ix+tYNDlELRVzERpK9bhVhKr995O30aFG
         ireXnIoepglSlkH2RH4+PjeYSumYvzdYWBiw0JSikC+Keho21LQW4tUMbuWmeQwL+XBp
         D/qLjbOkCtZLlQHjov+gFVBQlehvuy8OqTeosUu/7y3E1Zn3qGqIgAGP9h47Il7UxquV
         lXW73Ne6Sr7fEIv0RpetPMj05lREy1z0AvnPNHr5orWaqay/Mb9XouftS7YekKGaub+t
         d7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWkoxZQNs85Zw8WmrYZmHFhsVUxmwqgSqvxaC+4arGbovEgl35wZEMDwOKQCyViMDpBIl8JZjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/2HO9kKrw5Uvu9RKd4L82y7EqKuiltAQzZ56DDzO2XaLIFfz
	HrJB3p14DTwj9iqQKU5+4kGko1S9GeMqnY8Y8wTSYWCNyTkO2m9Z
X-Gm-Gg: ASbGncu0KgZ7ukam3yTZM2DoqaN0tP40z+KYZwOvOOcAl+TajxlF2+Em6AKtmwrDII/
	dOZPZqCWNMOGD5Ukq/Kx5iLJVuGpQ+klNpU93AnyNTKNJfT+Vj8cxTHIhkiB/E3roir94+SLwWf
	LyrorTAVH2m3MfgDbq7YQzE8aqGkwoaaPe6Jk2xlbKdaGHkaW1Sc3DlJxtMjrfLZ/DzSpu+zIKZ
	U3uI9Vv0+tXnx8KgMrbUfApKy5DDp7EqQHjp24JefAqMkAsKRg3UbaId9CZGNJXDzG7NzyFq91N
	nyK0uAh6+wwK4WaMCYmpUdHrdUylB7mx6kV+BE7U2/wPwUQ+OuniA11HgAN02t2+fp2sOIqA1zj
	g9umGkEmUWgLLl/D4u7+R
X-Google-Smtp-Source: AGHT+IF6yTofFQqNJRjHu8yN+LXcR9pRfUpjpCDneOZ5MV9lxSW2gVSZvP5TxTnx3hgGA6LubKeMmQ==
X-Received: by 2002:a05:620a:2695:b0:7c5:e2a0:4e64 with SMTP id af79cd13be357-7cabddd7e4cmr111533285a.51.1745863154894;
        Mon, 28 Apr 2025 10:59:14 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958e7bdfesm651601485a.75.2025.04.28.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:59:14 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:59:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com, 
 netdev@vger.kernel.org
Message-ID: <680fc1f210fdf_246a60294b2@willemb.c.googlers.com.notmuch>
In-Reply-To: <aA-9aEokobuckLtV@LQ3V64L9R2>
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
 <aA-9aEokobuckLtV@LQ3V64L9R2>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> On Mon, Apr 28, 2025 at 12:52:11PM -0400, Willem de Bruijn wrote:
> > Martin Karsten wrote:
> > > On 2025-04-24 16:02, Samiullah Khawaja wrote:
> 
> > Ack on documentation of the pros/cons.
> 
> In my mind this includes documenting CPU usage which I know is
> considered as "non-goal" of this series. It can be a "non-goal" but
> it is still very relevant to the conversation and documentation.
> 
> > There is also a functional argument for this feature. It brings
> > parity with userspace network stacks like DPDK and Google's SNAP [1].
> > These also run packet (and L4+) network processing on dedicated cores,
> > and by default do so in polling mode. An XDP plane currently lacks
> > this well understood configuration. This brings it closer to parity.
> 
> It would be good if this could also be included in the cover letter,
> I think, possibly with example use cases.
> 
> > Users of such advanced environments can be expected to be well
> > familiar with the cost of polling. The cost/benefit can be debated
> > and benchmarked for individual applications. But there clearly are
> > active uses for polling, so I think it should be an operating system
> > facility.
> 
> You mention users of advanced environments, but I think it's
> important to consider the average user who is not necessarily a
> kernel programmer.
> 
> Will that user understand that not all apps support this? Or will
> they think that they can simply run a few YNL commands burning CPUs at
> 100% for apps that don't even support this thinking they are making
> their networking faster?

Busy polling can already be configured through sysfs.

I have not seen any conversations where this is suggested to non
expert users. I don't think this will be different.

But we can and should definitely increase the confidence by making
sure that any documentation of the feature contains a clear warning to
the impact and that this is for expert users only.

> I think providing a mechanism to burn CPU cores at 100% CPU by
> enabling threaded busy poll has serious consequences on power
> consumption, cooling requirements, and, errr, earth. I don't think
> it's a decision to be taken lightly.

Good point.

