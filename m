Return-Path: <netdev+bounces-299870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWZOMFRdMWqEiAUAu9opvQ
	(envelope-from <netdev+bounces-299870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF66907A7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WFPLgVWZ;
	dkim=pass header.d=redhat.com header.s=google header.b=FNzC7M3Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299870-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299870-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5045230310F5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3B376A19;
	Tue, 16 Jun 2026 14:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F623385AC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:26:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619989; cv=none; b=Jr9+40DqdCOY83eETuSNzQfeDYu0ZIZkIvLYBXJyHYfx1Lf1y4zp3UmoSUvUMNpS5sziKh0/KxAKbnvh9ul0iAbV042kiTJNiy0g9SqsQmR4SDR8tfhTIvluiDCmCRv7zOO7Ite/XsJaE8FXhzo5nx2FrL/FY32cudMrC0XThOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619989; c=relaxed/simple;
	bh=2FtnmkA6sYVjNf1cUAA6sjpblaIDR9OLH/SC1eJdstY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TInWljQQipppF4SPjGyoeHC7JlRx7rnWoY97LM29jve2khgRUVgHZn+uKLIxOvEVPdh1jL/1IDw1bUCnlHF8OU1jlH9z4AKSUb1cbSyT3Uxc8bDPuNWc8ROUqlUsFoIoTSYEjBUMAa4cQXQBBAVUPquKVcfqwaQKsx2i9Ymz+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFPLgVWZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNzC7M3Z; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
	b=WFPLgVWZaM5XshKGqaS3O479q/pcyeydlSO2TxXHDyEkhlqLkgTTqw5gHrzx6ZjkrFm445
	lIyFz9CulitOLjzDRiI+o/YJZ+JdZVYJR0Z+VN7G8nz0alG209OJ0L32PYfnuJjPNpXC+5
	NwM5GLIA1GBvBmLW5D7lME6RXuzBuRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-nbe7kqQQPHqbAMU2-Ox09Q-1; Tue, 16 Jun 2026 10:26:25 -0400
X-MC-Unique: nbe7kqQQPHqbAMU2-Ox09Q-1
X-Mimecast-MFC-AGG-ID: nbe7kqQQPHqbAMU2-Ox09Q_1781619984
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef63d1214so3007782f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619984; x=1782224784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
        b=FNzC7M3ZEcquH5Fh+MJ5LvOIRbOh4dE3tSW9dISD1vwewkWZt9rSFtYsNCw3n1UINw
         hXnNtzHZhVyuHadmDI6zlIXL0gnPUVmissZE7eaBI4SUbmc6jnga68VkZBt8PaTlKEVE
         oZJ9FIjSos+WB3hOg2FjQ9DS2GqbfshrhBQCVcurjxSnywmoa0OUtAKVTHl/UgCxfnIb
         JYIA4MZCkj+5O3edgfJ7L9xc3wkE5Btg3gGwJOCJRbUwcY4NNcCg785mTz2ItJRd5tb9
         Nq1V4Hx2/zjMZXzwdiQQksnVWmOISsgL1sRuOk3JxwTCGm8hb0WO1HIG2srJmr9GoSev
         MiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619984; x=1782224784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
        b=EtPzw462xJC0hO1WspMbWMxEGP4PZa5mTDHezaattKeY0/KFEAQDZBbhUWAf62V79B
         4/lk/ThMPVOLNs8q8vDXx3WnIp6Wobtq7uQqzBAsOj5gXms1sUC0zh7JnAU432f+0aF4
         saiDk8TUOSIQsFsc6ScHYJ/4XQtwUEYWKmfUditNZTID8mGOeWVQU2QYE2IlPeltTMJH
         hLnaG0lxFo6JliDAbnKqYEmeJ1ehLRYJLX2r+WmCzzJJFfVezw+uxZrLcx0DQGTTR7PM
         C5JOSK3tJaG3gSP8aFZyrba/5XLsghxt4biLQbzyZOk/x54lPzfiWPqomgi8WBiWSUuD
         NObg==
X-Forwarded-Encrypted: i=1; AFNElJ857wFBr05tbKmH+6KvlOCKcs+C6xlfGnyyIO4iN66gBjrrGkqjtF/Y5LRUfX+2RavYcRkW+XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNd670q0KBQKtrklm3K4hMxErkzGRVWLrYaNapDLrG8P2lBnMn
	i124eZxLtkngfMjm4nlANg3J2UjgI9wCjZy7Z40KiUgHnhsoivb7N/O94udmZcupp7dGMcH96uY
	/DTH6bgWLsMiWFsfGaNjQo+yVcp+wn8+Kr4tS0l3hHMTIVfP5olm/3T1PpA==
X-Gm-Gg: Acq92OFxcc5MeZf/TguOV5w6Q7KU6m5aDJBE4ZjvQeOIuozJbaSFQBK+4jaAu3/jXZR
	Cp+6DhHN6n9dP+RBSg8L30BCNDj10qTee65/8srvqJq1ndqQh2GvktdTWSZTjZlc9EHD+yGmzZA
	y6pG+zcScI8y+P2QgxQoN2RSad+6bTabLo5O6gtCCHm+mVQRQ9S8r4iH/9/EU9lQ1inFR95abMu
	GvKJDZMHcwsfaZ3oDTfFmPw3+QjeOpEia2tWE/5wyk08uQJb1Qe9RlkB0lQLfb9wo+/WyAcHxIw
	cDvioh2u/kuERxOb2FYnOlF3GOt3GFvAYal6qfyOy4v+hKhDqGeUQixfRlsCoJthAZDWe219UnK
	Q9xPq/Fs81s/s9k60qUhySqpy+lrkWqM3NjygavwlMuinsBEisBInbmLmH59HZ387EhGvfn8=
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6376240f8f.0.1781619984270;
        Tue, 16 Jun 2026 07:26:24 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6375916f8f.0.1781619981390;
        Tue, 16 Jun 2026 07:26:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51566784f8f.29.2026.06.16.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:26:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:26:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFcf00nmUcfqofx@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
 <ajFRRmA9req1muX6@sgarzare-redhat>
 <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299870-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,vger.kernel.org:from_smtp,sgarzare-redhat:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63EF66907A7

On Tue, Jun 16, 2026 at 05:10:38PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 4:48 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>>> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>>
>>> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>>> the guest with vhost-vsock device.  For this to work, we need to reset
>>> the device ownership on the source side by calling RESET_OWNER, and then
>>> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>>> AF_VSOCK connection while this happens.
>>>
>>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>> ---
>>> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
>>> 1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>> index b12221ce6faf..e629886e5cf8 100644
>>> --- a/drivers/vhost/vsock.c
>>> +++ b/drivers/vhost/vsock.c
>>> @@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>>> 	return -EFAULT;
>>> }
>>>
>>> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>>> +{
>>> +	struct vhost_iotlb *umem;
>>> +	long err;
>>> +
>>> +	mutex_lock(&vsock->dev.mutex);
>>> +	err = vhost_dev_check_owner(&vsock->dev);
>>> +	if (err)
>>> +		goto done;
>>> +	umem = vhost_dev_reset_owner_prepare();
>>> +	if (!umem) {
>>> +		err = -ENOMEM;
>>> +		goto done;
>>> +	}
>>> +	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>>> +	vsock_for_each_connected_socket(&vhost_transport.transport,
>>> +					vhost_vsock_reset_orphans);
>>
>> In vhost_vsock_reset_orphans() we have:
>>
>> 	rcu_read_lock();
>>
>> 	/* If the peer is still valid, no need to reset connection */
>> 	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
>> 		rcu_read_unlock();
>> 		return;
>> 	}
>>
>> IIUC we are not removing the guest cid from the hash table, so this
>> check will be always true, and nothing is done.
>>
>> So, is this call really useful?
>>
>
>You're right, and it's most probably an artifact from mimicking the
>vhost_vsock_dev_release() implementation, as mentioned in the comment.
>In our case this whole iteration is a no-op, we better remove it.
>
>BTW earlier I received some feedback from Sashiko AI reviewer, which
>also spotted that same issue (and some more interesting races):
>
>https://sashiko.dev/#/patchset/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

Oh they seems similar to claude comments I included in my comment on 
patch 3.

Yeah, we should takes a look, they seems real issues.

>
>Apparently it only CC's its reviews to kvm@vger.kernel.org so you can't
>see them right away.  Just wanted to let you know to save your time
>here.  I'll send a v2 with respect to Sashiko remarks.  But of course
>would be great if you spot some more issues here.
>

Thanks for pointing that out, but in general I try to do my reviews 
before looking at AI reviews (both sashiko or claude locally) to avoid 
to be too much biased.

Thanks,
Stefano


