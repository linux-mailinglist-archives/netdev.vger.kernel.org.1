Return-Path: <netdev+bounces-221548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6DB50C82
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8869E3B56A3
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9682609EE;
	Wed, 10 Sep 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="JqgfHtVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbqJTg3g"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40B19CC27
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477099; cv=none; b=VoaVX50JTMN2Y8CnV867cVCM4hnBiJbOKVZVeZkjobnXQtdgxeHj1qy2bkdGa9nuKSrnL52EncbSvTsdM+jfV3r3AKOs3aNaeOT68NxiJt2gW6Xt7WTrO5wxNJleKkGPpnSsK4tKVLmHBenWopyd/crTwk+O+k7rRHHNNt4eBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477099; c=relaxed/simple;
	bh=5CgFgZpzFlj9xjg7HZ+NQAw5E4k4wk6Uwhk7RfYTu/I=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=IFgWHmxiufrqGLMix9MaDTv357cNU3AjO3W+griouaMkdErW8q1s9Vk89X/ooW6H6Hn0MgNmZDVC1Jdtqu2uJ71HCfRtGZKhroDuon7xH2cuiA7BcCNfIOMn95CI/dqjYoXy4jJQTX15wGuxeytaWgmus0RqqTXbQ/7QN20o618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=JqgfHtVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbqJTg3g; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B10DE1D0023F;
	Wed, 10 Sep 2025 00:04:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 10 Sep 2025 00:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1757477095; x=1757563495; bh=1gUR2mvqN1Qhei34vQ8ZpMd05n1i9vZ3
	dex/ti6zdX8=; b=JqgfHtVuftf0Tr3RfFQf0JQK8qc1fUTCu8q7XtK4oEC/nDnQ
	zBShjKPqbXwnYXaf/RXRYkjTUkfFRrNUXnNcg28v/4cAhizeynw7Y0bDLxQsoYqR
	x+Nb8OuazVxNNBwMlMrKwR9yuOhrwXS+EUBD2pKqV6FodsQbhSzUwaIvd1+PNHwQ
	La0Fu+K8AiYDhB88Q70SA7AbtKWL9Zvt9JA6cKB2/EiUJqUV/z55W5IB8PRwvK8y
	nbsRUTAFs4zjXOMHqEbT62YiazFbOoEXQSqOwfNaQZHFANOJkfjTTlQCD/DAalsQ
	IoqEC8VOQ0qq8tYs+uCSSwMQA7lyqJr9WKCfDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757477095; x=
	1757563495; bh=1gUR2mvqN1Qhei34vQ8ZpMd05n1i9vZ3dex/ti6zdX8=; b=I
	bqJTg3gF2J+2zWJEM/MDwmVaKtRjH3FsZBt8Pv6rgPYzQ1+EOOrABnqV35P+W6xc
	sTDVZCc1rJ3zgwmpybtSYuexmUKU8oWZkilxNyzrsHLGLijkl9T1ru/hhiP2Wtie
	UWeXbwSpS0iSfHTSKEeo53Ic+5omQVBCuCYhuW6FLtgCL7mecloZLVWHpj2wpBkC
	eID99w9A1TnRe7xhhK2o5pj5m/aJqqkyhKYUi5hxVARnBDSFqM/5vAP57XmLzl70
	2EdK4lt2bDb3sh29Pw89uTAi+kXCQdH3eB1klTjC+UoB4vKqW4V88Oh6fA84aq8I
	jTVuRcMbXVuAk1jJ/0rcw==
X-ME-Sender: <xms:5_jAaHDTrmZbVo3O76NXw52fw00Q3Aj18Uqmozs7j-xAXHmKjpUJTQ>
    <xme:5_jAaIG0kEPrMxMRtnxQiFjyQmWDVlLCUX_sy2pcD5spEUIaKIfg76ek4y6f8A_zX
    Bi9F-eynTbkJ4yk5YI>
