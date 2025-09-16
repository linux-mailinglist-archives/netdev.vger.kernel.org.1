Return-Path: <netdev+bounces-223752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F318BB5A45F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED98485829
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139F320A38;
	Tue, 16 Sep 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qM42Vx1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728D31BCA5
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059871; cv=none; b=t8PwEds2bRWdJVG4J3BAW2wM0135YJVEz4eBKIu1xG/PCScVu9FU24D2+efv1VsH4V2NcUG2pQWsHHpZnGpOSCCE4lOTlURYtIgw7P84az2LsROrUXD1RFHxQCdY6cRYxGaVFLPWAy9tkf1xppa3s5FpQmfkamoOTiaY1B1MG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059871; c=relaxed/simple;
	bh=blW92P8YkiivSz5fIKww8C/KZYzOZ86psSQ6njb3KPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qk0tvKN2V2PcejP1GNPKoEar8VMu+kiLYyIqroOqvZ5HzGWs4FQcbM1a8ZP8JW3Q/FQrrVB1VYEUf/xhJuv0pxcn+rBPIxEJa5dWlyPGQQF5OBWu7uze5Ezg7rwIfDKxbG6tOyFZlBDt0LUeVftQkgCoClZJnmq4RwsSLbFao7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qM42Vx1L; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5886E415E5;
	Tue, 16 Sep 2025 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758059866;
	bh=noD9e8yEyg9+FPISoF6WTDqDHw9IK/+aaaw6u9f40KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=qM42Vx1LH7EkdEddsI2zuczz5AomBnq4RROrwUkipD/pe5jCNZNxhfr7jOJTRcqOK
	 510EgBm79s+1Q4PNlCwQmBh0bdAqQ+3MzanFIsX56JSIpjKxUo6RT/WfC8OCRITkbF
	 OclksQ37CYsKIS3CrKPj5GTOz7j6C373PmLfZffIu8/YbJtBdSWrp6wS+03yjNQfEJ
	 dyKThzMEw9xpsG0P9o6JbPRPb/yzHskJ/qHOgg+/eicQ34V7CNh7RIAlxcfUsebC4z
	 3BZ0d9ZU7VIPG7LTG8DGMFzzw+Ehi0V2p/Z7OGajo8cGnmRgUK8jV6vGCW0InlJZAD
	 5K8bXzAkDqzOA==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v3 0/4 iproute2-next] tc/police: Allow 64 bit burst size
Date: Tue, 16 Sep 2025 14:57:27 -0700
Message-Id: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
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


