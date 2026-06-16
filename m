Return-Path: <netdev+bounces-299967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 22KuHTjHMWr1pwUAu9opvQ
	(envelope-from <netdev+bounces-299967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6C695803
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:59:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fnEJl5QF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299967-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83B99315D79F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65223AA1BB;
	Tue, 16 Jun 2026 21:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC193A7186
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:59:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647157; cv=none; b=ix4IXZwuk13T/eOWk+grlUf3eiJqjZabXWx3gMIYc6Akq2XAb/6uOfe++sNnruULFSjcJar/f85lVT1aYUDjLZj0CSNwA5Y1hsLVv6yKYR3OjtXaIy6w2wzuNwEpPKS1Zos4AZU94pYLW/XUbF6oXKnrdG34y/1/KgIDr8FTNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647157; c=relaxed/simple;
	bh=58cyZl1Q9XyXkuIUxJ6+57jGmD385jOekL0np4r18sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8WdiAPwSfRfktzgSRdS6yXdvmGs9uYFMy/edUO4n/RHryjCot+/VTcZMsFHt6mNalHE5r0zYxVFK1J8nsOZ2acEypktbPdmXHPS92wphYY5F6CA+OtfMY6gqW8+QAPhGNGtm7mCIF42/JWZNUw9bBrqoC/JKQixISL5kfkW3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnEJl5QF; arc=none smtp.client-ip=209.85.210.45
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6dcad6018so4378549a34.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781647155; x=1782251955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIhJ92yHcSeuARKRFApaFACq6jQgJFrqu8oVo70t/I=;
        b=fnEJl5QF+ZIcJxd9zQ+yLswpDGoY7uHw66oSfVeo+pSpzteG1IKD8NvUxqUL1l+ej2
         7pOR2DZlh5MJw/JwHPXUDFG5+65eemTJOtpI50VURJqGROV+mZrfTR9H5+3LOqZG8EHF
         wap2jT9CYEZuDY1DGqoIl7EUya3e3JiQRaw6lUOB2dJUgZIgzGWLd8RhkQrCZMlttOBM
         /Umxy9ByDtyy9OcfFATbMqaG4I0eAx85gWchkN78iunmuZ374JRZ1k9KFcePvjDN55m6
         2EQBCoMmx/eseBtVt2GIByTBmpTtAtUr+hHKUUR1pj1nb+5rqDVDUv/HNLGBpQDxVsmQ
         O+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647155; x=1782251955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdIhJ92yHcSeuARKRFApaFACq6jQgJFrqu8oVo70t/I=;
        b=sNeiV1BmqvjLOo24ZRWYDGspBJEAIaHaZwYd+A4STBgXhtpT4/FqTXaSjGg5D4FoSN
         0oLvKwq4260krJ9uE7KX81LkqnKGtmj5W1cE6BkVb0nN8IPj8UpdNF+4EmMgu5C4F2kC
         9T57doXk0kpv0ocnadcGbmpAODa+v4v1HjDIDszqR7rKNlkY8dBFYaIqK1P1jDEAGonQ
         ScMWV2xg1qBPMd0DxrnsFg3FU4u+Ld214HAK4eVzzrbjjzboDQeQiOdTsd6tuQubpOrE
         uG00GSsAnb9AFmkMHtoc7EmFr7qnujFLPiSaiTYn1KDzES5WdL8DgFYQJMhRjpbLARkM
         7dzg==
X-Forwarded-Encrypted: i=1; AFNElJ92VFwHPHVlphZXkd+EfMmHDT3qj8D1GVCqpvlwrA0xs+ZmfB5hB9JxNasMtIU7hXopKK6Ynuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYi2KZlGJdAXGKWhrF9GYNIU4GMPj9ezpj6TdNapFygDawj0i
	Y6ZdbJAhUrZDgyk7fV9cJxXlRsVGPUAJdcevSfgjMQuw8v2QcuPQWAq0
X-Gm-Gg: Acq92OFTN/LxvSLwPrcMwQ97Pdh+stABGt8n+9P//XY898oXvfXDcTvrzMq+z/M+7jS
	MPmKudlSgaR+zlAvQZ4lDLekcn5AL3PKtULnNBjDppMRJuvhqaRkTzNEbOdzKYSm5/HVrtJZaGe
	0xKPw4oxQgbX1Hc9/IVQbD+NXq2O8zDTjC7EVGo23Dwana2dabnhwjWY0FCwxUuKtq412s9Wxfi
	dqbYzShPIot6Bj7uDldC/shHuzupwFOT93C+9xUSXaAIh1IK59xhhj6pgF7bL+D+0GVDXdhtHwP
	aYSEQqOUE2YWYo/vP+FvmoQlkhYB/GoqjzU2aTJdT9iSqidfloDEgJ5MojhcK7lATgs+aqTvQ+e
	TSI10AdSBE/ciHj9zFeMUY+4dCLVu2aBSnu5w13PXR3dGyBb7vpqUvYuPHKVltNQ6sAZxm2B3YV
	zBaNnQFgcu1nskIYNI7XughVePGvD3qMG5nudAzhL9cFhS
X-Received: by 2002:a05:6830:2783:b0:7e7:352:2f74 with SMTP id 46e09a7af769-7e90b43fae5mr1228845a34.13.1781647155303;
        Tue, 16 Jun 2026 14:59:15 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e7a3c2b08fsm6625336a34.8.2026.06.16.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:59:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:59:09 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"matttbe@kernel.org" <matttbe@kernel.org>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"dw@davidwei.uk" <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <ajHHLfgY+pZ8AD97@devvm29614.prn0.facebook.com>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
 <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ajG4zaK9zu7qZT1+@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG4zaK9zu7qZT1+@devvm29614.prn0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299967-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vivek.kasireddy@intel.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:jgg@ziepe.ca,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,linaro.org,amd.com,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B6C695803

On Tue, Jun 16, 2026 at 01:57:49PM -0700, Bobby Eshleman wrote:
> On Tue, Jun 16, 2026 at 06:04:03AM +0000, Kasireddy, Vivek wrote:
> > Adding Jason to this discussion.
> > 
> > Hi Bobby,
> > 
> > > Subject: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
> > > folio
> > > 
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> > > underlying folio was larger.
> > > 
> > > Instead, walk folios[] and emit one sg entry per folio. When folios
> > We have recently merged a patch (that will make it into 7.2) from Jason that
> > replaced sg_set_folio() with sg_alloc_table_from_pages() in udmabuf driver:
> > https://gitlab.freedesktop.org/drm/tip/-/commit/5bf888673e0dda5a53220fa0c4956271a46c353c
> > 
> > Since you are relying on sg_set_folio(), the core argument against its usage
> > in udmabuf is that it doesn't work well with offsets > PAGE_SIZE, resulting
> > in a malformed scatterlist. Not sure if this can be fixed easily.
> > 
> > > represent large pages (as is for MFD_HUGETLB), each sg entry is a large
> > > page. Normal PAGE_SIZE sg tables are unchanged.
> > > 
> > > This is helpful for importers like net/core/devmem that expect dmabuf sg
> > IMO, udmabuf needs to detect whether importers can handle segments that
> > are > PAGE_SIZE and set the entries appropriately. Please look into how the
> > GPU drivers and other dmabuf exporters/importers handle this situation, so
> > that we can adopt best practices to address this issue.
> > 
> > Thanks,
> > Vivek
> 
> Hey Vivek,
> 
> It sounds looks like that patch might solve my problem. I'll apply and
> troubleshoot from there.
> 
> Thanks!
> 
> Best,
> Bobby

Good news for me, that patch solves the problem. Thanks for bringing
that up! I can drop my udmabuf patch when I respin the series.

Best,
Bobby

