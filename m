Return-Path: <netdev+bounces-251096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256AD3AAFC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70AC0301C0AC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E17374177;
	Mon, 19 Jan 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vg2HN0kH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193F374162
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831218; cv=none; b=h/cD3jir0TH/fYV3yGOaatKmclDILfZmxjmR7xa4TtxC4UpGPspkDCkJQEQw+CS03WZaEsjhE2eCqCGIFcDy5IbsKiT1Y9KGYUlMiebq3HXX/JSgaElmyyv8x1VKPbzPg+MCxvFEquvviPdlkcJE6AmWVXojUEngGb9v+Y5Kj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831218; c=relaxed/simple;
	bh=rHDhaxehZ9cnCtlrg1eGh7wnkATGGEi/5Jt/Usn8WvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr8t1mU1zN9uX+wRR3CC/G2NWngfqWWZA1/M8x0RdgqIBTcLhAvKLkathNcaLwCBOtis41Pxmj3VC4/0XhnZlKJ+PVkzwRpwYwCH+e/lGIU7yuQRYkj9OGUCYG4k7pOFN0kmn0Kno2RZFhvkvwcdMyiIKWSTHhD6JRasbocFrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vg2HN0kH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-431048c4068so2564225f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768831214; x=1769436014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fY1sXwtSL3uPdQErLSK5pwO7x80SrKKNfsfS6w/NJg=;
        b=Vg2HN0kH3rCKeaA8zMSitmrSmxAIkzCoriqCConYW1PgI5D+Top35Z04CYPf4HmJzn
         4sIxji8hJi2DuNbCAbMhgzFqix7ey09FTfa4uU96ASi+crjeJnxRfrh/7VPjGWY6gsBS
         jwjC3USmw4x5X6URDoYebsddrQOi1Wa3W/TFzaeB+X/dqRoaMJnddljcWKOPEdP4VCKt
         reNrzJX/M62YTReVSdjOGGTqxRGDshXlRlM6Q5t1+py2H2eLHt4pWKuZ4sMu2f351u4u
         1mxYo8KrdHmbd/Ll3XjmdQem6h/raK4sC9zpFzG4buNj38cr77hQT2MaM/Vo/ELRRBWJ
         aZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831214; x=1769436014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fY1sXwtSL3uPdQErLSK5pwO7x80SrKKNfsfS6w/NJg=;
        b=fmZnZDJHJFm0dYw6UwVqNL+edj3R7VUcv7vtKHmv2KkWKpeXDjXZXMRqg9jLuVobKd
         nwqZrqcp/H+6Fr1DH5kwGd2aW+BssLRenCHXBD4bGG2iB/78eEUwG2RpeKu1QlQsWRnl
         xnyXALQ1sr4+C2t4yxfwEOTrRZaAci8CpmUWO1ijthlPVOwonfoIm7RPtzfWFN8XkqSf
         1gQIs0RY5n4Hz0uYyib6NpAThmhYu2to7kPfkUQh+WvJ96lNcKUjLyoyHCAisLZgne9W
         xBiYxxwguBNqk3f/jL2fBHZbeIgemjIU4apctee/w/Q1Ft+5zzjHCOAIT5YFLT4huPkm
         aNrw==
X-Forwarded-Encrypted: i=1; AJvYcCVyEfvpLHF5SxwQJK9gjr5JefWyCt3ONd1rOyKsmwds1OxU2XRvwP4DWFQQgcqEgqcTRQDzm3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNnQI8zpHMnPQjdapImX51D5+SKRYazlTY1Y+gHMDHaFNi+70
	5Sk9g9cvmbUxGg8zEdGey0IZVmMObF/jmImRrApvCXK5TxTloTkzqW0NbsztjsmOUag=
X-Gm-Gg: AZuq6aKSczoH5FgxcBOmpmNDXdZcLNV6h2+Nz31MIFZvd/jMAqsyjR+a4oUJLN5Un83
	91STvJeeL4UujOo1/F+OKav2ckc8lommpHVVvOAgrz5DXili9hUa88divzV1Y1vEmTAwievB2xd
	F0xodY9sJGaGVY4/Q3xYJSPrl4GjmpfXPPly6HG4ipiqmXy8a7784gSUIUnmadaenB+Y+2DMNtf
	doaQomjI05SlLxEIppfMAn19WoyBcLJPBhskSirzbkqKHN6xXlhZEykpK15esz3YqcYKsqFgOtx
	6SVQ2h3YmLqxb2sHrwe6oblFEdVCAPVmCQJJ5AsyNGo6L819e/Q14Web/qEAd9Hg6XsUEs4GLfc
	iGZ7T+HVKbT/j6MWfaUULZJxm4Bv2d67dKqyGIYyJNmvkn7u2ody3Sd2Uh+RWEq0uXUmggabwnY
	XE/DlBMPluXVyyvg==
