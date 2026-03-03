Return-Path: <netdev+bounces-263054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAidLTKCpmmIQgAAu9opvQ
	(envelope-from <netdev+bounces-263054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:39:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE01E9B43
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8372302E310
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055938642A;
	Tue,  3 Mar 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL+FSrUO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzEJqzOc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BA38551C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519954; cv=pass; b=I6GiaHAp5rIxnxd1PAaWVLWlo9Z6PntcPoefu9aQj+0NlQYzqvkoOUh0a+f150y3N1vDy878beRo95mWRpcMM2jA+ceqDdb5OoswXC6Yu2U/R6Qi4fPqeMziHqAZeMWk+/XlTj453p7cc51X5hrcfRrzoyDk6hYt93MtGzTdkEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519954; c=relaxed/simple;
	bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwVy6mrNRZJcwVY6c8BrHPeX16nB1U8SFt/WgzfP8j/737cLogihTw5pwmX38FXzezlEzssVwkr79OvH+Ixx5UIr8czao9LK4J9fgCpPqwJPooM3oocRxY8i63Lf+XnTqfVa8EbfFpVdNVWpltuePvK1ay9WAt+uxZqp/34Cho0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL+FSrUO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzEJqzOc; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772519952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
	b=NL+FSrUOAUs/ci/w68RmIwM3mMHIWKFLOOQ7F03yloahhgiXCGaxTFHJI/0pEVSpbFy2Aq
	dixZfxyzW5Al+QZ+yYvVozEQqkUsfzjTeLwsz4/nIr4a33PZbux+dk/K90xqu35X1qO8hT
	lhl9lrBzJqvFmKAmtKn/lQHEiS4mnsI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-Q-Ql48WXPweCC43hjVSvUA-1; Tue, 03 Mar 2026 01:39:09 -0500
X-MC-Unique: Q-Ql48WXPweCC43hjVSvUA-1
X-Mimecast-MFC-AGG-ID: Q-Ql48WXPweCC43hjVSvUA_1772519948
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3594620fe97so26840207a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 22:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772519948; cv=none;
        d=google.com; s=arc-20240605;
        b=JQEw63grAfYhF94bNTIWFG19kHdFXrnweRQbgBOgMisMVx2vjMCjetjfzdP8uyI0h0
         3Vpd/yFop6FIctI11ePjMe5HObUwY/QUW2n+0xwKI3Sqy6gcWkazH/eOjiKtr6mncrWc
         79WUSGmeFfNTekN8szSnjU3OyYbnGM6DZMEYN+X/N4kQFr7fCupVlVS2yLGBKKThnrEW
         yVeYHmIWuysopceYDtIHTNRgPfe6RzfsKoiYuMoqKB+fdZc+AtZAsWxLhfVeYLjg8y/B
         hnR9AxBZm3n+wTCmTI6mhsu/QM8M81zzkOPp7SWKZClMZKbOOTaK39SNxpc7ZUnvKGg5
         hNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
        fh=Ceua2imIu5tN2stpibGYiNDkPN8QZEbqkj3kabQ7ltk=;
        b=Kwm7Ozj9shOLDht+pAFULnDvgWrWbzRyc7Tk/ZdRSYndbudee21a+ul4fDJPcXySX0
         xBWOqoYqRTY6cLJ1es2jLmYAmfY+R9qd0ojwUO1eebArZmOjVlWMTA3wrNQUrHiYkgZ6
         oprCtls1LQqU5BAscOvDkF20mB0HCEs2ONXWJeJfzWKPZfVQ+0ITFYdbrT6aN7xg/Hwc
         YZzb9as4RJUCVLLsfjNXiBDirHBrip9ntl13O7sqfQRjUfEUA+/KUsC2urEQRVN1TR4/
         5U1XGu+5SFLNBs8jbz9xDIc8jKHnOsC40wS442+03gl0Znazqx3Poz0FnTqTokO9t/q8
         ECPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772519948; x=1773124748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
        b=JzEJqzOcM4o9WYFZaMlMkDEdSbLocU9+Y4of0nyv0ijlGr81d7fLXf8ZiIILO3IrBG
         PnWqPvEdctNIB+P8QBRsfdxMCw6IAOBspWbSl+LuQq7qVCZBrJFsocRoSFnYyvu5CeO3
         F3ulol7Wesm4tpaeUSQg/EsyK2w1UCm69OKpJNq9MxTubc15e5DTUiAsqx7BtyTew6xt
         L36LslzTOBXrA08OphLQpxSCHMBSaRbvP9kezAjD9GMha6cureIjPKY9XC2gOkudEgXo
         S0QBC2BRt/ZIrzL6cnB/9KPwy8Oj99UphdmGJp81w/yzebWGK6+LtEtJh+3zjuQ7X+1J
         LpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772519948; x=1773124748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ip6BoVTn8aXO52ewkK8IVXmRFEEwBoj5bvSXeM7zmPQ=;
        b=QDY0QVNzXLaDZhoCzVNPisPr45d/8CD75TP7v9AFJoIOD7nRL7qOgqA8bjjDHUG5QE
         WZ9o3F8JhQSaOs3tAx+z+23oqFznH90ofBNIkHdcNeRpWOXjQyzUF8udIo+zgT4SOO0P
         5HeqscxL0Fwl+5ZBWvL9sE6eTYLeSdrWSrFe38EiOaY7zeGPyrJ4VYXXwaVWLGXWjoD3
         9MIIEUChz4Vj3AZp2XSKQmTmSGINvJcK+0jqEBSRQY1g2ImTzcdBgHo+MCZv3pSH8Upw
         81P45CKxhQ6yXb64fIBwbNPy0ZmJ93AMPeeF47tFtyyKI1q6GC/ilPpG9BJRRlxCJGDA
         5nEw==
X-Forwarded-Encrypted: i=1; AJvYcCX8c4HYmkGNSJmjycL4lpwX1IVyZq5heZ2LdHNgVjosqI6BOg7/n7oSPGlJ+7z8LslPiX9ZOu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqrF4wUaBLj5UbfFWW6KaLqwk/9kwT7so1O1yiTRuUfsDO1Fth
	dK8ba6EbDnjTO+/wTMlfzmVBDtek7cFSVcT8QEB5Ho749a8kxkaiKqpJHarA0WoDTIgJ4dPUF7F
	W00QpuOsHunMxdkFefEH6IUxdkHOkGlLjwrs25jEWXvBKWpjgXYRWmIrGe60mi4Epsc0yEt9V1F
	tZyZKYog86kRzdLCQmsMeheWNMqtSHzZpd
X-Gm-Gg: ATEYQzxEUbSMDRRBAQpPOOAEzrZlO8HNlT+SOaVUdWHAftO1ej9NwpBeAho4iTjEaFe
	yGT3jj4cxERcK9eJXNjMZvF4tdh67OHKLw+5phGXgKgAI96ww4EuiqF0Ik+EokN+ZgBvH6EBZ+s
	cKYlmOrP118Pouzi03jKhfFVdAtAzrp39+ZC3zWQfeV0mwUdlGiZBjDFQyOH+ugzPk7qQK9K807
	X9+YjJw
X-Received: by 2002:a17:90b:57cc:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-35965cc5651mr14849373a91.24.1772519948003;
        Mon, 02 Mar 2026 22:39:08 -0800 (PST)
X-Received: by 2002:a17:90b:57cc:b0:356:2872:9c5d with SMTP id
 98e67ed59e1d1-35965cc5651mr14849355a91.24.1772519947540; Mon, 02 Mar 2026
 22:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 14:38:56 +0800
X-Gm-Features: AaiRm53r9FNVJrff6gYF6SVhADQXXQkuO9R5pefHXa-qJopdw_5-5yvB1l-6tnI
Message-ID: <CACGkMEtWvsB0CcZCC9iB9GePROH37CuLFZMcdNs1DjXSx6uQiw@mail.gmail.com>
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>, 
	Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39BE01E9B43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263054-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yunyoo.cc:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 4:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> vhost_get_avail_idx is supposed to report whether it has updated
> vq->avail_idx. Instead, it returns whether all entries have been
> consumed, which is usually the same. But not always - in
> drivers/vhost/net.c and when mergeable buffers have been enabled, the
> driver checks whether the combined entries are big enough to store an
> incoming packet. If not, the driver re-enables notifications with
> available entries still in the ring. The incorrect return value from
> vhost_get_avail_idx propagates through vhost_enable_notify and causes
> the host to livelock if the guest is not making progress, as vhost will
> immediately disable notifications and retry using the available entries.
>
> The obvious fix is to make vhost_get_avail_idx do what the comment
> says it does and report whether new entries have been added.
>
> Reported-by: ShuangYu <shuangyu@yunyoo.cc>
> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


