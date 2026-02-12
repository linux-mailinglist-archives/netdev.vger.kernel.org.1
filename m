Return-Path: <netdev+bounces-258412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJKrEjZ8jWng3AAAu9opvQ
	(envelope-from <netdev+bounces-258412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:07:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BFD12ADBD
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594683143099
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2E29DB8F;
	Thu, 12 Feb 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKWRBbFz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oWbBvRbB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F628F5
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880002; cv=none; b=UaLRVH6jIEr3TuzxyE1R515K8h4BHhxIhrJiiwJKxK3BCC/NveMull1eS/zMSm5WSyKmSzBnnr19F/Jn70hH0Gfmfrz+/L+9fU+7qV8tRb/6Nw2U02KmX6UOlwZzvnERjVTC5ggsh2Lb6gGTdqYXvwcWYlfVAx4QmD4pCY+z1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880002; c=relaxed/simple;
	bh=g9HYPhHqcbaoctrpbQtbxiphE+OHyOHOP6Q7Eyep2RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4ceH/GEv5MYRV3H2ArugQ17aTiEFRH+r7OmLLw7/QOSagoY5nM5lkVN+pavQVfVkSD5l1GXExpkffpFU1g584jULv46SKt2wS8Be4RjavGlUPi2CiaGOs33kkh5zZ1m99U4R5cWZRTMchYrZo3guB85VXNJKm7ZdrtQwE/jUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKWRBbFz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oWbBvRbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770879997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSQGsAVLVUl/sL3M3UFHxDkkSBw9IH75zh0vjPlYmyg=;
	b=RKWRBbFz2AW9No/dTLA8XHUFVXzchyrahzDLWf+vCNMx5vuD9hAiqbt6w0kVm9M+m9mPbV
	eBFNxs4rkHJEAXtGvjJFKI6pPLRsaCHnxfImsFYOLBAqa1XfvSUft0gKwp/T3MeJw2aOmO
	QrV7p5DBSF4lcrP7AdGd+/fM5hYU6Jc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2fYB-CvgNlefxuwDumzBGw-1; Thu, 12 Feb 2026 02:06:36 -0500
X-MC-Unique: 2fYB-CvgNlefxuwDumzBGw-1
X-Mimecast-MFC-AGG-ID: 2fYB-CvgNlefxuwDumzBGw_1770879990
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-480711d09f1so38063635e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770879989; x=1771484789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSQGsAVLVUl/sL3M3UFHxDkkSBw9IH75zh0vjPlYmyg=;
        b=oWbBvRbBRTXC5y5pmjw3TQ7Vf3ygE9voPV0kPrP93gaZxlfY0CTzABoZJlNDdxfmUT
         hK3m5Ek9/HXC8ecvB/7UP5J4kwu5QIzZ0Ql+jA0NsPgyZOn7P2sLCjg5QQgpT/ZL4dn5
         wzmZmc9dgkdRb8ZolaoF3p6XP+aKvDKmOmWn0y5faGoWwvVjW7lh+akRo9/ouMYwoqMu
         g+Xw4mARVA8jXq3SgYGm7/GOqA+cvEpcXXH0P73cGxC8rFFHyMxg7tEDn103cH15cmRQ
         xml+uv52Lb0ZzgTrrW3h/XInhf2fp0ncO9B4vDpzs3ItkM2lw+CmRDMrl9cnupBbeoPv
         FRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770879989; x=1771484789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSQGsAVLVUl/sL3M3UFHxDkkSBw9IH75zh0vjPlYmyg=;
        b=t4Z7lZiZIgZhTVfVjJwhpB+FpXw6JEf9jrrliz+XP6QY7rlNpsyHybjw8ifkEmk+uc
         kcLyaeM42LuAmeUAVG+KcDWD2S6ycSjkpkNTGN9TYQvYeBn6C8GmIKyyQ56aAgqyx+CU
         KJM2FO8PSSpVqzlzMYkc+HAv1UgX82iSqu1EDp604SLSVsb/sHiOIoV3ZY1r7z1rey3l
         G85iiRpBxJx6Jts+rok0GILf2puiebHY+S5m2NlzXcNnnHN6Dro4C6ADxuadbSimQeP+
         YYbAi19Z/X9opCIPtxCDATgSvDjvR975qGGpqsgTgIULHEC7f4TkL6bsCSHSwwgC4PdX
         HGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdLE9UeZjcNZbdGDUU6hxAiuJBk40pLVfZoU83h+Hw/a3XthxQqeuG+UqCW+iUCCbjyysuyvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH/1ol+m8NJyQXUIpE3IPUjSe3Hi3ZUZtYLdFclcixMVl+wPB
	Zk4PzY6PEKvOKih/bCjq955xUU91Iaya+w40lkhcTFSDJaNbjF5IBWGUXsWcPSASuxUxiV3neut
	Anhqe6lmoKg25QWm0fzPO5d29Lw37rvmhzdIep8sS3Pc/Q+nzLunL0yVaNg==
X-Gm-Gg: AZuq6aITlvuywZUoIxPfluWm7v+gj1ucPGdpxHiUyRfjSs2FqL6W4a1IgR2pQOe69ZP
	eLbMSFB1vy+ffVZIRDTz/ksNY9s4yTXs/SXIgCK9KnNrDozRBNvkIMajjYrBQmGlJVmpUFJ1fKf
	M35L1QfFxfGt1O5U17jAdhqLzMHQjpgOluuDNXFGjSR6n/XnJ5UPjG6XiIwx+j6PFLhkJlDuN6N
	z+XFsNeS/050/wV5RDwyaPg+B6LWd2M1mQJqtqhMiZziStrJW3H0+U+ZkyvvZnnB+X5V1B2RtLU
	A75iAligId4Z0v/ZDfLJRIfqwOfcCnh3VYtasxNbPa0OTeztFEz816l/xm2G2CMBucaihdCZ/mG
	wxMwEZjG063jOda656A0W3/iNNHHM62ANhV4obAP5tIvHIg==
X-Received: by 2002:a05:600c:4e02:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4836710d797mr16270845e9.10.1770879989528;
        Wed, 11 Feb 2026 23:06:29 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4836710d797mr16270405e9.10.1770879989104;
        Wed, 11 Feb 2026 23:06:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm251666615e9.1.2026.02.11.23.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:06:28 -0800 (PST)
Date: Thu, 12 Feb 2026 02:06:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260212020317-mutt-send-email-mst@kernel.org>
References: <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
 <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
 <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <60157111-219d-4fb3-a01a-6df9a83eae7e@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60157111-219d-4fb3-a01a-6df9a83eae7e@tu-dortmund.de>
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
	TAGGED_FROM(0.00)[bounces-258412-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1BFD12ADBD
X-Rspamd-Action: no action


Simon is there a reason you drop "Re: " subject prefix when
replying? Each time I am thinking it's a new version
only to find out it's this endless thread where people quote
>1000 lines of context to add 2 lines at the end.

-- 
MST


