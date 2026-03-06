Return-Path: <netdev+bounces-264716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPgAGUWfqmlLUgEAu9opvQ
	(envelope-from <netdev+bounces-264716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:32:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B363721DF89
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BDA302F3BB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF5344DA0;
	Fri,  6 Mar 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JWny/2s3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2933B6D3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789364; cv=none; b=DPzVuhjqXoBj5AqpAhsctdUyoIppeparQpd19ZqxJSMF3R7XrpGZMYImUxUsBaoFl0Fp/p3yc2OFScG4FejN8GsGMh5hlRY8X+nam4YHatXZy5tJmc1S7s+w0Lxznzt9ZkyFunx4QSIEzY4n9U43hPKmeaYgSkY5BOqE5MRTHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789364; c=relaxed/simple;
	bh=x/glzxQjwNeoOrM9Lc6NVxvoBVg/wbVsT5yeoqKIE+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBVxJwZTYyN/4TZKhtf9xDSRdIh3QsCXez+cSGWOo7D8hZHJs/SQo8VSK+jcJ0GeAm2bkBgZHHfQpEMx0GXDDVcp/3mnd0dileOo4NmCDUjxWw2Hnkd3cQDU9viG5rj0YJ9R4MCIxM2MMYylECVpbJv0c4UdvoD9ZRfFimXWHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JWny/2s3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64498C4042A;
	Fri,  6 Mar 2026 09:29:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 652525FF92;
	Fri,  6 Mar 2026 09:29:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 112721036983A;
	Fri,  6 Mar 2026 10:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772789360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6P/MKfyRlFDYi9P8igZuX78NL4+a3bjyyr8GTJd+rbA=;
	b=JWny/2s37pMxj0LMDGJbaIITZuhe0UKJS2CbAf0MzOBHuPIh/j3Xyu0XSnxMflhTOcdjKs
	6XCGtDVd60DQ2djK/lr0ChM4OyO6bzuXXSwCGLSDQPdlRQg7dN72yYgCfLSbEDFHS67ozF
	ZYk/ObmR+5tXcVUlhbLDcX0O4LxVcEKbtygt/JUQ1kZTOsPI48xht3Nlv1WC/bBjZb4nMW
	DOYQuRhyOMcofbY87H5UuyEwThHmInVcQFazZZggusHxkFrDMGPuEVdOMS4Rb6Ercm+zVB
	VbJZ84UwzKkWqyTvvw1MCYw8IHht8Hy8cBrEtJ040i791A6KJLZQw6jZlQQR3Q==
Message-ID: <fb688404-00b1-457b-965c-1d04a29fa0c6@bootlin.com>
Date: Fri, 6 Mar 2026 10:29:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/9] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-4-3f4c47954c71@bootlin.com>
 <20260305101922.lmkbooqfoeeg3axy@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260305101922.lmkbooqfoeeg3axy@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B363721DF89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Vladimir

On 3/5/26 11:19 AM, Vladimir Oltean wrote:
> On Wed, Mar 04, 2026 at 11:18:55AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> +void ksz8463_ptp_irq_free(struct dsa_switch *ds)
>> +{
>> +	struct ksz_device *dev = ds->priv;
>> +	struct ksz_port *port1 = &dev->ports[0];
>> +	struct ksz_port *port2 = &dev->ports[1];
>> +	struct ksz_irq *ptpirq = &port1->ptpirq;
>> +
>> +	ksz8463_ptp_port_irq_teardown(port1);
>> +	ksz8463_ptp_port_irq_teardown(port2);
>> +	free_irq(ptpirq->irq_num, ptpirq);
>> +	irq_domain_remove(ptpirq->domain);
>> +}
> 
> Teardown in the exact reverse order of ksz8463_ptp_irq_setup(), please
> (port1 vs port2). Place them next to each other so it's more obvious.

Ok, I'll do it in next iteration.


Best regards,
Bastien

