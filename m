Return-Path: <netdev+bounces-90574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95008AE8B2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80861286EE7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3D13699C;
	Tue, 23 Apr 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys+x4Xec"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6C136997
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880382; cv=none; b=lOW9AaGXS8/A+r6+QnJONSocUY7oni2FYoRKHM/RDPfIbkMvpgNFTp1dWXB3nJMA7pJq3JGXrruVC0AmqdRBWIfIHGsvhRHljI6H39PWb/fD9b6gIlYG0HnQbkiHsPEm82upw2qEQvpVumhwlJnzIMR3Se8mF9Ep0hFGGjrd7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880382; c=relaxed/simple;
	bh=ez/88xR9shbhSkOXZCyjVuuP0CdvPj12t8Q8z6BPDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLOZTqEa1BHlhFu7o6ecl5ZLJEkxcPeVVEldKhNZOlg25ebW6Cl3fVp0za1iicxlIYx19G8f9QzPfpWiVJejV8M/D/MSu+Ey+T+349V8QBtd2ulPkwBSfnReGmVyr69bfpnsie5IK1DSgpQn7cTybV0Pz+9wsUUn3pz1NVsMD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys+x4Xec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713880379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3haXJIv6HOJCEt5+nTVbMLWUYWPW0T1HtN04B0mUTg=;
	b=Ys+x4XecXHb3ZGN8Gc1vhAslVjEAnlbzC3RnTPH2SUKMx2ohg3WwJu12PcGm6eXqI+UHM7
	hejrr7IE5YnfvfByTXXy4botmCzD5o09nPfcH8xBF2mG0rIVWlKq32ldZtbwCwSv4uq3+G
	GEfobTKvGEpp5qKf59YT8QCHOvpaWkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-FxKHN_3ZOiCKdnFzMlkEhw-1; Tue, 23 Apr 2024 09:52:56 -0400
X-MC-Unique: FxKHN_3ZOiCKdnFzMlkEhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B79DE812C39;
	Tue, 23 Apr 2024 13:52:55 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7733A1121313;
	Tue, 23 Apr 2024 13:52:55 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 50474A80BA0; Tue, 23 Apr 2024 15:52:54 +0200 (CEST)
Date: Tue, 23 Apr 2024 15:52:54 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <Zie9NggvhNuZeUYe@calimero.vinschen.de>
Mail-Followup-To: Paul Menzel <pmenzel@molgen.mpg.de>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20240423102446.901450-1-vinschen@redhat.com>
 <5d30a9df-224e-4285-94d1-53f6995d648a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d30a9df-224e-4285-94d1-53f6995d648a@molgen.mpg.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Paul,

On Apr 23 13:52, Paul Menzel wrote:
> Dear Corinna,
> 
> 
> Thank you for the patch.
> 
> 
> Am 23.04.24 um 12:24 schrieb Corinna Vinschen:
> > From: Paolo Abeni <pabeni@redhat.com>
> 
> It’d be great if you removed the trailing dot/period in the commit message
> summary.
> 
> > Sabrina reports that the igb driver does not cope well with large
> > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > corruption on TX.
> > 
> > The root cause of the issue is that the driver does not take into
> > account properly the (possibly large) shared info size when selecting
> > the ring layout, and will try to fit two packets inside the same 4K
> > page even when the 1st fraglist will trump over the 2nd head.
> > 
> > Address the issue forcing the driver to fit a single packet per page,
> > leaving there enough room to store the (currently) largest possible
> > skb_shared_info.
> 
> If you have a reproducer for this, it’d be great if you could document it in
> the commit message.

I fixed the trailing dot and added a reproducer.

Thanks,
Corinna


