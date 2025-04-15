Return-Path: <netdev+bounces-182816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE5A89F83
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DC43BF431
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462533991;
	Tue, 15 Apr 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK7F3HDF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4910A932
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724040; cv=none; b=EG33HQz4ZCPz3zG5AIJXsZ4CwUTx6PrPWhYqYMDbWIQZs3qqr9vNyyRY58LCIrli4y8SMhFZRHkT+PgeFVEq4hkzejWIwUm53GXfOQmJaUK4EozR+pPnNQ28GtXeqivM7vdPhEzMYQXXDGvJoK3bARf4TSjUkKDeHPYG4dbi9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724040; c=relaxed/simple;
	bh=l13QeGUpBt7Z+Eal2O9XukJlHaRSovKSMofedkTIq8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZineeQZTiHjahu+sIxTJREOpiJ0mco2FVnvJik7cYeH0OuiX5M6pr481mzX+byZlK8G+fLc9vgWI2qrlPRpbF4KRl5HScacBV/T6pSOhiExY8TY//LHxBebyHOPK6e+iNwCyztj/ZqO2t6O22QUYNIsmuyaopRe4hDJqeBtjmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LK7F3HDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744724037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXHpjM4APZ0tfvMUPblLuKGQITPLv+aM5MSFIiSWWGU=;
	b=LK7F3HDFe7I4udO6it7A+qSp9BBfDPq2GYPBWSc63WEbzVzRnDng7e8iylciQ0G4mLwURl
	FCm4qMJ4u3O8SMjws0I6E4VhFUaGGlSlI9bGZhG+faJAHrsoCr5bQbdURj6v8Hcw4dRAnl
	hDGaQ/MrdXO8+tA7VmQ3/4ei9FYek6E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-A3tSnNFEPeKZX5URPmQ2MA-1; Tue, 15 Apr 2025 09:33:56 -0400
X-MC-Unique: A3tSnNFEPeKZX5URPmQ2MA-1
X-Mimecast-MFC-AGG-ID: A3tSnNFEPeKZX5URPmQ2MA_1744724035
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39d8e5ca9c2so3697730f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724035; x=1745328835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXHpjM4APZ0tfvMUPblLuKGQITPLv+aM5MSFIiSWWGU=;
        b=NrTvmL7vmbBmxlp1jEMw/WRI4/bCFW56/LbOUbbumjxuDzmvS6u9BAJkmQxnPBLZoA
         1qMLUp5hWl5aEMpswTEan0OnhonL08os3ZIuUioQontvCm/O+25D5VIwsYQtauYxGxXQ
         SKlSdMyooLupNyvpfO+dhskpO8z09Nf4Y0PG3ApVs4LP8kXyFCi4onpBOyPlOmv10npg
         g+khV+0adGgPALcUM094akttC6lJ6g6OA+AXPzPqqjzF4CqR6N86/7kFaYEZ0LYLRG06
         BOAu9JmLDQgIy7VSj0vBMSu94TLw2cosGop8nSGx8+vvfqOHceTBLxcWTDSB0OV9BYNC
         M0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWoP1uQkWYZVxvY4C9ysPBcf0lC5RKg5DMzt4WXyqHrx6GkcQW98no6RPf3mxLpOCHRhFT63ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Fkv23NtfG7n+gIEt7wVvGPGd1HJbnKYVitM6MurVyt7yHoGJ
	NKYoLDjeo1Bm9UDRch4febf3f8yUWH/5LekIfJSpt3Gq7SvCLAAHcw8JPyChBORez+sz2Igme8x
	tzyPHZEluxnrU/K3DFTDyncCMCpdm9K4HhZRVGJ+7wsPEgsrgqOR6RwYBeBSrDA==
X-Gm-Gg: ASbGncuJNI08svdEKFeWh4TkwsbF2XiKGksu/Lned0uXgx54djDk+GA3lInxuNfYgtM
	lb2Psvxjn5hoBITpO2BLVEKhTEepvCONcMfPO8UUrYnGHSB7qJB5gPe9QPbWGCuvXnmjBxzaxer
	zY3I7BjzJMHWVYweeWgUgMtjrimrL5BGwL7Nb+lpAKfC8Aw+k1xMNhILbqlISbNguufBQtOjntc
	NRwZmr8xoofLSdCPobynDkM6euIyxKCS7pE+H/YBtjW1rdxXy9G4m7Azo+2jyUoDCWpDvdacbNo
	KZfBde4kEOSj2jYqiQ==
X-Received: by 2002:a05:6000:4285:b0:39e:cbe3:17c8 with SMTP id ffacd0b85a97d-39ecbe31894mr10699142f8f.12.1744724034767;
        Tue, 15 Apr 2025 06:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVEvjjmyIcEALcLIkoXzlOF17YjAd4KEcMk88wcE2sTQn6LLjsVNB9iVROcvb7oJkrVj6nDg==
X-Received: by 2002:a05:6000:4285:b0:39e:cbe3:17c8 with SMTP id ffacd0b85a97d-39ecbe31894mr10699100f8f.12.1744724034186;
        Tue, 15 Apr 2025 06:33:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.149.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf447914sm14218690f8f.97.2025.04.15.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:33:53 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:33:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: connect() disconnects TCP_ESTABLISHED (was Re: [PATCH net 2/2]
 vsock/test: Add test for SO_LINGER null ptr deref)
Message-ID: <f56zmuz36at6d5q43l7uk5ww6povxvlvzxyadpu4yqr7ju4soh@iaravg33efpg>
References: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <54481a3b-280f-4945-a513-f8a93b5568b4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <54481a3b-280f-4945-a513-f8a93b5568b4@rbox.co>

On Fri, Apr 11, 2025 at 04:46:09PM +0200, Michal Luczaj wrote:
>On 4/11/25 15:21, Stefano Garzarella wrote:
>> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> That said, I may be missing a bigger picture, but is it worth supporting
>>>>> this "signal disconnects TCP_ESTABLISHED" behaviour in the first place?
>>>>
>>>> Can you elaborate a bit?
>>>
>>> There isn't much to it. I just wondered if connect() -- that has already
>>> established a connection -- could ignore the signal (or pretend it came too
>>> late), to avoid carrying out this kind of disconnect.
>>
>> Okay, I see now!
>>
>> Yeah, I think after `schedule_timeout()`, if `sk->sk_state ==
>> TCP_ESTABLISHED` we should just exit from the while() and return a
>> succesful connection IMHO, as I fixed for closing socket.
>>
>> Maybe we should check what we do in other cases such as AF_UNIX,
>> AF_INET.
>
>OK, I suspect that would simplify things a lot (and solve the other issues
>mentioned; the EINTR connect() issue and the elevated bytes_unsent issue).

Yeah, I just replied to the other thread with the same consideration!

>
>Please feel free to tackle it, or let me do this once I'm done with the
>backlog.

-ENOTIME for this week here, so if you want, go head ;-)

I'd like to follow what TCP does in that case (connect() interrupted but 
socket is connected).

Thanks,
Stefano


