Return-Path: <netdev+bounces-58630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FA817A78
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F401C21B8E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41C495DE;
	Mon, 18 Dec 2023 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtBSFMcs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D77146A;
	Mon, 18 Dec 2023 19:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E2C433CA;
	Mon, 18 Dec 2023 19:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926058;
	bh=VApFh3cRumz6BLzq1kdAeoE0D33106JBTlF4Ob27DSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtBSFMcsOxj1N0SaNjSviRGYpMENFKp7sNvzql/Z+d+Q5EBYkme6rrWcaBnpFzokT
	 mnUhEyPn/1J7SGFTBlVi9IB1YaUXXtr7iu1DTuik9c+O/SnpYZJMbUOLCRlrsxnn/v
	 xx0YGhthVVS5L+2HFXiJ+E0ZDZe2rgRxcE/vPe6bSAgIVaI7gQDKWcxwc2hiyRHjrJ
	 omOwu3Zeww79+vv7L8bRgRRgsMsnxMaT/MYj4BtTmllEWVWmT4IP4Q0xYEzyRtaGRb
	 QywvQhrNi7Qww36KtXcJXZg3/C3OpoV3JjFmLx7C5OB3qX6q6E64CdVfsiQ3s8lGRn
	 dVdiT2uak84pA==
Date: Mon, 18 Dec 2023 12:00:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
Message-ID: <20231218190055.GB2863043@dev-arch.thelio-3990X>
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
 <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>

On Mon, Dec 18, 2023 at 08:32:28AM -0800, Nick Desaulniers wrote:
> On Sun, Dec 17, 2023 at 1:45 AM Simon Horman <horms@kernel.org> wrote:
> >
> > Although it does not seem to have any untoward side-effects,
> > the use of ';' to separate to assignments seems more appropriate than ','.
> >
> > Flagged by clang-17 -Wcomma
> 
> Yikes! This kind of example is why I hate the comma operator!
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> (Is -Wcomma enabled by -Wall?)

No and last time that I looked into enabling it, there were a lot of
instances in the kernel:

https://lore.kernel.org/20230630192825.GA2745548@dev-arch.thelio-3990X/

It is still probably worth pursuing at some point but that is a lot of
instances to clean up (along with potentially having a decent amount of
pushback depending on the changes necessary to eliminate all instances).

> Is there a fixes tag we can add?
> 
> >
> > No functional change intended.
> > Compile tested only.
> >
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index 812d04747bd0..f542f2671957 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > @@ -1917,7 +1917,7 @@ int i40e_get_eeprom(struct net_device *netdev,
> >                         len = eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
> >                         last = true;
> >                 }
> > -               offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
> > +               offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
> >                 ret_val = i40e_aq_read_nvm(hw, 0x0, offset, len,
> >                                 (u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE * i),
> >                                 last, NULL);
> >
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 

