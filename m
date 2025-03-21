Return-Path: <netdev+bounces-176826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBFEA6C4C0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1691116B7C8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB471EDA03;
	Fri, 21 Mar 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm25ytLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0182AF1B;
	Fri, 21 Mar 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590859; cv=none; b=AnmR3NTk+MvOAPCJsGYO/IHX4F6unlXMb0AiJXM4/Ec4U6SsQJSW1YfqGYIkjqtflUe3UdCCiqCXpzEBgUCCCKGjhzsI3I0tgXolFmsBnlzcyw/noooLK/ogcqJVUK9Yl2O1znC2/RRtl0Saxpee2Ch+sMOuIbIfOEps46e6Sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590859; c=relaxed/simple;
	bh=w0+ZrH5okB6sO4yHwZsP/O+qhxRXAwnW2UDoEeHq02A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDqxSDJibWnwOVozcMl87aHZrB7bYVs/Jl6MQE5XAq2wDQy5C6GPIMvW3TRLDSbrlx+vEoga+0myvBMJkKpMEYwFO2fDKGo+PVX0nVnLhieeab14sxHFQBgbvXJfzqLMpuIoNrMRXkZ9X2ZDhQ8wxFVTrATjcku3MAkY2EYNGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm25ytLk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c56a3def84so241334485a.0;
        Fri, 21 Mar 2025 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742590857; x=1743195657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFm+utToYllRDPvFrcY0VNwV9ONAWh+ysfKx7zHInPw=;
        b=gm25ytLknJGaTkK1GlUCT8QfJGbFvwHqj7SW4Qz1wjNDSsxt4Oy9JSDeOlbZEBxKJX
         1j7F3gklwwQNoQzKpfncyN8YsqUArJXXMxUk4N+ufXdjglh0J3Wjks5rWHtUSpNMtnHk
         Yv/DdS5a3ejBEYjiG66XZF4M63Y6+Zd5qLFn530bjnhR8H13mS7fzsffSJ/7M+W3XHVh
         B0dgrj+5BrCFKebjk607eG1FbDwERQhPxvdHnNtBy3V0OJYKX1YQf9GPVRzcD0NEYA2R
         1wdicImg8MVYl+rAtvtqK4VlWVJHMo6wTVS2C6cBdiudaQCvVOiJimGZ8EtRTxIEkZg3
         bmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590857; x=1743195657;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFm+utToYllRDPvFrcY0VNwV9ONAWh+ysfKx7zHInPw=;
        b=AaagedhYysLd6Rno38hiQHxw/0bZNkLgWn7vyUKlNYpFPBF174Xd81jUfgaLQdrhCv
         bDgOIxSxcmQfc0Y4WYHn/gwO+Ze+2JNA/A3r833frd0IGtVZTAVk3RbftlHX3knPO3cY
         vAg8ndEFCaxq6UfUP1tl4GVNYBRUeggVRjgZlLfpPINoCQAlrd4RhPB1+fFvgDHHRg4p
         cKuHHJLidChYPt0szianqhH8N8Q66TX5EU2xYquwPx8EpcSQceFb2T7pxoMe3INZqBKV
         EoMUKoBy4vI7vydfSHv2l36azjBOX776zYMrsdWXucRZihSaXilrcqI/26tOF6nvk3tv
         1l2A==
X-Forwarded-Encrypted: i=1; AJvYcCVtWy0fCZNkAhZAxagE7xK/hcaIEgLhEzhsBXUdGSbI0FVVbggRuWOTzzS1yCf+yOM3aY9Ci0+M@vger.kernel.org, AJvYcCX3XSHtwvN3EqQTz0YfBYKq+Au2OoINOjDNDyOC2s3AX4KXet2jATo93YSNt0wYdO9pm62lDL76zowjB6oCgNE=@vger.kernel.org, AJvYcCX8sB30Y69NAEDzJZwZU+KqGKJ3xAqlow1WnPZ0pwwn2EesjPi88mAK/WHLSK0h28A1S7WzLhHj6T59aGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZftI2iLJ+exF2I5mwfYJigIN3J1B1ZpsBE/CrOTXXspg/qeO
	S48iU1E3WP9tb4cNCEo9x9lrpMrnNK18lthSLxSuIe3nwXw2Ylnf
