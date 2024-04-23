Return-Path: <netdev+bounces-90575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225D8AE8BD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D171C21796
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79162136E01;
	Tue, 23 Apr 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gun0TsZi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB7136E07
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880453; cv=none; b=qTPkx7ZpBvASFRBWoQuwsgQ42EC9BDcM8eJrbgQDO3jEC/KKq2b6Z82Q7F3Yy1c5CGzXcUCD/lJpcJKsWyfp/gMRwOLtYlAMLu4vrjrZwNNmPvsAI1J+1Y8ublKkdiPgshLpxYjfGUAqfn/bitHf94yXNHq25m/XoqdWoyCgwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880453; c=relaxed/simple;
	bh=p8wvC7G1xR8U5eZAiLXDLmEut+0I5MoakxC/JieWjNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT4osQ/wOZzjpAHZcLUHzTZPsRNjCoY2mD8qotzVP/pkDO5NFVQsI/IP/DyslI2W/1hDNdWISuHKDRCd5+iwV7mDiSQZCCWTQZzVGbufbOWwUL0d6myXptmwO/e0WYuT2Vb6f0m9lSQwV8Pw8rMychle8rXSKscylqb68tTJdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gun0TsZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713880450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6v+B7nAQZWo5vCJl/UC/x1PI1ni2PSzp7Ef9oYTXrE=;
	b=gun0TsZiLCENNkkdkaGlJPwv0cmryandQPHCowloj9W9OYGdXP7VbhQ41ZRnZO3AKUYZ1b
	lE4/IC1Vv12cgxjTSX7KMw20KzF6jj23Yq7dHGBcjnpBS/lAEwPQVEKrMAfSMC3W0Cvpbs
	Ks5IjkOoqDczzD7QVSaDPQvRJzg+qiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-LYbZMmwYODObzdhPOdNSVg-1; Tue, 23 Apr 2024 09:54:07 -0400
X-MC-Unique: LYbZMmwYODObzdhPOdNSVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9B7C812C50;
	Tue, 23 Apr 2024 13:54:06 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A442B400EB2;
	Tue, 23 Apr 2024 13:54:06 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A6479A80D01; Tue, 23 Apr 2024 15:54:05 +0200 (CEST)
Date: Tue, 23 Apr 2024 15:54:05 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <Zie9ffllQf8qxv2-@calimero.vinschen.de>
Mail-Followup-To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
References: <20240423102446.901450-1-vinschen@redhat.com>
 <Ziea2_SRYoGcy9Sw@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ziea2_SRYoGcy9Sw@nanopsycho>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Jiri,

On Apr 23 13:26, Jiri Pirko wrote:
> Tue, Apr 23, 2024 at 12:24:46PM CEST, vinschen@redhat.com wrote:
> >From: Paolo Abeni <pabeni@redhat.com>
> >
> >Sabrina reports that the igb driver does not cope well with large
> >MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> >corruption on TX.
> >
> >The root cause of the issue is that the driver does not take into
> >account properly the (possibly large) shared info size when selecting
> >the ring layout, and will try to fit two packets inside the same 4K
> >page even when the 1st fraglist will trump over the 2nd head.
> >
> >Address the issue forcing the driver to fit a single packet per page,
> >leaving there enough room to store the (currently) largest possible
> >skb_shared_info.
> >
> >Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
> >Reported-by: Jan Tluka <jtluka@redhat.com>
> >Reported-by: Jirka Hladky <jhladky@redhat.com>
> >Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> >Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> >Tested-by: Corinna Vinschen <vinschen@redhat.com>
> >Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >---
> > drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> 
> Also, please use get_maintainer.pl script to get cclist.

done and done in v2 (for which I forgot the "in-reply-to" now, d'uh)

Thanks,
Corinna


