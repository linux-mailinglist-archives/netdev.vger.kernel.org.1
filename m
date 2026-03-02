Return-Path: <netdev+bounces-262692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH/6EPuopWmpDgAAu9opvQ
	(envelope-from <netdev+bounces-262692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:12:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA681DB911
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03BF0302FB28
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7828940B6ED;
	Mon,  2 Mar 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PblpajQg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiKaHq+2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165533BA23F
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464340; cv=none; b=VOAkqnV07ut8wpkJerXyHEVjDFGJ4RohJA17L6exlQtgDD3QjvgM/DcP8PMQ2vtJevKE1XFMzzJ6Y+AvMrnb6T2WeCQYNkDg+URFWO5HXzcMLsvg5UnnemMOO4AlxtMkrrpqx+zN5TP+oqbmbNEIGe3CWqno3K2IjH/nRE/a+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464340; c=relaxed/simple;
	bh=op0liavrrZXpHIYFE8b5murCMpJBWBYITF7jRogwVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDTmViJaGtRGNkfsSZ2xxCisMno+K3YqdqJlM0ukXdqDXOWscAmMCEBcB50ivDHKxA8GVFcgA5VSGIOA4lXLYnetMVsrSIShu3LBxDeQB2y8PqqbRUo4lPcUbtK48Am/nxHicL8c6cXLJRPb1ce8cYcjco3CJK5YC3vSUydLEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PblpajQg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiKaHq+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772464338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RF0n2SJ1RvllNep2fFvHq0JPMVeIU4OKpnJDj8ItlsE=;
	b=PblpajQgsZ/jY4gZ0pl6X+2keNeiW7LebN6X4vdrjMFx91WBrJNYXK1Lq0aB2yB7gY634E
	BZpVcldh7vpyvyvbX0Xh9fuKhbmrB4f0wLkWEkRKPMiyC5IENt2GeWGQeh2lWz+XsmDt05
	qNLuOg+7xwW+M3Sk+axVmka+N5NugKQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-5hDDJb-VPze6HnbyyJzTfw-1; Mon, 02 Mar 2026 10:12:16 -0500
X-MC-Unique: 5hDDJb-VPze6HnbyyJzTfw-1
X-Mimecast-MFC-AGG-ID: 5hDDJb-VPze6HnbyyJzTfw_1772464336
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so45697465e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772464335; x=1773069135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RF0n2SJ1RvllNep2fFvHq0JPMVeIU4OKpnJDj8ItlsE=;
        b=FiKaHq+2tyH8zoTrCU34EKgaF6VI4eGrN7Cpbgpl+PK5i9Xi1gzBpVkXVTuX0/q+a0
         GrU8h9k5AzbcY92nNVQACuup3wznw+f/TOJ1Dc5QUwJMgS/3gUHhyvOFMOw+SKm/jmAa
         7vwIfA2H4OV8wzoSeCRzOKTBwyFtVgHf+qkV3silkj5mu1YfM4P+q/evcNISgDe5MiMV
         lmm3qELJZMuLhM74D257VLkImoXcgGS/tVtoQm++PHkshiu8gSx8VvdOBrU3UvvtxzpZ
         nIzYn0LoiPHZR9xsY1hAI0CCwwM8DHzHmYdaWSQzVcBdWNrlRJVWcxQtELEQHGcZahdd
         /9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464335; x=1773069135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF0n2SJ1RvllNep2fFvHq0JPMVeIU4OKpnJDj8ItlsE=;
        b=sSaYFF28TnlnDlOTEMONydr61iIw8QmheyTXYMUE9k/XQMyqapS09vJRk627rmMsYp
         VhSrUiGjreY1jcyJeix5hMYn+yh+6u77XLw/npFaoFE5suFxLAlYg+418TM9BOqzQk8o
         ArY1UabLmdCPAB87ddk73JCbnIGDLJDq9oOsK4ym1ezYsUPFp+/PnYxqt602ORy3Ph5+
         cM5Bvh3VQrYuVkXpsn2TOTEDLYQPuV5+elR5ggqmKd6YF+OTwLvFAczW6chFr40SUgnv
         WUmjYglMnQSOCdWiwryaSzE8Yik9xZM0pfszmNEENYlbcBcSh3UqUPXzbHYi6h+a8lbh
         75ug==
X-Forwarded-Encrypted: i=1; AJvYcCU/tXBGQchVdBh67HIlaumYyWFacclJVur5wZB+3Tn5BztR3UscqV52ntfgK3ku0ZGopUZbh1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdk2R8hrY7R/TXixeUnM19P7+8LXB9C2OG8uA13phRXuQBK/+D
	6HIDfkiFKoGG0ohngUZNHL9LlAO0hkzqnJmnYMP4lU6H+h6LPOiBzaJl3US1xuVD9fELmaGm4uN
	MWrDF8cB8TqDN2qZE51bttCQv/fsABPosBWG5kc1YvKw8TTJY/l9ym9q0E6zGsN0VeQ==
X-Gm-Gg: ATEYQzwDOeO5DyeI+blGmP+yJvahiAlSQgirxh7cglS/Xx3cvUAHOh8mRXvx1/apUwr
	NwVnMIFhhtnP+Glc4rjDkatC5o0Dv/QvJTdmfuoR5CoRp0P1uEXdKHvD5qIoDwe58gtrV2RISFq
	3rIf0NG84u3Sm2wqJk6zivIApeRmYxm6C+ykQUrxG4VlOpkUu/SfBnbjAMaHOyVfa+/YaGHiuV3
	9JomLowdQfs/+Nltw8EZXiwgrV7EnKZjWamae14a2w1S3KcfI8HEAqfRdefq/cioiOZvth6N+P5
	HsJyghBqEnUifggh85k5JYWvtSrruFdsPsShHopXSEK+umCLOgFZ/DumogCPcU/2P4DlbziCKZB
	KT6EioNoq8yNwFQ07aqWmWBoDMD59UxuzhdsswN30Ud0r1A==
X-Received: by 2002:a05:600c:8106:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483c9bb6559mr206067785e9.4.1772464335149;
        Mon, 02 Mar 2026 07:12:15 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483c9bb6559mr206067215e9.4.1772464334575;
        Mon, 02 Mar 2026 07:12:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd765604sm360962425e9.15.2026.03.02.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:12:13 -0800 (PST)
Date: Mon, 2 Mar 2026 10:12:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <20260302101125-mutt-send-email-mst@kernel.org>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
 <aaWTjPXDqhMZlwLr@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaWTjPXDqhMZlwLr@sgarzare-redhat>
X-Rspamd-Queue-Id: DCA681DB911
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262692-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,yunyoo.cc:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:30:53PM +0100, Stefano Garzarella wrote:
> On Mon, Mar 02, 2026 at 03:51:49AM -0500, Michael S. Tsirkin wrote:
> > vhost_get_avail_idx is supposed to report whether it has updated
> > vq->avail_idx. Instead, it returns whether all entries have been
> > consumed, which is usually the same. But not always - in
> > drivers/vhost/net.c and when mergeable buffers have been enabled, the
> > driver checks whether the combined entries are big enough to store an
> > incoming packet. If not, the driver re-enables notifications with
> > available entries still in the ring. The incorrect return value from
> > vhost_get_avail_idx propagates through vhost_enable_notify and causes
> > the host to livelock if the guest is not making progress, as vhost will
> > immediately disable notifications and retry using the available entries.
> 
> Here I'd add something like this just to make it clear the full picture,
> because I spent quite some time to understand how it was related to the
> Fixes tag (which I agree is the right one to use).
> 
>   This goes back to commit d3bb267bbdcb ("vhost: cache avail index in
>   vhost_enable_notify()") which changed vhost_enable_notify() to compare
>   the freshly read avail index against vq->last_avail_idx instead of the
>   previously cached vq->avail_idx. Commit 7ad472397667 ("vhost: move
>   smp_rmb() into vhost_get_avail_idx()") then carried over the same
>   comparison when refactoring vhost_enable_notify() to call the unified
>   vhost_get_avail_idx().

Indeed.

> > 
> > The obvious fix is to make vhost_get_avail_idx do what the comment
> > says it does and report whether new entries have been added.
> > 
> > Reported-by: ShuangYu <shuangyu@yunyoo.cc>
> > Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Lightly tested, posting early to simplify testing for the reporter.
> 
> Tested with vhost-vsock and I didn't see any issue.
> 
> Thanks!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> > 
> > drivers/vhost/vhost.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2f2c45d20883..db329a6f6145 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> > static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> > {
> > 	__virtio16 idx;
> > +	u16 avail_idx;
> > 	int r;
> > 
> > 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> > 	}
> > 
> > 	/* Check it isn't doing very strange thing with available indexes */
> > -	vq->avail_idx = vhost16_to_cpu(vq, idx);
> > -	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> > 		vq_err(vq, "Invalid available index change from %u to %u",
> > -		       vq->last_avail_idx, vq->avail_idx);
> > +		       vq->last_avail_idx, avail_idx);
> > 		return -EINVAL;
> > 	}
> > 
> > 	/* We're done if there is nothing new */
> > -	if (vq->avail_idx == vq->last_avail_idx)
> > +	if (avail_idx == vq->avail_idx)
> > 		return 0;
> > 
> > +	vq->avail_idx = avail_idx;
> > +
> > 	/*
> > 	 * We updated vq->avail_idx so we need a memory barrier between
> > 	 * the index read above and the caller reading avail ring entries.
> > -- 
> > MST
> > 


