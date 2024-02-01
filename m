Return-Path: <netdev+bounces-67751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECA844DD3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366A9287213
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CA374;
	Thu,  1 Feb 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uwb2rmq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048AA35
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747354; cv=none; b=NkeD0ToCASWo+nxZ4wghmNnY8cdHpZuqnT/jS982HHbHtMhXL0zIcLJnoNajXVHPJMksCLyNqP94MrDLENWYpbwS1cqMIeclyKup0YP2fOqf0QDjN6/TqlHGg0wyMcWzrCgbb13EOm8ndsSSiXoQ2oAjXj22sIpLwgAPYZwAVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747354; c=relaxed/simple;
	bh=r98WeVKIjH3FW+EALOA3ng6LieuCPZs/iswet0NHsWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJW5soMdZyZg5p5DvSWQveH0+YtOfDKTFfSogL6j2pobDK5kmgLugzX7geYOysetLIQafdyDBvBrzGJ+dOyqDLbp+1jWWoK6qlOeIuOZ6m2WTIxBXb4WPxVYaM0n1OQndgqQhZfHIJe3uS1BSz/jmOPypyqArt+yfw8CTuyQXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uwb2rmq/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5112d5ab492so234124e87.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706747351; x=1707352151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44Ib+Vnnaqq8GOdjfv0UZJ3usenCsoa3lRg9+CYEi2Y=;
        b=Uwb2rmq/uk/lJdLmC5bHZKandYCUViX/jRsBJoTPlvhAC4phv6zLdQdNgxAbx8/36d
         HCk0adBWMmlz87oSsJWL5MJH05KFi+6kCvMRoPVVdnv+k+PdnqodAtBc/PqTFQCFPs4n
         2MICwBvATHN4jPUxtQ0YXc7HqcmQBEjdkCKyd6MT+ZQD5p6DVWnLNsIOi8FwyEggty17
         LA65j2A0h4VcZEi+XbqrExKldVPEotQOgu7O79UEYEye+luzh7wIz/klysy+PtKV+kw/
         XFSdwC+o1sBntlULqIMO/rCMS96be1L3+1rUjanb/c1HdhAGEUnW9yDgi47MppJTBW2n
         85Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706747351; x=1707352151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Ib+Vnnaqq8GOdjfv0UZJ3usenCsoa3lRg9+CYEi2Y=;
        b=oeMltc3gyhiFhgynSEcWsiZkQ7yk4Y2OEWR/Ax9S726WnM40OCJgQOtmCvIGKUmZWQ
         fytVLlmjs0dAKAzSOq6iMLiTvEafViJMyVqRzSvBmk4UfqjemFimIF1TvPefznVuUobJ
         WfLeyW4sl91+vzqdZoVktlxzcuyV9wK8h3vu5vFNLcmC0kfRAPIM/HV/0oqHaMxk/dkK
         uBTeQrYF4RDZC8aqRmN3CPeGDRf6bCBUkSvqTmtA1U1Gz4QhnG0FfytaRyVkIMtatvbJ
         TMMtto6cNaQqGD8zp7EKArICAwcT1toKR7AqsIpFjUqrod8XIHogS4YTwvVOT07Mr5hB
         6L1g==
X-Gm-Message-State: AOJu0Ywl+3B23H2U3SRv78uJ1pLnGkcxg0dAolMYhYeVnkz9ySdav62Z
	9ISAKu0xHxl+MSN6pXoMvV4/82Cmfo9gUx/9FJStiadlyWf233oW
X-Google-Smtp-Source: AGHT+IGjFb0fMAxw+lFvGcJ2rwTwwR0k/LlxjJh1dc1Kush+SVxids79yMzchkvuqx/dmAoCOu3jkA==
X-Received: by 2002:a19:3814:0:b0:510:1879:c86d with SMTP id f20-20020a193814000000b005101879c86dmr481785lfa.16.1706747350214;
        Wed, 31 Jan 2024 16:29:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIMiNPnBg7L12mdcb0hIWX3ULqMoDcJocJzbWM2e66Psv8KB6HTBBmgCiTM+t9Du//yKrjIYOB4chfvjyyQvruUCkNYMRbjirRlAkVCgzMBH591tibzVWXnETdBqwYWGOIjgkHWUa6YB/ktaCqNFU0fpnO/XoA8YObn/95N2pJG1cb3kCUe0uaAifoqRaVdYyczWq46NC1+KA03/9h/71RU/e3XXcCaOgmOW7/ox75UMVqnF8wDwmR58Se6Q==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a359e072fe0sm4361501ejc.145.2024.01.31.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:29:09 -0800 (PST)
