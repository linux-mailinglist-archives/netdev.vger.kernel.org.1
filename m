Return-Path: <netdev+bounces-150042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D59E8B87
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B18163CA3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78115990C;
	Mon,  9 Dec 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldFqQhef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1414E2CF;
	Mon,  9 Dec 2024 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725937; cv=none; b=RRsjfAqEv3SFCyAr6+SGfBsQ8kWnIBWp8N/wHQzoh6tJRBRvQOHrj5hu7r/op//UyDcEndEAr4ifm88/bj/0SXJa9Z7/wuM6/UWfy9ygwxQBz7yKYpUeNLVuE94uSHstYGL5Gx8e5fyUkzwhiOwEWH8jUKIT/vDBW9fmNk2UDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725937; c=relaxed/simple;
	bh=M0gILic1Jcfd4zLwbcEBp09+PdxDNMMYLSq89tSKWWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqla8BfEIscoeLXPibTryQ9QBQ4LEnIigg/VUYaIEx1fZMAQqDMPwoiK9sL8Dp0iRc1DMjhJUD2+UUb20QJ5CoVT3+9HaUlazosRa3UUmKif+tXpPhGLvo8WeyYM8W42i3UYlp1yhur2/n2D3Pp3mEX1cOtnKGEYO8YFqbTfSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldFqQhef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183C3C4CED1;
	Mon,  9 Dec 2024 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733725936;
	bh=M0gILic1Jcfd4zLwbcEBp09+PdxDNMMYLSq89tSKWWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldFqQhefLe+emhGvcfLjNeQsJHWNtve53OFslt17dpszYJ4z2b+fvGaGt3dikXPSO
	 WXoAAXzQGu0UEBgVRgt+it/jgb10sUUv+reoTNfFuY/m9uy2MSK+iwdfpEvGtmEH5j
	 nisUWl7bXLrMA/0nJNrB7xueiQClgebtgrVs/yuw=
Date: Mon, 9 Dec 2024 07:31:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir()
 helper
Message-ID: <2024120925-dreamt-immorally-f9f8@gregkh>
References: <20241206111629.3521865-1-shaojijie@huawei.com>
 <20241206111629.3521865-2-shaojijie@huawei.com>
 <2024120627-smudge-obsolete-efb6@gregkh>
 <6274cc5a-375f-4009-bc3e-1b1063f298bb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6274cc5a-375f-4009-bc3e-1b1063f298bb@huawei.com>

On Mon, Dec 09, 2024 at 09:02:10AM +0800, Jijie Shao wrote:
> 
> on 2024/12/6 19:40, Greg KH wrote:
> > On Fri, Dec 06, 2024 at 07:16:22PM +0800, Jijie Shao wrote:
> > > Add debugfs_create_devm_dir() helper
> > > 
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   fs/debugfs/inode.c      | 36 ++++++++++++++++++++++++++++++++++++
> > >   include/linux/debugfs.h | 10 ++++++++++
> > >   2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > index 38a9c7eb97e6..f682c4952a27 100644
> > > --- a/fs/debugfs/inode.c
> > > +++ b/fs/debugfs/inode.c
> > > @@ -610,6 +610,42 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
> > >   }
> > >   EXPORT_SYMBOL_GPL(debugfs_create_dir);
> > > +static void debugfs_remove_devm(void *dentry_rwa)
> > > +{
> > > +	struct dentry *dentry = dentry_rwa;
> > > +
> > > +	debugfs_remove(dentry);
> > > +}
> > > +
> > > +/**
> > > + * debugfs_create_devm_dir - Managed debugfs_create_dir()
> > > + * @dev: Device that owns the action
> > > + * @name: a pointer to a string containing the name of the directory to
> > > + *        create.
> > > + * @parent: a pointer to the parent dentry for this file.  This should be a
> > > + *          directory dentry if set.  If this parameter is NULL, then the
> > > + *          directory will be created in the root of the debugfs filesystem.
> > > + * Managed debugfs_create_dir(). dentry will automatically be remove on
> > > + * driver detach.
> > > + */
> > > +struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
> > > +				       struct dentry *parent)
> > > +{
> > > +	struct dentry *dentry;
> > > +	int ret;
> > > +
> > > +	dentry = debugfs_create_dir(name, parent);
> > > +	if (IS_ERR(dentry))
> > > +		return dentry;
> > > +
> > > +	ret = devm_add_action_or_reset(dev, debugfs_remove_devm, dentry);
> > > +	if (ret)
> > > +		ERR_PTR(ret);
> > You don't clean up the directory you created if this failed?  Why not?
> 
> Don't need to clean up.
> in devm_add_action_or_reset(), if failed, will call action: debugfs_remove_devm(),
> So, not clean up again.
> 
> #define devm_add_action_or_reset(dev, action, data) \
> 	__devm_add_action_or_reset(dev, action, data, #action)
> 
> static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
> 					     void *data, const char *name)
> {
> 	int ret;
> 
> 	ret = __devm_add_action(dev, action, data, name);
> 	if (ret)
> 		action(data);
> 
> 	return ret;
> }
> 
> But there's a problem with this, I missed return.
> I will add return in v6.

As this did not even compile, how did you test any of this?

I'm now loath to add this at all, please let's just keep this "open
coded" in your driver for now until there are multiple users that need
this and then convert them all to use the function when you add it.

thanks,

greg k-h

