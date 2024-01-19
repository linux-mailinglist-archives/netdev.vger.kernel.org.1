Return-Path: <netdev+bounces-64398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD36832D8F
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43881C20F4F
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C525576A;
	Fri, 19 Jan 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8nYkOMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F741C98
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683339; cv=none; b=c6BzO9aib42+nXi/uwoWco51I/YmsNa77ogII6M879lM4KsbxZTP68g0vtgtCoBvWGGD6W96HvXcZTNnhq7Lsj9PyVxvkWNvTpa8S8znkdzhUemspQnVETfdye2dJOJscEpfTa0JRZwIBvjvOMi62fVTLWPrmY4ceHptQSi5IhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683339; c=relaxed/simple;
	bh=zuZJZKU61xlL1EYFlogSl4Y/yFeVXu+b3DlM0oRVXpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu/fk1t+mSPul9eT0ej6typGoXSWqLIo+ukoQXCHfLUGtQf/+ZmQqz3+M5+g49dAjasHpJ9+uD8IYP1tY6KeGeh/tMZGWoF7F+RHB76BE0/UD4H7b0rjQIWVWdSvMkwDC+vzGeWpXUwd/dMBIwnoyl4ZeTtOO64OjsQGhyBHa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8nYkOMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062BC433C7;
	Fri, 19 Jan 2024 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705683338;
	bh=zuZJZKU61xlL1EYFlogSl4Y/yFeVXu+b3DlM0oRVXpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8nYkOMXzmqavT++E3STkO2oLudpyFxMEKVL6E5xSgb+s+uKdG/25BACXS99GkWeY
	 AXsB/CTSZzXzHpK4SsfdJsHxQQIMIhIPS5nXDnWlTY8+uMSB6pdk9B+Pe0fgCyA/3O
	 7KBZ7XpmXk4528NzKbPyQgGQH8NkfDWs/ea1ngqlajBsPKmdKNdvwD/cjKzxhhZnNI
	 g1XGgXgC0SvCiPv9C+HeSp46kUT6W84FleszYU/eKyiMWkFBRTxKIv6kZq/SjTxQrD
	 0GBsFBbR8j684vlkQpssggm9nPrsXykoHo7KRI59/PUMDd8SnrZvCGVSIXeCXVLEVx
	 Ts22fJF3HjxOg==
Date: Fri, 19 Jan 2024 16:55:33 +0000
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v5 iwl-next 1/6] ice: introduce PTP state machine
Message-ID: <20240119165533.GH89683@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-2-karol.kolacinski@intel.com>
 <20240115103240.GL392144@kernel.org>
 <CO1PR11MB50899045B5B747FC216134EAD6722@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB50899045B5B747FC216134EAD6722@CO1PR11MB5089.namprd11.prod.outlook.com>

On Wed, Jan 17, 2024 at 10:07:52PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, January 15, 2024 2:33 AM
> > To: Kolacinski, Karol <karol.kolacinski@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH v5 iwl-next 1/6] ice: introduce PTP state machine
> > 
> > On Mon, Jan 08, 2024 at 01:47:12PM +0100, Karol Kolacinski wrote:
> > 
> > Should there be a "From: Jacob" line here to
> > match the Signed-off-by below?
> > 
> > > Add PTP state machine so that the driver can correctly identify PTP
> > > state around resets.
> > > When the driver got information about ungraceful reset, PTP was not
> > > prepared for reset and it returned error. When this situation occurs,
> > > prepare PTP before rebuilding its structures.
> > >
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Hi Karol and Jacob,
> > 
> > FWIIW, The combination of both a Signed-off-by and Reviewed-by tag from
> > Jacob seems a little odd to me. If he authored the patch then I would have
> > gone with the following (along with the From line mentioned above):
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> > Otherwise, if he reviewed the patch I would have gone with:
> > 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > 
> 
> It's a bit odd, because I authored the initial code and patches some time ago, and Karol has been working to rebase and re-organize the code, so in some sense he authored part of this. I think a Co-authored would be suitable here. Additionally, I reviewed the result before it was published here.

Understood. I agree Co-authored might be useful here.

