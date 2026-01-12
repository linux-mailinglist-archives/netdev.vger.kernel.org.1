Return-Path: <netdev+bounces-248882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 241EED10948
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 05:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2CBF3008F3A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8E30EF81;
	Mon, 12 Jan 2026 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmH9pYUG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DflkwLav"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD119CD0A
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768192412; cv=none; b=If7hDxUcmOJnCMerrr58+9SZfV2eFW6mUM5K5xNB8PWEAX5fVaT1O46ElHS+0i29nBmyIArpBHvinVQEgVr8thDry7Mlu9HnCeMdg/FRyqxFCmdQ+mGRZYjuYc2xNK2quRkEcM73W17qRZIR9eS4LIbo8mWHcBFw+Kl2AGLNRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768192412; c=relaxed/simple;
	bh=JsECp4e88xlO5Vo5MlkaWcurekx6DybzbgYXNqaqYFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9Ka5o5DvlhVHsgfoAvJZsaz7taXwLAJLbqkJ09S+PSWKsADh3fuB3z10cqPg4wZmGjtWXA6Om5NuZON1OU0WeKyhIX4WirF6XD7JQ5qDG0g6X7ICXQA9Qn6QV9aK2Igu0te8FwSVR3plRisx6Rjo78wrjPMkPq3cfuNmFYRk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmH9pYUG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DflkwLav; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768192398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APuQMk+mj1Ir7IfbwA6rsBMcZIxIkKakSr4yNu5ZY2w=;
	b=VmH9pYUG/mLi9V1uEPPH2TR8PlbX3ABMRcRmmyeVtmLP2JCOHrvlgG4DFdgrlEPwW6JsOa
	/KnwTPsC2Cgtzv9R/Tar7AlvCi9VxVL8OKXrpuvHcqzt0jxoH/zqNnRyMH8uvGyLt/SVKF
	SSzfO8UiW/eoApudi0+JCfyEYNPMj+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-U6rgAWp-OSqV-i25SHxKSQ-1; Sun, 11 Jan 2026 23:33:16 -0500
X-MC-Unique: U6rgAWp-OSqV-i25SHxKSQ-1
X-Mimecast-MFC-AGG-ID: U6rgAWp-OSqV-i25SHxKSQ_1768192396
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f527f5easo2543970f8f.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768192396; x=1768797196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APuQMk+mj1Ir7IfbwA6rsBMcZIxIkKakSr4yNu5ZY2w=;
        b=DflkwLavtgns1iGBrrhWgRVEs+l5msngmMejVs2YPVUvSIS7iiXApi0uieueCJ1R+c
         axht/+rOF7DZSdljcnGsbarRqxblFfVq87esuBJG3XT29l2beT8mSl0xrMgzymksmoq/
         Suc3mUsQWEcAoLE3hVuQNy0m3uXyH3GxlCFyZwI40ftKWRiHEhhfScE3svNCtoGdgJTq
         so1ON2zo8SdGi+iDiN5F4lUvS/N7LLo1eo5o8Spc8Qr9fYkEOPUl0stwv4+8/0AeKFqA
         pmh8Dq/5an1N9d0RvrXs7cUp+/J4SBG+93bP+lNSrQ1uP8UTBaYSl+YD74YAQ56VdLle
         1vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768192396; x=1768797196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APuQMk+mj1Ir7IfbwA6rsBMcZIxIkKakSr4yNu5ZY2w=;
        b=T78BluakcNt7bt6cqwFfBL+l2OiOPheQxgPaIk5lOlMchuBqW/WfFd98OT1HBJQ8Jo
         1u2wbMl+cA7aRS9LGPHgp1Q9Bzo1zsKIBb5T0Vgx/pFg4sIhSJtb5CXxToAV8wQ+DYkm
         UrK45L7ZZ1zbwRU6YRqj/1aHQSuU4PiFwiqhDDLNFtkBb2E+QTXgULTQPblVFjIDGmvr
         mn117ePYlyFRt3AMVMiWM+ojPM3FIh084sMdkArnU/jjYc7E96SmWQPZFrIy7gnI9xfM
         Vld5uZNWSVzEhZTSTmXpkmGu+aBp+7lsR4rKP4thOVSAZyzxgj8jljdLGLuwnYUUhmet
         eGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXI1Rq6Fa1dTfYHiwJrrBwRpfx9LEapew2r8tm5ghU+CTfvi+NnNp9O6SHMk6529rDWzMXIZ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskaxPZsVOdrrPjLVPWbw+xfRS9TbCBv87tRFR1b7NVLYWjIHj
	zzkWu1M6A9GzJj7nk1ktH+jI650gFqENb+1IFaIbFWiRXU4hU2wY0LpB532Gm3EcMKqhYB0wsNI
	G8mTJUv/yejGtcldZxRTv9ESyF+1TRRPoOPEe1F+McCDMJ/zC8o/cIl8yag==
X-Gm-Gg: AY/fxX7UihsF+EdWLkZBng4fUjXKQOJ45Uhk3jRVZdYAR7umuJI9TOr2rh93CtJ5vpT
	qC9YYjr26i5e4jR16Ww3xFzmBBkbOPhCLo41AoaKLRBKL94UPf7xmPJ+2S/Hy4qGXYdVv53sJmj
	y27Fy5II/xxE8ox+ss2Qn3gED3YRZ/n7u+U6/6H0IG5FU0BFSSrM+t3EYU62CLs0uIq6RMJhTSt
	xNa38suGjg103P9EZl4oLBEvGZsWmKFQuieo0ipAh+B+kb28aE0ebbGf5PrNaeLGZVWa1O3NGfd
	FacrAMsUUeD3oAUHWPjBglRGojiI450m1Xw9hOzez67zTYC/kOZwh/qYlugfJmYFzaNKdsoux0U
	aX2vM3eDAAUg469HCrakc5TyyGi9ZNjM=
X-Received: by 2002:a05:6000:18c5:b0:432:da7c:5750 with SMTP id ffacd0b85a97d-432da7c589cmr7999793f8f.20.1768192395664;
        Sun, 11 Jan 2026 20:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/BXpYp147sy8NHGo+1rbRx2BpHOkLFAtFBJEDqcFXZDM5sBWqhXQb6dEWZIhQYfgNrNPMPA==
X-Received: by 2002:a05:6000:18c5:b0:432:da7c:5750 with SMTP id ffacd0b85a97d-432da7c589cmr7999782f8f.20.1768192395211;
        Sun, 11 Jan 2026 20:33:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm35982021f8f.35.2026.01.11.20.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:33:14 -0800 (PST)
Date: Sun, 11 Jan 2026 23:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
Message-ID: <20260111233129-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
 <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
 <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
 <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>

On Fri, Jan 09, 2026 at 11:14:54AM +0100, Simon Schippers wrote:
> Am I not allowed to stop the queue and then return NETDEV_TX_BUSY?

We jump through a lot of hoops in virtio_net to avoid using
NETDEV_TX_BUSY because that bypasses all the net/ cleverness.
Given your patches aim to improve precisely ring full,
I would say stopping proactively before NETDEV_TX_BUSY
should be a priority.

-- 
MST


