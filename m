Return-Path: <netdev+bounces-260161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KEvMJOinGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:55:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976C17BDFB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D39CA301DBAC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168D34029C;
	Mon, 23 Feb 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etGr2bmu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D81EFF8D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872906; cv=none; b=tVctQQj48CzZ+eiGJGb84Cx+5TJ8uk8JjPSt2mpA5OXJAHqOUC6d3mJyWvwhA8ABdaowhNzXenpVvZurHh5NXW32p3VpDfIHgZ8cFGgCYH4aEU0GjiNIwcBCCK7AuOAiF6V0mvRSvLEkHbtIe4Dc6OFBxwLPmdZ8/DE+UZ3PO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872906; c=relaxed/simple;
	bh=nctdjUKXo0u5+zaaCcHY+q1p5NNU/Ba/iOXcHcHJhqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgrvFrWHQD+JI3IsLsNR3mSbT/P5YbWaZKin9W9o8RTYbo9YTpUvWnj5KT+CjP8uHUkKqkMqfR4NfqofKhq0Q6Gf5j30hgBdAMghxyjmRPI7pccMlZJIbr8bYH8DWe6JhAJkNGlzAEwHF0gqXgGCi+ljakL8lMIxIlf8PmvJEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etGr2bmu; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7984d30f2a9so9640827b3.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771872900; x=1772477700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vud3sOYkGGFigTsBFe48YuQKgz6ijM9yPc/XUomBSLw=;
        b=etGr2bmu66pll/SNUp7O+2fZ4mY0Zb2IiRROH2FNzRhKqIGblnaMBAfSLkc9XALiEg
         up+CegmMpNMypSWVXCPtPy3m5Jk4vw1L6e38NE8QQLjv1u3JmKsI34RTO2v2vG3OP5AG
         7A2/RrZ9gFL18fs9qtV4ztLquDSY+9BAsR2njkaLHU3MN/5MqvR7Wf3Lhq94E07NJqCj
         +Gc0QcsBu7BnNurI4MXf7sq8JbHob6SdGiJVxisa1Do9joNnDDc3I+eWZ/2aSWf8bdrk
         r+sQWhRYO9U7mFZ0Nc64Ewm+atqjK78nF23bRzz+Zn3SJ0jmxb8cGsYZFFcbqEw57OJH
         gLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872900; x=1772477700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vud3sOYkGGFigTsBFe48YuQKgz6ijM9yPc/XUomBSLw=;
        b=GklzwYvS1w6agPINwRJvo5uKJQRulKZjDU/a6OA6osZMd4mYgHD4o+hnNXDrOSmJXL
         L9XtnE4gQF+Bjt7hlYYgR5QMT2WJXDnuMNkyxkg9sM93UGb3Nwe4OkVwtAabR2dS8EL+
         FznmWdJ5byFhlxXstVrTwlGNxb0fz5GKmyDaqaJGSvotkq7stZUuZpHSHF8zhKrXmawV
         igVGNrTwZ4ZRIBl0Zq4xtHRL+feMpdmjp0Re/IPDExwiq1lsgZdp2PgvzzFlYC1CLDmV
         +2kh9WMGvrYtK/33UgusaNZIPBlS7ZURfflsQgbWLeyhoCeF0NkhL3avj615nHBAW6ih
         ygUg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ncr8xEUKVitj4Nrb805ob4eA2Gx+KE96drxnsFhtsvsIxUJO9BoZTO7N2urwYHzEyVuDn8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GUYGqcHTCR4BNVG3Bcwi3NDICZb9bYUqLNakezTkCEGwek5c
	vgmi4C1rzg3AmYd/bmrwvd4D67dG36LfNR6UKkpkNBazRC5YvdF/Fsoc
X-Gm-Gg: ATEYQzxrwL18iaB1IfmuUFUh7w7/G8SjOo3eaZo/UShVPcN2oqZEb9gZtfvkAeWrdhk
	dtlLAkKNVYXdp4UvfDyL87RSWba/gLwHbT24dQ1d8CrocGo/RMeJBCzFriy4+LCijjXiAPfDAb8
	yh7uiwfQTDAx7MpbQrfko7qroIccwbbclFDJ4Xg1ZRDpwsJXD1mFehSGI+d/14z8Pjv3E1mbHqm
	y2U/wpL2MG7wSHMCGtRgKsuQFwB3UsU/04cuN1GlemJuWDy1h8MEy8dwB1jbtAlUigDpf5jZocq
	FoTmMkYKymKf+B8oT5wIvyV2EbBCpbli/XhpZdLGRn1B8hbWN+y+A1dt1WSLxRuT9tIxQHFadAZ
	V5GttdqO2Qjo8sTuvFMThaJn89ztXL+ICUp19MvOv9uvmmXFXlLlbcsoPOnMHBgOlym/N4zhzry
	ry5cIFufdrKQv0K3pWhQ6sq4wVefuVdZEWrbOSAFBiZMfOQR5DWnN+kEymIA==
X-Received: by 2002:a05:690c:c244:b0:796:4626:7425 with SMTP id 00721157ae682-7982914a1ccmr83072927b3.49.1771872900476;
        Mon, 23 Feb 2026 10:55:00 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm34856507b3.24.2026.02.23.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:55:00 -0800 (PST)
Date: Mon, 23 Feb 2026 10:54:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl handlers
Message-ID: <aZyigkExZEUc1bYE@devvm11784.nha0.facebook.com>
References: <2026022318-rearview-gallery-ae13@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,devvm11784.nha0.facebook.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 6976C17BDFB
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 06:32:18PM +0100, Greg Kroah-Hartman wrote:
> current->nsproxy is should not be accessed directly as syzbot has found
> that it could be NULL at times, causing crashes.  Fix up the af_vsock
> sysctl handlers to use container_of() to deal with the current net
> namespace instead of attempting to rely on current.
> 
> This is the same type of change done in commit 7f5611cbc487 ("rds:
> sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
> 
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Note, this is compile-tested only.  Some of my scripts found this when
> looking for places that are missing fixes that were applied to other
> parts of the kernel.  I think the af_vsock code uses namespaces, but as
> I don't know the network stack at all I figured I would let you all
> review it to tell me how wrong I got this change and all is fine with
> the original code.
> 
> thanks,
> 
> greg k-h
> 
>  net/vmw_vsock/af_vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9880756d9eff..f4062c6a1944 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
>  	if (write)
>  		return -EPERM;
>  
> -	net = current->nsproxy->net_ns;
> +	net = container_of(table->data, struct net, vsock.mode);
>  
>  	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				       vsock_net_mode(net), NULL);
> @@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>  	struct net *net;
>  	int ret;
>  
> -	net = current->nsproxy->net_ns;
> +	net = container_of(table->data, struct net, vsock.child_ns_mode);
>  
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);
> -- 
> 2.53.0
> 

Thanks Greg. LGTM, and passed all tests on my test setup.

I can't say if nsproxy can be null here in particular but better safe
than sorry.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

