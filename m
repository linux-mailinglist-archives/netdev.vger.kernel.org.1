Return-Path: <netdev+bounces-222401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6CB541A5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C907486C17
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3E3D544;
	Fri, 12 Sep 2025 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nqnQ8CNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFD79CD
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650756; cv=none; b=V7PiAqSOYrmsUffaO5Er/aFTyn8Q4K5QuLIoK1InJ2CEvmuqnBpUANwz2UQ49ODxtmg4by6SKVwoK1M8qbwSsges/4Vmn9EQoQEYDt3AwdBMwdbnhVEm+DYdEtkBdvokqnF0nZFNIfT0nU8Q7h7sznhM3+tpsuqb+v0VWX/GMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650756; c=relaxed/simple;
	bh=uTXq0zEBSfWlXWzpiE7hQec/LobO7dtqvyKG9+YZ3OA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=R2DvEEXpN6YdY6/PIaLF5VaVkmxbLaPK/UkZivupQUYf+Z1/LiEWB4PNdZu7zLaZ8YwyCjibP7hWpU5bRzFq4gLaSygrZtAqUD/bS4eN0UXKQ0OEyMWkb61jqI+SMDTs0GnhgTlLSozUAHViv00IjWR2IZ9cYYGd9uLaGkYJQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nqnQ8CNz; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6560141BF9;
	Fri, 12 Sep 2025 04:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757650746;
	bh=PntQfB2oMsB34fjP/B+XhCke36SETLLjq5qJ9h92Kg8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=nqnQ8CNz5ZZ9AjdksuVtnlYzSqjEpekWxf2s0IuTRTuklCPangurnixM3gaNdnRnf
	 eBqe5Cc16yxmGAANWOOrHX9j0nD1ClxIXWp4YXQk0/9wU5cOvsKltMBdSd1FKJdTn9
	 e3kzFfZpmW/+p/uj012p8ZV6MsE5JJSirVlKeGYSK+cMIqj1KjvPtEyn7DeIz+FuXH
	 UtDAGLGz01z/0Z3rvbfQJsqj22Ham2O9atf2AD/ufbJEvj34uPn6I2S7Ya9l/g0Tjm
	 EO9f+UhkEtvKtsunbAxo8XJFRIKsumyA9UVQh4K3vfkbcFZgYcVhWs+BctrNDXE08/
	 3ox5SOPE0z7uw==
Received: by famine.localdomain (Postfix, from userid 1000)
	id B60809FC97; Thu, 11 Sep 2025 21:19:04 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B2EA39FBF6;
	Thu, 11 Sep 2025 21:19:04 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: David Ahern <dsahern@gmail.com>
cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
    Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
In-reply-to: <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com>
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
 <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com>
Comments: In-reply-to David Ahern <dsahern@gmail.com>
   message dated "Thu, 11 Sep 2025 14:50:53 -0600."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3090257.1757650744.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Sep 2025 21:19:04 -0700
Message-ID: <3090258.1757650744@famine>

David Ahern <dsahern@gmail.com> wrote:

>On 9/9/25 9:32 PM, Jamal Hadi Salim wrote:
>> =

>> Please run tdc tests. David/Stephen - can we please make this a
>> requirement for iproute2 tc related changes?
>
>I will try to remember to run tdc tests for tc patches. Without an
>automated setup, there will be misses over time.
>
>> =

>> Jay, your patches fail at least one test because you changed the unit o=
utputs.
>> Either we fix the tdc test or you make your changes backward compatible=
.
>> In the future also cc kernel tc maintainers (I only saw this because
>> someone pointed it to me).
>> Overall the changes look fine.
>
>Sent a patch to add a tc entry to iproute2 maintainers file.
>
>You say the change looks fine but at least one test fails meaning
>changes are requested?

	Yes, I ran the tests and saw one failure, in the following:

        "cmdUnderTest": "$TC actions add action police pkts_rate 1000 pkts=
_burst
 200 index 1",
        "expExitCode": "0",
        "verifyCmd": "$TC actions ls action police",
        "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burst =
0b mtu 4096Mb pkts_rate 1000 pkts_burst 200",

	Which is trying to match a returned mtu value of "4096Mb" but
the new code prints "4Gb"; should be straightforward to change the test
to accept either returned value.

	Or I can take out the bit that prints sufficiently large values
in units of Gb, if you've got a preference for leaving that part alone.
Doing so would ease the lockstep problem between the tests in the kernel
tree and the change in iproute2.  The numeric formatting isn't the
important part of the patch set, so I'm ok either way.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

