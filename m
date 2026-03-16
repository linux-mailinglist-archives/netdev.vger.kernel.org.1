Return-Path: <netdev+bounces-268275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH1RHoFuuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:56:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CA2A0736
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D3C3079F96
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF835B126;
	Mon, 16 Mar 2026 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgPC9AuB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jiOH3TSQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D2853FD
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694521; cv=none; b=Gvd4rHxP97ySmrLKVs8eawtpmGnVt4lg5o9Lgl4Ue1jYNInobhRPgqRlfIp0InEXKlQ+tzVenPe8SGC7v2FRER7mQDLO9dhobjzNcd7gNiCKGdVKChcEFzs3Iw7RSKEG83ZWu1ldm9UhZmEEdtoN/o+csfcPq1j0a8K5n9EdMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694521; c=relaxed/simple;
	bh=/HGNrFoLEufWK5e5qzVP4QZuYO8XOFUldCK6WsKjvk4=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=h3hrEQJo9ad7+qugyPNcr/rDnMjpabfYQwHwTHc1aQ+lMqLUBGDJGbu1UYKmuWdQbLBaP04aoA1wwBWabTLB3I1C12bx6TCxN2QK3nk4dSOuuKE0fSHMFRtwHt87+njwH4QwO9wb1tuC06Pq3c7LN3QDx+cOQMamngh0ez88zsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgPC9AuB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jiOH3TSQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773694518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBXD1FJN/Ut/oszBqEDHIHt1BiwBmk2SZ97hBu1U4RI=;
	b=YgPC9AuB+atsBBE9O5gLwMMTIWXji1Glof01f0BeRnc3Gh6UonHaU5lJwS5AeXDoSF5w0e
	m1l1ZTUVwRY8q5hjZHS7YaKGtYFrwqUuVv+h7BSDTm953mV/5o6drQfhVM3OuOZR8jhh9q
	nFKV2ZlkbupRv8mCvLlKpQDHl7nv5Ao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-oUKpU1JKPLCY6_RoUVvp-Q-1; Mon, 16 Mar 2026 16:55:17 -0400
X-MC-Unique: oUKpU1JKPLCY6_RoUVvp-Q-1
X-Mimecast-MFC-AGG-ID: oUKpU1JKPLCY6_RoUVvp-Q_1773694516
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e8ae62so41395545e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773694516; x=1774299316; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBXD1FJN/Ut/oszBqEDHIHt1BiwBmk2SZ97hBu1U4RI=;
        b=jiOH3TSQIf+GKflhpx3yICB41tNybGOXzSKlqyCN2qaZEGWjwndT5LiYfzowxo/For
         SA1rKP6HE2iKFYGMT2QMBtRBaC0+m/uggGHiRZeItJf6lTqJOrfWTm1p7ondoAONP4do
         +2A1pjSClhj9+ibb/tbe4MnhEqBxH6o7nJQg2b3EOcUcLZ8R/gX3d/mUnOk2c0AWwWU5
         hufPEQR0iwmGUUuf8qTflXo8EwEedVwuFPV3XWhCUf50g4XAur+QqZTdUDaPUJEBb+Ey
         aYO04Woc1zWCM7azio1gAsGykXVGLM7tRWPTcylM8n9+tTMuxWTAkfm3YUJol3ipx4XJ
         LYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694516; x=1774299316;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBXD1FJN/Ut/oszBqEDHIHt1BiwBmk2SZ97hBu1U4RI=;
        b=AVdTAv8fTqzY6sLGx0Elaljch9oY3x1He3uKrFfkpBppd1PdwDo143GQP/7p7hSz/n
         3fNjgb6MvUwtgR0MyVPc93OQBtQPT55gQmMokh1i9WdgcIxPdOVUsRo/szGtCF5iq7CN
         vkXFtml/cTuMhLHGJuUsg/inGMFc7o+qrhepJ6SoNZcFDuWXgGOTUIAWyGp93bmYwZLo
         Eiv4nLIfL3/C/nwndv5P3VQIvitoehfxMQrcrxU0A80EKAbU8M/c6tJsBFoVNJAWinIN
         u3c9IJMz3hv8cNzNZs9XdIobaOT0ot95nufznekMVYK/iT3wPs02NQeHsnRRbIYyM4UR
         qZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCWfAvgc/r3UHotdOmL142RKN7dmDCI5UrWKSiC5bQPpOrllFGX6vTWt7dZmMdSBasgv03ssEmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZ7CReQRrznNUEXc+e2xafO5lrJHLaxYxpHL3AlNhI/z2peKr
	2O36ZZIrfS/f2O3HyTgYUhXZwRQTyKfXp7UjlHQoVTbcJJcvEyVAjmI8l2zGeo8990Eok+LYhwh
	baHjeyUqzYtzVOGhHzut+3quwL3ba5bqyP8MyKwqttCsAgm4pmQw/D9eGWQ==
