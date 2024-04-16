Return-Path: <netdev+bounces-88187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB98A63A4
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DDCB2420A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136913D0A4;
	Tue, 16 Apr 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOPcagGg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC023C08A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248207; cv=none; b=VW+bYC6SRjCnYk9WgaE26mDwFMTSugwn4TUr/whd9zzNhk13TZ/ndkrcT3+62V6P+nN8AJ9PUDauqg7z+61H+krh2n+hw5CPF9sJwvMBsgiaEPkdTfqQ1A4HUJArFFZo67sPhg9MsErYcPqiDzyr8P1uKNwVj6g+thkbH377cBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248207; c=relaxed/simple;
	bh=LS6kxqMr2jweAkl/e91IqtJx4zTS2TvjSxqvBc6KXKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC4zvJqcyhPdLjoJBzUtA2C8g1bSbPU/VW5ljKNYNSxx0OwQwV/rJaGiL2eSLKzRxYIocNVOoqbFm5DpFRowySDaEi8CaJouIRsMsDFmTf6hxPAzmrkgHpfL7YYmE+cF+jf42Uk6NAuVlJV9z67xFetS5PPcbu3UDdg4LvOCYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOPcagGg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713248206; x=1744784206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LS6kxqMr2jweAkl/e91IqtJx4zTS2TvjSxqvBc6KXKM=;
  b=QOPcagGgesHwE9tB5OEBQ3ViS+8aEbnmGFDCdkOW0X+dOXw2+FznWtKK
   h4M9hhIWDSZkgjLnsT/7yxofVHNB97GcidJhEH7mV2Jr4OSji5TJrXwC2
   mg0hYQkFAEcYFjcp63TnAz9v3r8dCkJJRotUH6/KcoSynX64aDV7SiP5V
   LWv5U3p8ERhWsJMO7x0E7G6sBzwf5w7PUVVdB1Ifz9TCQuCwIteYOfT3A
   qjHNvGQppf4yRYkr4AAPC8xEGgX4Bq3sqmMoRov4evge+FHexp1BYhe7G
   m4zT2KI9hsCsFIaHeBtzR+xnVu2l/b8VISKcar0jW7qRSzvvUrUfbRj0v
   w==;
X-CSE-ConnectionGUID: IYR/9OlERm6IUJgTfmQSbw==
X-CSE-MsgGUID: pjbqGvBHTEmw3eFLiGUvuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8546745"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8546745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:16:45 -0700
X-CSE-ConnectionGUID: TflDeatzQ8WEuacwtQYjPA==
X-CSE-MsgGUID: 1uQyPdlARhu2JLYl3yPx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26810051"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:16:42 -0700
Date: Tue, 16 Apr 2024 08:16:17 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: maciej.fijalkowski@intel.com, mateusz.polchlopek@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	jiri@nvidia.com, michal.kubiak@intel.com,
	intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	wojciech.drewek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v3 3/7] ice: add basic devlink
 subfunctions support
Message-ID: <Zh4XsXwDxeu936kw@mev-dev>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-4-michal.swiatkowski@linux.intel.com>
 <Zhje0mQgQTMXwICb@nanopsycho>
 <Zhzny769lYYmLUs0@mev-dev>
 <ZhzvGlDiuaPSEHCX@nanopsycho>
 <Zh4JQ4RDRIAYC+V7@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh4JQ4RDRIAYC+V7@mev-dev>

On Tue, Apr 16, 2024 at 07:14:43AM +0200, Michal Swiatkowski wrote:
> On Mon, Apr 15, 2024 at 11:10:50AM +0200, Jiri Pirko wrote:
> > Mon, Apr 15, 2024 at 10:39:39AM CEST, michal.swiatkowski@linux.intel.com wrote:
> > >On Fri, Apr 12, 2024 at 09:12:18AM +0200, Jiri Pirko wrote:
> > >> Fri, Apr 12, 2024 at 08:30:49AM CEST, michal.swiatkowski@linux.intel.com wrote:
> > >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > [...]
> > 
> > >> >+static int
> > >> >+ice_devlink_port_fn_state_get(struct devlink_port *port,
> > >> >+			      enum devlink_port_fn_state *state,
> > >> >+			      enum devlink_port_fn_opstate *opstate,
> > >> >+			      struct netlink_ext_ack *extack)
> > >> >+{
> > >> >+	struct ice_dynamic_port *dyn_port;
> > >> >+
> > >> >+	dyn_port = ice_devlink_port_to_dyn(port);
> > >> >+
> > >> >+	if (dyn_port->active) {
> > >> >+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
> > >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> > >> 
> > >> Interesting. This means that you don't distinguish between admin state
> > >> and operational state. Meaning, when user does activate, you atomically
> > >> achive the hw attachment and it is ready to go before activation cmd
> > >> returns, correct? I'm just making sure I understand the code.
> > >> 
> > >
> > >I am setting the dyn_port->active after the activation heppens, so it is
> > >true, when active is set it is ready to go.
> > >
> > >Do you mean that dyn_port->active should be set even before the activation is
> > >finished? I mean when user only call devlink to active the port?
> > 
> > The devlink instance lock is taken the whole time, isn't it?
> > 
> 
> I don't take PF devlink lock here. Only subfunction devlink lock is
> taken during the initialization of subfunction.
>

Did you mean that the devlink lock is taken for DEVLINK_CMD_PORT_SET/GET
command? In this case, I think so, it is for the whole time of the
command execution.

Sorry I probably missed the point.

> > >
> > >> 
> > >> >+	} else {
> > >> >+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
> > >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> > >> >+	}
> > >> >+
> > >> >+	return 0;
> > >> >+}
> > >> >+
> > 
> > [...]

