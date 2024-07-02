Return-Path: <netdev+bounces-108392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E1923AC2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D597280F7E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CEF156F5B;
	Tue,  2 Jul 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXPcVq6y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F47150987
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914024; cv=none; b=l9vFjzlPQg3QyQSuqurUE52eb9f/hdyp3fSN9GoybeXaXwY/OTsiba6uKHON5WVzUgwMeXBTW2cWsfq+NgWVAERWCKBEAkpRvpKR6JUnJauCVQBmdz8Ox3zZqtrzjAhC7DgDl/6hYmylSg1XM0IdKSLPRSJLmeU5WxIp3/PYu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914024; c=relaxed/simple;
	bh=MGSzto/cq3LB0E4ecOkYu6NC/5l/m8jXuofARCe6LEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6gDuxJNxLxyTWDXethM3JN9kHcq8bnoC2HTUqFnVvuIn3ctLfqdkqjW7bsuJ4aYIkdnsNpRXdrc7E423IOvST130Ix3zddH12WXhKd17L3ux1B9h4V3RR93YfLqfIyZAk1wvsOO7MmV/qY1jkonkgqRMY60UlMUxvar0dQi7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXPcVq6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
	b=CXPcVq6yv+PjBnZk0OOTknbaf56QLzag0sQW5bGNQbSJ8Sr0UZ95cwkKFcN1W/oINBHbEa
	fKPIBlOAha4KlgMaO1gK7HJnUS2QWwMKn7MnabTrbC+0F6u9K0UCtRDR+pBMwVF/1iY7PJ
	UZzjHPugGZHt7e8d+HyCZ0a6eXXrNOQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-x4Ww38wOM7SRkNtL7TLQ1Q-1; Tue, 02 Jul 2024 05:53:40 -0400
X-MC-Unique: x4Ww38wOM7SRkNtL7TLQ1Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44645ec39d4so51396061cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914020; x=1720518820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
        b=QoP07bSRzHyMzrazQXSPX6XejOTXJ9JgyjQO8bEgkHDJK5jYWc64VlP1FJvVMvCLF6
         xnJzB88MIC5BhCLCPvX0YUonRMRf9kIlVrhvWKwdcr4mqNzP0j0vi2rOVsyrFYDVA+Rv
         zfgwRV82oRomCEdHF/tU1xFXCc6tY2s9wgGNXnLvS83OsuQDIv9SzwtZB0PBKISVRZ+n
         SFdD5X6vRJ4HZzDrQ8HcGTmUpajuy/F8SKLY8kxjfG7jbx1rCDCKr/m0DweWVnPP1su2
         wGNj/QBgX0cyYvsZQvVJjwGswI5JS5xVZJ9INubZYztmLtb/Ts9PzVoXp35MPkUBJL2T
         B5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsKVbmp7IirDZuKP4zLxr/E5f+MbSdt6SooIUtwPpGsJcTS3knr0iDE12QunbTgoExDj2dRHo0h9lhi8RXkpC9gzg+HkS
X-Gm-Message-State: AOJu0YwcvDKg1y++9xTu3gQPsBcUMWWjqTVcLXv5ACi1zA+lVraRg0Tr
	t3fjJOsGo3AxMi2ASnxcqT3rEjxbVJcT6ZRirCSycxtWnwtfTZ3vGA3QMwR8WmdMbNJLJJeLOct
	JUK2j/JGa6gJHIqZ7O/vUjceWWmM3RwUJ02iz8FohAnDGKjg+MuF4eg==
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715701cf.51.1719914020145;
        Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCcQNmIPoKc5Qmxn92R19gzUW4REeysnZ+oNphjyAhLmalfFvXnVJlo/R+c80Iq9xcgNw8ug==
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715461cf.51.1719914019651;
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b2484sm39462531cf.81.2024.07.02.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:53:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: devnull+luigi.leonardi.outlook.com@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH PATCH net-next v2 2/2] vsock/virtio: avoid enqueue
 packets when work queue is empty
Message-ID: <e52cj2hjqmx5egtvnkqua3fvgiggfwcmkcsw3zswbey5s4bc4p@qp3togqfwgol>
References: <20240701-pinna-v2-2-ac396d181f59@outlook.com>
 <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Mon, Jul 01, 2024 at 04:49:41PM GMT, Luigi Leonardi wrote:
>Hi all,
>
>> +		/* Inside RCU, can't sleep! */
>> +		ret = mutex_trylock(&vsock->tx_lock);
>> +		if (unlikely(ret == 0))
>> +			goto out_worker;
>
>I just realized that here I don't release the tx_lock and
>that the email subject is "PATCH PATCH".
>I will fix this in the next version.

What about adding a function to handle all these steps?
So we can handle better the error path in this block code.

IMHO to simplify the code, you can just return true or false if you 
queued it. Then if the driver is disappearing and we are still queuing 
it, it will be the release that will clean up all the queues, so we 
might not worry about this edge case.

Thanks,
Stefano

>Any feedback is welcome!
>
>Thanks,
>Luigi
>