X-Gm-Gg: ATEYQzxCnvoeyoi1sPBrU2Qv+zAz/xUEhueUI1nbsvmQOomplkvkPsZtL4TXvr4u/Pd
	PAILsc92QxTABi7FOedTjH/SjOlIT9fPTovMEi7Wd3voq/p3B/Mr828eiGr8t8w+QMCWHNzVPqE
	AlK7C4VFEfRkZvVvQy6T2+Ybwa5lvCR0cjrhrhVNcqaanJQAZX1dbn7ZdtmQ/bXd4jIxHNqYL6V
	W4GMU3A500WQqIHNhCMG7C/fcP1scmOwz8sHSJmjVyo0iiBW2NcKN+hGZ5jCEU9olZYtRyv7AfH
	yeEyt3D1T60hQ5UhOPdBPuatCdEVSc8C2Zkzl/NG4rdqCG01HUiOI0CpeD4g2kdupa7lgzMhOk6
	60F65DTpSul2nsBMF1gS9xHk7zeGXh15rZHbwUhaUT0v1Yjse6w==
X-Received: by 2002:a05:600c:1388:b0:485:2fd9:3d4a with SMTP id 5b1f17b1804b1-4855670283cmr239646625e9.22.1773694515964;
        Mon, 16 Mar 2026 13:55:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1388:b0:485:2fd9:3d4a with SMTP id 5b1f17b1804b1-4855670283cmr239646345e9.22.1773694515550;
        Mon, 16 Mar 2026 13:55:15 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eabb6edsm13142265e9.15.2026.03.16.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:55:15 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <imaximet@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 3/5] selftests: net: rename pmtu.sh to
 pmtu-test.sh
Message-ID: <20260316215513.3f77af19@elisabeth>
In-Reply-To: <dd1f8981-b8ad-4a4d-b6c8-3333fb05c93b@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
	<20260311201057.049950d1@kernel.org>
	<dd1f8981-b8ad-4a4d-b6c8-3333fb05c93b@virtuozzo.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Mar 2026 21:55:14 +0100 (CET)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268275-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pmtu.sh:url,virtuozzo.com:email]
X-Rspamd-Queue-Id: ED6CA2A0736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 20:25:31 +0100
Aleksei Oladko <aleksey.oladko@virtuozzo.com> wrote:

> In v2 
> (https://lore.kernel.org/linux-kselftest/f7t1pj9v8h7.fsf@redhat.com/T/#m80f10ade0ba8963ac6b09b8aba07163cb3e4cf59), 
> I was asked to rename the main script for tracking purposes. Should I 
> proceed with this setup?

Ah, sorry, I missed Jakub's comment as it came just before Aaron Cc'ed
me (that's the Message-ID above).

I didn't consider that when I suggested to keep the current pmtu.sh as
pmtu.sh instead (this seems to be missing from your quote). Never mind
then!

-- 
Stefano


