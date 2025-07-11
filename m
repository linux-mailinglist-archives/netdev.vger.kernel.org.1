Return-Path: <netdev+bounces-206031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4416EB01139
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8055958459C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530318A6B0;
	Fri, 11 Jul 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+FwiDHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943D157E6B;
	Fri, 11 Jul 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201115; cv=none; b=PWTVU4sxvljjBlTghrVnY887z8V9P2S/2prHM8GfbJUbM56+y60Z6hNTaW63Dul7SPCaOqIj37ULwI8RC8+FuFdOcZwokIST9g7otu5kOQr05Wpewql1ZN6ds3ioRR26X1RP6cNRhnxnCaaZbGJ4XhKn+W10Shkat5XFE5uijOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201115; c=relaxed/simple;
	bh=qoMv3I/wvYY0fBc/km+29iL2QTJH+hPrK/s0FOHTlyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7kpSAjf9xartRi/f3Wa6Q7vFdzEYeUGgkceC9Ba478z54Axx7BU4N765snRYetYWKTAPmbwA16jzixd2dECKMCSIUjGynFC9697N8nd5seQYv0Mp5te2swJ/BfUyClHWm2t5hxRkZURS4hay/q2yG06CB/gntb046fuCp2EY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+FwiDHL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf99dd567so21694676d6.0;
        Thu, 10 Jul 2025 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752201112; x=1752805912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hpxRkNYRuqENsjSxqDYk0zNqW0LZ1+U3jypHB6kGXw=;
        b=m+FwiDHLtz1qpiz5cc0RCZn7ycKTgaN43ZeUm8f83i1tAaBCiXxu3NtoIkEa3SqQ30
         goYyjqYjBAJXLiDsw1lKwv9LBvdHN65v9NmNwe6zsHtYAh6kFod+7rxcwYnljXXlZEn4
         AGLIRbEHItvZj326l+XQN8Ids8RjpyuL+4r0jNeqsgeGx9wgj9c1SFpcDRlohbf8SzdH
         Els+Kh/JoxOeMgch/nJngGVKFXcyQXWJOqMmgFX9oDjyIs6oREwEt2O8ZKIG+YtMWAN+
         /dvrD4KRIZ394mPmcrWUp2XdDLbPDaXYFnLQ/hoYH+VuYRr4AlLRP9b+HkTBt1ykUYeK
         LJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752201112; x=1752805912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hpxRkNYRuqENsjSxqDYk0zNqW0LZ1+U3jypHB6kGXw=;
        b=vl68OylrkPLS2DIZyJ3aYj7BZCj+RDyqDrJsxykzXCyO1VtMKO4jglxfDt6L8eBQdM
         3vrirbOUBJIO2mKq7DfHqT51RI2/be4zYWTEKTtJW6Mx367rfG7jpBZas1ST5DSWFn9h
         NHMXF7SBDk1vvd3do80xs+UCmU+YDRlYnYZyHWhD4mRy381g0iqpMZ37fWsyH3ivHDo8
         6veDUK0CvVasT6Tn3kPfbw0ksHiAY5YxLWCdegoacubyXsZ8L3Eu17TiVxs8t7/CsLTC
         1TXIKbnjs9cdGH2cqDyLHDALgUzsRxK0trpKHJBzLCni0PMfpYKpTMextYrMaPkJVjH9
         oRew==
X-Forwarded-Encrypted: i=1; AJvYcCX0jnVE6b/9Fw+iKCjPSAbadqJUvrY4/unWs1hwpPy47xZfSoUya/o3ncPwRUcwMY738Mj9@vger.kernel.org, AJvYcCX8+DFCvWnR31r5q4xFUt9oI02Vum3avb1yuQhkfvS7Q52DTlMd42UwpRgnWGlkuMNeVycma4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOEJVCwKK78zoiM+5tAw5XHktnnKYjQaON7jTrWA7Fcrmyr5A
	2xJz8fQ3pMW5ZBA87SC1ksePYXGa3ZWZZRySkk2xqdif+J1a+BeP6Drh
X-Gm-Gg: ASbGncuUxmSHFzX5k1stuC3ypTBJCFrjNSAX9aKD9yYlHGI3zI+1d0nKIbCL4vPDtnP
	3579dw6K7EILv1v/xBI90YdAJ3Ig20Xt0fU9/PnhD6r+byZZRQmg9AFtgwmn3qhCwEc/tDX1ky+
	eyH4hCyN21/HQiZX91Y+LDX3/AoByjN/euw3gEFnGYJsBRawYLD2Q/5WeOK012vm7+++z29BWJ7
	EX3OuZhmWYqoxeVOsioAabEmEvGjr6g9nUEhOjJnyd9i/sL+lZkTIZNDrO/XBOtQua942Y6Ckq3
	v7d5f0hwkjVZn4eiK3LJpayKrqv/EsOt7INYr8gyBkOH+x33J2KDI8ElmocHTMpeJcIEgCLIds6
	eSgkxFV6hBCDafhqZWlbWK8IZcgVZf1F7KhjYmq09PNVPbhqu9ROYYlX0I3jSeMpXA3YCaZohki
	CvHcHD1c3aVeCj
