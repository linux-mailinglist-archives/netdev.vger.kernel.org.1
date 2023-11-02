Return-Path: <netdev+bounces-45800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74B7DFABB
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE821C20DDB
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5D200D4;
	Thu,  2 Nov 2023 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mPDbYyzj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263C21353
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 19:14:28 +0000 (UTC)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561C188;
	Thu,  2 Nov 2023 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1698952460;
	bh=O7wEcDJtrGJ2yEwB0sEkgTD3GrHwoBv5RI3h12B/TWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPDbYyzj2o7kfdQXXedsrUe8Ts0XLpOU4a2ChB6jMnNoFOwzBU97iZ5d7QZ00ekr4
	 BirHopLx8Qy05TCzR71Ua/aGkDs4JdExXFm45Bsz8W5tT/23QYJSV2X/Br3bfo9uKn
	 7bmJ/7HLYGg+8BnqSk72TpcADtK5s4dA533fXfgA=
Date: Thu, 2 Nov 2023 20:14:19 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rfkill: return ENOTTY on invalid ioctl
Message-ID: <613039a4-41af-48ff-8113-3b0ee8077bcf@t-8ch.de>
References: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
 <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>

Hi!

On 2023-11-02 09:57:45+0100, Przemek Kitszel wrote:
> On 11/1/23 20:41, Thomas Weißschuh wrote:
> > For unknown ioctls the correct error is
> > ENOTTY "Inappropriate ioctl for device".
> 
> For sure!
> 
> I would like to learn more of why this is not an UAPI breaking change?

"break" would mean that some user application worked correctly before
but does not do so anymore with this change.

This seems highly unlikely and I was not able to find such an
application via Debian code search.

In general I did *not* mark this change for stable so if some
application would indeed break it gets detected before the patch hits
a release.

> > 
> > ENOSYS as returned before should only be used to indicate that a syscall
> > is not available at all.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   net/rfkill/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > index 14cc8fe8584b..c3feb4f49d09 100644
> > --- a/net/rfkill/core.c
> > +++ b/net/rfkill/core.c
> > @@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
> >   			     unsigned long arg)
> >   {
> >   	struct rfkill_data *data = file->private_data;
> > -	int ret = -ENOSYS;
> > +	int ret = -ENOTTY;
> >   	u32 size;
> >   	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
> > -		return -ENOSYS;
> > +		return -ENOTTY;
> >   	mutex_lock(&data->mtx);
> >   	switch (_IOC_NR(cmd)) {
> > 
> > ---
> > base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
> > change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1
> > 
> > Best regards,
> 

