Return-Path: <netdev+bounces-216054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC8B31C4A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D02647DE7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66E2D3EE3;
	Fri, 22 Aug 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhuoYLXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A41CAA6C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873232; cv=none; b=an1IHU75qxfF17QMYdcN5I/5umzkfImId2Tq8shwwI4V++vRkVf16kI6qg5uZRQZdMurOFTWIpB00jc6/gH+l5nRoPAkqfyI+dsywUfN6ld39b7DiF+mkwAyebZR6F1DHfyUDsAaHPaAcNrqtm/ZbhKB5JgeBIUBtsBHIdRBr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873232; c=relaxed/simple;
	bh=kfolKQvYFZSxfkjeRUxdLC2rR9ChmO6Latvbv+PoNtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyl6kUkQPCeqFs4q5YZTIcQH8QRPlpxsSc9simYYha8iXXllgTAOa61zYpvwD8y/XcZYsb5GDgoAFxaw/YDUJSdW5KpQ+ilhRS3/c/rth3UxdIbG/GIRfd4br7SChq2A+hu1tkoo1hp8Hb54hGaAWEy5+rmUHbiWL7QVuTNvMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhuoYLXf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so1440154f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755873228; x=1756478028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5hx5Z5j6ph+gK1dar5pJS5/55awhd9qcvqd1JzEh+eY=;
        b=RhuoYLXfoHDBYKMaOX8AfGhkU1tVaU1f+KOLQM92XbACUC/PNOAu3eP+1FgwOeGGz5
         4rcOsvkK9WcaI1yImgoCfUPaggz60vteUtr+vt7K+o+S9EjfLD0BujtDg2b/IUtaPGYD
         teUx9G/d54Z7byZiVPJphQj0YjfNSEEGbFrokpCEJG6inQH7LHMlh8f37jE2z+ZywRR+
         kT0VNsNzaDzNpX/zMJGR1vptnvUMRG1o0FL4JTpc8KsaXDli9tV9/SJWJlMO3ndxRq0D
         n8U1DKH74+InR3z/HG1T3HvFWh/OtFEkmGU73ELznsS4hXt//etXpw/mErQuqlDem5A4
         dcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873228; x=1756478028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hx5Z5j6ph+gK1dar5pJS5/55awhd9qcvqd1JzEh+eY=;
        b=OEPPEKAQEjCJ7uqIMPqgqHXT7X3hoLb34ZBYN6VWZVHzXdB1RxbpSBcAw1l/c3rM45
         HGI+WDlBdP1EEvg7L/rObt3l1OogdN8gC8w5nR30XTwL5SjAau/3taRDgvGBXLsECQKx
         uLPjqfvQ4THFSces9f1mIoJ1XqC+RgAFaBwhaEjYi81bmxNbO8FMwUixlQbkDxuvRjOT
         I8k1LqWPdW27cyl3m3wc/W2EeaoEj8dYXlv47SYoWZHVCU/79dI6CTnmxRIdTlgtaXfz
         BeDP4ooIz+7H4zO6FfT3G2JvacGrRX+HYl7ntpGkxrPMVg+wNhlgPypqAN+rJjyX4zcF
         Mgcg==
X-Gm-Message-State: AOJu0Yz6i0c5sdfJWNj0yd31cC4gvgkMeuybrV0wpwiJLRFdifPW5T8O
	dLMqMo4nua2lAS6MOxgjjQjBqFyn2BFYXgUlUbGkx9mEXF95XquYDxmE
X-Gm-Gg: ASbGnctbrOiA8wTBc94Y0gyj5pxyFSZRcqI6VRa1N5azIq/tBYlm5yJ5PHVuK/rvWJD
	tzB5twiDzP4Qjc19goLvOu/+oB1YfMQHGglAvdjN8yBtHKZsqAZ1+CLN5+oC9YghTGTidstummD
	sVnHLskkBagP1+r7kwr1tN3GBdIX8ac7PC5cuXNBnRosgZgHFxbHyjuW6za2rQP6OuMoLRsNFON
	xdzqZJSsEGHdyiPptkV1hNsi/zu6zeiWD5K5Hd9qpqjt9Nju0cg06NawlnzImwhMcmvCreD5VPm
	rqCIoYLDTf1wnquUPa7E4VWmqICCx6LTuYmpONF7cw1n8DNnd2Wo9nSVaRVwS5uSDkjmvcCcLpW
	ePP4an62XrOjKeOrShLqNwpYVuATurM3VUYIK8ECBUp1MiCdRDCcnWpNONw==