Date: Thu, 1 Feb 2024 02:29:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <20240201002907.qdalrmwg6arkeld2@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <20240131133406.v6zk33j43wy2j7fa@skbuf>
 <87a5oltv8a.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5oltv8a.fsf@waldekranz.com>

On Wed, Jan 31, 2024 at 03:48:05PM +0100, Tobias Waldekranz wrote:
> >> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> >> +				    enum switchdev_notifier_type nt,
> >> +				    const struct switchdev_obj *obj);
> >
> > I think this is missing a shim definition for when CONFIG_NET_SWITCHDEV
> > is disabled.
> 
> Even though the only caller is br_switchdev.c, which is guarded behind
> CONFIG_NET_SWITCHDEV?

My mistake, please disregard.

> >>  int switchdev_port_obj_add(struct net_device *dev,
> >>  			   const struct switchdev_obj *obj,
> >>  			   struct netlink_ext_ack *extack);
> >> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> >> index 5b045284849e..40bb17c7fdbf 100644
> >> --- a/net/switchdev/switchdev.c
> >> +++ b/net/switchdev/switchdev.c
> >> @@ -19,6 +19,35 @@
> >>  #include <linux/rtnetlink.h>
> >>  #include <net/switchdev.h>
> >>  
> >> +static bool switchdev_obj_eq(const struct switchdev_obj *a,
> >> +			     const struct switchdev_obj *b)
> >> +{
> >> +	const struct switchdev_obj_port_vlan *va, *vb;
> >> +	const struct switchdev_obj_port_mdb *ma, *mb;
> >> +
> >> +	if (a->id != b->id || a->orig_dev != b->orig_dev)
> >> +		return false;
> >> +
> >> +	switch (a->id) {
> >> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> >> +		va = SWITCHDEV_OBJ_PORT_VLAN(a);
> >> +		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
> >> +		return va->flags == vb->flags &&
> >> +			va->vid == vb->vid &&
> >> +			va->changed == vb->changed;
> >> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> >> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> >> +		ma = SWITCHDEV_OBJ_PORT_MDB(a);
> >> +		mb = SWITCHDEV_OBJ_PORT_MDB(b);
> >> +		return ma->vid == mb->vid &&
> >> +			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));
> >
> > ether_addr_equal().
> >
> >> +	default:
> >> +		break;
> >
> > Does C allow you to not return anything here?
> 
> No warnings or errors are generated by my compiler (GCC 12.2.0).
> 
> My guess is that the expansion of BUG() ends with
> __builtin_unreachable() or similar.

Interesting, I didn't know that. Although checkpatch says: "WARNING: Do
not crash the kernel unless it is absolutely unavoidable--use
WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or
variants". So I'm conflicted about what I just learned and how it can be
applied in a way that checkpatch doesn't dislike.

> 
> >> +	}
> >> +
> >> +	BUG();
> >> +}
> >> +
> >>  static LIST_HEAD(deferred);
> >>  static DEFINE_SPINLOCK(deferred_lock);
> >>  
> >> @@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
> >>  }
> >>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
> >>  
> >> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> >> +				    enum switchdev_notifier_type nt,
> >> +				    const struct switchdev_obj *obj)
> >
> > A kernel-doc comment would be great. It looks like it's not returning
> > whether the port object is deferred, but whether the _action_ given by
> > @nt on the @obj is deferred. This further distinguishes between deferred
> > additions and deferred removals.
> >
> 
> Fair, so should the name change as well? I guess you'd want something
> like switchdev_port_obj_notification_is_deferred, but that sure is
> awfully long.

switchdev_port_obj_act_is_deferred() for action, maybe?

