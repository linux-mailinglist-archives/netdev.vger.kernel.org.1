Return-Path: <netdev+bounces-91421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB08B2843
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3DB224D7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF23A28D;
	Thu, 25 Apr 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7owl8bF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CB3A1BB;
	Thu, 25 Apr 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070522; cv=none; b=O80cREnjksZqAAjz1x23+q8r53QDS78sL1W/FiKT1vPuIgSFeKzff6eUnnWUEdqU9jrJ39esqFIASIRPNaU2QnDvxLYLNJOVv2YNi/vj2s6hQxtNXoW9YzHk4gkCq/m/clpf7LdSx9HpGNhLTdugDmzHwdJobHGjwtUdIg2Xkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070522; c=relaxed/simple;
	bh=UxjL0Brv5flxjKHMHvgRAYIFpaL1HlBkNX0x5SPNWJk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZBhYMPYIs3HQ042XPX8jm2ofIzH8Afu07fHtgOkDih9b5Y2aLWA/vu0oN0MPblHidbVfenmVo3PUB8fLLtLvXXp0KC3Q7RirUBgIpopyOqOVEXjvgcKlpIctf0b6/H72Zm1v1qtSVNC9d+fSKCppOLx59H5KDh07WeA9twNmsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7owl8bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F421C113CC;
	Thu, 25 Apr 2024 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070521;
	bh=UxjL0Brv5flxjKHMHvgRAYIFpaL1HlBkNX0x5SPNWJk=;
	h=Date:From:To:Subject:From;
	b=X7owl8bF7aMQohkgCaJ8OcqQIvm7L26yM+0DauW2DHRZY75gqe5iZtZ1CZaOg2Ihh
	 hMlBm9+lQn2sTlRVx6oGjareQLZMFCGK5FwbRuJmFlkx2wln2wIgJFwmcPyMlXIsdR
	 q2UAnw7LQ9nOXdLOtlFq83xqKlAxZ1QI4hQnyf4QG6gTD0RGrJQpHsBvW2pLMCXjlR
	 NJMyVlSgwaJoj1ZNGU/5yjdpMUHJzTuaPAGP/sIiz8OcBtu9cfS7UV680h8Gaji/rg
	 SV9iSxGPiD33NkzFF2alpFdhbBcvMspDr9aGW3+Vz6xToglnaWoI0KjPWDTrEqbPRm
	 m/CMD1kqPECrw==
Date: Thu, 25 Apr 2024 11:42:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] Differentiating "Supported" and "Maintained" drivers on
 something other than $$$
Message-ID: <20240425114200.3effe773@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

tl;dr - MAINTAINERS lists the following Status options:

	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.
	   Odd Fixes:	It has a maintainer but they don't have time to do
			much other than throw the odd patch in. See below..
	   Orphan:	No current maintainer [...]

Currently there's no process difference between Maintained and
Supported, the only distinction is whether maintainer is paid.

We would like to change that for Ethernet NICs, starting with Linux
v6.12, to require the netdev CI to be run against any driver which
wants the "Supported" status. Drivers which don't will get "downgraded"
from "Supported" to "Maintained"- but again, this has no impact on=20
the process or code acceptance, it's just a badge of honor.

The core networking stack itself is "Maintained", not "Supported".

---

*Background on Supported*

The Supported status in MAINTAINERS is most likely a historic attempt
to give developers working on Linux commercially (for pay) some
leverage to justify time spent on upstream work. Companies like having
their products listed as =E2=80=9CSupported=E2=80=9D, but in exchange devel=
opers can
point to the =E2=80=9Ccompany pays someone to work on this=E2=80=9D rule to=
 be allowed
to work on Linux on company time. This hopefully explains why the
=E2=80=9CSupported=E2=80=9D status exists, even though it=E2=80=99s rather =
meaningless from the
upstream process perspective. That is to say, it=E2=80=99s fairly obvious w=
hat
the difference between Maintained, Orphan or Odd fixes is. It=E2=80=99s much
harder to define the difference in expectations between codebase under
the =E2=80=9CMaintained=E2=80=9D status vs the =E2=80=9CSupported=E2=80=9D =
status.

Over the years Linux dominated some parts of the industry, and for
example for data center products companies need to provide solid Linux
support purely for business reasons. Regardless of the status of the
codebase, devices such as high speed NICs not working well with
upstream Linux reflect poorly on the company. This led to a situation
where the Supported status had lost its intended additional value to
the community. What=E2=80=99s worse, community members who work on Linux in
their own time may feel discouraged by the fact that the Supported
status (broadly seen as superior to Maintained), is unattainable to
them.

This situation does not apply to most parts of the kernel, but in
places where Supported lost its value we should either (a) stop using
Supported; or (b) more clearly define the expectations so that the
status continues to serve its intended goal of increasing upstream
participation. One part of the development process where upstream is
lacking in terms of collaboration between companies is driver testing.
This proposal puts forward a new requirement for Ethernet NIC drivers
that their owners must participate in netdev CI in order to earn the
Supported status.


*Plan and requirements*

1. Require all netdev Ethernet drivers listed as Supported in MAINTAINERS
   to periodically run netdev CI tests.

2. Must run all tests under drivers/net and drivers/net/hw targets of
   Linux selftests. Running and reporting private / internal tests is
   welcome.

3. The minimum run frequency is once every 12 hours. Must test the
   designated branch from the selected branch feed.

4. Note that branches are auto-constructed and exposed to intentional
   malicious patch posting, so the test systems must be isolated.

5. Drivers supporting multiple generations of devices must test at
   least one device from each generation. A testbed manifest (exact format
   TBD) should describe the device models tested.

6. The driver maintainer may arrange for someone else to run the test,
   there is no requirement for the person listed as maintainer (or their
   employer) to be responsible for running the tests.

7. The tests must run reliably and failing to do so will result in
   losing the Supported status.

8. Test failures due to bugs or incompatibility (rather than inadequate
   / buggy infrastructure) are not a basis for losing Supported status.

9. netdev CI will maintain an official page of supported devices,
   listing their recent test results.

a. Collaboration between vendors, hosting GH CI, other repos under
   linux-netdev, etc. are most welcome.


*Timeline*

May 1st - official announcement and notifying driver maintainers

The new guidance will take effect starting with Linux v6.12. This means
that any new driver merged for v6.12 (i.e. merged into net-next during
v6.11 release cycle) will need to come with running CI to be considered
Supported. During the v6.12 merge window all Ethernet drivers under
Supported status without CI will be updated to the Maintained status.

The exact dates in the Linux release process are somewhat unreliable,
but the current prediction is that these events should roughly
translate to any new driver requiring CI to be Supported starting on
August 11th 2024, and existing drivers without CI being changed during
the second week of October 2024.


Feedback welcome!

