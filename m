Return-Path: <netdev+bounces-278131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F4EIwob3WknaAkAu9opvQ
	(envelope-from <netdev+bounces-278131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:34:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F83EF467
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD2E03019760
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921462D5A19;
	Mon, 13 Apr 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="lu+JKZAU"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7512E54D1;
	Mon, 13 Apr 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098049; cv=none; b=fNSDsq76G+K6fm+HDx4S2w8Au6iYWuAbP6o5wbh/xX1r3qhFKRJDWjFuOK99YGXyAHsO0/nC1d/5Cji/RxGh/jP87NFt9OSiU7KKoasSP6ZWgs5pBHU1Fobjg58ql9fXPrNAIUzu+SAib5AfhX/DqEgz877CM2m4iynba7iMxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098049; c=relaxed/simple;
	bh=sRM/3iErQ+bEJ78zx4fih2iZW2uMmqnG+BlbG9Fnt9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjsKYAn/UbA2SSLA1qEFovqyxsDIFkwc1haCG5fDGKlC9YeX03cKVnvf0pT3py8tTKuNbIGiij+enR4v1GqI1gmaYbBfrZKFBGodYpVIlztCFOvV0mVp/COY8ECXV5tdws3xS9Ky0YTVFekB8aTNa0NS3pjxLB6kaafvrhbt+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=lu+JKZAU; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=lu+JKZAU;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 63DGKfFD2435927
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 17:20:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1776097241; bh=WxbNjJGvhy1SDAsoGKI4PvpYv/gawhK9m0KcvT+GkeE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=lu+JKZAU2pcUzwz64KYTiCBhSxs4LfsXT790gdtk1ZavGSVX7cCdQsGLVMzLkF9c9
	 x1ZA72lJVIeqip0029qWx15GE5t1szqCrIKhZZCO9udXaJbKtHX1vMB5Ylqx9Buhy1
	 nL+Slmi8Ku9Lu22DCpAy20lzdVUDqjbDLkuVfueg=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 63DGKfkj641744
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 18:20:41 +0200
Received: (nullmailer pid 2181676 invoked by uid 1000);
	Mon, 13 Apr 2026 16:20:40 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP offsets
In-Reply-To: <2026041355-designate-spiritual-e785@gregkh> (Greg
	Kroah-Hartman's message of "Mon, 13 Apr 2026 14:24:43 +0200")
Organization: m
References: <2026041137-comfy-eaten-a1ed@gregkh>
	<2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
	<2026041325-giggly-wrecking-e6ef@gregkh>
	<198c1240-80a6-456c-8b12-25158c90c965@suse.com>
	<2026041355-designate-spiritual-e785@gregkh>
Date: Mon, 13 Apr 2026 18:20:40 +0200
Message-ID: <87wlyavnl3.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278131-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mork.no:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,miraculix.mork.no:mid]
X-Rspamd-Queue-Id: 2E7F83EF467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Mon, Apr 13, 2026 at 02:11:50PM +0200, Oliver Neukum wrote:
>> On 13.04.26 12:43, Greg Kroah-Hartman wrote:
>> > On Mon, Apr 13, 2026 at 10:36:19AM +0200, Oliver Neukum wrote:
>> > >=20
>> > >=20
>> > > On 11.04.26 12:53, Greg Kroah-Hartman wrote:
>> > > > cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain t=
o the
>> > > > next one.  The 32-bit value from the device is stored into the sig=
ned
>> > > > int ndpoffset so that means values with the high bit set become
>> > >=20
>> > > Well, then isn't the problem rather that you should not store an
>> > > unsigned value in a signed variable?
>> >=20
>> > No.  well, yes.  but no.
>> >=20
>> > cdc_ncm_rx_verify_nth16() returns an int, and is negative if something
>> > went wrong, so we need it that way, and then we need to check it, like
>> > we properly do at the top of the loop, it's just that at the bottom of
>> > the loop we also need to do the same exact thing.
>>=20
>> Doesn't that suggest that cdc_ncm_rx_verify_nth16() is the problem?
>> To be precise, the way it indicates errors?
>> As this is an offset into a buffer and the header must be at the start
>> of the buffer, isn't 0 the natural indication of an error?
>
> Maybe?  I really don't know, sorry, parsing the cdc_ncm buffer is not
> something I looked too deeply into :)

Oliver is correct AFAICS. These functions could use 0 to indicate
errors.  This would make the code simpler and cleaner.

The negative error return is just a sloppy choice I made at a time we
only supported the 16bit versions.  Didn't anticipate 32bit support
since it is optional and pointless.  But as usual, hardware vendors do
surprising things.

Note that cdc_mbim.c must be updated if cdc_ncm_rx_verify_nth16() is
changed.


Bj=C3=B8rn


