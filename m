Return-Path: <netdev+bounces-241332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E6C82C01
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FC5834AFA8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFFC2F7456;
	Mon, 24 Nov 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPMIj3jd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE2USDwD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625B2F6922
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024868; cv=none; b=FObV543iflsupe7O1Xyzt7emzH+i5L9cQjcRQKnYnbN/LSRfWuQaU76kJS/BixErVxLtPU04EnnZkKTyEWPwWO3IImBgBeBVqzSdfoLaoZJJC404A+2vutPDMNDEP5ZCBpF6YUJvErjFTY7B70Hxpp9se3exruJXYYwPamNPLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024868; c=relaxed/simple;
	bh=26+QtX65UOT4HCp+EVjCEV/pYFiVKrU7/EECqOZouOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBfsCpIzQ1TeMaEUq1t0MlT0TO7/c7H0bIIgtU+WgZJw8L+c2vm267g4ss1e+RzPFraXwr0Xwf8GvG4jo9p7s+o4klAnvm8OIqXtph+bwBzKqymyncnbdGtpIaWOpOoi8A9Vj52a3aPMDMoP3V3qut+ldCEEc05pX7/74SBbG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPMIj3jd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZE2USDwD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764024865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OetEkTOE2F/5xzSGTfF4kqvBotamRkDb8AG8TB2+1l0=;
	b=cPMIj3jdxzw8J6dtMmzl7bxUEUfejGN8FhV50SEWTL47C8dUQ217zrOI7HrR/7zT2tQLdZ
	rd/wjubUbjt8Jr4QE6qma2wUbYSouDE/zJggBHXFDbsbtNAbBQ4/Ib7EDAaNCiu5B633jM
	McaQcRiKQZYVTgks6dlC5Geye5vGh6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Sn_waUchPxSnLOX3zkffww-1; Mon, 24 Nov 2025 17:54:23 -0500
X-MC-Unique: Sn_waUchPxSnLOX3zkffww-1
X-Mimecast-MFC-AGG-ID: Sn_waUchPxSnLOX3zkffww_1764024863
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106720618so61929965e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764024862; x=1764629662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OetEkTOE2F/5xzSGTfF4kqvBotamRkDb8AG8TB2+1l0=;
        b=ZE2USDwDfzXjRwUWB4VyudBbC0uoOnHqKnakj2U0ukpc8gpgRoYiQs2fQEkHJxJkaf
         rTGEB/Hk5EvWg5cTLUsdks8sPHZvtvVlmYZd0wXcn4Kbh3jfSQC6o4o+GTsSGRAlXpth
         hiXvDjSK9E6xNKpo6Are2fKmW7gdoleQj/Fzxv0vaQTii1oLwvaI58o4kpOJs9iPfz9x
         Nrnurh9kPYlJ3q9ClPnb3egDiea0jC8szFtLSgtxLqNS5lzgNY3w0luPQGX9l2th6Owb
         dnPVlSTz6yTRNRGbqA/qj6xpSSFiZK/I/948swlfEYvmk55z5ompkBgDB+XcNvrr/+wJ
         PPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764024862; x=1764629662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OetEkTOE2F/5xzSGTfF4kqvBotamRkDb8AG8TB2+1l0=;
        b=np/7NzAHiOTmZcFRZWL6F0VVq3vNOxYS4Rwf3Hsot0HgdLeGtXr1q2B6HZJvR95FEO
         J+NYoW69ciG2tWsAMQOM1JQGEDph+Uofpcs0wTrd0v2QXeoROT8j9Gw/o3ZNGRpwg+E6
         YBPUzlU4jYUw076v0CYTzyH2/0eOQ2MvguiCZur4RwLAI7+/5LRKuls64UsIq8uPxhz8
         /hyuwbWPV5xFRrXBoAAFzkOp5tpsFXYANTITUvoSHn10BJbOMJLHWwd+CQQ6AwlKhA6p
         FL84zoiDjLsYNB7L9m5Bh8BH8/3O05Ca2zJsaJnUtSTOa9QwPhQTMlfbHNVpxKkNbHW1
         oVsg==
X-Gm-Message-State: AOJu0YyhWxi/stnAv/5xaCT03la8s1nc8EMbQF30cyMYIfMg6009iH33
	QxKOjBDfgbAtzec2e7xNQVPfc1/qY0t7PuzFop2ALantcwOWxYpoFjUlPjseghawUdzCEbbIydG
	mfop76Qfw9B76Iv0RitUQp90XKyrJjCxuHvI/BfL6SL+961VyU+vLkXnlACCvxH8FmQ==
X-Gm-Gg: ASbGncuRUS/M58MIToL/TwAV/3Wm72wYeOQIa8VxoaeQtD8muavF9OtNLCGBCmniG37
	yL/IPRi7YklMOCJfATU6fo0Y1IqSkRCihtsMEl0e6PCmSEBK+G073UDv1D1N5ZytbiLvineUnAv
	s9qgALTPWhVu9nxAn+OZHA3rwSR5jLNhkMHxQb1QQFd6P2CIZPREmCIzyjaifTc8adYHMAx2Lm1
	vbHLtZDgzpd67xxDRif1XJuWaCeipIPZVkmV2oCvF6qKZR2V4J7+vu9ClubDKhp5YL7nUhdBv/C
	hKd1RxfR3jaX7jEh5ZSTgoCu9jjXKYeC3gGKLbygeTS/tOOHUR9hHruXx1sfweAfqzM4/DR7LL/
	3oAHGHSnJthKuh12aiNfLa5fz+0Tl5g==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr131520175e9.26.1764024862547;
        Mon, 24 Nov 2025 14:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjVw7J+iRYtg3aSk8SrQHBFx2JTGamtrX0Mw0WmcZxEeVR9ryRRvIYOmP8j4+NPfDD6CsKZQ==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr131520045e9.26.1764024862148;
        Mon, 24 Nov 2025 14:54:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm228563205e9.0.2025.11.24.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:54:21 -0800 (PST)
Date: Mon, 24 Nov 2025 17:54:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251124175247-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-6-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:16PM -0600, Daniel Jurgens wrote:
> index 4738ffe3b5c6..e84a305d2b2a 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -161,6 +161,8 @@ int virtio_admin_obj_destroy(struct virtio_device *vdev,
>  	err = vdev->config->admin_cmd_exec(vdev, &cmd);
>  	kfree(data);
>  
> +	WARN_ON_ONCE(err);
> +
>  	return err;
>  }


The reason I suggested WARN_ON_ONCE is because callers generally can not
handle errors. if you return int you assume callers will do that so then
warning does not make sense.

Bottom line - make this return void.



