Return-Path: <netdev+bounces-202883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B9AEF85B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA87B1910
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7A2741AB;
	Tue,  1 Jul 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1JISI0m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqCkYBBY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDC2741A6;
	Tue,  1 Jul 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372625; cv=none; b=s1UpjoNzDgZBYtxJSRN8NpnZ2oRVXubGZMpI8fmKMNlHT42dYeHZ/8TZ9JyobWGQ7OeMTZ6LaSPX9H5Y9mIkW/i/UfCKMHMOEVBuq7PzlVP1GtEmMlCBruvPSyB0FvHS+nb/ft1G9nJAskO3+3uptvtLFio1rnXCH0dzhO1tDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372625; c=relaxed/simple;
	bh=9nlou7VVvbnpibGWPZLlU8AW7nEx/UkPOp8/VdZdEbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sOYpjMhweZMfcVX1B80pCZSBRMsKN8diDpaPD4rUY0IwT5gi9v3/wGFFhAG7/4WUyckbozNdopMChAIfIh34wQDK4/WZEBwH1wHgJDTH8wdDAnSaRHo/JFRxqAYYfwC03wdXgLeSJJSVYbkRko1AnIJwWIMy2gWbkqkUb2T01tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1JISI0m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqCkYBBY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751372621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YynLe9Y0R1ZnzK2pV6bI4BTlb8INUrb2JzuFOPMblXM=;
	b=I1JISI0mzO9078e3C6dz/XhRJlBWIdbS/XedG5tYz5RRi0Hal1aOBKIpkGs1aUucpjWLE3
	TO9VWvbnfSPfLrWCnU/D+18cmUS068gt6q0mOjXKGy89DCpwWVTmZ6lOLxpC6j01S4vte3
	KcGwAHEscOU5tTgyBAJP3iH78Q0wbxeIACdCDm/172+Lmlvxe9EOyNB61XNXy7oy1ldfM2
	3/FHEYo6sE4p4QC4QY/AxNO9PU1IcNdeu67hrJURuX5HvjlIJ6K81RFBF1zn4H4AQTGyec
	UyHuKuDQ6CbfpMyJR7LVVxaScJ7Vh4mOjCrJnHScETMvSnB9V+gaYTElCXJQgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751372621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YynLe9Y0R1ZnzK2pV6bI4BTlb8INUrb2JzuFOPMblXM=;
	b=mqCkYBBY5g+6cne3JW8WimKDgXSelqerYl9xFT0naQKu5HMVicZy+L3eCmsLOkp2193ET7
	024j8edbTqJD0bBw==
To: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>, John Stultz
 <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <852d45b4-d53d-42b6-bcd9-62d95aa1f39d@redhat.com>
References: <20250626124327.667087805@linutronix.de>
 <852d45b4-d53d-42b6-bcd9-62d95aa1f39d@redhat.com>
Date: Tue, 01 Jul 2025 14:23:39 +0200
Message-ID: <871pr0m75g.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01 2025 at 12:16, Paolo Abeni wrote:
> On 6/26/25 3:27 PM, Thomas Gleixner wrote:
>> It is also available via git with all prerequisite patches:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver-auxclock
>> 
>> Miroslav: This branch should enable you to test the actual steering via a
>> 	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.
>
> I have some dumb issues merging this on net-next.
>
> It looks like we should pull from the above URL, but it looks like the
> prereq series there has different hashes WRT the tip tree. Pulling from
> there will cause good bunch of duplicate commits - the pre-req series vs
> the tip tree and the ptp cleanup series vs already merge commits on
> net-next.
>
> I guess we want to avoid such duplicates, but I don't see how to avoid
> all of them. A stable branch on top of current net-next will avoid the
> ptp cleanup series duplicates, but will not avoid duplicates for
> prereqs. Am I missing something obvious?

No. I messed that up by not telling that the PTP series should be
applied as a seperate branch, which is merged into net-next. That way I
could have merged that branch back into tip and apply this pile on top.

Let me think about an elegant way to make this work without creating an
utter mess in either of the trees (or both).

Thanks,

        tglx







