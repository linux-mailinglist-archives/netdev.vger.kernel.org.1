Return-Path: <netdev+bounces-253050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KopHQd1dGlI5wAAu9opvQ
	(envelope-from <netdev+bounces-253050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1637CD19
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E19A3009175
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53629D28B;
	Sat, 24 Jan 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi3yEZzp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqmwR/Rl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903A287259
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769239813; cv=pass; b=NUYKVSE3sm6RZJlDVf8vtSYIeahhgEkWP664N8ueohGbv6Z6XL+Js62PS2gWkGLn3JTD1UtlKWRqMzEqFEU13bCgUa87cUy+E3o0ubVNcEm4RAhFTE25SxbP/Il+S9gQLPOxtceaJrt4az8SVCUEmsJY8Ct//t9VaBYB9nA/BHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769239813; c=relaxed/simple;
	bh=e1ixly2/NjoR2aaoEVfMiu/QisgbcNguvOb9Kj2chmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhMkDDZz9DgmFSIIVgoshAU1GcWCuDS3+Q7JZzu+ZVzxi4aTmXsCU5t4NDJXR7jUwVQv3kmkc6My8472ZmSx+TDuY/6n28MbqMUtN/4gg0P72RM1VZljjhgJtK+Jnb19hmvmSSbZBuY930YgWCl0Gnn0orgWCdlp4rc5LzsEquU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mi3yEZzp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqmwR/Rl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769239810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTm852yTZfC4kegOsHtlkLTPRpkGn8HmDIJ+Htyp5Co=;
	b=Mi3yEZzp/SA3n5ZFYCjR95HD8VzaJBv1PVnprjh9e7hOmYmyDDFQt4iR7JQNChjEcKrnL9
	5P7BHdfWiN4ulEg+zEZVN20l1iHUVz1w9twW2MQ8+o98Rp95Zve27lz/63777xcY05k+rv
	UkbsenpovGmpH7NLlmUPXNZzRmxhQr8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297--Z3L5FC7OLWXg-uyW3vysA-1; Sat, 24 Jan 2026 02:30:08 -0500
X-MC-Unique: -Z3L5FC7OLWXg-uyW3vysA-1
X-Mimecast-MFC-AGG-ID: -Z3L5FC7OLWXg-uyW3vysA_1769239807
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6582edb3894so3538221a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 23:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769239807; cv=none;
        d=google.com; s=arc-20240605;
        b=SqZujclK2Ip7nkR2Sdkj1N/ERKBbYllB4QGcrm1gAYxvAes/crS6BoQWWjn/ALMMqA
         iD89giywL5soUJcGgQ0C3Xp8RoT6XUVVRdNe5FNt5eHk41i4wRoNuShIG1FfqGM2Dwgk
         9W/PW6Pgojk1WR4JdfkeuojuPUmdupVVibx0HLDlIt7JVPp2viwxjpCoFJGNbqiX/3D1
         NZBkYFTAR5A+q1w6sprhwnADBmmR65vB8vjArHCyLiQ16XT+bvGBVvqpbpnNw2e3yaoP
         YfrQyIO60wu8awKaUAKQ8F0Y+MVIqoRCNte/TPd2Zj37wRKAO/BSMnZfS9bPaME/o/sP
         uHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hTm852yTZfC4kegOsHtlkLTPRpkGn8HmDIJ+Htyp5Co=;
        fh=n+7+Gd4IqvJqSt7cg9y+gzCsGxuIUCES7WPGkjksb5g=;
        b=OlSTECo0IDHh2ZMpF5Scbig1/y+2FL3POyqCxl/UCQZeKSb9YCF1EkmcALg+xCGbg8
         kAFaHKXBVyMtG72dOf8vUwLEqIUT55ZHWqR43kthHRSrHP+hs+Hpu81x0jetC8B/Aufg
         CM8ddgYTrbAnQ8QoeDDoK+jDMgY4NCRKmi6e9kTVyFu9H7vUGHDZIM7MIVQzzIgm/goF
         UeJOrh7bqX9/YcVkgCFvUCGu7NjeB7VSZXL/Grmjq5VFAN5p7wK9D5TPz337RXnpUu/a
         /65YFQUpaRXzgoH+T6kO3Iptmhi9FD3PMW/VTE1UKMUsMpwJ3Cc5s81B2KSwUy+Zsrci
         zVOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769239807; x=1769844607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hTm852yTZfC4kegOsHtlkLTPRpkGn8HmDIJ+Htyp5Co=;
        b=cqmwR/Rl3DFvSx1DZ8WTR4VjGmM8zjL+Dah9T3wMOdNz3SW9kcPZNMPqL2ruBBIlxv
         aBT5m0otRh8a+bt282X/mqsUayEzUw3ZsE5kNchCM7TJCnxJWho8KEZZzUV1dtXw66tM
         5HfbOxgwv+Agz+Ghwphx0PbOYysFAAGAVMSFVrkMa4Qu51QUqCMS6k8aURri2c+ngy8/
         BUGYEcSAnj5XavoPzn4N/Nnf3ChnzipNEtYPmH2706IJwRu96qQ2syKrpOBDBxYf/DnQ
         5Y8r3C65uP/ur7KU9SPDIK7IbBKtS8jVGkyXncC+/rlEktlez7YjTXGe4MjV/lDrpddJ
         QvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769239807; x=1769844607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTm852yTZfC4kegOsHtlkLTPRpkGn8HmDIJ+Htyp5Co=;
        b=uL+klXQg4XTCWamPB29W68/SQK56CD/OT/9ceYjrQpDk55+UG+fKIRlCjJZUUDB/I/
         l502MddZNUxgqRWkAekVkec0s/EWjqUc644t9hl/XGC79Tn1gB6VVfeEnLXEVl252HUd
         u6T4apVKs93aeseXRPnQJ/cXjS25WwliKGBrUdB5lUCr39vdYfMTXymkofyFH/Hl/9sH
         m4v7hLqYJ3oAyQN4O5i9A1zS/DXo8/v6c1Goi/BlxexlnA2/YlLrPwPTUHvAfdhliQR0
         U1m6BUq2kSKocPyalbPH7U4BN3S6aRiP1/7ZgFsJAun2MuF1GDglG03MyS1RuUCRvlRu
         JD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMlS4Ws35tOswcNroFUL1rv1sHz6ulqV+I+0cfNubofnaIi4+wFrwuVR9+dkV5R3+ZPsGoes8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/xcF778Btu+m0hGCx3hId14lu4bOChwIhjfrwvCtZBxNB63s
	3iW1KdtYzHkc1+jHWlMPs3/E1r1KqXa1DspZiLo+ZNLFOJHgu9f9DV4oH7wtpyE1buscTEgpt2M
	WqTtEy+I4CmN8QV36i8sN607/zN2/o6Lt5b3VWH91BmzdSfJnxypg9IIcNRHu0Sfycib6NY9SCg
	K9qNbhvRnmbhvA/mvuqMWC27/Mjl6cJUWx
X-Gm-Gg: AZuq6aIsiS5Q59Gv+gYk0P3d+j00JxvtDuXo+cllSVmJ2x/Qq9sq2HLwkGBbH4SHdgq
	/fAQZSuhx0g7OVNdOquvGcL85byx2ARMrUmasde1AFq9/w/ZOdR/1eipJrBm3o00scqcp6HQF7k
	yJ8qXIoGJjMGhkNZAUyWkIdFAWjrxecWL1mDuWFs3OgPd56Rg/sIg20yAyZTKEDYg46FQ=
X-Received: by 2002:a05:6402:1e8e:b0:658:17fb:4890 with SMTP id 4fb4d7f45d1cf-65853cfea9bmr2031766a12.9.1769239807003;
        Fri, 23 Jan 2026 23:30:07 -0800 (PST)
X-Received: by 2002:a05:6402:1e8e:b0:658:17fb:4890 with SMTP id
 4fb4d7f45d1cf-65853cfea9bmr2031753a12.9.1769239806628; Fri, 23 Jan 2026
 23:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768979440.git.xudu@redhat.com> <b5787b8c269f43ce11e1756f1691cc7fd9a1e901.1768979440.git.xudu@redhat.com>
 <20260123114312.6f7c441e@kernel.org>
In-Reply-To: <20260123114312.6f7c441e@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Sat, 24 Jan 2026 15:29:53 +0800
X-Gm-Features: AZwV_Qh186JnYHMq_Dc9JNMDPpSXsLrjlvHGtwp4k7P6haU21KBrdjwoc_oemx4
Message-ID: <CAA92Kx=ZF3Tp9fh3q2sCEmyn_kfemMjMvzPKEqkk8-UJHQXHqA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/7] selftest: tun: Add helpers for GSO over
 UDP tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253050-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC1637CD19
X-Rspamd-Action: no action

> I'd be tempted to allocate the request in the here, and instead
> of passing the "fill" callback optionally pass in partially /
> pre-populated req. Just food for thought in case you'd like the idea
> and what to follow up. v6 looks good so I'll merge as is already.
>
> Thanks for converting to YNL!
>
Thank you for accepting this patch. I will consider your suggestion later.

-- 

Regards,

Xu


