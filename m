Return-Path: <netdev+bounces-263451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBRdBNNkp2mghAAAu9opvQ
	(envelope-from <netdev+bounces-263451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:46:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEB1F822D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91C3B30039BF
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0A31E823;
	Tue,  3 Mar 2026 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kiCEoxfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764A26D4F9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578000; cv=none; b=C0EBkG2kWz7zUIQfNvcXjcwE1wl5x+Oize9AKWdMnzwmCRfcoTfSxVbSoAycxSN7OMLVjKl1IyCTdP0miJZ53puVZ1LE+ifDTBCn7K6hlhhIzrpEDUtL+bjv6DeI015zEkX6edP6t9YArPZiss7X0S3zhcYP1vCing/Y1Ji+v7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578000; c=relaxed/simple;
	bh=15mPY02rEf1D69+S/sAF/O63FAH6R1FZWTAOmIK2dug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tER5f4PJRtUkMq/dEkSyiyswUQkEoIi3QzpQjFaXpk5dW0qjA+YZ+OYuH7IfP1aP+bi8/sHTk7XVHAxBmusfFcUOc/chVC16BJoe9L2uFDQkrJS9i8d+N6CtrD96TJ/XZPO6RsMb69XcmLYmztH/1OlQSdf8VtRVcpG5HLK2OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kiCEoxfi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8272a56b91cso5250866b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 14:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772577998; x=1773182798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIi+fDs163v4iN74yp1Z2WnYLFdEvhtUhAdwwnO5ji4=;
        b=kiCEoxfi2cUvN8W1oSqVfvVp0vBiPajqD/aAPhgwdB4bSdRyeeIhUyVlpydtVZRSf/
         P/P8gPPAESs4kWwO6Rnpxc+DOXlnzWq5sKSvXbppaNJcrvlGBlswFFgAA6FhwQbny0AR
         K2J/BagA4g7zs5aFjvbxKMBZ4Mpmx26a+nIGSfaYntkU3sXdgVwM3ye+Txxbz/s565cK
         Nfn7FhNvRQ4o8EWqLQ4PO0pbRRzezkCe3gr+fjcNbllffxA+p3Xdt8ERRNlbW3G4VTrW
         QolaGaLTSRGwIh4cJZggtka7w7Y7VS57N0yGfcsHvPyCnOZfT1KlqVERgZyJXH4+UzYR
         XupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577998; x=1773182798;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIi+fDs163v4iN74yp1Z2WnYLFdEvhtUhAdwwnO5ji4=;
        b=SbNXmuzd1ah38IU+QaiF4ivtocbvXnZrR51agr3CtfOwYjrmIXPQbeLr5gvMuyglyZ
         o1HPjGaVgQD0Bun5ZFzh6CWs5t5sRja+yiOUoeqdHJNKehOkw6tq5Fhkq5lXoZEv6ZcW
         4cevfSnqVEeExaribaW42YCK/txWAiTKM+jg4LWaY9eoTPCOla3OzOcDD5hwKMs0iSM2
         eEJPxHk7jKwCJovkSwSofh6PTB0Tx68t6ksP3omo/wY6o8LwvF0YS1rYnSc2wlX5XgaG
         OO6Yk/g0D9DHk2UKY62UoPDJTCa/wx0fmiyaBkKJDfZZYhiEmCnx6FTgQsb/Y0Yz2OYQ
         TpMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYmAOtflefejvWzXCM37WqHUdOKdC6RV1hr7I7RXj5astHCBB0ineDATVIlTpPVFVlBG1BTZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXn2BW3Gl+xs+rJu/hXSOw1MgvRDKREyoNraa70rXDf/3Fjzv4
	XMXDDz1Mgz4sijekxPQ2i4yNpof+jxl10nZc5BSFYDpuWGvqXFFTxicFkAeKzHaf4Rs=
X-Gm-Gg: ATEYQzw6Jx1UVs18aiw8yKvVMXy1QHzzWeLW/piuHYeGKee618KExtAYuaSsRpxXCxw
	E/G3tXzyjor2k53dYpa46JkgCXRqnltJ9imECeaPWHoI7X0unPYNKGFGFyeGMtMzhBU6k/oRRzc
	kVCFdvT35t/ARdNg06jTYqmWQLIjP2DLO0duH8vgJb1Tz8x3VXWlx/QkW6GlTwtDiDzNIpOaRE9
	GjrsqYlcTNXFqTkFBUEwqb8DDGv09TOT9XJpg9HAPS/c1UNq6GP3ClYzH6brq1cdWrixkUvQRJB
	WSMikU3NoaT26FP4Mszjk1N4xkAojwWHv3dH6TKv+gcx8TelOM2ZfvUAu/6h7kYS5TMaxt7I0Mj
	pKB/nldaH3cbV7A8bWU3ZqXyYhNc/an+AZOoMOVc8ovY6IcBtEp8P1JYi5pyaUVuUK14dge1kyl
	51yGw=
X-Received: by 2002:a05:6a00:464e:b0:806:12ff:3877 with SMTP id d2e1a72fcca58-8274d9082ccmr15638720b3a.4.1772577998626;
        Tue, 03 Mar 2026 14:46:38 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d5689csm21411917b3a.13.2026.03.03.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:46:38 -0800 (PST)
Date: Tue, 3 Mar 2026 14:46:36 -0800
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 4/5] nfc: nci: clear NCI_DATA_EXCHANGE before calling
 completion callback
Message-ID: <aadkzLW8Ba1Ej46V@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-5-kuba@kernel.org>
X-Rspamd-Queue-Id: A1AEB1F822D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263451-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:23:44AM -0800, Jakub Kicinski wrote:
> Move clear_bit(NCI_DATA_EXCHANGE) before invoking the data exchange
> callback in nci_data_exchange_complete().
> 
> The callback (e.g. rawsock_data_exchange_complete) may immediately
> schedule another data exchange via schedule_work(tx_work).  On a
> multi-CPU system, tx_work can run and reach nci_transceive() before
> the current nci_data_exchange_complete() clears the flag, causing
> test_and_set_bit(NCI_DATA_EXCHANGE) to return -EBUSY and the new
> transfer to fail.
> 
> This causes intermittent flakes in nci/nci_dev in NIPA:
> 
>   # #  RUN           NCI.NCI1_0.t4t_tag_read ...
>   # # t4t_tag_read: Test terminated by timeout
>   # #          FAIL  NCI.NCI1_0.t4t_tag_read
>   # not ok 3 NCI.NCI1_0.t4t_tag_read
> 
> Fixes: 38f04c6b1b68 ("NFC: protect nci_data_exchange transactions")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/nci/data.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

