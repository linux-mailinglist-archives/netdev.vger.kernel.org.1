Return-Path: <netdev+bounces-183908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876CCA92C71
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35258A78C0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730020767A;
	Thu, 17 Apr 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ar3w5zL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA435948
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923544; cv=none; b=GN/yBreisJViPZxG273fi0T6dOHUsPapmTGJMX7ThB0lGxSadBxsbQXEt+7HUHDrbWCa+Z4vbDfepCtFIsy/3uH1Peyi+5xZABHv0ylpGg7PpmS3INHzhtqR83HoYo5jOyWI1lCMyzLmHh9Q6bkGp64HLr15DYsmIaS7HeHX5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923544; c=relaxed/simple;
	bh=GvDLKyTkmKsaYd7sXxM11KZnMdIplo0KrzagXO0qXMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doOEdSEDjRTee5NE/puCsJtOC55k3XXtc4803AwuwYdvQ3DiO9SrO7bNa4Ohe8KY/DjLbbIuHF8jXU/f3AsaLXDkdoo5zd4qqOGm8yufa9FcnybO+AekoOiegtjQoRGj9BIFUOgbhQMsztAPCDBSbCKkXfAw6iUd6R42IPmN9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ar3w5zL2; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744923544; x=1776459544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWvHg5mIl3o+mfwbOFeqfdSqFFVdiYZjb4F4CKlwRHY=;
  b=Ar3w5zL2n0x/i5nDH6eTSdM1H5M5dfcPgyUgqT9P86n1JEDSUCG+tyGg
   jEVa6B2UtzkVTsmN+n8LF8aj0lRTie04v6tYfbBu83BYdr2SV+O72goaB
   Ia9QXB8Qna4FPUBKCwNNzEEOZFnt/Gc8bXuboIxD1hcb5icHF0sXo6ZLS
   s=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="481394119"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 20:57:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:18737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.240:2525] with esmtp (Farcaster)
 id ee074de8-aa69-4fc9-962e-aab5f89deda9; Thu, 17 Apr 2025 20:57:52 +0000 (UTC)
X-Farcaster-Flow-ID: ee074de8-aa69-4fc9-962e-aab5f89deda9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 20:57:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 20:57:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 1/7] neighbour: Make neigh_valid_get_req() return ndmsg.
Date: Thu, 17 Apr 2025 13:57:38 -0700
Message-ID: <20250417205741.13720-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416004253.20103-2-kuniyu@amazon.com>
References: <20250416004253.20103-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Thu, 17 Apr 2025 13:53:10 +0100
> On Tue, Apr 15, 2025 at 05:41:24PM -0700, Kuniyuki Iwashima wrote:
> > neigh_get() passes 4 local variable pointers to neigh_valid_get_req().
> > 
> > If it returns a pointer of struct ndmsg, we do not need to pass two
> > of them.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> ...
> 
> > @@ -2893,17 +2892,19 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
> >  		case NDA_DST:
> >  			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
> >  				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
> > -				return -EINVAL;
> 
> Hi Iwashima-san,
> 
> I think you need the following here:
> 
> 				err = -EINVAL;
> 
> > +				goto err;
> >  			}
> >  			*dst = nla_data(tb[i]);
> >  			break;
> >  		default:
> >  			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
> > -			return -EINVAL;
> 
> And here.
> 
> Flagged by Smatch as:
> 
>   .../neighbour.c:2907 neigh_valid_get_req() warn: passing zero to 'ERR_PTR'
> 
> > +			goto err;

Thanks for catching!

I missed nlmsg_parse_deprecated_strict() reset err to 0.

I'll explicitly set err before goto in every path instead of
initialising it first.


