Return-Path: <netdev+bounces-191889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B200ABD9D6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7421656BA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489E2F2E;
	Tue, 20 May 2025 13:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035149461;
	Tue, 20 May 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748740; cv=none; b=ukay48Td+C+t3EM/oD5NC3HrJTN3sh6XjqR0JEboxnNHf9GtxzGQ6KMb+a7E07Utk+Y28IV6wqXEB58hFkjWIkFwQxCaKy7/o4gC7dFkUcnXTq1nuiZE1b5jOT2ZPVwoqNBdYVc95yeBBwubBKDUWUUFoKJHmGvuqsL5qdJ6+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748740; c=relaxed/simple;
	bh=uoJnGd+vuxG7jedwVm1/hNkNBVfgCbHjewVyLkXTIQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpDjtE/pZvPf43pWiS535VvmamgPtVGnXuRBT9Bf8RNWEvEUrlKgrXfc6fhAk8cmG7sunmufgMU+Z9OIaK21SPUsCnMGp+4g9GZkT/V+Qy1RR+V1SDkm088kbkuP8q608JYfHrXALRBfCjaTi99sSG7HN2ChJHNh5WI+bDI2orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9E2096014F; Tue, 20 May 2025 15:45:35 +0200 (CEST)
Date: Tue, 20 May 2025 15:44:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Duan Jiong <djduanjiong@gmail.com>, pablo@netfilter.org,
	netdev@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH] ipvs: skip ipvs snat processing when packet dst is not
 vip
Message-ID: <aCyHRcHJOhU9Ieih@strlen.de>
References: <20250519103203.17255-1-djduanjiong@gmail.com>
 <aef5ec1d-c62f-9a1c-c6f3-c3e275494234@ssi.bg>
 <CALttK1Sn=D4x81NpEq1ELHoXnEaiMboYBzYeOUX8qKHzDDxk0A@mail.gmail.com>
 <df6af9cc-35ff-5c3e-3e67-ed2f93a17691@ssi.bg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6af9cc-35ff-5c3e-3e67-ed2f93a17691@ssi.bg>

Julian Anastasov <ja@ssi.bg> wrote:
> 	But the following packet is different from your
> initial posting. Why client connects directly to the real server?
> Is it allowed to have two conntracks with equal reply tuple
> 192.168.99.4:8080 -> 192.168.99.6:15280 and should we support
> such kind of setups?

I don't even see how it would work, if you allow

C1 -> S
C2 -> S

... in conntrack and you receive packet from S, does that need to
go to C1 or C2?

Such duplicate CT entries are free'd (refused) at nf_confirm (
conntrack table insertion) time.

