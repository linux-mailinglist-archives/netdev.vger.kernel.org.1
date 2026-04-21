Return-Path: <netdev+bounces-280138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsdIo2E52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591A43BC2C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEE6B303D0B0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E93D75B5;
	Tue, 21 Apr 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9AkZKRp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+vU1+xU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B993D6CD9
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780102; cv=none; b=hr1TszSB4sm0nkLK66pHa4PLnXns3Isls3W9w0BsvmuRra6jN6ENuXV6v7b/K6L0Vqb2CoJ2kQJKIQRgV9a8m/l2VRhlQgLiMEslCP7agBzGUImDOWntyAq00dt/Se6CObQMwGYxktfx9Fo4CdcTkdy72DjZwIyeKcwTPaoMdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780102; c=relaxed/simple;
	bh=kEmWXWrNjTwMojo+a24CnTYLttbVI+YVbbmUQBY2fz0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzWLyyDDCuQWZDiZRaYQd6ZzqCXCqM1ZRQfxjVHRYqiVbCkuZcMxA+bAon97o27FV+7RL1nex46BqRQQ0k4iGp1C1xpZhwfJ7ENWNe41uoCSqUuf5QunF/QHj/qqgs5LfpXHQkYe7avdU6hk4g0oP8kSM+WhA2JOUKuI6IRP3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9AkZKRp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+vU1+xU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776780099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEmWXWrNjTwMojo+a24CnTYLttbVI+YVbbmUQBY2fz0=;
	b=L9AkZKRpqdKwv/N5khLXSARYxsoBM/yFD7Xj9xOFKrU8Rg+11LxfbFtU2MvJGid9Wc4HfU
	P9n2Xs6fuzIv/Qg7vq+zM1imwFoCiN6SamA8rsEUv8/865WQA41fbzhGNJ/VbVtxsLfu4u
	NKfVHjRAd5HNWlSYxw9dJIQTekDfCBg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-xuD0O-g1Puu1PrRQNNU93w-1; Tue, 21 Apr 2026 10:01:36 -0400
X-MC-Unique: xuD0O-g1Puu1PrRQNNU93w-1
X-Mimecast-MFC-AGG-ID: xuD0O-g1Puu1PrRQNNU93w_1776780095
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a548b585cso7744745e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776780095; x=1777384895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEmWXWrNjTwMojo+a24CnTYLttbVI+YVbbmUQBY2fz0=;
        b=K+vU1+xUm1Ta+38wAQPLgKQozAhUe7Q1sV0CxvDYGcOBbetWQ/ZxPewrXGIfSX/Cvx
         8Is2RavUTGx5xNQrekZNAdvL40M3akU/6sMEpVi0rqlAOIl2lOzbrUTd3djTrYD3rTX7
         iVfgFabFWiZKUz7pKBWiEYXA3tSAl++vyHqxfDlwKh9nJo64STOBNFYX1kPyQme+V6L5
         grlXeMDdf9JpDTqu7CrL5qSIOjMgMyQfPpwDfh4E7XKd5/LS++FT5hUpa7CIkdjnBGDJ
         XExTfgsGJ12PsAXKuTD0WCvVVgo7/pfQBurddtycq9wJiLMrRL7kk2mqJxEAkI8Nkb2y
         qXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780095; x=1777384895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEmWXWrNjTwMojo+a24CnTYLttbVI+YVbbmUQBY2fz0=;
        b=r8u19+j4S3lOL3S3hAr+g31En00MMdyv10FPcXYH0vYPeE//Nt2ufsCcxYMA0Ch1ET
         WUJbRHsgJ5qFxhIA6nYrLcE/SSbvufsaQmAX/zfQlk2Nmpeywt3pfNvPnnTbN6zBFxFq
         41ELk1gTwoGft48UV03D9KRA+OAkfseQPAIWsgcCEW6JHEcvC9O445sb9I85hr9L/b7X
         0gyrmoqTtPuwrWP5ir6m7DQLlDRJeIya3MQ/sOvBbp6BRBsdy3vaCzhJ92a6imqeof40
         L8SKhP5yFIV6eLL94xMGlUYmdlyywun99zUHBwGkzQl7Ow4tzACN8o1NEpZZBltGnEdN
         Jo+Q==
X-Forwarded-Encrypted: i=1; AFNElJ84W8++QFzHGM9ZhV6yh4CRJszzUGSFyYLfjr01UumNYncGjSATqxJ4anEpq+FJDwxJTUsiL/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFO0bpYONAvRJQjBPDoaje3SlAnr/Ng1fM8n5/v1ZzrPOnwm/
	KmYe/hDtkkPR5eewqjZ5ybm4Q0UaRvvgXPCrhcQgwAkCPwQnuHyUv2koHqQ4lH/fJdABqxPScd6
	SZ2qmMDvDIZhwueze6PllxE1kSVCJ44bCu8I2U81z6/rAXvvxFvIvL70zOVALrqeo6w==
X-Gm-Gg: AeBDieukaw0ZETuKS1rtVQbecboZEf02jFVbmdXKK4JxFqeIL60N0sDBuXzf6hqqMbi
	uiiyZOLiYUAf7ooHdTc8WwRBrS+Rlp0vfb1ifw2SWXB6Sp7ynRavM0Uozyh6U+1kw1ULDItZGAc
	U73nZepgzyS5Qf1TpLzmBPy/1cXPgl+Msl01GjQVJ/zvzPCnNIZ8SBBYZQdq3xWQbFcfQFqDS6c
	0gC+ZMZIE8WpYLA7JupLv2o7L4Pqnr0F/Kq707P3rj+lMkZSkrCZ/hnha+0JpFMJVnLvormNBFb
	w9OIKDBdHkF479ZHJwCSOFGqpJyjDIoj3c64hKLDVwFBADmZPM0raqaXw8MBPJre3vZrCXuB4h2
	atnM3VaaWe/IJJ1ZIy7wXwMlM/e3i1PkZB3eS0w==
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr271655505e9.0.1776780094408;
        Tue, 21 Apr 2026 07:01:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr271653825e9.0.1776780093365;
        Tue, 21 Apr 2026 07:01:33 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55743c06sm18094685e9.2.2026.04.21.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:01:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:01:27 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: sgarzare@redhat.com, stefanha@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <aeeC7CtI6zw-XZgS@leonardi-redhat>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280138-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2591A43BC2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:35:12PM +0200, Luigi Leonardi wrote:
>parse_hostcond() uses get_u32() to parse the vsock port into the
>aafilter.port field, which is a long. On 64-bit systems, get_u32()
>only writes the lower 32 bits, leaving the upper 32 bits set from
>the -1 initialization. This causes the port comparison
>"a->port != s->rport" in run_ssfilter() to always fail, since the
>corrupted long value never matches the int rport.
>
>Fix by using get_long() instead, consistent with how AF_PACKET and
>AF_NETLINK handle the same field.
>
>Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---

Apparently this fixes `sport` but breaks `dport` filtering.
Will send a v2. Please ignore this patch.

Luigi


