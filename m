Return-Path: <netdev+bounces-265681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNreM3oMr2lzMQIAu9opvQ
	(envelope-from <netdev+bounces-265681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:07:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDD23E3ED
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8100930A5397
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D4284B25;
	Mon,  9 Mar 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="gduvc8dn"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B33ACA5B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079215; cv=none; b=JT+C4VlkmqLnsbaxnudyBqjq1rj7mXdKdeiWEAGczBG1sozXS01BLjVOq9+Q+Kch0/rDn9hzC4qM6nvR+B0T1cIdI+Kg5eOd7f1Zg/nPiafypcz3XtH4TqFMGx1OPsTUng5aRWZLkMi8ashn+LaTodJrLOGpYwBXJ6UqH3vWAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079215; c=relaxed/simple;
	bh=F3drlmrtmgypJmAyZsCGu+W7xIZaAJlnNGXhGVtzb24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tM5AiaV+E3c4Lj4x0W9zuuFhbhTglw0pXaO1Q8qdj8N5ZyTJH9ls85AVswjZFF3p6iDlmrTEFFa6MZstgGZYoC4G11pWqLGA9gCmKkle5y3l6JN3+06bApCXZ1TERFy5l6KgWo7N6DuNh42rdOFGDlLBmQDpqzt1tthnhyPcric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=gduvc8dn; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=gduvc8dn;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 629HkdRw3567357
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 17:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1773078399; bh=N6j9M5xHDNeHmrOAnX/HemDgg7iRf++X9IZrr0coNIE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=gduvc8dnAZv9fn+ydQPZR9KKWI0BXKp+u0sOq6JpjEhJ8CL8xRSMTJEp3FeOYyxd+
	 NG9Q67G/0G13F5bBsR4TAG1tYKiedrjEiBirf2BQJeCKHnIMEKqgrBX/8rqst9GmlT
	 JpLxG/dlmhB9NSZ0HdrbYYw9/Gl1TYvs9TG4I+S4=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 629HkdAJ117497
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 18:46:39 +0100
Received: (nullmailer pid 649465 invoked by uid 1000);
	Mon, 09 Mar 2026 17:46:39 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [RFCv5 05/13] net: usb: use accessor helper for usbnet private
 data
In-Reply-To: <20260309165614.861929-5-oneukum@suse.com> (Oliver Neukum's
	message of "Mon, 9 Mar 2026 17:53:28 +0100")
Organization: m
References: <20260309165614.861929-1-oneukum@suse.com>
	<20260309165614.861929-5-oneukum@suse.com>
Date: Mon, 09 Mar 2026 18:46:39 +0100
Message-ID: <87y0k0q4jk.fsf@miraculix.mork.no>
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
X-Rspamd-Queue-Id: 61DDD23E3ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[mork.no:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,miraculix.mork.no:mid]
X-Rspamd-Action: no action

Oliver Neukum <oneukum@suse.com> writes:

> diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
> index dbf01210b0e7..5522dc137d45 100644
> --- a/drivers/net/usb/cdc_mbim.c
> +++ b/drivers/net/usb/cdc_mbim.c
> @@ -43,7 +43,7 @@ enum cdc_mbim_flags {
>  /* using a counter to merge subdriver requests with our own into a combi=
ned state */
>  static int cdc_mbim_manage_power(struct usbnet *dev, int on)
>  {
> -	struct cdc_mbim_state *info =3D (void *)&dev->data;
> +	struct cdc_mbim_state *info =3D usbnet_priv(dev);
>  	int rv =3D 0;
>=20=20
>  	dev_dbg(&dev->intf->dev, "%s() pmcount=3D%d, on=3D%d\n", __func__, atom=
ic_read(&info->pmcount), on);


I'm not sure I'm following all the conversions, but you are aware that
cdc_mbim and cdc_ncm share a few functions struct cdc_ncm_ctx state, the
and therefore have to cooperate wrt the private data layout?

The 'struct cdc_mbim_state' has a ctx field which is supposed to be
managed by the cdc_ncm part of the driver:

struct cdc_mbim_state {
	struct cdc_ncm_ctx *ctx;
	atomic_t pmcount;
	struct usb_driver *subdriver;
	unsigned long _unused;
	unsigned long flags;
};

The cdc_mbim driver currently depends on cdc_ncm_bind_common(), which is
called from cdc_mbim_bind(), to allocate the 'struct cdc_ncm_ctx' data.
It will later call other functions, like cdc_ncm_fill_tx_frame(), which
depend on that 'struct cdc_ncm_ctx *ctx' field.

I don't understand how you make the patch above work in cooperation with
this:


@@ -1203,7 +1187,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct=
 cdc_ncm_ctx *ctx, struct s
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
-	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
+	struct cdc_ncm_ctx *ctx =3D usbnet_priv(dev);
 	union {
 		struct usb_cdc_ncm_nth16 *nth16;
 		struct usb_cdc_ncm_nth32 *nth32;


Looks like the cdc_mbim driver will use the same usbnet_priv(dev) as
both 'struct cdc_ncm_ctx' and 'struct cdc_mbim_state'.

Yes, I know this too magic, and should be rewritten on so many levels.
But it is what it is.



Bj=C3=B8rn

