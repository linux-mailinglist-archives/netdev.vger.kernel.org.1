Return-Path: <netdev+bounces-121617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B3F95DBE4
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54991C21ECB
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B425D15D5B6;
	Sat, 24 Aug 2024 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmnOhMzs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FC156993;
	Sat, 24 Aug 2024 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476712; cv=none; b=XiOYJH9P9Wlu+CyVUVHxskqY0FJQPCrL6jFklU3o3oDNIbY2HUu/8WmDh+LbzyK5pu72SCxXmC2XjuRRC9SXBFu4eZLjITJNKLx+Ix6/oifTNUBTuYyKADv+1+/8Jo+7PM3CXPn2nNz64foKMlJ71dJgAKWbdGkK5hDUBpJj9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476712; c=relaxed/simple;
	bh=vaVUY3x1E+AltHmP85LtP0QxxKM//TMlRo0EhRETOTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6g23gj7nv8w9lTkioVXkmC3gK/LMo8+zyg8B8ksx9ykqYGhNx/7rMbg6kdFn3wjubk3Fn6SMCDG/egi4VtmZVGQv3tIkD3B0Thjtukl7ON2Z6sbOvrhu6MvMSXa5JSG4SHojNx0Evv0qjrJYjcOHxbl7GDBpORuMgZknXjlbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmnOhMzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB78C32781;
	Sat, 24 Aug 2024 05:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476712;
	bh=vaVUY3x1E+AltHmP85LtP0QxxKM//TMlRo0EhRETOTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmnOhMzsIWi5qna6yeiwCxebFimDjitRfM8CBuwHM7gb0mWRGGHEfDISFTDDTScsG
	 0SqwyRgdBUC+C37zUAxwGakUPIR0xccyhLQBbaXaAMynDUabnToBTx6JeIsZyA7bbG
	 g+hRXmpP+D3OkewCfhYvDFAtNv7egCPPChRPzea0=
Date: Sat, 24 Aug 2024 11:21:03 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Message-ID: <2024082435-finite-handrail-a4bb@gregkh>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
 <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
 <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
 <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
 <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>

On Wed, Aug 21, 2024 at 10:44:27PM +0800, Zijun Hu wrote:
> On 2024/8/20 22:14, Ira Weiny wrote:
> > Zijun Hu wrote:
> >> On 2024/8/20 20:53, Ira Weiny wrote:
> >>> Zijun Hu wrote:
> >>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>
> >>>> The following API cluster takes the same type parameter list, but do not
> >>>> have consistent parameter check as shown below.
> >>>>
> >>>> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
> >>>> device_for_each_child_reverse(struct device *parent, ...) // same as above
> >>>> device_find_child(struct device *parent, ...)      // check (!parent)
> >>>>
> >>>
> >>> Seems reasonable.
> >>>
> >>> What about device_find_child_by_name()?
> >>>
> >>
> >> Plan to simplify this API implementation by * atomic * API
> >> device_find_child() as following:
> >>
> >> https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
> >> struct device *device_find_child_by_name(struct device *parent,
> >>  					 const char *name)
> >> {
> >> 	return device_find_child(parent, name, device_match_name);
> >> }
> > 
> > Ok.  Thanks.
> > 
> >>
> >>>> Fixed by using consistent check (!parent || !parent->p) for the cluster.
> >>>>
> >>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>> ---
> >>>>  drivers/base/core.c | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>>> index 1688e76cb64b..b1dd8c5590dc 100644
> >>>> --- a/drivers/base/core.c
> >>>> +++ b/drivers/base/core.c
> >>>> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
> >>>>  	struct device *child;
> >>>>  	int error = 0;
> >>>>  
> >>>> -	if (!parent->p)
> >>>> +	if (!parent || !parent->p)
> >>>>  		return 0;
> >>>>  
> >>>>  	klist_iter_init(&parent->p->klist_children, &i);
> >>>> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
> >>>>  	struct device *child;
> >>>>  	int error = 0;
> >>>>  
> >>>> -	if (!parent->p)
> >>>> +	if (!parent || !parent->p)
> >>>>  		return 0;
> >>>>  
> >>>>  	klist_iter_init(&parent->p->klist_children, &i);
> >>>> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
> >>>>  	struct klist_iter i;
> >>>>  	struct device *child;
> >>>>  
> >>>> -	if (!parent)
> >>>> +	if (!parent || !parent->p)
> >>>
> >>> Perhaps this was just a typo which should have been.
> >>>
> >>> 	if (!parent->p)
> >>> ?
> >>>
> >> maybe, but the following device_find_child_by_name() also use (!parent).
> >>
> >>> I think there is an expectation that none of these are called with a NULL
> >>> parent.
> >>>
> >>
> >> this patch aim is to make these atomic APIs have consistent checks as
> >> far as possible, that will make other patches within this series more
> >> acceptable.
> >>
> >> i combine two checks to (!parent || !parent->p) since i did not know
> >> which is better.
> > 
> > I'm not entirely clear either.  But checking the member p makes more sense
> > to me than the parent parameter.  I would expect that iterating the
> > children of a device must be done only when the parent device is not NULL.
> > 
> > parent->p is more subtle.  I'm unclear why the API would need to allow
> > that to run without error.
> > 
> i prefer (!parent || !parent->p) with below reasons:
> 
> 1)
> original API authors have such concern that either (!parent) or
> (!parent->p) maybe happen since they are checked, all their concerns
> can be covered by (!parent || !parent->p).

Wait, a device's parent can NOT be NULL except for some special cases
when it is being created.

And the ->p check is for internal stuff, meaning it has been initialized
and registered properly, again, these functions should never be called
for a device that this has not happened on.  So if they are, crashing is
fine as this should never have gotten through a development cycle.

The ->p checks were added way after the initial driver core was created,
as evolution of moving things out of struct device to prevent drivers
from touching those fields.  They were added add-hoc where needed and
probably not everywhere as you are finding out.

By adding these "robust" checks, we are making it harder for new code to
be written at the expense of doing checks that we "know" are never
going to happen in normal operation.  It's a trade off.  Only add them
when you KNOW they will be needed please.

thanks,

greg k-h

