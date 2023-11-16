Return-Path: <netdev+bounces-48468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9B7EE705
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82552B20A42
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6D2F867;
	Thu, 16 Nov 2023 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="H4F1RtD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F43181
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:49:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28028f92709so880576a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700160567; x=1700765367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urvivr0fPc84guU1XkEI763suIRSjRSre6ksUlL1zTA=;
        b=H4F1RtD4nWCPr0EYfcCknve0n5rFZGkwUBT2lPQztrNVAY/rs71UHyqiD5uSqJYFni
         iyq/nb276j7NwWbekd1Qpg+wfM8/c8YG2zuyn4kbGNxSY3x6X49ng6vkz29+DatPPnBK
         ed1QLpfoYw+PTfWg7gkH/vh8BtxyOSwY7htvVgtdkyELhL1OnxjdX7hxZ1d2Ls7yQDKI
         XebEeE9W79pwVAbP/Rm+rLMeaXMRYWilrN2UcD8so7FhsaAx/djJDaWL2mmXwJ2Mo7kq
         qF5ZuXscKCuQJy7HtXMZoK9WKS9FlIHaCJIcFaJiF9iTUQfUwZLALL1o2jtrJN5p5NnA
         bcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160567; x=1700765367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urvivr0fPc84guU1XkEI763suIRSjRSre6ksUlL1zTA=;
        b=rx3uh3UWzEyr+P4lebPy5H6iGtyIYXP63tdzIpzsaFS3KfiL1vasKYVWstOfWLRhe9
         KqlFGSf3UH1qAja3ltfkc7YlIgk5oxuGz1wZ2NHu3IH4rBwK9HJ7Z7K2FYuWKMIxlal6
         6QdfB26xo2FaYwF8DS9Ce3egCJuQNmPpFj0IQzUof3CcyKmLxFfxehsZspn4W76tv24X
         vxPffQWTDC6xf2UjEfjDlSFc5LrEeVLFBv4ZMLKDlc87cSsbyCxY78kBROgD5ikdBoqV
         szSz38ReRp2E6rFmglmGHPX2prGjYf30zwcFp0JuvnF1ytcih2yazww8TsbrBnsT5R+x
         vZfg==
X-Gm-Message-State: AOJu0YzpbssrWoVgWFmqPJo7lkHwDmtTh95w/DIA5SErUCc/wncqGdab
	Ts7z4ZFY0qitH2SRHLmRQyCRZgCAl0BAX0Dj9zVJsA==
X-Google-Smtp-Source: AGHT+IG5zw/2BBhLvBgD+bn/3yV+0N8vLNS/4+Fj4saBGhd7Qv7YeVIeSao5wSlEnVUxIQCXAQ7k9g==
X-Received: by 2002:a17:90b:19c3:b0:280:963d:9cb with SMTP id nm3-20020a17090b19c300b00280963d09cbmr3596533pjb.23.1700160566837;
        Thu, 16 Nov 2023 10:49:26 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id u17-20020a632351000000b0056606274e54sm31657pgm.31.2023.11.16.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:49:26 -0800 (PST)
Date: Thu, 16 Nov 2023 10:49:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, bjorn@mork.no
Subject: Re: [RFC] usbnet: assign unique random MAC
Message-ID: <20231116104925.302865a8@hermes.local>
In-Reply-To: <20231116123033.26035-1-oneukum@suse.com>
References: <20231116123033.26035-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 13:30:24 +0100
Oliver Neukum <oneukum@suse.com> wrote:

>  module_exit(usbnet_exit);
>  
> +module_param(legacymac, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(legacymac, "Use a legacy style common MAC if device need a random MAC");
>  MODULE_AUTHOR("David Brownell");

Module params are bad idea, just do the right thing.

