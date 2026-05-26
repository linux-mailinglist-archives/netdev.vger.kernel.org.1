Return-Path: <netdev+bounces-291559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC8iEf5FFWqLUAcAu9opvQ
	(envelope-from <netdev+bounces-291559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4D5D1739
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1D86300492B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D237E2E5;
	Tue, 26 May 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bc3UoS7w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3AG8dSv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0EB2DB7A3
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779067; cv=none; b=hUbXoGl1uSofLSBsxHdoDdtBGEwkAMIP/4MLlmcrZZRvnBVWfaDYB6fspKFCmfjyaZTfMwZnZhsJJrz+YvgGZk5bai60wH3I/Lgi4CueXHWgDg7zpbdUKeoJzsFju6Kl50ZBTvZVFY3rNysssLGNTtvnf564ctL/7LeZd6L8BMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779067; c=relaxed/simple;
	bh=BP3myrowaLaC1kIv1+a41f3Ww2nagIG5DOALpw7meB8=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=gHd1zeLKDPXAbLH5JH0cj48uWDEl+dLVwO/0SyaRlIWbDDcTFsUcV2FaRclsvytfsJ8QnGfrseIxDersiQwtdnW20ceEgOmZWhN2ZNDKM9UgfUC7a44TiaCRWyuAUp16ldXLY4kZdbOL6qEM3of4nyub+xkGfAgPE8jE5qVhUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bc3UoS7w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3AG8dSv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779779065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aS6b34rdBVpRCnMDa37L2IlTiIPUqxBt8t5oHtreho4=;
	b=Bc3UoS7wQ/Sb+rmbdi+pwHiqV5lWD3vG0Mz4JGZKedlsRA1sa8yZMSfQqsMP1VHpwXPZjv
	4StMRngi1WF1LD3PtujD2pchQzujM2RUWiFw1Ucf+WHs1dxt0Y46mXzJpyZPZnP8kl/77D
	AJ0b0poxOUKLhZoYebm3usiQcXILR5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-ReyLe_sOOZiFi9BqUj4QBA-1; Tue, 26 May 2026 03:04:23 -0400
X-MC-Unique: ReyLe_sOOZiFi9BqUj4QBA-1
X-Mimecast-MFC-AGG-ID: ReyLe_sOOZiFi9BqUj4QBA_1779779062
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so21388965e9.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779779062; x=1780383862; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS6b34rdBVpRCnMDa37L2IlTiIPUqxBt8t5oHtreho4=;
        b=F3AG8dSvrYIRl5mVhWNxPtp45qM51DPwCu8SsAHmf0GHsYWFritor7zYUIkUbssGsO
         KqJUME37R0P0o86IHaaK7k5jXzetYey89RdMmZXBnodjQxGfvFMwycyBUGkeWrZR3fC6
         2K5l5WNtro7zMtn5crW8zsrimsGmOluab30BLYVeuzUocbEbEZJnMWFZhOOxMq3J7GG/
         ReufiKtfRedz1L5YjciNnA2Ipm5U/csL9AULzCSlSABnPTdTuRaYY8Ddu2sPvfOL+1LC
         xJ8F14ecwq2QTN45W8sMygSUI6BaEfh1Yu35zU6Rs8FDPeEcM1qHSua4gH9kNxK4WntK
         xtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779062; x=1780383862;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS6b34rdBVpRCnMDa37L2IlTiIPUqxBt8t5oHtreho4=;
        b=Va667vsw9Icigp1F2Zejuiuw7i6ismmdaqmuVqSd+ZvW+7aUiEiHThSTxHQcBn1uCv
         HrAqucEsYLO5XDpKnIvEHj4sZg562SGcclqMfQwz2STn5IMfqHZgddsBAYI7iO0Hs1B1
         /b2+bLc0iC87/l1ZUF7hlf6bpdT1RAuFwKTOpJhgdk2/eXfErUbPP684Zo/0cHASfoDv
         ByEsPlyzantfr7Yy2ac6Q7w7ciF8XGJi8vCMkPAK7SmOQ8Q0dKNC33NVnvbhMIbXjwI/
         +vOTt4aAfwo5M/KYM2Je2SvA4L2U9ZKy/KoHc4+wdPWko7vBPDBUhpAtGnZ9MVH1cJrK
         V0Zg==
X-Forwarded-Encrypted: i=1; AFNElJ994Vjp4/NFkJR0SyFlWDRq1prDJVE1BLyqXlxlm90eRXKn//9CaGVNvIzQWaqJH8XnNRhg3dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13tvaJESUhTZZPOj0i5ne049WNkMM0q3PvVOQUGLFxyxMNlc2
	7HCKpB7aSrpvRnoSUi/VFKR4J4ERkc+PSCSwZFyxS3RCwlPKBs2E432oTuFGAyMbEIVZX+XvEhX
	hyiZafBKiyfKyUpFvWfiZ0D0nVUVEvYWY41S5o52rlqTBYaOBEl78f+8c1Q==
X-Gm-Gg: Acq92OE1Mdsfgc4Sbx/9CZdaz2dSxUJHVEIVgiv1W+XIzKuV94zmnGk19uGMQaw0FGx
	ACiNkS2U0Zj/u/BUthdZYn+eUEahWNhSv08vxwAKNnwfW+0cMCo0DOCN3aRtDfn7IRZd33xuNR0
	cqL1ZnQ6fcIhxvU2bnTyvWS3nTRBFbUSLQdmSp9SoHyL7mCOZcyROsduS5wJENAhNxKgi1Yy3kT
	7Nr0d2OUWWCjBLgHVu23JFoMM/eU2pl6+clqkMIxepZmf0Su9p2Sj/+1wUuUzplF7lbT1La8n4a
	aqHgBWeATlcTg5/UhRqB+XEiQSrKLWssn30sCorTC2ZzZrum2gGxNL32m28OHy2yiGRQXezFZWY
	FAj4TnrgWc+QSaYDP58d/kFRruUi8AxcKITgWO6LFj0PnwB5gmw==
X-Received: by 2002:a05:600c:a46:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-49069da61a2mr95683395e9.14.1779779061839;
        Tue, 26 May 2026 00:04:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a46:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-49069da61a2mr95682495e9.14.1779779061274;
        Tue, 26 May 2026 00:04:21 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm297860605e9.4.2026.05.26.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:04:20 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] tunnels: load network headers after skb_cow() in
 iptunnel_pmtud_build_icmp[v6]()
Message-ID: <20260526090419.54d5f115@elisabeth>
In-Reply-To: <20260525201335.2361845-1-edumazet@google.com>
References: <20260525201335.2361845-1-edumazet@google.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 26 May 2026 09:04:20 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291559-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DEE4D5D1739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 20:13:35 +0000
Eric Dumazet <edumazet@google.com> wrote:

> Sashiko found that iptunnel_pmtud_build_icmp() and
> iptunnel_pmtud_build_icmpv6() were caching ip_hdr() and ipv6_hdr()
> before an skb_cow() call which can reallocate skb->head.
> 
> Fix this possible UAF by initializing the local variables
> after the skb_cow() call.
> 
> Remove skb_reset_network_header() calls which were not needed.
> 
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stefano Brivio <sbrivio@redhat.com>

Oops, that's mildly embarrassing. Thanks for fixing this.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


