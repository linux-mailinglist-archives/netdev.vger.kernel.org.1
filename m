Return-Path: <netdev+bounces-196300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD4AD41BD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03F83A28EA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E72238D56;
	Tue, 10 Jun 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="vuO/4izA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cs2aiyqw"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61E1DE2A8
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579150; cv=none; b=bGPxutHUTraxcZyQUEOxjKMLFyi9Lz5maifVkjaxarDwjX+FT/SoQ/sWXlIbcRGg1x6Z5tN4BQtC5Bav/9uTd2ec6QAOBJcY8bBtkm/bb+msPRCvKqoUSzSi3F6EtmLclSwcIKo5N1NKORhsPVNgADCQSzNWjX/6VHaPtXNs4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579150; c=relaxed/simple;
	bh=0DO9ji7fhUKeP8C4dffS5kIgVpayLGI6iU9FypMtU1c=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gC5UPxSepWNDN2RfapXsyOL6/gSSieJ/CyKVGiYXYRjsOOyk8XGm2BcIl3/TM07tyOU8LlHZ1tmL7kbWo4I5cn1LOaUx1aR9rBUccdBdktD2Rk2ec2iXZR/s4SpFtMjkN/6Hw9sGZYXC2ZFni031N6l5QUdKKPy2iQUPIm1jKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=vuO/4izA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cs2aiyqw; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DD5F1140152;
	Tue, 10 Jun 2025 14:12:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 14:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1749579145; x=
	1749665545; bh=OoZ5u0oIBWN0fzLecqeatxwyVSEZ+6Btjcye8WjMJVM=; b=v
	uO/4izAf8kmSVcAgo0zJr+JnvAK5kYhOe3m3kf1PU36+dpjnMj95X1bmIEWRuy4l
	p4FXle5D4r/HdZT51DAbMrQLf1d7tZ0mmNjWx27UgUqglhJwq1BcWu0Bs0mwdHGZ
	aLyRW6tPhwYXSMCOpVzJAAiJMeBi75vfZS7hhpsr1JWv+lPFSe58Nk6wjM37S3tE
	UC/iTqvZUi2dQPg85Q6IT3Z7j9+UfzaQgSztndRsdT24h2IBB07mFCDKUejMJ49D
	wk4KsHSO1wf2lsCAWm6s9cAHBJNeLwphbrn/JSw5FK0PuKxsZ2uSKEWZIUy/dN+p
	E9/M+9IdcjWx5YeaY/Dfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749579145; x=1749665545; bh=O
	oZ5u0oIBWN0fzLecqeatxwyVSEZ+6Btjcye8WjMJVM=; b=Cs2aiyqwK8u79uE28
	/k+VuiOnnFuhdy+85VwXVs04frpIXjN5ACy2qhfIGZuDOtFQE2QaDYLncAM605ws
	J75qYKLyRnedStcjA7FfoQXv8h7s8BxzZRa5tM2dxrU/TY4R1gSmNsV7QNuR3kap
	xJ0RPxnBnyqM9F+4P64sQYxitaWyGdmlskdrRSdUii0/mMU0oC48Ly2/D+aMcGz6
	D2E4VtjLp81y7f2Lh594cHBbVuG4cOFNcc44yjCs6xretb3pHrArSbzZM1FMa4Fh
	InGB11/GcvVEl30NvNwEBpEx2GofCmbLidCSnBm79j7r7GLYZFdUN+HOHmghjP9j
	lOxiw==
X-ME-Sender: <xms:iXVIaO7EssFhD02b0xYv8uBu1ocOdZpEWUd-Sbv_LwHC_JbPJcrGjQ>
    <xme:iXVIaH7JaU0-Y1VL4rrrVcC2YER7HYsn9h2cOm6SzHmzp7lGkBGqOjpEH6sQFec1q
    -g5TTSMZTfzrIlQZg8>
X-ME-Received: <xmr:iXVIaNdWmvxOdfG-NGnbgmC1CQN4m9daozf_PiHwqPsrNn7W072oVL-NIFI0u719P-LouQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtfffksehttdertdertddv
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepjedvgffhteevvddufedvjeegleetveekveegtdfh
    udekveeijeeuheekgeffjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhmhhoohhrvgesqhhumhhulh
    hordgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iXVIaLKP0_xJNaRybGpOA9EqS25g_SjOvs_33G_uAv2ZD5tBkRk9eA>
    <xmx:iXVIaCLfickWhxFS8FGbNjKDuNtCR1kgPiG6ViiE2d9UQKFkU3WzOw>
    <xmx:iXVIaMwpa151-h4K1CjIx-wn8xX6eKAgZCLVRaq6L7XFndOt4_MWww>
    <xmx:iXVIaGKl213e5ZOdLreBa_pn8yksZrZPA5LW8Ghf1eDV8KqNTeyJaw>
    <xmx:iXVIaDzEgQ-H7iBJt-ZGBDmnlFB1Qr_4g5v213nHKJJqK_yNZ_GB5bql>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 14:12:25 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 75EC49FCA9; Tue, 10 Jun 2025 11:12:24 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 731659FCA8;
	Tue, 10 Jun 2025 11:12:24 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Haylin Moore <hmoore@qumulo.com>
cc: netdev@vger.kernel.org
Subject: Re: bond_eth_hash only uses the fifth byte of MAC address
In-reply-to: 
 <CALnKHDCKs-_XvW0jFAu1yv-Ex_OabqzuyBy=US_W-jzwy9N3Ug@mail.gmail.com>
References: 
 <CALnKHDCKs-_XvW0jFAu1yv-Ex_OabqzuyBy=US_W-jzwy9N3Ug@mail.gmail.com>
Comments: In-reply-to Haylin Moore <hmoore@qumulo.com>
   message dated "Tue, 10 Jun 2025 09:54:25 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1518703.1749579144.1@famine>
Date: Tue, 10 Jun 2025 11:12:24 -0700
Message-ID: <1518704.1749579144@famine>

Haylin Moore <hmoore@qumulo.com> wrote:

>Hello All,
>
>I am currently digging into the source code powering layer2+3 bonding
>and saw that for bond_eth_hash only the 5th byte of both the source
>and destination MAC address is used in the XOR.
>
>Is there a reason for this? I was not able to find anything searching
>the mailing lists or the web. This functionality while documented just
>feels weird to me.

	My recollection, which could be totally wrong, is that the
described algorithm was chosen to mimic what was available on Cisco
Etherchannel at the time.  Bonding's balance-xor mode was originally
developed to interoperate with Etherchannel, before LACP became popular,
so this would have been implemented circa 2000-2002.

	Development on bonding was done out of tree at that time, and
updates were distributed on sourceforge, with discussion primarily on
the bonding-devel mailing list.  marc.info has the bonding-devel list
archived; you might be able to find the original discussion there.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

