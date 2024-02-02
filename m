Return-Path: <netdev+bounces-68431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A897B846E83
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D73E1F298C9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40D13B7B4;
	Fri,  2 Feb 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b="TEkxB/vg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.foo.to (mail.foo.to [144.76.29.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBC7D3FD
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.29.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871589; cv=none; b=rpaupTUgx7tmfIUkGx77ls5x047hENL4n145DQAn+IiDpeKZsmi9hbLIex3bETgnVl4GFtc/Wx9NKPFhP5IEyUsLVzx0zkwMO51PUu30nGsRb3oWLhwmFUhgp4Fx3r4wktcFTVVQlyclsJUPeNKPqr8gNeObAfAeEcUskR0uFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871589; c=relaxed/simple;
	bh=OseHR9XUpA6GOcT+tGhh0Tf/xTqXdutgTpovZ7TLcU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTuBofjuat7fMpczcGyViD9MNmOiCD5MKaxIellEN+wbYFE3Tv4jsVpgJcxBKzPP3hfBaxfS2h7/2atTLTbUqvfg/Ps/dLF0aJzF1AsGLhH6TQ19+lXme1JmpUtPskf2nkkDA9DtxDso/YiVJAuAyVUEMnBB98qNt0no5FgwaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net; spf=pass smtp.mailfrom=pwaller.net; dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b=TEkxB/vg; arc=none smtp.client-ip=144.76.29.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwaller.net
Message-ID: <e8983972-c4aa-43f7-93bd-afa2ab167b37@pwaller.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pwaller.net; s=mail;
	t=1706871580; bh=OseHR9XUpA6GOcT+tGhh0Tf/xTqXdutgTpovZ7TLcU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TEkxB/vgBgtECIZxvwDH2XuE+u7kBKl2GNyi7PS7AmsycgTaw5sh1LGvYPdaVUtxX
	 OWH5oBUe278oLzrEqLYpMGwDnbkHYORoR8qIHYOLjISokuDHXizJ5LD+nMq1h6q1oD
	 PO72a/cDmypqt+zj9GSUkeQX9BV0vZkYsl62Bgrk=
Date: Fri, 2 Feb 2024 10:59:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Igor Russkikh <irusskikh@marvell.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Netdev <netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
 <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
 <20231128130951.577af80b@kernel.org>
 <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
 <e98f7617-b0fe-4d2a-be68-f41fb371ba36@pwaller.net>
 <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
 <e8739692-89ea-40e7-b966-bbb4ea5826af@pwaller.net>
 <b0cf8d1b-1bd6-b7ab-006b-896285c65167@marvell.com>
Content-Language: en-US
From: Peter Waller <p@pwaller.net>
In-Reply-To: <b0cf8d1b-1bd6-b7ab-006b-896285c65167@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 10:35, Igor Russkikh wrote:
> Unfortunately this seems to be a different issue, HW related. I suspect you have ASUS labeled NIC or MB?

Thanks for the link. Yes, it's an ASUS motherboard with onboard NIC. 
There are bios updates available which may also come with firmware updates.

Do you happen to know if there a way to identify/fingerprint/version the 
firmware on the NIC via the dmesg/lshw output/bios screens so that I may 
tell if updating the bios is also supplying new firmware?


