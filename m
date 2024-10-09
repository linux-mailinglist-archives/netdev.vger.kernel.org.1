Return-Path: <netdev+bounces-133820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098199729B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC482833E0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2F1ABEA3;
	Wed,  9 Oct 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pYA39/ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10EF188917
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493496; cv=none; b=N2oDPjkIq5A1HCGNTP0aX8IQujyC49FVZnhdjOL0q90gucU6Yz2h/zRgMeAoc9r1OQyw1n+du3xsXJxT+xsSoHzMkMImv641UMd7oiKPSDnXYJUeDIZtW5GoW1SjKOhgib4OAMfxgzL8RuCAllODOyNF6Z6AGWBksLMGpWmFX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493496; c=relaxed/simple;
	bh=xA+b3pZYpXE9AaENS3555G3n69KCThXPNsrqd9tZ+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPaDpYRw4rhfPLYbwbOO7mk8aDaMVIl6VLj6ikP2l2GhtWGlkpjcLlSyZ0BuoZBw8yYJZSyofMIN/I3fNqqrnaF+R7umWAdv+rwIV5oeRXcJiuxfbjJtXn6EmuERQcnhjDGSwJ4WNyE5/tjhiitPB+c2IQr0P5xAvEdu8kxKnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pYA39/ai; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71dea49e808so31742b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728493493; x=1729098293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NalHCw/yq0o7mdTQugdEr81cV/UtYYP9jAld2HHFzx4=;
        b=pYA39/aietqxzZDtpWFncUeW2qRtcLpqo2NtSPy8G9BKLF+zhXia7oJNN7NeVZQLTV
         vKCKttcQbXc2L/hX4CqpfbzXZN7L1oGw9D22CAuShi43ityemUXcWXguRSh5K72wLGPZ
         HDOprMS66/gaFWyRq01TdOi9RrNre6DoNPy64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493493; x=1729098293;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NalHCw/yq0o7mdTQugdEr81cV/UtYYP9jAld2HHFzx4=;
        b=EiuGrHZ5nA+2ZTcywMQkE1Ux8wcyuEWKslcGJZ+v1029oib3x+KU9ApL5nEFrB93d4
         P/GbjHF0qZJAP5EqzV4N47M31OTyRVf5uRsjOR66SYJ3B2fXBzpLqBofUTBhPAv+kHPN
         xnbLYw/HQEHcSXDGo/MsEIwDULENIUI2DjOu7FaxLf20z47v1jB4hOQVM8+h/dtUSWuA
         Huad4XrUbSt2huhknXAZm69P7K39vzDpsm78GB8R7RVLm4iIGx38t1fPo+iUWCefShph
         LTcxuLwq/gdwnaw2WRnq124E1X6F8KEO4k0pUIeIFWoCUQX++0hyI5bKE9IoE386ynYr
         iqWQ==
X-Gm-Message-State: AOJu0YwXhFaFFCop5KQYKdXEP7rHClMw7tV9pCBDQyx7PsbietRIbR66
	pzH9OgrEarCc+ugBSZB8Day+3paA5Rwz4SWU9jeRzMyxLb1meiLaMkIllkhzjDcaNcNwhuUY9jU
	7
X-Google-Smtp-Source: AGHT+IFqKNOtM7UgT7AYC29dcw8raaeuwMzF/VpPH0z2HRNDGR2sp/uQxYQenaFEXXjj0Uh3m3BDGw==
X-Received: by 2002:a05:6a00:2e26:b0:71e:13ac:d835 with SMTP id d2e1a72fcca58-71e1db7b230mr5390770b3a.11.1728493493007;
        Wed, 09 Oct 2024 10:04:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd3dd7sm8032275b3a.81.2024.10.09.10.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:04:52 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:04:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] igc: Link queues to NAPI instances
Message-ID: <Zwa3sW-4s7oqktX3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <20241003233850.199495-3-jdamato@fastly.com>
 <87msjg46lw.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msjg46lw.fsf@kurt.kurt.home>

On Mon, Oct 07, 2024 at 11:14:51AM +0200, Kurt Kanzenbach wrote:
> Hi Joe,
> 
> On Thu Oct 03 2024, Joe Damato wrote:
> > Link queues to NAPI instances via netdev-genl API so that users can
> > query this information with netlink:
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> >
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> >
> > Since igc uses only combined queues, you'll note that the same NAPI ID
> > is present for both rx and tx queues at the same index, for example
> > index 0:
> >
> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 7964bbedb16c..b3bd5bf29fa7 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >  void igc_up(struct igc_adapter *adapter)
> >  {
> >  	struct igc_hw *hw = &adapter->hw;
> > +	struct napi_struct *napi;
> >  	int i = 0;
> >  
> >  	/* hardware has been reset, we need to reload some things */
> > @@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
> >  
> >  	clear_bit(__IGC_DOWN, &adapter->state);
> >  
> > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > -		napi_enable(&adapter->q_vector[i]->napi);
> > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > +		napi = &adapter->q_vector[i]->napi;
> > +		napi_enable(napi);
> > +		/* igc only supports combined queues, so link each NAPI to both
> > +		 * TX and RX
> > +		 */
> 
> igc has IGC_FLAG_QUEUE_PAIRS. For example there may be 2 queues
> configured, but 4 vectors active (and 4 IRQs). Is your patch working
> with that?  Can be tested easily with `ethtool -L <inf> combined 2` or
> by booting with only 2 CPUs.

I tested what you asked, here's what it looks like on my system:

16 core Intel(R) Core(TM) i7-1360P

lspci:
Ethernet controller: Intel Corporation Device 125c (rev 04)
                     Subsystem: Intel Corporation Device 3037

ethtool -i:
firmware-version: 2017:888d

$ sudo ethtool -L enp86s0 combined 2
$ sudo ethtool -l enp86s0
Channel parameters for enp86s0:
Pre-set maximums:
RX:		n/a
TX:		n/a
Other:		1
Combined:	4
Current hardware settings:
RX:		n/a
TX:		n/a
Other:		1
Combined:	2

$ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
 144
 145
 146
 147
 148

Note that IRQ 144 is the "other" IRQ, so if we ignore that one...
/proc/interrupts shows 4 IRQs, despite there being only 2 queues.

Querying netlink to see which IRQs map to which NAPIs:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8200, 'ifindex': 2, 'irq': 148},
 {'id': 8199, 'ifindex': 2, 'irq': 147},
 {'id': 8198, 'ifindex': 2, 'irq': 146},
 {'id': 8197, 'ifindex': 2, 'irq': 145}]

This suggests that all 4 IRQs are assigned to a NAPI (this mapping
happens due to netif_napi_set_irq in patch 1).

Now query the queues and which NAPIs they are associated with (which
is what patch 2 adds):

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \ 
                         --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'}]

As you can see above, since the queues are combined and there are
only 2 of them, NAPI IDs 8197 and 8198 (which are triggered via IRQ
145 and 146) are displayed.

Does that cover the case you had in mind? If not let me know and I
am happy to test any other cases you like.

Thanks for taking a look at the code.

- Joe

