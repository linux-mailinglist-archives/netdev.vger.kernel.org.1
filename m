Return-Path: <netdev+bounces-266153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCO9NvsosGn/ggIAu9opvQ
	(envelope-from <netdev+bounces-266153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:21:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3482251CBB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22EF430F41EB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CB40DFD7;
	Tue, 10 Mar 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="hK6iEXPD"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEB40DFD5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149026; cv=none; b=akJ5/idt+uPC+DPnXxgbqzpI7zbXlVgsD/gsMC9i3v5yFWPeUdm+D3BbOJ0Fc8Xq0x9pqmVbTQ3NDEWjO8RC5dQ4CUePRmBRH/6FRjL6g9yp4lItTWgXJ6QZ/XlFo7d2+/iaiYQev/Psc1BiTVI8qd8DsB4qOwOzhzwMYXStJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149026; c=relaxed/simple;
	bh=TQRu2OY10hRTmnSn4KjatNLOH5NBn2VV4gfJESuVpoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TGoElQa7V3jMJWTRcnfuLZKapyxV7xnIokCIqcOl3i0D0+3zqLdVZAkaYN96ms+bXG5a0W+EDG2g1ijrewtYrlB4LXrVFpScH0LEawZlHo5jL0bffs55AhaC8nQr8GId5CVEsopXuHnWxBXL6sJM19zoiqI8D0FhjTWpyJhBE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=hK6iEXPD; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=hK6iEXPD;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 62ADNWRI4004847
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1773149012; bh=5wwV5LHKC59uHCjElUSeTZvppHb1aWgjjvdkeJ891zg=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=hK6iEXPDV3LFVjlFomzBGJ51Pk7nvgywPx1UlfAGnBbcV1N2849W5MMIXcnUTI2GG
	 Dh2eMaG7P2BVXIThznf2KcpKAiosEN0mLNKds1gUGbqr2PfnwoB4CbIlApt6miRg5A
	 wvI9Nc5uHo3FD2lbQ9vjeFMKyK7GCqsM9ijTY9eg=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 62ADNWjc237217
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:23:32 +0100
Received: (nullmailer pid 710527 invoked by uid 1000);
	Tue, 10 Mar 2026 13:23:32 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [RFCv5 05/13] net: usb: use accessor helper for usbnet private
 data
In-Reply-To: <5d014762-2a59-4aad-897f-9f543cd3113a@suse.com> (Oliver Neukum's
	message of "Tue, 10 Mar 2026 14:00:14 +0100")
Organization: m
References: <20260309165614.861929-1-oneukum@suse.com>
	<20260309165614.861929-5-oneukum@suse.com>
	<87y0k0q4jk.fsf@miraculix.mork.no>
	<5d014762-2a59-4aad-897f-9f543cd3113a@suse.com>
Date: Tue, 10 Mar 2026 14:23:32 +0100
Message-ID: <87pl5bq0mj.fsf@miraculix.mork.no>
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
X-Rspamd-Queue-Id: E3482251CBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266153-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[mork.no:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,miraculix.mork.no:mid,mork.no:dkim]
X-Rspamd-Action: no action

Oliver Neukum <oneukum@suse.com> writes:
> On 09.03.26 18:46, Bj=C3=B8rn Mork wrote:
>> Oliver Neukum <oneukum@suse.com> writes:
>>=20
>>> diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
>>> index dbf01210b0e7..5522dc137d45 100644
>>> --- a/drivers/net/usb/cdc_mbim.c
>>> +++ b/drivers/net/usb/cdc_mbim.c
>>> @@ -43,7 +43,7 @@ enum cdc_mbim_flags {
>>>   /* using a counter to merge subdriver requests with our own into a co=
mbined state */
>>>   static int cdc_mbim_manage_power(struct usbnet *dev, int on)
>>>   {
>>> -	struct cdc_mbim_state *info =3D (void *)&dev->data;
>>> +	struct cdc_mbim_state *info =3D usbnet_priv(dev);
>>>   	int rv =3D 0;
>>>     	dev_dbg(&dev->intf->dev, "%s() pmcount=3D%d, on=3D%d\n", __func__,
>>> atomic_read(&info->pmcount), on);
>> I'm not sure I'm following all the conversions, but you are aware
>> that
>> cdc_mbim and cdc_ncm share a few functions struct cdc_ncm_ctx state, the
>> and therefore have to cooperate wrt the private data layout?
>
> Hi,
>
> I was not aware of that. What do you think about the approach taken
> in the attachment? It just makes sure that the first part of the
> descriptors match.

Looks reasonable to me.  I haven't actually tested it, though.


Bj=C3=B8rn

