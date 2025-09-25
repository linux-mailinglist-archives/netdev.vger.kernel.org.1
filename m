Return-Path: <netdev+bounces-226282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83048B9ECB9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13827A3102
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F42EFDBD;
	Thu, 25 Sep 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TjmvLZoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAF2EA74B
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797229; cv=none; b=tQwdd5YqYKryYkBtQaAh4+BUzRBvwZ+j2kAy3g3mz0nY0EN/Hg68Y1R/G915w+yMoGcEPXEidMnUWgsXo64Z99DTOSad/W6kbY/VaMvQp6u5OBPenSUBlRFaCmAUEgnPotcZsqkalgDW2J1H5Lh8Yh3F7gtlwEzVSTNGzOZg2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797229; c=relaxed/simple;
	bh=8nvJ8A7foyLcKS29tCoL0fPQRMxEjUQMAs2niNyf/vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTUstErvouSBk9rXmGttnfxCZYy9lgv0ICEVBJfBKWigY0rvjKSUL2CXDar1MlS4uXx6SwjeSCObgzP2C6VoS/6gPVkPlgNc4Y582EFlSlDSjjWWdhlpkN7y+Df6wDP/8/uFSXnHnfuS0msOdWmspUfLI9WLT9tAn67wSqiUBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TjmvLZoD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1248745a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758797226; x=1759402026; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtezjMk6/bO0x/tPzo5ofmo/kKFHp0RyWiXSJ7o70so=;
        b=TjmvLZoDR1ZuQaL4P8J1XHY/ORwiC/F+3lKzWOBkh0OsDPetD3+z7WqOUWUj9kKHKf
         34O9dAdfPY0qRv1YCTw17V5aIIj6iSY5xYZcMf6NvGEbxg8IFdKzpmmDmoVBIun1ymFX
         CUK5HCGn7uD1nvayqvdvp2m6D4GLhbZZnpOE4fyKsfzGqzYZS1BA+1xTLsRSl7PunAoV
         /lO2gqIBOj7LxARwe7lkepO59nAX4ecpO4QYuCUaTY1JcUIBL5+R4D31xqwIjIVZE2ui
         6QrmXBwDby1kq2E9wWym0EfKaHSaurEIhSYJQa2RjxD6pKzBdT5o5PJHgSAK2DAMOvj8
         W+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797226; x=1759402026;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtezjMk6/bO0x/tPzo5ofmo/kKFHp0RyWiXSJ7o70so=;
        b=SqzXARsjFE7DwhPztIL0SHM9idivvFQU8sZz3BdGTb9gbGYn8uYikNKPq4MczxT4O1
         ujaIpEaj9b7xAH7b+XKWWbq12rUJvv9m9sl3Tvf3Ai2GN31BXSa21/oDPZcTIvPB0FHg
         G5uxIW80kl1fqjQGn9achsIOuQHPKWfuSQdDIWX6eNlCCf9uG2xvT5UBxHHb9qP5OA16
         j3c8Zk0VahKLfygiiD0ZDQwSJXLsA0CRAq2IL6iq0MIxwNu9whQ4aWBQBu29BKt5CZ0N
         2facgh1pATYgtIRanr5VtSw2z08qmK9a/3BEKwqoAej2oeyMquDOrK4YYHiTNg+/gl25
         BZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTNZ0ShsrHBpSXfUmFfsRD5fBBYcrUAoLBpaK0Vu6QBFb9zgsNtxJH4DiMlxOsmjT8ur/I548=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlCAY7GNvjdJAVGkvJGPeHz3j16lIzVwgRomANyHGfinB0z4Y
	JDODuA5EmOTWzkkSfXmkLirl4GPpiFJCcrl/DZwEYaQK8ICQ3d5VZ+LK6YGxcHy6Irs=
