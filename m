Return-Path: <netdev+bounces-225099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7939B8E5B2
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792D13B7CB3
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE82765E8;
	Sun, 21 Sep 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEiO/p/G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE88524D1
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488185; cv=none; b=QKHLwnzCa+rutVDmdJnF+E+GT/i6/+jQfX7pbG7eXFoY9jhW0q/7VnfyrRjqKYxxgXHLdOGZ03+gfmiRznRkBA4NZ2FEqMuxsJ9Y0CIl3JKdMB8/k6AfNkRoXKLuIx1gEUOp7wEe64OmFqjeLn9LghGCyIvRYOnIgxFUzKPHlfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488185; c=relaxed/simple;
	bh=vcRE+eOSUt9r7QlljmvLF/beKVSKoUFncXZuFjVkhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPl8R2AxHBrEFoPzZB2cLPUsj0MyfkNVftNH80VPRQy92/QcoYhcTsC0ccU5OFviJu8DlNkW9JrLtrtUaN2s20xUFEhSMPJQqbMI2TEftasA0nuNiNC4ycAMS7UtzZtC3TU2LIyjj2zsSbjbd2I5ZJ6UdvdJNJdid24UkFZvDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEiO/p/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
	b=fEiO/p/GLMek/RxSvrBq52tEsERDgk6rQhlteWthbt6p5jYWxsqlb1XIt2ZtlJa9qXyaX4
	q1gnLzRHtfi0jD7RT7JouJomWqZW1WNYB3+IBsaRKX9BYL0/j1iL2s4s8nr0rLzqRoFEEo
	IEiAx0tzqj/90dvKmKIDh+BHINOM/rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-1S88dRgPOcW1gyB43XvdnA-1; Sun, 21 Sep 2025 16:56:21 -0400
X-MC-Unique: 1S88dRgPOcW1gyB43XvdnA-1
X-Mimecast-MFC-AGG-ID: 1S88dRgPOcW1gyB43XvdnA_1758488180
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de07b831dso22823725e9.1
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 13:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488180; x=1759092980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZa+gvlnzJbu0CdEMidkqaQp0dZ4QxQQFlF/kZd1gcw=;
        b=pbRSWHDB46CfFhJgYuFmxAuC/AHT3pAk4boFG15d/Fhjz3DyXPBJEfPZwNyvJOH5lW
         bR16/ht35JqazTcIObtr9HDbhw4YfPbB2psPedsw8Ae0LPGp/ACoyC1L+CcdrFeHIv7s
         kjQ5myjj3SmdrdGU9QF2XGyXXo5vJWYgmByvGyOcfAm+xmxszKEzZp1h2zz82Mwoga7x
         8ug7ZHDBHf43rAIlmmAR9hT/k6v4ZIzKRnpjJ5UVQ8bbfCzKHf7qY20OH19Y/8VugPCu
         R/pgf4EETeL5MgkMCoJph85iHBqfGzWJV0X2Sxf5FS/KlKE8OR633vwvbd9E2HqFAX5Q
         XKyg==
X-Forwarded-Encrypted: i=1; AJvYcCU72ZuR5rAS+appVKxhy+VSd1Sd07eKNmSHrc8Umewm8Pg/y0CCuBtVy3mkPW3vQLGyXcxd768=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcec9E4PeunrIApuzJecEfVE8oOdlGTdJXPn5L0dns4n65HxxF
	DrK/xW/O8ZZGoGiLHRjBsQIwdP6JqgoVwZe1rlKQFPVOELjCAPBzC8jdXVzj0r59tDuvcq70rkL
	OQokbmJTToLg5ItClkvZzH/ZFnh/sKPEzBmn6Z3PPaaQlIi3Vf1FK9UowWQ==
X-Gm-Gg: ASbGncvPOs1JMWOLix5C5wrwolJDqD2hROwjFrHoeJ+gZTNK+cxz8P8UJo5H7qjuIUN
	e4R9d6wdtHYHnyLDO22ltPaaO3NX9zFkWl3FIplkJSR80YJjDkjEMAam4SxW6rK4aXp7QhOuQ0l
	8Hc26ZBflULDeLYHq+Lvqo8o0SH9xQYOE9djSxTuQYBt7IH7l51xbN5T0zn9cRBcy/LOkgl8D4g
	mgKXHZfTJjx7dAfoYW9pJ+r2/S11eh+72fJiqAx0dMkq3oGF9gzh8g6ZCwn4ccCyEPa0oP0BuGB
	ZabcC1F+IZ728YXAHYCDxTpiNOTdduLTIYw=
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206385e9.19.1758488180273;
        Sun, 21 Sep 2025 13:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnqwMssDCjhijdZ/zRsJjF/aux8aMPTu3vT6tEWO8ityPhOqzUTeSFi2aStyrPs+FMZNaF1Q==
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id 5b1f17b1804b1-46ce3df54dfmr9206345e9.19.1758488179887;
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f321032a1sm131335005e9.2.2025.09.21.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:56:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:56:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921165538-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>

Subject: that is reference -> that is referenced

On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/vhost_task.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  		return ERR_CAST(tsk);
>  	}
>  
> -	vtsk->task = tsk;
> +	vtsk->task = get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
> -- 
> 2.51.0