X-Gm-Gg: ASbGncu0cdMs/CP02DFOCZCWV/o4+ZLQbYw9rieO8A9Jrve+IBDn/MDKwx9FFm552T7
	VK1CM6OJVGEaDqJqXthINB/Fak5d6ylsvVATPgqrlC6SG36S+q/ext5qBw/Bfw/69d/aqZYF0Pm
	JrjMhy9ssb3jjq7SPrWh3iUSQfkf2j58ux+Dyt2S+Ib+RD6kxzpc0gx9LmHLrf9xUJcYIJZvEKH
	1smF9aFR5P8kW8bvFoeZyiDTciwC3yE8Dalk1MSUAZJ30PUCR6nncLJdZxzMRt7hvvwZxMyX6FN
	TOo+kIHc7ZJ6eVpjIfaY7WV0IwtLqtkWnzkqsSKfy2pzduuE+a45a0/ZKTrGoBdZIEyJBUjKtM9
	GJE36c9WEa4Bhb/sjv0ajHC1vlHMLJatpDuk=
X-Google-Smtp-Source: AGHT+IGayzhF/fnOzVDsUHL0vISCU5U/4LH600wkt0RjUh43Uc9VAdYMY9vcsFjlx6GEMau8u5GnRg==
X-Received: by 2002:a05:620a:1a19:b0:7c5:3c0a:ab7a with SMTP id af79cd13be357-7c5ba13a64cmr559981385a.3.1742590856448;
        Fri, 21 Mar 2025 14:00:56 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68f3sm174606585a.40.2025.03.21.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:00:55 -0700 (PDT)
Message-ID: <67ddd387.050a0220.3229ca.921c@mx.google.com>
X-Google-Original-Message-ID: <Z93ThNi0lw5D3sEu@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1A3E31200043;
	Fri, 21 Mar 2025 17:00:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 21 Mar 2025 17:00:55 -0400
X-ME-Sender: <xms:htPdZ12MNZRQQE7ZBpVWBKvRfdm60ysEfAYWmGQHUNJ0pycfTsmZ3w>
    <xme:htPdZ8FtmorIxWvcRPnAMmyIBjKwyXyNHd_ubZvG7sP-caKrZuaKbXforIoZzzSnK
    eVjnRgD0rB6RwLFgg>
X-ME-Received: <xmr:htPdZ155qEVvKynd5xohnsj_aII-ISCpxPiKJp_z0vKbKv4pcJ4h7vbKZ_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrd
    guvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:htPdZy2NUbEc8iRoHuQ5rmZBT-a-qpZcCsJCgzSkz0zToZgHNg3cqQ>
    <xmx:h9PdZ4FOTyzHJpZSIs3EjcFulk53tjW1yXVrVFMawvw7I7M-5jzr_Q>
    <xmx:h9PdZz_vHtzHAu_BBhMfH6pGDEFYZJZPSHBVpAIgPqTfJZAw8TuGaw>
    <xmx:h9PdZ1kJ0CahWPpDRL-UedgPp2hD0uMn2Tc9ylhCLWakctSOuJblTQ>
    <xmx:h9PdZ8G9tkPsoqaK33692ka1rPsPaH6g93dQC4Qo45jvvXXXCk3yJivi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 17:00:54 -0400 (EDT)
Date: Fri, 21 Mar 2025 14:00:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-7-fujita.tomonori@gmail.com>
 <Z9xnDzwixCbbBm0o@boqun-archlinux>
 <87jz8ichv5.fsf@kernel.org>
 <87o6xu15m1.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6xu15m1.ffs@tglx>

On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
> >> Could you add me as a reviewer in these entries?
> >>
> >
> > I would like to be added as well.
> 
> Please add the relevant core code maintainers (Anna-Maria, Frederic,
> John Stultz and myself) as well to the reviewers list, so that this does
> not end up with changes going in opposite directions.
> 

Make sense, I assume you want this to go via rust then (althought we
would like it to go via your tree if possible ;-))?

Regards,
Boqun

> Thanks,
> 
>         tglx

