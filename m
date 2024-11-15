Return-Path: <netdev+bounces-145246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479569CDE91
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AC281F0D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5E1B6D1A;
	Fri, 15 Nov 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdMQlEbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D51B6CE3
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674719; cv=none; b=Q8l60wVRrW7GK7PZNEjO14Y4UGx5c/Oa7y+LXfHYNuBZqluwETPMWdmO/bGz7lNtu+V3gIi6TsHaZk+t5oEK+fETLxzaNoCjpUExBzZxkTGDsB1xDobxVBenirwbNrOYTOoznk2dXnsNl+69e4rIQ3sesVwbZ+iSgIKF00/yA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674719; c=relaxed/simple;
	bh=zMOM1PAqWE7rZ59eadQ4Q40wY9FxpTUefPj94OxfR00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Muv/97m7JtbhIbErE/sJc8oOwFaopNUb2vnayi7PtpNMzaz8S1R+aYd07EvHzrzz8GhPSQSa++tor5gQEDtVfZ76sx+vlYJyppBUN1YIi1geqqGS11YyjGtYJZQ8k3+Oa3jPmKA7+tH/Q9eJaUU+Cee/6KldXoI1ughPq1HZ6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdMQlEbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C0C4CECF;
	Fri, 15 Nov 2024 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731674719;
	bh=zMOM1PAqWE7rZ59eadQ4Q40wY9FxpTUefPj94OxfR00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdMQlEbxjbB1mH5/lrhQKDG7URM4ArRfVUOqfnOcyA5XwTIrXyHUQB56Ws+TLW5az
	 bSU/uxBxpEGLGhgj/v/nBhhrvEO6jQqJ9NpbrQc0V4u1pXMJHq0ihRtXaU1RA+dXyC
	 bvR0HgDUpKuxSdvENTWyyt2KCUb+q2OJjzJ3sZDclP/W6U6CCXq4jbdl2WA2Fx8hpR
	 67yyJvbAedwmOAhbzrkzAUG4+NS7Fu3QXBpClOiJWlJaSeLEAhg6NkkDgpVkrI8UW0
	 cN03fudnFcBfXs47rdWHom2ozXps3DmxOFKPwCJb6oA7XHv8m4YT27PQqp28OEm8Tq
	 u+pqlK6a1LIDA==
Date: Fri, 15 Nov 2024 12:45:15 +0000
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-net 07/10] idpf: add Tx timestamp capabilities
 negotiation
Message-ID: <20241115124515.GO1062410@kernel.org>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-8-milena.olech@intel.com>
 <6736625792e20_3379ce2948b@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6736625792e20_3379ce2948b@willemb.c.googlers.com.notmuch>

On Thu, Nov 14, 2024 at 03:49:27PM -0500, Willem de Bruijn wrote:
> Milena Olech wrote:
> > Tx timestamp capabilities are negotiated for the uplink Vport.
> > Driver receives information about the number of available Tx timestamp
> > latches, the size of Tx timestamp value and the set of indexes used
> > for Tx timestamping.
> > 
> > Add function to get the Tx timestamp capabilities and parse the uplink
> > vport flag.
> > 
> > Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Milena Olech <milena.olech@intel.com>
> 
> A few minor points. No big concerns from me.
> 
> >  struct idpf_vc_xn_manager;
> >  
> > +#define idpf_for_each_vport(adapter, iter) \
> > +	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
> > +	     *iter = *__##iter; \
> > +	     __##iter < &(adapter)->vports[(adapter)->num_alloc_vports]; \
> > +	     iter = *(++__##iter))
> > +
> 
> Perhaps more readable to just use an int:
> 
>     for (int i = 0; iter = &(adapter)->vports[i], i < (adapter)->num_alloc_vports; i++)
> 
> >  /**
> > @@ -517,6 +524,60 @@ static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * idpf_ptp_release_vport_tstamp - Release the Tx timestamps trakcers for a
> 
> s/trakcers/trackers
> 
> > +/**
> > + * struct idpf_ptp_tx_tstamp - Parametrs for Tx timestamping
> 
> s/Parametrs/Parameters
> 
> > + * @list_member: the list member strutcure
> 
> s/strutcure/Structure
> 
> Please use a spell checker, don't rely on reviewers.

To add to that:

* Capabilities is misspelt in the subject
* checkpatch.pl --codespell will spell-check the patch

> 
> Also, going forward, IMHO documentation can be limited to APIs and
> non-obvious functions/structs/fields.
> 

