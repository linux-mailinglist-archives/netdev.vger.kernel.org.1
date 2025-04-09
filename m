Return-Path: <netdev+bounces-180751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56513A82555
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E224A0CD8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40037263F4C;
	Wed,  9 Apr 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvUsfUn8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863332638B0
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203077; cv=none; b=qTxQV0IspUceoH6KRJ0Vzr1c/fmpDsRx9/MD415Cki5fYJjPGkoKj2FPo+eEXq2ahtjXLL4RItg3y9DKzPHS0jFlFVDLspzw9kEjocKzhy4lOpT95as7uXuSVntsX+nTnGvDPc7bFLtQiv8lu+4t6CL1d4l6ydFRCvffZ2RKuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203077; c=relaxed/simple;
	bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eKlrLyCNsnKLze9u/mz7sXsjeBq2J+SQfzng0m4qWBob/0D/beIzMetydjSFlTmt0tJ88GS0qElGJBjdWiZHADfnKucMzLpwm64XNkBz8bvB4fT/jhWHQ5qltz/nqG8VahvswaF1xh7eiVRUwgGsOu8zkZQC/PKVGcXxOl/+4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvUsfUn8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edb40f357so39510335e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203073; x=1744807873; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=hvUsfUn8Bj3/9ULXN/CksIhXBEbfftKBhVL+Eit4pF45K8DU9u/N81sy5J/HaPtkat
         zwarfviqBm/fQLp505piazDKkTZApykrYpitq/qXTmNTVE96xp7Do2sGmz17f7D909KD
         pNOMMWMy1jnb2FWrr/pMxjIDeytZdLlvgyjeANzqSTwIXAVSXAZwSTIIU6RCq89E+urQ
         D3tIKJnRu4CBhRNrKLNtxcVmEirt6UnCprEHcaEv8qx9PN34W1dL56d4SYji7y1bdVET
         xoBk8wAtYdO9TIcGN9eWdXgviagnkNWBH1r1a9FMDmHuMyeepmwAxBcj3abAJ+My4zxt
         e45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203073; x=1744807873;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=H63RgZ5seeJqXFKuU1Thxd6K3TInawtAdt1aNIB8DHGmfY9FjzZ1b7VMvKDNWhjk0d
         7r6vDaHp9+9a8QoD2N3qQVNXacHrbIRxnyt2Mgoy/Yx01/QbKBVmLrlOaK7kKE6HTigZ
         WpUTWnxyj0dgtMo/Iam2f1Kdjl8yVeJXNDGsPtxtGUIOR3i6m5UwYc0Sn/f/hLUH7evm
         /AOZWzDpKKCZDxKbtJYx+Ju+TDSxOKMZIvH4ZsLV1ocpJHoxn72yJ7+D6cLD9LfN940J
         nPsHvVy9dlwEnkzePAwauZF2rJpG5394hQFv/s+o1g0mxczyWmiINCqZ/Ym90Ekx9qb6
         CVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsH8xX+auxK3wIx/Qx2Eec4QD+nc/N4NqxveCDjkMBgHfbpZAt8i1zbtMkX8q+zYC+ZBmw0MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdRMTypmACZQW77j9yEyYfm74/uUOAdkJSg6ZHFRUoUlgQyLl
	UcCkOI4ywfNwluzFrzrqOIG5Pdmb6X8Yc4iZAMUGRxDbPWGLOUBDVZafaty+
X-Gm-Gg: ASbGnctAcQu1Qk3rJfbUD0AVBJZdlsuRVjTJynzp4YlPS8Tq1QDS9Wj56p1GRhtquwa
	nZJd+CBjQ+OfesDbipsMOvEwrJa1MdJ2yMzt5FY4gj52ZEtLO50bU427x/8EvsTfcTMn5Afy77h
	4Ki35aXxyyTe70GIY13/i7JlBiZO0qy8UibPYrXhrDW24P7KfJAw7b3nejuXQte9qqeRXG+SicO
	axLx2X0y4Up/3IMiZDeOfGBm8N+/xjukKli8A2yO5I40qw0sPb+amVnQTfstoE7k1G2c/UoAVSW
	iLWKFb0N57haR0FjrL7eV9/TsRyVbVoSPd/itPlJdlduET3Z0yVn/w==
X-Google-Smtp-Source: AGHT+IF1u4xL8NhZPtVv6KCJzk+Dftz94HCjfcvU9K4jdOhNaIQVDtJa2jieJbLL8guImMftqMcorQ==
X-Received: by 2002:a05:600c:3541:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-43f1ec7ccf2mr29005035e9.4.1744203072569;
        Wed, 09 Apr 2025 05:51:12 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338d802sm16256035e9.1.2025.04.09.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:12 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 06/13] netlink: specs: rt-route: add C naming info
In-Reply-To: <20250409000400.492371-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:53 -0700")
Date: Wed, 09 Apr 2025 13:21:46 +0100
Message-ID: <m2jz7t34px.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add properties needed for C codegen to match names with uAPI headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

