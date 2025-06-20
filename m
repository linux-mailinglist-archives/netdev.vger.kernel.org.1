Return-Path: <netdev+bounces-199757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CAFAE1BFC
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA387AE328
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE328C017;
	Fri, 20 Jun 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUm+WMZ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7E1754B
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425664; cv=none; b=eZwKMgUhWi71yvBjO4lKONmqhrhp7GnyNLyUkaOhnMqtbeWRjqbPGGvx4o6EIu1V0n8lfXw0LOY/pfb9TvhkQOFfU2wRmdfRRiwFgKgvk+BuwlAqevR5eUgn30rBZlT+SJN+qbAQP2v/85LLYYCCerJJE3U0rUNuq2seX/o+e6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425664; c=relaxed/simple;
	bh=m++IWIdhWcOcndZZ1RdUUYfFhpUVf+EYrm4S0Wxh/7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP74p+GgRTIY+r3FR51yHDg6/jBnLT0yLvLNSTbOJKDoHA+OOxGemd7ce76iSbBMWwFHKzstsbyfFt/sWAhh24UDRJ1NpwH68i99fPmP5EWvc33Mqx14/GqgCM3+Wzy3FRavv9sv1aIfFMgtuzwV+eFbAJnvDXT3ezjfIAqqxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUm+WMZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750425661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrbqyOjgClJljme6Y8IBM3ztge6H5cPgaXJrix0YAsM=;
	b=hUm+WMZ2A7QejRXsToGjKQ/+jBlSeli6ZcfjjqCBb/n0cxDPBr8HIjqXZF+PwBkWQF+baY
	1qpBnltrPiHhfNn2zsaQFOsT6VsKpOb4QnGzpLcdWzSGwbsLK7ajLmiyaS5XuTBx146jMi
	KPJL2/3Ae29txkuCad8azLZAiUjeqQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-FwmEvLSTPIy-YiZj-5oXHw-1; Fri, 20 Jun 2025 09:20:59 -0400
X-MC-Unique: FwmEvLSTPIy-YiZj-5oXHw-1
X-Mimecast-MFC-AGG-ID: FwmEvLSTPIy-YiZj-5oXHw_1750425658
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso1065499f8f.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750425658; x=1751030458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrbqyOjgClJljme6Y8IBM3ztge6H5cPgaXJrix0YAsM=;
        b=MeizFGNVCLz+FsrMm0h9R3LSDqLUarDDWwBJ7AI+IA/v0e0gZ7PbfZ/wy5qQFMK0e6
         987VoEvrtl5xCyLtMWrQMgmsErGUTSQYptK2qf86CFNpDhWlJvlm9CM1Ma41vp8r8+3a
         PqMME3jXWG8YWg4kR/dptPrFkB+Ut9y+4vzAiSlTBkXtfCHQDxGysFRhX5e3Xjd6Fzf5
         jdxXJ7CLGTAnUsGDCiMqmBrIDd56T29rFANEaG1CCqrCbLYm7kr2U68kext49TbqG6gL
         7bzNkLhMSzrIjuFI4ARuiBvF/2Ouoy1GofIRgTREa1KL5t16uerZ4LVBk5sU8F6rpKBx
         +/ig==
X-Forwarded-Encrypted: i=1; AJvYcCUxt1warQnvPX58vm4UcQ0JKKUeKYxo5quVYPoZMmE1bk2mjjNgPxWXa7W4KNd96DSDrcA0iOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojeHgYOCDUUrbmVrr/K7nStc/CpzDQ7by+IDdETm6DsNkw5Wi
	6BxWcKd9LO21ipkyCeAUKsOTur6DetVSMQQhlDuymWHyWGqm8PUggUTZc1zqa+WGdLy/AKUKfBJ
	YrcmvS6eqhUi9CSJUkE7Fe2fxerTp3yhhR088w1PPZDiufBA6925JsV0AMw==
