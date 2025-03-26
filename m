Return-Path: <netdev+bounces-177762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3AA71A28
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C6816B95B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912D13C8EA;
	Wed, 26 Mar 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEYnLlFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE3323D
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002645; cv=none; b=s2eAm239uxyE+Yv6PFbrStkATCE4cLecircBwnpSxAi1IpoGeSdRM0eYz+EK6PkcrOGuDBS9kEddDFGzP55thwB1alRjmpVzNzQwW5zEcpGKyxbEsO9yQlrQwEjjbTQ3j0P/V8l787Ev1sPE53v+vCakuV/FqFdya0iEiOtMW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002645; c=relaxed/simple;
	bh=4FfmYsnViXFaYj416TiGDriOpzCDWEUKPyt7GuMq9tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ3kxeej6POGueJ0nSwx10xK2XVJx0m/HSlCSKjlTwMkUCaiO1LoCOPOA7JYC52aAMFvqPHheH51cIpL+3sQ0AISi8MuimSJ9SyaDmJSoEbzMnRjMtW9/UzSHXCmR0BxvV7KIqfjxOdYF04/3PwWKwo7zkjijSXK3AxV0hxNzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEYnLlFc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so211155ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743002643; x=1743607443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rky/bavuj14UmOnlVxS75L02uMQ3sgxL7B4eW9eWBKA=;
        b=mEYnLlFcoH2wvy7bUuPdBbybsUmqR93DBr+GSG2vpgDPwnfbaKBXrjZpXcFvkB4nl1
         FQKVA7O4FRsn84QzhfwFoIkumxLVtXvshpcl3ICUI7wYgNCxTA9YdM6PM+XzEKrrG59X
         zbO1cqevy4NtMdBDeU9rDLafCg9JMRehUQy7eGQLuh/2K3yfy9cQhyfJ5xib2zBzTj5M
         2zAkesHon562Gry2U5SEVkJQD7IA6PNFwXv4ZCouTWLLw11kSJKDL77J6eaZktXIMOZY
         h+RZpkm0zy5xaVnLK+tFoZsrlzCwZISYQSqK55QuW9WTxsxvYCbM8XxyNuFYCSyvmRZ8
         PwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002643; x=1743607443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rky/bavuj14UmOnlVxS75L02uMQ3sgxL7B4eW9eWBKA=;
        b=fRvJ2ve+MKsz5Qm9w4oSaAIO7NVjqKAIniJnsl3MEL+nGkVBPyGQpjzGmpPFT/vwL1
         y17iSuNqGXyxa4Q3KpbYXmaWhFgEGBcKydEtU00TFSWWPJ6arFsoN8z6DeSYn+C9rGE+
         YfhX3jtXDmhIT4f6syRk1MoQtYVCMYGJxUNO6NpxGX6YPsTLjFrq+0G5UXSqumSHl/hj
         A4yhqkj4eQjNY+QesMOw25x3Sb9oqjrzWVoEAtuDaqC7J3l7akFOdcebod+iSHN5hlks
         hrHgxAtahFjaFK+KiYQUmtmOaMRaSIVmqii25V6wGGA7LZgtYMlcM6YVmv0v+LssvBRj
         kjNQ==
X-Gm-Message-State: AOJu0YyJzOJQXSHEmE4ymUJwOl5ang1+pcTZNj/rh57O4na7PyJrr1ey
	upHsNhxNaxl1rFR8FmKVTW5hFC+LB5y5LRpNPA5PC6bdu1aaPL0=
X-Gm-Gg: ASbGncukWYUlrhBf86Qvc72ILFnakWZo0Rq97hHncZ9AmqZLVq7tlhl1UZUu139T05L
	Njj8vfGTXfvsuGpL6WvjcZLzxbxfi7Rkd2yj0H5Xm9yx9olcf4pXiNDMhsxoZLAT0FQ+nd8jLTF
	YR7oRmurIsIn2sZ1LfxP+Du2mh0iQRpm2sm4e+hSqLFsQMRIH+sw+OPdDMh6Ste2jUUJAAFP85S
	zHuECCMMMNWp6Mw5HYM8MebF1obdfryTpGaNcgQFii65akk9QiJT4mThpempmKDhGySHOr6131c
	Jamle7PZPdF+3hE/6/SmlQ+i6jSnUYGwiPyfXRyeGQVs
