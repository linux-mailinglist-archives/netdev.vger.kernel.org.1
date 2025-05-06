Return-Path: <netdev+bounces-188346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2070AAC6C8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215B83B308A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774227FB0D;
	Tue,  6 May 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P17d+MQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC928003B;
	Tue,  6 May 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538980; cv=none; b=awGQz+okwTkBWTn/GgomrsqKm8ueUagU98M1fN4oWZ4/gU0yMVJ3hLmGY0U+CdgU0eTJeOao7mDzn1JHMznuIo8Qq1+CXqjk7fgZ7CX8NxfqglDGwZmeiZLZV7xqsFJOPxhieChmx3AXZIjUhfFDB/W8bpVtfVadyRTZ6+dq9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538980; c=relaxed/simple;
	bh=P7MmDT0YiLN9IQpLfGcRluQMRY7SmCSqoyzu3pS5XKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx7Lcc0XXHfqxQ2ysN6OxY5jeT3qtc493JT9izSUdVMLm5icHKfoTRZ82KT/rx76FCAuIuVvpriRdV6Cyk/jqD7kh1NK1RyO5RhunxvX4F/h5ebJR5mVuAQlcsa1eHnTrVkiJz6ykIxAH8nAMbAG3/6nAFMXKyBVsDdJjmHErPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P17d+MQ7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac79fa6e1c2so107762466b.1;
        Tue, 06 May 2025 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746538976; x=1747143776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiemZaTp19eI1v1+NuBxq7gBLDW9Xde37HRgy41BFFg=;
        b=P17d+MQ7pjI3t6e5hJRqKALDrx/vaFVrcLlKOjUU8JPrXfTXAzCVytqSmqIy/cn7ck
         3sybM9R0ltAByBegvuJTdQesLnX87hRjHO0oQqZLBcjB9Ghso5BH5GuTfao+x2R74ZpT
         WqE/TlT7ELBZ2csWwWJP1pnlDa1VvWf/CWa62qdSKyU5svlOE21zwwEYklFSGcPALqil
         DGXPZXJ1ajLSuZQ3MupnSplrDay6jfTZtPHvnnF+QBYV59NwoSaM4UsVj7ZgMtPVwxrh
         W4Ys1JdCl1B2CfB6aGgi7pUcxrSTsF67QPhjajosZFKEP/OOsynCU9F5tfE8fV+1vhAm
         KAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746538976; x=1747143776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiemZaTp19eI1v1+NuBxq7gBLDW9Xde37HRgy41BFFg=;
        b=iJhclLOBEw0lJV3jofkKFgoLCMSHnDmxINRK+jQfTHxDG17o4TixbiywuaQKFCOFXP
         zI7pybCaBQzAtslRdfJiwXxCF8N32rbb22oLYg/dKTMYE95kAuyclJvxaDNcKhf8pVDY
         XVZcyTJbsPSOQJJW+y4gh+QxqSH66rddE2vbydBxxSMN3zHN1d3mhsLGwJVlO5vlMdk5
         pqZHiOX4kiJARXEn6z19Odo9vaf8OrvYcMn2WQ5ZShpzJGrN0nrkxqbl/fI7AGRFZhqE
         CwR0pVHijfl/Mngigm8MF7dNQz/sujmpi2yPQEkS1ycrFFpJmLYnWuao/hnbB5r1vlek
         A1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXUrj6mUK8LkaKD7HbamTY2OUDSCq0GL31cctJjBM3CMI9TdvnNSgNWDKY6TGCN5monq+n5KxrDjfLOZA=@vger.kernel.org, AJvYcCWIoE4ROuRhPMljBFg5/wDq0QRkpo9PoFWRsfnSS8BECnzccZq/w6PeMlLA3MFzzPGhMY1iJVdK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQ5qmtSDJqzMsx4Z9wrTVJhncB8aNoGbp54gDP09UOeuKJsxA
	sf6l5cy/mTwR1/bWZ6I4kDkPJJn3nMOPUGEjux/gUgmQhbzff7d9
X-Gm-Gg: ASbGncuzMMFUyD/JEklyxsyfRdXIzx/FR47pvUDbfP4xQ/MHzDAuSYjImUCj15Ei5Ry
	Ocd8kMnjDLvK9SuEcWkd5Q8E0WxPwzi6Tj9lgk7HihNFGzgIE2VNRZqkSJcqJOejfRCZkCrOTFe
	a3scSChDqjAd+Xt/Eyy1OEiU9bPTwn0R9Pd8j3RCP62dGrzX3NgLeM6Rq/ioTBpZoPtCI6hH+EO
	kHbPVzWKOdbdgTKsgDhyc4h62k0QBZm2SwKAL+i03Y9VqyNjS8NNYOojfsjUAkJ7lIABEXYCjoP
	p8gf7qukz+7QWUB0KpUk6hOWMrYf
X-Google-Smtp-Source: AGHT+IEx6UFb5TO/Fzb1ru+F2aQW/ZeYDNg8x1uGcC9VliQdtdvGz1X7rVtHdcrdZAJRaHIz8/NC7g==
X-Received: by 2002:a17:907:7e8f:b0:abf:6c88:df53 with SMTP id a640c23a62f3a-ad17ad76092mr586855466b.4.1746538976118;
        Tue, 06 May 2025 06:42:56 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895090a1sm710347866b.137.2025.05.06.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:42:55 -0700 (PDT)
Date: Tue, 6 May 2025 16:42:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
Message-ID: <20250506134252.y3y2rqjxp44u74m2@skbuf>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
 <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>

/ unrelated to patches /

On Wed, Apr 30, 2025 at 10:43:40AM +0200, Jonas Gorski wrote:
> > > I have a fix/workaround for that, but as it is a bit more controversial
> > > and makes use of an unrelated feature, I decided to hold off from that
> > > and post it later.
> >
> > Can you expand on the fix/workaround you have?
> 
> It's setting EAP mode to simplified on standalone ports, where it
> redirects all frames to the CPU port where there is no matching ARL
> entry for that SA and port. That should work on everything semi recent
> (including BCM63XX), and should work regardless of VLAN. It might
> cause more traffic than expected to be sent to the switch, as I'm not
> sure if multicast filtering would still work (not that I'm sure that
> it currently works lol).
> 
> At first I moved standalone ports to VID 4095 for untagged traffic,
> but that only fixed the issue for untagged traffic, and you would have
> had the same issue again when using VLAN uppers. And VLAN uppers have
> the same issue on vlan aware bridges, so the above would be a more
> complete workaround.

I don't understand the logic, can you explain "you would have had the
same issue again when using VLAN uppers"? The original issue, as you
presented it, is with bridges with vlan_filtering=0, and does not exist
with vlan_filtering=1 bridges. In the problematic mode, VLAN uppers are
not committed to hardware RX filters. And bridges with mixed
vlan_filtering values are not permitted by dsa_port_can_apply_vlan_filtering().
So I don't see how making VID 4095 be the PVID of just standalone ports
(leaving VLAN-unaware bridge ports with a different VID) would not be
sufficient for the presented problem.

That being said, trapping to CPU all packets on standalone ports is not
uncontroversial, as long as it works correctly for the hardware
controlled by this driver. You seem concerned about losing RX filtering,
but if you look at dsa_switch_supports_uc_filtering() and
dsa_switch_supports_mc_filtering() you'll see b53 never had it - it
depends, among other things, on ds->fdb_isolation == true and
ds->vlan_filtering_is_global == false. Here you're working on improving
the fdb_isolation requirements, but there is still no support in the
core for devices where VLAN filtering is a global setting.

