Return-Path: <netdev+bounces-81253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA50886C0A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8101C21129
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052843F9FE;
	Fri, 22 Mar 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKpJjzER"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332A446A0
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110463; cv=none; b=KnhEDgSgikHiJYpy+HN0R/BBaj+KLYYVg/Gz5vebjau7ZIWiYoy+gh5mn9VsZuIZS6KP5Wfxl5hwqegdp8GelAlvs+aGIiQz5nSUdq0HtVaznHJV/l7TSE110RQYOJl9mRRsSd6s4hoH3GTabRsxEiTvIr3OsF2luXQ/KZnlQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110463; c=relaxed/simple;
	bh=8hpQr/+lhckiXMwRaCUxRYTJR8kJ9fXUj4z0koFgqiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6xoP+LYEQMz6nKmcfodydh5xKP+Rtgx0QN677t9VvS5htGcEshtFi3xmhGwFkTtMflciUNa3CGQXyJwj98LOco483sllDrn/zHDmC7E1HLzYzAl1bhnLH5HrJyjGlrXBha4GaaVXzadRBR1x5fZg8PuhmoTkO+n6wYZ9cdqRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKpJjzER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711110461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeFbg/s58ZManW8gpt0hpReCGZ3/I4I/IZ7b4hoNET8=;
	b=ZKpJjzEREIV48gsVgDKZM6RKNI59kk6sYBNNI4F+/acRDlCKOzYcm+HOFr/cQV5Fb5ZTGw
	W1XeA/AUnBzbRjXA/Cjln7B5C976VDrxNqpId+kmcELv/4SCDTNSmb12UayQDeLuujyzQ+
	33VQ/RmO+eZzxf/H6rSHgdSzxtnL8w0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-l6QlrkJqPUaiBQWXetqoHw-1; Fri, 22 Mar 2024 08:27:37 -0400
X-MC-Unique: l6QlrkJqPUaiBQWXetqoHw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ec6c43a9cso1535800f8f.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110456; x=1711715256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeFbg/s58ZManW8gpt0hpReCGZ3/I4I/IZ7b4hoNET8=;
        b=ev96PoH1RTymPzsoEaPtpt9PjAvSWJY6BuMkbsJojQmnMg4F1iYzdYzcFxknEDtnkx
         GE1f5Q+U0JPMQ3JaHJ54qNegfNYHdRF/yARm5EXC0FbmL3KFxVj1ipDoCL0SIQZi3VG8
         3lsW19lqAfFmFO4oX7t3ZZ20qXRYJyjEUdAr14mPltOIpV9Bdw9ti2VYc+/IXGm9Gypj
         YV1I57OlEJPjIsOcmcR64gj4tZ6SCafOenPRObqxSdxNcgXTHN8S7sgrsHw2zK+3G9tf
         rziBl9V2r8dZx0yrAWpmnObtMEyzeoqFO6yVMFfXiwPzXiTuXpY6DLe0Dqvztsjo/aQW
         o8fg==
X-Forwarded-Encrypted: i=1; AJvYcCUPWaM3BnNLzDtGFTu8CQssi7L9AnQajuJFgsgS7PqT31AE1EmvYvegM08iY/wDmrJg0BBgfi/9EcsnCEu+tp7/xXa9ln54
X-Gm-Message-State: AOJu0YwvYvF+iFNNXlviAusMR7vqrgUdlozrEtNpuri2ijidZwLUbQel
	lWUEJiCP2YQO5ebQsYpzMpQsNP7mU4YuZyJFhmTmO7++8s3u3b4gY2wS8i0D7ajlM0tDX7B+yqt
	KE7k34y1VXBMhLvoRaHJFwfV1xK7OqQxy1xpyGMH0TiBvTqV1PIk4gFgvatinUgJoJvVbaOlJ97
	w6cUZM3bXHJQhIdB03KlE4kTFlemxm
X-Received: by 2002:a5d:4b82:0:b0:341:b8ae:4cba with SMTP id b2-20020a5d4b82000000b00341b8ae4cbamr1131811wrt.21.1711110456822;
        Fri, 22 Mar 2024 05:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/ks7QxKiXfSL/B4kpT/gKJtndmagRXMAQp6PnbGq2fcKMl7CJPNz0PJ8P3EY2JZ1SG5IS+7cBGcoXJs2o1VU=
X-Received: by 2002:a5d:4b82:0:b0:341:b8ae:4cba with SMTP id
 b2-20020a5d4b82000000b00341b8ae4cbamr1131798wrt.21.1711110456554; Fri, 22 Mar
 2024 05:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322105649.1798057-1-ppandit@redhat.com> <Zf1nSa1F8Nj1oAi9@nanopsycho>
 <CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com> <Zf12B9rjjZotZ46C@nanopsycho>
In-Reply-To: <Zf12B9rjjZotZ46C@nanopsycho>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 22 Mar 2024 17:57:20 +0530
Message-ID: <CAE8KmOw0dehmK2YNtypqkt6+yLKS7WAKr3xZxNKs=PRPrYLdZw@mail.gmail.com>
Subject: Re: [PATCH] dpll: indent DPLL option type by a tab
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, netdev@vger.kernel.org, 
	Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 17:44, Jiri Pirko <jiri@resnulli.us> wrote:
> >* Last time they said not to include "Fixes" tag ->
> >https://lists.infradead.org/pipermail/linux-arm-kernel/2024-March/911714.html
>
> AFAIU and IIRC, discussed couple of times, the outcome is that Fixes
> should be included for netdev patches every time, no matter what is the
> matter of the actual fix and target tree. Please include it. For -net it
> is actually required.

* Okay.

> You should have waited 24 hours. Did you read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

* Yes, I'm reading it. I'll remember it. Sorry for this time.

Thank you for a quick review. I appreciate it.
---
  - Prasad


