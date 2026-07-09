Return-Path: <netdev+bounces-306166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9zwIBbZ4T2pkhQIAu9opvQ
	(envelope-from <netdev+bounces-306166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BE72FA0D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bV0TASq3;
	dkim=pass header.d=redhat.com header.s=google header.b=kmPsuOUk;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306166-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306166-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8924E322DD49
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F1405C4F;
	Thu,  9 Jul 2026 10:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D63BE632
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592004; cv=none; b=lBIy9a9KbzarNL3LipvBrL33bb03bA2LiUpkem26UzFEpL2M+BBmmpkYMqD59YHmk3rplqnGVEvYADoLBQVdCaG1/s5kAdhB8NHbZlN+2L06dVXNpaMn1REMAKP5FA7TRumJxmtwIg2EZv9RsE/FkyVsvK7YPVGNdLj6sTtQdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592004; c=relaxed/simple;
	bh=yVuRczH0g0eYvB9MYnasgH+zcFLAlDOQbgaGV7yIGOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXIJSxydz653//4laxABPdlrVcdqI0BrwmmdSqzyiJipjBxVP3Nlhmj+W2XAfygAxwtJ9n1Ydv4UAx+YUcrN/FnQlsE6kBkGm81WY9M9DWn4KrgrlXIbEz30JZg49pw1XINhkIKRCKyeM9i5sjss358l1NtgkSBCToU/sHVJ7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV0TASq3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kmPsuOUk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783592002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjsH/O+2pHPUItGZGeF/WLuFKLrjsa/woFBHEoKXpTU=;
	b=bV0TASq3VbXBMNonoG4iTphBoCVZhRqdSCEkyYOYrfdwpmoNwEturWKyqEMexrDBkSc83o
	gUeeD9j4Xue6+Jt9KXmp5araFuhVVjlLCNm2f6mr4owys852nbbuGWY9FTLpaZHE9DvykV
	KkhyG5mXGoGJJWv/0SsVLw4gnCPPhSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-qWObnk98MpK1H7JpZXb0Xw-1; Thu, 09 Jul 2026 06:13:21 -0400
X-MC-Unique: qWObnk98MpK1H7JpZXb0Xw-1
X-Mimecast-MFC-AGG-ID: qWObnk98MpK1H7JpZXb0Xw_1783592000
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4729d2a64efso382404f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783592000; x=1784196800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjsH/O+2pHPUItGZGeF/WLuFKLrjsa/woFBHEoKXpTU=;
        b=kmPsuOUkNbVlX2ixDe2HIdp6/vjF3FTKkICoNwNAA1uUYalaaLnMLbgUAR871EUQHI
         9dIIAKT9BRzUqvoSjklM3Z6EDT5XMsYjIJ+E/hlddF6i0LeEa6L2xi9C5ETjRVpzJhD/
         vacFjK5gEfceB40vp2eJJ+f/0vGehzmzlzmyp90vDyXohV6FvIkRzN66Z0LzNEKJfQzS
         d7R2zYfO+ayeVSxsTDlOcYTuYaIPezTF8c+vJZazaY3c/6Ws2os43sqlnNf4yefOGHQc
         9NRAbZSy8G2nFNw227ixBHZEFYUdY4VK0cpYKGRa1G2AEymBBLj9PdZ73PRF/IQ/dyGa
         t7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592000; x=1784196800;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjsH/O+2pHPUItGZGeF/WLuFKLrjsa/woFBHEoKXpTU=;
        b=jHfsRX0OTMgf5Fx+ZHzd0i4bU2bkq5pIpatg54iJCjaKIkOCYqeW0MOFm/SO+wNRil
         yF76vOVgh0gHU/5FzyrH5q2NtiwYTeiFN1rmWSkMsk3X86FzsouvRpbdMH+2YdMrt3fq
         hdTf1UGaW7Q6RKbhgRH5KjDvtzh0eB7ooWKky3M8/tfqc5txdx19FTSjU/UAQn+bIcqi
         dA1LwxNpU2YKn8GoLFjrA/oequqSS8DW63vMjBbr8EITGvIda2l/VU/KAwIUfYQAkxEc
         /wWTLtvatobPC9fvQ/85dIq/JUCRfZcuxg3S4aMl6lhiJfIalylgYI0jWDHroiinQYo5
         PgWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjTsUI+J+KnbHnv/5oHGwiHzGzsdl4NI54aCIbE/rxvkiT1O7dahmTrtqtZm0Qwo8NNJi8NlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAODmklaAN01pygdprOggWkzFOjMq52WfcCC8vMLwU6Fc/6Fj
	dZMabBnC8NIs+1CeoR+JvlIpmyDEMozx2DbSutCHAJlB8xHR/a2GjJ/uXzBztWXFNcxBi8CyNEm
	khSeBYopmkjknJwtsUvamfQQGzsVfuOlk95DKGLHxB0qqqe/YOtn3Y0Ibbw==
X-Gm-Gg: AfdE7clUR46D/wZ3tDXmVueJRiCueZBJHZRJhRiYbqVVBmt7VWzaCGNCTLcAivSEuKx
	+S3trJeJ2JigCJsEY9D9aWSuljyfRRI6RxEZ04wvlKjgVvmUy62oLjSNGHvG5voRDlaR0PTT7Ja
	AirXCXVuA19Mosw+FdhVWF9dJy8wYvq0o1d9zTFnRewLmgy7wVDsZ53Rw9Gx/HUmcJK/1xoU/86
	AX9BClefo9JAFrBieqINQCn7FOisXsIVQdSSYxDd7xiX/W2UxPNBJAqbLjGd/U32FlcrW7b5KsI
	N87Lrei1Zo+w5oc5NmOTd0eislRDxBQVB3xzXCeuu9Y9AHWtqXtMe0o96o7eU3GOcpgEDRLluxE
	CEfwd0xuPa4cPKW+yaYvJ0fFkXFLjS+ISZC4CIA9fBNO0vp7VoMHHaiPZ3qhzS4kWEujNSzTElI
	FSSjG0/ovZlpe8
X-Received: by 2002:a05:600c:6288:b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493ec763a4fmr20284545e9.12.1783591999763;
        Thu, 09 Jul 2026 03:13:19 -0700 (PDT)
X-Received: by 2002:a05:600c:6288:b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493ec763a4fmr20284205e9.12.1783591999346;
        Thu, 09 Jul 2026 03:13:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm49363855e9.3.2026.07.09.03.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:13:18 -0700 (PDT)
Message-ID: <e733f981-5856-425a-8b74-3f54d9086d57@redhat.com>
Date: Thu, 9 Jul 2026 12:13:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] tcp: bound SYN-ACK timers to reqsk timeout
 range
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, horms@kernel.org, chia-yu.chang@nokia-bell-labs.com,
 ij@kernel.org, idosch@nvidia.com, fmancera@suse.de,
 bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 roxy520tt@gmail.com
References: <20260702095324.2995243-1-n05ec@lzu.edu.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702095324.2995243-1-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,nokia-bell-labs.com,nvidia.com,suse.de,icloud.com,gmail.com,lzu.edu.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A8BE72FA0D

On 7/2/26 11:52 AM, Ren Wei wrote:
> @@ -1034,6 +1035,7 @@ static struct ctl_table ipv4_net_table[] = {
>  		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dou8vec_minmax,
> +		.extra2		= &tcp_synack_retries_max

This new restriction, even if correct, may break existing scripts.

Since the rest of the patch enforces the upper bound at every
sysctl_tcp_synack_retries usage, what about dropping this chunk?

/P


