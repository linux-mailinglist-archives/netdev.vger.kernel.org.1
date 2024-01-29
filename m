Return-Path: <netdev+bounces-66560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2283FC72
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 04:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A09C28301C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F4F9DF;
	Mon, 29 Jan 2024 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLfkWjFe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269FE1078F
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497299; cv=none; b=Ox/sTBslZsBQiwKQ8tXROgyFB3KIjtm3ffRBV6eYXU7EtZHTg10jU0bCukgBi3vN3ylQgQsxNBkh+THRI6F9wDNKQitrty473rEMqHPbateIeGRnEwCBXqfazUE5M1CQJu+TF0rfpi1RXuP8p9gAzplpe8thMMeZdMmIURNuCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497299; c=relaxed/simple;
	bh=Q1j+KR/FHxsj92SR8cJe4NVvdgceho6xI2qepjHH75w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/TQhWYggpQy1KvTpr3tuSQIM2sQh1qR09roJeWXInJWlzZtx3b5GsYNOpY+MrhvW5lzmQBZV5SK5R7fpq9evPBeqJ9AP8Xg60aAnqTFj5UCEsKmK4zwujxwBO01nTqfoFbWcfauf1ANSZ/VvsieOsoDzy63c5SYKmrSyZ+jD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLfkWjFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZgzfc4q8wyPtVrbuYJMWOoz4ZtMUHFMRKeo6UesNQA=;
	b=VLfkWjFe4jEzWeuKzH53mqPc4V0mFechDNMApx+5FY86ikTV8Ik/h1Nt21XSCHsg/0m/dQ
	tbXhcKBJK8YUJZFvT/IMrB7loaFda3/SjcUlKmTcB6sVj+mdaB+OekSPhkSo6d77lwOim5
	jJKvtfA0kOcbpjLWUXLklFfwbXThB/4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-TSmRMW13NmWpVT3SRI_iVw-1; Sun, 28 Jan 2024 22:01:35 -0500
X-MC-Unique: TSmRMW13NmWpVT3SRI_iVw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so1531919a12.1
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 19:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497294; x=1707102094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZgzfc4q8wyPtVrbuYJMWOoz4ZtMUHFMRKeo6UesNQA=;
        b=X1vtQyTdISNHWR/pJg8XTsQQJwxxMojq71n5OfGX5fzcQ6NTSXbHeNYd7jxbdIwQO1
         dAF78voh6LTFEcCJM0BOKxetQSj9tTRTUdKCa6tc7aj8l7wHjNZE3s897DcRm7OEekhL
         PWTFVIhQaxyAEQVzN/cCqdWcI1qpqooV1SP4qmzh8KmWgCRCRzw0/feXBwj9ZUiCL6T7
         rxOHos7246b6xGggvckveNu/xGY++vEygryCPJcehZKMiQZ+SJRUs8kfSzXIJML/Th6P
         /5cOJVyJhYxApK2hCaNEYDOL+U0fXa/qLglQ5Hosd9W/ZsdH3ya94gYz5MSc61oWuNeF
         lnGw==
X-Gm-Message-State: AOJu0YzgbDCB35i0KXMNxdkr7O+eS9z0DOifnDxxReSKGFW00ad+mIVE
	l4gO37KbmAG/jD4stt91WPU4vmmD/X1KhhHelhJ/ze6vIhfq7w5s8gqOwG/mh0D+FB0Sw1YwfNr
	D6oSz4M+ddw3R+LjnEKowIsoPnfvMuZPdzalvI1rVrj+mvCqiCoCwgT0LakYtt5+TiyMRU+OYN/
	iAEDXZ/C546DhnEKcdYyPN+9DNmFZN
X-Received: by 2002:a05:6a20:94c5:b0:19c:ae3f:7d66 with SMTP id ht5-20020a056a2094c500b0019cae3f7d66mr336811pzb.22.1706497293993;
        Sun, 28 Jan 2024 19:01:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoxEHMOKR/5pPlKSrxDnjA4Jbr438TXbeFSA5fz8V8JIMvQlrEC41/kgPZWiUu4rkmzPD7EI6y0pVnptQ/S40=
X-Received: by 2002:a05:6a20:94c5:b0:19c:ae3f:7d66 with SMTP id
 ht5-20020a056a2094c500b0019cae3f7d66mr336803pzb.22.1706497293738; Sun, 28 Jan
 2024 19:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126002550.169608-1-stephen@networkplumber.org>
In-Reply-To: <20240126002550.169608-1-stephen@networkplumber.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:01:22 +0800
Message-ID: <CACGkMEvtuiYCQ+_SnjZGFrnSa6DzcZQr=CkKYx9eoQB-uaOV_g@mail.gmail.com>
Subject: Re: [PATCH] net/tun: use reciprocal_scale
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:26=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Use the inline function reciprocal_scale rather than open coding
> the scale optimization.  Also, remove unnecessary initializations.
> Resulting compiled code is unchanged (according to godbolt).
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


