Return-Path: <netdev+bounces-220652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D17B4789D
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDC43A8DEE
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571F195FE8;
	Sun,  7 Sep 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GRB7zK7n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6E189BB0
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209805; cv=none; b=l7+nEHifJo8jcP2zz2ZtolspzFqyN6086uKRrrCy0dJ5833Q1PTb8QuPQenF5+C8XRzxy4AFsb6DJJ2cy0mZa7j4BAr9elK3E7GFaGwmGwwNBC83Xm2fU1iUwfJB6fTlA0pyGRdAn+m0DhUPiHLtkPcVJp4w790sXQ5GECrex8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209805; c=relaxed/simple;
	bh=blW92P8YkiivSz5fIKww8C/KZYzOZ86psSQ6njb3KPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L+ANgW+nFIxDxbV12RINavON/lMf8zV+q/C3pD5lCZ/VORWgwGcnIjC6U9urqNy6YJ+jB9DubSDyM6iGiqcaWv7yr6FBxxZ/duAXCm+RGXRnNMOqWOkHplpq/yblcDvUAjyAtdghDSwHLj2Wuzb9LUe5owpoVPykIkQoLK6k0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GRB7zK7n; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 75D5340408;
	Sun,  7 Sep 2025 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757209347;
	bh=noD9e8yEyg9+FPISoF6WTDqDHw9IK/+aaaw6u9f40KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=GRB7zK7nbn5V9zBvmrR2sk2v2yEMOKox/yWplx2D1pNY11UFsaGFAxUAB9Av0/ELZ
	 vCg64KnzWMkNr83KY1kpQfCNVsOFJq23+OhPtphqQdgWhTaMu0HclZSoWrPRWQc9MO
	 ytdrk8l+HUawQRvqpY8abua8Vb7R4rrt54gIulv3JBD6gou8sxCKOwqwWm3sq4hdd6
	 1RD5D5IU0wpTOjgkJOcHTKJpigfcdIh2fZLOnRL9kK1dhmBqsBv2YEMsw5pirLgCUZ
	 A95Mu0Fa+g0kjdNrKPL/RrfI8+Sm00vP1NDmSLV4ZougOxfiolMNHqPk7w34Ogxsnd
	 ksiHI/eXTfDOw==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
Date: Sat,  6 Sep 2025 18:42:12 -0700
Message-Id: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


	In summary, this patchset changes the user space handling of the
tc police burst parameter to permit burst sizes that exceed 4 GB when the
specified rate is high enough that the kernel API for burst can accomodate
such.

	Additionally, if the burst exceeds the upper limit of the kernel
API, this is now flagged as an error.  The existing behavior silently
overflows, resulting in arbitrary values passed to the kernel.

	In detail, as presently implemented, the tc police burst option
limits the size of the burst to to 4 GB, i.e., UINT_MAX for a 32 bit
unsigned int.  This is a reasonable limit for the low rates common when
this was developed.  However, the underlying implementation of burst is
computed as "time at the specified rate," and for higher rates, a burst
size exceeding 4 GB is feasible without modification to the kernel.

	The burst size provided on the command line is translated into a
duration, representing how much time is required at the specified rate to
transmit the given burst size.

	This time is calculated in units of "psched ticks," each of which
is 64 nsec[0].  The computed number of psched ticks is sent to the kernel
as a __u32 value.

	Because burst is ultimately calculated as a time duration, the
real upper limit for a burst is UINT_MAX psched ticks, i.e.,

	UINT_MAX * psched tick duration / NSEC_PER_SEC
	(2^32-1) *         64           / 1E9

	which is roughly 274.88 seconds (274.8779...).

	At low rates, e.g., 5 Mbit/sec, UINT_MAX psched ticks does not
correspond to a burst size in excess of 4 GB, so the above is moot, e.g.,

	5Mbit/sec / 8 = 625000 MBytes/sec
	625000 * ~274.88 seconds = ~171800000 max burst size, below UINT_MAX

	Thus, the burst size at 5Mbit/sec is limited by the __u32 size of
the psched tick field in the kernel API, not the 4 GB limit of the tc
police burst user space API.

	However, at higher rates, e.g., 10 Gbit/sec, the burst size is
currently limited by the 4 GB maximum for the burst command line parameter
value, rather than UINT_MAX psched ticks:

	10 Gbit/sec / 8 = 1250000000 MBbytes/sec
	1250000000 * ~274.88 seconds = ~343600000000, more than UINT_MAX

	Here, the maximum duration of a burst the kernel can handle
exceeds 4 GB of burst size.

	While the above maximum may be an excessively large burst value,
at 10 Gbit/sec, a 4 GB burst size corresponds to just under 3.5 seconds in
duration:

	2^32 bytes / 10 Gbit/sec
	2^32 bytes / 1250000000 bytes/sec
	equals ~3.43 sec

	So, at higher rates, burst sizes exceeding 4 GB are both
reasonable and feasible, up to the UINT_MAX limit for psched ticks.
Enabling this requires changes only to the user space processing of the
burst size parameter in tc.

	In principle, the other packet schedulers utilizing psched ticks
for burst sizing, htb and tbf, could be similarly changed to permit larger
burst sizes, but this patch set does not do so.

	Separately, for the burst duration calculation overflow (i.e.,
that the number of psched ticks exceeds UINT_MAX), under the current
implementation, one example of overflow is as follows:

# /sbin/tc filter add dev eth0 protocol ip prio 1 parent ffff: handle 1 fw police rate 1Mbit peakrate 10Gbit burst 34375000 mtu 64Kb conform-exceed reclassify

# /sbin/tc -raw filter get dev eth0 ingress protocol ip pref 1 handle 1 fw
filter ingress protocol ip pref 1 fw chain 0 handle 0x1  police 0x1 rate 1Mbit burst 15261b mtu 64Kb [001d1bf8] peakrate 10Gbit action reclassify overhead 0b 
        ref 1 bind 1 

	Note that the returned burst value is 15261b, which does not match
the supplied value of 34375000.  With this patch set applied, this
situation is flagged as an error.


[0] psched ticks are defined in the kernel in include/net/pkt_sched.h:

#define PSCHED_SHIFT                    6
#define PSCHED_TICKS2NS(x)              ((s64)(x) << PSCHED_SHIFT)
#define PSCHED_NS2TICKS(x)              ((x) >> PSCHED_SHIFT)

#define PSCHED_TICKS_PER_SEC            PSCHED_NS2TICKS(NSEC_PER_SEC)

	where PSCHED_TICKS_PER_SEC is 15625000.

	These values are exported to user space via /proc/net/psched, the
second field being PSCHED_TICKS2NS(1), which at present is 64 (0x40).  tc
uses this value to compute its internal "tick_in_usec" variable containing
the number of psched ticks per usec (15.625) used for the psched tick
computations.

	Lastly, note that PSCHED_SHIFT was previously 10, and changed to 6
in commit a4a710c4a7490 in 2009.  I have not tested backwards
compatibility of these changes with kernels of that era.


