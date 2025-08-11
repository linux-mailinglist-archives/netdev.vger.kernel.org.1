Return-Path: <netdev+bounces-212514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C73B211E3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D9D5011BF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBC29BD89;
	Mon, 11 Aug 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/streQG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA5296BDD
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928606; cv=none; b=uQwPEkKMAixOqbR6Dp2WD1ROP6huDbuZPeYtioY8Gi0SE3AQsYPIrkYuvqOKQfGqfP74MEqENhf5Sid5z4mAFPdbHHPe1ZFyQEIRjDQEmci/BQUzN/9F11rnVLbIchvDPlSs9IhWuIeC0aaFf/dGi0fr94eGLzenXAd3J/39G4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928606; c=relaxed/simple;
	bh=y4EGvWntROiGWD3Dne4zAMWLn57dmjFXDvrUzFPu+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8+3bymwji9vCtVlbbC3Z2g0tpMgyq9BMaVyYRVoDdkoFt56iMknHZrIAiA2uWmb2NYdjMrHkyStbv11uDKwj7I5I24eyZzFZ4F1rgFclEyTTGkyfVWkrkDcmQj0+H4ZQykNHEr0yhRQzAMl5Fy3LU9PbvWg/0LVTZeXsjlP6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/streQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754928603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SA1YwZmmcpaEV0r4xjbOOTwA3ieiKxLs5sjJ47pZWYU=;
	b=F/streQGXIAys3UdmfFUYKYUY7r8mk4PxTg/hfYPsHHJ1Af2Kp5NNMbdEJQjptDzOhvt0G
	fWp8MNPccoUk3FYoEh8hpH711pHrSnItfxxa9fG+OhrN9sNEBRmEB0r3tdXU1SXd+e+nc3
	d8r61eWscr53vUf9BI3q6gY4oH7Hcgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-kws948R8Pf-9NRtIT6PdOw-1; Mon, 11 Aug 2025 12:10:00 -0400
X-MC-Unique: kws948R8Pf-9NRtIT6PdOw-1
X-Mimecast-MFC-AGG-ID: kws948R8Pf-9NRtIT6PdOw_1754928600
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7ed90baso36347825e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928599; x=1755533399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA1YwZmmcpaEV0r4xjbOOTwA3ieiKxLs5sjJ47pZWYU=;
        b=keDEX9wvzBnmXuc4sw1HU0c4Ld3qPJWOrLQZO2N321/Jol8BOHiZzJ5NcxdhasD5vk
         SQ2tfhyQGkNiSePaVspGZBG9YlSeeec3iZC5o4LrTbEya+Vj6/7XD/rqBrNX/MC6ZOXz
         okQl9u7l1Adthxc35ISeYmxgGPnKydK29VitOF/ZVJvyKdB/7u/8oL0/QHEgpL+Bbm3E
         tS5b0OC9rlUx3rnyHCLcJM2JcXt++uruEsC/u9jHkut4XSThO8ZkYawCPhNeQOwt0RsL
         p+nHrDdExx6KzulHGd9ybOOe8VFDA4Es2UeSKou3eJ8J0V0yzzNH2UGawPn5M0XmbcW4
         0g2g==
X-Forwarded-Encrypted: i=1; AJvYcCVo1Fti5Ve6UNXiVX8zpmGG7Weso03W1FFo6goclzFCgJF/nAU8gKowv+w/oWcBVIyN+pyKDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPh2gtt4MloLZlUfmUMY+pew1crpFDXJGgaf5MAEwxFZX1YZK
	eS4ypEMdFgOhqehGTr47Al/6OGeiQ5baCkhV3i4/T35TisCWgw+t55l53yGpPElP4TpbX8muo/P
	VeXkW4WlkM7VeiYQjGu2pnVcT+oKrTAUhFM/rOhtLZd+nd1JyHmgkLVlxLQ==
