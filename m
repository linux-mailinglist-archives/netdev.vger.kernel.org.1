Return-Path: <netdev+bounces-116018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B64948CBA
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE544B24353
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012F1BE846;
	Tue,  6 Aug 2024 10:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310CE1BDA9B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939628; cv=none; b=f5zMRVWRk+zS3xaeHxYf+6uqr5ccvtQXvLQeariAP6fg/N15E61ucBKvwAUZ/OLjpfxaHWOuY+76PJWaNWinOF5ZJA/E0lRT2fpqu4m+LztzndgXBgrM1uYpUMi+xSWveRGIAvgjF8ozO8mVVc/hkcCPW3WS06WVI6WFp9qWq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939628; c=relaxed/simple;
	bh=uuKWgBbEVMKUnzeNuW4mG6qevQdO0fmSurt+rJycJlY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=cLqU1+/LK0lPZw31NtRhzaOj7mNFkBjPsPgpWGzMwY4wdO+dI6rXKYdOObduMkK2upIPkThqATVKs6b4iEQoPVArMpUCdWqHv28lx1nevIK5D2ogdfHyqA1iFeaZapnzDG27byYxZ6FMKir+aLg9y3Jl7TucKjAGILsiplKUzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 1F6527D08A;
	Tue,  6 Aug 2024 10:20:26 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-9-chopps@chopps.org>
 <20240805171040.GN2636630@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8 08/16] xfrm: iptfs: add user
 packet (tunnel ingress) handling
Date: Tue, 06 Aug 2024 06:19:28 -0400
In-reply-to: <20240805171040.GN2636630@kernel.org>
Message-ID: <m27ccuosuu.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Simon Horman via Devel <devel@linux-ipsec.org> writes:

> On Sun, Aug 04, 2024 at 04:33:37PM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add tunnel packet output functionality. This is code handles
>> the ingress to the tunnel.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>
> ...
>
>> +static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
>> +{
>> +	if (x->outer_mode.family == AF_INET)
>> +		return iptfs_encap_add_ipv4(x, skb);
>> +	if (x->outer_mode.family == AF_INET6) {
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +		return iptfs_encap_add_ipv6(x, skb);
>
> iptfs_encap_add_ipv6 is flagged as unused when IPV6 is not enabled.
> Perhaps it should also be wrapped in a CONFIG_IPV6 check.

Done, and tested with CONFIG_IPV6=n.

Thanks,
Chris.

