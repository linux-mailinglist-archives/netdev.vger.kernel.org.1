Return-Path: <netdev+bounces-81736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C188AEDB
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22CB1C3B95D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC815A10E;
	Mon, 25 Mar 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI3HsRsX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1C5A108
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391989; cv=none; b=Pb1K0TKJdAvI1xxNRsIy08By1JzXbVH0n1n99RwxOdNaCjy5z+zDFeqKtnC0uVQSu6lsGFfr+zKY1v8NXXhb0N+rQNSBac+mdTDKwNoLzpSbZf9syWZ1SGHhhJYzNXFgrTt+4NxPDZAvix2OPBRtkb87lIn6fnnL6h5I9b5Fa70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391989; c=relaxed/simple;
	bh=wBYimhzaY3McYq4ZugmBXpR4jUE6j8uUOdVyfRG3T3U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lLoRLgt3YXnPfcqYVAUk20Dp6W/iTwACBZFJrSc0uAYwxcYKooB0VQG2DWZl6MlB40qdeZtTd+gukM/jvRTOmJXBd1Kp67A2Kl65qVxn5UVVSG4hFKlIjyj/pRJSK8y5vl7uQAGbW99Lpx9ZNSnYUb8PcD4U+p4E4BqVEcgceoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI3HsRsX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a26aaefc8so293844385a.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391987; x=1711996787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMbQf5Ijpb9EEgmQvbnxb1a7Nv30D27qZTpM9SmOPmY=;
        b=XI3HsRsXLFi+fMoObuirv8En+slrV4CFPuRJhPnlHOs/VOR0nKwlyNHk1S90fBvP7E
         4FExmoYbTypkdIKSAw9vuDxHbxPfSS1biJ38NYGp0BMEf+otvHHMeHnYIPUgm0tP5vbs
         VcPZr20D1AfVuxo9Z7sV8E9aRDP7DCa1/4ExleNpv2ARaPnKNnEYZRYqUnzWqAlt1Iqd
         0DKL3k1XuD0AnwzAqjTE+cygAlxjZSEZdxr8CCLl1Vi8BdY6bxEcJ4pBooU8eP65GsyX
         LlWrIEaxrmUJRmrBvzq0XrdP2L5vYu18zGY+8QkaoPppUl/+YcxO8w3QKbQynK51GUTh
         7DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391987; x=1711996787;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMbQf5Ijpb9EEgmQvbnxb1a7Nv30D27qZTpM9SmOPmY=;
        b=Bs2efwAi37wokrKaA+4DfczLnRph21wBCdYpjkHAloggpf9HoGbldVoTuNIRM1arRX
         k8hESISV2/dolDri4uLPwAFC4uWSaKsBphPS8hmRMYtVyqcyTABsSA4JD8IvqOgiEp/q
         wpr3Mu/u7GnjKvMKa0H92SnHKUt3kwaUwGmlSSxc9j+XYsJb/C5awSSSWXMeuRoaj9wv
         1bc7o4vlNe92l0egxR1ds3TnL4amp9hLuHyHOg5t+K05M0OQIiT5mcKiVLGpqLthSDaX
         WJVU3dbNTyMvqCJYIHKqK/leuQpngXVUYXnUdgCuFYHs2MHibuwg4kMJ1bcNemuJhWGg
         X7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzG0Xs22ydR91+wIN7nLQ+kqN3ieKlO6uM8oODFNTvIala3si3ixRGEjnmWFZ2WPRbBediSf12xdg8zDC+X47LhR/BPr33
X-Gm-Message-State: AOJu0YyhP6f0PBwad3iMCDqR1Bz9MIc74j6ytZqgrYSsERGeV64SKI5G
	d/uWCcYPt7tpCJdtoywRVZ9faodOD3cT24AU4l17c5OzvFtqGd36
X-Google-Smtp-Source: AGHT+IHUlvy5QWFWOBgd4gLoj2lqZWmVM7DL2TPT2UW9TbvN14aG/1/fxKzTOfc/3SJGGIwnxEISSQ==
X-Received: by 2002:ae9:c310:0:b0:789:ecde:5d25 with SMTP id n16-20020ae9c310000000b00789ecde5d25mr7689898qkg.8.1711391986924;
        Mon, 25 Mar 2024 11:39:46 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a0b8100b0078a4fe9bf69sm1622870qkh.57.2024.03.25.11.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:39:46 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:39:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <6601c4f27529_11bc25294b@willemb.c.googlers.com.notmuch>
In-Reply-To: <171136303579.5526.5377651702776757800@kwain>
References: <20240322114624.160306-1-atenart@kernel.org>
 <20240322114624.160306-4-atenart@kernel.org>
 <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch>
 <171136303579.5526.5377651702776757800@kwain>
Subject: Re: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist
 partial checksums to unnecessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-22 18:29:40)
> > Antoine Tenart wrote:
> > > UDP GRO validates checksums and in udp4/6_gro_complete fraglist packets
> > > are converted to CHECKSUM_UNNECESSARY to avoid later checks. However
> > > this is an issue for CHECKSUM_PARTIAL packets as they can be looped in
> > > an egress path and then their partial checksums are not fixed.
> > > 
> > > Different issues can be observed, from invalid checksum on packets to
> > > traces like:
> > > 
> > >   gen01: hw csum failure
> > >   skb len=3008 headroom=160 headlen=1376 tailroom=0
> > >   mac=(106,14) net=(120,40) trans=160
> > >   shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> > >   csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
> > >   hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
> > >   ...
> > > 
> > > Fix this by only converting CHECKSUM_NONE packets to
> > > CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary.
> > > 
> > > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> > 
> > Should fraglist UDP GRO and non-fraglist (udp_gro_complete_segment)
> > have the same checksumming behavior?
> 
> They can't as non-fraglist GRO packets can be aggregated, csum can't
> just be converted there.

I suppose this could be done. But it is just simpler to convert to
CHECKSUM_UNNECESSARY.

> It seems non-fraglist handles csum as it should
> already, except for tunneled packets but that's why patch 4 prevents
> those packets from being GROed.

You mean that on segmentation, the segments are restored and thus
skb->csum of each segment is again correct, right?

I suppose this could be converted to CHECKSUM_UNNECESSARY if just
for equivalence between the two UDP_GRO methods and simplicity.

But also fine to leave as is.

Can you at least summarize this in the commit message? Currently
CHECKSUM_COMPLETE is not mentioned, but the behavior is not trivial.
It may be helpful next time we again stumble on this code and do a
git blame.

> 
> > Second, this leaves CHECKSUM_COMPLETE as is. Is that intentional? I
> > don't immediately see where GSO skb->csum would be updated.
> 
> That is intentional, fraglist GSO packets aren't modified and csums
> don't need to be updated. The issues are with converting the checksum
> type: partial checksum information can be lost.
> 
> Thanks,
> Antoine