X-Gm-Gg: ASbGncszqfiFJszkEqRzlbgCRKvg1Nijs9t46MOSA5HtZBbNqVKYsmi1EDJSh7mV9kq
	/raTo1DmrSbVSgkmN/bZIFDZlrkiARDxWl13KEjpJXb5j5wa83VOMhqsO499OdmukywfCbpes6l
	7HL+omPnNKrA+9r8jt90Im/jnlZXXG8Sk/UJXo+g4oH4xE6M9p8NA/mLat+iA/UUF3wag090Wax
	T7a0OIwj6Plvpk9hv+tgsBf+qQnnVgp2qO0QZ20BiAmmPerPtV1yIh+ICKoLZWl0jeVIa8Yljo/
	/oOMiUeswVjsawZBGwIHjVaG2Ijl71tkx+EWUA==
X-Received: by 2002:a05:600c:1988:b0:458:bfe1:4a81 with SMTP id 5b1f17b1804b1-459f4f039dfmr126209395e9.17.1754928599579;
        Mon, 11 Aug 2025 09:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0IesQW2cjSCKWKUmYC4O+ml5wRM1qVfay2hrpIj6eOuFp577HfqPM1t5k0XDTbyY35jlYmA==
X-Received: by 2002:a05:600c:1988:b0:458:bfe1:4a81 with SMTP id 5b1f17b1804b1-459f4f039dfmr126209105e9.17.1754928599159;
        Mon, 11 Aug 2025 09:09:59 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58542f3sm258541405e9.10.2025.08.11.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:09:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:09:57 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging
 unused classes
Message-ID: <aJoV1RPmh4UdNe3w@dcaratti.users.ipa.redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
 <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
 <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
 <c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>

On Mon, Aug 11, 2025 at 10:52:08AM -0300, Victor Nogueira wrote:
> On 8/11/25 06:53, Victor Nogueira wrote:
> > On 8/11/25 04:49, Davide Caratti wrote:
> > > Maybe it's better to extend sch_ets.sh from net/forwarding instead?
> > > If so, I can follow-up on net-next with a patch that adds a new
> > > test-case that includes the 3-lines in [1] - while this patch can go
> > > as-is in 'net' (and eventually in stable). In alternative, I can
> > > investigate on TDC adding "sch_plug" to the qdisc tree in a way
> > > that DWRR never deplete, and the crash would then happen with
> > > "verifyCmd".
> > > 
> > > WDYT?
> > 
> > That works for me as well.
> 
> Sorry, should've been more specific.
> I meant that the net/forwarding approach you suggested
> seems ok. The tdc approach would be a lot of work and
> I don't believe it's worth it.

I was more of the idea of avoiding a non-deterministic kselftest, because
with mausezahn running in the background we have to be "lucky" enough to
see the tc qdisc change command executed while the packet socket is
still emitting packets. And the sch_plug approach I mentioned this morning
looks doable: I just reproduced the NULL dereference on unpatched kernel
using something like:

 # ip link add name ddd0 type dummy
 # tc qdisc add dev ddd0 root handle 1: ets bands 4 strict 2 priomap 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 # tc qdisc add dev ddd0 handle 10: parent 1:4 plug 
 # ip link set dev ddd0 up
 # tc qdisc change dev ddd0 handle 10: plug limit 5
 # mausezahn ddd0 -A 10.10.10.1 -B 10.10.10.2 -c 0 -a own -c 5 00:c1:a0:c1:a0:00 -t udp
 # printf "press enter to crash..."
 # read -r _
 # tc qdisc change dev ddd0 handle 1: ets bands 2 strict 0

so, including "plug" children in the tree should make kselftest feasible either with 'net/forwarding'
or with TDC + scapy plugin superpowers.

@Victor + @Jakub, can we apply this patch to 'net', so that regression is fixed ASAP, and then I post
the kselftest in a separate submission for net-next?

-- 
davide