X-Google-Smtp-Source: AGHT+IECkXeB4qLUGLVES0ue7P5pKRS6gBpilYXh7ELJfgELi40OEEAUh4AoyzZaDbuCugJ0isgl8g==
X-Received: by 2002:a05:6a20:3d84:b0:1f5:902e:1e97 with SMTP id adf61e73a8af0-1fea2fa6777mr272915637.41.1743002642512;
        Wed, 26 Mar 2025 08:24:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a284695dsm11137676a12.44.2025.03.26.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:24:01 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:23:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <Z-QcD5BXD5mY3BA_@mini-arch>
References: <20250325213056.332902-1-sdf@fomichev.me>
 <20250325213056.332902-3-sdf@fomichev.me>
 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>

On 03/26, Cosmin Ratiu wrote:
> On Tue, 2025-03-25 at 14:30 -0700, Stanislav Fomichev wrote:
> > @@ -2072,8 +2087,8 @@ static void
> > __move_netdevice_notifier_net(struct net *src_net,
> >  					  struct net *dst_net,
> >  					  struct notifier_block *nb)
> >  {
> > -	__unregister_netdevice_notifier_net(src_net, nb);
> > -	__register_netdevice_notifier_net(dst_net, nb, true);
> > +	__unregister_netdevice_notifier_net(src_net, nb, false);
> > +	__register_netdevice_notifier_net(dst_net, nb, true, false);
> >  }
> 
> I tested with your (and the rest of Jakub's) patches.
> The problem with this approach is that when a netdev's net is changed,
> its lock will be acquired, but the notifiers for ALL netdevs in the old
> and the new namespace will be called, which will result in correct
> behavior for that device and lockdep_assert_held failure for all
> others.

Perfect, thanks for testing! At least we don't deadlock anymore, that's
progress :-) So looks like we need to do something like the following
below, maybe you can give it a run on your side? Since we don't
have any locking hierarchy (yet), we should be able to lock all
other netdevs besides the one that's already locked at netlink level.


diff --git a/net/core/dev.c b/net/core/dev.c
index afee19245401..125af0fc25d3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1895,32 +1895,32 @@ static int call_netdevice_register_notifiers(struct notifier_block *nb,
 
 static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 						struct net_device *dev,
-						bool lock)
+						struct net_device *locked)
 {
 	if (dev->flags & IFF_UP) {
 		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
 	}
-	if (lock)
+	if (dev != locked)
 		netdev_lock_ops(dev);
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
-	if (lock)
+	if (dev != locked)
 		netdev_unlock_ops(dev);
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 						 struct net *net,
-						 bool lock)
+						 struct net_device *locked)
 {
 	struct net_device *dev;
 	int err;
 
 	for_each_netdev(net, dev) {
-		if (lock)
+		if (locked != dev)
 			netdev_lock_ops(dev);
 		err = call_netdevice_register_notifiers(nb, dev);
-		if (lock)
+		if (locked != dev)
 			netdev_unlock_ops(dev);
 		if (err)
 			goto rollback;
@@ -1929,18 +1929,18 @@ static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 
 rollback:
 	for_each_netdev_continue_reverse(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev, lock);
+		call_netdevice_unregister_notifiers(nb, dev, locked);
 	return err;
 }
 
 static void call_netdevice_unregister_net_notifiers(struct notifier_block *nb,
 						    struct net *net,
-						    bool lock)
+						    struct net_device *locked)
 {
 	struct net_device *dev;
 
 	for_each_netdev(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev, lock);
+		call_netdevice_unregister_notifiers(nb, dev, locked);
 }
 
 static int dev_boot_phase = 1;
