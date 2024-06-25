Return-Path: <netdev+bounces-106377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40351916084
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB371F214BF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F41474B7;
	Tue, 25 Jun 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftElq25A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9245145A0B
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302263; cv=none; b=bhpJHj0zIdAD5g/70jwVlXoGM3QtGHBiPKrWn23vZEtGK121rt0OgajplOIP2xiMt6zQqyjSLWNQpMHYeOvTxZy5pDL4bkjPNnQCErRJAMSpgAWAmIQWl6/Gk75OVP6s9btpEkMNCOG5GVZ+HskAHrq7Kta8PPqis2FxOGt5svg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302263; c=relaxed/simple;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGRy9Li00QJOY0kSVBLnieO2VIKZp1027NsoApFTK0VU9nTA9v23dMAPmI09naXwJDoMcNV1PqavG/GvSB7YkYiLS4Amxllfe6ZiNQloUkpmHQRnPF43aFwWOHQjNN6ogwobNETQKStQ9e1qgWgJsFc88+gGDm66ahgRmDQ5Jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftElq25A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719302260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	b=ftElq25AdFhzuY/LmIMjcX/GPsIH/1S0ghEq+37Apx+7GvV17jQ93rFQdq4LWfVN9WUhm4
	EwF2OwGNIPJpwBwLSf9YFceINBdXXtywCL/m1TagpZSEIvdOm0KTnfznBQKCb/kARLtkds
	9bCa/htZ/6Btf7xuhkIB7NksutjIY5s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-c98V6IvCNwmpqVpYYYrT4w-1; Tue, 25 Jun 2024 03:57:37 -0400
X-MC-Unique: c98V6IvCNwmpqVpYYYrT4w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52cdec8a6a7so1794069e87.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302256; x=1719907056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
        b=VnoLDZwR5okrPBUN6FDYX1HRQGFYRbhM35vdu2cLhkYuHLYX8xVAgdeDc8L2CR+kEV
         h8B6RVBtTWy1ETB547cR2NI1n4qrGuZrv/gXYcgLLxOGbOMfTv5R7JMXrLGNkrgUBTTO
         qryB78uB493Fqix7PKt90ky0aU6r6rypoUucx3AlzZfPPlOLXrgAbCo4qPguFHSgQdlQ
         N7qxdhKMZxNAzhCPUhcavdv5bUGELheHzpReBU0iNtVccfvlhtwSM8QIxkd/Z4HthoCg
         qNEXW/KHrgWrTvYSfUTiV9RHd6d2zdmxVXTKfkUBq6sbffOcS7JGD+Bz8JLL4mCZFOXa
         weUw==
X-Forwarded-Encrypted: i=1; AJvYcCWHF8FS8zKOoitCNINBGJS4HlK/iOyhEAc4ktbKncWIaRstQkGeJjB7AC/w21tAGBSzvKHHVOgIaRrQ3FPkfDFMSZQP6Kjt
X-Gm-Message-State: AOJu0YySYAQX/nFmZpwUwPcmzc1KnAJUUoSvc46v4BAgfDvvNSKBTbuy
	WgQVVoaaeUdqo/K+ClPSnwAocHn+cejGh8QLuOtf/xS7ABJNZBjJ6B3SZYjO1bf8MWHh3o1ml3c
	cL33OstpL3/7GXZHoDNpG+0NLbipbOkQ7otRlzPz0KtaC5c0/G9zldw==
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772814e87.11.1719302256145;
        Tue, 25 Jun 2024 00:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtSiI6MnJMyKcIBakFxsAacJJgrU/9spzJO8lG47UPorN5R3MoQXUk1RYI4fQLSyfsKsVUtQ==
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772784e87.11.1719302255343;
        Tue, 25 Jun 2024 00:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191fac8sm160640555e9.42.2024.06.25.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:57:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625035638-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>

On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> Workqueue is used to serialize those so we won't lose any change.

So we don't need to re-read then?


