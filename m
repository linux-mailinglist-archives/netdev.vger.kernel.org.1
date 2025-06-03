Return-Path: <netdev+bounces-194690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B920ACBED3
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF48A18904DC
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21917A2EB;
	Tue,  3 Jun 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8u4YpM4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC479EA
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920832; cv=none; b=g2SjiGaSYPyGYnlJF0OJ2v38787MvIbN6JY0aYoImXWbRzJVWvhIQ6PuYw7wmZ2G16lK4v9BPIirmq2VEZlO48x5ppo+AjsQlUat41LlDhhyjn9G5GqPDEoamVs9UAOt42fGdD1aK4RI5m59D8r6Q/DlgG1e1OL93gsOwmESk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920832; c=relaxed/simple;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+F97jHlG6QrOkMs+xtsfsWoddWWAhS2Kzeumao/0yicvkLA+Jo7rQlo9rZno/TjreNRS4k4DQjWklI490DuTrrUvTBDiwOreMkl0uJ2/fhzsmfNIJm/Ve2tdrJm0KBJcG1/lwt7zads6skVu/U8UakFV47KpalewPaakGaw854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8u4YpM4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748920825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	b=F8u4YpM4c8cviBr8P7r4QYZALbiCvCTMgsTZm8WUwcieOoTGTrVxjn2leBKDyw7yTbGLNt
	GS3PUcDwMqVhO7IzKO7s3QbedKk2gvqqSTz2uo2T0i23yJoLD/G1PJ588qmGui3rfyvciV
	CEfHYFI+x0CfCGMhY01/4F3P0dAexwc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-NvARtoT5MYyJZKytD9UwnA-1; Mon, 02 Jun 2025 23:20:20 -0400
X-MC-Unique: NvARtoT5MYyJZKytD9UwnA-1
X-Mimecast-MFC-AGG-ID: NvARtoT5MYyJZKytD9UwnA_1748920819
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso4905541a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 20:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920819; x=1749525619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
        b=Pe4BwIqv17qME6S45RA68TKEng6oBvRovvafHQDhZXXTsTHpgmAfiz1eMFGDcEKcXI
         +HhmsgbCBUx6c9Qh04sCQ5MwLZZsN3Dmne3A68XY3xgpER0yhIa4SKimeWBf5SD0Peo5
         NNagKa6a58ij8DuM7t0C6+PP4pFAJ/uYt1SkUrYY1ZPH0YqWNsWtNIL34sD73lGtv9Ge
         rKxqXlWPJajmoeZBIMM9bIDduqVWyVSIhVySZQpg+9hoyP7Z/F1vpkMODYgKCnsWlGrs
         AjGycvG9s8JyP4ar2x64XQSWizFhzABdHoA00yPR6wQ8Qq2cAN8UOSZ9HLwwHMbFHrAi
         DX7A==
X-Forwarded-Encrypted: i=1; AJvYcCU9MFuLy3XTZq/9WT9w00thYAl8/UEGzeuO3gPYkf0dw6oy3JE0szC1VLTYhWGTcXXCJi5x6yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbUREfEu19GEPAXjaPCzaUBU0Bwk5UPbEQaBRBUGaVLK7SGaq
	RLJuB65rsqeD3J204P5XEuaD0xcH9bCwvPTzc7QUEkGTZnxDvPgtuc/FHFl4n2vQNmPte1HsWCr
	vaWILHA2gvgHrED2gZdyk+rCgy5a5ThkGz8K11Qdz+AZTMYANEtgyl4qSsBVrvEaTAq8bb5qoSn
	Hi2U6mj/AnWutv7PQcZ9ajzhaNQSjR5xcQ
X-Gm-Gg: ASbGncsSp6r1NYjNwzEibusvfoRo7qacpstpfufltf1CULLNXjToeC7Lpex5CaimGGH
	AKFPXpUKIfRfNfvLavi+GYr0eeMScVpSVKc5MT7u5YT38HG6O7xCeuRt/pfrL59EXgUJlFcZfgv
	l2/hdj
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id 98e67ed59e1d1-3124150cd29mr24182665a91.13.1748920819224;
        Mon, 02 Jun 2025 20:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMKoDoVhANJXhkEH8PMyc1LxUezj6sEzlWUU8w4Uyd+7t0SdHYB02l6iAUnHMY64ChUWPuoGBpUpLK5iNRSqc=
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-3124150cd29mr24182639a91.13.1748920818809; Mon, 02 Jun 2025
 20:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-2-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-2-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:20:06 +0800
X-Gm-Features: AX0GCFvi3ezIBQa7yKxnmidSOgr8eNk-oM266seJU5yCRwglxX_y22dfD-57w2A
Message-ID: <CACGkMEuwb+EcT=W5OwbZ=HOf=d56cZFKF5aYPx0iCLOZ630qNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 02/10] net: flow_dissector: Export flow_keys_dissector_symmetric
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> flow_keys_dissector_symmetric is useful to derive a symmetric hash
> and to know its source such as IPv4, IPv6, TCP, and UDP.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


