Return-Path: <netdev+bounces-141001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646799B90A0
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DCDB219AC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42815820C;
	Fri,  1 Nov 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjD4sEwV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B715CD42
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461898; cv=none; b=E0gzW6ZxlecQ2hTHU1Et6jTdv151wSDae4cKAwr8gmvZV7TPDOkLuZvRSjOirFF70L0oqTGYRvPffCe+ytCmKxNIJ8fIXugv5S5DhPoImIqbv6lZQHPuqS6AdDu5AQ/+t2i0qmH1+w5Zl64pJzshhYl/D9ssvIIG2XYJZiP8Gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461898; c=relaxed/simple;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b7DslVy5VPBlW8morhGEB9PG1v4iYQQx+UBQjxg9nQ8G3F7OPINu38sLIO+THIyX4rrcNmhiXGhbWZUj2pY+cT5vJnNoq8xnCVY1QaGFbZeix+fPE6GCpo/OoMunJhS+imfO3/xYB2EFkTwNW9R/JbVZF9A79YJpqI1/70kNk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjD4sEwV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	b=CjD4sEwVPnIDD/Fc2XaHhqLr7dSKURPrI3RsD2a8Vjsm9Sw3G16Qk+8fT/Tx8xFmRqYcHS
	NFHQW6Qu4JgF22u/wHqPPFlXttdpceF1/O3s5qDFIZaya4Dgb/TqN7d6woMETkJU/JBBQ0
	IGYtoBZXzzxXkE/L9KnGL51uZvOpzrU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-GgHRB9qwNSmxOu-hUhY66w-1; Fri, 01 Nov 2024 07:51:33 -0400
X-MC-Unique: GgHRB9qwNSmxOu-hUhY66w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so941827f8f.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 04:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461892; x=1731066692;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
        b=cqCm6hd7Q/RvTDl2tlQv0hxoTImX/vCHL9mbIqrcT2mu6A+LzRYgI+FI221mjIy0Mn
         7dmNnruX6zWA1NMQOffs987Gd4PuSLHkhCEl2m1URGDpWa15UR7BG9D4gzpbqkTcm0wE
         OmmPO630vrsQh7I4xjqBg7gj41LwJOca09n1ZCYKb+lo+5/pPeuH1FI1Z4x+WXx2S64P
         rHvGvh+NIQsy8PHB3MdgJfGFzOLt2GxEIsI3XYHhvI2/FRum1uJLExnGgWaFcnJHrKrY
         kyWGy/+lIeZSRG4p38zw+Sf8unrFtX0v78Kd8+sWGzsGOrsgq3+6n68MJh7DUYaFs3mE
         DQUA==
X-Forwarded-Encrypted: i=1; AJvYcCXXccasa3E/8WV/qa/oRcKC5Z1r7Ya8Rvdu+OJxs+wADCNocfeMUdvkv3/pqRxAviT4v/7lBxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnP400ICBnmh48+BBAXPXkYMOmJpJykueSgqFSnFIg/8kq0tVb
	s763PEnHVkYMRTGItm9iGlZHonbPLkcihpZO/7KPJ46CtlDtXhUFYTCZSPELKS1GfABfNeIcLPZ
	X7c4e9f9mtF/L/NYVi+P6Rmlr95aIx6T1S6Jssdd7slXwOyHRVFANhw==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409652f8f.4.1730461892455;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS/eOEyEN3rqadpyq16ef47A5nw2zggvZfNjgqN1OyQ1xs15a45QCa7mgQruSh8w34R8VLyg==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409639f8f.4.1730461892097;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd8asm4861201f8f.73.2024.11.01.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:51:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9329C164B950; Fri, 01 Nov 2024 12:51:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/18] xdp: allow attaching already
 registered memory model to xdp_rxq_info
In-Reply-To: <20241030165201.442301-7-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-7-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:51:30 +0100
Message-ID: <87r07v9np9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> One may need to register memory model separately from xdp_rxq_info. One
> simple example may be XDP test run code, but in general, it might be
> useful when memory model registering is managed by one layer and then
> XDP RxQ info by a different one.
> Allow such scenarios by adding a simple helper which "attaches" an
> already registered memory model to the desired xdp_rxq_info. As this
> is mostly needed for Page Pool, add a special function to do that for
> a &page_pool pointer.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


