Return-Path: <netdev+bounces-302153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YjFTCoVjPmpqFAkAu9opvQ
	(envelope-from <netdev+bounces-302153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331E6CC7DE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:33:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=R8o5giQv;
	dkim=pass header.d=redhat.com header.s=google header.b=eVZ4D2He;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302153-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302153-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F91300B473
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2093C81AD;
	Fri, 26 Jun 2026 11:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303283F210A
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:32:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473560; cv=pass; b=dqS2k/HrwV6iBJBVJXaX8VYxA8L/rqPjrqNx8z3trCHVPMJUNuXRlu+c1DuoMRMDAcjcQKKnvAPTkz/OaOPDbpOYNL7IkZGAzwzLxyapwEugdPxoX0UL3veP1G3GiBcbCW5MpWQexpEjpTikL245JdBi/rKyXo1ia+UXFDLtCY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473560; c=relaxed/simple;
	bh=wvBn6e2zZVZyJRVO6FTn9idn63IqtNcAsXkmlHdOuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS0cdn/mty5RZHoCUh5V0QXhRPRp7dnAU52nTYF263YP9DLL4SKXqAODA0buAeoZeSvuzMKNKl2KMjhzzPnfJ6JhmA/suj6QVVizYyoLy+Is046E76TQcCKaikGqgNK6LEW1T37TRR7MACd6sFmIsCNh+kr1inoQPAXcuUs9v0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8o5giQv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVZ4D2He; arc=pass smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
	b=R8o5giQv/Htf3lm5YZtxwFzDqOh6e+heJsTuvl8uSh/4B50909nXO4qEaUitRxCIwOyBQ1
	vUR6AWyBqhjP13I90s7EwLf1DOooyOjKIudpzSVf97Hd7urU4FwPY2SV70QU12ufovv+MJ
	fH9Qzz/KSb0hzfNjM51+CJ2WWZfTuJk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-KrHuNl69Nt-2f_YaIs0Y5Q-1; Fri, 26 Jun 2026 07:32:34 -0400
X-MC-Unique: KrHuNl69Nt-2f_YaIs0Y5Q-1
X-Mimecast-MFC-AGG-ID: KrHuNl69Nt-2f_YaIs0Y5Q_1782473554
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6648196cb82so1201509d50.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 04:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782473554; cv=none;
        d=google.com; s=arc-20260327;
        b=LqPb0PDx24YmP3q4zPdOvPYq/X/s+NOGA9IM59qfrW3vpf23OD0IpjGa/cN1cNgOa5
         X5P1MKriJ/sztTebvw89BKiwNTkqO43L2QCI3EFZnG/ovygBp29UTn1FNosvZCWMwoUV
         pC3cr8wPNmBupkUdUDXdt012nzGq0F8q2RPoyFfsBGuxVpgXAaUs530KIsqLjnuvHFYx
         Bvur02zGfx+NfI3iyxzWwC3WoNSW/CPdKSLZCwI2OEF2fJ+fkhUPMS6i2MMB63b39bJO
         XgzwLjsNf/RLOTXiOL93ApRRncL8ervd8eMgkmXWlkjZ7KgRmeXXSYWMdHcJ9JgWTfuc
         bdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        fh=Dpium897ZvDGREQq9S1BA6Wr0+JDraFVh1z84Imj8IE=;
        b=ozPlsH52TOC6OCspYQN7deWwOrarRKrUKgBbmhwdEgYxzXvCBjzgTBzt3Bgknvccvq
         stLfbIMWZfAK9UDK4DkTiVRFwhJLI2MA0GEBojYNSV4aaPAJi5g1ePAXqhAFOQ4tKEcg
         zFYOTODr91+CzckE18BoQIV8YMsBJOBk3EJ61Kbndlz+99bFgm4qtsxJvsl5O2MIMfff
         OCTZeXtJt9NC9XB+S/J0guvS05wjFIQDmIrBY8siq3mpNcTERudoEqL/1Z7obbKpjB3f
         Mq/CuLk0K+vtUwm+pR9uLcPLRLKqTBgCavQ5zjwheYs8Nkuzcp+Jt/EHOvxUGroqBPm4
         63Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473554; x=1783078354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        b=eVZ4D2HeGGtE1hozOY1Th66jqjaHLABdESFBGK2Wjh9bbJjmPv6ciRjidUSP4pYhnL
         j9dhtlcgzBcqlMS9gJOSvsWLTqQuAQ82P+v25nt8uYkGHke8JcexLMWHf96KmWzT6RWA
         pEbQsr5ZrCQsJ+PLTWNV70aua814VtUIJefeFZhvmf7gubQ7Jc0SWX32D0MCE993jwZ5
         k/G4niaBttIrCLzgqlvGmE7LSNCggCaChxyRCkZ4FGFNaYaDqSy9AkGFXYSW0ZEO2Igm
         hytFbhJlNX1QvAmTDTO08+Mb0atdXZLmOAYYh34PrUmY93npLKWhzTvuGiCMmF3DZu3d
         w3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473554; x=1783078354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        b=HAb4w0oaqGyNnqyozD0Qxj510NIIFAdWXrSoD7KrE04IPIhDS47tfruzetWZr1QdBj
         VZfovIPzWlVghcBABTUqMgDwUwYSwaqsJI4mrHaShNrSOhlPTzCZFh87qnJnFK8qZmle
         l6uPzRDZexkksXOTZG+5D34me1ib/r03u201bQpgOZ+9ISVbE5V+MQsaAywfUpbKIPNQ
         imkg65PC9rVMJ/gGdAq6QDOWqRJbAJ+MmaTw18uaaJzdGeMmFfMKcQKC2ua2gRRwCKQA
         lzoivnGc9TewLbO9IOs5AXsNwaBbhW4jzJ39FhvrG9ATXUy5SvxBhFKsU/K5/YHiI1d9
         Zy3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoOHFuZls2af6MCEGZuCbQA1v5QH6fIz9ob3NynLYS3YgjoSkFRkKTr5/NAMCOQBtG1rSfzfcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBctj4i+FBGDEoSpcpjPnY4o32lAjLsBsiL7Q08iOIHJj2Y4Ss
	HopIdJVAUlUYX5aeOqslbCISLdRcsuSvLEi0M0mnYpSezE9TfCPlsuLYY5VlLrIy/LRHFXjxo/B
	bX/xcwv4xkJ7uzlix1vG51Nmv9ea4GHk2HDIUe06Vfx9gPDUlNVtgBNKjan5BliaXIsIfol/MgA
	xaJhwrhDemBJNuPDXGImN+tfhV3UzTczxm
X-Gm-Gg: AfdE7cnyxOzbWK1t1pHzrfQEI0fpMMDDvQAOkH3XjXjyv+C4W2uYmZu/xV43qZHP6GN
	qvUjiyDEGQ701W2oZHCN84OnFMFOn62tOWZuYBPPZ55GenK1j5yy0FEd5xdFPrskt3SmG0YYkPY
	biZ3wdYON11N45WrmVTrNoUnl6KNWBnAE/HHmiNVia+m+szBFpmiDkXu2bwAZkeCRepzM=
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id 956f58d0204a3-66488344efbmr5117684d50.60.1782473553798;
        Fri, 26 Jun 2026 04:32:33 -0700 (PDT)
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id
 956f58d0204a3-66488344efbmr5117666d50.60.1782473553142; Fri, 26 Jun 2026
 04:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626070438.59149-1-r4o5m6e8o@163.com>
In-Reply-To: <20260626070438.59149-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jun 2026 13:31:55 +0200
X-Gm-Features: AVVi8CdX7YAE0vZmUHYTRxuB_yZ_qwok6xv6BtZ9RLd4G6r_QlmLWG0P771exiQ
Message-ID: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
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
	TAGGED_FROM(0.00)[bounces-302153-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7331E6CC7DE

On Fri, Jun 26, 2026 at 9:05=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Use size_mul() for both the offset and length calculations so the
> arithmetic stays consistent with the surrounding code and remains
> overflow-safe.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
>
> ---
> Changes in v2:
> - Use size_mul() for the offset calculation as well, per review feedback.
>
> Link to v1: https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@=
163.com/
>
> Note:
> Thank you for your review and suggestions.
>
> I tried to add a switch in tools/virtio/vhost_net_test.c.
> The switch is meant to use VHOST_GET_FEATURES_ARRAY and
> VHOST_SET_FEATURES_ARRAY instead of the legacy versions.
>
> However, when I ran `make virtio` in the tools directory,
> the build failed with an error: missing asm/percpu_types.h.
> I fixed that error, but then another error appeared.
>
> Would it be acceptable to postpone the submission of
> this test case until I have sorted out all the build
> errors?
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..4b963dafa233 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1784,7 +1784,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + size_mul(copied, sizeof(u64)),
> +                              size_mul(count - copied, sizeof(u64))))

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>


