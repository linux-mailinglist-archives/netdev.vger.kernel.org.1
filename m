Return-Path: <netdev+bounces-97685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189F8CCB53
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136FC1F21B0C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9E770F1;
	Thu, 23 May 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/1g6jTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AF273FD
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437884; cv=none; b=mi3We9ku5zXZC7o2eTiP06EqD+J8PPBadF8s4BeIn/WR07n5tW0zPSygJWiCdk7HmuIC198ulxUFl+qMpVGymWD6K8mEUVy1JGMf4iA/f6h0/LAudiaYlKOgMLpGUO2Rmm01naCXe1g7h0e+aDvKDPBWrfElBFvy5zTM0HPz5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437884; c=relaxed/simple;
	bh=GbFSOG9GIAlbCFwXl3iK2a2xIn0SGwFHqJmyiZfbwpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9HPQZ667A+8YX1xz4LxBoX6ZqUYVY8aOGBUtyFpZNNQdXim1+9hFryCdNaCP1T7phD2poPjG2OxBlVsiF9WJEgo+QJenhp+AXz4lq8bazZ8ybKyt5GV1LK5UXBEUkSSko7l5VxQlQPGN3++/WQ9hWZ6ZUW3/rWDLHjKMsQRY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/1g6jTV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62036051972so61857107b3.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716437881; x=1717042681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=T/1g6jTVCCRt6ouxIhQs9dEpbf9g1f2gk+S68EarS4RXXoZOiNg+AGPM4tRd6Ulw1S
         /RN630nDTA1wAXBHaodeBKnW9ou8mVaD7TDFF+3Ar9yNNvLbNkIWCDfK/0zwlKx0ECZE
         esL2M1zgZ6BCihUcLDPW8tWzBJU/zA6yrXFMU3SIDb6U4OAvoe7Xp/IP8ixauf0DjmsU
         4N1LTGvhxFhxS+jjzkJ3HqJqaOFaF+KGkjD5gr1XUrxW1h1+7n7NIpql/4gJfe+37vDt
         3bW9hOJWXZTlOyGO2di/Uxp++SdBXiHIE6Art6AfSiHlywbWKjZy+gt3C5ptmEKhiqcM
         Bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437881; x=1717042681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0AowVZMPa7u6e5KLIEun2YKjWG2qpejnyGcGINzJ0c=;
        b=jzFyuG0P/M1Ap+r/7SiRPe3Rln9JMCHpDeoiSKjMCS4ppBZGBWr1f9/U9R+UVO0W2Z
         dFTdQEuvYzY7Nv4NvIzIY5HXsotcC1rA6qcrts/7QNXdu96/OGddIZe6lU/7HA9A4mVz
         vZHEgFFGhGs0Tczah9VRuuejMh/InsBCBYuU5/JKa/ZtP+g1ngJdGKSSPyucFDpCKRVH
         FSe6Hl2GTAxbmS8Iwi7lOhZbyF/+k/Q6vcX2ciF5UbFl37Jz2WPjDQW/GOTi7CcH7mnf
         NS0NNBjC7oftYFQzM0jpO5YdVx40rdUHEUvxinQfU+0qssOJGbFd92Vb7q0AXPch1XYA
         WhbA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgPXZvPInivPqUVS9U46DHVZbv87UKk/e/nZqrpYff/BTxMHx/n8LlRk1aTReY43hj7oPKPXzqcMF02O9E5jYG7wx7+hM
X-Gm-Message-State: AOJu0YwU1tVArCGv9is2MSiWwSDVPH/GyQqIka4FvnRXl9DC/QkIwKBm
	xzqom9Oxcko2FotAdTKBF4RFjzuWc2pF/pWOJaRQjmMPSg3f25TDxdNQKQfE9VXckl7W8Z7ivX7
	xg/6eYbjFLMKjHi3zeJMxqGAgfa/RsjU2/EiKjQ==
X-Google-Smtp-Source: AGHT+IECtJaV4ktOjw3xeRQOL27efpUlrVmDS3eWOWwjyesv2pFJSpT8QDS7HAip0CnL/cY7cSKZ5IEpz01Tke9lhTg=
X-Received: by 2002:a05:690c:fca:b0:61b:3484:316b with SMTP id
 00721157ae682-627e46ca8a9mr52170097b3.14.1716437881214; Wed, 22 May 2024
 21:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
 <20240514070033.5795-1-jtornosm@redhat.com> <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
In-Reply-To: <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 23 May 2024 12:17:50 +0800
Message-ID: <CAMSo37XsdqWZUd3ih+zSaMf7U5hSJ1=-4U2SLUwU7Qaru+J9zQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Tue, 14 May 2024 at 17:14, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi Jose
> On Tue, 14 May 2024 at 09:00, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello Yongqin,
> >
> > I could not get a lot of information from the logs, but at least I
> > identified the device.
> > Anyway, I found the issue and the solution is being applied:
> > https://lore.kernel.org/netdev/171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org/
> Ah, I was not aware of it:(
>
Sorry, I was in a trip last week, and not able to test it,

But the patch does not help for my case, here is the output on the
serial console side
after I cherry picked the above patch you shared with me.

Could you please help to check more?


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

