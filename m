Return-Path: <netdev+bounces-116166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB839495D8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6BD281ACF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD313A8CB;
	Tue,  6 Aug 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYqf8dqc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A52EB10
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962761; cv=none; b=BfY9M3hhXBKvkifmlbjaareKTWKhWAqxKR96k9PXQOi176S/+8NOOY29+BZ0buCnU0gw5+QyIYD0JAzFrUMJ3ur+i8z8+KomxQ9Q+TzrMMQ0QOsp53KsudR2tEjAWOnf0Ds61A9O5sTGMije2dx8HqZdAQaarW4WoehfilPa8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962761; c=relaxed/simple;
	bh=E9l70jJaQyykusgTWUUnXUryASZQduz2DF5zqC8MC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrWRq+pJmeNo59H/z6IZktpovVbscmNTaLdXBUUB+plCCzAeg4S/bUpNOUPgMUSn/ny9oTX6GpF2LV+G2sk/gtQ1DFgi/khfkH3KWMrKUHHsTaGFKnzdoMwydALuN720IxVD6OSMDHrrGCya0ryTtjhNZriQBJ3Ce0kSeyouCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYqf8dqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722962759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
	b=LYqf8dqc6N8jwqlM52+A8BRo8YCkF5rCH/byc8E3aDPyiChTbquTCEpn/eGccDWTQx7FqB
	cx81bnmP2gAweKwUdfFwsCl0P6GZL7iVoT+1F1b2gAabAr/GP60nRSUwJh+Z/Hf1GyWXU6
	WE5AlxQOdVOOChmYCzbIN3J+yCog+m4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-oZlKdDrVPCaVkGj7dJboag-1; Tue, 06 Aug 2024 12:45:58 -0400
X-MC-Unique: oZlKdDrVPCaVkGj7dJboag-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a999275f8so34774866b.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962757; x=1723567557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
        b=QDyvd030Yr6tpMZ+XPQXsDyJcH+itFig+wr+SdV0zEMc5FJVcj7rPSyWT3a2pUMIoW
         ilze5794Hl1oh+ECnqySO2naJ/htqmY0ZH1fpsxPdW3sHVpW4XMMnYx8crAvWVFDIzdy
         dyNu5GZs9JnlWj/q5ZUtJQyCRx/68ita3o/CSpuuwJ1tc42H+xIAUSIfWfqiWQfQg/Fe
         Xoe3YM87yzWRiwNMGtt/VFi3or90dTLaMJuX942UxZrcb6jYSwE0rYaeAwrY96NHvkPN
         W0iSGgQr9nfDdjuiEpAZNlKhSiuP0ucDHYt/lcyFBFnMjfdQKoHzoEQ54G0aKwuq6Hw3
         +Y+g==
X-Forwarded-Encrypted: i=1; AJvYcCXYU65Mm+gp0/GvgprSmY6TPjZRkIRKh2f2KSdoyWst39/aqQhIAgZlrU5u/ScwCQNJbmRYNv3ABOZiwm4AILwpEEyJwZAw
X-Gm-Message-State: AOJu0YyBmgWWVlo8GXw+WPdkg45ONX/SJ9iKXJrDOzrxZTiPVjCE6BUr
	ZZJd+ymRnY4rnN8dKzIOyry3MIXiffWKt4jYktxisOv/qP41o1VfmfaqnUuS2UJZVHQlpIcMhl3
	ht4otEtEbmHJwHsvj/wzUG2/eA8SmvSChw/aYt/n28QtU0BXcm/KgpA==
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590408a12.32.1722962756762;
        Tue, 06 Aug 2024 09:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESyQrC5UzGzF64K7apX07hUu3twGVSZOhtmGTLXe8INI/Ij1pbHzqjoqEDGmV/r2tnzicC/Q==
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590380a12.32.1722962755874;
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb6609d7afsm3140107a12.52.2024.08.06.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:45:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: luigi.leonardi@outlook.com, mst@redhat.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <uhrf5ctkvc6ic7frpfndtdf66u66lonhfgane7bigb72damukf@mjavswunu7ve>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
 <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <20240806090257.48724974@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240806090257.48724974@kernel.org>

On Tue, Aug 06, 2024 at 09:02:57AM GMT, Jakub Kicinski wrote:
>On Mon, 5 Aug 2024 10:39:23 +0200 Stefano Garzarella wrote:
>> this series is marked as "Not Applicable" for the net-next tree:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> Actually this is more about the virtio-vsock driver, so can you queue
>> this on your tree?
>
>We can revive it in our patchwork, too, if that's easier.

That's perfectly fine with me, if Michael hasn't already queued it.

>Not entirely sure why it was discarded, seems borderline.
>

Yes, even to me it's not super clear when to expect net and when virtio.
Usually the other vsock transports (VMCI and HyperV) go with net, so 
virtio-vsock is a bit of an exception.

I don't have any particular preferences, so how it works best for you 
and Michael is fine with me.

Thanks,
Stefano


