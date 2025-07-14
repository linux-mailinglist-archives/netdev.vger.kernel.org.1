Return-Path: <netdev+bounces-206774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF0B04571
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411D8188509F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2625B1D2;
	Mon, 14 Jul 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXLjCS8X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DF1ADC69
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510574; cv=none; b=goVHqGGZE6tWtot2Se5SMqY4xDVB8brzuPpqQTfmZSOzMMU2X0jiE+9VtYucVPI4+GEC5958vMiGc4SnDuSmt6gWYUHR9AvsHaZVQe+lcllCpM51y/koKsWplJrG5I3tE9Nq8bR8FbAqdsECm8a1zyJ3YAaMlssS0DjRJeL0I0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510574; c=relaxed/simple;
	bh=yUlpY/MH94IAi98phDQr3Eg8TalvrZIoJoaxdVk0rn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTcBO8MZtRhvRa7zHtOhnURPjyAaKSTVK+6Y6TDeHCSoJHdTH4VVtwdQ5MuVwy0dZjx107MujV4Lh97ozSeNnpHH8EZ4W/qofpcgRC7P4a12fJ0zWP9fgr9t9MtRL0EeqNVSnh40PFh6IkGiwEsTAZc1coT/UU1jafT6y3oowZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXLjCS8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1435C4CEED;
	Mon, 14 Jul 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510574;
	bh=yUlpY/MH94IAi98phDQr3Eg8TalvrZIoJoaxdVk0rn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UXLjCS8XWwXwKbm/2GYZli/TtyWZod7KP1JYEeID9ql3kFxt1i4krRZ2ufcNopls0
	 tBS+6xqzdnrQQK+YuqBrhkiUcM6hgUn3xuzrXh1bkwoDvsDjnzafyPybGTD3fy9nWG
	 FK8gIIwbjbuh0mYCCC9G1Gimhl1DLyUmz2eKQ4qXjWnzB/Y8RUoe3ATJFo9/JO39qH
	 BlBgUYrGEleSraZkoQ4mAecor4JvTEZ79zsBK6WoncDJKROxrOB8lpj0ghDiXxY9O/
	 OWtvwaezFdfYIRgusgynCsfSzEhvgo5YPOZBtQAO7JBR982TTmlb7XMDOroWkuJYSm
	 CmC00ijHLzdQg==
Date: Mon, 14 Jul 2025 09:29:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 10/11] ethtool: rss: support setting flow
 hashing fields
Message-ID: <20250714092933.029a6847@kernel.org>
In-Reply-To: <2a4c0db9-d330-441f-bce1-937401657bfe@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-11-kuba@kernel.org>
	<2a4c0db9-d330-441f-bce1-937401657bfe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:12:33 +0300 Gal Pressman wrote:
> On 11/07/2025 4:53, Jakub Kicinski wrote:
> > Add support for ETHTOOL_SRXFH (setting hashing fields) in RSS_SET.
> > 
> > The tricky part is dealing with symmetric hashing, user can change
> > the hashing fields and symmetric hash in one request. Since fields
> > and hash function config are separate driver callback changes to
> > the two are not atomic. Keep things simple and validate the settings
> > against both pre- and post- change ones. Meaning that we will reject
> > the config request if user tries to correct the flow fields and set
> > input_xfrm in one request, or disables input_xfrm and makes flow
> > fields non-symmetric.  
> 
> How is it different than what we have in ioctl?

Because:

  user can change the hashing fields and symmetric hash in one request

IOCTL has two separate calls for this so there's no way to even try
to change both at once. I'll add "unlike IOCTL which has separate
calls" ?

> > We can adjust it later if there's a real need. Starting simple feels
> > right, and potentially partially applying the settings isn't nice,
> > either.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  static void
> >  rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
> >  		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
> > @@ -673,11 +767,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
> >  	struct rss_req_info *request = RSS_REQINFO(req_info);
> >  	struct ethtool_rxfh_context *ctx = NULL;
> >  	struct net_device *dev = req_info->dev;
> > +	bool mod = false, fields_mod = false;  
> 
> Why not use mod?

Because it's a difference driver-facing op.

