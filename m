Return-Path: <netdev+bounces-230844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A427BF0725
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909EA18A177A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC212F6567;
	Mon, 20 Oct 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrQEmkuO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D232F6162
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955017; cv=none; b=FcsW8mMp0/l2AzLSP2MSTKOlRoiVNlmo5/43Ic5orl0LJ4b2yeCThJSPdfz3C6m++6b6mkGR8a6BRTMoQnyhSMeMoJa3GLfWbs9H7NnEAEJaXwLyJR2e8eloVPPaYB0tA7kXBdAzlK5XoCBiQl11PBJrOhY9GVfpad4HW3ZMWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955017; c=relaxed/simple;
	bh=irwHczt7jTZu429UGLQiqo0bQAQe6oh+iKytPWQdo9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1jRDB5pJ2g6ZVBLRzuHhYNSh8OUVplNIDf/LfWyE8KwI6xDd/V5tRWCbS5lr7YMII/6Qie3KcozPCS5kpX85Y0VQfWMJc+cLXe6GTOUruJ6bg8DvLjjHyrHR+m7r5VYjOUvbgwQd8CY/ajAAq8eXoklpMlWPvnXOqL7NKQIK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrQEmkuO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117f92e32so25218915e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760955014; x=1761559814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIWARefYPtKPfqB0xwmbONWz7j5Ht1YLIPXHwUrFpFA=;
        b=IrQEmkuOxi/GwkN7WZzPHCV9sexq3E+L96YDx3FnOsl1H0EsWzxBSoBXHYy4+PcOaw
         bZrx4g24U6Qh6aKxNKiui8iSaSCwilmuB0O/DR9maelpfVLqbrzxpm9evrP5VOZoIzXg
         imtW3zwYyJYVZQaJaYBBMggL67UuWS1ibg1h7EiCsx6/Sll3IdKHx9YcbL8atDRB/WBO
         Z5iNhKJLnL7tkjd29dQXkeITTqHHkVle2IWeq4HE89yZ9Zc/YnHyW8sUlfgod3TIfOeA
         mf1PosV+Jedpeu/Pt2Mkk1FMonZ1oTDKJLz7fqajl5YbGw0356zOjcsJwkBNuAGE9rbW
         wkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955014; x=1761559814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIWARefYPtKPfqB0xwmbONWz7j5Ht1YLIPXHwUrFpFA=;
        b=TrUSsqJGrYeiervtLqMwLnoo45ImH6bkk0Fa6hAkIjTfDXD10g5YhGHcbUQLCjTOy5
         r9yboMtGEigdYfd3jbjWVFsV6h/nhGGNmtqQz+KAPS3YtI4w94DTiXBWbLkVIpxhJP+l
         BLrBXAQhefbkrlRBUV2m32FWfGrfwIDvDJT39daR7PSNG6wzYdXYFqsghgfGzTen6Kh9
         suhHnHXiUVkzoBH7RqpA16PvM85gK9pPWVtVV8sK4NnDz18MWPYv/MfX2gQTHMMm/41z
         L42fDJ7mYmAXQ3DelH//LTmkkG+AbhwHvfhGwmw+Ct4k/wSU0tebSwW0Z5X2ZK2gYCrW
         FZjg==
X-Forwarded-Encrypted: i=1; AJvYcCVE/ZxY/JJkglDK8AxvFLRpHPnBZShZ+7bGaMbGC5T9DsLsnCMKjFNXfUKvNeQgw2+0FBF3zyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDHyZHrfnnxei9vHmyEcaTWGWComOjshwyk160dyD6/9QAhvr
	pyw5XQcZq8EsULfBgUBI9kOT72FqvoExCWWJLw07+Az5h/9Oy0vvzwIEVGBClUkbeG8=
X-Gm-Gg: ASbGncsPU2NfkuGy8gH16ILCUH+ZmK+sZrDRIfyKgUfyAcGFpy/UPGy/93V68nMRHjs
	9+CVhHjbvNkkZEccxJEdnt1z62yKkGuwJjchFsP1TYxNbLl3V5X9+IQgRl70+L1r548AqFhhf3a
	m25xNMHSNyss/uGueBaduD6RQ+wi+GkrD431PgYhZGXBm1vZTax9jyohNqXSMYRpjsJcIEVq3e2
	ky3GgnTyCnt7htrAwHzKPStfnZaf1M5XfRYMnVfdr3y+ngz1pfq1bVQXacikAFZuiVWNwM2UMsz
	kWyuB9PIALC0cJiLe/szl8Ii7oIU74wLO/iOrl3XsE24YQNNRlyNtZhAoD+MYKnq+tT9Q0eQCWZ
	979yXF8U2stuIMEMtOJ3eCUfz9otVyOcMtsrTy1XRvfCI8VRGEZ+rT//FPTHE8jOCiXLJ3QsubV
	ioV2DLfouPJJuR4xA=
X-Google-Smtp-Source: AGHT+IHrrYifEg1gpWKBK0S8ZIgR8Z+8wANqrcE3Fb9jIBMTS+dnOjVa5aHlyOB7K3bTQJksXWDdXA==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr99523105e9.30.1760955013820;
        Mon, 20 Oct 2025 03:10:13 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5bab52sm14440788f8f.22.2025.10.20.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:10:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:10:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPYKgFTIroUhJAJA@stanley.mountain>
References: <68f3fa8a.050a0220.91a22.0433.GAE@google.com>
 <20251020081359.2711482-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020081359.2711482-1-lizhi.xu@windriver.com>

On Mon, Oct 20, 2025 at 04:13:59PM +0800, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> NETROM_NODE commands to add new routes, there is no lock between them to
> protect the same nr_neigh.
> Task0 may add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> When Task3 executes nr_neigh_put(nr_node->routes[2].neighbour), it will

s/Task3/Task1/

> release the neighbour because its refcount value is 1.
> 

The refcount would be 2 and then drop to zero.  Both nr_neigh_put() and
nr_remove_neigh() drop the refcount.

> In this case, the following situation causes a UAF:
> 
> Task0					Task1
> =====					=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node->routes[2].neighbour->count--

Does this line really matter in terms of the use after free?

> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);


This chart is confusing.  It says that that the nr_neigh_hold() is the use
after free.  But we called nr_remove_neigh(nr_node->routes[2].neighbour)
before we assigned nr_node->routes[2].neighbour = nr_neigh...

The sysbot report says that the free happens on:

	r_neigh_put(nr_node->routes[2].neighbour);

and the use after free happens on the next line:

	if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)

Which does suggest that somewhere the refcount is 1 when it should be
at least 2...  It could be that two threads call nr_neigh_put() at
basically the same time, but that doesn't make sense either because
we're holding the nr_node_lock(nr_node)...

regards,
dan carpenter


