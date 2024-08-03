Return-Path: <netdev+bounces-115480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC2946779
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B3B21282
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29C3EA98;
	Sat,  3 Aug 2024 04:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D1F4C6D
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722660981; cv=none; b=Zwiu6S91zXqynXmEGeIXSMyLC9qg6nsHOy8NJBcyGeanved5B0UmK3kLNiZoEh/C/dPTApu3ndythor+WJmu+NyDMkKhAJ8DigtlBaNBAoLQ6Tn0/MFrIUqFfXHZkA1Nph6/YoxEm1EdzOygcsHIFWPlZTkLmax/8yaFiTGF5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722660981; c=relaxed/simple;
	bh=rn2KMVYWjNwKMOg5sFt73oIo8kJzUnbOQywj27Dth4w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IQF3tl1TLLle8eASaIs9Dri6F65grx0jUF2Sz6I6x2j7NVaCZRTx+vOl4X1271wIwhTolz8mQv30SCUs3MdNX5g/mlrQsW/2GXnXWWSz+UUEbpOLPe8s9XdDMZ7x1G2gymZxr6CUcZjVaeej52e2nNL5ytz+uDho6174UGoQex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 8B0077D018;
	Sat,  3 Aug 2024 04:56:12 +0000 (UTC)
References: <20240801080314.169715-1-chopps@chopps.org>
 <20240801080314.169715-9-chopps@chopps.org>
 <20240801121808.GB10274@breakpoint.cc>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Florian Westphal <fw@strlen.de>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet
 (tunnel ingress) handling
Date: Sat, 03 Aug 2024 00:55:46 -0400
In-reply-to: <20240801121808.GB10274@breakpoint.cc>
Message-ID: <m2h6c26w7o.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Florian Westphal <fw@strlen.de> writes:

> Christian Hopps <chopps@chopps.org> wrote:
>> +static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct sk_buff *skb, *skb2, **nextp;
>> +	struct skb_shared_info *shi;
>> +
> [..]
>> +			if (skb->dev)
>> +				XFRM_INC_STATS(dev_net(skb->dev),
>> +					       LINUX_MIB_XFRMOUTERROR);
>
> Nit:
> Here and in several places you are using dev_net() helper.
>
> I think that if xfrm_state is available, then xs_net(x) makes more sense.
>
> It also avoids the skb->dev conditional.

Ok, replaced where xfrm_state was available.

