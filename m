Return-Path: <netdev+bounces-263369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIetNhMtp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:48:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 425161F5747
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B49230713C1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD949218A;
	Tue,  3 Mar 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zm5leosn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C9492519
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563692; cv=none; b=HNSg5A/Buv1VoEnsSJGunsCrFPrKB/tWclj64lOeRISd6Pojs6y72QPES0AkhSyeO+2NiFtoD3AEC+ljKxiIY0FraTRui3WRCC9jonK+xDGO5gYioKcsHaY6HKMpkFRr3n8d8CPtBZ4E0k98IFMqLKqTjkZMpo4RZ7aOnvjpdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563692; c=relaxed/simple;
	bh=ttzqQEcVrPb/nmW7Y+klXQCF2FmI64whE3fDRja4xHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU/LYBk9d9ggUWTFPZnfGQwtGq3JJoJHfRsOEdDF9TDhFloYDWapDUZKhZj2HSGHUHicKLkf0jIx6eTYxevSlcWG/RUoCW+DQC5hwFneNqLNLt3HXgOrrJ7UNhV3hMzp5zgqygv7qZYETqfb2scC2FmcMwM1J1epDyTzpa9v59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zm5leosn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2669167b3a.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772563690; x=1773168490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/gvGEJPIh9oms2y2n2+7WYpJ/cio0F68+jb7Mp93Es=;
        b=zm5leosnHjkYW8qnNHi3Vasu4XmWIklY8SJ2SMXSMzwKSHcu2M2L/PakC4owyAtP/Y
         2bdup48hepvbjVdSivCQRUwAGsFMQiPdwenjid0a5NylzS3w1CZmaixQfUf1eDNu9jW/
         Ca4GZvW3FTCEdW+Ijp3o7ds1OMJKinQoNr3gvNALVdMCkX3uaDRNtlkYixcefhAnHnyp
         dPlXVpKJu5Uhr1kV1D+MLEDPLRZYnGPw8UyfinDX3tZH4wiEbAtBoixHaaBWU9SYrt98
         4AGaVibPmTuAcJEfzU8mDfl4FAA147aKLAsjPtF95khhDuPbb5S8XqUBYb/CTWMNhXrO
         UTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563690; x=1773168490;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/gvGEJPIh9oms2y2n2+7WYpJ/cio0F68+jb7Mp93Es=;
        b=ooVEMp0K8uDOQ3qkTet8+oxQrJLk6qx8mygoT84+bbi8xQ9nlp27OgEpDLh+BKOT2E
         FxpdmMwFMGlQ91019aVl0YMx+/wjpJK/UonVX+De6DFezOOw0EZP7D29rk0v0A4zvw1M
         sZhZeyrbV7IXJlAmtcx0f5CWxVW6scMg9KnRCEqlroqnOjBTQLlGaCFUhXoZ9ASzo8I6
         tN4D+qrvjt/NJbMhOXLxMvedGc7jsbgfh6TIjm0MZqGmwbLPDzDtPiMcEUuufOXDWbfp
         krvZqpg5WxZGlwu4l2YvAqQaFzy6KW9FyYC2wnD+q4s7WwxospFmwnbw5udYIwKHZMuN
         6sTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMc9xCklrzrHdkCc6vp6dejj5Yv38MHgkJCOEfkHDGTTiLFyYyA1khHqi2GoeJdK/Y53xEJb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCifbA43M4d9N6wvCqDBZTDD0OUazkOoxDsLYa7pXL/S7d2UiP
	Zo9ackgV6Al8w2CxBcOnstpRr3FjPHi4EO1y6JCjGL7LgHxkwXC6wXjl4JcaYiz1wn0=
X-Gm-Gg: ATEYQzzWPNWZxyQjgAqJkUQ1vgBHbdkACr9L9MwcC9oxnF+n7BPnmmawZBYZji+q4Be
	OlmVdh4lbnJyaRoSWBdU1PXrbyRuV32flrUFtDDmVWs5sb97+6NxvajFjRkXAwUldE4NpDCIaSB
	r7vUqzi+ThUGeX0bKqGoAR5kVj7RjTUizHwfk1Ds+Lij+fLg6WRyk0SZG48vk5jzehAX+aPbO57
	0Wp7xv4442K2b7KGJZpNPB6tTXGY7uNJKGDUq1GOb2oa7pYqyib+elcDLVskf0ukVgZjhU1Q/Tk
	QFDmhHir0EeLCt30RYvghSwuOYzXiyLNn/0fCEvADDDfzUcrVE767rVJBeBq4iKInbzV/tL5XSb
	knJJgzJjh7clAoK7MCZD1LIzo/EYuTtgRa+juu78dEabejxfG8sR5J1lgt+9N3N6/YNRljayCim
	NSp22g
X-Received: by 2002:a17:90b:2747:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-35965c3475bmr14809639a91.9.1772563690200;
        Tue, 03 Mar 2026 10:48:10 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3abc40sm2916519a91.14.2026.03.03.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:48:09 -0800 (PST)
Date: Tue, 3 Mar 2026 10:48:08 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aacs6Nli7ku7uuTn@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
 <20260303024510.644962-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-4-carges@cloudflare.com>
X-Rspamd-Queue-Id: 425161F5747
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:43:51PM -0600, Chris J Arges wrote:
> This moves a few functions which can be useful to other python programs
> that manipulate XDP programs. This also refactors xdp.py to use the
> refactored functions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
>  4 files changed, 95 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

Took a quick look and it didn't seem like anything changed in this patch from
the last revision I reviewed:

Reviewed-by: Joe Damato <joe@dama.to>

