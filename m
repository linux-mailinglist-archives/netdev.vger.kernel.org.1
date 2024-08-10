Return-Path: <netdev+bounces-117354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32094DAD1
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FEC2830BE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23A5FEED;
	Sat, 10 Aug 2024 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4keRsET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AE42AB3;
	Sat, 10 Aug 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266246; cv=none; b=CvSKo5vRcIOJjmkYzKopEuoYhJbZh2Cgllj/a2mPN6oYpPpVtwEZ8k+YDstuVOBLOt25VPupXLuxzZ9QKGL2uFCznjohkzsPIF/FEz4Bbln/tPeo4PP2eBDDgPV8qdxx/Mso/ZeB2o+u79e0hxz9pLttkbkVWdVfX/pe0r8Nicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266246; c=relaxed/simple;
	bh=EF1ylEYDfUpPrmMSUJqw9uq/GgTVKqGyTRiONwYjiXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR64hTJ6DzKQXVR7rZ3ayV6WUiBaNOtjoT89Tclrl+dnzpmi9K8JJ/lG2R5qqR+3vIKCgnL9l7RDcyRPAFcKhDdK5lHirisomll1+GcJukM1Vf0NaPAzM1PFefmb7iuuVcXtFm/cZqUY3ciH53pxZmtWRh9XomupCtlTTF9HOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4keRsET; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so134274b3a.2;
        Fri, 09 Aug 2024 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723266244; x=1723871044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF1ylEYDfUpPrmMSUJqw9uq/GgTVKqGyTRiONwYjiXs=;
        b=K4keRsETpen9RnhM7uU3egubjlmzeNOacduZ2phxsl7oJJLUPbcgKJNfwixBA93N9M
         ZkTo1Ro/+o+tTgO+ZT+05CG8aQK5mVqgUgZ+B/ueZgVUnrFfGEg8/hCuCwCO7WWzxL10
         lVJjy16peTPRxEXt2q70F29fItT0ow8m9XbH0eSdsos3ZdsOEak/lvBy58IfVWkNLL2K
         H0S41bnUdby2Nocp652oaTDIJxkpJ6oxz5RimSnJazqn4eUukU0+41wjddEOv6GEqfps
         cZoSm4ZfjRrMYvjOk8bGezZUcqsLlQd6XVY9PJdN/UtMNnE+dXJRjMiA1AvQRTFW+4zD
         QCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723266244; x=1723871044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF1ylEYDfUpPrmMSUJqw9uq/GgTVKqGyTRiONwYjiXs=;
        b=KL2jsVaQoZygDBpwYXU7kj6beogcpay4qgU4qZMkDk2oI20GmRnW37NyMlimPAP+5g
         ap2bECFNfmIXysR1+v+fCq8YQP3ayjcJqMuHp5/MInMe0Yx3VetVFdbnsWyWmMXnc4PR
         mWHIh0us5g0LH4zI+5EMGE5hbmdtRetPoc+w2gSgAoOyAKr738Tx01XvjQ6pFGSz7J/4
         +BmswDz4+dvVnMOgq3rhY5km7NjJ+rZ5OfA6GmxNB5hVgNIXXnu9LZFJ1JXCritTMT7u
         OUdCx+NgQ9XMQ0yNCO9J/Utmr+2z7awr48lG8IowesHNXbwYZWcqNC2OVbDx4czrSfNg
         AwIA==
X-Forwarded-Encrypted: i=1; AJvYcCUXPmhcJZvnfomq+3ZphVMUn6b++6Dcj6rbyICQ3FRRh/grkx7HyN0n5S6Kj+mOjN6NeWtC5Mo/WVdYnx4=@vger.kernel.org, AJvYcCVbapg2n2I7rOSjBmJA6DceqpG/sNRQMuTniMkjiQJSPzNgLVFPaK7rXCqrmsyo7Yh65hRpXNiM@vger.kernel.org
X-Gm-Message-State: AOJu0YysvDsgjtzT35ToMHQW0wcTRXHLqlwt80KNbW1znAwqBaUXiCmX
	mnGxZhkFHKp8wtQZuPlDyFKL4gxJalf4My3cm3ZhaP392RwlVamU1K7k+A==
X-Google-Smtp-Source: AGHT+IFHjTn9AA8sti07RfxyPTI0/0m0irWEAB86cudnkSZ5wPUtQ79956cjbv3Kdbpl7zgp7QKHpg==
X-Received: by 2002:a05:6a00:91e9:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-710dcb4aaf2mr2365053b3a.4.1723266244019;
        Fri, 09 Aug 2024 22:04:04 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58bd3bfsm571455b3a.89.2024.08.09.22.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 22:04:03 -0700 (PDT)
Date: Fri, 9 Aug 2024 22:04:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, daiweili@gmail.com,
	sasha.neftin@intel.com, kurt@linutronix.de,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts for
 82580
Message-ID: <Zrb0wdmIsksG38Uc@hoboy.vegasvil.org>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810002302.2054816-1-vinicius.gomes@intel.com>

On Fri, Aug 09, 2024 at 05:23:02PM -0700, Vinicius Costa Gomes wrote:
> It was reported that 82580 NICs have a hardware bug that makes it
> necessary to write into the TSICR (TimeSync Interrupt Cause) register
> to clear it.

Bug, or was it a feature?

Or IOW, maybe i210 changed the semantics of the TSICR?

And what about the 82576?

Thanks,
Richard