X-Google-Smtp-Source: AGHT+IHePE6D2i8wK5/YMZnc3WHtQ7a+wVA20brD7S26qCzY/sjZrHNByRJidt8Ie+UuBlh2m7hVzQ==
X-Received: by 2002:a5d:588f:0:b0:3c0:7e30:a961 with SMTP id ffacd0b85a97d-3c5de34d10emr2514830f8f.62.1755873228297;
        Fri, 22 Aug 2025 07:33:48 -0700 (PDT)
Received: from bzorp3 (178-164-188-58.pool.digikabel.hu. [178.164.188.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789106sm15619656f8f.51.2025.08.22.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:33:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:33:46 +0200
From: Balazs Scheidler <bazsi77@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
Message-ID: <aKh_yi0gASYajhev@bzorp3>
References: <aKgnLcw6yzq78CIP@bzorp3>
 <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3>
 <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
 <aKho5v5VwxdNstYy@bzorp3>
 <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
 <aKhxpuawARQlCj29@bzorp3>
 <CANn89iK5-WQ-geM6nzz_WOBwc8_jt7HQUqXbm_eDceydvf0FJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK5-WQ-geM6nzz_WOBwc8_jt7HQUqXbm_eDceydvf0FJQ@mail.gmail.com>

On Fri, Aug 22, 2025 at 06:56:03AM -0700, Eric Dumazet wrote:
> On Fri, Aug 22, 2025 at 6:33 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 06:10:28AM -0700, Eric Dumazet wrote:
> > > On Fri, Aug 22, 2025 at 5:56 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 02:37:28AM -0700, Eric Dumazet wrote:
> > > > > On Fri, Aug 22, 2025 at 2:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > > > > > > On Fri, Aug 22, 2025 at 1:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > > > > > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the update is
> > > > > > > > done to the counter.
> > > > > > > >
> > > > > > > > In our case (syslog receive path via udp), socket buffers are generally
> > > > > > > > tuned up (in the order of 32MB or even more, I have seen 256MB as well), as
> > > > > > > > the senders can generate spikes in their traffic and a lot of senders send
> > > > > > > > to the same port. Due to latencies, sometimes these buffers take MBs of data
> > > > > > > > before the user-space process even has a chance to consume them.
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > This seems very high usage for a single UDP socket.
> > > > > > >
> > > > > > > Have you tried SO_REUSEPORT to spread incoming packets to more sockets
> > > > > > > (and possibly more threads) ?
> > > > > >
> > > > > > Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute the
> > > > > > load over multiple sockets evenly, instead of the normal load balancing
> > > > > > algorithm built into SO_REUSEPORT.
> > > > > >
> > > > >
> > > > > Great. But if you have many receive queues, are you sure this choice does not
> > > > > add false sharing ?
> > > >
> > > > I am not sure how that could trigger false sharing here.  I am using a
> > > > "socket" filter, which generates a random number modulo the number of
> > > > sockets:
> > > >
> > > > ```
> > > > #include "vmlinux.h"
> > > > #include <bpf/bpf_helpers.h>
> > > >
> > > > int number_of_sockets;
> > > >
> > > > SEC("socket")
> > > > int random_choice(struct __sk_buff *skb)
> > > > {
> > > >   if (number_of_sockets == 0)
> > > >     return -1;
> > > >
> > > >   return bpf_get_prandom_u32() % number_of_sockets;
> > > > }
> > > > ```
> > >
> > > How many receive queues does your NIC have (ethtool -l eth0) ?
> > >
> > > This filter causes huge contention on the receive queues and various
> > > socket fields, accessed by different cpus.
> > >
> > > You should instead perform a choice based on the napi_id (skb->napi_id)
> >
> > I don't have ssh access to the box, unfortunately.  I'll look into napi_id,
> > my historical knowledge of the IP stack is that we are using a single thread
> > to handle incoming datagrams, but I have to realize that information did not
> > age well. Also, the kernel is ancient, 4.18 something, RHEL8 (no, I didn't
> > have a say in that...).
> >
> > This box is a VM, but I am not even sure about the virtualization stack used, I
> > am finding it out the number of receive queues.
> 
> I think this is the critical part. The optimal eBPF program depends on this.
> 
> In anycase, the 25% threshold makes the usable capacity smaller,
> so I would advise setting bigger SO_RCVBUF values.

Thank you, that's exactly what we are doing.  The box was powecycled and we
lost the settings.  I am now improving the eBPF load balancing algorithm so
we get a better use of caches on the kernel receive side.

What do you think about the recovery-from-drop part?  I mean if I could get
sk_rmem_alloc updated faster as the userspace consumes packets, a single
packet drop would not cause a this many packets to be lost, at the cost of
loss events to be more spread out in time.

Would something like my original posting be acceptable?

-- 
Bazsi