X-Google-Smtp-Source: AGHT+IE4R+kXFovwAQJmZ+v8jqidWY5K2h3e6hQAjYhhgIxztQTNavaWz/IaBUBUvPNaZ4bACtvsYA==
X-Received: by 2002:a05:6214:da9:b0:6ff:1665:44ef with SMTP id 6a1803df08f44-704a4216423mr26754716d6.22.1752201112490;
        Thu, 10 Jul 2025 19:31:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e40b6sm15319656d6.46.2025.07.10.19.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 19:31:52 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82CAAF40068;
	Thu, 10 Jul 2025 22:31:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Jul 2025 22:31:51 -0400
X-ME-Sender: <xms:l3dwaDjCBzuIOtKkXwkkM9WAlS73Aq5nkFvKXN93XoYOd_TT0zh62g>
    <xme:l3dwaLgIRA1-AMiQ0EzhaINKPj0JsaLuaCEgUuRY_GfugsSsDP579a3VQ4LZCRAaQ
    y99gtIJlKhWZUNTWw>
X-ME-Received: <xmr:l3dwaJG9HUf_YlBzMNT7McDBjDlJXoRHWb5JSBXPMHkttbPdWfzwumJTJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghithgrohesuggvsghirg
    hnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvse
    hsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:l3dwaODRLba5tSugkVy_SP5N2J9lXjZmT8GsRr6JY6JsnQms934OMw>
    <xmx:l3dwaF_ia8kPFVbnpkmLR4iT8OTaym4i5NUU--E2eeO-jcBew5COPg>
    <xmx:l3dwaBh4NeApwlomub9O-GiDghFI1ejzHhFcw_iXo7b9xP8SvotDxA>
    <xmx:l3dwaOZKDnHFn1g8IKD4re89LI2ZFnt6ibBZvi-GRMte1sPEOTWeWA>
    <xmx:l3dwaDTgLKUwWlkHjAJaVOemsmbbyA_i2h9K6eiqi-pfk682wMDdl4KD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 22:31:50 -0400 (EDT)
Date: Thu, 10 Jul 2025 19:31:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, aeh@meta.com,
	netdev@vger.kernel.org, edumazet@google.com, jhs@mojatatu.com,
	kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 8/8] locking/lockdep: Use shazptr to protect the key
 hashlist
Message-ID: <aHB3lh4zkh8g5H1T@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-9-boqun.feng@gmail.com>
 <i3mukc6vgwrp3cy5eis2inyms7f5b4a6pel4cvvdx6jlxrij2g@wgrnkstlifv3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i3mukc6vgwrp3cy5eis2inyms7f5b4a6pel4cvvdx6jlxrij2g@wgrnkstlifv3>

On Thu, Jul 10, 2025 at 07:06:09AM -0700, Breno Leitao wrote:
> Hello Boqun,
> 
> On Tue, Jun 24, 2025 at 08:11:01PM -0700, Boqun Feng wrote:
> > Erik Lundgren and Breno Leitao reported [1] a case where
> > lockdep_unregister_key() can be called from time critical code pathes
> > where rntl_lock() may be held. And the synchronize_rcu() in it can slow
> > down operations such as using tc to replace a qdisc in a network device.
> > 
> > In fact the synchronize_rcu() in lockdep_unregister_key() is to wait for
> > all is_dynamic_key() callers to finish so that removing a key from the
> > key hashlist, and we can use shazptr to protect the hashlist as well.
> > 
> > Compared to the proposed solution which replaces synchronize_rcu() with
> > synchronize_rcu_expedited(), using shazptr here can achieve the
> > same/better synchronization time without the need to send IPI. Hence use
> > shazptr here.
> > 
> > Reported-by: Erik Lundgren <elundgren@meta.com>
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> First of all, thanks for working to fix the origianl issue. I've been
> able to test this in my host, and the gain is impressive.
> 
> Before:
> 
>          # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
>          real    0m13.195s
>          user    0m0.001s
>          sys     0m2.746s
> 	
> With your patch:
> 
> 	#  time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 	real	0m0.135s
> 	user	0m0.002s
> 	sys	0m0.116s
> 
> 	#  time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> 	real	0m0.127s
> 	user	0m0.001s
> 	sys	0m0.112s
> 
> Please add the following to the series:
> 
> Tested-by: Breno Leitao <leitao@debian.org>

Thanks! Will apply ;-)

Regards,
Boqun

