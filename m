Return-Path: <netdev+bounces-292406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GIoDzEjF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B695E81A2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6CB7301B152
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B643F20E7;
	Wed, 27 May 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW8IM/Nj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tx3XlRy/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFE3D6CD5
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901229; cv=pass; b=Gz7j1PtIHE1G9XV0KuChTgRZqckpKxcr5Jd84WOddeUdq9kAtiWrr+4voHan7ubYl0A8yfnuKSjmgKaniED+YdrCiC46eUrO6KQlumX2rntRL5Ij0fogwYXSO3e2NbxjSIpAQzXOwf+XQQZ8HSzviqoAwE2EezxfTjeG9ccHMn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901229; c=relaxed/simple;
	bh=lubCvrF1puiThpi5h2smuHn4grMXYsYs7CCcT4LYEWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyaLbPGMSH0VkgnfrhzZznrm5YX6VmN5QDO2+NAUVRYw72/FgHXB8VutWQPswUw3uAJn/NqM6sko3Q5wIleZOo91QbqndwcHC4gzqtwGVjjzlxIZ99C/Ig5BZUtudOt5sHD5oc9IqcHsSGB4aehZWWSCe5TsGkf808oBnfDtqC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW8IM/Nj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tx3XlRy/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779901227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lubCvrF1puiThpi5h2smuHn4grMXYsYs7CCcT4LYEWg=;
	b=AW8IM/NjES3lHJlAcKe1/t+JoDGQ1Y7UVXjttusRNU64J54jOUNuFmT7O27Su8PjXDaQKM
	jJgMPjPJI5q0U2DCVQh2qnXQi3Ff8NIA3pGghMG+LEdpRqObCVCM0mXdaFZEI9vbCHE3Gx
	Vw1V1Agp88dSLNZmTRNw62v8XUEBEj4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-vRYy2PHQNk2BiGWB0y0paQ-1; Wed, 27 May 2026 13:00:25 -0400
X-MC-Unique: vRYy2PHQNk2BiGWB0y0paQ-1
X-Mimecast-MFC-AGG-ID: vRYy2PHQNk2BiGWB0y0paQ_1779901224
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82ac893940so5817048a12.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779901224; cv=none;
        d=google.com; s=arc-20240605;
        b=huePN4ae6fhorS8fBhu8mxtCWuk60Uc82KuQ5yxpdPPHzfqCoBhXYSEWMnE9t+dpnB
         Ur34vm+F12dDlNKHv5/L4Lrv7v7wHEIURBZhBlJY2CxA0dMwY+mX9HOfcz6htQlBYjNK
         JBRVrsWym6RkJrF24nU3ZI7RbhSgaM51HaNy3soX0HXJOAo+HwlM3LDjwk89FeLOiRqv
         +yr8Ft6txbe8FJRGdztCIAnfnWYSWTtu60bHT9NAhGXthw7I7BcfffVC2HEIcpxm8JmZ
         7UfiZCqujDHuN8uDfWuoaw26q8nc0Q1yH8atlw5EzqtgSh5T79IYVMsOGap2CnX+d7SS
         Exng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lubCvrF1puiThpi5h2smuHn4grMXYsYs7CCcT4LYEWg=;
        fh=wizQPkMG6FE0/8a/KqcgYc9l3d9YSZh/fqEwIeLJmyk=;
        b=EtjoZRkXoFGPdYtL1OcLwgBZGC9KyhR+BKTdWvuah7o6CFNamb6u8Jiz03Ay11xZVZ
         iNJvhs15n9IK7RnC4skH5yB6heon5llpCdR70uhzTHEt4Ee/iLlpWuWsSSOUlJ7a+SkY
         h2aQGqcElXMUKSPQUZEPpFbzNjinsz3mE8Mk+jaB1T2kC1u5bUjZwkw/LAl8tIYR72gO
         a3oD14OSlybrCItFuBlil0ehj8jjq6XT5FWWYR9+gCOQ3CF1pao0nMvOAxxg7+f8CioG
         U9gbBBuvcQGpH7jG1BXNkFnShGs6APBvpXdfkeyWcwvQ7lOxMQiQdKbKkxTYA29Q7N1H
         Elbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779901224; x=1780506024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lubCvrF1puiThpi5h2smuHn4grMXYsYs7CCcT4LYEWg=;
        b=tx3XlRy//mpJf80Xf4QL4TxbDy6g/gtoR9banOY/bbyJiOPJxxjLw8yaY/S66gBa3/
         ixCtYnGPNJj831lROZkCN8rTme5j39qc7g9f8x6nWubtqtJ4y6XUOpj7QNhcX6WYWfn/
         z3GNHI+o14aUTGQIOOJIOmaJdEZmB7GniYznpFV3ZRY9OmaJXnhr5vw0wObY3wfqTfll
         JnCdT6/BWvmd5vdskXNtJA40w0fDz/DrnlT50D6a+hFO+xkMQXKKX1wbN1rBW5iV2Lg+
         55S2GhR1z+FUZeKbCnvU2ZcYIqA5+1ujVXy5At193Hl32oeBzHEkU6d8LMQD2PcuIrXF
         57Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901224; x=1780506024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lubCvrF1puiThpi5h2smuHn4grMXYsYs7CCcT4LYEWg=;
        b=qQf8n77lAYFySkHaUY3x5mc5seTthWa4ernsPOIruXX4ApvVkL3PYRhVbbBiAOtRC1
         7aXKn3CYuYYMrsl1Gm9CNftRrmBd21fah85MWgMwdCYCSarnD1tawuTCFWQe1LqfG4ow
         nnm3bmY7loH3AAKAR7hoteJOzbZEnuhLva7t0F1Ldq5z1ICX7KSNvNyXzn2Fqdk6xo8R
         kAO8/iLe8BDseXm4ZYKATX3Cte5xrGFZIKvSwB73f8B6PWUVrSfepDjvcWGrvMsFH1hZ
         ixPxqXQ2HWMiCIlysf7vrrvPs7XAV3H/w/4ZdBD78GDC4OV0BQKjMH8SawijCb/f7Mi6
         qQGg==
