Return-Path: <netdev+bounces-202681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072DAEE987
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DDC1755B0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F71242D82;
	Mon, 30 Jun 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajJjtZM/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B71FFC55
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319734; cv=none; b=nAiHZ3yV+cyokK1I1lI34dFwKphU/0hxKggC/W9SSvxNLxT440FnNtFzGrIYae9Tw3HW6Q+RpHPmwPjAsiYRMK3KTfYB5tq9bPVvBDCapljnIVAWnB++qNc9qUmQcsUTLEkblGVAYPhDDNobn3bzW8w9xkYMjDGGwjHSUQ2ZUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319734; c=relaxed/simple;
	bh=IWNEkCgzfnPA4/ohbGdYgcwSLK+Xw0Mg3GdnhoX/hDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCG36CN0y4qCXyXrY+ZvS+H8GXqTabnpsCi4Cpi7/BZ2FzxPe3l+yiu/iFGvxu5RqJB+ae5plY/DsoNK15w/eIa0V4e0uFQCwjFYfFslrTW6AtsIPu9SYXgiXxCF/BEOZxKkCeBuvOziKTlpqrx/+43JbKrHYMHmPUwyUxlIpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajJjtZM/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34ab678931so4225689a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319732; x=1751924532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWNEkCgzfnPA4/ohbGdYgcwSLK+Xw0Mg3GdnhoX/hDI=;
        b=ajJjtZM/ZU9Xam56sj0lp7ilIMlKF20oR7c6HD72vIWTa4Wp8Bivq3YjI1o1xf4sYr
         saoGYmGujG+oc2ZQRCEntt6b7n7lXpkV5IdJFCOrQJRabv9wsyXzEv7on8NP0r2Fx90y
         J/UnQRr0ov9lHH5UVKv4LUigSYC0/KoUMoNBoAWo1C17DkQs+S6JwSbEgQk0ZboGyOPj
         toGlqD9rGd45jlTJnT8+L5aCZl2deYPrYtUzhIXVdluGu+EfxJsJz9EwwyOy/xWzmaY/
         OmRgUgsQwwj7/ex5Tzkpa0CPngCIeDAKIvj2e1NO1pdqtKZcgSNu/77VS+6/o2m8xAjv
         I5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319732; x=1751924532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWNEkCgzfnPA4/ohbGdYgcwSLK+Xw0Mg3GdnhoX/hDI=;
        b=ZCgoQ342qC9tkdAeQsmLEzW/4ZQAKY3UJICrNhZWRt6568aWkfmubmtG0rV+jonSnY
         5VcYWDBX82oC4V9+rXgnCcZ2AuH1kYSyUlehrgxDI8NrKvafARrh7cz8vRQ/9DObJnyp
         C/MpnVERsyC6yUA5brSaYx2sfzAXajFv9FstkOzqUSrUpdw5hcMLUkdhNOUnkWq8lmwA
         muWajYMs91j7O375bDZJQ58hhv0od6yMEErNiW3eZYMlkne+UlNTVujiEPW5a3a07yrY
         bVTA3kAB5ZLf1s/vX9RNYyoHib1We+tneiGaqB86qHVhezgZXurMfJcj5ts/o4kXfGmO
         2H+A==
X-Forwarded-Encrypted: i=1; AJvYcCXZa6iWO+2orBp45KDP4LOpoZ/Tc+KaNthqyhsNFiRuszDAjpxTF+usURP/44O31iH0eTdwUVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPBhUnp7EMeQ3NwEet824GwtRvlY8SDmheDe3IDTZkZTT+qGH
	9ZBGE+WpJlvVNh7EaUW5+tvWMmlclcGCZvVGMTx/MJYTFoEiZDogrMqt8Qd2BQ==
X-Gm-Gg: ASbGncsxELg//fJI6i+lnplzR+tIxsxgYyD2q5dBydJatXn3QB518VBZit+SGSISNpH
	MQmWrSVUd8kgV6iJSs4JvsL1kcHpfn4ef+gi/yN+uazbYflliJZbk9qzQJHbfZSO6rGef7WXTsh
	mfjq19fSrnoNWSbS+7+e1IINwtdk3dyfgNn9D8TvTUCRK2A6P3kwdy9yHeYGo+CQpwRIgn/PDdX
	vlui4/SnJuHvR8BkB/tIi/+sBLosy7ABcD69BpWWDHW6+CoImhKPWem3XotUgiJy0Hy52nptziz
	zpOua9t6wA2m74yWlYjrlsSsErqRm5uVZgcek3kcQJOCGxCbpxLXdGmH71ERrR1l9vm1f9WlzaR
	r
X-Google-Smtp-Source: AGHT+IEjlLzYAko2OL+hCIuTjfI7YE6ht8z9Ng3E5X0xe58W497r8q6cGLvL6RVf8aNtVbMJnCRAKQ==
X-Received: by 2002:a17:90b:1dcf:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-318c92e3157mr18892071a91.26.1751319732032;
        Mon, 30 Jun 2025 14:42:12 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a16d4sm9799433a91.11.2025.06.30.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:42:11 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:42:10 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Lion Ackermann <nnamrec@gmail.com>,
	netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Mingi Cho <mincho@theori.io>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
Message-ID: <aGMEsnYnv0lwBTcl@pop-os.localdomain>
References: <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
 <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
 <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
 <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>
 <442716ca-ae2e-4fac-8a01-ced3562fd588@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442716ca-ae2e-4fac-8a01-ced3562fd588@mojatatu.com>

On Mon, Jun 30, 2025 at 02:52:19PM -0300, Victor Nogueira wrote:
> Lion, I attached a patch to this email that edits Cong's original tdc test
> case to account for your reproducer. Please resend your patch with it (after
> the 24 hour wait period).

Or send it as a follow up patch? I am fine either way, since we don't
backport selftests, this is not a big deal.

Thanks for improving the selftest!

