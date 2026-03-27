Return-Path: <netdev+bounces-272520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MJrFtVxxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:02:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD3343ECE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F774302EA83
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4E391836;
	Fri, 27 Mar 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxbZkIAw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401D38F923
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612900; cv=none; b=Ht7lhxHoufzbCqUNqFrSDmMr1jYNj5k4+sbz26xy5xMHkEONhxAB4svrsOWZsEoaO3jYm6UEUAq/Fz7UcnGhycwxwD8er3oACECjULsqeZbQkUeAbVUL9BQEYVvE8M4cfuvJVury00PVdi6N59Dq2pMGOEfVD8sly13gDYx/UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612900; c=relaxed/simple;
	bh=Ok4j49gu2VTWuchFZy9QnRZzJkYTWamW2suiarPVT+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fuq45dz8HQadV724ODvRWyWhSAgtkfPQXJd2EaK2RiaRyIhJJxpkBKhzilRnjAuLCqbi1SrcI8MaCCbNe8VP/VYw9JlijfNDCUXQXxp+ppo1KWYrg7loDDby9u1PJj06on61cGVWFF44fEBgu0/NBefzHfoYm5V0ivQhLlAOzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxbZkIAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774612898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3WhH1msur3UHpUWCgk4GOP0E4m61K4RiHMSJwcOf3I=;
	b=NxbZkIAwI+NYKJwJocVhk43JZvVVdNriBzoNMErMK1PcI1BWI+ZvI+3jt2fvyW5GWvCfmx
	9YMBGL5Y1hS+7lD7k+4c0mVxnc94DKYWgidy2DKZrkXGEy//qdtuRpM06EFOfP/r5X1f4/
	aI31/2mWuoqdrkTT1WM1/mmu7+Hg6PQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-uoBJyWXZPZG9q4J5a6bYEg-1; Fri,
 27 Mar 2026 08:01:35 -0400
X-MC-Unique: uoBJyWXZPZG9q4J5a6bYEg-1
X-Mimecast-MFC-AGG-ID: uoBJyWXZPZG9q4J5a6bYEg_1774612893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FCB518005B9;
	Fri, 27 Mar 2026 12:01:31 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95F1630002DC;
	Fri, 27 Mar 2026 12:01:28 +0000 (UTC)
Date: Fri, 27 Mar 2026 13:01:25 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: hsr: subsystem cleanups and
 modernization
Message-ID: <acZxlczkaUE9dVGQ@thinkpad>
References: <20260326174600.136232-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326174600.136232-1-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272520-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92CD3343ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 06:45:58PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> Changes in v2:
>  - dropped trivial cleanup-only patches per netdev clean-up policy
>  - added AI attribution for cover-letter/commit-message wording only
>  - dropped fallthrough/BIT conversion patches per review

Thank you for updating (and limiting) the series.

> This series contains two focused HSR cleanups with practical benefit.
> It constifies protocol operation tables and replaces a hardcoded
> function name with __func__ to keep diagnostics correct across
> refactoring.
> Assisted-by: Copilot:gpt-5.3-codex (cover-letter/commit-message wording
> only)
>
> Luka Gejak (2):
>   net: hsr: constify hsr_ops and prp_ops protocol operation structures
>   net: hsr: use __func__ instead of hardcoded function name

The patches look good to me, so for the series:
Reviewed-by: Felix Maurer <fmaurer@redhat.com>

Thanks,
   Felix


