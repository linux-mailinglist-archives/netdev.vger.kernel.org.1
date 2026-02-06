Return-Path: <netdev+bounces-257599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AjtEW0NhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:49:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3BFFE43
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AC633003BDE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20752D8780;
	Fri,  6 Feb 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmBObHnS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A22848BA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392935; cv=none; b=fR+4dCRRmlPIX6onvoL1cBvEyP3rxhtwc26Is8Tb015YgccMyWGB5q8dNBE/PvMGiNkycgznVVCcL/JiKeCpeRGHoIu9PxbeaM6xRZjOr4fAKXpeGmUbla/5t7StNYZudbe0Nb3GEkH83MmHnOZjpLSXkaguzNUDHlvEt5t5Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392935; c=relaxed/simple;
	bh=TkbPZDuaM3Ey72aDzPp4NX/g8lmpJuu7rhdPRlsL9O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZejNS77f0LcscwUf236+NSxfn/rzUaDvU/jf0rs/AhSqD6JKGFWGa2qgYzpZyleCRrSmKZQPcBd8N+sTqbZ8mDVYKzteeJh/iAcop65RfwwajHtRxUjMA2yD+N+xzcikM6/SPH4/aBekTJARCc+6v6qKHdM4VA6SHxT0z1azdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmBObHnS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6ac42b91eso261548385a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392934; x=1770997734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqv9UpiwsosaHO0SvN6INhsVJ7z4ijgNCpwtXYUpMxA=;
        b=QmBObHnSvZVD7FGWc5dUpMU11tgC3srNUiQns6Wqu/DRXXW9n4IIYnaRucy6WFIkuO
         //WmGsPSjdMuNmVFTQnFwznoG6vNtTpTcum2YSm9zFgL7O9nBuirdOTHKVxz103Fu9N4
         i2HdlzHjyYl9/F6SWttAg/VIpRNhf7h7R0bnV0nVxJ/zyIVmb3DSGmdxMtd6tzQiFNTO
         ECpaOBHalwNJ8+kUAbcl4ZSXM1TEi3ptwQfjDkQ3nAFtmBIAwxbGr2RGPcDxRefSz2IO
         StdsSqRc/lO1iTmGf7BIwO1zyI406G0wSWFAtQ05A3GQSX+0YZlQwHD3aOX5iiQNlaMC
         egeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392934; x=1770997734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqv9UpiwsosaHO0SvN6INhsVJ7z4ijgNCpwtXYUpMxA=;
        b=rcsB0udlEj93znsVmPS1JH9+zk4jOYZz6/WBD5ypdVHQctO+yVUKAtd0KTN+IOiKym
         j5QU2P0IaoIhh4FMLOCdQKVimQRsygIj0gsTtDssCmsR+mLEMYHH9Y9hE/GYbjUl54wT
         3ocnf7G1Ns4neixLyLubyRusZySyhYKdnApzP/nhMZfoeZelL8zgFoeeQX/WRjAhBDpr
         ruf7Vq/G8RfU0P8YLBVQ6kvZveRA4S8jEMDuTBXPPO4q7G+FUvKF71pBO4fYgPiCSTt/
         5CG4xEpsEHlaoVgxJI30ysAZMd6WdP4l9t2rIhCxIFK9YBbTWsGEhz1aHfYpr5URHtJE
         zouQ==
X-Gm-Message-State: AOJu0YztbteLbYKRt2Hdqs4LDA8J5IHAJ/n1reHcCKMNIMlLL7ywHfFI
	UxTxSBb+8P7N0YYidLozZWnNGX9104U4DXzhVCRy+fTLzf5KbzOQr/+w
X-Gm-Gg: AZuq6aJlHtjP4NwDMduKJiNh5ppDNwnC5BUBe8L6PkDws9ki99nv0aiY3p0oXmRnUS4
	zzEh1nufH6qvS3lbNR1OZ5Nm1NZv0yy/BPgHlCn3TwJmCcb4ez1BFHzMgEBsQurKvww9G49hKdG
	jDzQJf9sP0nDf72QbzAiu1z9nRL3g0iW5ZGk7kqxQAYQ83UWe9TA3a1QpDJr7SfT1d++oeGbrj4
	IafaTu+6YxSRd1xdFHw8Wn/f0NW0zmruSQJ45SrX1QH2V2Ndl9cp5e/0bAflWrJTtF08TDBxiwh
	eh3+06dBGn4HZAvNOJDeI73c6VIU+49scxdVKUepwnvD9VrZozBxnjIaOWHyA9G8+vLMOv9mqcK
	yai8iQgA1AS73k7I4VSwMShUBRMndIjXj7uCPRWx4EStHM992SbtjEudB9hvl0G/hD0jX4gPZXF
	wsx5FTJehCwQ8sM5J/R0f19oiYQ55d2iF7dVnmDrshj7eX
X-Received: by 2002:a05:620a:bc9:b0:8c6:a723:415a with SMTP id af79cd13be357-8caef4094cbmr422856485a.11.1770392934093;
        Fri, 06 Feb 2026 07:48:54 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed8bsm183883785a.20.2026.02.06.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:48:53 -0800 (PST)
Date: Fri, 6 Feb 2026 10:48:51 -0500
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Lee Trager <lee@trager.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 0/5] eth fbnic: Add fbnic self tests
Message-ID: <aYYNYxxUSHHOYiDF@PF5YBGDS.localdomain>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206154246.814-1-mike.marciniszyn@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257599-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,PF5YBGDS.localdomain:mid]
X-Rspamd-Queue-Id: 55A3BFFE43
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:42:40AM -0500, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>
> This series adds self tests to test the registers, the
> msix interrupts, the tlv, and the firmware mailbox.
>
> This series assumes that the
> [PATCH net-next 0/2] Add debugfs hooks [1]
> is present.
>
> When the self tests are run the with ethtool -t:
>
>         ethtool -t eth0
>         The test result is PASS
>         The test extra info:
>         Register test (offline)  0
>         MSI-X Interrupt test (offline)   0
>         FW mailbox test (on/offline)     0
>
> Mike Marciniszyn (Meta) (5):
>   net: export netif_open for self_test usage
>   eth fbnic: Add register self test
>   eth fbnic: Add msix self test
>   eth fbnic: TLV support for use by MBX self test
>   eth fbnic: Add mailbox self test
>
> Link: https://patch.msgid.link/20260127200644.11640-1-mike.marciniszyn@gmail.com/ [1]
>
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 126 ++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   4 +
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  93 ++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  92 ++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_irq.c   | 154 ++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   | 276 ++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  26 ++
>  net/core/dev.c                                |   1 +
>  10 files changed, 776 insertions(+)
>
> --
> 2.43.0
>

Ignore the v12.  This is v1.

Mike