X-Gm-Gg: ASbGnctkuKHtD6GdwA1lwVXqpPzZL3MPq7YYYiJZN69lrwWDm867BNK9U2RS64fXMhs
	tPRCgjaWhsI/FcwOzE0KmORvNooz4i1cEsxg2w9Q+bRYDLcHyGf5QzPXgRyBmip3Wo1DM2NEYfA
	BEcbLrZNmqxHHDPcPROAsBNmnd1rA95rRtLLZAHUGODwRHBfvqREGQIvZF+GstPrvf0svgZYiMa
	TuLnzraGuEKdTPhISe9mYGz4iof6RfM1xkQ6byXMu79j8X/15yP9AatmfpfsxOcheIYvxuiCsH+
	wmcMeBvj066d66dqH8nu8ZHFfT/7faTSNgB5M2Fv0cET95l87u4/F7dvhgOIjOGMLSYrfn+my17
	kqH43YPLtqGfV1Z8=
X-Google-Smtp-Source: AGHT+IEEcfDn2RrVsshiYTVRq+15zLodFJyHTF6YE6Rd2TNw1hBwfGLx4qw9HosoUAVdPzH9DGkLsA==
X-Received: by 2002:a17:906:6a14:b0:b29:8743:8203 with SMTP id a640c23a62f3a-b34b14ad9e0mr345065266b.0.1758797225581;
        Thu, 25 Sep 2025 03:47:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a983ffsm140688266b.94.2025.09.25.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:47:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  donald.hunter@gmail.com,  andrew+netdev@lunn.ch,
  ast@kernel.org,  daniel@iogearbox.net,  hawk@kernel.org,
  john.fastabend@gmail.com,  matttbe@kernel.org,  chuck.lever@oracle.com,
  jdamato@fastly.com,  skhawaja@google.com,  dw@davidwei.uk,
  mkarsten@uwaterloo.ca,  yoong.siang.song@intel.com,
  david.hunter.linux@gmail.com,  skhan@linuxfoundation.org,
  horms@kernel.org,  sdf@fomichev.me,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
In-Reply-To: <e85e7bb2-6229-4b04-9c2a-7a7b79497c6c@gmail.com> (Mehdi Ben Hadj
	Khelifa's message of "Thu, 25 Sep 2025 12:28:07 +0100")
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
	<87h5wq50l0.fsf@cloudflare.com>
	<0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
	<87348a4yyd.fsf@cloudflare.com>
	<e85e7bb2-6229-4b04-9c2a-7a7b79497c6c@gmail.com>
Date: Thu, 25 Sep 2025 12:47:03 +0200
Message-ID: <87y0q23j2w.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 12:28 PM +01, Mehdi Ben Hadj Khelifa wrote:
> On 9/25/25 11:18 AM, Jakub Sitnicki wrote:
>> On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
>>> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>>>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>>>    This patch series is intended to make a base for setting
>>>>>    queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>>>    the right index. Although that part I still didn't figure
>>>>>    out yet,I m searching for my guidance to do that as well
>>>>>    as for the correctness of the patches in this series.
>>>> What is the use case/movtivation behind this work?
>>>
>>> The goal of the work is to have xdp programs have the correct packet RX queue
>>> index after being redirected through cpumap because currently the queue_index
>>> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
>>> current understanding.I still have to know how I can propogate that HW hint from
>>> the NICs to the function where I need it.
>> This explains what this series does, the desired end state of
>> information passing, but not why is does it - how that information is
>> going to be consumed? To what end?
>
> In my vision,The queue index propagated correctly through cpumap can help xdp
> programs use it for things such as per queue load balancing,Adaptive RSS tuning
> and even maybe for DDoS mitigation where they can drop traffic per queue.I mean
> if these aren't correct intents or if they don't justify the added code, I can
> abort working on it. Even if they weren't I need more guidance on how I can have
> that metadata from HW hints...

Both filtering or load balancing you'd want to do early on - in the XDP
program invoked on receive from NIC, which as Stanislav pointed out
already has access to the RX queue index in its context. Not on the
remote CPU after spending cycles on a redirect.

And even if you wanted to pass that information to the remote XDP
program, to do something with it, you can already store it in custom XDP
metadata [1].

So while perhaps there is something that you can't do today but would be
useful, I don't know what it is. Hence my question about the use case.

[1] https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/


