Return-Path: <netdev+bounces-164938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0BA2FCEF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0204E3A3DDD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DA24E4D1;
	Mon, 10 Feb 2025 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jCWCrwlP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0134264624
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226130; cv=none; b=Eg9/co3TpV6eGqyBQC+VbOQn7KSY/eiDmJ+sUgD8WMK2U6zRn/8/DK2T/KWi8Z48IUtlU6+LTkzjeNX81Wsh7EqmBxui2h9CRLkk0r6IxOMZnGPoYuH8G2hwQeNT57HLIuw1BX/QCQa/SBfRkmfuq+rO7VNPLztaco35qFSNNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226130; c=relaxed/simple;
	bh=dyVoUW/eys+SQpqte4PNXbCcpy3xrk5dn2Q+dm43u2Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt94m5J9LocdM3Jewa5VlfoHiuh2bSzOyCiXdK8zuegIgQvWZDQ0wVyGICaS6yX0P7H5sNiG+p2tOnaXpYzRhgncfebJOIzyWX7yq83Q/LyAMvABDlUtqIFfcYvLASQTLYpv/+ElkCw8Hs+yk5XrCGFAvLdtPt5/OqorAyi5lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jCWCrwlP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f6a47d617so40773555ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739226128; x=1739830928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fbq5bdkh5KGZmV4lXmeUGC15WHyvC1UK0TIUDiJsUQ0=;
        b=jCWCrwlPjVc0aknhkSKqwmLfKz7d0ipiyElJ6GwNaHaS1ELRQ46CtId9M4yPCXER10
         SfglCzjE26q3PaB1MZBE5ILS3gpTgo+1o9wDD2I4Y6kOfVIWGpF6iNl5V9WCj/eQA/3T
         4TAD6Fru2Q3AXqF90k1q/hHJGFMoBl8noK5gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739226128; x=1739830928;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbq5bdkh5KGZmV4lXmeUGC15WHyvC1UK0TIUDiJsUQ0=;
        b=nJBnC562yrYKYqL4Am9NVoDqUZUroaACznx/4hDcSEHBhIapUIwRE0ZERyX4SYBbbg
         gktmS0z6lC7fV1hSqPCYQ6SOqPWxawHZXuQBbLk6BJzxmX3eQg8ibQgETfBIONbZY1s6
         A7swQiXG9PR1I8FtbbgTacZStLCurOEp+6Qq4alihuuTx/ZsmMm7YK6KL/zBrd1vYpF4
         Hptyh/mzXMEma6CU1cpzS/QHuFi4O/kOLqW68twjSEdFJq61SXS5DfGRo7JCsMnjxI5a
         7mwDk1dBf+T8kSygMsCyZagK8WUaLVnwO2I9cZEgYzi8/EXV+aFbPh/WIGFrNPdY89qB
         zl8g==
X-Forwarded-Encrypted: i=1; AJvYcCUunOPNdJ0m3JecrvR/WoZK4E0dLR13prZBMJfwLLfm7xRsburAReE8S2q8fLp3GOMvmKp3B/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJsTqtIIVtYF9UdAnBvE2MnRo7W7SxfkK98Um4g5PU8gSyj5y
	jvryABveOYWHcomhTBeusEFTRnro0ZECat5sbOjiLR+jqgCRGpxf7/LtV6JG2Sk=
X-Gm-Gg: ASbGncv/wKTg/uHgvyB/fnQNBq2fjdST6B25V1CWT4mChtU2+v3ZcduABL+W/0JKU3c
	QCTlxwcjmeqm85Q/PlrN7U6LelAlXrwkGJ63XMx4vdKUrpzSYp3MbgvGdFINb5VZEhUZ2QqKkPw
	OlWrGLMZGHQad/EWpq4jiIWvpg0g6QEI6y3PvtimTn9+WUCy9lKjuNUfW2SjFbwJX8RsgvXv9Jt
	fI3kjnp8kau4eJPXSDt1lH2ZTlbrXn6Jvz/aIjshXh0HdU2xD92UMWEYVCz5/62WplUO69A3AFG
	NXUfcHq6PWmh22sb6zSodLTpVmJ0dFl/Na1/z1xuuaV50HDTKHUgUhyUAQ==
