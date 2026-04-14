Return-Path: <netdev+bounces-278575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JOAFTWd3mlrGQAAu9opvQ
	(envelope-from <netdev+bounces-278575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:01:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC83FE359
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97D75302F3A0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B4225397;
	Tue, 14 Apr 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p72VqbeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DB13DDA4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196847; cv=none; b=UAYjhShdQeXiF/b27zfRnffo3MEHd5OLadwykBUoU1R/4DExTQCl0WKas0M3DmHEkDkbvLE4uNx9Sau+RNWWK2S1xF3EbP4RVmH3jGe2JgIKb8G3sFYb3OR5xKJVdY68bH1q4UtK2aFqXHKvIGQz8EYL8K3dFuSLK8o7cGxHiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196847; c=relaxed/simple;
	bh=ithCxZ94/lpCyjWS5Q1yqtuB5xCNWYQO26fHa8taySU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu8ggxv7BcFzOtheeFcp11iGNFp8kNlmMedzokSOjuska4hXEFsZJ321NqE/gQMWggyLNNDSG1o3dW9EsRmfeNAEg2t22EtU91NNKYNDDiI4xtlH3+q002vBGpVMiw4hYZGW8RpqI4t6NVbpjzgWNTOjcqzbAOicnxRy92sW3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p72VqbeV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso263005ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196846; x=1776801646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lj5suPMM0090nuUB3pghGeuC5Cz7fnPMxIf04NMBZA=;
        b=p72VqbeV7ejGRWmzuBeMbSS1hfzW+2NVze5lL/voUPyLSzlc8iYZG8iqNhtL4blI2R
         yKqaA6kgZBzDShPUNBdXMuH78b+V1SEf93gqKgjQMelc0PdAYN8yrTJgOCbmTh8r4zrl
         LOu+pkGANKtQqvFR+c/DscqTnT6/zg3tzxS+nSoTYyrd2N8mcm4tKtWBdm99E0SFmEK6
         R/p0wmq2MTJX/I+v+ByceT97n23YdGizOSUIngpiioIy3vLHQokNDHEONxLgaIRG/zDQ
         MchVOryx2k3h9F4zJac/9877khuc00ccrXWy7t8VJEDQuBcdJrWGmmolp4ubTnJEOJxv
         gALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196846; x=1776801646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lj5suPMM0090nuUB3pghGeuC5Cz7fnPMxIf04NMBZA=;
        b=YoTlQ47G2dE+cy8AqaX1k/D/5nLPh8/N7FXtmY2/KS8OLtlziWivMvmygwo262JDl6
         QWUWwE84cInWTofhLra0JBmrpZcQViE0PqxCtiAkr6IGyxP6M+NlHk3fxfve99jdXnte
         vQSklz0npr1DU/7uRwrYsQDyfXC12qrbt9SWgt0C49CJ5m+L+wJjgWqPs/Ix6DTdv9AM
         eEXpe0IjLbSdmq+UsGahw0L7m7ikdKBqPnqw5XG6O3A9Om6d2/1vHg6fblY9IAm/t1KQ
         B7QUfDTUkEfg3Toxf7g3hexHfNmD/Wz3lbCNSJmfmeEHFii+aEvjxwGNloe3Kf1ersdW
         Sn/A==
X-Forwarded-Encrypted: i=1; AFNElJ8QHN5GsF87fqttQHxRRy84LeJGeRtG1oXHcoY5r9ULpBVwhW9zjAFQNkvluYAHQ7bjVtf4C5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICLMTFX4Wg7vrgB0Qr5UBD10miUSJYMvKKT+578JwmgMJOLli
	LEe/6pxfthRj8vyoOdzhdZ25IynpP+BHVmWcn87VlzZ+J+Lh2U+tIpFTsW7wzbu0vA==
X-Gm-Gg: AeBDieuTsvSCbmd7E/qzsQobs/JpyyxSsV/FSXI5K38Lpd/gQvrCuyT33YOaR+4Qs0r
	qY0F+IZ8uGrXGLjE+XZJMvfaic1C3xkv+rTMWLezEFQ6R/HX2VN5Q3XFRNYn8Tp2hAkLWexjzNu
	FJOY5+iZaFRcHu5sgADPmzFquYxs3ePpqur6ulV73ZZT09rrPQUTFIggyZVR8TxFzazKq+VP2ur
	PT3z410C9hxnef/a0AY0yppHN/+FFSkOTaQjOx63qkm1hco8uElvFp9Wsad3O3lnzlVR57MrJ2T
	QYXPAbobFL0m0U37Ss0Du3/ODNsqyAkHG3ADyoSZve4HSPXuzn7b5O16JOW+S3yqoafO9VyKFj5
	MLzfpE3PDOKDZYiFKnC8PPyhcv+uMZJph/nTfbe3kAF8hEtWaINgBsoVblqb3ephpSYkbBEf8U/
	dmMP2H9+iwD3JVrvVdJbz6AyA1TlPFS18vz9F9+bDsYFpAuIsOTa6FZ+uYt9S155BuquWe+FiFz
	vHUYxE=
X-Received: by 2002:a17:903:4b50:b0:2b2:70ba:304b with SMTP id d9443c01a7336-2b474d3d9b5mr926455ad.10.1776196845352;
        Tue, 14 Apr 2026 13:00:45 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm158961075ad.46.2026.04.14.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:00:43 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:00:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] nfs: allow P2PDMA in direct I/O path
Message-ID: <ad6c5fI0HsHkUbKH@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-5-praan@google.com>
 <ac35ICYHuw4lEOri@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac35ICYHuw4lEOri@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5FC83FE359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:05:36PM -0700, Christoph Hellwig wrote:
> On Wed, Apr 01, 2026 at 07:45:00PM +0000, Pranjal Shrivastava wrote:
> > Migrate the NFS Direct I/O path from the legacy iov_iter_get_pages_alloc2()
> > API to the modern iov_iter_extract_pages() API. This migration enables
> > support for PCI Peer-to-Peer DMA (P2PDMA) by allowing the setting the
> > ITER_ALLOW_P2PDMA flag.
> > 
> > Pass ITER_ALLOW_P2PDMA to iov_iter_extract_pages() only if the local
> > mount indicates support via the NFS_CAP_P2PDMA capability bit (detected
> > at mount time for RDMA transports).
> 
> Please split theconversion to iov_iter_extract_pages into a separate
> preparation patch, and even series.  That is a long overdue change
> that fixes potential data corruption in XFS.
> 

Sure, I'll send out a series with the migration to 
iov_iter_extract_pages, should I club this with the pin-aware + folios
for direct I/O or send it as a separate series?

Thanks,
Praan

