Return-Path: <netdev+bounces-257754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAiuMc8Vh2nBTQQAu9opvQ
	(envelope-from <netdev+bounces-257754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:37:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 256571058BE
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADAE3011C6B
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160B33D6E2;
	Sat,  7 Feb 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnk4xgc4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWiB0+ok"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FA302756
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460620; cv=none; b=k5ZS7xXvHaJa1msvy94IsOxMVNfsEkUUt37qyu+znptgy1xiVn4PCCn5nj6DyJFvhZu3FFZiLwFdMUfqep0VJzhFTS5fQ7R4m92LbOcrct1oB2GniBzV/5S6SOFdYCJhud8TZgDrcry3U8l8v9UIVXjWWUnfywUR5b5YaFZZXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460620; c=relaxed/simple;
	bh=LSToBen3PC7STn5LIO5y4sRfmIQC6eXFBNpCr3/T+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3xONHlZh87QId6Ak9TH7wP3ZU71VmCyJwXSxK6HPzq8oOKFPeBpiy3rOGRmVGW1xHMKVrUoyqb0FkEexx0EE5Ji13fA3tw7u81XGDj29k72UivOKOWqYSgIRHav+di00BZnhRqr8BzYeI3GTIsFL9K9f6agm1Wf6Y+4Nxe55zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lnk4xgc4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWiB0+ok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770460619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kh3D9klgXXKO9Bcq7zAYbqELTISjbIQTe+oHD7vW69Q=;
	b=Lnk4xgc4hE3Od5d2fdV/TXSCL3I7Uo8CgsKTDtjjfLm+QCYihWvH0bW2s8hiH4kJkB0K5P
	wXYsmZxKux+w9p6fEAQ1bo8yhHIbNPtkp+crx+LUzgOqRBJiXsTwcWAj2e9XLaw3b+Zo+j
	Be5qf/g30oFNTm8US5rriNbb8H/bUmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-bQw8gWoKM5K_vo-oQo7-2g-1; Sat, 07 Feb 2026 05:36:58 -0500
X-MC-Unique: bQw8gWoKM5K_vo-oQo7-2g-1
X-Mimecast-MFC-AGG-ID: bQw8gWoKM5K_vo-oQo7-2g_1770460617
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48070c21420so29007735e9.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770460617; x=1771065417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kh3D9klgXXKO9Bcq7zAYbqELTISjbIQTe+oHD7vW69Q=;
        b=LWiB0+ok4+TyBTwB70/R9IjuhjysDBkZFBr2UmbhpX1uOvT86tNFDtVPjbUDh7Ynb4
         jRtOwmG0ycxr7ZJ3y44I/cvP1sVltEtmQpP+cTBkpZ3Wq1UK43f+ViMGvHiZb+udZAWy
         GGm4LSOJ/l1C/GZurflG1kG9ttbkHysh0A3BZNTYSCHcB8eqzfmrXLnHpGGZOP+MpNBN
         hpVaACXSZopHEfr/aFKOZ8uvdySA3Pc0o5yTckB866CuKhAxCQjKRVYS8Cksb71sA1eP
         +YI7SzPpsw3B7ZvTz5GcgS4jya9k969BEYkGLdEjxZOk6lfX3mn89clvXMtw8ysHFy/G
         0FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770460617; x=1771065417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh3D9klgXXKO9Bcq7zAYbqELTISjbIQTe+oHD7vW69Q=;
        b=gnGSSkg7Ip0ZflG0YLZjN0LbDDzL49ck3ohHXl5T7WufP5YOLzH59kRDaOvwcePf+d
         P1/XsyVQ4CFkxOplDpz7IPo6y/VnwDFefS3vjlP+tVMKSW6+DQDyhmsLK7DS3CQuFNZJ
         GQdA3NWSeXyeLrpJY1wOAukEavmvdp+plC1q335sC/InDoZYeWqLreU1yiWvvW9+ziXP
         yHDz/VhqMEa1ekxuWRcWGifTvaca+vgZSyWYDW+TTDmrp7JYUbqGjhdrLQ9tn0Ol4ZfW
         L3Wvkivhznna8e5Q6gzTDzOzUNe5w9VN2qjmAyk9V+XFEBg24OKp09Nkon3Zx6SIiJGM
         C8og==
X-Forwarded-Encrypted: i=1; AJvYcCWanftlAhAPhSkyqyGz+Xf3bEyHFGYn0oQHJh0aGUAid48YhfKtLyovhV5Z5jyoHwHBaUlgU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+wM3vxZ2CZ6OXo+3hmziNPo8SOzij5fqkfuWmSk2X11Mb49m
	B4+tjd2ZB8wEvEAciABXLlqRha5toGyJheXeABGEbCcbvocjTCdkagLq1gHJiLZVCnKD+Am1D9l
	IjhzM9MUtUoi98nPxR2jWzpenm8pwV6sy7ueeuW/KlTmJXE2daw368rGjuw==
X-Gm-Gg: AZuq6aIG5+ug0bYPNcpmAHWc82I+IUKd1Josrap0+iKu/j1EpRFHqMYy3vKmEYYeRsv
	rS8+c1P+vf5dBVdVNTxmZkec+3h7vl3NtHPjsRGy4Plo09OaKTgmvXmKHHiuku7E4ogrB2lsYP/
	9/3+ubQeQ7nO9WjPUhsxAgccejo0OM8+32usCnal0kaU4m/hJyHiGOdWozFic1x8IrLRTePhOjz
	fUWlr71cuBOtszrjloKHktXZ69XRXsRnFNWWaUOEuGBRsMBq+QO9OMzmwKRl7WL41qUaetaFrDb
	7gpULMm5cVSORYsdtNpywwLEqC+Kuq/2/jOxB766bWUVAu1zDk9Fpv2RdFqg89zjvhPYFMG/1Ym
	vk1HAT9egT0vk9XFjpI8lBKFb1ncsxPzPIw==
X-Received: by 2002:a05:600c:810c:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-483203ab857mr91768495e9.8.1770460617158;
        Sat, 07 Feb 2026 02:36:57 -0800 (PST)
X-Received: by 2002:a05:600c:810c:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-483203ab857mr91768265e9.8.1770460616804;
        Sat, 07 Feb 2026 02:36:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719bf4sm107581565e9.10.2026.02.07.02.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:36:56 -0800 (PST)
Date: Sat, 7 Feb 2026 05:36:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260207052531-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206191308.7fdbfef4@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257754-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 256571058BE
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > align with kernel's standard RSS key length. Add validation for RSS
> > key size against spec minimum (40 bytes) and driver maximum. When
> > validation fails, gracefully disable RSS features and continue
> > initialization rather than failing completely.
> 
> Hm, FWIW clang says:
> 
> drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
>  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Which is kinda annoying because the value was increased in net-next.
> If Machael wants this backported then we need to keep the check
> and follow up in net-next? We could try to cast the u32 away but
> that feels dirty..


for net next we will presumably replace with 
	BUILD_BUG_ON(type_max(vi->rss_key_size) > NETDEV_RSS_KEY_LEN) 

and I think we should get rid of VIRTIO_NET_RSS_MAX_KEY_SIZE while
we are at it.

-- 
MST


