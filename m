Return-Path: <netdev+bounces-99765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7508D64DA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B015D1C24CF7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EE56773;
	Fri, 31 May 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gJhSWPMl"
X-Original-To: netdev@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE932558B9
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167019; cv=none; b=HsnbLgCZ+WZFK8qFk+uCTKx52/MDDnzcuYuk4sPKVFHRFJfFAqK1TEuWckqGjZKy52fS92m/ksxSuCI3hjEPsQsTUoIquxp3ZsP2EjmHb/+ou9Acq5EQ9CoIXH72lOXkVo+2fFbN0ipL36T8pXT+Ptv05xYMjdUwfzFWOJ6nVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167019; c=relaxed/simple;
	bh=zIxJj+eFNW131CghuD8tAVb+DXZz1K/r7747QzysLZ0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oW+mgk/JzCEWbj/MSguO9ruf7/+HBg6wJrtWynZ1lXeI+mnMtM1ci/x2Pav3T86WguvYz9aVaDzchYW8K8n7ctV3swzkr3wqwfWXQKXQ3AlDxx2SNZVSJT6AVH/px0MVqzPuR3aaKrIOQo5XYbayd2izxfeUjQFd705/nq7hzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gJhSWPMl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-149-40-50-56.datapacket.com [149.40.50.56] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44VEnwYM020082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1717167002; bh=TVitHfGXx2wIQGCXtRSfpVuiPAJXkRLy5+/11kjTZi8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gJhSWPMlva12midGaeg/PHU2neWOcKsKiFso7tYpYY6tMVpafdbk0znXMFEK9H1hU
	 qdyBPtkEngiB7yqQ+IbNrHlkWYOWgTjcvQgJNO7MTOTZisvZdZSoDHJWY3lqeJaYZE
	 U38u43F9VE4lFxJknYqgbIoTNE+P1A2Q4LVc12BHeDv1KKY88JN9DqWz4hzA6iWmx8
	 y2TY1uFckzpWjIiew4C1qPlARFYwrj6ebMmhkk+fiFQEX7rpKDXel6j5rvPRdi9eDf
	 HMJqjXMcGDUiuhpBoML4bUHQ6xIbM2FnKtOoPuHSbUzya2eBGa7gg01LX6ZZmBbqR2
	 QX791qc6scs2g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 257EA340A68; Fri, 31 May 2024 16:49:57 +0200 (CEST)
Date: Fri, 31 May 2024 16:49:57 +0200
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, ksummit@lists.linux.dev
Subject: Maintainers Summit 2024 Call for Topics
Message-ID: <20240531144957.GA301668@mit.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This year, the Maintainers Summit will be held in Vienna, Austria on
Tuesday, September 17th, 2024, just before the Linux Plumber's Conference
(September 18--20th).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

Linus has generated a list of people for the program committee to
consider.  People who suggest topics that should be discussed at the
Maintainers Summit will also be added to the list for consideration.
To make topic suggestions for the Maintainers Summit, please send
e-mail to the ksummit@lists.linux.dev with a subject prefix of
[MAINTAINERS SUMMIT].

To get the most out of our topic discussions, folks proposing a topic
should also suggest relevant people and desired outcomes.

For an examples of past Maintainers Summit topics, please see these
LWN articles:

 * 2023 https://lwn.net/Articles/951847/
 * 2022 https://lwn.net/Articles/908320/
 * 2021 https://lwn.net/Articles/870415/

The Kernel Summit is organized as a track which is run in parallel
with the other tracks at the Linux Plumbers Conference (LPC), and is
open to all registered attendees of LPC.  The goal of the Kernel
Summit track will be to provide a forum to discuss specific technical
issues that would be easier to resolve in person than over e-mail.
The program committee will also consider "information sharing" topics
if they are clearly of interest to the wider development community
(i.e., advanced training in topics that would be useful to kernel
developers).

To suggest a topic for the Kernel Summit, please do two things. by
June 16th, 2024.  First, please tag your e-mail with [TECH TOPIC].  As
before, please use a separate e-mail for each topic, and send the
topic suggestions to the ksummit discussion list.

Secondly, please create a topic at the Linux Plumbers Conference
proposal submission site and target it to the Kernel Summit track:

	https://lpc.events/event/18/abstracts/

Please do both steps.  I'll try to notice if someone forgets one or
the other, but your chances of making sure your proposal gets the
necessary attention and consideration are maximized by submitting both
to the mailing list and the web site.


If you were not subscribed on to the kernel mailing list from
last year (or if you had removed yourself after the kernel summit),
you can subscribe by sending an e-mail to the address:

   ksummit+subscribe@lists.linux.dev

The program committee this year is composed of the following people:

Christian Brauner
Jon Corbet
Greg KH
Sasha Levin
Ted Ts'o
Rafael J. Wysocki


