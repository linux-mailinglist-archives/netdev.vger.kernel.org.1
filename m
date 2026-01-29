Return-Path: <netdev+bounces-254775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJWnD8tIe2kdDQIAu9opvQ
	(envelope-from <netdev+bounces-254775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431CAFC87
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C2C3005798
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448D3876AB;
	Thu, 29 Jan 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXtCkTKQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7FoknhQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B320385EDC
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687214; cv=none; b=bpoB9j+5bY06X/IXV0WS+rgl3mzytZDSIXriQh6q2n6hVR4Uw3sSduAjfGPVCG+Y6M3v/+TYseg/Bo87xcHNLAfufIv/ICfp8jMa+IsDzqI/nfBqcImp1aYenexQJJhncKrBb5On9jR2xIbHRmcw4UIo90OzUHybI8trh6knOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687214; c=relaxed/simple;
	bh=jSw/u7S8eCN5NKIw+gpHjTuW9Esip6V4dfxS2M/EkY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o62zzs1E58M3uFil0VJDw5rBsgSFuRcFJPmlLED8/gVyVmicac4sjlcdaIYa3u93+Pgg32/z06CiqVeudOWRN8Wo9rZTj3o5q5rFzTFwZEWgB4/8xlloxy5rTPfVKrtsxTVsPxM4AFkrNtg904MsngY6xyeZIpoqc54bHp4yluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXtCkTKQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7FoknhQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769687212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpvdzmSa+i+pWFFmFsuGVs+kLgJBr+cyfmxqCcSStVY=;
	b=SXtCkTKQehtcm59zBb5hj3XnuAx7Z+lnfnosnCdqARTXjSUjbRMlc5j95NPQaFwbdIJnPK
	3WTbCN38s0wmwjz/IH1+6QY4V4bi4sHRJgm28MspleIbedl1ZkXRVecz0dtcWvTbwqvkVV
	Yi5euvs2N66dFRFkCOBEoFyNgQ1IrOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-5HFqks2oM4Wj5myUs-LAJQ-1; Thu, 29 Jan 2026 06:46:51 -0500
X-MC-Unique: 5HFqks2oM4Wj5myUs-LAJQ-1
X-Mimecast-MFC-AGG-ID: 5HFqks2oM4Wj5myUs-LAJQ_1769687210
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801bceb317so8876585e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769687210; x=1770292010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpvdzmSa+i+pWFFmFsuGVs+kLgJBr+cyfmxqCcSStVY=;
        b=e7FoknhQGAGaPg/rksxKD+eg/MpIJMnaJ3gTKUXbMkfUtMVpVGjUolM5efo1aVtZx4
         wLjXoeHg63n6jJpy1gFgm6sKvNCnPxgpHFBFc8G3GxnV0RnOcxb9CcKqL6DPPJ55Eux9
         MuBCNUqCv0G2dB9OK4WbPa6RcvbA/dvStFmlL6NUmM/OyLiJmK5XGJvwPoW+9RWb7gHU
         WTjl2jkVvLbLQtchK6FL9gqrfjgsjCRcFTUX1s6etL8zMiLH7MwzO+JkiB/qwYWlCHKe
         tyFtt3SnytoXy/NBgEWiOLzslRefJA4kOFZ5hX3xrl07I9jjbuLQ9swCyHjmMmUScIBm
         B5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687210; x=1770292010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpvdzmSa+i+pWFFmFsuGVs+kLgJBr+cyfmxqCcSStVY=;
        b=tBNFxGbCMGpoGLkC+KE+IqJWahUUIikiJ+ujrbM3+KkDFbg5dUMkb+Y0tRTnXqCAOq
         /dC62NUQXSOLYxjVgFpq1mTDH7ZnJkmlieegEpI6MqlINXVnO3Dlslu2DSNHaZ8IY9l8
         0PgIbDbBUero9+7gTrJMAvLeAgthkgcfY1QG64rS2HFQct966m09jXn7neKUShOwyHaR
         jAUkUVvOc1WgY7wZgDqwYDfPdAAPanWXfZp/D3dqk3qT6pjn5xo7OrQdOENWYzHUUYXM
         5ZIBA1wLZDqSCOP1qpYBTLZFea33Vz7lOiz7MFOWUEhVYmqC1JlDOx4OAuD/roPpiEOa
         hRdg==
X-Gm-Message-State: AOJu0YyzhZQzZ38mSjrzrWspWvs6XdC9p3npUj0Un0U3IH7YLwSgqfbI
	QX8K0wqVxAFltcjbrUyjYwjunUvjLb65p3czsLSlN7zt7m6vRGrsBlPQnmhkP1nQoRbCTHT0RUA
	ykg1U1PXGiVIJAnAex93Alebe2mn79CygN5t3mQrbZiqoOhZ2nLmf/JMPog==
X-Gm-Gg: AZuq6aK/caDCYN4eKjUIEwo3iTXLSHaF7wVakvsKTL2GpqHiNAV1m0fsHwWo18UORld
	EPsudPceTHkE1Ex8oUxu8vTzwtTJVcpRckk/OgU9WUzTml2U80UFF1+AqR02yu62dHvAzmFKNp7
	Y7hfZR/oEEqN7oLpt0DCqMI4V3xu7zq9t2fWJYbCNIjxBn9avkA0pm3BzQwgZ2GkFqu5J9ntHqP
	YokS7jLX+zwyiW6s5YElxn7JcdDN815AlaS58ycHyG42Er8MmPlzoY047wAvSb0zhEOLmv2GI6d
	NegW32fmccuh93fucpdDZ1KKL+AXLNEyb2Asgt6YRd/J5HPYMyYVSDEP28loNqARb++in3o8f7u
	YopWNDmmpUdyi
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-48069c20e88mr107550405e9.10.1769687209770;
        Thu, 29 Jan 2026 03:46:49 -0800 (PST)
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-48069c20e88mr107550105e9.10.1769687209355;
        Thu, 29 Jan 2026 03:46:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm123063015e9.0.2026.01.29.03.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:46:48 -0800 (PST)
Message-ID: <62793715-5fcb-470d-85dd-77472e410df3@redhat.com>
Date: Thu, 29 Jan 2026 12:46:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v8 3/8] net: wwan: core: split port creation and
 registration
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, mani@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126062158.308598-1-slark_xiao@163.com>
 <20260126062158.308598-4-slark_xiao@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260126062158.308598-4-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-254775-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9431CAFC87
X-Rspamd-Action: no action

On 1/26/26 7:21 AM, Slark Xiao wrote:
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> 
> Upcoming GNSS (NMEA) port type support requires exporting it via the
> GNSS subsystem. On another hand, we still need to do basic WWAN core
> work: find or allocate the WWAN device, make it the port parent, etc. To
> reuse as much code as possible, split the port creation function into
> the registration of a regular WWAN port device, and basic port struct
> initialization.
> 
> To be able to use put_device() uniformly, break the device_register()
> call into device_initialize() and device_add() and call device
> initialization earlier.
> 
> While at it, fix a minor number leak upon WWAN port registration
> failure.
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

The series LGTM, but waiting a bit more for Loic's explicit ack here.

Thanks,

Paolo


