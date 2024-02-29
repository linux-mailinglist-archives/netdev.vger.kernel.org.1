Return-Path: <netdev+bounces-76089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450E86C49E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA33B22B95
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157758128;
	Thu, 29 Feb 2024 09:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0ED58104
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197956; cv=none; b=ZNODkh49d3TIzKehJS6ZZBfARgh+KKHxguOh2penf/SHdMXEjwMKGewdYaeUBusW6eglh12rM17O9wKydxEB9ur049/wDW9CSOMO8SOZoSK0Y/0TqvT3GiZYNS5+UU25daJy9sugStaQPOxgu3j2U+IS9AX4zyYlpuX+MGQCMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197956; c=relaxed/simple;
	bh=4phtFMy2RobOfghJY8v5H/yEDVEGzZoYl1BLRLK61To=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RCSwmcTZmmuVoUkUk6PfoqH6zQpsJ9/5pFWQlbwB4UyiJrl/ITR7DVwlFVRJYnvDfiQo/iJn8SlaG4yBDKNuaOWwKnO92bz1qxf7w8UJY7bIObz61v/OSa+56GYkGxsuhAje76CDLlhUnbGWbBvzfQdRnWInzz/iHIZhJkYO2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 783047D0A2;
	Thu, 29 Feb 2024 09:12:28 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <20240226205746.GK13129@kernel.org>
Date: Thu, 29 Feb 2024 04:12:17 -0500
Cc: Christian Hopps <chopps@chopps.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <070C751F-0BFE-4F18-B320-63786B56C56B@chopps.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org>
 <20240219201349.GO40273@kernel.org> <m24je013cj.fsf@ja.int.chopps.org>
 <20240226205746.GK13129@kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On Feb 26, 2024, at 15:57, Simon Horman <horms@kernel.org> wrote:
>=20
> On Thu, Feb 22, 2024 at 03:23:36PM -0500, Christian Hopps wrote:
>>=20
>> Simon Horman <horms@kernel.org> writes:
>>=20
>>> On Mon, Feb 19, 2024 at 03:57:35AM -0500, Christian Hopps wrote:
>>>> From: Christian Hopps <chopps@labn.net>
...
>>>> +/**
>>>> + * skb_head_to_frag() - initialize a skb_frag_t based on skb head =
data
>>>> + * @skb: skb with the head data
>>>> + * @frag: frag to initialize
>>>> + */
>>>> +static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t =
*frag)
>>>> +{
>>>> + struct page *page =3D virt_to_head_page(skb->data);
>>>> + unsigned char *addr =3D (unsigned char *)page_address(page);
>>>> +
>>>> + BUG_ON(!skb->head_frag);
>>>=20
>>> Is it strictly necessary to crash the Kernel here?
>>> Likewise, many other places in this patch.
>>=20
>> In all use cases it represents a programming error (bug) if the =
condition is met.
>>=20
>> What is the correct use of BUG_ON?
>=20
> Hi Christian,
>=20
> I would say that BUG_ON should used in situations where
> there is an unrecoverable error to the extent where
> the entire system cannot continue to function.

Well in these cases it means that IPsec/IPTFS is in an unrecoverable =
state and broken. It's hard to predict how much that means "entire" to =
the user that expects their IPsec tunnels to be working, it may be the =
entire purpose of the box it's running on, so normally I don't think =
it's wise to try.

If you still object I will remove them.

Thanks,
Chris.

>=20
> ...



