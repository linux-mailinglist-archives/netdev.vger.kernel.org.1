Return-Path: <netdev+bounces-294160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHIXBt+9HmpNKQAAu9opvQ
	(envelope-from <netdev+bounces-294160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01E62D720
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17BB305FB38
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1993CD8D4;
	Tue,  2 Jun 2026 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWDREzUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1F3B2D06
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399271; cv=none; b=PvWOulDyHgZJxd4WTlCac8vb+Bm3k4/awBlLA59zY3cmRZw2q0Tx8V7GSUzAXUNtRLoeNkWOLUfue3P7olW0/jPDoP/Mej5hC7Ac+MZ1zV1TZaiRcUn4JEfPBOP/UYId67E0k1OAan8xBhVR2fRG2GUj0/kIkLgLBAqpthHJta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399271; c=relaxed/simple;
	bh=mdyShz2Hb1nhbf16JMmhzAI3lw9uTjlKGNRSkU4NhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZfQ2UUV2IRh2VvIEjVdQ3/904Z47y0INRv7948fXK4r1r560OrL5VTI3L9aoR95H74NgBC4bqQ8OqF0Uz5x12CbUs/g/8krp3dhBLgnOrF7/LFvVykCXKewvoWUenp5jT5Xy+65LS3xs5s6Gb6Al4j6diAOr6gwdUUExzbgNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWDREzUc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490a7629380so23969335e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399269; x=1781004069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=QWDREzUcNvwFfuiuy45CUK0AXWlgdkktBJ+GtFJ8FBXCqyxwgJFlKRhsPar2d2ZSS/
         wF+OEbhaLwx7LV28ZPNWspdgAJm9xUvN96CZwuoAtPTffSCzW/4Fpr6/Mbt9enzRoXPK
         A8vQoiFTbt5B2mNhEoq1uAz7t7WnR63xJyAs9Jqz6Qq8pOBKts+L5/hKYYv7x9LFkOQk
         hLy4CUB02VWElNjR5IpQWxMuofdoGXhNgBfSxRh30zfh3WNMYPoKoGEmTte5sN9ugr58
         IEZwZrfmGvoplpLC/y3c2bT2VXy/rXJ4VUqMPgGRnElRSiMysIq4uug9vXoy1EJesNkh
         bggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399269; x=1781004069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=RLTdVnhM/qhSeahaVYMsun3g3XRaAbAkp2ec+IThbmuEG0w4XgSJJHNYsxNEKCqT0C
         xPltzbqtqlhgEOZ1T8DLsnPlpwzm/mvysLExLKwdj79YJ681QeO50zwPLNJPXXwbxMKe
         x7Sv6wlvxC7O+D66scTer/SXUylGPoFLSM5ttaDbpIo0B5of2bgOulaANL4UEscS/qRe
         eGBzZO35PN3OJw9ICsPQW10bHdoRwepv/HoKQiQvQMfcH0OmgUtCzcmh4tJqMso0cP8R
         uvw8FeHaAfQpfZdykpcbFL8z/szaRAeiP4Pw6fYDAdJuPDQYygyart2wrieSajvVZypD
         GiAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bl5XQRxvySapYs309GGmEDvrary1LE0iG28PaieB9+PON43IOe8wpAZJqCGRMVjgpbqulQXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/V4hU9gcvTpEqImiRdIV+1obYc7/mbuNto7owAwyA6XPzvekE
	vwasC/Uu3vV8fuaA4fr3U5UoUAvJM5Mc6nSox/+rPtvcu+1AWUbL01S/
X-Gm-Gg: Acq92OEQsTy2HO++4H+cW5yC5W6gkdmvqZFBKzcPAYeAjx5f6Skl05FQ98sAgJ8aIXf
	en1cEW/sepgWvFQcBULR/TBj+ZRtKeg8oW+B8K2VZ0KOxs5TqnBA9EhDJNhdq8dlB/ioTM9eQvT
	nUbVUOhT6+i2SddfC8+Gyh15zHhKjITZg9QLR9MIsm8W6yR7kADlaz2yDGRiY/n2765Uv6hNlSU
	7/OsgtKkEngRwLQjNNQ0NR3upMYm1R6xg5xUAgiVPo2qtCY4jA83m8uV1Fhx5aw+ywWcZxUEn0a
	vPcgREefSMA8ZwpTbEUFvPItb8tXFOhVdKIsF5gMBHLszbgpolaKz7+VW1Cf/Gv6TpRWOEusmB1
	CS0vHKKE+qGuK/VufBXkvrl3aQzOOnLtlwqZWjyhxNcAkpQn4lRCZv4L9slZV2udePqWQ3bnsAF
	GF+dnx+yGCV6eOlG50hHaudqomA0ajvnTtyMI+FCZudtzYlkuLi58SWUxabI6jb41weBcsKJQ=
X-Received: by 2002:a05:600c:46d1:b0:490:a7ab:bbe3 with SMTP id 5b1f17b1804b1-490a7abbd7fmr206981415e9.0.1780399268568;
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm31033836f8f.26.2026.06.02.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:21:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, mkalderon@marvell.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
 sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
 jinpu.wang@ionos.com, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, ebadger@purestorage.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260602122104.20afa8b4@pumpkin>
In-Reply-To: <ah6gtquGDMvEXjcb@ashevche-desk.local>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
	<5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
	<ah6gtquGDMvEXjcb@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F01E62D720
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294160-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[acm.org,linux.microsoft.com,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2 Jun 2026 12:21:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:  
> 
> ...
> 
> > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);  
> > 
> > min_t() shouldn't be used if there is an alternative available. For the
> > SRP drivers, please make sure that both arguments of min() are unsigned
> > instead of using min_t().  
> 
> Ah, I just answered in similar way against v5. I also mentioned clamp() there.
> 

IMHO it is also best to do min(value, 255) not min(255, value).
Like an 'if' put the value you are comparing against second.

The min_t(u8, x, y) you've removed are usually broken.

Maybe I should change clamp() to allow clamp(int_var, 0, unsigned_var).
That will need the order of the compares swapping (to do the low bound
first).
I think they used to be that way around, got changed by a commit that
said it didn't change it!
Correct code shouldn't care.

-- David