X-Gm-Message-State: AOJu0YxwU5mNbQjN0m3AW9a92o5mvpx+kWsb5acuDCjNkmqzt4ZFR7OK
	S2f18p8GStnzJY4nOIwdYH4Wj0FLcuZHymiHwr7xFoakhQ9F+jRpkHhD2PRUMyFtcu+Z8jduuLD
	VBMqCG78rOVfLm75tfirre2LcbUMYEbAh3X3+x9iiVUqyVpQIqnb0FBxGxZV2LSXmRSK7BliGSf
	6ifWwOc1i1OWr7uYFFuHs3tKNumNDXVuWMvOss+xLC
X-Gm-Gg: Acq92OGoHv6Kbj5AocTrnZkhIlEcBBID8DniFMRHIegvtJimudNyM8j6mR1EyijXi0a
	/KR8djhXbnepjgIzmBAxUloybt/SVRKaCsdK9PZsCERC0quox/snFg5h+1nqbZ1zYb/Mn5eCsHP
	L6FsjgPXllyR5JS1w3Z83ug3P6dmWzKlaMnt2Nx+APeFxzUAQSQA2xn4NihGqppHFQ+F0E9l7eA
	Fef61URTHraZlc=
X-Received: by 2002:a05:6a20:ce44:b0:3a3:56db:919c with SMTP id adf61e73a8af0-3b328c988c7mr21976235637.14.1779901223743;
        Wed, 27 May 2026 10:00:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:ce44:b0:3a3:56db:919c with SMTP id
 adf61e73a8af0-3b328c988c7mr21976160637.14.1779901223120; Wed, 27 May 2026
 10:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527164843.125054-1-sgarzare@redhat.com> <ahchEKOnRwGJBL2V@sgarzare-redhat>
 <20260527125631-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260527125631-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 27 May 2026 19:00:11 +0200
X-Gm-Features: AVHnY4KtP7u7V_LXADNL0jTnyc1d-DJIC7mxGp_c5gBauU4SsMmfK4ENAnH0PHs
Message-ID: <CAGxU2F4Jc5Ug+QPoKY4rY89TOfVFRkLF75kiAhxCqUnq0OwAHg@mail.gmail.com>
Subject: Re: [PATCH net] Revert "vsock/virtio: fix skb overhead overflow on
 32-bit builds"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292406-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B8B695E81A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 at 18:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, May 27, 2026 at 06:54:21PM +0200, Stefano Garzarella wrote:
> > On Wed, May 27, 2026 at 06:48:43PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> > > overflow on 32-bit builds"). The fix was semantically correct (although
> > > it would have been better to use mul_u32_u32(), as David pointed out),
> > > but in practice we are estimating the memory used to allocate the SKBs,
> > > and this will never cause a 32-bit variable to overflow on a 32-bit
> > > system, since the memory would have run out long before that. On 64-bit,
> > > SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> > > already in 64-bit arithmetic without the cast.
> > >
> > > Let's revert this to avoid unnecessary 64-bit multiplies on the
> > > per-packet receive path on 32-bit systems.
> > >
> > > Reported-by: David Laight <david.laight.linux@gmail.com>
> > > Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> > > Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > aaarg, something wrong on my new setup, CC list was missing several people
> > and mailing lists, including LKML. Please let me know if I should resend
> > this.
> >
> > Sorry for the noise,
> > Stefano
>
>
> yea just do it. Put PATCH resend in the subj.

Should I carry your Acked-by ?
(maybe better no, otherwise should be a v2)

Thanks,
Stefano