@@ -1977,7 +1977,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 		goto unlock;
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		err = call_netdevice_register_net_notifiers(nb, net, true);
+		err = call_netdevice_register_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 		if (err)
 			goto rollback;
@@ -1991,7 +1991,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 rollback:
 	for_each_net_continue_reverse(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net, true);
+		call_netdevice_unregister_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 	}
 
@@ -2028,7 +2028,7 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net, true);
+		call_netdevice_unregister_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 	}
 
@@ -2042,7 +2042,7 @@ EXPORT_SYMBOL(unregister_netdevice_notifier);
 static int __register_netdevice_notifier_net(struct net *net,
 					     struct notifier_block *nb,
 					     bool ignore_call_fail,
-					     bool lock)
+					     struct net_device *locked)
 {
 	int err;
 
@@ -2052,7 +2052,7 @@ static int __register_netdevice_notifier_net(struct net *net,
 	if (dev_boot_phase)
 		return 0;
 
-	err = call_netdevice_register_net_notifiers(nb, net, lock);
+	err = call_netdevice_register_net_notifiers(nb, net, locked);
 	if (err && !ignore_call_fail)
 		goto chain_unregister;
 
@@ -2065,7 +2065,7 @@ static int __register_netdevice_notifier_net(struct net *net,
 
 static int __unregister_netdevice_notifier_net(struct net *net,
 					       struct notifier_block *nb,
-					       bool lock)
+					       struct net_device *locked)
 {
 	int err;
 
@@ -2073,7 +2073,7 @@ static int __unregister_netdevice_notifier_net(struct net *net,
 	if (err)
 		return err;
 
-	call_netdevice_unregister_net_notifiers(nb, net, lock);
+	call_netdevice_unregister_net_notifiers(nb, net, locked);
 	return 0;
 }
 
@@ -2097,7 +2097,7 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 	int err;
 
 	rtnl_net_lock(net);
-	err = __register_netdevice_notifier_net(net, nb, false, true);
+	err = __register_netdevice_notifier_net(net, nb, false, NULL);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2126,7 +2126,7 @@ int unregister_netdevice_notifier_net(struct net *net,
 	int err;
 
 	rtnl_net_lock(net);
-	err = __unregister_netdevice_notifier_net(net, nb, true);
+	err = __unregister_netdevice_notifier_net(net, nb, NULL);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2135,10 +2135,11 @@ EXPORT_SYMBOL(unregister_netdevice_notifier_net);
 
 static void __move_netdevice_notifier_net(struct net *src_net,
 					  struct net *dst_net,
-					  struct notifier_block *nb)
+					  struct notifier_block *nb,
+					  struct net_device *locked)
 {
-	__unregister_netdevice_notifier_net(src_net, nb, false);
-	__register_netdevice_notifier_net(dst_net, nb, true, false);
+	__unregister_netdevice_notifier_net(src_net, nb, locked);
+	__register_netdevice_notifier_net(dst_net, nb, true, locked);
 }
 
 static void rtnl_net_dev_lock(struct net_device *dev)
@@ -2184,7 +2185,7 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 	int err;
 
 	rtnl_net_dev_lock(dev);
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false, true);
+	err = __register_netdevice_notifier_net(dev_net(dev), nb, false, NULL);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
@@ -2203,7 +2204,7 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 
 	rtnl_net_dev_lock(dev);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb, true);
+	err = __unregister_netdevice_notifier_net(dev_net(dev), nb, NULL);
 	rtnl_net_dev_unlock(dev);
 
 	return err;
@@ -2216,7 +2217,7 @@ static void move_netdevice_notifiers_dev_net(struct net_device *dev,
 	struct netdev_net_notifier *nn;
 
 	list_for_each_entry(nn, &dev->net_notifier_list, list)
-		__move_netdevice_notifier_net(dev_net(dev), net, nn->nb);
+		__move_netdevice_notifier_net(dev_net(dev), net, nn->nb, dev);
 }
 
 /**

