Return-Path: <netdev+bounces-86291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0789E530
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5051C20CDC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7812BE9C;
	Tue,  9 Apr 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0bHQIDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A0158A37
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699389; cv=none; b=BGHFzJZ9nR2aorjLpjdgsIwDJyvs2rFxb4lBrKfLq0+Vcv3tw8hoS4USIdN1caKj8R0qNLyo3OMBpzd3DG2frmI3HZB1zd/ysniIrBOzs6uWv9jlriV4pavnbOoIaKC4X25X2SafUoxJ/sjCWh9XpUAdOa8v8+dZ0vvzH1gny10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699389; c=relaxed/simple;
	bh=DCkbWKmg6esBY6bjotpQw/cJxEhL3ElYb214DU57Bxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OE/KxP11+Jsb5GDNQliR0Hq9yD/nIta/6Xw2FjTLIIUrCVCWeZkBYp250XIqNfus1Ue8xKT8ScAtnDW1yqUH2c829k7tdbyitK6ptcR3vQ/W/J8QXArq4uIwNaPZkCUFTGdsrNR1OnoSSRtC9wi0AsEN0pqXXE6cLx9hrZmxCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0bHQIDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E7DC433F1;
	Tue,  9 Apr 2024 21:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712699388;
	bh=DCkbWKmg6esBY6bjotpQw/cJxEhL3ElYb214DU57Bxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U0bHQIDWpR4cRu2ZzR8azj2IdMKqJu+ZdPn0tES0sVTLsWQ099BzQKxltzWj5nRs/
	 ueh2B4zj0ZsXR/DqIXCDvQ7VdxUIb5aoV7KVmBgrqJzNQijPM1dL4ep4iRqycvmYLi
	 l10mT+2h4cYnW//P7FDYcFlJbFwwWMwjWxwHkdGbYXVXRYzwUfCdF2146c2EsQQV6u
	 rK0njAIlluHsw6KKjU7WBvPd/93KryeVOGwMa0uP28PLXZcTIvMKcDd3WQyEAFbRuW
	 YZAfngUe31Dl5leYhQxFnFX284Do7DfOsEyUdeLSv+qFWW+32ldlv5zlpkvivP3Lbh
	 KkhMZeJtIWTkw==
Date: Tue, 9 Apr 2024 14:49:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org
Subject: Re: [RFC net-next v2 5/5] net:openvswitch: add psample support
Message-ID: <20240409144947.1379e33b@kernel.org>
In-Reply-To: <f2bbefed-f17c-4127-a87b-13a5933e98cd@ovn.org>
References: <20240408125753.470419-1-amorenoz@redhat.com>
	<20240408125753.470419-6-amorenoz@redhat.com>
	<eb44af1d-7514-4084-b022-56f1845b109e@ovn.org>
	<ad55dd2d-c07e-4396-a32c-92d7aefe2ef0@redhat.com>
	<4a86e5bb-f176-42fc-a2b1-f21dea943626@ovn.org>
	<01898b85-d950-4e56-99b3-5a366dddb383@redhat.com>
	<f2bbefed-f17c-4127-a87b-13a5933e98cd@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 11:35:04 +0200 Ilya Maximets wrote:
> > If we try to implement all our actions following this way, and we keep just 
> > copying the incoming actions into the internal representation, we incur in 
> > unnecessary memory overhead (e.g: storing 2x struct nlaattr + padding of extra 
> > memory to store 2 integers).
> > 
> > I don't want to derail the discussion into historical or futuristic changes, 
> > just saying that the approach taken in the SAMPLE action (not including this 
> > patch) of exposing arguments as attributes but having a kernel-only struct to 
> > store them seems to me a good compromise.  
> 
> Sure.  As I said, it's fine to have internal structures.  My comment
> was mainly about uAPI part.  We should avoid structures in uAPI if
> possible, as they are very hard to maintain and keep compatible with
> older userspace in case some changes will be needed in the future.

FWIW there are some YAML specs for ovs under
Documentation/netlink/specs/ovs_*
perhaps they should also be updated?

