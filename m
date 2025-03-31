Return-Path: <netdev+bounces-178309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745F9A768F6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0248F3B2CF4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C621C9F9;
	Mon, 31 Mar 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="SyRK28Us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F6219A91
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431882; cv=none; b=urjvQubxG6MtL4xkO4UinmZWU6jQzd60/z2UvMULbQOQVidPk123FnhrD9VOwByr4j3h+yIVHbiEZnFocsrmvZjoHwWCHbhWI9RrVp5ZG8U/cRVbfD9pUBz+G9jU5wiWCzJqK53P2WVt6QS1pRnLkMv1VJE1H8ntXdDv/1Lpv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431882; c=relaxed/simple;
	bh=5GuqQsOBQ/wettgqlG9rE0MePw04dSg//SEXlT2WjJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqggZSQ6/7xOja4DESaPwwIlgbpYXUeBnKQ81z41C+PFNNy1OvoemBM4mB9YXgdT1yGcO/qSspZD2sruqNeygyc780PWbRU0iq6Qa8jjEaw50XSXEUO/NF20bOHf/QL3UWWgLvzuJdOtyJ3D5rFyD8Q151taGEPrHJS5NgBhLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=SyRK28Us; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecf0e07947so41991936d6.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1743431879; x=1744036679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE/sAWU5nCw+S23T4Bkv3/flGqA1IFUngSA9Kn4PpRQ=;
        b=SyRK28Usi2ArIPgB99vM7d1JJ+bQ4eTWtb1vo1NVitiiGXyLWmLQO4Ga7n1pVl04lN
         yxEylKVUuwuRM70nTBGy6kp1TCSJ0SkRgq/k/wuelsS106INVH5AujvZswMQ52RmzCZI
         4uC1MCU5LfG0eLguZn1nc/zbeLaA/7w0gABKJvvo8MP9fpx6pvA7EPvgSOHhm+iZDl71
         4vMGzmI5cYL6H9N6h1CODJpeI0DHu0VCoK5Hpeqmkns8WWTyJXRO5chy8MvIigZFuZQl
         xHdH7mCy+1zKSacW/I9Rzri2qeJh9kk+nIum9AKrXotb6oJUCHXhcho7hSnnkX3RCbs1
         ra3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431879; x=1744036679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE/sAWU5nCw+S23T4Bkv3/flGqA1IFUngSA9Kn4PpRQ=;
        b=wQcyf7IjYJLzupf/xF2Uw4bsunpNnjily4LQkBrP5eZfg33CvwoKSFXKFePD4i8YrI
         8N5jr+/BpDtufv7pQYV1UTJ7y7ydHs9zFDoabp23HUJuGcflsLDRv67ZsNbAriXUHiDh
         qgnqBRfafZXYWJEWmo6lnnQsxIFiOeRbeOLs4WW74mGOrkgX6rCTyrhjDS/sFui6LxX/
         hTBmusOOMpyhECfl3IVlPCE6qjBcxGB72cedsmXkv9OxB3ijvPrczn4+sWEinlZyaFQ2
         ffAFWc14pwzzxrJg0c6LXytOAAxVU+7jYg3GKG0gqEXpXLmZR+wibGAgZL104h8nPLDv
         +W5w==
X-Forwarded-Encrypted: i=1; AJvYcCVyTdE3hIwE/VrfPlOUHqImYGM/2Z7pKHW3doPui+gQkMtID9O4nVkRLpzumw0AE/BQOeY04h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUa6acWAfEbydlveyuLnojnh6Y7vtV5vuOerKfIMW8mapqF9Ug
	ObA+8wBMqIASJxAlohvelQergKUe/2wZhE19l+52ySkK/6tnOZJ/PRcHGSb7qw==
X-Gm-Gg: ASbGncvcQhP0mJa6tQBoi1N9P6DV+pm9p1qXrHFQ67cDltsaC5F6euEPyqS9clNi1M7
	81+9jucTlTL31sKaehCgSp3yrkwlao3Zsrm3OBqZK8oDiCLlUCd2ROSUe8BGjNl1zir4+MQt6qM
	DTr/8mzxS3Cd+eimdO5Ookh0AqgKKV+DZ95PsA3h7uy4OvOHylR6Zj1OXtUYqZAPI7sx6/hQZAk
	3wfLSbRClroDUVpKPgU+mDZlqNpfq8hBONFnkhQFcmA1b5bx9CvyAq+h/5PWVtjAp2yo45SSHno
	mJ8ajvbA951zttVfmRCLKvI8y60yRzYT2xsHUgMCci6EaA8c0EtlPWVS5oYoZiw=
X-Google-Smtp-Source: AGHT+IHE+whbE87lsI1UQ/QzTdYVOSsbIWuODpn6hXAsvKFRJxfvxGSxHa3ir5a/Dc5qV7S2oJPI/w==
X-Received: by 2002:a05:6214:1252:b0:6ea:d503:6cfd with SMTP id 6a1803df08f44-6eed527fd89mr124796916d6.19.1743431879146;
        Mon, 31 Mar 2025 07:37:59 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768e744sm505959485a.48.2025.03.31.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:37:58 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:37:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: gregkh@linuxfoundation.org, bjorn@mork.no, loic.poulain@linaro.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] USB: wdm: close race between wdm_open and
 wdm_wwan_port_stop
Message-ID: <1fc14a6e-c77e-4030-bb62-6f6d5bb18d63@rowland.harvard.edu>
References: <20250331132614.51902-1-oneukum@suse.com>
 <20250331132614.51902-3-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331132614.51902-3-oneukum@suse.com>

On Mon, Mar 31, 2025 at 03:25:02PM +0200, Oliver Neukum wrote:
> Clearing WDM_WWAN_IN_USE must be the last action or
> we can open a chardev whose URBs are still poisoned
> 
> Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/class/cdc-wdm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index 12038aa43942..e67844618da6 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -870,8 +870,9 @@ static void wdm_wwan_port_stop(struct wwan_port *port)
>  	poison_urbs(desc);
>  	desc->manage_power(desc->intf, 0);
>  	clear_bit(WDM_READ, &desc->flags);
> -	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
>  	unpoison_urbs(desc);
> +	/* this must be last lest we open a poisoned device */
> +	clear_bit(WDM_WWAN_IN_USE, &desc->flags);
>  }

This is a good example of a place where a memory barrier is needed.  
Neither unpoison_urbs() nor clear_bit() includes an explicit memory 
barrier.  So even though patch ensures that unpoison_urb() occurs before 
clear_bit() in the source code, there is still no guarantee that a CPU 
will execute them in that order.  Or even if they are executed in order, 
there is no guarantee that a different CPU will see their effects 
occurring in that order.

In this case you almost certainly need to have an smp_wmb() between the 
two statements, with a corresponding smp_rmb() (or equivalent) in the 
code that checks whether the WDM_WWAIN_IN_USE flag is set.

Alan Stern