X-ME-Received: <xmr:5_jAaPLO1OQCyaLeqxYKD19rSWoJG9mqUpdcbOj9cjTz3y_Elwttx984MZewRE0p3SfOPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepughsrghhvghrnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjhhhssehmohhjrghtrghtuhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvght
    fihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5_jAaMm-4vCeAumjjwx3sx7yFphpg8Vre5b7boLmp2Kw_k9_TrwG1g>
    <xmx:5_jAaHQf1sXTa5PyZzVu6MF4Jf1I2BGOUSgcwDgWdNIPvQtIlRFs5w>
    <xmx:5_jAaOKvSLvTYnq9dcVfKBVp5EXT8HHvZKLZLAzkZvLNbBNgrlKTRw>
    <xmx:5_jAaNDVfEcVNfeJEWZdmy7jpz4JTXU7Ovfwrxe4L__dJ3dmh5xXvA>
    <xmx:5_jAaAHXmoMTLmxs-DbeO0rOc8ElHXTiLCao74lFQ3aI8M9jUBMWFhqp>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 00:04:54 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C03269FD4F; Tue,  9 Sep 2025 21:04:53 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id BF4499FD43;
	Tue,  9 Sep 2025 21:04:53 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>
cc: netdev@vger.kernel.org,
    Stephen Hemminger <stephen@networkplumber.org>,
    David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
In-reply-to: <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com> <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
Comments: In-reply-to Jamal Hadi Salim <jhs@mojatatu.com>
   message dated "Tue, 09 Sep 2025 23:32:40 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 21:04:53 -0700
Message-ID: <2940856.1757477093@famine>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:

>On Sat, Sep 6, 2025 at 9:50=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>>
>>
>>         In summary, this patchset changes the user space handling of the
>> tc police burst parameter to permit burst sizes that exceed 4 GB when the
>> specified rate is high enough that the kernel API for burst can accomoda=
te
>> such.
>>
>>         Additionally, if the burst exceeds the upper limit of the kernel
>> API, this is now flagged as an error.  The existing behavior silently
>> overflows, resulting in arbitrary values passed to the kernel.
>>
>>         In detail, as presently implemented, the tc police burst option
>> limits the size of the burst to to 4 GB, i.e., UINT_MAX for a 32 bit
>> unsigned int.  This is a reasonable limit for the low rates common when
>> this was developed.  However, the underlying implementation of burst is
>> computed as "time at the specified rate," and for higher rates, a burst
>> size exceeding 4 GB is feasible without modification to the kernel.
>>
>>         The burst size provided on the command line is translated into a
>> duration, representing how much time is required at the specified rate to
>> transmit the given burst size.
>>
>>         This time is calculated in units of "psched ticks," each of which
>> is 64 nsec[0].  The computed number of psched ticks is sent to the kernel
>> as a __u32 value.
>>
>
>Please run tdc tests. David/Stephen - can we please make this a
>requirement for iproute2 tc related changes?

	I was not familiar with those tests (but see them now that I
look in the kernel source).  I did run the tests included in the
iproute2-next git repository.

>Jay, your patches fail at least one test because you changed the unit outp=
uts.
>Either we fix the tdc test or you make your changes backward compatible.

	I'll run the tdc tests and have a look at the failures.

>In the future also cc kernel tc maintainers (I only saw this because
>someone pointed it to me).
>Overall the changes look fine.

	Understood, but this isn't documented in iproute2.  Perhaps the
iproute2 MAINTAINERS should have a tc section to clarify this
expectation?

	-J

