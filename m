Return-Path: <netdev+bounces-251223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF072D3B571
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A387301B83C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DB2DB7BB;
	Mon, 19 Jan 2026 18:19:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6A2BEFEB
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846778; cv=none; b=dV4G605/CkRJF1q3ik5jcKKBiFuu/C5pc5JyRudr+2I1sXgB5tL6zrai77rbM+WNu2EyS8Gnu8w7Z8NOKpuFt9t06FptL03mgHF0pmKHkNpyyy7E4EfDvRLpb4lvtz5MG4VIhCNAn7ZMh3kLKnzN7152KaIU5Wi+dzrqFNGH3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846778; c=relaxed/simple;
	bh=j/SRBb2ZT4Cn0T+DBMm7KEIR8kdvBJvngX5EUKoxgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca/6S09mcFSgdlXXxv7GEW3cYaziYHlPVZ73fw7fzxFrjj9PjWl9cEEMkTatfEBi9mFFfOYmRsTfmkGvLe/hK+Ed8SpoSwu7uGfyHy255XCvTDVD3ree2r7kp4+wQkjapBC+JDAX7LO0aA42YG6ukuiNTYVAOFwwicEh7ra2vKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12336c0a8b6so9761513c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846776; x=1769451576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ84VwN+TO51MELR1xUf/19B58cPviiMYC5+chC+wqY=;
        b=HhXcMxQREzig0Dmc2DWehXqbHwXlcQUG4Q+1e0ni0duJ9YF6iiei+utK6XyLFg/T4t
         s9RSOOguAJ5pZx5l2P8Jk+naEIj/mNUxuzEbt6rJv5yFBQPSEm4xzgSzpUljN7i1qB2+
         xQpq0WSHryKmCxo7qSuakeP2oiHZ+Hs/GKoREG+f6hlxpRBPbS3PIEfuHmH4QymLPVBC
         QJSuMATHIVWMsmyM6zhQeUUFgkUp6/WTQ7bG7NeS+QPzaPYU3HwC4FzMRyZUSOk6uF5J
         16g604XzOdMastZ0V4+SpRwlcr3fJUrUQTpqHPLxVN1NKT6M8hF3Woeo+NXu2TL+47SU
         yhmw==
X-Forwarded-Encrypted: i=1; AJvYcCU7BE1N0zEpvjkS0Hr5JT6mdOyZ5kmdS24pK3wN/n1IDaS+VoRM/4gemLGecw5/C1Z/atqGCWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOSNHVUhs05NIxl3MY51jSJA2E03y61YrGvoRIPsBt5Md2E9Z
	rB5piKJSEzWtNoUVNfnsD440DbeZVZ1s3ck6ttgEBkTs5/KfC2zitnWE
X-Gm-Gg: AY/fxX4wQwhXMQI4GubHo80wY2fSNu2OlNzQ41/GEvfyYWiSbYcFoPKRdD/3Zly7ctO
	b1N84qnp1j4q0JCihqcalvtHZyRXENMfQih0jKHewxHEXmYAuP9N88mAnvj3j24K5USsymvJKn5
	Hky4a8CWfK2pgPSf1a1PT2oAiht6Ed3PJtQGraOdX1QAgDe2xeQeYl3EkC1E3VoqK1+w8lvTtLN
	jQ7FAKFcIVo7qnc9TuAxJ8c5Yuw71EZ9DYBz7UpUqYUYlb9sYUmGe9cIPKW/3hr28Ld+OSxcWOx
	v/Hd435wUsuNAWDi1Acn3Ej/aQrZl/xenl4+TREkU7vw4KXaWXCL8dE9kcM/3BlThqFvZkhnH+C
	lo97EGvsy8RXdu5lY+yHbYP3h4R2Rwh4QIyEPVUSKjbGFgyE3NxEOI/+iflVd99osuW/VTr+ssd
	l18w==
X-Received: by 2002:a05:6871:738f:b0:404:292a:d108 with SMTP id 586e51a60fabf-4044c1c648emr5199238fac.17.1768840485015;
        Mon, 19 Jan 2026 08:34:45 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5b00esm7153772fac.15.2026.01.19.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:34:44 -0800 (PST)
Date: Mon, 19 Jan 2026 08:34:42 -0800
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com, 
	mpdesouza@suse.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, kernel-team@meta.com, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <bvmrtic6pr52cxwf6mis526zz4sbxstxjd2wiqkd2emueatv33@eccynoxgjgo2>
References: <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
 <aWpfDKd64DLX32Hl@pathway.suse.cz>
 <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
 <aW446yxd-FQ1JJ9Q@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW446yxd-FQ1JJ9Q@pathway.suse.cz>

Hello Petr,

On Mon, Jan 19, 2026 at 03:00:11PM +0100, Petr Mladek wrote:
> > Context: netconsole outputs the message in a different way, similarly to the
> > printk dictionary. I.e, taskname and cpu come after, one entry per line:
> > 
> >   <message>
> >    SUBSYSTEM=net
> >    DEVICE=+pci:0000:00:1f.6
> >    cpu=42
> >    taskname=NetworkManager
> >    ...
> 
> I see. Honestly, I never liked the way how dictionary was printed.
> It used another syntax than loglevel, sequence id, and timestamp.
> It might be confusing and complicate parsing.
> 
> But it is a personal opinion. Others might like it because
> it might be easier for human eyes parsing.
> 
> IMHO, the information needs some parsing anyway to make it human readable:
> 
>   + people do not know the log level meaning out of head
>   + message id is there primary to detect lost messages
>   + timestamp needs conversion, definitely
> 
> Sigh, the use of lower case letters for "cpu" and "taskname" made it
> even more inconsistent. I would voted against it if I did the review ;-)

Me too. ;-)

At least, we can use it to differentiate what is coming from pritnk
dictionary and netconsole.

> > Here is the full patch I was using to test the integration of netconsole and
> > the previous printk patch:
> > 
> > https://github.com/leitao/linux/commit/4175dc10719a15844b3a0bd7aa38158a913181a3
> 
> BTW.1: I see that netconsole actually does not show pid. So that we do not
>        need the trick with caller_id2. But people might want to add it in
>        the future.

Correct, I haven't found the pid important when aggregating messages in
the a fleet of hosts.


> BTW.2: I also noticed that sysdata_append_msgid() uses netconsole-specific
>        message counter.
> 
>        Note that each message has its own sequence number. It is the
>        .seq member in struct printk_info. It is printed in the extended
>        console output, see info_print_ext_header(). So it is printed
>        even on netconsole when this extended format is used.
> 
>        I wonder if the netconsole-specific counter was added
>        intentionally.

The addition was intentional. The purpose was to monitor the number of
lost netconsole messages.

Originally we were using printk seq number to track "lost" message, later
we discovered that some message numbers were never sent to netconsole
, either due to  different loglevel or supressed message. Thus, using
.seq was not useful to track lost netconsole message.

As a result, netconsole now increments the sequence number only when
a packet is sent over the wire. Therefore, any gap in the "sequence"
indicates that a packet was lost.

Back o this current patch, I've tested it internally and run a test for
hours without any current issue in terms of task->comm/cpu. 
How would you prefer to proceed to get the patch in?

Thanks
--breno

