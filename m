Return-Path: <netdev+bounces-298280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5XfkI93/Kmq+0wMAu9opvQ
	(envelope-from <netdev+bounces-298280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE6674754
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="J8/4dVMJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298280-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 695B7300C7D2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B94CA298;
	Thu, 11 Jun 2026 18:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B54C8FEA
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:34:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202896; cv=none; b=X1vV9KJOrpe7FEW4OSeZJbxJpbZa0RcbFUpXsnuRLfOg48UHK7EAbuCrG/yIs66adu1CHqp4Xte9y7xWE8ZMQa5dRwVcoRrvrqksvVmzZqfSt3xyq1XmEPcM8mXebX63zk1S8AP5PI9iQXd1wOepohltCijylcLN4H359L9ncDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202896; c=relaxed/simple;
	bh=I7nKHejdDue2acZKZys4LfnQEyFLVRI/XfxUy4Hd7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHrSpiARuCt3+ZyMBw6uMxag8Zxc/ogZ+307yKLbXAMtyZBvmaVIES2j2WoN5hKetLXo01Ak6616ykGWXCLV3G8DhCeP9Qsgq67jcBLHlW3eP/yugaq1fYaAEal8pnu/pzQ6qdYdqqjxpOPdEHDVr2aSePKEceawauiNpazpODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J8/4dVMJ; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91550dda53cso22725085a.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781202892; x=1781807692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzbKVYkD2taudFdcJosofP1/X39YXQKpW9J7XG1Isfg=;
        b=J8/4dVMJKXrJZU62Hs6DvafvKLTXNF3w10pwYZG+QJvPHxwdfyyjSuEI4d43RpwzYn
         5qORd2a7WOHgqSv56fPdaiQb0NfFICj+Zz3NnhUc/pKbwIvxTtvB8SzM0Qjwi6gENMNj
         +BinbNRn/dA6ON4yMhU9hD6R9IRckMDXrlaPKpKjR+oEa2a/Y6SdaSNBevUC+OLEqUNm
         eIIKmibmDiljVQl79D6KMEhaCcSBJLYZCGYpi7UKA8SViD4V90scd5D3Xw6nUdMjBbB2
         BI9QB6uxeRUTGo5drAEO085MSvei8/qSDThutUZ5YLyVafeWUVWLKh73T9QRHXUGdmlk
         Kgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202892; x=1781807692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzbKVYkD2taudFdcJosofP1/X39YXQKpW9J7XG1Isfg=;
        b=MyPbtXZqBu/PqsfrIE198jiHGRvvMOP3CBRiVZ6Eh8tVyjN54hmJHzmvn4TkbAE1OW
         AZV4GUff8OEJUueNyY42gFKcIMaCotkzwW052kilxjJLyCu6BXcdKaRcici5q8enBt53
         f8CuKTxtaW2idLAR06iS+w5iMfbrih2EkbvF3RHcB98d9s8niJpwpnVoFOPp0zeVMYxp
         JJTbhc9PNAEk0Ow+A6youXD6tE2adMFn9OFKa9IyXEZ4ffmPDt9Igs+Z6jbT4Vs4qhmB
         AiXdfsTIUk+B9meEOLYblM0ocQUcvUQMmpcI2P/EwqgOAOKXOBBvSt5YmbH4L51ciBqp
         /nng==
X-Forwarded-Encrypted: i=1; AFNElJ+KMhcVtJSP4ciXE5XnaQ4K/FwBkhVe6zmhy/CF9sPtaJvjD24EFdyuen07287ksDv9TQFBq+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL45TYV8VMsf+YB//zS2ki9rpxfDyRM9QR1Qmy7wKEYxKnrYd
	EEwewU2EQ+IfYfWGF9YsSZ8SNk0oEuf8G+17Vcx1CYg0BWbDaWRKo48W1JmOnmlXDhY=
X-Gm-Gg: Acq92OEqBj73uxA6wRO/XjTlPpVUnxCngeyHEb+XRKfOfEcQ00kO21QDozdho8io67V
	EbtTROAsmVF/jf1jTbqnZLQZqAexkMuRgCtfccK16lsHYyQyMSCjM9qNBdCsPBOBQ7RcSBxALaO
	pOfKkdHvf7p56N537FtzW3uCO1phE+5rlf9DnKhTvl3wD9Vul/Lo+ektd/QyTuV46ANLd3XWeuW
	DW9Wpzg0+CUQXOR/zFLerB4KnPO/OC4hXSxNMnDMVbu7c738OgVsRmBMXGVm4dhC3yFa12iECZO
	hsbrKxy+vmGSorG8VzvuQjeU3YY/v/4EcGOQRigz4HbEGoAer3HLwepZCXSXiLJlSOzfua/K+zB
	vLYOGgpr8scqHN+RVcz7Lnzyg0/ub3f7GrhFPvnOI2QSsMqlWdTtDjZvqtbF35pcT/+x8WDJAnd
	37009ttZbouaxR8yE2WAV2eIICzEE/g3du3baaKqKnE1LpI2C+AkV+5RIUz5jQeNAtfGRlwpEks
	NtozQ==
X-Received: by 2002:a05:620a:7001:b0:915:89d4:df1e with SMTP id af79cd13be357-9160ade1865mr653579285a.27.1781202891862;
        Thu, 11 Jun 2026 11:34:51 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160aca325csm257905685a.11.2026.06.11.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:34:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXkEr-00000006GIL-3m5L;
	Thu, 11 Jun 2026 15:34:49 -0300
Date: Thu, 11 Jun 2026 15:34:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [for-next v2 2/2] RDMA/ionic: Add RCQ userspace support
Message-ID: <20260611183449.GG1066031@ziepe.ca>
References: <20260611092544.783731-1-abhijit.gangurde@amd.com>
 <20260611092544.783731-3-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611092544.783731-3-abhijit.gangurde@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298280-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88EE6674754

On Thu, Jun 11, 2026 at 02:55:43PM +0530, Abhijit Gangurde wrote:
> @@ -2154,7 +2157,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>  	int rc;
>  
>  	if (udata) {
> -		rc = ib_copy_validate_udata_in(udata, req, rsvd);
> +		rc = ib_copy_validate_udata_in(udata, req, ionic_flags);
                                                            ^^^^^^^^^

>  struct ionic_qdesc {
> @@ -84,6 +85,7 @@ struct ionic_qp_req {
>  	__u8 rq_cmb;
>  	__u8 udma_mask;
>  	__u8 rsvd[3];
> +	__u32 ionic_flags;
>  };

That is not the right way to use these APIs, this will fail old
rdma-cores that used the smaller struct.

Please check everything you did here.

Please support IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA before changing
anything, and your userspace needs to check it before using extended
functions.

Jason

