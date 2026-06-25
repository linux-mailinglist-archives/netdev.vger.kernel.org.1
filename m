Return-Path: <netdev+bounces-301965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0g6hGeExPWouywgAu9opvQ
	(envelope-from <netdev+bounces-301965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F243E6C63FF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:49:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TEg25zpA;
	dkim=pass header.d=redhat.com header.s=google header.b=NoLjEyTd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301965-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A29303A934
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB89345CAA;
	Thu, 25 Jun 2026 13:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F62FFDCC
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:49:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395344; cv=pass; b=qix3t//Q3HuQzLTV6laX/+8bBW775SyLlpXHT1oILwL3p7mo0IagNn7jeylLf+FmZ6iDGYz3uuvfG8AiszHFxW8cExWXy/XPLBnpnld0j1sRiGylVpuLGdeDdXdgKZ3rtJjRc16OWjhJkjwzE2cmkHjS0kdB/Ev7LCl93CfxNjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395344; c=relaxed/simple;
	bh=FyKAtny/z3K2aOAcLJ07FAa4Lo0Z1QSMYiY1kmIuw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFst8d2SsFmyGNRMYtaH1dsBOxSLorvKKqm3Mb2S8a0w9gFNfXo7coeBHjg5bSkkhJAbspEJq7w0JaWMwqqy2CRebccT4hqRy49+0E2RMSeY8VS7nALzmpkQHZHg+u4Kc46X6I0td5qXIoPZcnRzEOZ7RpA3qShsaFxsf0tLRe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEg25zpA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoLjEyTd; arc=pass smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
	b=TEg25zpAIlyqfAcSnY6IGCBMeeR4P72s31lpVcNlp2iwAtQAtC6ZsZECcRjOsUmxHbLpbK
	sUPkHY7UaOR1riRGM2E1+jFQSVP4tjYMEkjgQKJ1egnpcu0rPgeugp+55aWb6FAMicNfoK
	a/wdzDcz3c3qpW57eyIFe2gps17KTKU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-COQAD4v2PbaVdhsvUw0bjQ-1; Thu, 25 Jun 2026 09:48:59 -0400
X-MC-Unique: COQAD4v2PbaVdhsvUw0bjQ-1
X-Mimecast-MFC-AGG-ID: COQAD4v2PbaVdhsvUw0bjQ_1782395338
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aea4d1b3deso169199e87.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782395338; cv=none;
        d=google.com; s=arc-20260327;
        b=VovW3ahTBl9eMtZnxUVejDUzrgdfcu9mfY+bArPCEwDYL4ext9Sn2fEbuiGWjpGuK3
         SbLChSyizyjAPDQJniJlLK+dGWSNVvBi2OYMqqbqj0DB4J2Q85g6fXVTjtWB8+jL5oTI
         /w5wU9Q5pAXN9UACDq3mZ0FExOjrbh2EsZvqbbT5GaYkr7B0u7IACPWlpCn/9RxEOkFU
         17qDLmMMeby8hFw8zhVCsnhhmVOEmpCbq0Rw0gDH8QfHJRzm5ZY2mOexsv/UGDUSUYHg
         6irx5xLtiCAmcMVlT/FjYugTRkq8uTU1Rr3ew36qw3FkVCljDfAA38F6kiBu5kpT5+me
         ypgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        fh=R2mDboSi3A/BMzh7QtzyMoApoSfi6dDdSunEXP63H/k=;
        b=RxCaVXDc3bEhb78SvV5eNC1z0acMETXm8+R9m2uZOl+ahTJ8/p6UF/A6MSNGuKv1Hj
         of5jIDQ8cfIazy6VOBvF6IgHuPE7nNuUZmBh56o2JbOH3oa/XhY3j9vlAH+yM8bkylfA
         Xuu1kWDr1AYOAU4uohKpNBw6pT5LUM7RBhFGtQ2YNwAN4HIS/kVOnOhD9HJ+IHdrq36T
         jYFp3Z35YHbOCzlT0dTK2GiYX324EVBrz8vwH7FSGVkIt22Z7AvdGJ+jHmgDv05/XJJZ
         aZ58Tgx9zkZwdXUHMlpe+Z1c+37gmJBZK7KZW3UTL8xd3mQEyEmBE97injNVBEfokRjn
         Gw9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782395338; x=1783000138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        b=NoLjEyTdNIvkbGlQv1osN6qdpKu1oCfQFAFTfUV05wIt7puWn+57MO5UZy1jTR8Y6Y
         d+M7t5a7w/CmBD2k++aIY4C861NbfuqkRZEYjrkbNLeJud1JXvNo5fbJmiBmLlERSWjM
         a9OzX/ibXbumN7aEMw/O0NgNJL6eaD0SqiqYPtBKMAxNhCPy1GAxGNtWevn0ZRcNSTP/
         oq6PIj3k2z2tp5gKssF7J8VynU09a0DrqxRF+lRYMIiG5xTPdz/p2EOtYlStT2LtgDcO
         wm2DV9mHd4gs8UCmFJrL1s3deNkF0nbFjv7NkXPJft7VMUKW3jlU0AX+JlIiKa5NJEQV
         weaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395338; x=1783000138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        b=WxtfbAwhdlLsE0K61tPYxTBb49EQz4yxSkr9UKaV4vE70ROE5ESTyD1CfrVExJRBNa
         LKbEsC1P5GR4TjYRiaktwnYWbpylafBecTtH5ZVYj68MQ/5tT6QoukxJ0yeNDtDUW3l+
         aQETsGXxby7C8EcdIG9EqCMpsBk/rxo5BcND8g+1CSS3BHALEqzp9gb+l+62adDbwnX2
         ShL0ariP1JxvijpK1LndKa4HQHVjgl3IzeLdONA8/WBO6UUzvkd8BBaBwifetRs9N2Qy
         lWAv/jv3zAF1AYOc7SPFTu7YOGwnstHLXDYWREQ4n2T3Z/KS88CcjQs5QDQm/D88jbX0
         rltw==
X-Forwarded-Encrypted: i=1; AHgh+RpaVb5Se1qGQW2EbPsBxM8VQ5mzpk1bLdG2vkCVGbjmdU6QYYXiDLEdFy5izKuIhTCGmYNv8P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJT+xyvdOpGNIdClepeZNfshpRWLwyN3eqrIv6AdW1xDrafG5R
	x/3Zob2+T9nyn0ZP4iCJK0tG8Uc5sxTAzKxY71ccS4I8X1ThRQ9zu0sv5cURZR2FriptudklV2f
	50I9MXwgdH7R2kdqkAv72q1BzsMGA6Me+IfaOzx7g+rKrYWg4XX3qFjQ7bJxEau7rMirxifSIkA
	qexP0SNbT7FLWcTX/pP6Nr5gffPPVkyZxzy9nK/Kog1ho=
X-Gm-Gg: AfdE7cnvJpnUw1Y9oXZxyo9uHjL/28f/+y4uV0YhUajrrNfcdsC+QksRdOF0iW7cbb1
	dNR9LqVKmE5eQjpCqed6GBgzAfswczGEkUSVj0TJHwlxqzFxgRZCxXmtZeTqww8x6qutCXPzCAZ
	P/TREWnM9bR+SRBl+W0yglD6RjlFQZFfOrG8745V0fdoby60vu87Ofg3DZKQGZJnWRm7I=
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id 2adb3069b0e04-5aea1f648edmr586214e87.40.1782395338209;
        Thu, 25 Jun 2026 06:48:58 -0700 (PDT)
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id
 2adb3069b0e04-5aea1f648edmr586207e87.40.1782395337730; Thu, 25 Jun 2026
 06:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:48:18 +0200
X-Gm-Features: AVVi8CfV4sl2uVjBO80B06iwl-K1gPbYL0GUC3qWAw99NMlfQNPKKN6RpIXYBRI
Message-ID: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301965-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:r4o5m6e8o@163.com,m:mst@redhat.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangyufeng@kylinos.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,rom.wang:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F243E6C63FF

On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote=
:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index db341c922673..70c578acf840 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + copied * sizeof(u64),
> +                              size_mul(count - copied, sizeof(u64))))

The fix looks good to me, but why not use size_mul() macro for copied
* sizeof(u64) multiplication?

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>
>


