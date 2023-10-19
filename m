Return-Path: <netdev+bounces-42631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280127CFA25
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF17A282072
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A340225BC;
	Thu, 19 Oct 2023 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryaqfFw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A62225BA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03D1C116AC;
	Thu, 19 Oct 2023 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697720448;
	bh=UaNVdnVtS+6Y8Bshaztbg+8lEOSi39R7ycoX+4dZ6pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryaqfFw+Um1JiXJ/cvml2Ts72RDlw1VPiTE4HrJJc83VENXKHBG9V3jrfo7BzweXJ
	 nCq2j6VVCnj/fo9L7NyyXpzPJ61jsS8RGDvy1SohZCp4r5eW7sBqfps7Syn2QLlMue
	 fGKx4RRFnojw3NO8i3Vd10Amvrz/CG1BM0NmpN4Odh/BmiLtmYXO6OPknPTkLumujH
	 6OGEkfXgW5uKna/ST3fNefqE4abgz9oIfM8MUzd7BLNqDXGN859DLI7oHfvhcU/XO9
	 DkZZTCMojrif7yFjcdyqR7hAit9YA3jkQ2e7qrsOmRoRLc2Utd97u99taPCdBYm3+B
	 6SGCSUFP1/uCg==
Date: Thu, 19 Oct 2023 15:00:37 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Benjamin Poirier <bpoirier@suse.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <20231019130037.GI2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-2-przemyslaw.kitszel@intel.com>

On Wed, Oct 18, 2023 at 10:26:37PM +0200, Przemek Kitszel wrote:
> Retain error value in struct devlink_fmsg, to relieve drivers from
> checking it after each call.
> Note that fmsg is an in-memory builder/buffer of formatted message,
> so it's not the case that half baked message was sent somewhere.
> 
> We could find following scheme in multiple drivers:
>   err = devlink_fmsg_obj_nest_start(fmsg);
>   if (err)
>   	return err;
>   err = devlink_fmsg_string_pair_put(fmsg, "src", src);
>   if (err)
>   	return err;
>   err = devlink_fmsg_something(fmsg, foo, bar);
>   if (err)
> 	return err;
>   // and so on...
>   err = devlink_fmsg_obj_nest_end(fmsg);
> 
> With retaining error API that translates to:
>   devlink_fmsg_obj_nest_start(fmsg);
>   devlink_fmsg_string_pair_put(fmsg, "src", src);
>   devlink_fmsg_something(fmsg, foo, bar);
>   // and so on...
>   devlink_fmsg_obj_nest_end(fmsg);
> 
> What means we check error just when is time to send.
> 
> Possible error scenarios are developer error (API misuse) and memory
> exhaustion, both cases are good candidates to choose readability
> over fastest possible exit.
> 
> Note that this patch keeps returning errors, to allow per-driver conversion
> to the new API, but those are not needed at this point already.
> 
> This commit itself is an illustration of benefits for the dev-user,
> more of it will be in separate commits of the series.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> @@ -1027,14 +934,12 @@ int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,

Hi Przemek,

The line before this hunk is:

		err = devlink_fmsg_binary_put(fmsg, value + offset, data_size);

And, as of this patch, the implementation of
devlink_fmsg_binary_pair_nest_start() looks like this:

int devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
                            u16 value_len)
{
        if (!fmsg->putting_binary)
                return -EINVAL;

        return devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
}

Which may return an error, if the if condition is met, without setting
fmsg->err.

>  		if (err)
>  			break;
>  		/* Exit from loop with a break (instead of
> -		 * return) to make sure putting_binary is turned off in
> -		 * devlink_fmsg_binary_pair_nest_end
> +		 * return) to make sure putting_binary is turned off
>  		 */
>  	}
>  
> -	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
> -	if (end_err)
> -		err = end_err;

Prior to this patch, the value of err from the loop above was preserved,
unless devlink_fmsg_binary_pair_nest_end generated an error.

> +	err = devlink_fmsg_binary_pair_nest_end(fmsg);

But now it looks like this is only the case if fmsg->err corresponds to err
when the loop was exited.

Or in other words, the err returned by devlink_fmsg_binary_put()
is not propagated to the caller if !fmsg->putting_binary.

If so, is this intentional?

> +	fmsg->putting_binary = false;
>  
>  	return err;
>  }
> -- 
> 2.38.1
> 

