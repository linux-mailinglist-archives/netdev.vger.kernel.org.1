Return-Path: <netdev+bounces-201209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B680BAE876C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD07175FA5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718A269817;
	Wed, 25 Jun 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOgJ0x64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DF267721;
	Wed, 25 Jun 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863957; cv=none; b=aXgpBApNsQmjUokJel9KOoxJnQLnbrSgTtfXJpIM0tasPQHYHDTEzZn8Xcz6KPZah9S4bPVq9xRter5cfI7YM6kMxw93oiNL09zHy9myQmAqGkMEAyF7jnYUUuZbeKlj0W9DXjnYjUGIbdgp8PTcW2CsAAYxQGFKbaT7uUeJOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863957; c=relaxed/simple;
	bh=l5nird3PVMjr8OkJr+e7IHDK6msydbxihukDb/k8U0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxSdP2k6YHzEPGeiZpDtWU1RgHyVrXM1G5y165USUkicFi7/VaZKLUnMNz3tvTI74YSu1SIfUkU06OEfAETyxolHKpIZlV+k9WPemTE+zTgmDZHnYuoqzo6JKhzZMxa2jO0+yJRCR7aUULa93hS1k+eN2XpIpC1pjneHovNm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOgJ0x64; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafdd322d3so140916d6.3;
        Wed, 25 Jun 2025 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863951; x=1751468751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLxNZ2nfHdzqYuGH8fuWWbBZX9lmP9zWUSihpsHjHn8=;
        b=cOgJ0x640hNWts2LD06lAOgc4G070c5V3qK6Y9/S5IJpTGib5P9lvwhGle+E+94kk8
         W/pBt7gqX9ayUloGyrp9f6UekoPIb02duf+Cxx7/wOoM6NOfuE7/hZ5GxKqHVa85XTG3
         zj7hzzUXPMbiIfh4mCYeCK5M6Xvg3iyc0hReKH9MYsOHcp0ygHhQBZB1tAwU0eeCxjOv
         HoBYSwTsgPMJdeMlGn3D1flY8i9fH7EUAiMwUhopPdV1pu4WDvX9LQ2gR27t69qpX6Ny
         xOt9QGz5qo76hOU84qcftOiw0A2ArFQhrXct59nid4gaRqDqxa19bLhYRlGZV35WWW3/
         mOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863951; x=1751468751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLxNZ2nfHdzqYuGH8fuWWbBZX9lmP9zWUSihpsHjHn8=;
        b=dDGAi0Ki7bzrFBumauR5NTy7+CKPdfzXLJcW+kSype+XT9FatoMaICiLMRL4koJdHt
         Lg2+7FFGYPE0vogPqI3r5wQycZORaHqGuyggZfyl0VHjr27lXeDTAb1+bpazU+LEd43d
         b9k3DC7FiJtMXbbQ6jL1E9YVS1+k2lSWVVOtYjTkec+fbgG/y3BLaUtnb8nqcqBuiebc
         Zo/EEt5f9tcFm7TRDvnwxm/NXiNhILA63cXTeITIfNUKI2Fk0JB3B2Q4Dl22nzEBXpkV
         D/2N9bw65xxCeHyLLKzVBEw18zytAESWVyakhn6W60mFYvjPuj852r3WkhH4soj/9a7Z
         l2WA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUNuF9vCTGcz5YkED5Vm3XWBI2VC+yvpS2lJ7toLOY2FhpdDdsjHkKfeRXvM9BNgOWK97@vger.kernel.org, AJvYcCVdtEmz99GjC2bogmlobzH1+xaIaMOq3jQ6RNvY5w8oUlVBuIAzeojabek7BB+VU4Kmhtw3KZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwZhbgVUlO4MTSblU4pKqMKV5slipqM4bnAFQe+xtsMi+QSau
	ACS0sAPJWd5Fbtrsu6frxqHDY5DqwT5YvYMwuu7/L90iOKA8YNfpP5v6
