Return-Path: <netdev+bounces-272362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FCJNxT9xWmOEwUAu9opvQ
	(envelope-from <netdev+bounces-272362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:44:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5894233EE48
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318513013499
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161036CE1C;
	Fri, 27 Mar 2026 03:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7Ws/JCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D02DC344
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583026; cv=pass; b=Y/tYDhX714YVgchZ1sAt8EBO8EWI3w2oIX/wUVuYvySmHxFdboLynJbGSX1TdpaSChO2ChvS/aeZBuNZ7JbEf9q46/3O33e6Xkqpl34FV2j1PqNPKIckloRLkmaGidRY2skSY1gbbCG+8et1jtJV2VEcu+PKpwQf5Q6ghaIc2xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583026; c=relaxed/simple;
	bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoQk2GzLoA5UrlFVjank9G8Kd4SFFxtaGYMrV23KQ2qA+YbXyOOpnOJS+tcOnQSzctthdAk9Yq+JqWtIrcF9/AqmOBEkVwuCJ7y4ARhzEAalYvZ0K43wnTh9L0kJmaB2p2n+mBGq4CTOuBLUaAHK4g3YB9WKsoFnBCM6Q1NjS6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7Ws/JCZ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50904a8f421so16959021cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583024; cv=none;
        d=google.com; s=arc-20240605;
        b=AdOoH80rtFawrxI0Em0hXAgyrb3U/KqI6Cv7HKqYNGZpgqDSEDHt4I4viQrXm34CXC
         yD80HEs/BlzHZuHwIi4DxCSz3JP/Wz33iWb+d2DHWjzWUk3lpzM3itGoyuy+0Fad3hUW
         v2xIANdJVsSBJfTQqzjlDIo6dBUeKLm5OSXk1IX9tdXKZJsB2I1YQoMVlPgDnysxFrDD
         arsVGOw4UovvGP/LTk988DcEdySxoMYcVRVuuGwLJZPYdyPTAv8JDQAm1zO1EFFAmtGu
         F2Y17pX0Fa2TAbV+FLoqVrmYID+dtsKhRHt0ISUn8C6i9xZviPQxV/xF7yApxFhffGh8
         zwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        fh=LOWXRHRV2HmL3q/o1rwBa+k2sQSydnZrl0m4MDGnJmQ=;
        b=fIMj1r0mJNVlvjxH1Lij3DqHXIMsUq+FIsrWK9QxMzlrHLeADAJMtvjsALGaGys67z
         WTV41G4gA4y9/3sOnF8jYxatbLdPYbZRpSl7rEKLmXI6o8tcn9sVe4UC3jyNib8pqvOS
         TquxkbI3R0ysWBf28McAnperIn4OV85ojZuDP1XCImoGMQIu1W1XroqWQib86tG7DhBc
         jjRfGIXhsqQFzIMkl+ymoPl2eJF7BTdnPAskGMEjaWXQXCXhD1wNr30cOdgaIk/u8kz/
         zDzCXzd1biVbVwoiJ/FgHrYPhhhCXLEf9Q9WuoL3JqgSeOR5kdLiYa2hxJ/Zs4tTu1cB
         jzRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583024; x=1775187824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=u7Ws/JCZNimk/pAmatYO3igeRU+sC4Nb/sBDK0vRl6AooNd7ymqtFy5RvKSeP4jHSv
         26mAA0AqrHmzOWvuvi6GU/G/xaTGgRvp2N+6DtttQXSw/JTOG7f6MuK93Yp0bi8osAon
         JyC2HPayj1uNLRxfA07Pbq+xVlrF1tejQ327w6lS55WWdGkJU5jozm7cdawikJ9mtPvn
         F6iZ/X7ob56en+EHu+j9iNmLXIdFCOuJ/T1K4maFljQII5ZYUC7WetRr1LPm8x16bxpE
         Rhb8Fee71nJxyTg+C/O78t/mx6RpPR4F4tpjgtRzIbJH3mox7N+Dj2RNIe9n0OVSwF0Z
         1XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583024; x=1775187824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=LvaWJNiiBwcqhkEZj9QlXP2TuvW++UHzFOWYn5/CGTZkFcqF0T4MaEaNyyXVNiEC5z
         tLZDmm4ZDU6nmgiRewXYU13lNJE0adCugkYuZIp7YtKSO/76LmWnlvhC6363vfXENfzT
         1XqrOq1kiab6dAbqBX+QgLc7t8iwmvxKfgdplQcWDnqdcBhDBe18jdjZRts0vRg2p0Jz
         fy4pQ+BTSqj6Zd9sEeFeTzIHBv6Q3Mh1z5JxYzDgiyc7vKti8Q05zk02EW6c2FCFMJU/
         m9f2aeBFBvzrYFZwqdP54va6Tb2WMW4dfuo3yv6gJy0MmEkjFtVjfIFWxfBxTaXBt4rP
         /fEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdyYb+Ik9urYZJkcZHeYVUYlDDsMZWlxYeUTxTEXri6JGUKM5RnR0zZvx3fVcv8aRogwLNxDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+YKVC3tc4QyS8+ZHRDE6ifW2S3VZc6xBxNzPZdSkHioxJv+F5
	DPjI4njIdHzoVuGMEGtuZXY5m56WstWZKPSUbQycRpdjjOL2T6zUQS08Matf644QoLrfkEgE0/y
	ZuFbZ5EJp88CLbBTqx9Ur2DXAYpPPzsBiDfeQe7wH
X-Gm-Gg: ATEYQzxarMYtILp78+PkB6LTGY1JTom+n7PnIsNuDIVf0He7IoQAofs/gWqVM7eCEwL
	iwrGXwlJBtJOkmyeBHj0RemNXSpQzsmjaRYo1BaAXVt3MxHZVwI2JBpye8KHAhsE7rKxCXZSkwl
	2FkpTjE4AZKSFZW/Cl5f2WSNZBlQuvLPDoKDdmfWOEXrZ2DHHG+hATF1mKoM/qWN7gXTe0uW1w0
	pbccG9LOJtB2bYQDAULAZ/JZA+Xb9kh7i7sMKS0PPz0QSk59it8qA7gpcrkO2/AKyiToXEadhTf
	ws2h7g==
X-Received: by 2002:a05:622a:5a0a:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50ba37d3a17mr14739431cf.15.1774583024002; Thu, 26 Mar 2026
 20:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
 <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
In-Reply-To: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 20:43:33 -0700
X-Gm-Features: AQROBzBTAZQiZv5gITUpNks5cRGZmqvxfVTU9Y6vZlwD1VKoOLXGxZ_EY6bfseI
Message-ID: <CANn89iKJUMP+7udEPs_j2Z5pPJnc8-Gkn==5OLr63OJQs1a5Mg@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,tu-dortmund.de,gmail.com,lunn.ch,davemloft.net,kernel.org,networkplumber.org,nutanix.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5894233EE48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 8:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

