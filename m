Return-Path: <netdev+bounces-167608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972ECA3B081
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 05:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815363A61A3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249561ADC90;
	Wed, 19 Feb 2025 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+r8yviz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFD19AD89
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739940899; cv=none; b=GXbCGs4TUULMOv8iKjoU3SZqQZ1WmAh5mnnVy0aVtqYjoJUIkDpm1XeW/wCY9uOKbubcs8V+7/RgE2I83LNs3nSd6AWrxvcMEIzqiWzaHr7Sul2hg96dK1OiKFAuohwwecj+FoMFdunY7IrUN823VISvhpJy4gsj8NLfGi3rTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739940899; c=relaxed/simple;
	bh=lLnzIAnvhyZD9MaTtFQD2WioT9PVJeR4O0WtZBfWPw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck18aG84lnzqwrZhictNBOgwWVWOPv7iSgpfUQXiWyYNkONG7qTd9wZdPzp/Rrm59RzN/LCjrE1qo/msvzh5ey11/caypL7uUfk8SIEHJaWQspUfuqbtH8lG/lKZkxH32+vDd7Z00Zexn3rM6HinxKgi4vhv2FcErwu7aH4HXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+r8yviz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22114b800f7so61415905ad.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739940897; x=1740545697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypALkMvv9FItppnqs2nIJ0OHPXF90HXfPtp2iB5MkCA=;
        b=B+r8yvizMbu8S45wIbaK6DYB84iWom6rFqMN0xElcJhaS+JFTmTez1bMYi/7reYjpp
         HbDCfe+hCEJIDT/kR4EH95qf9H2KK4VPQYbKRVJr6oAPKHi128Fad/WS1Q5K0/MiNS6x
         CbBKaXZ4hln+UHGqsQGNhWMnOWNiN+heG/KORfE7qqOCWjOcfarRzKkvMbVLMnTBsC4v
         g0tbz4Q5CHOnEEgiSe5xiAIz2WuzLAKj/PscZMIKrv2zzCu8FwomWJrqgp1wKTL6zXnW
         MEcU75dPFbsDLFlKhuiSJscA2cBnA2JPygrwx/V2+QQKocM/JQtFV40SCnDDrllTFUqe
         DU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739940897; x=1740545697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypALkMvv9FItppnqs2nIJ0OHPXF90HXfPtp2iB5MkCA=;
        b=AfWgyDAddDQjIoMB05J7fKimlg6Gts8J5ldt20ovHK1x065AmXlk8FPHwq0gT1Zk6H
         CNEK8TIYXPzASTYRhzbsS2+W0izjyEMSeduVZaV3p0q8p5zsSoYOaHsWnbTfUtnvwNxs
         OuuvPzFTbTAKGqRy3EhQ1CNPvmKvZYEIxHfbJniFaOV2GP04WSVhvdvnB16cIVSTQtS7
         4Zj9e8k19ZrMusFdeC/ZHE/LH71ulI10XchvSc7tgsD4SEL61Z5hC5v99ANY0uVhcQPb
         boDPrQ/3PVK0duis1zw/r0q6oisvuoLvQH7+XZJgFB6yO/Jg8MR6bYEpgUjktduCZq5Q
         0VBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfT/hIwDuAbL8GK4ZisDDUKePdgVgWNkZS+Y9wOTUtpBKlvhqNztzJ6oUxYC46e0Csu8HZu50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxjRE9V/Eoy5uwOIToDpt5WVBldo+Mu+YLa1MHFNGfh+03sI5
	wH2Ul3jcIk8hWdr/RDiWLfIUGnG7/utdulyCp0Yd0WWCQ21n7Oo=
X-Gm-Gg: ASbGnctANFGvroWKx1J9X8NKblmmRP+xcX3ZRytWD64TrOYVkcyz9wzGHftbiwFb61X
	88oxLuopK5X8P9TdNH/Hhi/ljxVhKYT2g5zDFy9Nb2DkzgCxWTqsFPLDEIKNzFIt7WDKfoesnyD
	kTFhhzAmWYHHDiV5HxepacOuSZhFisOd/eA7fKFQ9u2NAPUNSozYkRxMTO+f7mQtb1z71DVTFdF
	qh3a/M5Nnzcjk9XFOOtsxmmChiosguzzjv09ajm0sLc8XSsCkmdkdQYmee1yH5EBriMo/lBvcoG
	JfVoYJ5XHphYHdM=
X-Google-Smtp-Source: AGHT+IGtkw7lJst0Sf0wnLjx51MCOAFJ9a7O54wxRmtniA7XYobPxYZoLK7F6Zutz4WhjiseLgil5w==
X-Received: by 2002:a05:6a00:816:b0:732:56cb:2f83 with SMTP id d2e1a72fcca58-7329df01376mr3187831b3a.15.1739940896742;
        Tue, 18 Feb 2025 20:54:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732547af8acsm9114973b3a.71.2025.02.18.20.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:54:56 -0800 (PST)
Date: Tue, 18 Feb 2025 20:54:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 07/12] net: hold netdev instance lock during
 ndo_bpf
Message-ID: <Z7VkH56cwF8u2RjX@mini-arch>
References: <20250218020948.160643-1-sdf@fomichev.me>
 <20250218020948.160643-8-sdf@fomichev.me>
 <20250218190258.5c82026b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218190258.5c82026b@kernel.org>

On 02/18, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 18:09:43 -0800 Stanislav Fomichev wrote:
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -528,10 +528,10 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	bpf_map_init_from_attr(&offmap->map, attr);
> > -
> >  	rtnl_lock();
> > -	down_write(&bpf_devs_lock);
> >  	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
> > +	netdev_lock_ops(offmap->netdev);
> > +	down_write(&bpf_devs_lock);
> >  	err = bpf_dev_offload_check(offmap->netdev);
> >  	if (err)
> >  		goto err_unlock;
> > @@ -548,12 +548,14 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
> >  
> >  	list_add_tail(&offmap->offloads, &ondev->maps);
> >  	up_write(&bpf_devs_lock);
> > +	netdev_unlock_ops(offmap->netdev);
> >  	rtnl_unlock();
> >  
> >  	return &offmap->map;
> >  
> >  err_unlock:
> >  	up_write(&bpf_devs_lock);
> > +	netdev_unlock_ops(offmap->netdev);
> >  	rtnl_unlock();
> >  	bpf_map_area_free(offmap);
> >  	return ERR_PTR(err);
> 
> Any reason for this lock ordering? My intuition would be from biggest
> to smallest, so rtnl_lock -> sem -> instance

From rtnl we take the following:

rtnl_newlink
  rtnl_lock
  do_setlink
    netdev_lock_ops
    dev_change_xdp_fd
      dev_xdp_attach
        bpf_offload_dev_match
	  down_read(bpf_devs_lock)

So I made bpf syscall path to look similar:

map_create
  bpf_map_offload_map_alloc
    rtnl_lock
    netdev_ops_lock
    down_write(bpf_devs_lock)