>cheers,
>jamal
>
>>         Because burst is ultimately calculated as a time duration, the
>> real upper limit for a burst is UINT_MAX psched ticks, i.e.,
>>
>>         UINT_MAX * psched tick duration / NSEC_PER_SEC
>>         (2^32-1) *         64           / 1E9
>>
>>         which is roughly 274.88 seconds (274.8779...).
>>
>>         At low rates, e.g., 5 Mbit/sec, UINT_MAX psched ticks does not
>> correspond to a burst size in excess of 4 GB, so the above is moot, e.g.,
>>
>>         5Mbit/sec / 8 =3D 625000 MBytes/sec
>>         625000 * ~274.88 seconds =3D ~171800000 max burst size, below UI=
NT_MAX
>>
>>         Thus, the burst size at 5Mbit/sec is limited by the __u32 size of
>> the psched tick field in the kernel API, not the 4 GB limit of the tc
>> police burst user space API.
>>
>>         However, at higher rates, e.g., 10 Gbit/sec, the burst size is
>> currently limited by the 4 GB maximum for the burst command line paramet=
er
>> value, rather than UINT_MAX psched ticks:
>>
>>         10 Gbit/sec / 8 =3D 1250000000 MBbytes/sec
>>         1250000000 * ~274.88 seconds =3D ~343600000000, more than UINT_M=
AX
>>
>>         Here, the maximum duration of a burst the kernel can handle
>> exceeds 4 GB of burst size.
>>
>>         While the above maximum may be an excessively large burst value,
>> at 10 Gbit/sec, a 4 GB burst size corresponds to just under 3.5 seconds =
in
>> duration:
>>
>>         2^32 bytes / 10 Gbit/sec
>>         2^32 bytes / 1250000000 bytes/sec
>>         equals ~3.43 sec
>>
>>         So, at higher rates, burst sizes exceeding 4 GB are both
>> reasonable and feasible, up to the UINT_MAX limit for psched ticks.
>> Enabling this requires changes only to the user space processing of the
>> burst size parameter in tc.
>>
>>         In principle, the other packet schedulers utilizing psched ticks
>> for burst sizing, htb and tbf, could be similarly changed to permit larg=
er
>> burst sizes, but this patch set does not do so.
>>
>>         Separately, for the burst duration calculation overflow (i.e.,
>> that the number of psched ticks exceeds UINT_MAX), under the current
>> implementation, one example of overflow is as follows:
>>
>> # /sbin/tc filter add dev eth0 protocol ip prio 1 parent ffff: handle 1 =
fw police rate 1Mbit peakrate 10Gbit burst 34375000 mtu 64Kb conform-exceed=
 reclassify
>>
>> # /sbin/tc -raw filter get dev eth0 ingress protocol ip pref 1 handle 1 =
fw
>> filter ingress protocol ip pref 1 fw chain 0 handle 0x1  police 0x1 rate=
 1Mbit burst 15261b mtu 64Kb [001d1bf8] peakrate 10Gbit action reclassify o=
verhead 0b
>>         ref 1 bind 1
>>
>>         Note that the returned burst value is 15261b, which does not mat=
ch
>> the supplied value of 34375000.  With this patch set applied, this
>> situation is flagged as an error.
>>
>>
>> [0] psched ticks are defined in the kernel in include/net/pkt_sched.h:
>>
>> #define PSCHED_SHIFT                    6
>> #define PSCHED_TICKS2NS(x)              ((s64)(x) << PSCHED_SHIFT)
>> #define PSCHED_NS2TICKS(x)              ((x) >> PSCHED_SHIFT)
>>
>> #define PSCHED_TICKS_PER_SEC            PSCHED_NS2TICKS(NSEC_PER_SEC)
>>
>>         where PSCHED_TICKS_PER_SEC is 15625000.
>>
>>         These values are exported to user space via /proc/net/psched, the
>> second field being PSCHED_TICKS2NS(1), which at present is 64 (0x40).  tc
>> uses this value to compute its internal "tick_in_usec" variable containi=
ng
>> the number of psched ticks per usec (15.625) used for the psched tick
>> computations.
>>
>>         Lastly, note that PSCHED_SHIFT was previously 10, and changed to=
 6
>> in commit a4a710c4a7490 in 2009.  I have not tested backwards
>> compatibility of these changes with kernels of that era.

---
	-Jay Vosburgh, jv@jvosburgh.net


