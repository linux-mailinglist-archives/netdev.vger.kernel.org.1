Return-Path: <netdev+bounces-225777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EDB98293
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D7F7A1898
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9813DDAE;
	Wed, 24 Sep 2025 03:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Slm8RzTf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5A4C98
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686327; cv=none; b=SeCMr4UEbwnZ6JWQIq/zGWtgWWt2aY4XbRcXRP8CjY35DLbbNPxfXY9ukRlzIIin7iX4w0dAoh0PShg/eNB6C+pxCFhzREgL68XKD7ZeyDekWKFa8A6cSqRw58uiv6ef80GW8phQH8Q4iX9HPx8fYzc6OtIcKmTIn7cVmMl5/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686327; c=relaxed/simple;
	bh=0/nstA96EthAffNkQnb2C/bCSot1JaTfmjuFnXEQMk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TmldFBCfg1dupfDt7jU37uOf2WIjNZInP1SGI4UoNRzrGW4gYfA91zfI/WDQbxQxl2gAcEJ7W//H+4qXIPp59yyXBgno4nuvxDBCISKEU1e0YmgeIRy9N6LNaiLycSuTLgGGReZQahq4XLNH3enVo0P5Hs/6I8JkZnYGvAglUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Slm8RzTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758686324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=c75KYydA4R+KeAtMkV0hFgk+5/p69cgI/7DgnNbkdaI=;
	b=Slm8RzTfJw0uUBNhMc8g0mmNn5U3ghl3XRKlQYTal1ZJhcLBiK3tHp+A+ZeCR57/NDCaZ3
	wVBtDtiWzEjAgN1EjtbRYPx/qMdwDv4+FR1y2f9kByel8g+TAHLQRecy2KNyIl2cTtrQUp
	cyEpujTQNUFxo7YMZxknRBQKMOyeJCU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LjcTqzv5OLuk_D4C-DQhag-1; Tue, 23 Sep 2025 23:58:42 -0400
X-MC-Unique: LjcTqzv5OLuk_D4C-DQhag-1
X-Mimecast-MFC-AGG-ID: LjcTqzv5OLuk_D4C-DQhag_1758686321
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso4324423f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758686320; x=1759291120;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c75KYydA4R+KeAtMkV0hFgk+5/p69cgI/7DgnNbkdaI=;
        b=MJH8FQCFx1PwSJDEozvgka0rRB011VY+n5yQxMxGNwHgmBKRi+nqR7Efixc4sia9t+
         Pyr7Bn798EKqkcKz63JR9Y0GHZHH2TPgfB37+fP8gHBZHLXA1K98VwJ51aNxlAoeYUF4
         ZYMHf1/srekTHCrit5pWuF1oJv64SS0fT64skQPqTc34YHV327/3cY0LXvJZ2hzD5j0k
         6US5QiVe5EMDAnkVBLeQ6Xw2vwx74bwic/kzg0nTOgC1XLwF6M3m8pCt3Y2/GVj8bJFh
         tJnBSYbbqwBE/pTwwLD0Te0xhzDZbpX7MCJGio19TMSajlKj4kPqdS0jM8tO0/pdJu0U
         OLNA==
X-Gm-Message-State: AOJu0YwPXbn8sObsM4CJzNaz4tr5DxyisfKo732oXJS3ggsFPN9dwc+b
	avqtL/Dbs3VbZ/IjOEoJT83XxFcMcPmkWna+qa2z6w9l8rXn1bG9o/2jZGNhKeM9iks2lkYQbtG
	rRhJllfWUWLObtaSx8JqreyEpeAMdMhj4g71F8hBT/yWO/HRD1KTu/Ne9mxJbMNfMNQ==
X-Gm-Gg: ASbGncvNtFIPYtKCrCrE9vPlAjQHW/Fl9p1w24Y4AW/reROj6I3g8102oM5896VtTCs
	5AxWBJXdN5InXo/XCugo+Z9QMrRRHEtTQ75ZH/x5WDVqHo/F4Nt08fFzdbRZ/AA1QjwEChtSTMN
	+3mb5+/P4ju/iZnrm3y0JPqIpQtXj19QSooIULa6GoVXWSWDtSuUW5aJ7FCuBI/GyKWnVjhWotn
	NoZdj8ziZVtZafQSxX/s4v5Wt38kKvJ1SYz30m/MwVK6pL1KcVwnfMm95qambDCyqoJJKZL4bzy
	/NYSbCVv9mk3UO25PI4ngJsak7NcqAbAlWc=
X-Received: by 2002:a05:6000:381:b0:3fe:709b:9d83 with SMTP id ffacd0b85a97d-405c3c3e1f1mr4126544f8f.13.1758686320598;
        Tue, 23 Sep 2025 20:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvnRrLh+81YE/FtRhl+i3yKkapl1dKXLuECr/TLRZeIHNXgwhai22ew9GrpHMf6bQk9AZ+bg==
X-Received: by 2002:a05:6000:381:b0:3fe:709b:9d83 with SMTP id ffacd0b85a97d-405c3c3e1f1mr4126536f8f.13.1758686320258;
        Tue, 23 Sep 2025 20:58:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1227cc37sm24528025f8f.7.2025.09.23.20.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:58:39 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:58:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org
Subject: ptr_ring_unconsume: memory corruption potential?
Message-ID: <20250923235611-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jason, guys,
reading ptr ring code, I noticed:


static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
                                      void (*destroy)(void *))
{
        unsigned long flags;
        int head;
                
        spin_lock_irqsave(&r->consumer_lock, flags);
        spin_lock(&r->producer_lock);

        if (!r->size)
                goto done;
                
        /*
         * Clean out buffered entries (for simplicity). This way following code
         * can test entries for NULL and if not assume they are valid.
         */     
        head = r->consumer_head - 1;
        while (likely(head >= r->consumer_tail))
                r->queue[head--] = NULL;
                __ptr_ring_update(r, head);
        r->consumer_tail = r->consumer_head;


...



Does not look like this will DTRT if r->consumer_head == 0 .
In fact it looks like it will go off corrupting memory.

Why isn't this a concern?

-- 
MST


