Return-Path: <netdev+bounces-54752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AFA808117
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F7B20C0E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EAE13FF3;
	Thu,  7 Dec 2023 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHe///dg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6110E2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 22:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701931728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFOBgtGuzzS/PcpQyRYcdxas2wCmUyPkxn+UwmQBEoo=;
	b=fHe///dgLPTjTfTNpAPaIAQJ8t73AHRlLnxBbKDX6IWOgt08T8Czwu84QkV3vBTk8TaKnv
	OQW2b+OzMj1zMZrBXcnRapBWarSj8uEyOJanFs1mIS7ud331WEhas2jkBqXIcGX0APjBVI
	RNOaMKlexhROyXn1vfXXH1DL3AkSEOU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-pND3q3kuPKG-GTvCPLcAcg-1; Thu, 07 Dec 2023 01:48:46 -0500
X-MC-Unique: pND3q3kuPKG-GTvCPLcAcg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c77e011baso248450a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 22:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931726; x=1702536526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFOBgtGuzzS/PcpQyRYcdxas2wCmUyPkxn+UwmQBEoo=;
        b=pHeACc7NIwSBtixQi0TkfPQAJGtpwS6l5XWo1hGoAmLzN6BH5w+rPVkZSfvkt//AAH
         sLHiHXpRzLAQ2nO8ZL4WclOtygCz5ymQFrJIfRMqEzlLosytCJXWUrle/RCmSgMt84Jy
         zeKXjNGonI+a+ilC985PnoR7t3fGAYeAU5fOh3EqSvtzGU5WXp/w9cnhSWlMVhA3ugG8
         8se0S7gV3q/mycxzfw1G53AMkMpYIMom1hSf+aj0jGuZ3EhD4WajWx6/98NRGod1bIHL
         V/B7SpXtnwB13Z/KpFMfgwW633AWVVhbsPLTMBbsWTbNeQqOBJQtwpRLiTu3E/CuIJ0W
         j6Dg==
X-Gm-Message-State: AOJu0Ywlhns7yWz1QMkbqfAjzgqdfKaOy9Tyo/SdRMI88cLBvbOX1SRi
	hxDJq03Elp/n3PWyfKChoLNBcd6FNBs98nTXP6PlrUEBboSo2IcQ71gDjgfx81ATcyFphZl/Wvo
	wjwYiOM2SMAcZqDdp
X-Received: by 2002:a50:f698:0:b0:54b:2af0:dee2 with SMTP id d24-20020a50f698000000b0054b2af0dee2mr1288736edn.4.1701931725888;
        Wed, 06 Dec 2023 22:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP+ojkzLMHbSqAu0C2ANg33CShDwPxZTAJjmCw0nO8Gd6wnGRVjFY+tgfoLKlBErzzBy1nOA==
X-Received: by 2002:a50:f698:0:b0:54b:2af0:dee2 with SMTP id d24-20020a50f698000000b0054b2af0dee2mr1288726edn.4.1701931725570;
        Wed, 06 Dec 2023 22:48:45 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id z61-20020a509e43000000b0054ce0b24cfdsm404552ede.23.2023.12.06.22.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:48:44 -0800 (PST)
Date: Thu, 7 Dec 2023 01:48:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231207014626-mutt-send-email-mst@kernel.org>
References: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
 <20231117092318.GJ8262@noisy.programming.kicks-ass.net>
 <ZVdbdSXg4qefTNtg@DESKTOP-2CCOB1S.>
 <20231117123759.GP8262@noisy.programming.kicks-ass.net>
 <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07513.123120701265800278@us-mta-474.us.mimecast.lan>

On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> 3. vhost looping endlessly, waiting for kworker to be scheduled
> 
> I dug a little deeper on what the vhost is doing. I'm not an expert on
> virtio whatsoever, so these are just educated guesses that maybe
> someone can verify/correct. Please bear with me probably messing up 
> the terminology.
> 
> - vhost is looping through available queues.
> - vhost wants to wake up a kworker to process a found queue.
> - kworker does something with that queue and terminates quickly.
> 
> What I found by throwing in some very noisy trace statements was that,
> if the kworker is not woken up, the vhost just keeps looping accross
> all available queues (and seems to repeat itself). So it essentially
> relies on the scheduler to schedule the kworker fast enough. Otherwise
> it will just keep on looping until it is migrated off the CPU.


Normally it takes the buffers off the queue and is done with it.
I am guessing that at the same time guest is running on some other
CPU and keeps adding available buffers?


-- 
MST