X-Gm-Gg: ASbGncu9rPUttaFbKNw6F9r/1K96/z0v+N+09z5H1bDKKgYVfCbcNVY7rU75oGUVEZ+
	uEmeO+uwBR3YInfEb+m1MGc/94oP0GLvdw+J1L/PN7RSZvVt1rLNznNAVInFBjU2+ffX395rfzn
	ZskmWNeswLcJCkfAsBA5juG6H9w65492DNVndAhVYnoYeLtOuXlJJpcrLgeD76N4noWRA4OHCEV
	40bscOQBvmzoTCgAn6vNBh7S7togEFbGntKYPM9gTsmxOUgbQ2s06heguUdDExpdiGYOKfjx0lm
	SLNdpvVFTtKrDwbISE8x4w8yTKY=
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a6d131787bmr2056463f8f.27.1750425658397;
        Fri, 20 Jun 2025 06:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9QRtkvxSOLn59Do52l3ix3GhLfK1cWTxETb+z/cJOkSsbedauMcmLKrjvI5kUALGNlARMfA==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a6d131787bmr2056441f8f.27.1750425657878;
        Fri, 20 Jun 2025 06:20:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.146.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0ec947fsm2106321f8f.0.2025.06.20.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:20:57 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:20:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
Message-ID: <cg25zc7ktl6glh5r7mfxjvbjqguq2s2rj6vk24ful7zg6ydwuz@tjtvbrmemtpw>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
 <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
 <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>

On Fri, Jun 20, 2025 at 02:58:49PM +0200, Michal Luczaj wrote:
>On 6/20/25 10:32, Stefano Garzarella wrote:
>> On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
>>> Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
>>> Make sure pointers remain valid.
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>> Call Trace:
>>> __x64_sys_ioctl+0x12d/0x190
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>>
>>> 	switch (cmd) {
>>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>>> +		mutex_lock(&vsock_register_mutex);
>>> +
>>> 		/* To be compatible with the VMCI behavior, we prioritize the
>>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>> 		 */
>>> @@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>> 		else if (transport_h2g)
>>> 			cid = transport_h2g->get_local_cid();
>>>
>>> +		mutex_unlock(&vsock_register_mutex);
>>
>>
>> What about if we introduce a new `vsock_get_local_cid`:
>>
>> u32 vsock_get_local_cid() {
>> 	u32 cid = VMADDR_CID_ANY;
>>
>> 	mutex_lock(&vsock_register_mutex);
>> 	/* To be compatible with the VMCI behavior, we prioritize the
>> 	 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>> 	 */
>> 	if (transport_g2h)
>> 		cid = transport_g2h->get_local_cid();
>> 	else if (transport_h2g)
>> 		cid = transport_h2g->get_local_cid();
>> 	mutex_lock(&vsock_register_mutex);
>>
>> 	return cid;
>> }
>>
>>
>> And we use it here, and in the place fixed by next patch?
>>
>> I think we can fix all in a single patch, the problem here is to call
>> transport_*->get_local_cid() without the lock IIUC.
>
>Do you mean:
>
> bool vsock_find_cid(unsigned int cid)
> {
>-       if (transport_g2h && cid == transport_g2h->get_local_cid())
>+       if (transport_g2h && cid == vsock_get_local_cid())
>                return true;
>
>?

Nope, I meant:

  bool vsock_find_cid(unsigned int cid)
  {
-       if (transport_g2h && cid == transport_g2h->get_local_cid())
-               return true;
-
-       if (transport_h2g && cid == VMADDR_CID_HOST)
+       if (cid == vsock_get_local_cid())
                 return true;

         if (transport_local && cid == VMADDR_CID_LOCAL)

But now I'm thinking if we should also include `transport_local` in the 
new `vsock_get_local_cid()`.

I think that will fix an issue when calling 
IOCTL_VM_SOCKETS_GET_LOCAL_CID and only vsock-loopback kernel module is 
loaded, so maybe we can do 2 patches:

1. fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
    Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")

2. move that code in vsock_get_local_cid() with proper locking and use 
it also in vsock_find_cid()

WDYT?

Thanks,
Stefano


