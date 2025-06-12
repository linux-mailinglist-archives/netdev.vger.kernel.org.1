Return-Path: <netdev+bounces-196772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048EAD651F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446F17C9AB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8192B9A7;
	Thu, 12 Jun 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RydV1do3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF188847B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691918; cv=none; b=VaqnChGGQaUEHGStRbG1/QTHXcu1SxDKjEL/l5JV2+lbKuaUVRqQGb9UadITBDEII1ewRRy8G68CLHt9B6rGgFVATb8bK4PyB+2U2PjE43elYaVv4flf6KZ4VBBYLE4+BEBpfWTLYL+2jR2MzWEYgABLeReidjCOvr+DOeRB/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691918; c=relaxed/simple;
	bh=uzRPQuadfg+MsUbZWNA25TKvjMOKYbyLX0HK6ZbbBzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyvAAjDgxGtldTw71acMROxs0p3xAvO1XeO7u+euvDzGLAzXn5Ba0VIthMP7ss+L0ZkNFoDFSe7cAaAfQrQO4iublcfUsk/DrNRTfobDbSxLdOHZVjWOszPfLvY6uq5hPQwAqYgFwMi30nPC3Xg/YBi44J0HjJ+Ujaq+4rM3IwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RydV1do3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749691915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzRPQuadfg+MsUbZWNA25TKvjMOKYbyLX0HK6ZbbBzo=;
	b=RydV1do3p1e3Nda7ibWwYLIidOX8fqoKM+e2DbtXC37e/Sh2VndzwDelQgpxOv5MbRQ7xG
	UX2+qUTgooomBskRGIFytxSLbJPFEoh7uPCM7Wd/cz6/mQNieEebP61U1OXdQvbtUySjv5
	9Maqgp/5IE96upo3fEsMG23R7tjyIXc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-OBncaRmhPNuSY-cWN5iAng-1; Wed, 11 Jun 2025 21:31:54 -0400
X-MC-Unique: OBncaRmhPNuSY-cWN5iAng-1
X-Mimecast-MFC-AGG-ID: OBncaRmhPNuSY-cWN5iAng_1749691913
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313b0a63c41so597949a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749691913; x=1750296713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzRPQuadfg+MsUbZWNA25TKvjMOKYbyLX0HK6ZbbBzo=;
        b=oPanc6LYehRVjj0SHJLltiJgYXSaNDVc4WbhIi9uEhA+QTR7kHT+4qUcYbfv+tVP3M
         I9WDAhdBG3QPMI0dedYr2uqKV1eWU+7qKEA9F7RL5e8ZNZ5dOQWnVbbeLz52cY5FERWm
         /oaT98bdlBR6aUEATQ49KsiGdgDBq8PUYyKfPH7OHO7NGFHSXgU0uXfJqKlx9QXO5o91
         lMiZjY04PTNhCrg+dPotizS3VJZQv6/zHbbVvbJTE/W9pF/0LtqDT1rASVKx+E5lcz9F
         b5329WFBDpzpwkdC3AH8G7c644aABaFUOWCcXV7GY+D5/Tux+OFbpv3UsJhtewSogc4i
         DtWw==
X-Gm-Message-State: AOJu0YyWXPgw0tIh1nwVNj1GiUgEze9kmlIHYVDPgOckPQpdJQM9exjB
	eQSYk9W2VNXJTBoLUgGE0MGEiw1r29OJVtDyx462foMJ31BAEvbfULzrok4C/94FtBgMJ8KrkCy
	KFjWBjj5B5CMiGbX5LNiA7X8RmBOXF4dinTLwZPuEuzCCm9TSu4aDdbq2hYsm6i2AXHIwzek/5y
	9Sd11vAiMqR7o1v125C9p2nHpH8XOn5e8j
X-Gm-Gg: ASbGncts3M2Z8uS6juSVUPD6ssm7BiAGUcLa5ANRIdGMv1TyXlGeLFowtn2ABZueyxf
	vIcK5aCC/MxzYqKxBOX01DcNRtWruakp0dZcSQoZy5tIKRzPeGIoTrowfaAzbC9SFf0fQb2lVSy
	r2LPA=
X-Received: by 2002:a17:90a:c107:b0:311:e8cc:4253 with SMTP id 98e67ed59e1d1-313af0fd831mr8258455a91.2.1749691913314;
        Wed, 11 Jun 2025 18:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGShyXqewEnPdW9a4QkLHMGE2Mut1WcTgHpX20adFBHOsFV4eNASE22aKwbnP+MEgzZOnS5Ux+cOMl2/TVrqfs=
X-Received: by 2002:a17:90a:c107:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-313af0fd831mr8258422a91.2.1749691912913; Wed, 11 Jun 2025
 18:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
In-Reply-To: <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 09:31:41 +0800
X-Gm-Features: AX0GCFuI9yVK4EZw6Ojqo6bgWW_zeCycp-AnliYK04g9n8Mv67U2SgTB_Q1s5HM
Message-ID: <CACGkMEshBCkMWFwa8-_FBGVaemzpgZHxpm5_w-YjK0P1pXgAGA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Use the extended feature type for 'acked_features' and implement
> two new ioctls operation allowing the user-space to set/query an
> unbounded amount of features.
>
> The actual number of processed features is limited by VIRTIO_FEATURES_MAX
> and attempts to set features above such limit fail with
> EOPNOTSUPP.
>
> Note that: the legacy ioctls implicitly truncate the negotiated
> features to the lower 64 bits range and the 'acked_backend_features'
> field don't need conversion, as the only negotiated feature there
> is in the low 64 bit range.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


