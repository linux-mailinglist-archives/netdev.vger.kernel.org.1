Return-Path: <netdev+bounces-306213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CA+zFYiYT2o6kgIAu9opvQ
	(envelope-from <netdev+bounces-306213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EC731325
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:48:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="U/DlZ5eu";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306213-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306213-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD37F30FC04F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2642B303;
	Thu,  9 Jul 2026 12:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0F42314E;
	Thu,  9 Jul 2026 12:37:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600662; cv=none; b=UUQDIqqjOdP/nzvnWWBpo6AXNb2b1rPS5jv84M0Pq3Tq1vm39F5WH9CAQ2CUbOjcTwTyoX2/YMFZxiNlMPfgVT6Y6FYQDCtF1wPfI7QsyoKRS9lBTO0GAbzCu8bc1aHneGTgzx8E2owVyISVP9Kj7+8fnj1EASPTVJY8Rs55sck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600662; c=relaxed/simple;
	bh=9mUEh7JJ5Hj7d4HF8ZuDZfLWSNamwgKa9yDJtW4exD4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVHCwOeF3SwvReUjJZhk9u4kPiF7NKUrDYu9nWYRGPQLKRhNPm4ippKFWBirDki20KSSFxm968hBsgQ5j+wSxBSODTHLH2oDTcPaBtQ3ZmksVx0Q7AqzxJoPzdQvZDXAK+GOiIKXxF5S9Q7T9P6jPicFzZ4py6vyH95ccQx0mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U/DlZ5eu; arc=none smtp.client-ip=80.241.56.172
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwvcd4bk6zMlHs;
	Thu, 09 Jul 2026 14:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783600657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9w3MuQ9hO1ow5wjopkcgpcnT5W91hwq/FqCJiEnl/U8=;
	b=U/DlZ5euG11Bh810Iznq69BjcVMDkoFkm+C96W3oeQBilkHk8oNAFTBo6S0w3hXt1L1W1J
	Qha2BmaIkGP+3knXFrk0+Qd7XUY+SdYpHHIOW5vEZXL66FeVNQPybYn8X5wmKy2gTIv7F4
	nFe/mIiRWExsZLzW1hdtHp8t4IKbpFZpD9DfVsCYLb92IdyOwjIgxOsxm2LJU09sB5nsmC
	53FPIW1gvDPniB+ElxG2hxKDRaRSHvsSLKcAz5nVEtFRfADKrSRxdyYkFdyAIjNQ59ZSCa
	ngRXngGHcExvfhPcM/XusDRpW2kUKAfPm6fjd8eScRxwOyVXsQPW81HxAwewtA==
Message-ID: <0a0721d511c10414cb6a6e53f1bb33698ada963e.camel@mailbox.org>
Subject: Re: [PATCHv2 net-next 1/7] net: usb: centralize
 usbnet_cdc_zte_rx_fixup in usbnet
From: Manuel Ebner <manuelebner@mailbox.org>
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 09 Jul 2026 14:37:32 +0200
In-Reply-To: <20260709120116.1423033-1-oneukum@suse.com>
References: <20260709120116.1423033-1-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1bc4835a57a33a462e4
X-MBO-RS-META: 5zy76esrfprzhha86d1riy6nno75xab5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306213-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:dkim,mailbox.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A13EC731325

On Thu, 2026-07-09 at 14:01 +0200, Oliver Neukum wrote:

I guess a couple suggestions got lost, that's ok.

> This helper is used by multiple drivers using usbnet.
> It is better to be provided by usbnet than one of them.
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>=20
> v2:
> - spelling issues
> - issue with lost synchronization with SPLIT packets
>=20
> =C2=A0drivers/net/usb/cdc_ether.c | 19 -------------------
> =C2=A0drivers/net/usb/usbnet.c=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++++++
> =C2=A02 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
> index b4df32e18461..e688fb99c61d 100644
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -404,25 +404,6 @@ static int usbnet_cdc_zte_bind(struct usbnet *dev, s=
truct
> usb_interface *intf)
> =C2=A0	return status;
> =C2=A0}
> =C2=A0
> -/* Make sure packets have correct destination MAC address

Make sure packets have the correct destination MAC address

> - *
> - * A firmware bug observed on some devices (ZTE MF823/831/910) is that t=
he
> - * device sends packets with a static, bogus, random MAC address (event =
if

 (even if the device ...

> - * device MAC address has been updated). Always set MAC address to that =
of the
> - * device.

Always set the MAC address to the one of your device.

Thanks
 Manuel

> [...]