X-Google-Smtp-Source: AGHT+IFT1mfdHNlgzjIhjuvz926QB5vh22HSLx2qvqTalfE3+n+YY/zew1rCD6y0tP0B+x0g7qTHuQ==
X-Received: by 2002:a05:6a20:6f8b:b0:1ed:707e:7c4 with SMTP id adf61e73a8af0-1ee03b6fe02mr24807986637.38.1739226127931;
        Mon, 10 Feb 2025 14:22:07 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730aad5535fsm1205630b3a.51.2025.02.10.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:22:07 -0800 (PST)
Date: Mon, 10 Feb 2025 14:22:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] igb: Link IRQs to NAPI instances
Message-ID: <Z6p8DeQxCEpb6Nij@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-1-bde078cdb9df@linutronix.de>
 <Z6pEq9fs5RvglrVk@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6pEq9fs5RvglrVk@LQ3V64L9R2>

On Mon, Feb 10, 2025 at 10:25:47AM -0800, Joe Damato wrote:
> On Mon, Feb 10, 2025 at 10:19:35AM +0100, Kurt Kanzenbach wrote:
> > Link IRQs to NAPI instances via netdev-genl API. This allows users to query
> > that information via netlink:
> > 
> > |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > |                               --dump napi-get --json='{"ifindex": 2}'
> > |[{'defer-hard-irqs': 0,
> > |  'gro-flush-timeout': 0,
> > |  'id': 8204,
> > |  'ifindex': 2,
> > |  'irq': 127,
> > |  'irq-suspend-timeout': 0},
> > | {'defer-hard-irqs': 0,
> > |  'gro-flush-timeout': 0,
> > |  'id': 8203,
> > |  'ifindex': 2,
> > |  'irq': 126,
> > |  'irq-suspend-timeout': 0},
> > | {'defer-hard-irqs': 0,
> > |  'gro-flush-timeout': 0,
> > |  'id': 8202,
> > |  'ifindex': 2,
> > |  'irq': 125,
> > |  'irq-suspend-timeout': 0},
> > | {'defer-hard-irqs': 0,
> > |  'gro-flush-timeout': 0,
> > |  'id': 8201,
> > |  'ifindex': 2,
> > |  'irq': 124,
> > |  'irq-suspend-timeout': 0}]
> > |$ cat /proc/interrupts | grep enp2s0
> > |123:          0          1 IR-PCI-MSIX-0000:02:00.0   0-edge      enp2s0
> > |124:          0          7 IR-PCI-MSIX-0000:02:00.0   1-edge      enp2s0-TxRx-0
> > |125:          0          0 IR-PCI-MSIX-0000:02:00.0   2-edge      enp2s0-TxRx-1
> > |126:          0          5 IR-PCI-MSIX-0000:02:00.0   3-edge      enp2s0-TxRx-2
> > |127:          0          0 IR-PCI-MSIX-0000:02:00.0   4-edge      enp2s0-TxRx-3
> > 
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index d368b753a4675d01b5dfa50dee4cd218e6a5e14b..d4128d19cc08f62f95682069bb5ed9b8bbbf10cb 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -947,6 +947,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
> >  				  q_vector);
> >  		if (err)
> >  			goto err_free;
> > +
> > +		netif_napi_set_irq(&q_vector->napi,
> > +				   adapter->msix_entries[vector].vector);
> >  	}
> 
> As far as I can tell, all paths that lead here hold RTNL:

A nit on my own comment, netif_napi_set_irq doesn't ASSERT_RTNL (but
does hold net_device->lock); its the other functions in patch 2 that
ASSERT_RTNL.

My reviewed-by stands; just wanted to correct myself.

