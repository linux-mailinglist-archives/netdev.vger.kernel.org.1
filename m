Return-Path: <netdev+bounces-251399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB70D3C2F9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EEA74C8380
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E63BB9EF;
	Tue, 20 Jan 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTb7GYkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7783B95EB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899562; cv=none; b=HhePrtwftnS8ipp7n0ZOV7TdTn43EYKPz+k+KinD5Rynenff2gydM+Ukhl33zOWLU16hPHH4IgA4GHIRHoYih3+tNMaMdCDiBq2BlNjcIjxiDVtiRSWmtLQdkI3YaV0Ueq2J2JQmiuPjkSOlE/ej17CVzWLXTkshH326uXzqDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899562; c=relaxed/simple;
	bh=DGWvUmNWBI3cmvoyS6O985pWqbg2oxnZqeZ1Mrp2RyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQgvONEBmkxBL1zR8f8sbKoy2Hzyer8CGolt1HuM6Vz4V2BwmsocKIdIyfVWE0Uf4yrcQoRs370OBO4yy0m7znJ2T6oPUw3NEmm9t1kYxXcO9cEl7vlYdAIa9AWZXkotWOkaRWMF8N9tZhavvbqyqOoei1J59fNSa/5YfkOd/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTb7GYkp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4358fb60802so206176f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768899559; x=1769504359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALcRfu9s9R3EXYRBCz4TWxhxv7i+sOPbGmKIee8iWRE=;
        b=PTb7GYkpswvvTVeRxUGnhrZoazIlr2kHeJIleqvtFXnQFBv9KWfRixOGBv/4UGdTt8
         GfyNDh+hwzn6F19emEGuhQ5vgqxLrhm74S8w36gJN7JslgK/C/D8zriBunDifRD9w5y8
         et/rzcT+YnwJQVowUcd0X3JzntTvDKKNRk5asjuf5kH7fLeAeqmoj5l4TUvCxzCCUY+E
         W/glVQsjUpCfMMpQiypyqTDhpUKKXBTLXL3RPd5vqbBssCh+ay8LDBGiqZOxiBLUnCjL
         dblrVJOJYGdpEYTmS15XtDJQb8EFEt/gxmzOcoHJYFyA0YGDqaEcWJnORHLeXsebMvhi
         mhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899559; x=1769504359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALcRfu9s9R3EXYRBCz4TWxhxv7i+sOPbGmKIee8iWRE=;
        b=wHYTx/NmNIKNgKfYcxyegPGMyZfd43UZlG/SEY8Qhk33HdX3JNGMQsRi6sglDEAbwj
         SOUirMR1ZjAIIgAsbdPoNvUuFXc9RdTTURczunZ+Ot9Bm6dxmcfAP+hXAuErS5qiJ/8w
         k9rb8nuTg60eh7C0ZIPXTjL+xMQatjQJiBucAh6ZWlvcjDd6LVwRXBkVYEI1OCGAM20m
         yhDsN7EYwmCZdWDArnWMZjnTNmIPMYnsHBhpZDG4rKLvEloBdAPE+m0ZYFoemD0oMCja
         vOBmh5Bonvi3eXpZxZKbVGf7xfqRVfvcvQ1BX5e8KZej2R8KF9SMd/u1q5OjVsyWYFvw
         GJJg==
X-Forwarded-Encrypted: i=1; AJvYcCUElgjSczc27YKRRUbRRtxrabTjieowjXdxZGv4ZPlOJRxR3CDCg+hiYqY20oq4o8SxmecYOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEh0v0bOe6qwq9n8NM0fMjUWdRnuRI4dtzoYPm96+KPJ1K8ue
	9+zWAEhmi329DNjObYRrZTO5U3wlvrhbWBYHjp924lS84DUMv23Stx3MlunQ9H2/DoE=
