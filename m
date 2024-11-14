Return-Path: <netdev+bounces-145018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A084E9C91B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6564A283AB6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC518C91E;
	Thu, 14 Nov 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abEs317I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373216EB76
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609173; cv=none; b=lap9N9abK5uFZt9WjE0hZEer8j/I/mstmknQvN4PXKq9ocI4h5ii59RQRGeRfHdfzD0cg9LevR4HhgOztd0XwLyiRt0I4YHPpTAuMYluaa+RSwTLJmARqa6MxUXHRzaXV3h7mpP7kU8Wq8RY88l3WJI0xcuRf6cH7saJAHs58Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609173; c=relaxed/simple;
	bh=GtoUocYxOO43x1jcxHW5REFrvehfdiJltsSWjcPgIRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2EWB4UobZlIGQlGUwMVUCBgeQFQvbTJGsV/1ry+Kdhr/silw4GmyQ2sf5LhDpyT5sudy3Xv2wBMAarYgEheYf1UOgVCYBJe3vgstEIMWKgtE3qMVh4/5Su8kzw8VN2p47E/aUZEc6Wqu1XoK5dXQ3DJSi4jX0abb/eEP1JcEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abEs317I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731609170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFI7tbBYGiEseQ7bvAyFPEuhxaHn8dv5eXukTVUQJvk=;
	b=abEs317IqWvy81OFFOID1QhCHl267efca9VTHNthaAT0ShgJtgzfs6mn2BsGL0Zp80ryfH
	IwQcbaOsRmBEmvIbxPjtZkTHcUVtqw0fR8W1c3faDg6gBoNbD7rTElv+aoB5s+dkYxHmWS
	w1Oaab0CUnO5gd9BW7JYMJpUfTJPRZI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-GkaJt-cRO7ewf0P1P6esGA-1; Thu, 14 Nov 2024 13:32:49 -0500
X-MC-Unique: GkaJt-cRO7ewf0P1P6esGA-1
X-Mimecast-MFC-AGG-ID: GkaJt-cRO7ewf0P1P6esGA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4635760799dso21193561cf.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609169; x=1732213969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFI7tbBYGiEseQ7bvAyFPEuhxaHn8dv5eXukTVUQJvk=;
        b=eOoSvZ6uz/hW0yEaF1pt1xVQ2MPM3F6ECaDewSguqIrRPHhyP/UMb9oQRIZTI+9VaB
         zNdo3codMc2rhuEF54d+NxBDar4NiDaqitcATyGy5CELf1zc0qhvxhdt/8+S6L+T0Zr2
         kXBufW2/rBwb7ONYGsB/NnJ0oy0lp2gkKsRdwbqBSQrJcElLMV/5MHkCS1+SB34UbZn7
         X4kLDjTgM/kOrISdpC+oS7o9SMfV/6Mj7S1hrfZIekKYbmAIDDrfQcruzgHrEF1Wx5IC
         3picmfzw57HMhTx3t9ah3aB7DyAqag/alREiY1xmRbylQ7M6jz3wKdr7ybCPNYEb8Y+X
         sGig==
X-Forwarded-Encrypted: i=1; AJvYcCVddZKvWF9LP7kkA67Kgjzkz4P7M6s9qGCPhgBb318cxrXXgEt16+cQi/NKeRj0e6i0Nhj40VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoTcDF/HlWtMZ+pjMUolkc31ftCq2IXlP/VQwhoq+WlJSorgt
	/wPetoV/2YhzMH2PQ9J6lu0n3o3ecrxOV9X4OLDqXi26nOvh5WmgdNwKdQXuW/uyg0dJSjaavVm
	RRGJxd6cM0bDkZdqLBGpfRfKUeuaNnUXQSo5dZDmXxTh2qXQJKuZhwSWhDK6UfIq2
X-Received: by 2002:ac8:58ca:0:b0:458:1e37:f82 with SMTP id d75a77b69052e-46356b78d6amr69904341cf.18.1731609168786;
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0QtIZNLBykcxZpLOh80DvJJPMPMAFpJAL1kQs1vq2h6v1QgZ6rz33PSsG16J+HF/4i/gWqQ==
X-Received: by 2002:ac8:58ca:0:b0:458:1e37:f82 with SMTP id d75a77b69052e-46356b78d6amr69903921cf.18.1731609168445;
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24e39sm8729521cf.63.2024.11.14.10.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
Message-ID: <3f967373-32b8-4e43-a180-80c94fc091d1@redhat.com>
Date: Thu, 14 Nov 2024 19:32:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
 "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>,
 Mina Almasry <almasrymina@google.com>, Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org> <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>
 <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 18:58, Joe Damato wrote:
> On Thu, Nov 14, 2024 at 10:06:02AM +0100, Paolo Abeni wrote:
>> Please send the two patch separately, patch 1 targeting (and rebased on)
>> net and patch 2 targeting (and based on) net-next.
> 
> OK, I've done that. I left the fixes tag on patch 2 despite it
> targeting net-next, but didn't CC stable since the code doesn't need
> to be backported.

Thanks! FTR the above was the right thing to do.

/P


