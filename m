Return-Path: <netdev+bounces-240180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3543C71066
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 21:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 551E0293EE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3E730FC19;
	Wed, 19 Nov 2025 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7OpbVpR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpibAmbI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B52248A4
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763583761; cv=none; b=RaohvJe9PzLUbHsQ9aQ7VRjCd8Nj5esin+DHrEcFO59TAWBiIB/9RXAPxQIsYTKGiNNgOd1//V/BlavG7ttx3mfP4utn3OogaYo4kYi9rz3sJY/JHW5/NXhZA3fjJUJkvTOgyIZN2JJbjhDa2Xk6r9MvIvYJcbLTI3AzPcD+NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763583761; c=relaxed/simple;
	bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA14Jem3eftNPPvtUXrsjKiaphKbFa/Wlot3ML5pCwldvf1ZygdQdrxJuRpeCB/8J6dEUOCCuaHtD1WwUlpMZRoaedHAnrUt64EvluEtEKTEJW4SsDFjZNUM14opigH7UCrdDZ9BUzMgLB0LJaTU/zoVlIsVQcnJOrxrpl3xOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7OpbVpR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpibAmbI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763583759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
	b=a7OpbVpR22gPxN8gh9XaMaDITKs19fCWzcHsIXtiQ8Z1NmeDqcE+RUzHXGTUd3GOZbXAU+
	WSU6SBIO1r3EFUHu6+4gRjOfy83ki72xpu/IcZonT6J39Cw2IwbcPYCuN2lap7sQj4mEjA
	5Hm6O9tPUcHWEYABVxJ5+AGjc3/SJ/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-gCt3oWfqNWuZDyAcjPvEhg-1; Wed, 19 Nov 2025 15:22:37 -0500
X-MC-Unique: gCt3oWfqNWuZDyAcjPvEhg-1
X-Mimecast-MFC-AGG-ID: gCt3oWfqNWuZDyAcjPvEhg_1763583757
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so2333775e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763583756; x=1764188556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
        b=NpibAmbIhAzM6kAhiD7ejnIJeQHWFnIBc9l6lPUukspZpwPezFyetf3492xJN1Z7+W
         4Me2EYZHzXM0C6d8X8yHypKZILDO5t8aPZ4PqEijGTSGzmKHqqH57QQd1ciQzzOkWwF4
         WHLZw8qLjyxyln4H6B8ABvWcQzYPtG5a4UbGQDKq53cZPJSyLLrTvF7P3hAR9gBJpl7F
         S0vEIvOqvDAvz7VWmtpGHhIM7x7gL4y70qluiqpEaNdwPf4cllw9uDC+q6tAMM12aEvB
         mnQ6W5W5mdH0HX+9B+2eSzSsehyoScHJNoXnXHX4zIdRfKhcLf6aCd6O3wOsnm508UkU
         Cv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763583756; x=1764188556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
        b=OWUWA4et3aQDbRrEXMoEykgSzK6Z+y8omf1XAYgYrxIX9f7t/s4e1z5Q9UedoQISKK
         calKzB7a1EeZ3hsuu7RFsxBiwZTWqLTPfjk1BiAmZH3mOdMF2SCMm9JnB3Mxj0wGr52u
         WfMtQA42zvxFijUokbVag75FSNjUSEYSA9cawLpmRoFUf3qV6tKhXRoADGBF0NyR37Je
         fdcK1NCBPPjse7IprKYZwZ2HL8wjYvXuZJgtCKCKe/g870FpzakHm18Wpxk2On+86Yr4
         bTXPAF6gOGg5Z1ffeIIKa6QaI5GZjqFcogXf16hZOkxWguIMi0ucrdvRe+giBQFGXVLO
         vzSw==
X-Gm-Message-State: AOJu0YxJIrWrZU0J2tLBiQ6r5pESj8MU8BI2TWMUQi5jb7EjUrkrV32c
	BerctexvrtaQOJPS4ZjoVsCEOG1ZB0YS/oskI9BIN8fhNTPWWQ5uw8UqF1wFpWuJaneDXQQs2OF
	mzYFon2ue35uMkTCzXefm60PEhzHq+JocWwhfjnKVHXYYPtkL8fUT49a8qg==
X-Gm-Gg: ASbGncuEeaptfw9+JwS0WFjHya5+oStcVjMU8bwmwTTtZnx96J+HNJqvajESAwPTILA
	Bxb1HBfDFOaBAtoeV0anVwUyjmrTOuPv9b0tySreCJr3qH0mfAAK7sM/+j/JJoe7g7RWXyQyV2i
	9ON6SUYtRLLtvUw56IFfwPU7i7cZUut3h96OMJfKg/Up+mTLQrnPI3+O5xmA1/lOF2F1LZbWtC9
	+WSsCvQKrD6Mx/WDmchecv706QoTRhCy/B/VBxD98UPnKVe7OPDmCa7+rrmtSKVGK3MFCztQCst
	UIa3zyWtlT0Y8/T/o009ZKaRVfWLb7K8deIRQJGVw9HXgP3avthocL25TpSr/mqU6AjIoN86MB3
	ui2GZTql85dyQatLE5+Oc0cpVEd+ZhA==
X-Received: by 2002:a05:600c:1c16:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477b8a90b69mr5239515e9.24.1763583756392;
        Wed, 19 Nov 2025 12:22:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv7OY/eeh/eaCRC0mGOzH9PPH/EZSDaI5JiPGJFpcL+zSbxL7SPGpS4v2uWECCiGLjI0pkxw==
X-Received: by 2002:a05:600c:1c16:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477b8a90b69mr5239305e9.24.1763583755891;
        Wed, 19 Nov 2025 12:22:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a96aed1esm50247745e9.0.2025.11.19.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:22:35 -0800 (PST)
Date: Wed, 19 Nov 2025 15:22:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20251119152206-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:11PM -0600, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

traveling, will review after tuesday. thanks!


