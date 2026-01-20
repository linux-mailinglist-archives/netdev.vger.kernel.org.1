Return-Path: <netdev+bounces-251628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLmXGuQKcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:08:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CCE4D836
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 602F566F0F6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BE44DB77;
	Tue, 20 Jan 2026 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoGyE5XA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CD3B5305
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948299; cv=none; b=nvW+KScCnCIAHM4JeDvMgS/auZrzAG8EzMeFoBpeZeReqeAOma9Qogip3bHOLKsPkbfv1Ne1RiDTC/f+QHGC1/59hj2q9kagrkkFNbV8JlttM29auRwtfVWLurjRlOOT51EButaB1F1K/4MaPntunS3CjEFzB2k9Pu9PcVBgyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948299; c=relaxed/simple;
	bh=KT7crfYGC+gc35aZUssQokbzc2G2zw05Q7/bzVHxgsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0G1/bVxU8L3aljkiPUlpRoJTrtYb2l30TwInXCLckPkz0LerHN6PjfhnstvZThgKqO+kI72/nOZ2eeLvWbP99dHevTF+iMlHUNo27aEonFTlrMaCypQXstE2KteK3nT1jtGQcO0rugfnTcB9tR43fNNFJ8ugJEcvCmqFFCr3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoGyE5XA; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so11111606eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768948292; x=1769553092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oK1Xva04K7ygLWg0U7fdlOWooXBJszh65DA1fNcqFD8=;
        b=UoGyE5XA/4IPLlWoyVdKaPXt4eHUQ1cD1T38G7F4r1Q4XuH3aPJIpHv/EETsZBvDy9
         nMCL69ZE0bhsgASs8dhuTIzuDxkRlcH+Y55gL73D6C3CnQx7UlrY2saYyZdTuE8LZ+gL
         19L8eP9nolk2Y9l19T4oHZyFiDtS99R4t4Lp06Eu2f1EGM7HnUfpaMQA1pdXZ51ZSXJg
         Ebl/Bk+FdsT5WeAwipH8uHYAmBmOV64dll/aDFNmt1/orFHr+yEtS2GQnWjPmP87MBrL
         6NiDws33UUAjVxiGt5h8I1C1+IVSaYk1S15OEZKaJ3s5jUf20Lq0Wdr1Pq6vVWp71Fzi
         V/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768948292; x=1769553092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK1Xva04K7ygLWg0U7fdlOWooXBJszh65DA1fNcqFD8=;
        b=f4nJouXPJlexulwcInHNrIzSuk2JuyOkMQfVzj3iLj8hKn7kY1DqBkekYAfHaJoMFi
         9p11JjMoSbnIDqp0FF9ZbCO37kmcegm1q6aQaQZfZJGs50AroojKJvPDq/6ofpaP7DG7
         Xq+pfPpahBh6RgGYFMkJZwR66jyAK5346JHM9lV/LfRWszx3AFotKCJqVVZTP5m24GFX
         r3j8UyT8KVnBlsTM4DVCltDmxqiDFi6Ztac4oIB3pp1MmfA7vzxFzUbbKNHFlHZu5isf
         LuumopK+KJWTaUFoR/Dikr1gIFw0YarVh3PWaY5BAvg3+fv4LdBF3SRdWSf2Xd1sl+h4
         F11w==
X-Forwarded-Encrypted: i=1; AJvYcCWs4Pp/zFbswG6UeJIAX0oBAUpJh1QAZiEa90wIR7MWk93nBW0O2FT1/RWnHwuBvpnQvB5vtLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQuj+fy9/PT9XwEfJQjfMXcqap8j1Yqe9TXNzxc9/Mk7GtTaN
	4gFUv9sfLzWUttI3zCa/FlFrVxsSV9ECQnJabM0B7S/t3/MM0Ku6DN6I
X-Gm-Gg: AZuq6aJufu6URX911xw3Pnv9WVEw4WyAazt7x/XT8+a5y1dO1bcDdqY7oaaL7m59wGA
	qCcO9Ap4XepV2bQXGgDE1xYoI1NtODOGnuHjQ+VURFYW5GY4uPSoUKRPiXunVY17+ojLs2d3iX1
	GS5cknVKhTD7xNt6qut6bHCR+DyLDc12dyAyQSNCH1vP4AP4c2sSvm0Hl6I3HgbdtZN5S/t45UH
	j3xshtQViMbjEDUPEMZ79KdpeElRN71Dbgvv3qwutyIUJ7IjAn9kxm8FJmNGCCmk5ajT8NlhrvU
	6BWLkhcQBF57vI1rp5xpzWqS4wBgIckEXOlksl5EeLjMu8xCFNU6K7P7+WaxLYGSVd0bYA9RXR2
	882PgB0oFGcyZDuh0Q+9QptlSMsUHiquYTfb+oMvJjtySd3yZWlnY25bHYXW0zHIJOI430fgqI9
	ZfdK95Wchd7wu0diBVtsQg
X-Received: by 2002:a05:7300:1493:b0:2ae:5a55:fc0a with SMTP id 5a478bee46e88-2b6b4e287acmr16477739eec.7.1768948292340;
        Tue, 20 Jan 2026 14:31:32 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b712881482sm499886eec.5.2026.01.20.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:31:32 -0800 (PST)
Date: Wed, 21 Jan 2026 06:31:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Yao Zi <me@ziyao.cc>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: Add support for Spacemit
 K3 dwmac
Message-ID: <aXABw0zVz8n3jLlm@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-2-inochiama@gmail.com>
 <aW9fL7r0AM0flALJ@pie>
 <aW9ou-lsQQ5dVzqW@inochi.infowork>
 <9334905d-d11b-49d4-92b1-61e8cf644f0f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9334905d-d11b-49d4-92b1-61e8cf644f0f@lunn.ch>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziyao.cc,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,inochi.infowork:mid]
X-Rspamd-Queue-Id: 36CCE4D836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:48:12PM +0100, Andrew Lunn wrote:
> > IIRC, the "phy" clock is used to pass the phy from the mac core, I will
> > double check if it is possible to connect to the phy directly.
> 
> Are you saying this is the reference clock output from the MAC being
> fed to the PHY? That would be a clock provider, not a clock consumer.
> 
> Or is it the reference clock output from the PHY going to the MAC?
> Then the MAC would be a consumer.
> 
> And there are some designs which have a third party generate the
> clock, and both the MAC and the PHY consume it.
> 

I have confirmed the clock is directly from the the clock tree and
is consumed only by the PHY. It seems like I have got a wrong
information about this. So let's remove it and let the phy consume
the clock if it use this clock.

Regards,
Inochi

