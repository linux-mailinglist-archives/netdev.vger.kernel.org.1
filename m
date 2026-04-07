Return-Path: <netdev+bounces-275925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GFNNkrR1GljxwcAu9opvQ
	(envelope-from <netdev+bounces-275925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:41:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA63AC35E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D468230071C1
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6493A6B96;
	Tue,  7 Apr 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZp7rTEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51803A5E8C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554889; cv=pass; b=ZM47cV+Xr2z+GOBBYaMTJHQr09J+nZWfoHkCoOPZAA+I9Wz+32WHJTe77INDRtt10Ga/yCaYb9GPZG4kTe+Qti0b/R6zUXu8sY+6+tqEa1cx41GdbTYKZm9DD1OTH4bP+skAoQkcaJKK+8ZtgniNubn7YSrQzlu5DBVMYBxGd2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554889; c=relaxed/simple;
	bh=9XKMsadydwDQqCY9F+DkrtsGh8JxW60RIBSvou5/6bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxS6/YtWT7by/X6wCmiO3JuWiH/uZy6TzbzOGDELZ81OTdU06qgDuKKEeTy1/seqyHyA9usmkr3TSr5kUD+uvFn19m0b1W68oPUAwwIo4cPyByD7UTVegfEfQMhhdW8Dlwk4hFBu7goDP72owUSb9XZz1vlF7BCdVdtQp4Yq28c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZp7rTEz; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89fc4147f2eso62712246d6.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775554883; cv=none;
        d=google.com; s=arc-20240605;
        b=F31yaqNo8sRETP23BmcU53cmHt01SrC6C9BBg8BCWvjKMTAK7hwSBja0vmRtKuRKP1
         L/89qLVHO+wlqfObHs3sx4qW0M6ZRQ2u+ArxkAaKVUaBIqlWF5JZN+jfzFuUlJ2wUQbM
         D4fatsjp565cYSZnnlAUlwsp832bcOJ3gYVnGuuljgUGcMLhxVy/VCRnkKo03/UEOm8w
         leqxPiav2R7z2NY/OSHCoDtQQy23fFpralOjR9CQQOJkfQDizlyCU39QGHvSQzfC4pQV
         JoKBh8Cm/vr64MwVGY+kA7+d0KAGG9riMYr+SlA0ZkzaUKw0wd4ARFiPvHO/yxy/XNj6
         1vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XKMsadydwDQqCY9F+DkrtsGh8JxW60RIBSvou5/6bE=;
        fh=NUu01oYJ/8KdePd4eImPO/tX73eiFcB3BBlOUTYYgK0=;
        b=dwB3/49ngylPOURFNA5mhKFYZ0S7SewgIWo8ncSpxe6uaCYowmTB04budSKbOaHsnW
         eEsxc7WQasLzUqpO4uCN1vxHRGtk7EgusPdXd8FXg1ruilk+icTxFBRVepwLtcw+hLWh
         RrOJ7UEeWXPRAkl1vy6f3MWfgtts4cikAEdj1C97VepGtrPL+WQFQj+Ah3cLQTKqDqKz
         YLVWyMR4YZCYFVmJeRTqkioKnrrPeXknL+WVBCO6b+FJI+2herGjl9U5NjYYZe5OkEvY
         syfi0vpTs9AewpFYsy3dRaXvA/fuKiE+LhZSXs8Bz+/JEDy3aXznfX+jc+kWVRXvqfXW
         GSEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775554883; x=1776159683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XKMsadydwDQqCY9F+DkrtsGh8JxW60RIBSvou5/6bE=;
        b=nZp7rTEzIgwApXkyB4DOq1hdYaHOXy2CgZTki3CI/gAiVpeDlBXGkivctNvJ7KUkJJ
         nvNVtLHrvwpZua9JrMUOLgOv3DR+J+8YKe5VE9JUVJBwGQKkNRt9UhNgbql8buaYu9Sa
         dLk2Vec0G09UmG2fZqQ5oQAKWe9ZApIbtb14ZnX1sY1HMNTqk0LPVioNMdkzCOblWRIp
         +q6v8V7cpgqSa8l5ocB3tqBdxD9ByLfknmy0dE4hqETsQJDiHrkV+Mvli53vU5KrpQ0E
         taWTiWAQ01rHlPeiREiJ85MwR0+XnUihGjNZS8qel/Vya+3NJ6pmk5Eq8sr273f1xZEG
         9gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775554883; x=1776159683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XKMsadydwDQqCY9F+DkrtsGh8JxW60RIBSvou5/6bE=;
        b=KMPW3gFiMUF4idQdnP3c1ZtPy8KeOqnzeGZVIFEAx6a2NOH48SjSnyIU5lKSXcyEz0
         IKO4gpTIk8fixIYFSRdT86MXS2jtimRp6zuZ5TBaGwjyvyByiwzKYEc7y/aNbpXMkL3o
         ovfGtu8a3O5ygO4fxVP4dqi7JFsosNOVHAPWsxLeHXPsrThmOnbBJZlW0xvHTwWJEC+1
         /ds5E+SU9vCT5elHF9W+PtyGKNZ7h4K2I0QNAcoc4eunaoWv0QnZEWH4TdElEnYejU5Y
         gukGW4XW69MzkMim4pe/gvfrjVHsLo7HcOF+IhqirGBjOby0Ws6T76jw//OxNqlZECNI
         Q8zw==
X-Gm-Message-State: AOJu0Yz5iSoIz4YJZyiwSa7zVDCmbRLi+MJOhmto6sZLAan056+SAwHm
	MPU7HvL9931qaVVk3ed1Jvmlydud08sUw2dWG9sP30lgW5M6SgDCVECWi5Qpgs0jtPEz9tFUexp
	Hzwlx3Ya3THvfHksV1szhWs0KKJT8qlsdNLHd7Tqx
X-Gm-Gg: AeBDietlEvr/PiRGQziIhui1pDsjiJPxJhDYiNu8etedki4uVLJx5B6RMcQIEiZYEoP
	bxeuotjl2EDBOc58XEUWVvGQK4nQFJULAZflop6P7ey1zP6XMIzzeTJlTbQcqBh7V16mEa5VOUh
	FwUo0yiFAHX8607EEpT7wRFw6CIxvCpgg3frEKbYAcZF40TVMCR2iulFbekCnDPwmsdVDN76gni
	ID3deNlo0t+KsvE/z/Rbd/qQhV/khEy10ysmCexRsq83yGTlhEV/wU+YCLCoMs7PHJzjM1HHup3
	pMNH
X-Received: by 2002:ad4:5e8f:0:b0:89c:4985:83e3 with SMTP id
 6a1803df08f44-8a704fa67a2mr262987336d6.49.1775554883096; Tue, 07 Apr 2026
 02:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407084219.95718-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260407084219.95718-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 02:41:11 -0700
X-Gm-Features: AQROBzDxjTgngBp4Xw_lPhwbg1f-uM-3EApa_YW3WL5jzC4EuSzAvXYNieQbksQ
Message-ID: <CANn89iLEPOh8p-KythbL1FOPW4SU4U8qhSb7A_CVvjoVUZtn=g@mail.gmail.com>
Subject: Re: [PATCH net] net: initialize sk_rx_queue_mapping in sk_clone()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Soheil Hassas Yeganeh <soheil@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275925-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 73CA63AC35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 1:43=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> sk_clone() initializes sk_tx_queue_mapping via sk_tx_queue_clear()
> but does not initialize sk_rx_queue_mapping. Since this field is in
> the sk_dontcopy region, it is neither copied from the parent socket
> by sock_copy() nor zeroed by sk_prot_alloc() (called without
> __GFP_ZERO from sk_clone).
>
> Commit 03cfda4fa6ea ("tcp: fix another uninit-value
> (sk_rx_queue_mapping)") attempted to fix this by introducing
> sk_mark_napi_id_set() with force_set=3Dtrue in tcp_child_process().
> However, sk_mark_napi_id_set() -> sk_rx_queue_set() only writes
> when skb_rx_queue_recorded(skb) is true. If the 3-way handshake
> ACK arrives through a device that does not record rx_queue (e.g.
> loopback or veth), sk_rx_queue_mapping remains uninitialized.
>
> When a subsequent data packet arrives with a recorded rx_queue,
> sk_mark_napi_id() -> sk_rx_queue_update() reads the uninitialized
> field for comparison (force_set=3Dfalse path), triggering KMSAN.
>
> This was reproduced by establishing a TCP connection over loopback
> (which does not call skb_record_rx_queue), then attaching a BPF TC
> program on lo ingress to set skb->queue_mapping on data packets:

Ok, it's a somewhat convoluted way, and no real harm but KMSAN :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