X-Gm-Gg: ASbGncu43ROec5Y48lMB+LVM8BQLXnjCQ79qmdMMpsUc2h+1aspGvoZOQCiDtAC2CD0
	px6jd3YkgXQCantTtaTAvqyiH2PB3BfAgE52c15yRRyYsLdFV96Z6o9lPI2xiqACWU3mxfP8mbB
	7GqH+N2s4KAHQh44f2EbMLrR5sKtqQMUMyYOqjcb5n9fuFi/XIK6eS9FmfviVZ1uq1VNDOm61EF
	cykbHXnUyOAHTmYtHm1KLN8pjRLi3LfJ/3KJaBTLUffQd8d4kdpwaxc7/lfjMk7CNbjXyq8Pjjw
	6jTfn3RHwzoH/AH4keXdALwWIAKk20/hnE2xMbBOvVozpHDlTC4vYw0aZCAkkpfRO6APX08IaV7
	0Mce6meSKbzDqPV6PahiEQQqEo4udEAXrzM+f4RKbHRbOiracjdR9
X-Google-Smtp-Source: AGHT+IFdz1ZJDNBl9FpRjIaT86z6/EovaIOb64kf6xyyuNuZOIkf+JVRuQzNIU1aW33VTHbLIA6Z+A==
X-Received: by 2002:a0c:f094:0:20b0:6fd:7297:2559 with SMTP id 6a1803df08f44-6fd72972603mr14952046d6.17.1750863950754;
        Wed, 25 Jun 2025 08:05:50 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd74e3266bsm553516d6.53.2025.06.25.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:05:50 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 76F22F40066;
	Wed, 25 Jun 2025 11:05:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 25 Jun 2025 11:05:49 -0400
X-ME-Sender: <xms:TRBcaN9ZCL7uxn4N9ZSzV4Lqwi4hxqVyUFqsxRp1MFszhNhiagY3Ig>
    <xme:TRBcaBu61u1IQTaJg07QPnRqXGYpnD31VJzoLZIgWq1jJAjRSB_g_bVZUyPSmJ1bV
    F7LpIbuKPLp0Uwn6Q>
X-ME-Received: <xmr:TRBcaLDX5SEzsqsRxfnPyNcN1VQ_7640b26ou4SdFWbrWn9bjdp34i8nTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnheptddtudegueevgefhgfeuffetffeuheekgedtffefhefhjeffhffgfeeggeetgefh
    necuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvg
    hsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:TRBcaBdiyKmSKN6yAsWQbHtK7PNQ8pkLpKdcumGnpWtLqi8Q-qBSeg>
    <xmx:TRBcaCMy6u3UWL2myLBVB-wVwUgHu_oy8pAN0Y3soombcrtAb0LfNw>
    <xmx:TRBcaDln7cjIRHYvXtP9l6Yd38-RyNWbdOJGABi7z78r-sPHZHmNZw>
    <xmx:TRBcaMu6--A2BLrRrytFLQZzC7h1QhMl16s2oXHkyj8QonV5HcT6xg>
    <xmx:TRBcaEu31TpZ6gt7pf_E8pt1WBmper8QRMzjW8P7H52Jfw_C9JE7O4Tj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 11:05:48 -0400 (EDT)
Date: Wed, 25 Jun 2025 08:05:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
Message-ID: <aFwQTO-_t-P5rLUp@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
 <3e2a80e6-b3c5-44dd-b290-1d140cc427ff@efficios.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2a80e6-b3c5-44dd-b290-1d140cc427ff@efficios.com>

On Wed, Jun 25, 2025 at 10:25:23AM -0400, Mathieu Desnoyers wrote:
> On 2025-06-24 23:10, Boqun Feng wrote:
> [...]
> > +
> > +static inline void shazptr_clear(struct shazptr_guard guard)
> > +{
> > +	/* Only clear the slot when the outermost guard is released */
> > +	if (likely(!guard.use_wildcard))
> > +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
> 
> How is the wildcard ever cleared ?
> 

The outermost shazptr_guard will have .use_wildcard being false, so it
will clear the wildcard. E.g.

	g1 = shazptr_acqure(a); // g1->use_wildcard is false
				// this cpu's hazptr slot is 'a'.
	g2 = shazptr_acqure(b); // g2->use_wildcard is true
				// this cpu's hazptr slot becomes
				// WILDCARD.

	shazptr_clear(g2);	// do nothing
	shazptr_clear(g1);	// clear this cpu's hazptr slot to NULL.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

