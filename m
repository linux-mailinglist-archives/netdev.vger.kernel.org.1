Return-Path: <netdev+bounces-255078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APxoO8d3fGmWNAIAu9opvQ
	(envelope-from <netdev+bounces-255078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:20:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 507ADB8D26
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33D913013B61
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C391350A0E;
	Fri, 30 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YP7lBMtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF2329C74
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764803; cv=none; b=Y0PGgBv2IHR7HhXEtp28zmIFnTy9SdSBRDZRCIyglABylc9Pxh1Y73TfRzCitgGK/1lp6Bkzd644satphr90ihLk+A3oZANXBs1W1CYigq7dqVGmaQhka4oTkriple/3BOXBcZlu5qAgZIMKZoqB4Mo630WnjiwHtnzpreEFGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764803; c=relaxed/simple;
	bh=eKT+tQm3ETWhvlfEhqg1JLGrm90pC6+LX3rTH/wPMhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh/XHc6fL7M+xo4Ju06AG85GnDRgx9kvL3P80RW/RmDvd4YTnsn9rpAPOQnlRlAmU+P855YX6aNpCFqTTQGnM0noBF9hJiV0G9ZHkbmgvZv2+sXkbSgclazbMMjK4XRaK5vEbOtDD1jLHUj3fe8siOWbwp2W+CKTx0MfZScRFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YP7lBMtU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359249bbacso1897007f8f.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769764800; x=1770369600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbTCalOWB0NHjgCMwW2yClq+WZkgEvxgQYZT9kk7Xxc=;
        b=YP7lBMtUF/UAvR+xj6WVWh8bG8zNlZ3Qkw+ExpsD1/glssMlmQyP4ZEhUDthOpliNo
         OLLnoQdOW/LF2RdFBM9DlegR0MuqG3XdyHzRdMuqvGHFtgu7qzv+L4RQs0sG7gofSyXJ
         w3c28mUSTmzT2ycVQFVd1T9j75sYQS6pcBPInpIK0ygaUJhF/eHEHGWYcijGCXbSIVh9
         xpbKT9bHCXw2RiA2oBkhYb3objqu2o+wrsQeczEWsYsgLHj9xll15b7hKjFI3LJEt/wn
         aSBYWANRLFBg3sK4ENO3BlI4KS60HWIKs0ek+JFL8zkhrrrHg8UQ6mB3piDYnrh9TXR6
         Pyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764800; x=1770369600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbTCalOWB0NHjgCMwW2yClq+WZkgEvxgQYZT9kk7Xxc=;
        b=A/Wmb5BUJcOJ16/SDdcqh/Y1iWxmCKACbQawthXlGdBsY4SM3AGBkMOKCVmhdemPPa
         EqE90qBpbrFaWcuvKdPXyfRFGopOGjazXj51L8wTh2yqjshquBS9+hlCNi134JXWHTHz
         XRCARUTMmFc92BEmQPY9Sush0l2OUI9NJMZ2KpS12gCWCLCxupIp2NqCurzszD3xZolF
         4lTE6/iJjzmDab/uhqxlLIv9/QWEJclDnxNZP/c0gqegm0EV5XWPF2Q0XIdNOUnj5r9g
         os+ZJM9KQEimxtQ2S4aylUTBhar3sUUmEQr/MCgK5dEoPxQ5g2kjuEKBOhMdL/LqZbha
         ynyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpOXfkz8zjLaDVPoHClElCqUWuQXeFkOqVi8X4NPbN1kAVPZzJEBWbdXMOjuZ1ATeYo+dUm1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0q78F0WImWKrsxXvfb53cwUMPqPkV19C9goXDAVgx1wovVShB
	kpHSg5Nydz7MbT6qgg064ecU6G8HZdRtMleTZ06xkj4YAbYOP53zNFKTu7o74AeXbBA=
X-Gm-Gg: AZuq6aK7VhkNRN6Ly0sRVsEKsnhoVoXafFVtJXubioct+7PiKy4urE/DukXQ29iSosK
	Uu4OE83WFhcToIVjY8Bfq4AQyWovMynHHN7rgZrUoUb88Wb3saR4Zwq/S96UYWPT0/60Sd1EVsZ
	/xRYDhMeltajPoZ/GfSZVl8dfE2k6uOlV9hP7o+y2aKvKf+D0k27wIjrQBlgMoZdeSbY7P/DuyN
	KQLW1PsRcW+Z8ZHt/Ka3dg1cl4Z7friqrx/uJXUF6QEfn16jVN2PezYaNcON7nCm/nJj45LI7K7
	nwcxtsJgtpRnGWHx4NT/fDggUmsjJ3sNF+0cIKTj1Tfey+dohoFFjwSQcYAEf+98IoZPygcgRrh
	pOCLcu0XdKRmWcP1PtZlzMAXNC6atdNJ1IYh2z3spW1bUAOmhklQAEX7iWFqbHEedVc3ZQTuKiy
	C3mLwNwYeqbIRmyg==
X-Received: by 2002:a05:6000:184b:b0:435:a43b:2dde with SMTP id ffacd0b85a97d-435f42ced91mr2869861f8f.15.1769764799879;
        Fri, 30 Jan 2026 01:19:59 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm20218053f8f.34.2026.01.30.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:19:59 -0800 (PST)
Date: Fri, 30 Jan 2026 10:19:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aXx3vARHSDMq4XVN@pathway.suse.cz>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
 <87ikcllrxz.fsf@jogness.linutronix.de>
 <aXxy7usBz1-TTkVB@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXxy7usBz1-TTkVB@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255078-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 507ADB8D26
X-Rspamd-Action: no action

On Fri 2026-01-30 01:01:11, Breno Leitao wrote:
> On Wed, Jan 28, 2026 at 03:48:16PM +0106, John Ogness wrote:
> > On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> > > Extend struct printk_info to include the task name, pid, and CPU
> > > number where printk messages originate. This information is captured
> > > at vprintk_store() time and propagated through printk_message to
> > > nbcon_write_context, making it available to nbcon console drivers.
> > >
> > > This is useful for consoles like netconsole that want to include
> > > execution context in their output, allowing correlation of messages
> > > with specific tasks and CPUs regardless of where the console driver
> > > actually runs.
> > >
> > > The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> > > automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> > > the helper functions compile to no-ops with no overhead.
> > >
> > > Suggested-by: John Ogness <john.ogness@linutronix.de>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > 
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> Thank you for the review. To confirm, it is acceptable to queue this for
> the next netdev version, isn't it?

Go on with it. At least I do not have anything against it. :-)

Best Regards,
Petr