X-Received: by 2002:a05:6000:4023:b0:430:f2ee:b21f with SMTP id ffacd0b85a97d-43569565238mr15176785f8f.22.1768831214289;
        Mon, 19 Jan 2026 06:00:14 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699272a0sm23576512f8f.17.2026.01.19.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:00:13 -0800 (PST)
Date: Mon, 19 Jan 2026 15:00:11 +0100
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
Message-ID: <aW446yxd-FQ1JJ9Q@pathway.suse.cz>
References: <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
 <aWpekVlhRpD4CaDI@pathway.suse.cz>
 <aWpfDKd64DLX32Hl@pathway.suse.cz>
 <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6tryrckp7mah2qghxu5fktrwexoik6anplubfvybushtcgocq5@kg6ln44istyk>

On Fri 2026-01-16 10:07:08, Breno Leitao wrote:
> Hello Petr,
> 
> On Fri, Jan 16, 2026 at 04:53:48PM +0100, Petr Mladek wrote:
> > > Otherwise, it looks good to me.
> > > 
> > > I tried to update your patch with the above proposal to see how
> > > it looks and I got:
> > 
> > The change seems to work. I have tested it with the following patch:
> 
> First of all, *thank you* so much for spending your time on it, this is
> helpful.

You are welcome.

> > Then the extended console format should show also:
> > 
> >      ,cpu=XXX,pid=YYY,comm=ZZZ
> 
> Are you using this just for testing, or do you plan to get this output?

I used this just for testing. But it looks like a good variant for me.

Note that the above is /dev/kmsg output. It would show dev_printk()
messages the following way:

6,295,1164587,-,caller=T1,cpu=10,pid=1,comm=swapper/0;pci 0000:00:02.1: enabling Extended Tags
 SUBSYSTEM=pci
 DEVICE=+pci:0000:00:02.1
6,296,1167287,-,caller=T1,cpu=10,pid=1,comm=swapper/0;pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400 PCIe Root Port
 SUBSYSTEM=pci
 DEVICE=+pci:0000:00:02.2


We would need to use another format for (slow) consoles, for example:

     <level>[timestamp][Cxxx][context]comm[pid] message

, where:

   + [Cxxx] would show cpu number like the current context field, e.g [  C123]

   + [context] would show context, ideal in some existing format. But
     I know only about lockdep format which looks a bit hard to
     understand for me.

     For example, it might be, for example [TC,HD] for a task context
     with hard irqs disabled.


   + comm[pid] is inspired by the existing messages passed from systemd, e.g.
     <30>[    5.317305][    T1] systemd[1]: Starting Journal Service...
     <30>[    5.349000][    T1] systemd[1]: Starting Load Kernel Modules...

But I guess that this might be long bikesheding about this.

> Context: netconsole outputs the message in a different way, similarly to the
> printk dictionary. I.e, taskname and cpu come after, one entry per line:
> 
>   <message>
>    SUBSYSTEM=net
>    DEVICE=+pci:0000:00:1f.6
>    cpu=42
>    taskname=NetworkManager
>    ...

I see. Honestly, I never liked the way how dictionary was printed.
It used another syntax than loglevel, sequence id, and timestamp.
It might be confusing and complicate parsing.

But it is a personal opinion. Others might like it because
it might be easier for human eyes parsing.

IMHO, the information needs some parsing anyway to make it human readable:

  + people do not know the log level meaning out of head
  + message id is there primary to detect lost messages
  + timestamp needs conversion, definitely

Sigh, the use of lower case letters for "cpu" and "taskname" made it
even more inconsistent. I would voted against it if I did the review ;-)

> I would like to keep the same format, given users might be used to this format
> already, where netconsole grabs teh cpu,pid,comm data and massage it before
> outputing. Something as:
> 
>  static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
> 				    struct nbcon_write_context *wctxt)
>  {
>      return scnprintf(&nt->sysdata[offset],
>               MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
> -             current->comm);
> +             wctxt->msg_comm);
>  }

I see. I think that you could keep it for now. It might take quite
some time until we integrate this for /dev/kmsg, ...

> Here is the full patch I was using to test the integration of netconsole and
> the previous printk patch:
> 
> https://github.com/leitao/linux/commit/4175dc10719a15844b3a0bd7aa38158a913181a3

BTW.1: I see that netconsole actually does not show pid. So that we do not
       need the trick with caller_id2. But people might want to add it in
       the future.

       I do not have strong opinion about it. We could change it
       anytime later if we did not export the new fields for crash
       dump, via the VMCOREINFO_OFFSET() macro.


BTW.2: I also noticed that sysdata_append_msgid() uses netconsole-specific
       message counter.

       Note that each message has its own sequence number. It is the
       .seq member in struct printk_info. It is printed in the extended
       console output, see info_print_ext_header(). So it is printed
       even on netconsole when this extended format is used.

       I wonder if the netconsole-specific counter was added
       intentionally.


Best Regards,
Petr

