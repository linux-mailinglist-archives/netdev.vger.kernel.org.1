Return-Path: <netdev+bounces-177810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5AA71DBB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB791887C7E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF0219306;
	Wed, 26 Mar 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adkxo3/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7F23FC5B
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011397; cv=none; b=QQZGtcu8d4Qwmi08aQyDrtcHBWnzq630EnIqtXv8fzeO4cHzYM2l+WnfZAlVQlIf0wz/j25GO6i/pKLt2IteJQyIYKgpXlhhs9FgP5oSGL5Xg2SsYVCkILnEUWWvHhdatKJsZD2WYO5tyFkTLs5SZAc05op6YWxW/X+FwvhGE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011397; c=relaxed/simple;
	bh=5RgoKlJOKVdsgf/mOHgIax5U6ROL1PCD/hI2QIDcItE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtT1kxCk1p0WaZ5iGQLUR2LTAgdzMLHbTVyOGkELe91b58rLwd22ff0QNMRT/eyauEsWlkzfHo+0y7N5p6l1RB4hKTO/a+hEVFAPiGGtNOoIfIZqPCqYXx5TOlIxHTG6mVDOAXUNDbEMR/pJbOHltzNt2vgrpB3zZktY/FYNl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adkxo3/v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227aaa82fafso4020185ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743011395; x=1743616195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4I072Jo6zXbCYYjqv4PUzgwHZ9ZKJXfV61ZcszZ25g=;
        b=Adkxo3/vEo+K/T/qWHiKb2NvTPaOqLgTgHh4cwCPjKvSMhC61Iub6irQVOz9bVLRx1
         KUcQvUCs38kSXd1kJQgMsAVU/noNce8CjRzp4nNtGxdRuoVcF5sWD7O8ccdOriLJwyfy
         R6ZSM84FXwVOeI0zPXtMv7WOp8wlNPHRoay6nBjqFNwsSu2m4ogHp+fXeWuN0/Ar8I1K
         H46an0scTBOjLysXx+P+E3ewtvkKWP0RSlfgAXZWaZLdotJamRdJJHN6YJX8cWXiQ17T
         5obWGF3QyVDjObgp4a0rLR5rvw0is8tZM1nsyQf2uw/Q+9JBiUDMqLdL+E0nGRe7QoNc
         tvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011395; x=1743616195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4I072Jo6zXbCYYjqv4PUzgwHZ9ZKJXfV61ZcszZ25g=;
        b=URce3T9bVMLLUOBYe0nG9AMxLJTE4RzGTZ6v6NcJzmXRV9R0qWJ9uGmoIw63SBGAP3
         XK8AUx6WmQI4XxiVxJvx800X1vF1VKysEcpBbUyCd4eqTHJdS/7og6L7xHuO2Zklicrt
         b/RMPVIzpcg16UtXgpLMypEg0HTuEY7iTt/1wI39K+hRQgYd62ZjdxWDmsRnvoM29aj8
         qgw11Q01ScTO+5jMqzmJb8sygyqD0m2ezO4gx6cwyXYvDo+0v+vz1sqAICmzRArEGGd2
         qxYjcl1kojDSkDsorrVksBes1rKEbg0wVKZy90I93QNzkcrJVX8x0fXAVMlosOaVKXTp
         qSiw==
X-Forwarded-Encrypted: i=1; AJvYcCUM17igGZUu+NSynelqxQc1h+3YwvOYzy9kRmiaR3FtETzXZvK8Ow1+rfRgQTA41wM+zXSKSoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+09HSQwd0pFLu+tnRzRIz3KxK++vuf5OBj+3BirjNEffLEOZ2
	5l0ArXAwb0W+ij81EfHqoqtoVqq1QlZwyRgPmpxMIRqKyHsuZLM=
X-Gm-Gg: ASbGnctnvzvWApxbcZYjbkgoe+7xuSBRSbhv8OMJkQrsdzUBNWFu0pIg2FMlHM+rawg
	2AOhQUO0rE1JD/M9Deg7/LNDzBDwzJ60hu8Bc75q/oWxkJg6SffGWQvyzWaHhHA2VBqU/XnZAzM
	//ZprwEBQnkMF0GFDol2BQC6cGoT4pyXAc6G7cH4qnAUpvGlXHgexbhTdpM0vE2GI7Uk2mLnJX1
	gYdskNIcPZyLLGMFztFwlwDU0STIK5sxim4VgDq+aP4gKX17WWlJX6FLAG6Lwc8/qZTJTIIY0Ad
	ATL7+cLmXtvG40EaLIlX0ApndDLV0srh7jiXDKbgSgXeLbRlKaAjcdE=
X-Google-Smtp-Source: AGHT+IH9N/9eZ6auB90iUcv4YIqRggnyBNNNdrZjaHu+wHZdLSuh0e2KKO6rHy7pQIoWCmyRmnJLyg==
X-Received: by 2002:a17:903:2acb:b0:21f:2ded:76ea with SMTP id d9443c01a7336-22804913c86mr6835035ad.36.1743011394726;
        Wed, 26 Mar 2025 10:49:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f39763sm113443385ad.10.2025.03.26.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:49:54 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:49:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <Z-Q-QYvFvQG2usfv@mini-arch>
References: <20250325213056.332902-1-sdf@fomichev.me>
 <20250325213056.332902-3-sdf@fomichev.me>
 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
 <Z-QcD5BXD5mY3BA_@mini-arch>
 <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>

On 03/26, Cosmin Ratiu wrote:
> On Wed, 2025-03-26 at 08:23 -0700, Stanislav Fomichev wrote:
> > @@ -2028,7 +2028,7 @@ int unregister_netdevice_notifier(struct
> > notifier_block *nb)
> >  
> >  	for_each_net(net) {
> >  		__rtnl_net_lock(net);
> > -		call_netdevice_unregister_net_notifiers(nb, net,
> > true);
> > +		call_netdevice_unregister_net_notifiers(nb, net,
> > NULL);
> >  		__rtnl_net_unlock(net);
> >  	}
> 
> I tested. The deadlock is back now, because dev != NULL and if the lock
> is held (like in the below stack), the mutex_lock will be attempted
> again:

I think I'm missing something. In this case I'm not sure why the original
"fix" worked.

You, presumably, use mlx5? And you just move this single device into
a new netns? Or there is a couple of other mlx5 devices still hanging in
the root netns?

I'll try to take a look more at register_netdevice_notifier_net under
mlx5..

