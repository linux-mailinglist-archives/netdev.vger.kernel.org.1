Return-Path: <netdev+bounces-137570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB09A6F62
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3091F25FF3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421C1CCB49;
	Mon, 21 Oct 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ23pET/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27341CCEC8
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528072; cv=none; b=KbNLTt7deCuZ3hQbH8S9KEGXO4mYC3aX71RkjtVNcZlG/+J+beZm5WTUK7e84KOIHZkXQ5pRx/VoxuORXmsqG4DYakzRk8AWvHZsgC6V6C1Ig5LjauFJ3H9XY7o+dSF2IqssjL2c+ewCY97Iyc3M6G0DbNXObDJvk6np8yIwf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528072; c=relaxed/simple;
	bh=ng4Fd/1eXm21KjZGx0nNu+fVA/U+EZvgbDIonKK4TTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvmUKP4ebQLIAgmiWzA0orMhm2ub+tdIveNRf2CFNPv4Y9kagA0T1jg4Sq5kax80nBDZJXtmThV7yMj8oNESnLiZE7tjJN+7UrQazYhnuYkp/vujXgLmkXKcaBWuEWKpsxaQ0Y9JTMDeo9GypO+0QzlREoFKt/mFsxpmK6h1jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ23pET/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729528069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTDxXEF8TjHAORp7n3Sf58mbRFCPldS14PaLA/YlNHg=;
	b=LJ23pET/ko9SOMKEHqlZO+OEw5LtJLGC2kczBUXawBz345VZRGPiu9hDRM3l+EqOR4zvS3
	V1bBjRnTgWPrZPPQ+nwJ8E4GZlzTKpyxDmKQPiSF4FbvS2Ti5ynd1TLUlOl4o8erUlT03K
	r4MRyS/nzHWtRfzHyiLJfxXiE8ElHaI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-t6Xp2pWXNrOpCsbUQIM5iQ-1; Mon, 21 Oct 2024 12:27:48 -0400
X-MC-Unique: t6Xp2pWXNrOpCsbUQIM5iQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so34536635e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528067; x=1730132867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTDxXEF8TjHAORp7n3Sf58mbRFCPldS14PaLA/YlNHg=;
        b=ZVqHi3FL7tvDF0dE3wgXn8DwaT+KUVYWEWfHPbeT+uDYSzmQ7bwwzITj23uu/SXOPT
         +EFR/10DLiL87+W2xTe28+WUEEJdgzwmX7niHZLSJUva144kX0q9LprtyQ39kRgAUB0P
         S6Zz+2UbCLj79znkXwx6RAkoTOW982fRpXE1iw//R7NtkKpWan/iUPRwzwbGOlZHRVPv
         hLN05tFuB1r+vRA10wdRcAZImWG44gPcUr6ufNzXOEo5UxTWc5TKy9hepD446w+8db+5
         0V1rx/a3ZYgkoiKbxyGkapfRjTXVkRWkZT4C7XIzDsA8J7K7CDObHBwL4cBQjO/AXx3D
         kLjw==
X-Forwarded-Encrypted: i=1; AJvYcCX4fcBh36HFRlT12GOrgtUewN2Tt1UJBzEcXSbwIcPSLn6+jWPpE54ZVh9M96Ap3gHoAieaBc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqyDHsrsjlkxB+nfNmt1LwitCf63locWkwdF5dPNw8y2mpJv1
	th2HORnvaQgd5sVfGFySpPNsGa3ab4PU42hMAg3O3sF5KHhP4pVvjLWPKdGxhmd5zUMYVRIMgfd
	94ffa0XkzpV2XOLpoHXo0wArS4Km7m0M2ozHnw4gpSvfFTksv6J0uIQ==
X-Received: by 2002:a05:600c:3110:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4316169ac06mr96399995e9.25.1729528067187;
        Mon, 21 Oct 2024 09:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSI/56QMnJyhwqWOYstEnbLNMAgepug8Hr4wC/KvF/uwvrNQxqtSy1YQTxoGG0Smjo/CMklA==
X-Received: by 2002:a05:600c:3110:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4316169ac06mr96399795e9.25.1729528066798;
        Mon, 21 Oct 2024 09:27:46 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570f89sm62079325e9.7.2024.10.21.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:27:46 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:27:43 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
Message-ID: <ZxaA/6zaqgbrcHX/@debian>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
 <ZxT3oVQ27erIoTVz@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxT3oVQ27erIoTVz@shredder.mtl.com>

On Sun, Oct 20, 2024 at 03:29:21PM +0300, Ido Schimmel wrote:
> On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
> > The vlan_qos member is used to save the vlan qos, but we only save the
> > priority. Also, we will get the priority in vlan netlink and proc.
> > We can just save the vlan priority using vlan_prio, so we can use vlan_prio
> > to get the priority directly.
> > 
> > For flexibility, we introduced vlan_dev_get_egress_priority() helper
> > function. After this patch, we will call vlan_dev_get_egress_priority()
> > instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.ko.
> > Because we don't need the shift and mask operations anymore.
> > 
> > There is no functional changes.
> 
> Not sure I understand the motivation.
> 
> IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shifted
> and masked in the control path (vlan_dev_set_egress_priority) so that
> these calculations would not need to be performed in the data path where
> the VLAN header is constructed (vlan_dev_hard_header /
> vlan_dev_hard_start_xmit).
> 
> This patch seems to move these calculations to the data path so that
> they would not need to be performed in the control path when dumping the
> priority mapping via netlink / proc.
> 
> Why is it a good trade-off?

I agree with Ido. The commit description doesn't explain why these
changes are made and I also can't see how this patch can improve
performances.

If it's about code readability, why not just add a helper that gets a
struct vlan_priority_tci_mapping pointer as input and returns a __u8
corresponding to the priority? This way, the /proc and netlink handlers
(and other potential users) wouldn't have to do the bit shifting and
masking manually.


