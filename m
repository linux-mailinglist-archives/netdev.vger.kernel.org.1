Return-Path: <netdev+bounces-201211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D9AE8772
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46161BC1F91
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A73269B08;
	Wed, 25 Jun 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8iy5MuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC31A5BAE;
	Wed, 25 Jun 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863994; cv=none; b=LkNSFMFU0ORfhEhj5b20vHV88SS2IGNA17sPJA76anAA6rpoHS5uW/SknmxsZhmo9Ezq5PrOu7CjzrNKCFGZIJOBV4RKY43G7t0Lz4qJB1iQ2Gk/EiU/1CTbk3E3aCv+ymDTnf9aXSSOIMkK9afHkqy+9qJIXgLJG06MFfYLzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863994; c=relaxed/simple;
	bh=l5nird3PVMjr8OkJr+e7IHDK6msydbxihukDb/k8U0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/w5h/wKIZn3dLXrWPdPbkv/lbU/hLupNHVIWCgVceDgEtpH9WeluBjNLAw3QWiZtvEScp4B6JVnEejNtnYjVCs96wtIFpO06l6sHV4z9d52U7R4QDyeHOOL37E6GbstzhOoi5wjsvU3uTvqXaPatXYJ9gcpu2vw8sx6ptK0Wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8iy5MuV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df2fa07ee4so6275005ab.0;
        Wed, 25 Jun 2025 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750863992; x=1751468792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLxNZ2nfHdzqYuGH8fuWWbBZX9lmP9zWUSihpsHjHn8=;
        b=A8iy5MuVlrx1ya5TeQ1cQoSf0/rxnVG1G5UYR1zOXxee3lGRU5+UNJGPeCm7LAbVQf
         uKvQ246WKBMCF6oZekPIFDhrXEpn5QcZXpBVGBicMxXTkB/G5mz3D+P+KrwLvFnbgusP
         crpS3dhLX+G/+p8yszCXLUA+E60AaEw6DuAPLg5Tv3HsDZnJTlXnGQJwQemQJWIYdcND
         EbN3KN6Is3NPEbLvaiP2AlhFnRJFseRMPJE8cDC3dm1brq9DHwb3BhHvj8cATxFqkyqS
         U0Z6cZNFHayp40oEGcj2S7kFDJgXzfWtq9Jbo1Z063Cm7obMxGITgArhmTwvOKOyK57G
         hZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750863992; x=1751468792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLxNZ2nfHdzqYuGH8fuWWbBZX9lmP9zWUSihpsHjHn8=;
        b=qY5eVeRji/P24uaJmeaKCH6PhrpfeJ5kd5QjXT/OD9dIHTcjhfNXdjh25P7H/BckgN
         hcZj1MCDaZdPRdIDlJv2uhnox4s0bbrsDABEocJJSN4jx+0koD3M0vi6Js12jWMEN3gC
         j95da1IuuGcrj9JOgGRJa+ww+1QyW6pj20QIthZXUcjRroWuGb/HQn6DkPdBC4WCHoKm
         CGkLFald6m6Dx21NPsEmIiMDZerKJuSgc/JSdRtRAb/i5HKacGW4MjWOQuVI/Mvxq9oY
         fIpstpBN6PN52Arn3DNXW84FngTiqUKQGJAqwM77vQPrpBK0av65uKCP9h6S2r4IDtV8
         eeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5X8ZtuErw7ZCA8TdX1GO+3WZ4XeKfkoWG8u8ECpseHVqXjO76LHjYuSZDjE3JAGWxqbzJm+E=@vger.kernel.org, AJvYcCWWUq5t/J64ez7fYCV+9l0cLsPm3sGgi0lpUXLMlE4JtZKxBisBqkd5KC4oKPjBF4em9M+4@vger.kernel.org
X-Gm-Message-State: AOJu0YytkwGlqLkFjdCZ0SDKKfwU1CF9+BudurY4GsSxlQ2mMnT5NdCM
	+ODhC2/0HTVD+4VR0n1BKU5fmy8BDpHBEV0A/Lhn7TMd+LpUN0BEYEJKFw5nbg==
X-Gm-Gg: ASbGncsrOksfm1BEW35HW7wMaD0Y0bVDgijqCMgmN81FufIr9hOwZ6GoO53uJVJtwa5
	kWJyoDOTYqO9U6d9XYkDR3GlB+269lGeX4LfEZnIZc3swoWvqsj+zN01/X88wmKrp178sxoqliH
	8q7JuM7YEC8R8QN3tO8gsChXhPm9mZJofEQfweUZ9MTyi7XUKTxR/T4lChd94yWWgJICrAdRpmr
	hvKai/1U8AqT43h+Igt83TBXJSBBx1z+DxS2i4uqc8SHvc5o02bJHNuCQm+WoBGR+TGpN6J2FW1
	VE709+Qmw3Krcs1c/ILhiTHESqg8sev4IUUy+W3MYqozTyjw4qoewRIVfb/fztH3PC7LEhw95bO
	CnhAdYL6ck662BPLIuuYAm6Bhys0o7RbjZuGs1/viNMh2wulFW9ml
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

