Return-Path: <netdev+bounces-209973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B4B11A19
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295DE3A52C8
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D22BEFE4;
	Fri, 25 Jul 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXmHflGa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3241DE3A7
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432778; cv=none; b=mZDk41mehojAhlriBHlig3Qzope/DX48ElbMGmymDuzvBtQ9oPfUmBOTVynrBlKWVATYqLsBiNRcDCVMxv8ucSNhDLk+js3IGHc7R4D1m+0oUwDPur7v6dSI3+UsuwUv/YAK2r5GxZ3DS9TqKpPnM70xwKCDGy4Cr7eLqyXiRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432778; c=relaxed/simple;
	bh=tBY0iimkxVoIBYuB3s33dxWd0cIaOYVPs9j9EliKe5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSTKZ85cFe71Ks9GU8XdqpBL/eIP6eWA2CiHpHMIkS7bseui3Eeggu+qOff3q+ydgTRehB/5E80FWlJ2v34agU5hyr+/R06+xhmJS1sAzrd6dyA1oyy09TNl4AQH2/6dxrJnGSGIGYOcYU+aCz9Ab5GXH2irlW/K1WAWgtPZRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXmHflGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753432775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
	b=iXmHflGay1NHXivdZZz0VXGzpSxrQns3ahCyheekzolQjcYRBNLo1pzR/ZjcYq+/Gb+vrj
	qjjAF871dMhToLmhUZb6fHf9utkdimHMFnNcW3UVjf6d6iLNF8CaQ72Ac+gEB1aP5+QtOu
	5+LNypxI7IhGdu2neFX+xJAyP+MQ38I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nhFYH0p7OwO4vb9ILB-nog-1; Fri, 25 Jul 2025 04:39:34 -0400
X-MC-Unique: nhFYH0p7OwO4vb9ILB-nog-1
X-Mimecast-MFC-AGG-ID: nhFYH0p7OwO4vb9ILB-nog_1753432774
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb50d92061so28917416d6.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432774; x=1754037574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtiFyoZfZGgkbcgP/8jfuIG2d1G6bK99JX46EtJwAvg=;
        b=jW4/r4k0W4iGzVZ9R3EIdxiAmZ1sW4waDSAxTD715mQDBmqrfijRFv2VXVwrl/Onf9
         p19sIgFm/Xw+FlziwyceNJnKlXW6NWsEvpgdpRA9bj7SNzkUWb+oAOxg65ihpUvHEOeo
         q4S5GRnYySYl5yk0cHGG3Yfq79B3yKIlFtH04skEMjx3UODT3UJstGwTsNtfaFkFCOIX
         9lkdOs12HmXBeNnbJxcNcL9g13EA1u0ZS2TQgXD08gNr8EjRWB7kM2CgITXFomSwE1hg
         +e5D9qXHW27J8eHiNr+zQTbc6fzjWbGwx/bzyn4Rjt+qZeoI0Gs27jxwjx4g2mmsKffs
         TNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2ap9/Jf4lYocOu6WRQu675V6GUtdYCHpSgaovPNhagp//fNH6TEBgpD03t4OsQ4PsEJ107A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VmmZgDEAjh83LjMdVCmknZzCxby6t8J3bn7VncLSj//YUC9f
	tvt/XZfc0lon3wyNSSl9YIZ+C9skPB4oBx1QS8uqj4YUGMRTYqRJvv4DIIDiwGtMXGyaNC2yExI
	qIPVzbpRmkIi9xeQsR11nzeGsW2yVDlDZzgYMiZZWCEY/bDsfmyppjjACfA==
X-Gm-Gg: ASbGncvPlzVr7CBwgVPufoIxXA37tN0H0B7RsDTryKrO122P0YROk+hAfJvq2ucWjck
	KoA8Kx436S1SlpYMPcmd4rpoNDfJsn10+n/+JIuq2HcpsQKSxgci/RLE8biHAGZYFy69t5o1OZy
	IyLKvFuBo2rd1GFrT/g4d9lwGJD/h9VdjL0hRpMHjnZ5sBzYsa/vGeeq1bB2q4E3Wje7+jMJKyS
	vHPVjZL+q6Xka8NVaYtEWEt/6FMTaz0cr95G+EtcQvK6AJwX9Vc0oTfbCMEbLtvLevJYeSWFW3V
	Ah+Zvv/j3XcteuJSQPJjc+ruG6yyy4rqglvKqeCNd6XuB3bpS57QRXo59I5kCFKvCEdDnhN5s1b
	BIyQXj2BklPvFaaw=
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797386d6.7.1753432773691;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuvrU/iDku3ReNmbC6er8A+AX9lbZ9M1ZVZ63Zo4Y0gnCBIubTMZ5l4qHxguWAFRNt5SjA+A==
X-Received: by 2002:a05:6214:242c:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707204dceacmr12797146d6.7.1753432773224;
        Fri, 25 Jul 2025 01:39:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fca2189sm24242566d6.62.2025.07.25.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:39:32 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: remove unnecessary null check in
 vsock_getname()
Message-ID: <dqlpaa6nczbjmf5agbjktmlzu2avgnqjmsuisp2ic2hsvgxh7a@ruhby5c6lcbn>
References: <20250725013808.337924-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250725013808.337924-1-wangliang74@huawei.com>

On Fri, Jul 25, 2025 at 09:38:08AM +0800, Wang Liang wrote:
>The local variable 'vm_addr' is always not NULL, no need to check it.
>
>Signed-off-by: Wang Liang <wangliang74@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 5 -----
> 1 file changed, 5 deletions(-)

Thanks for the cleanup! We've had it since the beginning, maybe some 
changes were made during initial development...

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 1053662725f8..fae512594849 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1028,11 +1028,6 @@ static int vsock_getname(struct socket *sock,
> 		vm_addr = &vsk->local_addr;
> 	}
>
>-	if (!vm_addr) {
>-		err = -EINVAL;
>-		goto out;
>-	}
>-
> 	/* sys_getsockname() and sys_getpeername() pass us a
> 	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
> 	 * that macro is defined in socket.c instead of .h, so we hardcode its
>-- 
>2.34.1
>
>


