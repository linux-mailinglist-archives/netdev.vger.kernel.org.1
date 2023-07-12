Return-Path: <netdev+bounces-17001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD3D74FC6F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74D2281796
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AEC374;
	Wed, 12 Jul 2023 00:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A3362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:55:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7F10CF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GJB47C2d0ARqOg/c1U+pb6qA16FXo2kjbcUazUrlYBs=; b=Dk
	8Yc2997LAx/h8mtrAV8BvF5hc4XqVRwCYdXNMhXWXy1BWiTx6Af+Covp36CiVvxq/c4cT8qFcQEcq
	psCDPp+OEnCQ/0m2IEeGRm8LhRlEKbm7boi2M16qLd128FJhA3gkSNqYO39ooljXyl5czwOx2m90U
	iKU9Vvafv1qzt4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJO8g-0015UK-Na; Wed, 12 Jul 2023 02:55:30 +0200
Date: Wed, 12 Jul 2023 02:55:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Harry Coin <hcoin@quietfountain.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Message-ID: <de5a9b44-fd6d-466a-822b-334343713b9b@lunn.ch>
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
 <20230711215132.77594-1-kuniyu@amazon.com>
 <b01e5af6-e397-486d-3428-6fa30a919042@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b01e5af6-e397-486d-3428-6fa30a919042@quietfountain.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Something like that, but to your point about regression -- It a
> statistically good bet there are many bridges with STP enabled in
> non-default name spaces that simply have no loops in L2 BUT these are
> 'buried'  inside docker images or prepackaged setups that work 'just fine
> standalone' and also 'in lab namespaces (that just don't have L2 loops...)
> and so that don't hit the bug.  These users are one "cable click to an open
> port already connected somewhere they can't see" away from bringing down
> every computer on their entire link (like me, been there, it's not a happy
> week for anyone...), they just don't know it.  And their vendors 'trust STP,
> so that can't be it' --- but it is.
> 
> If the patch above gets installed-- then packagers downstream will have to
> respond with effort to add code to turn off STP if finding themselves in a
> namespace, and not if not.   They will be displeased at having to
> accommodate then de-accommodate when the fix lands.   As a 'usually
> downstream of the kernel' developer, I'd rather be warned than blocked.

I don't know this code at all, so maybe a dumb question. What about
user space STP and RSTP? Do they get to see BPDUs? If that works, we
need to ensure any checking you add does not break that use case.

	Andrew

