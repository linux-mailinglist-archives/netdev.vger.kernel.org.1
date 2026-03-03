Return-Path: <netdev+bounces-263453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPncHdtlp2mghAAAu9opvQ
	(envelope-from <netdev+bounces-263453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:51:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB531F82B8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80E2430354A5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36135361653;
	Tue,  3 Mar 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="i1xzRmq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2E16DC28
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578265; cv=none; b=T2hUXFS/XBY0PbnN0/sDjPie9Eji7WY7TbWcmJuitr/YHLHCcBnVU2TSsO1SaWhwo3ERVRCM0RRDWmhimTP2J3jVaMryDdlpn2SVt6zZRhpsCc2KdQiJ62CE8oRDegTWdxX7W0ZUMHwUytjFraJ+f1SA4J2dT57jhyp6wRME6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578265; c=relaxed/simple;
	bh=oJPg8ngFkWbAjDHnV+FPiRZWOJRL0IebQ2cas9eMRqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQlBmFdEJdDR6+R7EecJatLc/GaCUElXcK5jgbLT+Glu8ObeYfGGYqb2lKPBp8h3fDK+Qcipadu1WpHQfUg8yqK4USorgWfwRt87Y7NH+VB3dwnJockNcZiUt48lRXiyWBj4TrwWxAY2UrNHfdxvyzqRxkUzBBvZKDzMWlbEGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=i1xzRmq5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35980423087so1637803a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772578263; x=1773183063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8nfthd7ZxjhMqe0CrJ3b93FJHo4Cq0tHeMrNC2OcZ4=;
        b=i1xzRmq5/yeivJB1hT7EHHUTTWtE4bZyOR2RJGF1RJYFTKa5Ib5Pu4pT7Qo8rXRnbd
         KkPunPet/2MqFl8UZDRocS1+w02C7Wp95l43FyShjxZxzww7FecwGxuJC22OkFhI2x2I
         ws7Lacfs5pAAicVCRnnW9Tx+DHN3K90sn/3MigKOWSxIvmIWxzlZOSy1GfAHyYI0VRcc
         IdYl+matDGZo01OmKnCnkoxbE29Pf4/vbAGtjZ8fn3mSwL1Q2c4xuM72xfuJA6/CrjOt
         mD8qvYW0qGJQ3A4jgBEsAkPCYD3+A3ewXnfeLaBYauon1y8Dvc9oA1TAuSzpDhz83HuP
         VDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578263; x=1773183063;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8nfthd7ZxjhMqe0CrJ3b93FJHo4Cq0tHeMrNC2OcZ4=;
        b=da5z7emxECAGzm8Wc1xCGVKsL8r08dbXILMGtLYZ0ykCsHp324WQKj/nj457MotmRL
         b9NCOLZ24fD3de9a8CvewZOX7A4we7bmuT1G58dhj5jFKgJ4vBHr5yNJNG00/aSID2YV
         KMF7H55uGl8ujB57Rvvdv0743JbVoCPPlaJjTWhgy3SGf1rQ8afWvb+pl6/91kao7ADy
         LL44exj4OtXgzdp7TMhkWwXUgq9tFkcbm0ukCrvockMmfaU17hRObOT0oscsvoUYW0qv
         bf2HaCHOw8B0arNIIFkTn5JFN3g6GoWYKqO4p23dSqwndnNlqnX023OTQ3x/YbnhB5bN
         ftYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhgvSGUrq/PKb4FWou+YCUn6ROHqvni1RBJwV8IxtLejVrEGPqRFhUFlyP8+mv49xOKDMExTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXMR75m/zrNAL+WO3B73CT3qr4aW2se1TYnWNJZHQ6iF/gCVA
	oGIQpaUEIaIlR1huxKEpc4kP+O/0leEn5OXSYDV2RLqq42VdrTiMmtUsnaJsgOSCCwaZtl80T5K
	t/wPcrRk=
X-Gm-Gg: ATEYQzxmDtVtfKiagBZjePSDWThbDVbOupvorSE//dQyI6oHsqUrw2L3VBgIg2mMORT
	aZcqwLUjIglkexF0HME6OpHntCfs+K7+GaCx7waCehyuMIWac90Lo/K/SX14SYje9p5D7uPx1aO
	gh6xjYGfNJ4ysAIVjTh6ty7kKnGylsbXm6ZifuLK6YmrJO7Yrhkt3692VgL9z2eWvcM+pwmvPyu
	UJbDx0Lc1+nF7WXVitRK5N6/TRFK9ric/x3aMXE0zkYotDxB9ZehmkYBVdm4wCe000W9pT72gjB
	RB3LNM2XtC8nvDe/b1IHd154SLoWtVn0HwhK0BxJqRL5AoatVFtcDwozDKZs7lFqU41FUlwPFyf
	s+XVGoeZmEBk1Vq5nCikJG8mHuFqVL4Tx2xJdNZpAsQhnqrW2/8OMqIopDSBO1/ALvVUxVkqPcT
	yPj/Y=
X-Received: by 2002:a17:90b:3945:b0:359:94d8:34e7 with SMTP id 98e67ed59e1d1-359a6a7ea1amr17117a91.32.1772578263511;
        Tue, 03 Mar 2026 14:51:03 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599cc5cacdsm1772179a91.14.2026.03.03.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:51:03 -0800 (PST)
Date: Tue, 3 Mar 2026 14:51:02 -0800
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 5/5] nfc: rawsock: cancel tx_work before socket
 teardown
Message-ID: <aadl1gXK0u6HBYIT@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-6-kuba@kernel.org>
X-Rspamd-Queue-Id: 1AB531F82B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama-to.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:23:45AM -0800, Jakub Kicinski wrote:
> In rawsock_release(), cancel any pending tx_work and purge the write
> queue before orphaning the socket.  rawsock_tx_work runs on the system
> workqueue and calls nfc_data_exchange which dereferences the NCI
> device.  Without synchronization, tx_work can race with socket and
> device teardown when a process is killed (e.g. by SIGKILL), leading
> to use-after-free or leaked references.
> 
> Set SEND_SHUTDOWN first so that if tx_work is already running it will
> see the flag and skip transmitting, then use cancel_work_sync to wait
> for any in-progress execution to finish, and finally purge any
> remaining queued skbs.
> 
> Fixes: 23b7869c0fd0 ("NFC: add the NFC socket raw protocol")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/rawsock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>

