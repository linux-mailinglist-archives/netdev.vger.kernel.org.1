Return-Path: <netdev+bounces-247667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558DCFD1C4
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 486ED30028AB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D630DD2C;
	Wed,  7 Jan 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOxoPqit";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtfSkX4z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588912FD1DC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780513; cv=none; b=mW6JUtnbQ5VHOwJuASsyOqUKVZ8W5xN7YxqXbBrMOBUVKFKAjWjLCY9uzPuulVDINbUkXxnqg5CnQHl1xXih7UapxPXvx8HN4WKfsfIALY2Q4dzuj86qC/RjtKJJAF8eUOJhS3ny8G68LNS4yyR715OFJTAWzLf1Yk6Rsaui2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780513; c=relaxed/simple;
	bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKLf+K3K+BkTKNYBNybO7KV9D6ZjbrEJFa0/E5Fe7hVUiLUyWnwISzfWNsgk5onS28YanjiAUu9NvN78oSJt91gu6+3SPVK3O2kquspAOoyOtIi/dxjYTaaUpQi9tPQQsuQxPZ/6TI/RwKg/eNp8d7FSNkNbkKM1hW/kgI/zQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOxoPqit; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtfSkX4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767780511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
	b=XOxoPqitBp8f1uXmCKkCDFkH0nCJ89n50jc/gVsWRph1JvZPj5cdyx3ibFdCkMS7lq+Gl1
	pH+4xP0a6ocTZcKQNeyXRrfQiqs0yJNT9WFhdEeVVeybNpej6eUcTFN+Nf9TWvuHxt7+2F
	MA9Bc69n494/rS7KqfCnIR6TMTtBbVU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-hVzUQ0uEOZ6m47D9rwXsyw-1; Wed, 07 Jan 2026 05:08:30 -0500
X-MC-Unique: hVzUQ0uEOZ6m47D9rwXsyw-1
X-Mimecast-MFC-AGG-ID: hVzUQ0uEOZ6m47D9rwXsyw_1767780509
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b83623fd3bdso250543166b.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767780509; x=1768385309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
        b=RtfSkX4zt39N9lpEGBtvgYkKizty5NAdRrIBXk1HsFCl4whQbRtDclyGyanFtpSnYP
         6M7jpyrDV/8sUa1AqIS8moAxCk9PNv64zLEp0i+cHH4be9Smb042pX5+xA/9e8a9YNdF
         gjru7kMuP0Mjdyk2rgDhiYXn5ctbuW789LSmdlFPDCLvMIx2/C9ptXn2NTYMznorfqTV
         7AZhJT40vuEsPnwQx5X1aBp39QjE5X5wvhTuuP7GAxX6vjGsxKDbp52Nuja2BNbkvDCH
         ICI/EsSdopYjTxFElMGektZK69nOmif/SKFyg7ALwgkMM1zAveRquSO+wRNc7V4+XHAT
         X1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780509; x=1768385309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ygcepvSJNVODWuU6JNbfcjH/SnUb2rs77H2pE47HhE=;
        b=YrRFT0mOzYyLreFCGFifFVbL0iUCVcF0rDNGbUfVx6+R90wEw+BFplqhPJ3Q43TVdn
         u9PO77mi6VMyCSUrTAvvFOr/6ytTtS+GoYZGch8Q76ahJ5tlCmIjnXmOYOcpLuFzM8pz
         +CUcs/Z8cOY5gz3mu2uz7IZGp9qIzsnUAhjilkLCIo20Y2mZdCb0JkCXDyJE8w631+uc
         6DK8WlLHU6OuuNDhuIlRVdscyXczPMxKS+rMkIZTLC6VuSgvyOkwDWGodsYZ9Miclb6A
         SKrwSPygQ8WXMsuTiHjWqQfBOwJ7H8/rqOlyeTg84U3piupYlNPlDnmLA0hYFMhivlxG
         NREw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZsOyDSQmw+PfVNtJKhKKnZXdpQDhCymxjUviNPkIiwm1fCLRkLgJgr6XA5mcMcF4DJ9kLhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJte/+PjyyCAa/PRzlPumbR7U8XQoLebCz62D5/m6+WnQ6Mfu
	hR3cWKwWUY0wWu0rmMXqMYS/QUQWAgg1aTqJMT/20Nb/61NkvmgIgDkLnAzIjO10m9M2bgdCDNE
	5dWEqCYDzM4dWzR84QWE+P0NwUZJwDR4VLR4IEd2r+sdb8WzI+cPscoA2x7xYIygTsJ0hTL4S1x
	cXtnvECLdNwF8qZ8QDnfZd0CB4HtMNw01p
X-Gm-Gg: AY/fxX6QdHNOxE8ZOa15c783nCcitIM68teISkB1AwGG5urhcDkoO2oAWxgthnibCh0
	KOYciFYnm+/xCMXhEmDDECEgssnE33qwgKASdgFK0024M+3oTJEiM+I2/7ZVtXeE7ryjP2R+IRH
	cZeVN+vyDqnKi+nJmlM0R31LVXDXZ4VNuQaEv+UVpRApfL9j9bQOkDGRHYN34QwQIswBo=
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id a640c23a62f3a-b8445357b42mr206537066b.39.1767780508976;
        Wed, 07 Jan 2026 02:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE81GdeuNAEywjYesgsiMhu6sLL7zfN/AhZAkDb8gl/VOQRYao7CB3ma4keuKvaOSyaMMr5oeFFLjUFgp8dpuY=
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id
 a640c23a62f3a-b8445357b42mr206534966b.39.1767780508499; Wed, 07 Jan 2026
 02:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767597114.git.xudu@redhat.com> <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
 <20260106145822.3cd9b317@kernel.org>
In-Reply-To: <20260106145822.3cd9b317@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Wed, 7 Jan 2026 18:08:17 +0800
X-Gm-Features: AQt7F2oOpa5k4FH9OvrOLzMFLUr2Dae6WSsV1U5PxQngfIFZxya3WX6skGieWRg
Message-ID: <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> > For instance, can the new netlink code be replaced by YNL, whether in
> > C or called from a script?
>
> +1 looks like YNL is already used in net/ tests, and it supports
> the operations in question, so that's a much better direction.
> Please let us (YNL maintainers) know if there's anything missing
> or not working, IDK how much use the rtnetlink support in YNL is
> getting.
>

Thank you for the suggestion. I am looking into replacing the netlink
with YNL to reduce code. But after reviewing rt-link.rst, I found that
rt-link currently lacks support for VXLAN. Would more significant changes
 to the patch be acceptable if I switch to Geneve to leverage YNL?

--=20


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