X-Gm-Gg: AZuq6aJJgQUUhAvNtkmdpyBGb2hsHG1+TeWB3qhIuh/U5qHHzIMwyhDoIKq3Bp4Ro5D
	cbCsxtaF3SezNaDlsyZFFREic1SPRsM124ceLb7/omfd/es1EsCEHnVi6N8vi9S3MhhN6vnmJxd
	5nZi32eW76TY6cwTBMYmUHjzmVxynwC3e/RO3vVev8L5sbrIbatj5TCLp+4FO29hJ3oqHzT8VEg
	tCwXJl3GosVHfACyJ5F+LSMT8UJDYWTibJE3Ot8W08ZCfP8nGCpKPXrw4OMiKyDZMCvX85yeXOW
	ygwsMN/OiFl0RX4jf2vafl1O2Gx23EY0mYKZzRiiKE9+v21+dCfT/Zv8Vix4Q1ZnHkYIpjTJMcV
	DVy7BPLdnd8ifImnMR6cX2H2+uOTEmhK4YvGZvFdEeOTlzLbldbXNMqYbd7+DnwpLY3hpoIU8Fk
	aOGXw9afXCL0HpaA==
X-Received: by 2002:a05:6000:2082:b0:432:dcb1:68bc with SMTP id ffacd0b85a97d-434df0ed27fmr23403774f8f.23.1768899559176;
        Tue, 20 Jan 2026 00:59:19 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997df75sm28295155f8f.29.2026.01.20.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:59:18 -0800 (PST)
Date: Tue, 20 Jan 2026 09:59:16 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com,
	mpdesouza@suse.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	kernel-team@meta.com, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aW9D5M0o9_8hdVvt@pathway.suse.cz>
References: <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
 <aWpfDKd64DLX32Hl@pathway.suse.cz>
 <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
 <aW446yxd-FQ1JJ9Q@pathway.suse.cz>
 <bvmrtic6pr52cxwf6mis526zz4sbxstxjd2wiqkd2emueatv33@eccynoxgjgo2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bvmrtic6pr52cxwf6mis526zz4sbxstxjd2wiqkd2emueatv33@eccynoxgjgo2>

On Mon 2026-01-19 08:34:42, Breno Leitao wrote:
> Hello Petr,
> 
> On Mon, Jan 19, 2026 at 03:00:11PM +0100, Petr Mladek wrote:
> > > Context: netconsole outputs the message in a different way, similarly to the
> > > printk dictionary. I.e, taskname and cpu come after, one entry per line:
> > > 
> > >   <message>
> > >    SUBSYSTEM=net
> > >    DEVICE=+pci:0000:00:1f.6
> > >    cpu=42
> > >    taskname=NetworkManager
> > >    ...
> > 
> > BTW.1: I see that netconsole actually does not show pid. So that we do not
> >        need the trick with caller_id2. But people might want to add it in
> >        the future.
> 
> Correct, I haven't found the pid important when aggregating messages in
> the a fleet of hosts.

Good to know.

> > BTW.2: I also noticed that sysdata_append_msgid() uses netconsole-specific
> >        message counter.
> > 
> >        Note that each message has its own sequence number. It is the
> >        .seq member in struct printk_info. It is printed in the extended
> >        console output, see info_print_ext_header(). So it is printed
> >        even on netconsole when this extended format is used.
> > 
> >        I wonder if the netconsole-specific counter was added
> >        intentionally.
> 
> The addition was intentional. The purpose was to monitor the number of
> lost netconsole messages.
> 
> Originally we were using printk seq number to track "lost" message, later
> we discovered that some message numbers were never sent to netconsole
> , either due to  different loglevel or supressed message. Thus, using
> .seq was not useful to track lost netconsole message.
> 
> As a result, netconsole now increments the sequence number only when
> a packet is sent over the wire. Therefore, any gap in the "sequence"
> indicates that a packet was lost.

Makes perfect sense.

> Back o this current patch, I've tested it internally and run a test for
> hours without any current issue in terms of task->comm/cpu. 
> How would you prefer to proceed to get the patch in?

Is the netconsole part ready for mainline?

If yes, I would suggest to send the full patchset for review and
it might go in via the networking tree.

If no, then we could try to get in at least the printk part
for 6.20. I would personally use the variant with caller_id2
just to be on the safe side.

Note that AFAIK, there are no conflicting changes on the printk side
floating around.

Best Regards,
Petr

