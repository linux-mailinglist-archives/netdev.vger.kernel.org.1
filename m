Return-Path: <netdev+bounces-211386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E1B18801
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5689546B93
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2F205AD7;
	Fri,  1 Aug 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR8wGA6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB31548EE
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079314; cv=none; b=SiITrETw1IsGHEmCsqV0OwXxinEF4yWa16kJfHK2DaSbHhbNOyvd7yuRPK03Dd4yh6W+zyec37x8RuYG/Kks8br+TKzFCl2zp6ng7m1/jCi+za+SLqZNB43ddNG/NHP8aUepdcA4HJOsmgsppKP38uVtjacBBQ9UN6G6H+K+ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079314; c=relaxed/simple;
	bh=ywCesd64E7AJR+4Ov1/u18ELI3llW4JDyzu3rDZqqbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCHgPNI60F0msaOQVkLMoDnLuJNuLI5EbPzkh9vDKHy/vj1XnKdn0N6VNaz95Pl1PZI/gx8H1aSVWP/4PVHqDUU7YT7Hs0o+C5qD2gYk0X1yWubnaMRL9am5HA3CSW9/TmNLN8hfssHCvDolbK/krsCFTUtU2Twz/nK7cS7KCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR8wGA6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FDBC4CEE7;
	Fri,  1 Aug 2025 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754079314;
	bh=ywCesd64E7AJR+4Ov1/u18ELI3llW4JDyzu3rDZqqbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QR8wGA6uxXkmlv7iiUDzxH/KRAsjJ7WQuJO3iPbqUtwKB2JKYgWV8PRTYHqflKWpP
	 5B79jMmSSBaZPCMO+u+zx1mQlPPi9p1PTNO/QcksI31gw5Q6wsTHO4oxQeRWRDs6Sp
	 dmu76EkV4zDd7JMDFA6/8kL7PbIFRXkLIiB+zVJUGw+hvtlPGNabFv6TFrgbLRX6OR
	 YDsxsi6uQU4CDfrcIfp6y6KE0iJ7dYTNETxGCR0ykODQCG4U5poaftLdzYsO1PHbhZ
	 TTaG+cF51KM+3VVHvKQfxgSa6erLijCFAh8GSgmAACH8Wff1axWsw7MGGqBGvrI/ru
	 SFoBLAwedIa2A==
Date: Fri, 1 Aug 2025 13:15:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Kaplan@amd.com,
 dhowells@redhat.com, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH net 1/2] devlink: allow driver to freely name interfaces
Message-ID: <20250801131513.45a6274d@kernel.org>
In-Reply-To: <20250801172240.3105730-2-anthony.l.nguyen@intel.com>
References: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
	<20250801172240.3105730-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Aug 2025 10:22:37 -0700 Tony Nguyen wrote:
> Subject: [PATCH net 1/2] devlink: allow driver to freely name interfaces

The subject is a bit misleading.. Maybe something like:

  let driver opt out of automatic phys_port_name generation

> Date: Fri,  1 Aug 2025 10:22:37 -0700
> X-Mailer: git-send-email 2.47.1
> 
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Currently when adding devlink port it is prohibited to let a driver name
> an interface on its own. In some scenarios it would not be preferable to
> provide such limitation, eg some compatibility purposes.
> 
> Add flag skip_phys_port_name_get to devlink_port_attrs struct which
> indicates if devlink should not alter name of interface.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>

Link to the suggestion could be useful?

> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  include/net/devlink.h | 7 ++++++-
>  net/devlink/port.c    | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 93640a29427c..bfa795bf9998 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -78,6 +78,7 @@ struct devlink_port_pci_sf_attrs {
>   * @flavour: flavour of the port
>   * @split: indicates if this is split port
>   * @splittable: indicates if the port can be split.
> + * @skip_phys_port_name_get: if set devlink doesn't alter interface name

Again, we're not actually doing anything the the interface name.
We're exposing a sysfs attribute which systemd/udev then uses
to rename the interface. From kernel PoV this is about attributes.

>   * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
>   * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
>   * @phys: physical port attributes
> @@ -87,7 +88,11 @@ struct devlink_port_pci_sf_attrs {
>   */
>  struct devlink_port_attrs {
>  	u8 split:1,
> -	   splittable:1;
> +	   splittable:1,
> +	   skip_phys_port_name_get:1; /* This is for compatibility only,
> +				       * newly added driver/port instance
> +				       * should never set this.
> +				       */

Thanks for noting that this is compat-only. I think it'd be better
to consolidate the comments, since we have kdoc..
Move this note up to kdoc; or document the member inline:

	splittable:1,
	/**
	 * @skip_phys_port_..: bok bok ba-gok!
	 */
	skip_phys_port_name_get:1;

BTW the name is a bit long, "no_phys_port_name" please?

