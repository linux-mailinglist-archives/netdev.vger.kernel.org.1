Return-Path: <netdev+bounces-114627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA894342A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7266B20D2E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C81773A;
	Wed, 31 Jul 2024 16:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D915E96
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443556; cv=none; b=WmdnZz1oKYa0QDz2gd0i1bN4rfFjWnQbERW4wuzRYXSmWLRXgQXh9Inry0zep+26+pRXPAYqIQW4HoqdkQRmdZFUIMsyJAVYymjiLWqp6qDVA3MO+gefvmLTGkPQ0nwE/AoO0b7yjS7KdP7MO31JowrOarBF4jAO2DtXb3z1OMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443556; c=relaxed/simple;
	bh=xSiBStIp0JfvLhkJ9qgt35kxkKwun1dpgjtrgYfuNHI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=MiC3eZzw/bwzOPXmU3sA0kEqzQ0c1rcnTBKsixMoDAUD0pda5lt8873nl2NIq4cpzK5ltRq1g7ZzTX/e8SG2MCgqHZpd4u8DL1AjO0becZSU96aNr1Jj3E6GGrC6KSNEkZ99nr1iXEU5aUwibUs91LE1SBfJ6ylCHA4857NbTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id AF0DD7D052;
	Wed, 31 Jul 2024 16:32:33 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org> <ZqJUMLVOTR812ACs@hog>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new iptfs xfrm
 mode impl
Date: Wed, 31 Jul 2024 12:29:06 -0400
In-reply-to: <ZqJUMLVOTR812ACs@hog>
Message-ID: <m2ttg58qu6.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-07-14, 16:22:36 -0400, Christian Hopps wrote:
>> +struct xfrm_iptfs_config {
>> +	u32 pkt_size;	    /* outer_packet_size or 0 */
>
> Please convert this to kdoc.

Done.

>> +};
>> +
>> +struct xfrm_iptfs_data {
>> +	struct xfrm_iptfs_config cfg;
>> +
>> +	/* Ingress User Input */
>> +	struct xfrm_state *x;	    /* owning state */
>
> And this too.

Done.

>> +	u32 payload_mtu;	    /* max payload size */
>> +};
>
>
>> +static int iptfs_create_state(struct xfrm_state *x)
>> +{
>> +	struct xfrm_iptfs_data *xtfs;
>> +	int err;
>> +
>> +	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
>> +	if (!xtfs)
>> +		return -ENOMEM;
>> +
>> +	err = __iptfs_init_state(x, xtfs);
>> +	if (err)
>> +		return err;
>
> BTW, I wrote that this was leaking xtfs in my previous review, back in
> March :/

I went back through your earlier review again. The next patch set adds the queue flush/cleanup on state delete, and uses a new MIB direction independent MIB counter for failed skb alloc -- which you identified as well.

Thanks,
Chris.

